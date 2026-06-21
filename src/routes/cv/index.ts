export function truncate_authors(
  author_str: string,
  target_name: string,
  max_authors: number = 3,
): string {
  // show at most max_authors, including the target author, replacing the rest with ellipsis
  const authors = author_str.split(`, `)
  const target_idx = authors.indexOf(target_name)
  if (target_idx === -1) {
    throw new Error(`target_name=${target_name} not found in ${author_str}`)
  }

  if (authors.length <= max_authors) return author_str

  // track original positions (not names) so duplicate author names don't collapse
  // into one slot or confuse gap detection. Always keep first, target and last.
  const keep_indices = new Set([0, target_idx, authors.length - 1])

  // fill remaining spots with the earliest authors
  let pad_idx = 1
  while (keep_indices.size < max_authors && pad_idx < authors.length - 1) {
    keep_indices.add(pad_idx)
    pad_idx++
  }

  // join kept authors, inserting an ellipsis wherever we skipped over some
  const sorted_indices = [...keep_indices].toSorted((idx_1, idx_2) => idx_1 - idx_2)
  return sorted_indices
    .map((curr_idx, idx) => {
      const has_gap = idx > 0 && curr_idx - sorted_indices[idx - 1] > 1
      return has_gap ? `..., ${authors[curr_idx]}` : authors[curr_idx]
    })
    .join(`, `)
}

export function extract_citations(note: string | undefined): {
  citations: number
  citation_database: string
} {
  if (note === undefined || note.length === 0) {
    return { citations: 0, citation_database: `` }
  }

  let [citations, citation_database] = [0, ``]
  for (const { groups } of note.matchAll(
    /Citations: (?<count>\d+) \((?<database>[^)]+)\)/g,
  )) {
    if (groups === undefined) continue
    const citation_count = parseInt(groups.count, 10)
    if (citation_count > citations) {
      citations = citation_count
      citation_database = groups.database
    }
  }

  return { citations, citation_database }
}

function format_print_filename(): string {
  const date = new Date()
  const year = date.getFullYear()
  const month = String(date.getMonth() + 1).padStart(2, `0`)
  const day = String(date.getDate()).padStart(2, `0`)
  return `janosh-cv-${year}-${month}-${day}`
}

export function print_cv({ single_page = false }: { single_page?: boolean } = {}): void {
  const original_title = document.title
  const print_title = format_print_filename()
  let style: HTMLStyleElement | null = null

  const cleanup = () => {
    document.title = original_title
    style?.remove()
  }

  document.title = print_title
  globalThis.addEventListener(`afterprint`, cleanup, { once: true })

  if (!single_page) {
    globalThis.print()
    return
  }

  const main = document.querySelector(`main`)
  if (!(main instanceof HTMLElement)) {
    cleanup()
    return
  }

  const main_css = `width: 210mm !important; max-width: none !important; margin: 0 !important; padding: 2em !important; box-sizing: border-box !important; box-shadow: none !important;`
  const visible_css = `height: auto !important; max-height: none !important; overflow: visible !important;`

  style = document.createElement(`style`)
  document.head.append(style)

  void main.offsetHeight // Force layout before measuring
  const height_mm = Math.ceil((main.getBoundingClientRect().height * 25.4) / 96)

  style.textContent = `
    @media print {
      @page { size: 210mm ${height_mm}mm; margin: 0; }
      main { ${main_css} }
      html, body, main { ${visible_css} }
    }
  `

  globalThis.print()
}
