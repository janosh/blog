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
