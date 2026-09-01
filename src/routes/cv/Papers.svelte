<script lang="ts">
  import type { Publication } from '$lib'
  import { tooltip } from 'svelte-widgets/attachments'
  import { flip } from 'svelte/animate'

  const { publications }: { publications: Publication[] } = $props()
</script>

<ol>
  {#each publications as { title, id, authors, DOI, URL: href, issued, journal, citations, citation_database } (id)}
    <li animate:flip={{ duration: 400 }}>
      <h3 {id}>{title}</h3>
      {#each authors as author, idx}
        {idx ? `, ` : ``}<span
          style:color={author?.is_me ? `var(--highlight)` : undefined}
          >{author?.name ?? `...`}</span
        >
      {/each}
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
      &nbsp;&mdash;&nbsp; {[issued.year, issued.month]
        .filter((part) => part !== undefined)
        .join(`-`)}
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
</style>
