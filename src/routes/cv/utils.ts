export function truncate_authors(
  author_str: string,
  target_name: string,
  max_authors: number = 3,
  wrap_target_auth: string = `<strong>{}</strong>`,
): string {
  // show at most max_authors, including the target author, replacing the rest with ellipsis
  const authors = author_str.split(`, `)
  const target_idx = authors.indexOf(target_name)
  if (target_idx === -1) {
    throw `target_name=${target_name} not found in ${author_str}`
  }

  if (authors.length <= max_authors) return author_str

  // pick first, target, last authors and drop duplicates
  let truncated_authors = [
    ...new Set([authors.at(0), authors[target_idx], authors.at(-1)]),
  ] as string[]

  // wrap_target_auth
  truncated_authors = truncated_authors.map((auth) =>
    auth === target_name ? wrap_target_auth.replace(`{}`, auth) : auth,
  )

  // Fill remaining spots
  let idx = 1 // Start from the second author
  while (truncated_authors.length < max_authors && idx < authors.length - 1) {
    if (!truncated_authors.includes(authors[idx])) {
      truncated_authors.splice(idx, 0, authors[idx])
    }
    idx++
  }
  truncated_authors = truncated_authors.slice(0, max_authors)

  // Add ellipsis
  let truncated_str = truncated_authors[0]
  for (let idx = 1; idx < truncated_authors.length; idx++) {
    if (
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
