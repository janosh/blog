<script lang="ts">
  import { social } from '$lib/cv-icons'
  import { Icon } from 'svelte-widgets'
  import { CvSquare, Newspaper } from 'svelte-widgets/icons'
  import OpenSource from '$lib/OpenSource.svelte'
  import PhysicsNotes from './physics/PhysicsNotes.md'
  import type { PageProps } from './$types'

  const { data }: PageProps = $props()
</script>

<img src="./janosh.webp" alt="me" width="200" />
<h1 id="janosh">Janosh</h1>

<address>
  {#each social as { url, icon, style } (url)}
    <a href={url} target="_blank" rel="noreferrer"><Icon {icon} {style} /></a>
  {/each}
  <a href="/cv"><Icon icon={CvSquare} style="transform: scale(1.1)" /></a>
</address>

<div class="intro">
  <p style="font-size: 1.1rem">
    <strong>Computational materials scientist</strong>. I work at
    <a href="https://periodic.com/">Periodic Labs</a> on high-throughput density functional
    theory (DFT) and machine-learning force fields (MLFFs) for atomistic simulations.
  </p>
</div>

<h2 id="recent-work" class="section-title">
  <Icon icon={Newspaper} />
  Recent Work
</h2>
<ul class="recent grid" style="margin: 1.2em auto 1.5em">
  {#each data.recent_work as { name, url, logo, color_invert, description, issued, links } (name)}
    <li class="card" style="grid-template-rows: auto auto 1fr">
      <h3 style="font-size: 1.2rem">
        <a href={url} style="flex-wrap: wrap">
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

<OpenSource projects={data.projects} />

<PhysicsNotes />

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
