<script lang="ts">
  import Icon from '@iconify/svelte'
  import type { FrontMatter } from './types'

  export let prev: FrontMatter
  export let next: FrontMatter
</script>

<ul>
  <li>
    <h3>
      <a href={prev.slug}>
        <Icon icon="carbon:previous-filled" inline />
        Previous
        <br />
        <small>{prev.title}</small>
      </a>
      <br />
      <time>{new Date(prev.date).toLocaleString().split(`,`)[0]}</time>
    </h3>
  </li>
  <a href="/" aria-label="Back to index page">
    <Icon icon="simple-icons:homeassistant" inline />
    back to home
  </a>
  <li style="text-align: right;">
    <h3>
      <a href={next.slug}>
        Next
        <Icon icon="carbon:next-filled" inline />
        <br />
        <small>{next.title}</small>
      </a>
      <br />
      <time>{new Date(next.date).toLocaleString().split(`,`)[0]}</time>
    </h3>
  </li>
</ul>

<style>
  ul {
    display: flex;
    list-style: none;
    padding: 0;
    place-content: space-between;
    gap: 2em;
    margin: 3em 0;
    position: relative;
  }
  ul > li {
    display: flex;
    flex-direction: column;
  }
  a[href='/'] {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    font-size: 15pt;
    padding: 1pt 5pt;
    border-radius: 3pt;
    transition: 0.2s;
  }

  time {
    font-weight: lighter;
    font-size: 10pt;
  }
</style>
