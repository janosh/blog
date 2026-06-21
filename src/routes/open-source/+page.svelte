<script lang="ts">
  import { sort_oss_projects } from '$lib'
  import Icon from '@iconify/svelte'
  import { highlight_matches } from 'svelte-multiselect/attachments'
  import { flip } from 'svelte/animate'

  const { data } = $props()

  let sort_by = $state<`commits` | `stars` | `title`>(`commits`)
  const sort_by_options = [`commits`, `stars`, `title`] as const

  let query = $state(``)
  let projects = $derived(
    sort_oss_projects(
      data.oss.projects.filter((project) => {
        if (!query) return true
        return JSON.stringify(project).toLowerCase().includes(query.toLowerCase())
      }),
      sort_by === `title` ? `name` : sort_by,
      sort_by === `title` ? `asc` : `desc`,
    ),
  )
</script>

<h2 class="section-title">
  <Icon inline icon="ri:open-source-line" />
  Open Source
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
  {#each projects as { url, repo, name, description, stars, logo, commits, role, color_invert } (name)}
    {@const logo_url = logo ?? `${url}/favicon.svg`}
    <li class="card" animate:flip={{ duration: 400 }}>
      <h3>
        <a href={url ?? repo} target="_blank" rel="noreferrer">
          <img src={logo_url} alt="{name} Logo" data-color-invert={color_invert} />
          {name}
        </a>
      </h3>
      <div class="project-stats meta-row">
        {#if stars}
          <a href="{repo}/stargazers" class="stat-link pill">
            <Icon inline icon="octicon:mark-github" />
            <span>{stars} ⭐</span>
          </a>
        {/if}

        {#if commits}
          <a href="{repo}/commits?author=janosh" class="stat-link pill">
            <Icon inline icon="octicon:git-commit" />
            <span>{commits} <small>commits</small></span>
          </a>
        {/if}

        <a href="{repo}/graphs/contributors" class="stat-link pill">
          <Icon inline icon="octicon:people-16" />
          <span>{role ?? (repo.includes(`/janosh/`) ? `Lead` : `Contributor`)}</span>
        </a>
      </div>
      <p class="project-description card-description muted">{@html description}</p>
    </li>
  {/each}
  <li style="visibility: hidden"></li>
  <li style="visibility: hidden"></li>
</ul>

<style>
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
    border-radius: var(--radius-lg);
    transition:
      transform 0.2s ease,
      background 0.2s ease;
  }
  button:hover {
    background: var(--nav-bg);
    transform: translateY(-1px);
  }
  button.active {
    background: var(--button-bg);
    border-color: var(--card-hover-border);
  }
  input {
    padding: 0.5em 1em;
    border-radius: var(--radius-pill);
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
    grid-row: span 3;
    grid-template-columns: subgrid;
    grid-template-rows: subgrid;
  }
  h3 {
    font-size: 1.1rem;
  }
  h3 img {
    width: 2em;
    height: 2em;
  }
  .project-stats {
    font-size: 0.8rem;
  }
  .project-description {
    font-size: 0.85rem;
    line-height: 1.4;
    max-height: calc(1.4em * 4);
    overflow-y: auto;
  }
</style>
