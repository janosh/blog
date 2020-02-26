---
title: Sticky Active Smooth Responsive ToC
slug: /sticky-active-smooth-responsive-toc
date: 2019-06-11
cover:
  img: desk-toc.jpg
tags:
  - Design
  - JS
  - Tutorial
  - Web Dev
showToc: true
---

## Intro

This is a guide on how to implement a sticky, active, smooth and responsive table of contents (ToC) in a mere 80 lines of JavaScript (styles excluded) using [React](https://reactjs.org) and [styled-components](https://styled-components.com). A ToC is particularly useful for longer pages with lots of headings where it allows readers to see their place in the document and quickly jump to other sections. This post is too short for it to make much sense. I added it anyway just to demonstrate. If you want to try it out in a setting where it's more at home, check out [this introduction to Hamiltonian Monte Carlo](/blog/hmc-intro).

[![HMC Intro](/hmc-toc.png)](/blog/hmc-intro)

Just so we're on the same page, here are two important points.

1. The component assumes that all headings you want to list in the ToC can be targeted by one or several CSS selectors which the component passes into [`document.querySelectorAll`](https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelectorAll). By default it uses `['main h1', 'main h2', ..., 'main h6']`. Also, you should be able to provide `getTitle` and `getDepth` functions to obtain the title and depth of a heading given it's DOM node. (The latter is not essential if you're happy with a flat ToC, i.e. one that doesn't indent lower-level headings.) The default values are `getTitle = node => node.innerText` and `getDepth = node => Number(node.nodeName[1])` (since with the default CSS selector, `nodeName` will be one of `H[1-6]`).

2. This is what each of the words in the unwieldy title mean:

   - **Responsive**: The ToC is displayed in a column to the right of the text if the screen width permits or as a small book icon in the lower left corner on narrow screens. In that case, the component expands to show the full ToC when that icon is clicked.
   - **Sticky**: The ToC scrolls with the viewport below a certain threshold on the page to always remain easily accessible as you progress through the document.
   - **Active**: The ToC highlights the heading that's closest to the reader's current position to act as a "progress bar", i.e. give an idea how far through the document you've progressed.
   - **Smooth**: When a user clicks a heading in the ToC, the viewport smoothly scrolls there (without adding to the browser history, i.e. clicking the back button will always send the reader back to the previous page).

Alright, enough talking! Here comes the code.

## Implementation

```js:title=src/components/toc/index.js
import React, { useRef, useState, useEffect } from 'react'
import { throttle } from 'lodash'

// A hook to close the ToC if it's currently in an open state
// and close it, when the user clicks or touches somewhere
// outside the component (only used on small screens).
import { useOnClickOutside } from 'hooks'
// Import styled components (see the Styles section below).
import { TocDiv, TocLink, TocIcon, Title, Toggle } from './styles'

// Used to calculate each heading's offset from the top of the page.
// This will be compared to window.scrollY to determine which heading
// is currently active.
const accumulateOffsetTop = (el, totalOffset = 0) => {
  while (el) {
    totalOffset += el.offsetTop - el.scrollTop + el.clientTop
    el = el.offsetParent
  }
  return totalOffset
}

export default function Toc({ headingSelector, getTitle, getDepth, ...rest }) {
  const { throttleTime = 200, tocTitle = `Contents` } = rest
  // headingSelector: string or array of strings
  // getTitle: function
  // getDepth: function
  // tocTitle: string
  // All Toc props optional.
  const [headings, setHeadings] = useState({
    titles: [],
    nodes: [],
    minDepth: 0,
  })
  // Controls whether ToC is expanded or closed on small screens.
  const [open, setOpen] = useState(false)
  // Controls which heading is currently highlighted as active.
  const [active, setActive] = useState()
  // The ref is attached to the top-level div (TocDiv) and is
  // used to determine if the user clicked outside the ToC.
  const ref = useRef()
  useOnClickOutside(ref, () => setOpen(false))
  // Read heading titles, depths and nodes from the DOM.
  useEffect(() => {
    // Fallback to sensible defaults for headingSelector, getTitle and getDepth
    // inside useEffect rather than specifying them as Toc default props to avoid
    // the need for useMemo and useCallback, resp.
    // Otherwise, these would change on every render and since this effect calls
    // setHeadings which triggers a rerender, it would cause an infinite loop.

    // The default selector targets all headings (h1, h2, ..., h6) inside
    // a main element. You can pass in whatever string or array of strings
    // targets all the headings you want to appear in the ToC.
    const selector =
      headingSelector || Array.from({ length: 6 }, (_, i) => `main h` + (i + 1))
    const nodes = Array.from(document.querySelectorAll(selector))
    const titles = nodes.map(node => ({
      title: getTitle ? getTitle(node) : node.innerText,
      depth: getDepth ? getDepth(node) : Number(node.nodeName[1]),
    }))
    // Compute the minimum heading depth. Will be subtracted from each heading's
    // depth to determine the indentation of that heading in the ToC.
    const minDepth = Math.min(...titles.map(h => h.depth))
    setHeadings({ titles, nodes, minDepth })
  }, [headingSelector, getTitle, getDepth])

  // Add scroll event listener to update currently active heading.
  useEffect(() => {
    // Throttling the scrollHandler saves computation and hence battery life.
    const scrollHandler = throttle(() => {
      const { titles, nodes } = headings
      // Offsets need to be recomputed inside scrollHandler because
      // lazily-loaded content increases offsets as user scrolls down.
      const offsets = nodes.map(el => accumulateOffsetTop(el))
      const activeIndex = offsets.findIndex(
        offset => offset > window.scrollY + 0.8 * window.innerHeight
      )
      setActive(activeIndex === -1 ? titles.length - 1 : activeIndex - 1)
    }, throttleTime)

    window.addEventListener(`scroll`, scrollHandler)
    return () => window.removeEventListener(`scroll`, scrollHandler)
  }, [headings])

  return (
    <>
      <Toggle opener open={open} onClick={() => setOpen(true)} size="1.6em" />
      <TocDiv ref={ref} open={open}>
        <Title>
          <TocIcon />
          {tocTitle || `Contents`}
          <Toggle closer onClick={() => setOpen(false)} />
        </Title>
        <nav>
          {headings.titles.map(({ title, depth }, index) => (
            <TocLink
              key={title}
              active={active === index}
              depth={depth - headings.minDepth}
              onClick={event => {
                event.preventDefault()
                setOpen(false)
                headings.nodes[index].scrollIntoView({
                  behavior: `smooth`,
                  block: `center`,
                })
              }}
            >
              {title}
            </TocLink>
          ))}
        </nav>
      </TocDiv>
    </>
  )
}
```

And here's the `useOnClickOutside` hook.

```js:title=src/hooks/useOnClickOutside.js
import { useEffect } from 'react'

export const useOnClickOutside = (ref, handler, events) => {
  if (!events) events = [`mousedown`, `touchstart`]
  useEffect(() => {
    const detectClickOutside = event =>
      !ref.current.contains(event.target) && handler()
    for (const event of events) document.addEventListener(event, detectClickOutside)
    return () => {
      for (const event of events)
        document.removeEventListener(event, detectClickOutside)
    }
  }, [ref, handler, events])
}
```

## Styles

I include the styles here mostly for completeness and in case you're also using `styled-components`. You can boil these down some if you don't need the component to be responsive or adjust to your site's dark theme.

```js:title=src/components/toc/styles.js
import styled, { css } from 'styled-components'
import { BookContent } from 'styled-icons/boxicons-regular/BookContent'
import { Close as Cross } from 'styled-icons/material/Close'
import mediaQuery from 'utils/mediaQuery'

const openTocDiv = css`
  background: ${props => props.theme.background};
  color: ${props => props.theme.textColor};
  padding: 0.7em 1.2em;
  border-radius: 0.5em;
  box-shadow: 0 0 1em rgba(0, 0, 0, 0.5);
  border: 1px solid ${props => props.theme.borderColor};
`

export const TocDiv = styled.div`
  height: max-content;
  max-height: 80vh;
  z-index: 3;
  line-height: 2em;
  right: 1em;
  max-width: 20em;
  overscroll-behavior: none;
  nav {
    max-height: 78vh;
    overflow-y: scroll;
  }
  ${mediaQuery.maxLaptop} {
    position: fixed;
    bottom: 1em;
    left: 1em;
    ${props => !props.open && `height: 0;`};
    ${props => props.open && openTocDiv};
    visibility: ${props => (props.open ? `visible` : `hidden`)};
    opacity: ${props => (props.open ? 1 : 0)};
    transition: 0.3s;
  }
  ${mediaQuery.minLaptop} {
    font-size: 0.85em;
    grid-column: 4 / -1;
    position: sticky;
    top: 2em;
  }
`

export const Title = styled.h2`
  margin: 0;
  padding-bottom: 0.5em;
  display: grid;
  grid-auto-flow: column;
  align-items: center;
  grid-template-columns: auto auto 1fr;
`

export const TocLink = styled.a`
  color: ${({ theme, active }) => (active ? theme.linkColor : theme.textColor)};
  font-weight: ${props => props.active && `bold`};
  display: block;
  margin-left: ${props => props.depth + `em`};
  border-top: ${props =>
    props.depth === 0 && `1px solid ` + props.theme.lighterGray};
`

export const TocIcon = styled(BookContent)`
  width: 1em;
  margin-right: 0.2em;
`

const openedCss = css`
  position: fixed;
  bottom: calc(1vh + 4em);
  ${mediaQuery.minPhablet} {
    bottom: calc(1vh + 1em);
  }
  left: 0;
  padding: 0.5em 0.6em 0.5em 0.3em;
  background: ${props => props.theme.background};
  border: 2px solid ${props => props.theme.borderColor};
  border-radius: 0 50% 50% 0;
  transform: translate(${props => (props.open ? `-100%` : 0)});
`

const closedCss = css`
  margin-left: 1em;
  border: 1px solid ${props => props.theme.borderColor};
  border-radius: 50%;
`

export const TocToggle = styled(Cross).attrs(props => ({
  as: props.opener && BookContent,
  size: props.size || `1.6em`,
}))`
  z-index: 2;
  transition: 0.3s;
  justify-self: end;
  :hover {
    transform: scale(1.1);
  }
  ${mediaQuery.minLaptop} {
    display: none;
  }
  ${props => (props.opener ? openedCss : closedCss)};
`
```

## Closing Remarks

That's all. It took quite a bit less code than I expected when I started writing this component considering the list of requirements I wanted to implement. I think that's another testament to the hooks API. It's been a big step towards making React even more modular, composable and compact.

As implemented, the ToC does not update when adding new headings to a page after the page has loaded. In most cases, pages are static once the user has loaded them so there's no point in wasting CPU cycles on a DOM observer. But just in case your ToC should update to include new headings even while the user is viewing a page, you might want to take a look the [MutationObserver](https://developer.mozilla.org/docs/Web/API/MutationObserver) ([with excellent browser support](https://caniuse.com/#feat=mutationobserver)).

Let me know in the comments how the component works for you or if you have questions!
