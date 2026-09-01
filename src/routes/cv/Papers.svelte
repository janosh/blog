<script lang="ts">
  import type { Publication } from '$lib'
  import { tooltip } from 'svelte-widgets/attachments'
  import { format_publication_date } from './index'

  const { publications }: { publications: Publication[] } = $props()
</script>

<ol>
  {#each publications as { title, id, authors, DOI, URL: href, issued, journal, citations, citation_database } (id)}
    {@const paper_url = DOI ? `https://doi.org/${DOI}` : href}
    <li>
      <h3 {id}>
        {#if paper_url}<a href={paper_url}>{title}</a>{:else}{title}{/if}
      </h3>
      {#each authors as author, idx}
        {idx ? `, ` : ``}<span
          style:color={author?.is_me ? `var(--highlight)` : undefined}
          >{author?.name ?? `...`}</span
        >
      {/each}
      {#if journal}
        &nbsp;&mdash;&nbsp; <strong style="color: var(--text-secondary)">{journal}</strong
        >
      {:else if href?.toLowerCase().includes(`arxiv.org`)}
        &nbsp;&mdash;&nbsp; preprint
      {/if}
      &nbsp;&mdash;&nbsp; {format_publication_date(issued)}
      {#if DOI}&nbsp;· <a href={paper_url}>DOI</a>{/if}
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
      margin-block: 1em;
      padding: 1pt 6pt;
      > h3 {
        margin: 2pt 0;
        font-weight: 500;
        a {
          color: inherit;
        }
      }
    }
  }
</style>
