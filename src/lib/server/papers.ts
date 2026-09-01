import { date_num } from '$lib'
import papers from '$lib/papers.yaml'
import type { Publication, Reference } from '$lib/types'

// Prepare the CV's fixed three-author display once, before sending it to the browser.
export function prepare_publication(reference: Reference): Publication {
  const {
    id,
    title,
    author,
    issued: [issued],
    DOI,
    URL,
    note,
  } = reference
  const first_author = author[0]
  if (!first_author || author.some(({ given, family }) => !given || !family))
    throw new Error(`Invalid authors for ${id}: ${JSON.stringify(author)}`)
  if (!issued || !Number.isFinite(date_num(issued)))
    throw new Error(`Invalid publication date for ${id}: ${JSON.stringify(issued)}`)
  const my_idx = author.findIndex(
    ({ given, family }) => given === `Janosh` && family === `Riebesell`,
  )
  if (my_idx === -1) throw new Error(`Janosh Riebesell missing from publication ${id}`)
  const last_idx = author.length - 1
  const indices =
    author.length <= 3
      ? author.map((_, idx) => idx)
      : [0, my_idx > 0 && my_idx < last_idx ? my_idx : 1, last_idx]
  const authors: Publication[`authors`] = []
  for (const [position, idx] of indices.entries()) {
    if (position > 0 && idx - indices[position - 1] > 1) authors.push(null)
    const { given, family } = author[idx]
    authors.push({ name: `${given[0]}. ${family}`, is_me: idx === my_idx })
  }
  return {
    id,
    title,
    DOI,
    URL,
    issued,
    authors,
    first_author: first_author.family,
    is_first_author: my_idx === 0,
    journal: reference[`container-title`],
    ...extract_citations(note),
  }
}

export function extract_citations(
  note = ``,
): Pick<Publication, `citations` | `citation_database`> {
  let citations = 0
  let citation_database = ``
  for (const [, count, database] of note.matchAll(
    /Citations: (?<count>\d+) \((?<database>[^)]+)\)/g,
  )) {
    if (Number(count) > citations) {
      citations = Number(count)
      citation_database = database
    }
  }
  return { citations, citation_database }
}

export const publications = papers.references.map(prepare_publication)
