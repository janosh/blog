<script lang="ts">
  import oss from '$lib/oss.yml'
  import Icon from '@iconify/svelte'
  import { compile } from 'mdsvex'
  import { highlight_matches } from 'svelte-multiselect/attachments'
  import { flip } from 'svelte/animate'

  let sort_by: `commits` | `stars` | `title` = $state(`commits`)
  const sort_by_options = [`commits`, `stars`, `title`] as const

  let query = $state(``)
  let projects = $derived(
    oss.projects
      .filter((proj) => {
        if (!query) return true
        return JSON.stringify(proj).toLowerCase().includes(query.toLowerCase())
      })
      .sort((p1, p2) => {
        if (sort_by === `title`) return p1.name.localeCompare(p2.name)
        else if ([`commits`, `stars`].includes(sort_by)) {
          return p2[sort_by] - p1[sort_by]
        } else throw new Error(`Unknown sort_by: ${sort_by}`)
      }),
  )
</script>

<h2 class="section-title">
  <Icon inline icon="ri:open-source-line" />&nbsp; Open Source
</h2>

<div class="controls" style="color: var(--text-secondary)">
  Sort by
  {#each sort_by_options as title (title)}
    <button onclick={() => (sort_by = title)} class:active={sort_by === title}>
      {title}
    </button>
  {/each}
  <input placeholder="Search projects..." bind:value={query} style="margin: 0 0 0 1em" />
</div>

<ul
  class="projects grid"
  {@attach highlight_matches({ query, css_class: `highlight-match` })}
>
  {#each projects as { url, repo, name, description, stars, logo, commits, role } (name)}
    {@const logo_url = logo ?? `${url}/favicon.svg`}
    <li animate:flip={{ duration: 400 }}>
      <h3>
        <a href={url ?? repo} target="_blank" rel="noreferrer">
          <img src={logo_url} alt="{name} Logo" />
          {name}
        </a>
      </h3>
      <div class="project-stats">
        {#if stars}
          <a href="{repo}/stargazers" class="stat-link">
            <Icon inline icon="octicon:mark-github" />
            <span>{stars} ⭐</span>
          </a>
        {/if}

        {#if commits}
          <a href="{repo}/commits?author=janosh" class="stat-link">
            <Icon inline icon="octicon:git-commit" />
            <span>{commits} <small>commits</small></span>
          </a>
        {/if}

        <a href="{repo}/graphs/contributors" class="stat-link">
          <Icon inline icon="octicon:people-16" />
          <span>{role ?? (repo.includes(`/janosh/`) ? `Lead` : `Contributor`)}</span>
        </a>
      </div>
      {#await compile(description) then result}
        {#if result?.code}
          <p class="project-description">{@html result.code}</p>
        {:else}
          <p class="project-description">{description}</p>
        {/if}
      {/await}
    </li>
  {/each}
  <li style="visibility: hidden"></li>
  <li style="visibility: hidden"></li>
</ul>

<style>
  h2 {
    text-align: center;
    margin-bottom: 1.2em;
  }
  .controls {
    display: flex;
    place-content: center;
    place-items: center;
    gap: 6pt;
    margin: 1em 2em;
    flex-wrap: wrap;
  }
  button {
    background: var(--card-bg);
    border: 1px solid var(--card-border);
    padding: 4pt 8pt;
    border-radius: 8pt;
    transition: all 0.2s ease;
  }
  button:hover {
    background: var(--nav-bg);
    transform: translateY(-1px);
  }
  button.active {
    background: var(--button-bg);
  }
  input {
    padding: 0.5em 1em;
    border-radius: 18px;
    min-width: 180px;
    background: var(--input-bg);
    border: 1px solid var(--card-border);
    font-size: 1em;
    transition: all 0.2s ease;
  }
  input:focus {
    outline: none;
    border-color: var(--button-bg);
    background: var(--nav-bg);
  }
  .projects {
    margin: 1.2em auto;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  }
  .projects > li {
    display: grid;
    gap: 0.6em;
    grid-row: span 3;
    grid-template-columns: subgrid;
    grid-template-rows: subgrid;
    background: linear-gradient(
      135deg,
      var(--card-bg),
      var(--nav-bg)
    );
    border: 1px solid var(--card-border);
    padding: 0.8em;
    border-radius: 6pt;
    transition: all 0.2s ease;
  }
  .projects > li:hover {
    transform: translateY(-2px);
    border-color: var(--nav-bg);
  }
  h3 {
    margin: 0;
    font-size: 1.1rem;
    font-weight: 500;
  }
  h3 a {
    display: flex;
    place-items: center;
    gap: 0.4em;
  }
  h3 img {
    width: 2em;
    height: 2em;
    object-fit: contain;
    border-radius: 3px;
  }
  .project-stats {
    display: flex;
    gap: 0.6em;
    place-content: center;
    flex-wrap: wrap;
    font-size: 0.8rem;
  }
  .stat-link {
    display: flex;
    gap: 0.3em;
    place-items: center;
    background: var(--card-bg);
    padding: 0.2em 0.6em;
    border-radius: 12px;
    color: var(--text-secondary) !important;
    transition: all 0.2s ease;
  }
  .stat-link:hover {
    background: var(--nav-bg);
    color: var(--text-color) !important;
  }
  .project-description {
    margin: 0;
    font-size: 0.85rem;
    line-height: 1.4;
    color: var(--text-secondary);
    overflow: hidden;
    max-height: calc(1.4em * 4);
    overflow-y: auto;
  }
</style>
