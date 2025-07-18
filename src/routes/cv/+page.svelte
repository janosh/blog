<script lang="ts">
  import { PaperGrid, PaperTimeline, type Project, SortButtons } from '$lib'
  import papers from '$lib/papers.yaml'
  import { OSS_SORT_KEYS, PAPER_SORT_KEYS } from '$lib/types'
  import Icon from '@iconify/svelte'
  import type { ComponentProps } from 'svelte'
  import { flip } from 'svelte/animate'
  import cv from './cv.yml'
  import Intro from './intro.md'
  import Papers from './Papers.svelte'

  const { data } = $props()

  type PaperProps = ComponentProps<typeof Papers>
  let sort_papers_by: PaperProps[`sort_by`] = $state(`date`)
  let sort_papers_order: PaperProps[`sort_order`] = $state(`desc`)
  let sort_oss_by: keyof Project = $state(`commits`)
  let sort_oss_order: PaperProps[`sort_order`] = $state(`desc`)
  let PaperGraph: typeof PaperGrid | typeof PaperTimeline = $state(PaperGrid)

  const paper_sort_keys = [
    [PAPER_SORT_KEYS.date, `Sort by date`],
    [PAPER_SORT_KEYS.title, `Sort by title`],
    [PAPER_SORT_KEYS.author, `Sort by first-author last name`],
    [PAPER_SORT_KEYS.first_author, `First-author papers to the top`],
    [PAPER_SORT_KEYS.citations, `Sort by citations`],
  ] as const

  const oss_sort_keys = [
    [OSS_SORT_KEYS.commits, `Sort by commits`],
    [OSS_SORT_KEYS.stars, `Sort by stars`],
    [OSS_SORT_KEYS.name, `Sort by name`],
  ] as const

  const links = { target: `_blank`, rel: `noreferrer` }

  function export_single_page_pdf(): void {
    const main_element = document.querySelector(`main`)
    if (!main_element) return

    // Apply print-like styles for measurement
    const measure_style = document.createElement(`style`)
    measure_style.textContent =
      `@media screen { main { width: calc(210mm - 0.2in) !important; max-width: calc(210mm - 0.2in) !important; margin: 0 !important; padding: 2em !important; font-size: 10pt !important; line-height: 1.2 !important; } main p { font-size: 10pt !important; margin: 0 0 6pt 0 !important; } main h2 { font-size: 12pt !important; margin: 12pt 0 6pt 0 !important; } main h4, main small { font-size: 10pt !important; margin: 6pt 0 3pt 0 !important; } }`
    document.head.appendChild(measure_style)

    void main_element.offsetHeight // Force layout
    const height_mm = ((main_element.scrollHeight * 25.4) / 96 * 1.8) + 50
    measure_style.remove()

    // Create single-page PDF
    const print_style = document.createElement(`style`)
    print_style.id = `single-page-pdf`
    print_style.textContent = `@media print { @page { size: 210mm ${
      height_mm.toFixed(1)
    }mm; margin: 0.1in; } *, main, section, section.body, section.body *, ul.oss, ul.oss *, ul.skills, ul.skills *, ul.hobbies, ul.hobbies *, ul.horizontal, ul.horizontal *, .side-by-side, .side-by-side * { page-break-before: auto !important; page-break-after: auto !important; page-break-inside: auto !important; break-before: auto !important; break-after: auto !important; break-inside: auto !important; } html, body, main { height: auto !important; max-height: none !important; overflow: visible !important; } }`
    document.head.appendChild(print_style)

    window.print()
    setTimeout(() => document.getElementById(`single-page-pdf`)?.remove(), 1000)
  }
</script>

<main>
  <section class="title">
    <h1>Janosh Riebesell - CV</h1>

    <address style="font-size: 1.2em">
      {#each cv.social as { url, icon, style } (url)}
        <a href={url} {...links}><Icon inline {icon} {style} /></a>
      {/each}
    </address>
  </section>

  <section class="body">
    <Intro />

    <h2>
      <Icon inline icon="iconoir:journal" />&nbsp; Publications
      <SortButtons
        bind:sort_by={sort_papers_by}
        sort_keys={paper_sort_keys}
        bind:sort_order={sort_papers_order}
      />
    </h2>
    <div class="view-toggle">
      {#each [
          [PaperGrid, `mdi:grid`, `Grid`],
          [PaperTimeline, `mdi:timeline`, `Line`],
        ] as const as
        [Component, icon, label]
        (icon)
      }
        <button
          class:active={PaperGraph === Component}
          onclick={() => PaperGraph = Component}
        >
          <Icon {icon} /> {label}
        </button>
      {/each}
    </div>

    <PaperGraph papers={papers.references} class="paper-graph" />
    <Papers {...papers} sort_by={sort_papers_by} sort_order={sort_papers_order} />
    <h2>
      <Icon inline icon="ri:open-source-line" />&nbsp; Open Source
      <SortButtons
        bind:sort_by={sort_oss_by}
        sort_keys={oss_sort_keys}
        bind:sort_order={sort_oss_order}
      />
    </h2>
    <ul class="oss">
      {#each data.oss.projects.sort((p1, p2) => {
          const dir = sort_oss_order === `asc` ? -1 : 1
          if (sort_oss_by === OSS_SORT_KEYS.name) {
            return p1.name.localeCompare(p2.name) * dir
          } else if (
            sort_oss_by === OSS_SORT_KEYS.commits ||
            sort_oss_by === OSS_SORT_KEYS.stars
          ) {
            return (Number(p2[sort_oss_by]) - Number(p1[sort_oss_by])) * dir
          } else {
            throw new Error(`Unknown sort_oss_by: ${sort_oss_by}`)
          }
        }) as
        { url, img_style, repo, name, description, ...rest }
        (name)
      }
        {@const { stars, logo, languages, commits } = rest}
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
                  <span style="font-weight: 200">commits</span>
                </small>
              </a>
            {/if}
            <small class="langs">{languages.slice(0, 3).join(`, `)}</small>
          </h4>
          <p>{@html description}</p>
        </li>
      {/each}
    </ul>

    <h2>
      <Icon inline icon="zondicons:education" />&nbsp; Education
    </h2>
    <ul>
      {#each cv.education as edu (JSON.stringify(edu))}
        {@const { title, thesis, date, href, uni } = edu}
        <li>
          <h4 style="margin: 2ex 0 1ex">
            <a {href}>{title}</a>
            <span style="font-weight: 200"> - {uni}{date ? ` &bull; ${date}` : ``}</span>
          </h4>
          Thesis title: <a href={thesis?.url}>{thesis?.title}</a>
          {#if thesis?.repo}
            &nbsp;<a href={thesis.repo} {...links}>
              <Icon inline icon="octicon:mark-github" />
            </a>
          {/if}
        </li>
      {/each}
    </ul>

    <div class="side-by-side">
      <div>
        <h2>
          <Icon inline icon="lucide:languages" />&nbsp; Languages
        </h2>
        <ul class="horizontal">
          {#each cv.languages as { name, level, icon } (name)}
            <li>
              <Icon inline {icon} />
              &nbsp;{name}
              <Icon inline icon="carbon:skill-level-{level}" />
            </li>
          {/each}
        </ul>
      </div>

      <div>
        <h2>
          <Icon inline icon="gis:search-country" />&nbsp; Nationality
        </h2>
        <ul class="horizontal">
          {#each cv.nationality as { title, icon } (title)}
            <li>
              <Icon inline {icon} />
              &nbsp;{title}
            </li>
          {/each}
        </ul>
      </div>
    </div>

    <h2>
      <Icon inline icon="carbon:skill-level-advanced" />&nbsp; Programming Languages and
      Tools
    </h2>
    <small style="white-space: nowrap">(emphasis &asymp; proficiency)</small>
    <ul class="skills">
      {#each cv.skills.sort((s1, s2) => s2.score - s1.score) as
        { name, icon, score, href, site }
        (name)
      }
        <!-- color based on score style="color: hsl({score * 20}, 100%, 40%)" -->
        <li style:font-weight={(score - 3) * 100}>
          <a href={href ?? site}>
            <Icon inline {icon} />
            {name} <small>({score})</small>
          </a>
        </li>
      {/each}
    </ul>

    <h2>
      <Icon inline icon="mdi:account-group" />
      &nbsp; Memberships
    </h2>
    <ul>
      {#each cv.memberships as { name, date, href } (name)}
        <li>
          <a {href}>{name}</a>&ensp;<small>{date}</small>
        </li>
      {/each}
    </ul>

    <h2>
      <Icon inline icon="material-symbols:interests" />&nbsp; Hobbies
    </h2>
    <ul class="hobbies">
      {#each cv.hobbies as { name, icon, href } (name)}
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
  </section>
</main>

<div class="pdf-dropdown">
  <button type="button">
    <Icon icon="mdi:file-pdf-box" />
    Export PDF
    <Icon icon="mdi:chevron-up" />
  </button>
  <div>
    <button onclick={() => window.print()}>Multi-page</button>
    <button onclick={export_single_page_pdf}>Single tall page</button>
  </div>
</div>

<style>
  main {
    margin: 2em auto 100px;
    max-width: 50em;
    background-color: whitesmoke;
    color: black;
    padding: 3em;
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
    margin-bottom: 0;
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
    font-size: 16pt;
    text-wrap: balance;
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
  .side-by-side {
    display: flex;
    gap: 2em;
    flex-wrap: wrap;
  }
  .side-by-side > div {
    flex: 1;
    min-width: 200px;
  }
  ul.hobbies {
    display: flex;
    gap: 4pt 8pt;
    flex-wrap: wrap;
  }
  ul.horizontal {
    display: flex;
    gap: 4pt 8pt;
    flex-wrap: wrap;
  }
  .pdf-dropdown {
    position: fixed;
    bottom: 20px;
    right: 20px;
    z-index: 1000;
    white-space: nowrap;
  }
  .pdf-dropdown > button {
    background: rgb(58, 87, 215);
    color: white;
    border: none;
    border-radius: 8px;
    padding: 9px;
    font-size: 14px;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    transition: all 0.2s ease;
  }
  .pdf-dropdown > div {
    position: absolute;
    bottom: 100%;
    right: 0;
    background: white;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    opacity: 0;
    visibility: hidden;
    transform: translateY(10px);
    transition: all 0.2s ease;
  }
  .pdf-dropdown:hover > div {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
  }
  .pdf-dropdown > div > button {
    background: white;
    color: darkblue;
    border: none;
    padding: 8px 12px;
    cursor: pointer;
    display: block;
    width: 100%;
    box-sizing: border-box;
    text-align: left;
  }
  .pdf-dropdown > div > button:hover {
    background: #f0f0f0;
  }
  @media print {
    .pdf-dropdown, .view-toggle, :global(.paper-graph) {
      display: none !important;
    }
    /* Ensure colors show in PDF for both paper components */
    :global(:is(.week-tile, .legend-tile, .timeline-line, .marker-bar)) {
      print-color-adjust: exact !important;
    }
    @page {
      margin: 0;
      padding: 0.6in;
      size: auto;
    }
    main {
      margin: 0;
      padding: 2em;
      box-shadow: none;
    }
    /* Keep section and publication titles with their content */
    section.body :global(:is(h2, h3)) {
      page-break-after: avoid;
      break-after: avoid;
    }
    /* Keep publication metadata with titles */
    small {
      page-break-before: avoid;
      break-before: avoid;
    }
    /* Keep publication list items together */
    section.body :global(ol li) {
      page-break-inside: avoid;
      break-inside: avoid;
    }
  }
  .paper-controls {
    display: flex;
    align-items: center;
    gap: 1rem;
    margin-left: auto;
  }
  .view-toggle {
    display: flex;
    gap: 8px;
  }
  .view-toggle button {
    background: white;
    border: 1px solid #ccc;
    border-radius: 6px;
    padding: 4px 8px;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 4px;
    transition: all 0.2s ease;
    font-size: 12px;
  }
  .view-toggle button:hover {
    background: #f0f0f0;
  }
  .view-toggle button.active {
    background: #3a57d7;
    color: white;
    border-color: #3a57d7;
  }
</style>
