<script lang="ts">
  import type { Reference } from '$lib'
  import { PAPER_SORT_KEYS } from '$lib/types'
  import { highlight_matches, tooltip } from 'svelte-widgets/attachments'
  import { flip } from 'svelte/animate'
  import type { HTMLAttributes } from 'svelte/elements'
  import { extract_citations, truncate_authors } from '.'

  let {
    references,
    first_name_mode = `initial`,
    target_author = `J. Riebesell`,
    sort_by = `title`,
    sort_order = `asc`,
    highlight_props = {
      query: target_author.toLowerCase(),
      css_class: `highlight-match`,
    },
    ...rest
  }: {
    references: Reference[]
    first_name_mode?: `initial` | `full` | `none`
    target_author?: string
    sort_by?: `title` | `date` | `author` | `first author` | `citations`
    sort_order?: `asc` | `desc`
    highlight_props?: Parameters<typeof highlight_matches>[0]
  } & HTMLAttributes<HTMLOListElement> = $props()

  const target_family = $derived(target_author.split(` `)[1])

  const processed_references = $derived(
    references.map((ref) => ({ ...ref, ...extract_citations(ref.note) })),
  )

  const date_num = (ref: Reference): number =>
    100 * ref.issued[0].year + ref.issued[0].month

  const sorted_references = $derived(
    processed_references.toSorted((ref_1, ref_2) => {
      const dir = sort_order === `asc` ? 1 : -1
      if (sort_by === PAPER_SORT_KEYS.title)
        return ref_1.title.localeCompare(ref_2.title) * dir
      if (sort_by === PAPER_SORT_KEYS.date)
        return (date_num(ref_1) - date_num(ref_2)) * dir
      if (sort_by === PAPER_SORT_KEYS.citations)
        return ((ref_2.citations ?? 0) - (ref_1.citations ?? 0)) * dir

      const author_idx_1 = ref_1.author.findIndex((auth) => auth.family === target_family)
      const author_idx_2 = ref_2.author.findIndex((auth) => auth.family === target_family)
      if (
        sort_by === PAPER_SORT_KEYS.first_author &&
        (author_idx_1 === -1 || author_idx_2 === -1)
      )
        return 0
      return (
        (author_idx_1 - author_idx_2) * (sort_by === PAPER_SORT_KEYS.author ? dir : -dir)
      )
    }),
  )
</script>

<ol {...rest} {@attach highlight_matches(highlight_props)}>
  {#each sorted_references as { title, id, author, DOI, URL: href, issued, ...rest } (id)}
    {@const { 'container-title': journal, citations, citation_database } = rest}
    {@const authors_formatted = author.map(({ given, family }) => {
      if (!family) {
        throw new Error(`No family name in author=${JSON.stringify(author)} of ${title}`)
      }
      const first_name = { initial: `${given[0]}. `, full: `${given} `, none: `` }[
        first_name_mode
      ]
      return `${first_name}${family}`
    })}
    <li animate:flip={{ duration: 400 }}>
      <h3 {id}>{title}</h3>
      {truncate_authors(authors_formatted.join(`, `), target_author)}
      &nbsp;&mdash;&nbsp;
      {#if DOI}
        <a href="https://doi.org/{DOI}">{DOI}</a>
        {#if journal}
          &nbsp;&mdash; <strong style="color: var(--text-secondary)">{journal}</strong>
        {/if}
      {:else if href}
        <a {href}>{href.replace(`https://`, ``)}</a>
        {#if href.toLowerCase().includes(`arxiv.org`)}&nbsp;(preprint){/if}
      {/if}
      {#if issued}
        &nbsp;&mdash;&nbsp; {issued[0].year}-{issued[0].month}
      {/if}
      {#if citations}
        &nbsp;&mdash;&nbsp; <span
          style="height: 1em"
          {@attach tooltip({ content: `According to ${citation_database}` })}
        >
          {citations} citations
        </span>
      {/if}
    </li>
  {/each}
</ol>

<style>
  ol {
    list-style: none;
    padding: 0;
    > li {
      font-weight: 300;
      text-wrap: balance;
      margin-block: 1em;
      padding: 1pt 6pt;
      > h3 {
        margin: 2pt 0;
        font-weight: 500;
      }
    }
  }
  ::highlight(highlight-match) {
    color: var(--highlight);
  }
</style>
