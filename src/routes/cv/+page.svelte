<script lang="ts">
  import { hobbies, skills, social } from '$lib/cv-icons'
  import {
    oss_sort_keys,
    type OssSortKey,
    type PaperSortKey,
    sort_oss_projects,
    type SortOrder,
  } from '$lib'
  import { ButtonGroup, Icon, Popover, ThemeToggle } from 'svelte-widgets'
  import {
    AccountGroup,
    ChevronUp,
    Education,
    FilePDF,
    GitHub,
    Interests,
    Journal,
    Languages,
    OpenSource,
    SearchCountry,
    SkillLevel,
    Star,
  } from 'svelte-widgets/icons'
  import { flip } from 'svelte/animate'
  import type { PageProps } from './$types'
  import cv from './cv.yml'
  import { print_cv, sort_papers } from './index'
  import Papers from './Papers.svelte'
  import Intro from './intro.md'

  const { data }: PageProps = $props()

  let sort_papers_by: PaperSortKey = $state(`date`)
  let sort_papers_order: SortOrder = $state(`desc`)
  let sort_oss_by: OssSortKey = $state(`commits`)
  let sort_oss_order: SortOrder = $state(`desc`)
  let pdf_menu_open = $state(false)
  let cv_main: HTMLElement | undefined = $state()

  const paper_sort_keys = [
    { value: `date`, tooltip: `Sort by date` },
    { value: `title`, tooltip: `Sort by title` },
    { value: `author`, tooltip: `Sort by first-author last name` },
    { value: `first author`, tooltip: `First-author papers to the top` },
    { value: `citations`, tooltip: `Sort by citations` },
  ] as const

  const links = { target: `_blank`, rel: `noreferrer` }
  const sorted_oss_projects = $derived(
    sort_oss_projects(data.projects, sort_oss_by, sort_oss_order),
  )
  const sorted_skills = skills.toSorted(
    (skill_1, skill_2) => skill_2.score - skill_1.score,
  )

  function export_pdf(single_page = false): void {
    if (!cv_main) throw new Error(`cannot print CV, <main> is not mounted`)
    pdf_menu_open = false
    print_cv(cv_main, single_page)
  }
</script>

<main bind:this={cv_main} data-cv>
  <section class="title">
    <h1 id="janosh-riebesell-cv">Janosh Riebesell - CV</h1>

    <address style="font-size: 1.2em">
      {#each social as { url, icon, style } (url)}
        <a href={url} {...links}><Icon {icon} {style} /></a>
      {/each}
    </address>
  </section>

  <section class="body">
    <Intro />

    <h2 id="publications-sort-by" style="margin-block: 1em;">
      <Icon icon={Journal} />&nbsp; Publications
      <span class="sort-controls">
        Sort by
        <ButtonGroup
          options={paper_sort_keys}
          bind:selected={sort_papers_by}
          bind:sort_order={sort_papers_order}
          label="Sort publications by"
        />
      </span>
    </h2>
    <Papers
      publications={sort_papers(data.publications, sort_papers_by, sort_papers_order)}
    />
    <h2 id="open-source">
      <Icon icon={OpenSource} />&nbsp; Open Source
      <span class="sort-controls">
        <ButtonGroup
          options={oss_sort_keys}
          bind:selected={sort_oss_by}
          bind:sort_order={sort_oss_order}
          label="Sort projects by"
        />
      </span>
    </h2>

    <ul class="oss">
      {#each sorted_oss_projects as { url, color_invert, repo, name, description, stars, logo, languages, commits } (name)}
        {@const logo_url = logo ?? `${url}/favicon.svg`}
        <li animate:flip={{ duration: 400 }}>
          <h4>
            <a href={url ?? repo} {...links}>
              <img src={logo_url} alt="{name} Logo" data-color-invert={color_invert} />
              {name}
            </a>
            <a href={repo} {...links}><Icon icon={GitHub} /></a>
          </h4>
          <div class="oss-meta">
            {#if stars}
              <a href="{repo}/stargazers">
                <small>{stars} <Icon icon={Star} /></small>
              </a>
            {/if}
            {#if commits}
              <a href="{repo}/graphs/contributors"><small>{commits} commits</small></a>
            {/if}
            {#if languages}
              <small class="langs">{languages.slice(0, 3).join(`, `)}</small>
            {/if}
          </div>
          <div class="project-description">{@html description}</div>
        </li>
      {/each}
    </ul>

    <h2 id="education"><Icon icon={Education} />&nbsp; Education</h2>
    <ul>
      {#each cv.education as { title, thesis, date, href, uni } (title)}
        <li>
          <h4 style="margin: 2ex 0 1ex">
            <a {href}>{title}</a>
            <span style="font-weight: 200"> - {uni}{date ? ` • ${date}` : ``}</span>
          </h4>
          Thesis title:<a href={thesis?.url}>{thesis?.title}</a>
          {#if thesis?.repo}
            &nbsp;<a href={thesis.repo} {...links}><Icon icon={GitHub} /></a>
          {/if}
        </li>
      {/each}
    </ul>

    <div class="side-by-side">
      <section>
        <h2 id="nationality"><Icon icon={SearchCountry} />&nbsp; Nationality</h2>
        <ul class="horizontal">
          {#each cv.nationality as { title, flag } (title)}
            <li>{flag}&nbsp;{title}</li>
          {/each}
        </ul>
      </section>

      <section>
        <h2 id="languages"><Icon icon={Languages} />&nbsp; Languages</h2>
        <ul class="horizontal">
          {#each cv.languages as { name, flag, level } (name)}
            <li>{flag}&nbsp;{name} <small>({level})</small></li>
          {/each}
        </ul>
      </section>
    </div>

    <h2 id="programming-languages-and-tools">
      <Icon icon={SkillLevel} />&nbsp; Programming Languages and Tools
    </h2>
    <small style="white-space: nowrap">(emphasis &asymp; proficiency)</small>
    <ul class="skills">
      {#each sorted_skills as { name, icon, svg, score, href, site } (name)}
        <li style:font-weight={(score - 3) * 100}>
          <a href={href ?? site}>
            {#if svg}
              <img src={svg} alt="{name} logo" class="skill-svg" />
            {:else if icon}
              <Icon {icon} />
            {/if}
            {name} <small>({score})</small>
          </a>
        </li>
      {/each}
    </ul>

    <h2 id="community"><Icon icon={AccountGroup} />&nbsp; Community</h2>
    <ul class="community">
      {#each cv.community as { name, date, href, img, role } (name)}
        <li>
          <a {href}>
            <img src={img} alt="{name} Logo" class="community-logo" />
          </a>
          <a {href}>{name}</a>
          {#if role}<span style="font-weight: lighter">{role}</span>{/if}
          <small>{date}</small>
        </li>
      {/each}
    </ul>

    <h2 id="hobbies"><Icon icon={Interests} />&nbsp; Hobbies</h2>
    <ul class="hobbies">
      {#each hobbies as { name, icon, href } (name)}
        <li>
          {#if href}
            <a {href}><Icon {icon} /> {name}</a>
          {:else}
            <Icon {icon} />
            {name}
          {/if}
        </li>
      {/each}
    </ul>
  </section>
</main>

<div class="cv-controls">
  <ThemeToggle tooltip={false} />
  <Popover bind:open={pdf_menu_open} placement="top" match_width class="pdf-menu">
    {#snippet trigger(props)}
      <button type="button" class="pdf-menu-trigger" {...props}>
        <Icon icon={FilePDF} />
        Export PDF
        <Icon icon={ChevronUp} />
      </button>
    {/snippet}
    <button type="button" onclick={() => export_pdf()}>Multi-page</button>
    <button type="button" onclick={() => export_pdf(true)}>Single tall page</button>
  </Popover>
</div>

<style>
  :global(body) {
    background: color-mix(in srgb, var(--page-bg) 88%, var(--text-color) 12%);
  }
  main {
    margin: 2em auto 100px;
    max-width: 50em;
    background: var(--page-bg);
    color: var(--text-color);
    padding: 3em;
    border-radius: var(--radius-md);
  }
  main :global(a) {
    color: var(--link-color);
  }
  h1 {
    margin: 0 0 3pt;
  }
  h2 {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    column-gap: 0.3em;
    margin: 1.5em 0 0.5em;
  }
  .sort-controls {
    display: flex;
    place-items: center;
    gap: 5pt;
    flex-wrap: wrap;
    margin-left: auto;
    font-weight: 100;
    font-size: 9pt;
    --btn-group-gap: 5pt;
    --btn-group-btn-padding: 1pt 4pt;
    --btn-group-btn-radius: var(--radius-sm);
    --btn-group-btn-border: none;
    --btn-group-btn-bg: var(--nav-bg);
    --btn-group-btn-color: var(--text-secondary);
    --btn-group-btn-hover-bg: var(--nav-bg);
    --btn-group-btn-active-bg: var(--accent-bg);
    :global(button) {
      font-weight: 500;
    }
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
  ul.oss {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(min(100%, 20em), 1fr));
    gap: 12pt;
    font-size: 14pt;
    > li {
      display: grid;
      grid-template-rows: subgrid;
      grid-row: span 3;
      gap: 2pt;
      > h4 {
        margin: 0;
        display: flex;
        gap: 6pt;
        place-items: center;
        a {
          display: flex;
          place-items: center;
        }
        img {
          width: 3ex;
          height: 3ex;
          margin-right: 5pt;
        }
      }
    }
  }
  .oss-meta {
    display: flex;
    gap: 8pt;
    place-items: center;
    font-size: 10pt;
    color: var(--text-secondary);
    .langs {
      font-weight: 200;
      margin-left: auto;
    }
  }
  .project-description {
    font-size: 10pt;
    font-weight: 300;
    :global(p) {
      margin: 0;
    }
  }
  .skill-svg {
    height: 1em;
    width: auto;
    vertical-align: -0.125em;
  }
  ul.skills {
    display: flex;
    gap: 4pt 8pt;
    flex-wrap: wrap;
  }
  .side-by-side {
    display: flex;
    gap: 2em;
    flex-wrap: wrap;
    > section {
      flex: 1;
      min-width: 200px;
    }
  }
  ul.community {
    margin-block: 1em;
    display: grid;
    gap: 1ex;
    > li {
      display: flex;
      gap: 1ex;
      place-items: center;
    }
  }
  .community-logo {
    display: block;
    width: 30px;
    height: 30px;
    object-fit: contain;
    border-radius: 50%;
    box-sizing: border-box;
    padding: 3px;
    background: light-dark(transparent, rgba(255, 255, 255, 0.9));
  }
  :is(ul.hobbies, ul.horizontal) {
    display: flex;
    gap: 6pt 12pt;
    flex-wrap: wrap;
  }
  .cv-controls {
    position: fixed;
    bottom: 20px;
    right: 20px;
    z-index: 1000;
    display: flex;
    align-items: center;
    gap: 8px;
    white-space: nowrap;
    > :global(button),
    .pdf-menu-trigger {
      min-height: 28px;
      box-shadow: 0 4px 12px var(--shadow);
    }
    > :global(button) {
      min-width: 28px;
    }
  }
  .pdf-menu-trigger {
    border-radius: 8px;
    padding: 2px 3px 2px 6px;
    font-size: 14px;
    display: flex;
    align-items: center;
    gap: 8px;
  }
  :global(.pdf-menu) {
    --popover-padding: 0;
    --popover-bg: var(--page-bg);
    --popover-border: 1px solid var(--card-border);
    --popover-shadow: 0 4px 12px var(--shadow);
  }
  :global(.pdf-menu button) {
    display: block;
    width: 100%;
    padding: 8px 12px;
    border-radius: 0;
    background: transparent;
    color: var(--link-color);
    text-align: left;
  }
  :global(.pdf-menu button:hover) {
    background: var(--nav-bg);
  }
  @media (max-width: 600px) {
    main {
      padding: 1.25em;
    }
    .sort-controls {
      flex-basis: 100%;
      margin: 0.5em 0 0;
    }
  }
  @media print {
    .cv-controls,
    .sort-controls {
      display: none !important;
    }
    @page {
      margin: 0.6in;
      size: auto;
    }
    main {
      margin: 0;
      padding: 2em;
      box-shadow: none;
    }
    section.body :global(:is(h2, h3)) {
      break-after: avoid;
    }
    small {
      break-before: avoid;
    }
    section.body :global(ol li) {
      break-inside: avoid;
    }
  }
</style>
