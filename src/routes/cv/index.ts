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

  // pick first, target, last authors and drop duplicates
  const truncated_authors = [
    ...new Set([authors.at(0), authors[target_idx], authors.at(-1)]),
  ].filter((auth): auth is string => auth !== undefined)

  // Fill remaining spots
  let pad_idx = 1 // Start from the second author
  while (truncated_authors.length < max_authors && pad_idx < authors.length - 1) {
    if (!truncated_authors.includes(authors[pad_idx])) {
      truncated_authors.splice(pad_idx, 0, authors[pad_idx])
    }
    pad_idx++
  }

  // Add ellipsis
  let truncated_str = truncated_authors[0]
  for (let idx = 1; idx < truncated_authors.length; idx++) {
    if (
      // Add ellipsis if truncated authors are not consecutive in the original list
      authors.indexOf(truncated_authors[idx]) -
        authors.indexOf(truncated_authors[idx - 1]) >
      1
    ) {
      truncated_str += `, ...`
    }
    truncated_str += `, ${truncated_authors[idx]}`
  }

  return truncated_str
}

export function extract_citations(note: string | undefined): {
  citations: number
  citation_database: string
} {
  if (note === undefined || note.length === 0) {
    return { citations: 0, citation_database: `` }
  }

  let [citations, citation_database] = [0, ``]
  for (const [, raw_count, raw_database] of note.matchAll(
    /Citations: (\d+) \(([^)]+)\)/g,
  )) {
    const citation_count = parseInt(raw_count, 10)
    if (citation_count > citations) {
      citations = citation_count
      citation_database = raw_database
    }
  }

  return { citations, citation_database }
}

export function print_cv({ single_page = false }: { single_page?: boolean } = {}): void {
  if (!single_page) {
    globalThis.print()
    return
  }
  const main = document.querySelector(`main`)
  if (!(main instanceof HTMLElement)) return

  const root_class = `single-page-pdf`
  const style = document.createElement(`style`)
  const main_css = `width: 210mm !important; max-width: none !important; margin: 0 !important; padding: 2em !important; box-sizing: border-box !important; box-shadow: none !important;`
  const visible_css = `height: auto !important; max-height: none !important; overflow: visible !important;`
  style.textContent = `
    html.${root_class} main { ${main_css} }
    html.${root_class}, html.${root_class} body, html.${root_class} main { ${visible_css} }
  `
  document.head.append(style)
  document.documentElement.classList.add(root_class)

  void main.offsetHeight // Force layout before measuring
  const height_mm = Math.ceil((main.getBoundingClientRect().height * 25.4) / 96)

  style.textContent = `
    html.${root_class} main { ${main_css} }
    html.${root_class}, html.${root_class} body, html.${root_class} main { ${visible_css} }
    @media print {
      @page { size: 210mm ${height_mm}mm; margin: 0; }
      main { ${main_css} }
      html, body, main { ${visible_css} }
    }
  `

  const cleanup = () => {
    document.documentElement.classList.remove(root_class)
    style.remove()
  }
  globalThis.addEventListener(`afterprint`, cleanup, { once: true })

  globalThis.print()
}
