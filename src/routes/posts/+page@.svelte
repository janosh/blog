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

  const posts = (page.data?.posts ?? []) as FrontMatter[]
  const tag_counts = posts
    .flatMap((post) => post.tags)
    .reduce((acc: Record<string, number>, tag) => {
      acc[tag] = (acc[tag] ?? 0) + 1
      return acc
    }, {})
  const all_tags = (Object.entries(tag_counts) as [string, number][]).toSorted(
    ([, count_1], [, count_2]) => count_2 - count_1,
  )
  // check if any tags appear with different casing
  const seen_lower = new Set<string>()
  for (const [tag] of all_tags) {
    const lower = tag.toLowerCase()
    if (seen_lower.has(lower)) console.error(`Tag "${tag}" appears with different casing`)
    seen_lower.add(lower)
  }
  const top_tags = all_tags.slice(0, 15).toSorted()
  const local_covers = import.meta.glob<string>(`./*/*.{avif,jpg,jpeg,png,svg,webp}`, {
    eager: true,
    import: `default`,
  })

  const matches_active_tags = (post: FrontMatter): boolean =>
    active_tags.length === 0 ||
    active_tags.some(({ label }) => post.tags?.includes(label))

  const visible_posts = $derived(
    posts
      .filter(matches_active_tags)
      .toSorted((post_1, post_2) => post_2.date.localeCompare(post_1.date)),
  )
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
    {@const tag = option as Option}
    <span style="display: flex; gap: 5pt; align-items: center">
      {tag.label} <span style="flex: 1"></span>
      {tag.count}
    </span>
  {/snippet}
</Select>

<ul class="grid" style="margin: 4em auto; gap: 3ex">
  {#each visible_posts as post (post.title)}
    {@const { cover, slug, title, tags, date } = post}
    {@const href = `/posts/${slug}`}
    {@const cover_src =
      (dev && local_covers[`./${slug}/${cover.img}`]) ||
      `${repository}/raw/main/src/routes/posts/${slug}/${cover.img}`}
    <li animate:flip={{ duration: 400 }}>
      <h3><a {href}>{title}</a></h3>
      <a {href}>
        <img src={cover_src} alt={cover.caption} />
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
