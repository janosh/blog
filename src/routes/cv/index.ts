export function truncate_authors(
  author_str: string,
  target_name: string,
  max_authors: number = 3,
): string {
  // show at most max_authors, including the target author, replacing the rest with ellipsis
  const authors = author_str.split(`, `)
  const target_idx = authors.indexOf(target_name)
  if (target_idx === -1) {
    throw `target_name=${target_name} not found in ${author_str}`
  }

  if (authors.length <= max_authors) return author_str

  // pick first, target, last authors and drop duplicates
  const truncated_authors = [
    ...new Set([authors.at(0), authors[target_idx], authors.at(-1)]),
  ] as string[]

  // Fill remaining spots
  let pad_idx = 1 // Start from the second author
  while (
    truncated_authors.length < max_authors &&
    pad_idx < authors.length - 1
  ) {
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

export function extract_citations(
  note: string | undefined,
): { citations: number; citation_database: string } {
  if (!note) return { citations: 0, citation_database: `` }

  const citation_matches = note.match(/Citations: (\d+) \(([^)]+)\)/g)
  if (!citation_matches) return { citations: 0, citation_database: `` }

  const citations = citation_matches
    .map((match) => {
      const [, count, database] = match.match(/Citations: (\d+) \(([^)]+)\)/) || []
      return { count: parseInt(count || `0`, 10), database: database || `` }
    })
    .reduce((max, current) => current.count > max.count ? current : max)

  return { citations: citations.count, citation_database: citations.database }
}

export function export_single_page_pdf(): void {
  const main_element = document.querySelector(`main`)
  if (!main_element) return

  // Apply print-like styles for measurement
  const measure_style = document.createElement(`style`)
  measure_style.textContent =
    `@media screen { main { width: calc(210mm - 0.2in) !important; max-width: calc(210mm - 0.2in) !important; margin: 0 !important; padding: 2em !important; font-size: 10pt !important; line-height: 1.2 !important; } main p { font-size: 10pt !important; margin: 0 0 6pt 0 !important; } main h2 { font-size: 12pt !important; margin: 12pt 0 6pt 0 !important; } main h4, main small { font-size: 10pt !important; margin: 6pt 0 3pt 0 !important; } }`
  document.head.appendChild(measure_style)

  void main_element.offsetHeight // Force layout
  const height_mm = ((main_element.scrollHeight * 25.4) / 96 * 1.8) + 50
  measure_style.remove()

  // Create single-page PDF
  const print_style = document.createElement(`style`)
  print_style.id = `single-page-pdf`
  print_style.textContent = `@media print { @page { size: 210mm ${
    height_mm.toFixed(1)
  }mm; margin: 0.1in; } *, main, section, section.body, section.body *, ul.oss, ul.oss *, ul.skills, ul.skills *, ul.hobbies, ul.hobbies *, ul.horizontal, ul.horizontal *, .side-by-side, .side-by-side * { page-break-before: auto !important; page-break-after: auto !important; page-break-inside: auto !important; break-before: auto !important; break-after: auto !important; break-inside: auto !important; } html, body, main { height: auto !important; max-height: none !important; overflow: visible !important; } }`
  document.head.appendChild(print_style)

  globalThis.print()
  setTimeout(() => document.getElementById(`single-page-pdf`)?.remove(), 1000)
}
