<script lang="ts">
  import type { Reference } from '$lib'
  import { PAPER_SORT_KEYS } from '$lib/types'
  import { highlight_matches } from 'svelte-zoo'
  import { flip } from 'svelte/animate'
  import { truncate_authors } from '.'

  interface Props {
    references: Reference[]
    first_name_mode?: `initial` | `full` | `none`
    target_author?: string
    sort_by?: `title` | `date` | `author` | `first author`
    sort_order?: `asc` | `desc`
    highlight_props?: Parameters<typeof highlight_matches>[1]
  }
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
  }: Props = $props()
</script>

<ol use:highlight_matches={highlight_props}>
  {#each references.sort((ref1, ref2) => {
      const dir = sort_order === `asc` ? 1 : -1
      if (sort_by === PAPER_SORT_KEYS.title) {
        return ref1.title.localeCompare(ref2.title) * dir
      } else if (sort_by === PAPER_SORT_KEYS.date) {
        const { year: y1, month: m1 } = ref1.issued[0]
        const { year: y2, month: m2 } = ref2.issued[0]
        return dir * (100 * (y1 - y2) + (m1 - m2))
      } else if (sort_by === PAPER_SORT_KEYS.author) {
        // papers with target_author first/last
        const idx1 = ref1.author.findIndex((auth) =>
          auth.family === target_author.split(` `)[1]
        )
        const idx2 = ref2.author.findIndex((auth) =>
          auth.family === target_author.split(` `)[1]
        )
        return (idx1 - idx2) * dir
      } else if (sort_by === PAPER_SORT_KEYS.first_author) {
        // papers with target_author first/last
        const idx1 = ref1.author.findIndex((auth) =>
          auth.family === target_author.split(` `)[1]
        )
        const idx2 = ref2.author.findIndex((auth) =>
          auth.family === target_author.split(` `)[1]
        )
        if (idx1 === -1 || idx2 === -1) return 0
        // -dir to have target_author==first rise to the top by default
        return (idx1 - idx2) * -dir
      } else throw `Unknown sort_by: ${sort_by}`
    }) as
    { title, id, author, DOI, URL: href, issued, 'container-title': journal }
    (id)
  }
    {@const authors_formatted = author.map(({ given, family }) => {
      if (!family) {
        throw `No family name in author=${JSON.stringify(author)} of ${title}`
      }
      const first_name = {
        initial: `${given[0]}. `,
        full: `${given} `,
        none: ``,
      }[first_name_mode]
      return `${first_name ?? ``}${family}`
    })}
    <li animate:flip={{ duration: 400 }}>
      <h3 {id}>{title}</h3>
      {truncate_authors(authors_formatted.join(`, `), target_author)}
      <small>
        &mdash;
        {#if DOI}
          <a href="https://doi.org/{DOI}">{DOI}</a>
          {#if journal}
            &nbsp;&mdash; <strong style="color: #444">{journal}</strong>
          {/if}
        {:else if href && (href.includes(`arxiv.org`) || href.includes(`arXiv`))}
          <a {href}>{href.replace(`https://`, ``)}</a>
          &nbsp;(preprint)
        {:else if href}
          <a {href}>{href.replace(`https://`, ``)}</a>
        {/if}
        {#if issued}
          &mdash; {issued[0].year}-{issued[0].month}
        {/if}
      </small>
    </li>
  {/each}
</ol>

<style>
  ol {
    list-style: none;
    padding: 0;
  }
  ol > li {
    font-size: 10pt;
    font-weight: 300;
  }
  ol > li > h3 {
    margin: 8pt 0 2pt;
    font-size: small;
  }
  ::highlight(highlight-match) {
    color: initial;
  }
</style>
