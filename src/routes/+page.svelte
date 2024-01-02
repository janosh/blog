<script lang="ts">
  import Icon from '@iconify/svelte'
  import Physics from './physics/+page@.md'
  import Posts from './posts/+page@.svelte'

  const urls = {
    mbd: `https://matbench-discovery.materialsproject.org`,
    mbd_arxiv: `https://arxiv.org/abs/2308.14920`,
    mace: `https://arxiv.org/abs/2401.00096`,
    pmg: `https://github.com/materialsproject/pymatgen`,
    pmv: `https://github.com/janosh/pymatviz`,
  }
</script>

<img src="./janosh.jpg" alt="me" width="200" />
<h1>Janosh</h1>

<p>
  I work on <a href={urls.mbd}>computational materials discovery 🔎</a>,
  <a href={urls.mace}>machine learning 🤖</a>,
  <a href={urls.pmg}>software engineering 💻</a>, &
  <a href={urls.pmv}>data visualization 📊</a>.<br />
  Outside of work, I enjoy hiking 🧗 and cycling 🚲. The rougher the terrain, the better! ⛰️
</p>

<strong>My latest work</strong>
<ul>
  <li>
    <h3>
      <a href={urls.mbd}>Matbench Discovery</a>
      <span style="font-weight: lighter;">[<a href={urls.mbd_arxiv}>arXiv</a>]</span>
    </h3>
    A new framework to evaluate ML energy models on materials stability prediction from unrelaxed
    crystals
  </li>
  <li>
    <h3><a href={urls.mace}>MACE-MP Foundation Model</a></h3>
    A versatile ML force field capable of a wide range of chemistry simulations and property
    predictions.
  </li>
</ul>

<address>
  <a href="https://github.com/janosh" target="_blank" rel="noreferrer">
    <Icon inline icon="octicon:mark-github" />
  </a>
  <a href="https://twitter.com/_jrib" target="_blank" rel="noreferrer">
    <Icon inline icon="logos:twitter" />
  </a>
  <a href="https://linkedin.com/in/janosh-riebesell/" target="_blank" rel="noreferrer">
    <Icon inline icon="bi:linkedin" />
  </a>
  <a href="mailto:janosh.riebesell@gmail.com" target="_blank" rel="noreferrer">
    <Icon inline icon="mdi:email" width="1.35em" style="vertical-align: middle;" />
  </a>
</address>

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
  }
  strong {
    text-align: center;
    color: #eee;
    margin: 2em auto auto;
    background-color: darkcyan;
    padding: 2pt 8pt;
    border-radius: 8pt;
  }
  ul {
    display: flex;
    place-content: center;
    gap: 1em;
    margin: 2em auto;
    flex-wrap: wrap;
    list-style: none;
    max-width: calc(100vw - 4em);
    padding: 0;
  }
  ul > li {
    background-color: rgba(255, 255, 255, 0.05);
    padding: 1ex 1em;
    border-radius: 4pt;
    max-width: 300px;
  }
  ul > li > h3 {
    margin: 0 0 1ex;
  }
</style>
