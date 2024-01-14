<script lang="ts">
  import { dev } from '$app/environment'
  import { page } from '$app/stores'
  import type { FrontMatter } from '$lib'
  import { repository } from '$root/package.json'
  import Icon from '@iconify/svelte'
  import Select from 'svelte-multiselect'
  import { flip } from 'svelte/animate'

  let active_tags: string[] = []

  const tag_counts = $page.data?.posts
    ?.flatMap((post) => post.tags)
    .reduce((acc, tag) => {
      acc[tag] = (acc[tag] ?? 0) + 1
      return acc
    }, {})
  // keep only most frequent tags
  const all_tags = (Object.entries(tag_counts) as [string, number][])
    .sort(([, count_1], [, count_2]) => count_2 - count_1)
    .slice(0, 15)
    .map(([tag]) => tag)
    .sort()
  const has_active_tags = (active_tags: string[]) => (post: FrontMatter) => {
    return active_tags.length === 0 || post.tags?.some((tag) => active_tags.includes(tag))
  }
</script>

<section class="landing">
  <img src="./blog-banner.svg" alt="Banner" style="margin: 2em 0 0;" />

  <h2 class="section-title">
    <Icon inline icon="ri:article-line" />
    Posts
  </h2>

  <Select
    options={all_tags}
    placeholder="Filter by tag"
    bind:selected={active_tags}
    closeDropdownOnSelect
  />

  <ul>
    {#each $page.data?.posts
      ?.filter(has_active_tags(active_tags))
      .sort((post_1, post_2) => {
        return post_2.date.localeCompare(post_1.date) // sort by date descending
      }) ?? [] as post (post.title)}
      {@const { cover, slug, title, tags, date } = post}
      {@const href = `/posts/${slug}`}
      <li animate:flip={{ duration: 400 }}>
        <h3><a {href}>{title}</a></h3>
        <a {href}>
          {#if dev}
            {#await import(`./${slug}/${cover?.img?.replace(`.svg`, ``)}.svg`) then { default: src }}
              <img {src} alt={title} />
            {/await}
          {:else}
            <img
              src="{repository}/raw/main/src/routes/posts/{slug}/{cover.img}"
              alt={cover.caption}
            />
          {/if}
        </a>
        <small>
          <time>
            <Icon icon="carbon:calendar" inline />
            {date?.split(`T`)[0]}
          </time>
        </small>
        <small><Icon icon="carbon:tag" inline /> {tags?.join(`, `)}</small>
      </li>
    {/each}
  </ul>
</section>

<style>
  ul {
    display: grid;
    gap: 2em;
    place-content: center;
    grid-template-columns: repeat(auto-fit, minmax(18em, 1fr));
    list-style: none;
    max-width: min(90vw, 65em);
    margin: 4em 0;
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
    width: 100%;
    background: linear-gradient(-45deg, #5a6323, #2a355e, #642626);
  }
  :global(div.multiselect) {
    max-width: 20em !important;
    margin: 0 auto -1em !important;
    border: 1pt solid #666 !important;
  }
</style>
