<script lang="ts">
  import { cover_url } from '$lib'
  import { Icon, MultiSelect } from 'svelte-widgets'
  import { Article, Calendar, Tag } from 'svelte-widgets/icons'
  import { flip } from 'svelte/animate'
  import type { PageProps } from './$types'

  const { data }: PageProps = $props()

  let active_tags: typeof data.top_tags = $state([])
  const visible_posts = $derived(
    data.posts.filter(
      ({ tags }) =>
        active_tags.length === 0 || active_tags.some(({ label }) => tags.includes(label)),
    ),
  )
</script>

<img src="./blog-banner.svg" alt="Banner" class="banner" />

<h2 id="posts" class="section-title">
  <Icon icon={Article} />
  Posts
</h2>

<MultiSelect
  options={data.top_tags}
  placeholder="Filter by tag"
  bind:value={active_tags}
  close_dropdown_on_select
>
  {#snippet option({ option: { label, count } })}
    <span style="display: flex; gap: 5pt; align-items: center">
      {label} <span style="flex: 1"></span>
      {count}
    </span>
  {/snippet}
</MultiSelect>

<ul class="grid" style="margin: 4em auto; gap: 3ex">
  {#each visible_posts as { cover, slug, title, tags, date } (slug)}
    {@const href = `/posts/${slug}`}
    <li animate:flip={{ duration: 400 }}>
      <h3><a {href}>{title}</a></h3>
      <a {href}>
        <img
          src={cover_url(`posts`, slug, cover.img)}
          alt={cover.caption ?? title}
          loading="lazy"
          decoding="async"
        />
      </a>
      <small>
        <time>
          <Icon icon={Calendar} />
          {date.split(`T`)[0]}
        </time>
      </small>
      <small><Icon icon={Tag} /> {tags.join(`, `)}</small>
    </li>
  {/each}
  <li style="visibility: hidden"></li>
  <li style="visibility: hidden"></li>
</ul>

<style>
  ul > li {
    display: grid;
    align-content: space-between;
    grid-row: span 4;
    grid-template-rows: subgrid;
    gap: 2pt;
  }
  ul > li > h3 {
    margin: 0;
    font-size: 14pt;
    text-overflow: ellipsis;
    overflow: hidden;
    text-align: center;
    align-self: end;
  }
  ul > li > h3 > a {
    color: inherit;
  }
  ul > li > a > img {
    border-radius: 2pt;
    object-fit: cover;
    height: 10em;
    width: 100%;
    background: linear-gradient(-45deg, var(--card-bg), var(--nav-bg), var(--border));
  }
  :global(div.multiselect) {
    max-width: 20em !important;
    margin: 0 auto -1em !important;
    border: 1pt solid var(--border) !important;
  }
</style>
