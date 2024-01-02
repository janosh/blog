export function truncate_authors(
  author_str: string,
  target_name: string,
  max_authors: number = 3,
): string {
  // show at most max_authors, including the target author, replacing the rest with ellipsis
  const authors = author_str.split(`, `)
  const target_idx = authors.indexOf(target_name)

  if (authors.length <= max_authors) return author_str

  let truncated_authors = [
    authors[0],
    authors[target_idx],
    authors[authors.length - 1],
  ]

  // Remove duplicates
  truncated_authors = [...new Set(truncated_authors)]

  // Fill remaining spots
  let i = 1 // Start from the second author
  while (truncated_authors.length < max_authors && i < authors.length - 1) {
    if (!truncated_authors.includes(authors[i])) {
      truncated_authors.splice(i, 0, authors[i])
    }
    i++
  }
  truncated_authors = truncated_authors.slice(0, max_authors)

  // Add ellipsis
  let truncated_str = truncated_authors[0]
  for (let j = 1; j < truncated_authors.length; j++) {
    if (
      authors.indexOf(truncated_authors[j]) -
        authors.indexOf(truncated_authors[j - 1]) >
      1
    ) {
      truncated_str += `, ...`
    }
    truncated_str += `, ${truncated_authors[j]}`
  }

  return truncated_str
}
