<script lang="ts">
  import { repository } from '$root/package.json'
  import Icon from '@iconify/svelte'
  import type { PageServerData } from './$types'
  import Physics from './physics/+page@.svx'

  export let data: PageServerData
</script>

<img src="./janosh.jpg" alt="me" width="200" />

<h1>Janosh Riebesell</h1>

<p>
  I'm interested in computational materials discovery, machine learning, software
  engineering & data viz.
</p>

<address>
  <a href={repository}>
    <Icon inline icon="octicon:mark-github" />
  </a>
  <a href="https://twitter.com/_jrib">
    <Icon inline icon="logos:twitter" />
  </a>
  <a href="https://linkedin.com/in/janosh-riebesell/">
    <Icon inline icon="bi:linkedin" />
  </a>
  <a href="mailto:janosh.riebesell@gmail.com">
    <Icon inline icon="bi:envelope" />
  </a>
</address>

<h2>Physics Notes</h2>

<Physics />

<h2>Posts</h2>

<img src="./blog-banner.svg" alt="Banner" />

<ul>
  {#each data.posts as post}
    {@const href = `/posts/${post.slug}`}
    <li>
      <h3><a {href}>{post.title}</a></h3>
      <a {href}>
        <img src={post.cover.src} alt={post.cover.src} />
      </a>
      <time>
        <Icon icon="carbon:calendar" inline />
        {new Date(post.date).toISOString().split(`T`)[0]}
      </time>
      <small><Icon icon="carbon:tag" inline /> {post.tags.join(`, `)}</small>
    </li>
  {/each}
</ul>

<style>
  img[alt='me'] {
    border-radius: 50%;
    object-fit: cover;
    height: 10em;
    width: 10em;
    margin: 1em auto;
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
  ul {
    display: grid;
    gap: 2em;
    place-content: center;
    grid-template-columns: repeat(auto-fit, minmax(18em, 1fr));
    list-style: none;
    max-width: min(90vw, 65em);
    margin: 4em auto;
  }
  ul > li {
    display: grid;
    align-content: space-between;
  }
  ul > li > h3 {
    margin: 0;
    font-size: 14pt;
    text-overflow: ellipsis;
    white-space: nowrap;
    overflow: hidden;
  }
  ul > li > a > img {
    border-radius: 2pt;
    object-fit: cover;
    height: 10em;
  }
</style>
