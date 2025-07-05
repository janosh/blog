---
title: Svelte Action to Highlight Matching Text
date: 2024-01-28
cover:
  img: svelte-highlight-text-match-action.svg
tags:
  - Svelte
  - Web Dev
  - CSS
  - JavaScript
  - HTML
---

<script>
  import { highlight_matches } from 'svelte-multiselect/attachments'

  let query = 'adipisicing'
  // must match the name passed to ::highlight() in below, defaults to 'highlight-match'
  const css_class = 'highlight-match'
</script>

I like the Svelte action API for how neatly it packages up modular functionality, like a power-up to HTML that nonetheless feels native, perhaps because it keeps your markup clean.
The use case to highlight text matching a search query string comes up a lot so I'd like to share this `highlight_matches` action as an especially neat example of how to combine Svelte's minimal syntax with the GPU-accelerated power of the CSS Custom Highlight API (supported by all major browsers and easily scales to very long texts) to achieve a performant drop-in solution for highlighting text matches.

## Demo

Here's a simple Svelte component that uses this action:

Type a query: <input bind:value={query} />

<blockquote use:highlight_matches={{ query, css_class }}>
  Lorem ipsum dolor sit amet consectetur adipisicing elit. Facilis nihil excepturi in earum reiciendis perferendis eveniet eum repudiandae! Assumenda dolorem numquam ullam cum vel ad voluptates voluptatum corporis id vero.
  Reprehenderit quibusdam, incidunt natus sequi officiis perferendis ullam est ea, sed officia dolores similique consequatur reiciendis, voluptatibus vero. Assumenda vero repellendus sit, id possimus consequatur accusantium sint minus voluptatum exercitationem.
  Repudiandae consectetur, eius odio esse perspiciatis dolores magnam quia et animi reiciendis, aperiam id a delectus, beatae porro voluptates commodi nesciunt praesentium modi molestiae maiores deleniti? Ab veritatis ducimus veniam.
  Ut, dolore eaque, animi quo unde ipsam praesentium veritatis nemo voluptate itaque laboriosam ullam vel fugiat explicabo. Tempora corporis, voluptas itaque, et soluta odio expedita natus tempore quis eveniet ipsum.
</blockquote>

<style>
  ::highlight(highlight-match) {
    color: mediumaquamarine;
    text-decoration: underline;
  }
</style>

```svelte example
<script>
  import { highlight_matches } from '$actions'

  let query = 'adipisicing'
  // must match the name passed to ::highlight() in below, defaults to 'highlight-match'
  const css_class = 'highlight-match'
</script>

Type a query: <input bind:value={query} />
<p use:highlight_matches={{ query, css_class }}>
  Lorem ipsum dolor sit amet consectetur adipisicing elit. Facilis nihil excepturi in
  earum reiciendis perferendis eveniet eum repudiandae! Assumenda dolorem numquam ullam
  cum vel ad voluptates voluptatum corporis id vero...
</p>

<style>
  ::highlight(highlight-match) {
    color: mediumaquamarine;
    text-decoration: underline;
  }
</style>
```

Any text context within the DOM node to which we pass `use:highlight_matches` (in this case `<p>`) will be highlighted when matching `query`. The `query` can be bound to an `<input>` or Svelte store and will be fully reactive.
Any matching text will get the CSS pseudo-class `::highlight(highlight-match)` and the corresponding style rules. Note that the [allowed properties for `::highlight()` are very limited](https://developer.mozilla.org/docs/Web/CSS/::highlight#allowable_properties) (but sufficient for highlighting text).

## Implementation

Like any Svelte action, `highlight_matches` takes an `HTMLElement` and an `options` object as parameters. The options object can include a `query` string, a `disabled` boolean, a `node_filter` function, and a `css_class` string (all optional, though of course, the action won't do anything if `query` is empty or `disabled` is true).

The `update_highlights` function is where the actual highlighting happens. It first clears any previous highlights. If the `query` is empty, `disabled` is true, or the CSS highlight API is not supported, it returns early.

Otherwise, we create a `TreeWalker` to iterate over all text nodes in the DOM subtree rooted at the given node. It finds matches of the query in each text node and creates a `Range` object for each match. Finally, it creates a `Highlight` object from the ranges and adds it to the CSS highlight registry.

Note that the action returns an object with an `update` which is needed to make it responsive to changes in the `query` string. Without it, the action would only run once on mount.

```ts
type HighlightOptions = {
  query?: string
  disabled?: boolean
  node_filter?: (node: Node) => number
  css_class?: string
}

export function highlight_matches(node: HTMLElement, ops: HighlightOptions) {
  update_highlights(node, ops)
  return {
    update: (ops: HighlightOptions) => update_highlights(node, ops),
  }
}

function update_highlights(node: Node, ops: HighlightOptions) {
  const {
    query = ``,
    disabled = false,
    node_filter = () => NodeFilter.FILTER_ACCEPT,
    css_class = `highlight-match`,
  } = ops

  // clear previous ranges from HighlightRegistry
  CSS.highlights.clear()

  if (!query || disabled || typeof CSS == `undefined` || !CSS.highlights) return // abort if CSS highlight API not supported

  const tree_walker = document.createTreeWalker(node, NodeFilter.SHOW_TEXT, {
    acceptNode: node_filter,
  })
  const text_nodes: Node[] = []
  let current_node = tree_walker.nextNode()
  while (current_node) {
    text_nodes.push(current_node)
    current_node = tree_walker.nextNode()
  }

  // iterate over all text nodes and find matches
  const ranges = text_nodes.map((el) => {
    const text = el.textContent?.toLowerCase()
    const indices = []
    let start_pos = 0
    while (text && start_pos < text.length) {
      const index = text.indexOf(query, start_pos)
      if (index === -1) break
      indices.push(index)
      start_pos = index + query.length
    }

    // create range object for each str found in the text node
    return indices.map((index) => {
      const range = new Range()
      range.setStart(el, index)
      range.setEnd(el, index + query?.length)
      return range
    })
  })

  // create Highlight object from ranges and add to registry
  CSS.highlights.set(css_class, new Highlight(...ranges.flat()))
}
```

## Update

I recently converted this action to an attachment in `svelte-multiselect` (`npm install svelte-multiselect`) and can now be used like this:

```svelte
<script>
  import { highlight_matches } from 'svelte-multiselect/attachments'

  let query = 'quick'
</script>

<p {@attach highlight_matches({ query, css_class: `highlight-match` })}>
  The quick brown fox jumps over the lazy dog
</p>
```
