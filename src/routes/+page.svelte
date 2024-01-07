<script lang="ts">
  import Icon from '@iconify/svelte'
  import cv from './cv/cv.yml'
  import OpenSource from './open-source/+page.svelte'
  import Physics from './physics/+page@.md'
  import Posts from './posts/+page@.svelte'

  const chgnet = cv.projects.find((p) => p.name === `CHGNet`)
  const mbd = cv.projects.find((p) => p.name === `Matbench Discovery`)
  const pmv = cv.projects.find((p) => p.name === `pymatviz`)
  const pmg = cv.projects.find((p) => p.name === `pymatgen`)
  const mace = cv.projects.find((p) => p.name === `MACE`)
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
  <a href="mailto:janosh.riebesell@gmail.com" target="_blank" rel="noreferrer">
    <Icon
      inline
      icon="mdi:email"
      width="1.4em"
      style="vertical-align: middle; transform: translateY(-2px)"
    />
  </a>
</address>

<p style="max-width: min(40em, 80vw); margin: auto;">
  I work on
  <a href={mbd?.repo}>🔎 computational materials discovery</a>,
  <a href={mace?.paper}>🤖 machine learning</a>,
  <a href={pmg?.repo}>💻 software engineering</a>, &
  <a href={pmv?.repo}>📊 data visualization</a>.<br />
  <!-- Outside of work, I enjoy hiking 🧗 and cycling 🚲. The rougher the terrain, the better! ⛰️ -->
</p>

<h2 class="section-title" style="margin: 1em auto 0;">
  <Icon inline icon="octicon:repo" />
  &nbsp;Recent Projects
</h2>
<ul class="recent grid">
  <li>
    <h3>
      <a href={mbd?.repo}>
        <img src="{mbd?.url}/favicon.svg" alt={mbd?.name} />
        Matbench Discovery
      </a>
      <small>[<a href={mbd?.paper}>arXiv</a>]</small>
    </h3>
    A new framework to evaluate ML energy models on materials stability prediction from unrelaxed
    crystals.
  </li>
  <li>
    <h3>
      <a href={mace?.paper}>
        <img src={mace?.logo} alt={mace?.name} />
        MACE Foundation Model
      </a>
    </h3>
    A versatile ML force field capable of a wide range of chemistry simulations and property
    predictions.
  </li>
  <li>
    <h3>
      <a href={chgnet?.repo}>
        <img src="{chgnet?.url}/favicon.svg" alt={chgnet?.name} />
        CHGNet
      </a>
      <small>[<a href={chgnet?.paper}>NMI</a>]</small>
    </h3>
    Pretrained universal neural network potential for charge-informed atomistic modeling. Paper:
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
  ul.recent > li > h3 {
    margin: 0 0 1ex;
    display: flex;
    place-content: center;
    place-items: center;
  }
  ul.recent > li > h3 :is(img, small) {
    margin-right: 5pt;
    vertical-align: middle;
    width: 3ex;
  }
</style>
