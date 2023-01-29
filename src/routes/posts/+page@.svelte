<script lang="ts">
  import { repository } from '$root/package.json'
  import Icon from '@iconify/svelte'
  import type { PageServerData } from './$types'

  export let data: PageServerData
</script>

<img src="./blog-banner.svg" alt="Banner" />

<ul>
  {#each data.posts ?? [] as post}
    {@const { cover, slug, title, tags, date } = post}
    {@const href = `/posts/${slug}`}
    <li>
      <h3><a {href}>{title}</a></h3>
      {slug}
      <a {href}>
        <img
          src="{repository}/raw/main/src/routes/posts/{slug}/{cover.img}"
          alt={cover.src}
        />
      </a>
      <time>
        <Icon icon="carbon:calendar" inline />
        {date.split(`T`)[0]}
      </time>
      <small><Icon icon="carbon:tag" inline /> {tags.join(`, `)}</small>
    </li>
  {/each}
</ul>

<style>
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
