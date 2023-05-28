---
title: No Non-sense Copy Buttons in SvelteKit
date: 2023-05-27
cover:
  img: no-nonsense-copy-button.svg
tags:
  - SvelteKit
  - Web Development
  - User Experience
  - Coding
---

<!-- also posted at https://github.com/pngwn/MDsveX/issues/385#issuecomment-1565811519 -->

In the age of LLMs, we've entered a copy-paste world. Anything you do 20 times a day should be automated. Manually selecting text in the browser only to have unintended scrolling or weird page flow mess up the selection gets old fast. And don't get me started on mobile devices! Nowadays any blog, docs, and technical writing worth its salt needs proper code block copy buttons!

Luckily, the lowest-effort solution turns out to also be the most robust here... like fixing your device by simply turning it off and on again. Robust in the sense that these copy buttons apply to both code blocks in markdown and in Svelte components (which are not processed by MSveX). The only downside is that they flash on page load. Might try to fix that another day.

## Cut to the Chase

If your site is built with SvelteKit (as this one is), go to your root `+layout.svelte` file. Many other frameworks will have an equivalent file that wraps the base of your component tree. Using the `afterNavigate` function from SvelteKit's `$app/navigation`, which fires on page load and again on every page navigation, we can easily make the required DOM manipulations to prefix every code block with a Svelte component that renders a copy button. I'll use `CopyButton from 'svelte-zoo'` here but feel free to roll your own.

```ts
import { CopyButton } from 'svelte-zoo'
import { afterNavigate } from '$app/navigation'

afterNavigate(() => {
  for (const node of document.querySelectorAll('pre > code')) {
    // skip if <pre> already contains a button (presumably for copy)
    const pre = node.parentElement
    if (!pre || pre.querySelector(`button`)) continue

    new CopyButton({
      target: pre,
      props: {
        content: node.textContent ?? '',
        style: 'position: absolute; top: 1ex; right: 1ex;',
      },
    })
  }
})
```

These dozen lines seek out all the code blocks on whatever page you load and insert a copy button. The code should demo itself. You can see the result on this very code block. Because we're using Svelte, we get some nice reactivity for free. Try pressing the button!

<details><summary>Button styles</summary>

```css
button {
  color: white;
  cursor: pointer;
  border: none;
  border-radius: 3pt;
  background-color: teal;
  padding: 2pt 4pt;
  font-size: 12pt;
  line-height: initial;
  transition: background-color 0.2s;
}
```

</details>

### Caveman Style

That's all there is to it in Svelte. But for completeness, let me cover the vanilla JS framework agnostic version. Here's how to insert a copy button imperatively:

```ts
afterNavigate(() => {
  for (const node of document.querySelectorAll('pre > code')) {
    const pre = node.parentElement
    if (!pre || pre.querySelector(`button`)) continue

    const button = document.createElement('button')
    button.textContent = 'Copy'
    button.className = 'copy-button'

    button.onclick = () => navigator.clipboard.writeText(node.textContent ?? '')

    node.parentNode?.prepend(button)
  }
})
```

### Caveman with Style

If you count yourself a sophisticated caveman, you may not want to forego a pretty SVG icon to decorate your copy button. I got you covered:

```ts
// anywhere after `const button = document.createElement('button')`

const svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg')
svg.setAttribute('width', '16')
svg.setAttribute('height', '16')
svg.setAttribute('viewBox', '0 0 16 16')

const use = document.createElementNS('http://www.w3.org/

2000/svg', 'use')
use.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', '#copy-icon')

svg.appendChild(use)
button.prepend(svg)
```

You'll need to make that SVG icon `xlink`able in your `app.html` (or whatever acts as the entry point for your app, from where the `<symbol>` is sure to be accessible):

```html
<svg style="display: none">
  <!-- https://icones.js.org/collection/all?s=octicon:copy-16 -->
  <symbol id="octicon-copy" fill="currentColor">
    <path
      d="M0 6.75C0 5.784.784 5 1.75 5h1.5a.75.75 0 0 1 0 1.5h-1.5a.25.25 0 0 0-.25.25v7.5c0 .138.112.25.25.25h7.5a.25.25 0 0 0 .25-.25v-1.5a.75.75 0 0 1 1.5 0v1.5A1.75 1.75 0 0 1 9.25 16h-7.5A1.75 1.75 0 0 1 0 14.25Z"
    />
    <path
      d="M5 1.75C5 .784 5.784 0 6.75 0h7.5C15.216 0 16 .784 16 1.75v7.5A1.75 1.75 0 0 1 14.25 11h-7.5A1.75 1.75 0 0 1 5 9.25Zm1.75-.25a.25.25 0 0 0-.25.25v7.5c0 .138.112.25.25.25h7.5a.25.25 0 0 0 .25-.25v-7.5a.25.25 0 0 0-.25-.25Z"
    />
  </symbol>
</svg>
```
