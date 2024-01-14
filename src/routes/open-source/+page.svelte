<script lang="ts">
  import Icon from '@iconify/svelte'
  import { flip } from 'svelte/animate'
  import oss from './oss.yml'

  let sort_by: 'commits' | 'stars' | 'alphabetical' = `commits`
  const sort_by_options = [`commits`, `stars`, `alphabetical`] as const

  $: projects = oss.projects.sort((p1, p2) => {
    if (sort_by === `alphabetical`) {
      return p1.name.localeCompare(p2.name)
    } else if ([`commits`, `stars`].includes(sort_by)) {
      return p2[sort_by] - p1[sort_by]
    } else {
      throw new Error(`Unknown sort_by: ${sort_by}`)
    }
  })
</script>

<h2 class="section-title">
  <Icon inline icon="ri:open-source-line" />&nbsp; Open Source
</h2>

<ul class="buttons">
  Sort by
  {#each sort_by_options as title}
    <button on:click={() => (sort_by = title)} class:active={sort_by === title}>
      {title}
    </button>
  {/each}
</ul>

<ul class="projects grid">
  {#each projects as { url, repo, name, description, stars, logo, commits, role } (name)}
    {@const logo_url = logo ?? `${url}/favicon.svg`}
    <li animate:flip={{ duration: 400 }}>
      <h3>
        <a href={url ?? repo} target="_blank" rel="noreferrer">
          <img src={logo_url} alt="{name} Logo" />
          {name}
        </a>
      </h3>
      <section>
        {#if stars}
          <a href="{repo}/stargazers">
            <Icon inline icon="octicon:mark-github" />
            {stars} ⭐
          </a>
        {/if}

        {#if commits}
          <a href="{repo}/graphs/contributors">
            <Icon inline icon="octicon:git-commit" />
            <span>
              {commits} <small>commits</small>
            </span>
          </a>
        {/if}
        <a href="{repo}/graphs/contributors">
          <Icon inline icon="octicon:people-16" />
          {role ?? (repo.includes(`/janosh/`) ? `Lead` : `Contributor`)}
        </a>
      </section>
      <!-- <p class="langs">{languages.slice(0, 3).join(`, `)}</p> -->
      <p>{description}</p>
    </li>
  {/each}
</ul>

<style>
  h2 {
    text-align: center;
  }
  h3 {
    margin: 0 auto;
  }
  h3 a {
    display: flex;
    place-items: center;
  }
  h3 img {
    width: 3ex;
    height: 3ex;
    margin-right: 5pt;
  }
  section {
    display: flex;
    gap: 2pt 1em;
    place-content: center;
    place-items: center;
    font-weight: 200;
    font-size: 11pt;
    flex-wrap: wrap;
  }
  section a {
    display: flex;
    gap: 1ex;
    place-items: center;
    color: inherit;
  }
  ul.buttons {
    display: flex;
    place-content: center;
    gap: 9pt;
    margin: auto;
  }
  button {
    transition: background-color 0.2s ease-in-out;
  }
  button.active {
    background-color: darkslategrey;
  }
  ul.projects {
    margin: 1em auto 2em;
  }
  ul.projects > li {
    display: grid;
    gap: 12px;
    grid-row: span 3;
    grid-template-columns: subgrid;
    grid-template-rows: subgrid;
    background-color: rgba(255, 255, 255, 0.04);
    padding: 9px 12px;
    border-radius: 4pt;
  }
  p {
    margin: 0;
    font-size: 11pt;
    font-weight: 250;
    max-height: 6em;
    overflow: scroll;
  }
</style>
