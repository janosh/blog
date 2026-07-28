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
    const citation_count = Math.trunc(Number(groups.count))
    if (citation_count > citations) {
      citations = citation_count
      citation_database = groups.database
    }
  }

  return { citations, citation_database }
}
