import { format_print_filename, print_page } from 'svelte-widgets/print'
import type { Publication } from '#lib/types.js'

const month_year = new Intl.DateTimeFormat(`en-GB`, {
  month: `short`,
  year: `numeric`,
  timeZone: `UTC`,
})

export const format_publication_date = ({ year, month }: Publication[`issued`]) =>
  month === undefined
    ? String(year)
    : month_year.format(new Date(Date.UTC(year, month - 1)))

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
