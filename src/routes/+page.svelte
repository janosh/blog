<script lang="ts">
  import GdmSLides from '$lib/2024-01-12-deepmind-interview.pdf'
  import oss from '$lib/oss.yml'
  import { references } from '$lib/papers.yaml'
  import Icon from '@iconify/svelte'
  import OpenSource from './open-source/+page.svelte'
  import Physics from './physics/+page@.md'
  import Posts from './posts/+page@.svelte'

  export let data

  const mbd = oss.projects.find((p) => p.name === `Matbench Discovery`)
  const pmv = oss.projects.find((p) => p.name === `pymatviz`)
  const pmg = oss.projects.find((p) => p.name === `pymatgen`)
  const elementari = oss.projects.find((p) => p.name === `Elementari`)
</script>

<img src="./janosh.jpg" alt="me" width="200" />
<h1>Janosh</h1>

<address>
  <a href="https://github.com/janosh" target="_blank" rel="noreferrer">
    <Icon inline icon="octicon:mark-github" />
  </a>
  <a href="https://x.com/jrib_" target="_blank" rel="noreferrer">
    <Icon inline icon="bi:twitter-x" />
  </a>
  <a href="https://linkedin.com/in/janosh-riebesell/" target="_blank" rel="noreferrer">
    <Icon inline icon="bi:linkedin" />
  </a>
  <a href="mailto:{data.email}" target="_blank" rel="noreferrer">
    <Icon
      inline
      icon="mdi:email"
      width="1.4em"
      style="vertical-align: middle; transform: translateY(-2px)"
    />
  </a>
  <a href="/cv">
    <Icon inline icon="academicons:cv-square" style="transform: scale(1.1);" />
  </a>
</address>

<p style="max-width: min(40em, 80vw); margin: auto;">
  I'm interested in<br />
  <a href={mbd?.repo}>🔎 computational materials discovery&emsp;</a>
  <a href="https://arxiv.org/abs/2401.00096v1">🤖 machine learning</a><br />
  <a href={pmg?.repo}>💻 software engineering&emsp;</a>
  <a href={pmv?.repo}>📊 data</a> <a href={elementari?.repo}>visualization</a>.
  <!-- Outside of work, I enjoy hiking 🧗 and cycling 🚲. The rougher the terrain, the better! ⛰️ -->
</p>

<h2 class="section-title">
  <Icon inline icon="mdi:newspaper" />
  &nbsp;Recent
</h2>
<ul class="recent grid">
  {#each oss.projects.filter((p) => p.paper) as { name, repo, logo, paper: id, description } (name)}
    {@const paper = references.find((p) => p.id == id)}
    {@const date = Object.values(paper?.issued[0]).join(`-`)}
    {#if !paper}
      {@debug id}
    {/if}
    <li>
      <h3>
        <a href={repo}>
          <img src={logo} alt={name} />
          {name}
        </a>
        <small>[<a href={paper?.URL}>Paper</a>]</small>
      </h3>
      <time>{date}</time>
      {description}
    </li>
  {/each}
  <li>
    <h3>
      <img
        src="https://github.com/janosh/blog/assets/30958850/f545ac6e-255f-4242-a23a-7516df80c8e7"
        alt="DeepMind Logo"
      />
      DeepMind Talk
      <small>[<a href={GdmSLides} type="application/pdf">Slides</a>]</small>
    </h3>
    <time>2024-01-12</time>
    1h talk covering 3 PhD projects on ML-guided materials discovery & synthesis to SF+London
    DeepMind team.
  </li>
</ul>

<OpenSource />

<Physics />

<Posts />

<style>
  img[alt='me'] {
    border-radius: 50%;
    object-fit: cover;
    height: 10em;
    width: 10em;
    margin: 4em auto 0;
  }
  h1 {
    margin: 0;
  }
  :is(h2, p) {
    text-align: center;
    margin: 1em 2em;
  }
  address {
    display: flex;
    place-content: center;
    place-items: center;
    gap: 1em;
    font-size: 16pt;
    margin: 1em auto;
  }
  ul.recent h3 small {
    padding-left: 4pt;
    font-weight: 300;
  }
  ul.recent > li {
    background-color: rgba(255, 255, 255, 0.05);
    padding: 1ex 1em;
    border-radius: 4pt;
  }
  ul.recent > li > h3 :is(img, small) {
    margin-right: 5pt;
    vertical-align: middle;
    width: 3ex;
    transform: translateY(-1px);
  }
  time {
    display: block;
    font-size: small;
    margin: -4pt auto 1ex;
    font-weight: 300;
    background-color: rgba(0, 0, 0, 0.2);
    padding: 0 3pt;
    border-radius: 4pt;
    max-width: max-content;
  }
</style>
