<script lang="ts">
  import Icon from '@iconify/svelte'
  import Physics from './physics/+page@.md'
  import Posts from './posts/+page@.svelte'
</script>

<img src="./janosh.jpg" alt="me" width="200" />
<h1>Janosh</h1>

<p>
  I'm interested in computational materials discovery, machine learning, software
  engineering & data viz.
</p>

<strong>
  Check out <a href="https://matbench-discovery.materialsproject.org">
    matbench-discovery.materialsproject.org
  </a>
  <br />
  A new framework to evaluate ML energy models on materials stability prediction from unrelaxed
  crystals
</strong>

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
    <Icon inline icon="bi:envelope" />
  </a>
</address>

<h2>Notes on Physics</h2>

<Physics />

<h2>Posts</h2>

<Posts />

<style>
  img[alt='me'] {
    border-radius: 50%;
    object-fit: cover;
    height: 10em;
    width: 10em;
    margin: 1em auto 0;
  }
  h1 {
    margin: 0;
  }
  :is(h2, p) {
    text-align: center;
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
    margin: 2em auto 3em;
    background-color: darkcyan;
    padding: 2pt 9pt;
    border-radius: 9pt;
    max-width: 500px;
  }
  strong a {
    color: #191960;
    text-decoration: none;
  }
</style>
