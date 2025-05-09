<script lang="ts">
  import { dev } from '$app/environment'
  import { page } from '$app/state'
  import type { FrontMatter } from '$lib'
  import { repository } from '$root/package.json'
  import Icon from '@iconify/svelte'
  import Select from 'svelte-multiselect'
  import { flip } from 'svelte/animate'

  type Option = { label: string; count: number }
  let active_tags: Option[] = $state([])

  const tag_counts = page.data?.posts
    ?.flatMap((post) => post.tags)
    .reduce((acc, tag) => {
      acc[tag] = (acc[tag] ?? 0) + 1
      return acc
    }, {})
  // keep only most frequent tags
  const all_tags = (Object.entries(tag_counts) as [string, number][]).sort(
    ([, count_1], [, count_2]) => count_2 - count_1,
  )
  // check if any tag appear with different casing (start inner loop at i + 1)
  for (let ii = 0; ii < all_tags.length; ii++) {
    const [tag_1] = all_tags[ii]
    for (let jj = ii + 1; jj < all_tags.length; jj++) {
      const [tag_2] = all_tags[jj]
      if (tag_1.toLowerCase() === tag_2.toLowerCase()) {
        console.error(`Tag "${tag_1}" appears with different casing`)
      }
    }
  }
  const top_tags = all_tags.slice(0, 15).sort()
  const has_active_tags = (active_tags: Option[]) => (post: FrontMatter) => {
    return (
      active_tags.length === 0 ||
      active_tags.some(({ label }) => post.tags?.includes(label))
    )
  }
</script>

<img src="./blog-banner.svg" alt="Banner" class="banner" />

<h2 class="section-title">
  <Icon inline icon="ri:article-line" />
  Posts
</h2>

<Select
  options={top_tags.map(([label, count]) => ({ label, count }))}
  placeholder="Filter by tag"
  bind:selected={active_tags}
  closeDropdownOnSelect
>
  {#snippet option({ option })}
    <span   style="display: flex; gap: 5pt; align-items: center;">
      {option.label} <span style="flex: 1;"></span>
      {option.count}
    </span>
  {/snippet}
</Select>

<ul class="grid" style="margin: 4em auto; gap: 3ex;">
  {#each page.data?.posts
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
  <li style="visibility: hidden;"></li>
  <li style="visibility: hidden;"></li>
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
    background: linear-gradient(-45deg, #5a6323, #2a355e, #642626);
  }
  :global(div.multiselect) {
    max-width: 20em !important;
    margin: 0 auto -1em !important;
    border: 1pt solid #666 !important;
  }
</style>
