<script lang="ts">
  import oss from '$lib/oss.yml'
  import { references } from '$lib/papers.yaml'
  import Icon from '@iconify/svelte'
  import cv from './cv/cv.yml'
  import OpenSource from './open-source/+page.svelte'
  import Physics from './physics/+page@.md'

  const { data } = $props()

  const cambridge_crest = `https://github.com/janosh/thesis/raw/main/figs/cambridge-crest.svg`

  const projects = oss.projects.map((project) => {
    if (!project.paper_key) return project
    const paper = references.find((reference) => reference.id === project.paper_key)
    if (paper) return { ...project, paper }
    console.error(`Paper ${project.paper_key} not found`)
    return project
  })

  // combine featured projects and PhD thesis into one date-sorted list for Recent Work
  const date_num = (issued?: { year?: number; month?: number; day?: number }) =>
    issued ? (issued.year ?? 0) * 1e4 + (issued.month ?? 0) * 100 + (issued.day ?? 0) : 0

  const recent_work = [
    ...projects
      .filter((proj) => proj.featured)
      .map((proj) => ({
        name: proj.name,
        url: proj.url,
        logo: proj.logo,
        color_invert: proj.color_invert,
        description: proj.description,
        issued: proj.paper?.issued?.[0],
        links: [
          { label: `Paper`, href: proj.paper?.URL },
          { label: `Code`, href: proj.repo },
        ],
      })),
    {
      name: `PhD Thesis`,
      url: `/physics/phd-thesis`,
      logo: cambridge_crest,
      color_invert: undefined,
      description: `Towards Machine Learning Foundation Models for Materials Chemistry — Matbench Discovery, ML-guided dielectric discovery and the MACE-MP foundation model.`,
      issued: { year: 2024 },
      links: [
        { label: `PDF`, href: `https://doi.org/10.17863/CAM.113233` },
        { label: `Notes`, href: `/physics/phd-thesis` },
      ],
    },
  ].toSorted((card1, card2) => date_num(card2.issued) - date_num(card1.issued))
</script>

<img src="./janosh.jpg" alt="me" width="200" />
<h1>Janosh</h1>

<address>
  {#each cv.social as { url, icon, style } (url)}
    <a href={url} target="_blank" rel="noreferrer"><Icon inline {icon} {style} /></a>
  {/each}
  <a href="/cv">
    <Icon inline icon="academicons:cv-square" style="transform: scale(1.1)" />
  </a>
</address>

<div class="intro">
  <p>
    <strong>Computational materials scientist</strong>. I work at
    <a href="https://periodic.com/">Periodic Labs</a> on high-throughput density functional
    theory (DFT) and machine-learning force fields (MLFFs) for atomistic simulations.
  </p>
</div>

<h2 class="section-title">
  <Icon inline icon="mdi:newspaper" />
  Recent Work
</h2>
<ul class="recent grid">
  {#each recent_work as { name, url, logo, color_invert, description, issued, links } (name)}
    <li class="card">
      <h3>
        <a href={url}>
          <img src={logo} alt={name} data-color-invert={color_invert} />
          {name}
        </a>
      </h3>
      <div class="project-meta meta-row">
        {#each links as { label, href } (label)}
          <a class="pill" {href}>{label}</a>
        {/each}
        {#if issued}
          <time class="pill muted">{Object.values(issued).join(`-`)}</time>
        {/if}
      </div>
      <p class="project-description card-description muted">{description}</p>
    </li>
  {/each}
</ul>

<OpenSource {data} />

<Physics />

<style>
  img[alt='me'] {
    display: block;
    border-radius: 50%;
    object-fit: cover;
    height: 10em;
    width: 10em;
    margin: 2em auto 0;
    box-shadow: 0 8px 32px var(--shadow);
  }
  h1 {
    margin: 0.3em 0 0;
    font-size: 2.8rem;
    font-weight: 200;
  }
  address {
    display: flex;
    place-content: center;
    place-items: center;
    gap: 1em;
    font-size: 16pt;
    margin: 1em auto;
  }
  address a {
    transition: transform 0.2s ease;
  }
  address a:hover {
    transform: scale(1.1);
  }
  .intro {
    max-width: min(45em, 85vw);
    margin: 1em auto;
    text-align: center;
  }
  .intro p {
    font-size: 1.1rem;
  }
  .recent {
    margin: 1.2em auto 1.5em;
  }
  .recent > li {
    grid-template-rows: auto auto 1fr;
  }
  .recent > li > h3 {
    font-size: 1.2rem;
  }
  .recent > li > h3 a {
    flex-wrap: wrap;
  }
  .recent > li > h3 img {
    width: 2.2em;
    height: 2.2em;
  }
  .project-meta > a,
  .project-meta > time {
    padding: 1pt 6pt;
    font-size: 0.85rem;
  }
  .project-meta > time {
    font-size: 0.8em;
    background: var(--nav-bg);
  }
  .project-description {
    font-size: 0.9rem;
  }
</style>
