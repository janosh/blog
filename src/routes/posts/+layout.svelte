<script lang="ts">
  import { Cover } from '#lib'
  import { heading_anchors, Icon, PrevNext } from 'svelte-widgets'
  import { Calendar } from 'svelte-widgets/icons'
  import type { LayoutProps } from './$types'

  let { data, children }: LayoutProps = $props()

  let { title, date, slug } = $derived(data.frontmatter)
</script>

<Cover section="posts" {...data.frontmatter} --cover-height="50vh" />

<main style="max-width: 50em; margin: 0 auto" {@attach heading_anchors()}>
  <h1>{title}</h1>
  <time>
    <Icon icon={Calendar} />
    {date}
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
        <time>{date}</time>
      </h3>
    {/snippet}
  </PrevNext>
</main>

<style>
  time {
    font-weight: lighter;
    font-size: 10pt;
    text-align: center;
    display: block;
  }
</style>
