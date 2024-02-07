<script lang="ts">
  import { SortButtons } from '$lib'
  import oss from '$lib/oss.yml'
  import papers from '$lib/papers.yaml'
  import Icon from '@iconify/svelte'
  import type { ComponentProps } from 'svelte'
  import { Toggle } from 'svelte-zoo'
  import { flip } from 'svelte/animate'
  import Papers from './Papers.svelte'
  import cv from './cv.yml'

  export let data
  export let show_sidebar = true
  export let sort_papers_by: ComponentProps<Papers>['sort_by'] = `date`
  export let sort_papers_order: `asc` | `desc` = `desc`
  export let sort_oss_by: `commits` | `stars` | `title` = `commits`
  export let sort_oss_order: `asc` | `desc` = `desc`
  export let sort_oss_keys = [`commits`, `stars`, `title`] as const

  const paper_sort_keys = [`date`, `title`, `author`] as const
  const links = { target: `_blank`, rel: `noreferrer` }

  const social: [string, string][] = [
    [`mailto:${data.email}`, `mdi:email`],
    [`https://github.com/janosh`, `octicon:mark-github`],
    [`https://twitter.com/jrib_`, `fa-brands:twitter`],
    [`https://stackoverflow.com/u/4034025`, `mdi:stackoverflow`],
    [`https://linkedin.com/in/janosh-riebesell`, `bi:linkedin`],
  ]
</script>

<main style="grid-template-columns: {show_sidebar ? `1fr 140px` : `1fr`}">
  <section class="title">
    <h1>Janosh Riebesell</h1>

    <!-- <small>
      <a href="https://materialsproject.org/about/people">
        Materials Project Staff @ Lawrence Berkeley National Lab
      </a>
    </small> -->

    <address>
      {#each social as [url, icon]}
        <a href={url} {...links}><Icon inline {icon} /></a>
      {/each}
    </address>
  </section>

  <section class="body">
    <small>
      I joined the Materials Project in early 2023 where I developed ML foundation models
      (CHGNet, MACE-MP) and build high-throughput workflows for generating large DFT
      datasets to train still bigger models. I am a co-maintainer of
      <a href="https://github.com/materialsproject/pymatgen">pymatgen</a>. I'm a big fan
      of high-quality open source software with a focus on enabling new capabilities for
      scaling computational materials science. GitHub is where most of my work happens.
    </small>

    <h2>
      <Icon inline icon="iconoir:journal" />&nbsp; Selected Publications
      <SortButtons
        bind:sort_by={sort_papers_by}
        sort_keys={paper_sort_keys}
        bind:sort_order={sort_papers_order}
      />
    </h2>
    <Papers {...papers} sort_by={sort_papers_by} sort_order={sort_papers_order} />

    <h2>
      <Icon inline icon="ri:open-source-line" />&nbsp; Open Source
      <SortButtons
        bind:sort_by={sort_oss_by}
        sort_keys={sort_oss_keys}
        bind:sort_order={sort_oss_order}
      />
    </h2>
    <ul class="oss">
      {#each oss.projects.sort((p1, p2) => {
        const dir = sort_oss_order === `asc` ? -1 : 1

        if (sort_oss_by === `title`) {
          return p1.name.localeCompare(p2.name) * dir
        } else if ([`commits`, `stars`].includes(sort_oss_by)) {
          return (p2[sort_oss_by] - p1[sort_oss_by]) * dir
        } else {
          throw new Error(`Unknown sort_oss_by: ${sort_oss_by}`)
        }
      }) as { url, img_style, repo, name, description, stars, logo, languages, commits } (name)}
        {@const logo_url = logo ?? `${url}/favicon.svg`}
        <li animate:flip={{ duration: 400 }}>
          <h4>
            <a href={url ?? repo} {...links}>
              <img src={logo_url} alt="{name} Logo" style={img_style} />
              {name}
            </a>
            <a href={repo} {...links}>
              <Icon inline icon="octicon:mark-github" />
            </a>
            {#if stars}
              <a href="{repo}/stargazers">
                <small>{stars} ⭐</small>
              </a>
            {/if}
            {#if commits}
              <a href="{repo}/graphs/contributors">
                <Icon inline icon="octicon:git-commit" />
                <small>
                  {commits}
                  <span style="font-weight: 200;">commits</span>
                </small>
              </a>
            {/if}
            <small class="langs">{languages.slice(0, 3).join(`, `)}</small>
          </h4>
          <p>{description}</p>
        </li>
      {/each}
    </ul>

    <h2>
      <Icon inline icon="zondicons:education" />&nbsp; Education
    </h2>
    <ul>
      {#each cv.education as { title, thesis_title, date, href, uni }}
        <li>
          <h4>
            <a {href}>{title}</a>
            <small style="font-weight: 200;">{uni}{date ? ` &bull; ${date}` : ``}</small>
          </h4>
          <p>Thesis title: {thesis_title}</p>
        </li>
      {/each}
    </ul>

    <h2>
      <Icon inline icon="mdi:trophy" />&nbsp; Awards
    </h2>
    <ul>
      {#each cv.awards as { name, description, date, href }}
        <li>
          <h4><a {href}>{name}</a></h4>
          <p>{description} <small>{date}</small></p>
        </li>
      {/each}
    </ul>

    <h2>
      <Icon inline icon="material-symbols:volunteer-activism" />&nbsp; Volunteer Work
    </h2>
    <ul>
      {#each cv.volunteer as { name, description, href, logo, role }}
        <li>
          <h4>
            <a {href}><img src={logo} alt={name} height="20" />{name}</a>
            <small style="font-weight: 200;">{role}</small>
          </h4>
          <p>{description}</p>
        </li>
      {/each}
    </ul>
  </section>

  {#if show_sidebar}
    <aside>
      <h3>
        <Icon inline icon="lucide:languages" />&nbsp; Languages
      </h3>
      <ul>
        {#each cv.languages as { name, level, icon }}
          <li>
            <Icon inline {icon} />
            &nbsp;{name}
            <Icon inline icon="carbon:skill-level-{level}" />
          </li>
        {/each}
      </ul>

      <h3>
        <Icon inline icon="gis:search-country" />&nbsp; Nationality
      </h3>
      <ul>
        {#each cv.nationality as { title, icon }}
          <li>
            <Icon inline {icon} />
            &nbsp;{title}
          </li>
        {/each}
      </ul>

      <h3 style="margin-bottom: 0;">
        <Icon inline icon="carbon:skill-level-advanced" />&nbsp; Skills
      </h3>
      <small style="white-space: nowrap;">(emphasis &asymp; proficiency)</small>
      <ul class="skills">
        {#each cv.skills.sort((s1, s2) => s2.score - s1.score) as { name, icon, score, href, site }}
          <!-- color based on score style="color: hsl({score * 20}, 100%, 40%)" -->
          <li style:font-weight={(score - 3) * 100}>
            <a href={href ?? site}>
              <Icon inline {icon} />
              {name} <small>({score})</small>
            </a>
          </li>
        {/each}
      </ul>

      <h3>
        <Icon inline icon="mdi:account-group" />
        &nbsp; Memberships
      </h3>
      <ul>
        {#each cv.memberships as { name, date, href }}
          <li>
            <a {href}>{name}</a>&ensp;<small>{date}</small>
          </li>
        {/each}
      </ul>

      <h3>
        <Icon inline icon="material-symbols:interests" />&nbsp; Hobbies
      </h3>
      <ul>
        {#each cv.hobbies as { name, icon, href }}
          <li>
            {#if href}
              <a {href}>
                <Icon inline {icon} />
                {name}
              </a>
            {:else}
              <Icon inline {icon} />
              {name}
            {/if}
          </li>
        {/each}
      </ul>
    </aside>
  {/if}
</main>
<Toggle
  bind:checked={show_sidebar}
  style="transform: scale(0.9); margin: 1em auto 2em; font-weight: lighter;"
>
  Toggle Sidebar&ensp;
</Toggle>

<style>
  main {
    margin: 2em auto 0;
    max-width: 42em;
    background-color: whitesmoke;
    color: black;
    padding: 3em;
    display: grid;
    gap: 0 1em;
    border-radius: 2pt;
  }
  main :global(a) {
    color: darkblue;
  }
  h4 img {
    width: 3ex;
    height: 3ex;
    margin-right: 5pt;
  }
  section.title {
    grid-column: 1 / -1;
  }
  h1 {
    margin: 0 0 3pt;
  }
  /* h1 + small {
    text-align: center;
    display: block;
  } */
  h2 {
    position: relative;
  }
  a {
    color: inherit;
  }
  address {
    display: flex;
    place-content: center;
    gap: 12pt;
    font-style: normal;
    margin: 1ex;
  }
  ul {
    list-style: none;
    padding: 0;
    margin: 0;
  }
  ul.oss > li > h4 {
    margin: 8pt 0 4pt;
    display: flex;
    gap: 8pt;
    place-items: center;
    font-size: smaller;
  }
  ul.oss > li > h4 > small.langs {
    margin-left: 2ex;
    font-weight: 200;
    font-size: 9pt;
  }
  ul.oss > li > h4 a {
    display: flex;
    place-items: center;
  }
  p {
    margin: 0;
    font-size: 10pt;
    font-weight: 300;
  }
  ul.skills {
    display: flex;
    gap: 4pt 8pt;
    flex-wrap: wrap;
  }
  aside {
    font-size: smaller;
    max-height: max-content;
  }
  aside > h3 {
    white-space: nowrap;
    margin: 2ex 0 1ex;
  }
  aside > h3:first-of-type {
    margin-top: 0;
  }

  /* TODO convert to CSS prop with next svelte-zoo release */
  main :global(input:checked + span) {
    background-color: #f0f0f0 !important;
  }
  @media print {
    /* hide sidebar toggle when printing */
    main :global(label) {
      display: none !important;
    }
  }
</style>
