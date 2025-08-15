<script lang="ts">
  import oss from '$lib/oss.yml'
  import { references } from '$lib/papers.yaml'
  import Icon from '@iconify/svelte'
  import cv from './cv/cv.yml'
  import OpenSource from './open-source/+page.svelte'
  import Physics from './physics/+page@.md'

  const projects = oss.projects.map((proj) => {
    if (!proj.paper_key) return proj
    const paper = references.find((p) => p.id === proj.paper_key)
    if (paper) return { ...proj, paper }
    else {
      console.error(`Paper ${proj.paper_key} not found`)
      return proj
    }
  })

  const mbd = projects.find((p) => p.name === `Matbench Discovery`)
  const pmv = projects.find((p) => p.name === `pymatviz`)
  const pmg = projects.find((p) => p.name === `pymatgen`)
  const torchsim = projects.find((p) => p.name === `TorchSim`)
  const matterviz = projects.find((p) => p.name === `MatterViz`)
  const mace_paper = references.find((p) => p.id === `batatia_foundation_2023`)!
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
  <p class="interest-description">
    <strong>Computational materials scientist</strong>. I'm interested in machine-
    learning-powered atomistic simulation and building software around that.
  </p>

  <div class="interest-links">
    <a href={mbd?.repo} class="interest-tag">🔎 Materials Discovery</a>
    <a href={mace_paper.URL} class="interest-tag">🤖 ML Foundation Models</a>
    <a href={torchsim?.repo} class="interest-tag">⚛️ Atomistic Simulation</a>
    <a href={pmv?.repo} class="interest-tag">📊 Data Visualization</a>
    <a href={pmg?.repo} class="interest-tag">💻 Software Engineering</a>
    <a href={matterviz?.repo} class="interest-tag">🌐 Web Development</a>
  </div>
</div>

<h2 class="section-title">
  <Icon inline icon="mdi:newspaper" />
  &nbsp;Recent Work
</h2>
<ul class="recent grid">
  {#each projects.filter((proj) => proj.featured).sort((p1, p2) => {
      const date1 = p1?.paper?.issued?.[0]
      const date2 = p2?.paper?.issued?.[0]
      if (!date1 || !date2) return 0
      return new Date(date2.year, date2.month, date2.day).getTime() -
        new Date(date1.year, date1.month, date1.day).getTime()
    }) as
    project
    (project.name)
  }
    {@const { name, url, repo, logo, paper, description } = project}
    <li>
      <h3 style="white-space: nowrap">
        <a href={url}>
          <img src={logo} alt={name} style="border-radius: 3pt" /> {name}
        </a>
      </h3>
      <div class="project-meta">
        <a href={paper?.URL}>Paper</a>
        <a href={repo}>Code</a>
        {#if paper}
          <time>{Object.values(paper.issued[0]).join(`-`)}</time>
        {/if}
      </div>
      <p class="project-description">{description}</p>
    </li>
  {/each}
</ul>

<OpenSource />

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
    gap: 1em;
    font-size: 16pt;
    margin: 1em auto;
  }
  address a:hover {
    transform: scale(1.1);
  }
  .intro {
    max-width: min(45em, 85vw);
    margin: 1em auto;
    text-align: center;
  }
  .interest-description {
    font-size: 1.1rem;
    margin-bottom: 1.2em;
  }
  .interest-links {
    display: flex;
    flex-wrap: wrap;
    gap: 0.6em;
    place-content: center;
    margin: 1.2em 0;
  }
  .interest-tag {
    background: var(--card-bg);
    padding: 1pt 8pt;
    border-radius: 20px;
    font-weight: 500;
    font-size: 0.85rem;
    border: 1px solid var(--card-border);
    transition: all 0.2s ease;
  }
  .interest-tag:hover {
    background: var(--nav-bg);
    transform: translateY(-2px);
  }
  .recent {
    margin: 1.2em auto 1.5em;
  }
  .recent > li {
    background: linear-gradient(
      135deg,
      var(--card-bg),
      color-mix(in srgb, var(--card-bg) 50%, var(--nav-bg) 50%)
    );
    border: 1px solid var(--card-border);
    padding: 0.8em;
    border-radius: 6pt;
    display: grid;
    gap: 0.6em;
    grid-template-rows: auto auto 1fr;
    transition: all 0.2s ease;
  }
  .recent > li:hover {
    transform: translateY(-2px);
    border-color: var(--nav-bg);
  }
  .recent > li > h3 {
    margin: 0;
    font-size: 1.2rem;
    font-weight: 500;
  }
  .recent > li > h3 a {
    display: flex;
    place-items: center;
    gap: 0.4em;
  }
  .recent > li > h3 img {
    width: 2.2em;
    height: 2.2em;
    object-fit: contain;
  }
  .project-meta {
    display: flex;
    gap: 0.8em;
    place-content: center;
    font-size: 0.85rem;
    flex-wrap: wrap;
  }
  .project-meta > a {
    background: var(--card-bg);
    padding: 1pt 6pt;
    border-radius: 12px;
    font-weight: 500;
  }
  .project-meta > a:hover {
    background: var(--nav-bg);
  }
  .project-meta > time {
    color: var(--text-secondary);
    font-size: 0.8em;
    background: var(--nav-bg);
    padding: 1pt 6pt;
    border-radius: 12px;
    display: flex;
    place-items: center;
  }
  .project-description {
    margin: 0;
    color: var(--text-secondary);
    font-size: 0.9rem;
  }
</style>
