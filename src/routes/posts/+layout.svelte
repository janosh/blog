<script lang="ts">
  import { cover_url } from '$lib'
  import { heading_anchors, Icon, PrevNext } from 'svelte-widgets'
  import { Calendar } from 'svelte-widgets/icons'
  import type { LayoutProps } from './$types'

  let { data, children }: LayoutProps = $props()

  let { title, cover, date, slug } = $derived(data.post)
</script>

<img src={cover_url(`posts`, slug, cover.img)} alt={cover.caption ?? title} />

<main style="max-width: 50em; margin: 0 auto" {@attach heading_anchors()}>
  <h1>{title}</h1>
  <time>
    <Icon icon={Calendar} />
    {date.split(`T`)[0]}
  </time>
  {@render children()}

  <br />
  <PrevNext
    items={data.posts.map((post) => ({ ...post, href: post.slug, label: post.title }))}
    current={slug}
  >
    {#snippet children({ item, kind })}
      {@const { href, label, date } = item}
      <h3 class="toc-exclude">
        <a {href}>
          {kind === `next` ? `Next →` : `← Previous`}
          <br />
          <small>{label}</small>
        </a>
        <br />
        <time>{date.split(`T`)[0]}</time>
      </h3>
    {/snippet}
  </PrevNext>
</main>

<style>
  img {
    margin: 0;
    height: 50vh;
    width: 100%;
    object-fit: cover;
    background: linear-gradient(-45deg, var(--card-bg), var(--nav-bg), var(--border));
  }
  time {
    font-weight: lighter;
    font-size: 10pt;
    text-align: center;
    display: block;
  }
</style>
