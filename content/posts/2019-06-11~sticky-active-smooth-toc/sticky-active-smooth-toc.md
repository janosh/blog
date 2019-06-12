---
title: Sticky Active Smooth Responsive ToC
slug: /sticky-active-smooth-responsive-toc
date: 2019-06-11
cover:
  img: hmc-toc.jpg
tags:
  - Design
  - JS
  - Tutorial
  - Web Dev
showToc: true
---

## Intro

In this post, I'll walk you through how to implement a sticky, active, smooth and responsive table of contents in less than 100 lines of JavaScript (excluding the styles) using [React](https://reactjs.org) and [styled-components](https://styled-components.com). This component is particularly useful on longer pages where it allows visitors to both see where on the page they currently are as well as quickly jump to other sections. This post is too short for it to make a lot of sense here but I added it for the purposes of demonstration anyway. If you want to see a post where it's more at home, check out [this introduction to Hamiltonian Monte Carlo](/blog/hmc-intro).

[![HMC Intro](/hmc-toc.png)](/blog/hmc-intro)

Just so we're on the same page, here are two important points.

1. Firstly the component assumes that all the headings you want to list in the ToC can be targeted by a CSS selector or array of CSS selectors which is passed into [`document.querySelectorAll`](https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelectorAll). By default it uses ``[`main h1`, `main h2`, ..., `main h6`]``. Also, you should be able to write a `getDepth` function to compute the depth of a heading given it's DOM node. This is not essential as you could just have a flat ToC, i.e. without indenting nested headings if you prefer. The default value for `getDepth` is `node => Number(node.nodeName[1])`.
2. Secondly, this is what each of the words in the unwieldy title mean:

    - **Responsive**: The ToC is displayed in a column to the right of the text if the screen width permits and as a small book icon in the lower left corner on narrow screens such as phones and small tablets. In that case, it expands to show the full ToC when clicked.
    - **Sticky**: The ToC scrolls with the viewport below a certain threshold on the page to always remain easily accessible as you progress through the document.
    - **Active**: The ToC highlights the heading that's closest to the reader's current position to show where in the document as a whole you're currently at.
    - **Smooth**: When a user clicks a heading in the ToC, the viewport smoothly scrolls to that heading (without adding to the browser history, i.e. clicking the back button will always send you back to the previous page).

Alright, I can hear you saying "enough talk, show me the code already". Here it is.

## Implementation

```js:title=src/components/toc/index.js
import React, { useRef, useState, useEffect } from "react"
import { throttle } from "lodash"

// A hook to close the ToC if it's currently in an open state
// (only used on small screens) and close it, when the user clicks
// or touches somewhere outside the component.
import { useClickOutside } from "../../hooks"
// styled components (see below)
import { TocDiv, TocLink, TocIcon, Title, Toggle } from "./styles"

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

export default function Toc({
  // The default selector targets all headings (h1, h2, ..., h6)
  // inside a main element. You can pass in whatever string or
  // array of strings would target the all the headings you want.
  headingSelector = Array.from({ length: 6 }, (_, i) => `main h` + (i + 1)),
  title = `Contents`,
  getDepth = node => Number(node.nodeName[1])
}) {
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
  useClickOutside(ref, () => setOpen(false))
  useEffect(() => {
    const nodes = Array.from(document.querySelectorAll(headingSelector))
    const titles = nodes.map(node => ({
      title: node.innerText,
      depth: getDepth(node),
    }))
    // Compute the minimum heading depth. This will subtracted
    // from each heading's depth to determine the indentation
    // of that heading in the ToC.
    const minDepth = Math.min(...titles.map(h => h.depth))
    setHeadings({ titles, nodes, minDepth })

    // Throttling the scrollHandler saves resources and your reader's battery life.
    const scrollHandler = throttle(() => {
      // Offsets need to be recomputed because lazily-loaded content
      // increases increases offsets as user scrolls down.
      const offsets = headings.nodes.map(el => accumulateOffsetTop(el))
      const activeIndex = offsets.findIndex(
        offset => offset > window.scrollY + 0.8 * window.innerHeight
      )
      setActive(activeIndex === -1 ? titles.length - 1 : activeIndex - 1)
    }, 500)

    window.addEventListener(`scroll`, scrollHandler)
    return () => window.removeEventListener(`scroll`, scrollHandler)
  }, [headingSelector, headings])

  return (
    <>
      <Toggle opener open={open} onClick={() => setOpen(true)} size="1.6em" />
      <TocDiv ref={ref} open={open}>
        <Title>
          <TocIcon />
          {title}
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

And here's the `useClickOutside` hook (which I reexport from `src/hooks/index.js` in order to import it as above).

```js:title=src/hooks/useClickOutside.js
import { useEffect } from "react"

export const useClickOutside = (ref, handler, events) => {
  if (!events) events = [`mousedown`, `touchstart`]
  useEffect(() => {
    const detectClickOutside = event =>
      !ref.current.contains(event.target) && handler()
    for (const event of events)
      document.addEventListener(event, detectClickOutside)
    return () => {
      for (const event of events)
        document.removeEventListener(event, detectClickOutside)
    }
  }, [events, handler, ref])
}
```

## Styles

I include the styles here mostly for completeness and in case you're also using `styled-components`. You can boil these down quite a bit if you don't need the component to be responsive or if your site doesn't have a dark theme.

```js:title=src/components/toc/styles.js
import styled, { css } from "styled-components"

import { Close as Cross } from "styled-icons/material/Close"
import { BookContent } from "styled-icons/boxicons-regular/BookContent"

import mediaQuery from "../../utils/mediaQuery"

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
  overflow-y: scroll;
  z-index: 1;
  line-height: 2.2em;
  -webkit-overflow-scrolling: touch;
  ${mediaQuery.maxLaptop} {
    max-width: 16em;
    position: fixed;
    bottom: 1em;
    left: 1em;
    ${props => !props.open && `height: 0;`};
    ${props => props.open && openTocDiv};
    visibility: ${props => (props.open ? `visible` : `hidden`)};
    opacity: ${props => (props.open ? 1 : 0)};
    transition: ${props => props.theme.shortTrans};
  }
  ${mediaQuery.minLaptop} {
    max-width: 15em;
    font-size: 0.85em;
    grid-column: 4 / -1;
    position: sticky;
    top: 2em;
    right: 2em;
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
  display: block;
  margin-left: ${props => props.depth + `em`};
  border-top: ${props =>
    props.depth === 0 && `1px solid ` + props.theme.lighterGray};
`

export const TocIcon = styled(BookContent)`
  width: 1em;
  margin-right: 0.2em;
`

const openerCss = css`
  position: fixed;
  bottom: 1em;
  left: 0;
  padding: 0.5em 0.6em 0.5em 0.3em;
  background: ${props => props.theme.background};
  z-index: 1;
  box-shadow: 0 0 1em ${props => props.theme.shadowColor};
  border: 1px solid ${props => props.theme.borderColor};
  border-radius: 0 50% 50% 0;
  transform: translate(${props => (props.open ? `-100%` : 0)});
`

const closerCss = css`
  margin-left: 1em;
  border: 1px solid ${props => props.theme.borderColor};
  border-radius: 50%;
`

export const Toggle = styled(Cross).attrs(props => ({
  as: props.opener && BookContent,
  size: props.size || `1.2em`,
}))`
  transition: ${props => props.theme.shortTrans};
  justify-self: end;
  :hover {
    transform: scale(1.1);
  }
  ${mediaQuery.minLaptop} {
    display: none;
  }
  ${props => (props.opener ? openerCss : closerCss)};
`
```

And that's it. It took quite a bit less code than I expected when I started writing this component considering the long list of requirements I had in mind for it. I guess that's another testament to the hooks API which makes React even more modular, composable and compact.

Let me know in the comments if the component works for you or if you have questions!
