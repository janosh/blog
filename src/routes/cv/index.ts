import { format_print_filename, print_page } from 'svelte-widgets/print'
import type { PaperSortKey, Publication, SortOrder } from '$lib/types'
import { date_num } from '$lib'

export function sort_papers<
  Paper extends Pick<
    Publication,
    `title` | `first_author` | `is_first_author` | `issued` | `citations`
  >,
>(papers: readonly Paper[], sort_by: PaperSortKey, sort_order: SortOrder): Paper[] {
  const direction = sort_order === `asc` ? 1 : -1
  return papers.toSorted((first, second) => {
    if (sort_by === `title`) return first.title.localeCompare(second.title) * direction
    if (sort_by === `date`)
      return (date_num(first.issued) - date_num(second.issued)) * direction
    if (sort_by === `citations`) return (first.citations - second.citations) * direction
    if (sort_by === `author`)
      return first.first_author.localeCompare(second.first_author) * direction
    return (Number(first.is_first_author) - Number(second.is_first_author)) * direction
  })
}

let reset_page_size: (() => void) | undefined

// The CV owns its page sizing; the shared print helper only manages the PDF filename.
export function print_cv(node: HTMLElement, single_page = false): void {
  reset_page_size?.()
  const options = { filename: format_print_filename(`janosh-cv`) }
  if (!single_page) return print_page(options)

  const style = document.createElement(`style`)
  let watchdog: ReturnType<typeof setTimeout> | undefined
  const cleanup = () => {
    clearTimeout(watchdog)
    globalThis.removeEventListener(`afterprint`, cleanup)
    style.remove()
    reset_page_size = undefined
  }
  reset_page_size = cleanup
  try {
    style.textContent = `
  [data-cv] { width: 210mm !important; max-width: none !important; margin: 0 !important; padding: 2em !important; box-sizing: border-box !important; box-shadow: none !important }
  [data-cv] .sort-controls { display: none !important }
  html, body, [data-cv] { height: auto !important; max-height: none !important; overflow: visible !important }`
    document.head.append(style)
    // Measure the print width and padding, then restrict those same rules to printing.
    const height_mm = Math.ceil((node.getBoundingClientRect().height * 25.4) / 96)
    style.textContent += `\n@page { size: 210mm ${height_mm}mm; margin: 0 }`
    style.media = `print`
    // Match print_page's cleanup when an embedded browser never dispatches afterprint.
    watchdog = setTimeout(cleanup, 60_000)
    globalThis.addEventListener(`afterprint`, cleanup, { once: true })
    print_page(options)
  } catch (error) {
    cleanup()
    throw error
  }
}
