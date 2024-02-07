<script lang="ts">
  import type { Reference } from '$lib'
  import { highlight_matches } from 'svelte-zoo'
  import { flip } from 'svelte/animate'
  import { truncate_authors } from '.'

  export let references: Reference[]
  export let first_name_mode: 'initial' | 'full' | 'none' = `initial`
  export let target_author: string = `J. Riebesell`
  export let sort_by: 'title' | 'date' | 'author' = `title`
  export let sort_order: 'asc' | 'desc' = `asc`
  export let highlight_props: Parameters<typeof highlight_matches>[1] = {
    query: target_author.toLowerCase(),
    css_class: `highlight-match`,
  }
</script>

<ol use:highlight_matches={highlight_props}>
  {#each references.sort((ref1, ref2) => {
    const dir = sort_order === `asc` ? 1 : -1
    if (sort_by === `title`) {
      return ref1.title.localeCompare(ref2.title) * dir
    } else if (sort_by === `date`) {
      const { year: y1, month: m1 } = ref1.issued[0]
      const { year: y2, month: m2 } = ref2.issued[0]
      return dir * (100 * (y1 - y2) + (m1 - m2))
    } else if (sort_by === `author`) {
      // papers with target_author first/last
      const idx1 = ref1.author.findIndex((auth) => auth.family === target_author.split(` `)[1])
      const idx2 = ref2.author.findIndex((auth) => auth.family === target_author.split(` `)[1])
      return (idx1 - idx2) * dir
    } else throw `Unknown sort_by: ${sort_by}`
  }) as { title, id, author, DOI, URL: href, issued } (id)}
    {@const author_str = author
      .map(({ given, family }) => {
        const first_name = {
          initial: `${given[0]}. `,
          full: `${given} `,
          none: ``,
        }[first_name_mode]
        return `${first_name ?? ``}${family}`
      })
      .join(`, `)}
    <li animate:flip={{ duration: 400 }}>
      <h3 {id}>{title}</h3>
      {truncate_authors(author_str, target_author)}
      <small>
        &mdash;
        {#if DOI}
          <a href="https://doi.org/{DOI}">{DOI}</a>
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
