import React, { useRef, useState, useEffect } from "react"
import { throttle } from "lodash"

import { useOnClickOutside } from "../../hooks"
import { TocDiv, TocLink, TocIcon, Title, Toggle } from "./styles"

const accumulateOffsetTop = (el, totalOffset = 0) => {
  while (el) {
    totalOffset += el.offsetTop - el.scrollTop + el.clientTop
    el = el.offsetParent
  }
  return totalOffset
}

export default function Toc({ headingSelector, getTitle, getDepth, tocTitle }) {
  const [headings, setHeadings] = useState({
    titles: [],
    nodes: [],
    minDepth: 0,
  })
  const [open, setOpen] = useState(false)
  const [active, setActive] = useState()
  const ref = useRef()
  useOnClickOutside(ref, () => setOpen(false))
  useEffect(() => {
    // Fallback to sensible defaults for headingSelector, getTitle and getDepth
    // inside useEffect rather than specifying them as Toc default props to avoid
    // the need for useMemo and useCallback, resp.
    // Otherwise, these would change on every render and since this effect calls
    // setHeadings which triggers a rerender, it would cause an infinite loop.

    const selector =
      headingSelector || Array.from({ length: 6 }, (_, i) => `main h` + (i + 1))
    const nodes = Array.from(document.querySelectorAll(selector))
    const titles = nodes.map(node => ({
      title: getTitle ? getTitle(node) : node.innerText,
      depth: getDepth ? getDepth(node) : Number(node.nodeName[1]),
    }))
    const minDepth = Math.min(...titles.map(h => h.depth))
    setHeadings({ titles, nodes, minDepth })
  }, [headingSelector, getTitle, getDepth])

  useEffect(() => {
    const scrollHandler = throttle(() => {
      const { titles, nodes } = headings
      // Offsets need to be recomputed because lazily-loaded
      // content increases offsets as user scrolls down.
      const offsets = nodes.map(el => accumulateOffsetTop(el))
      const activeIndex = offsets.findIndex(
        offset => offset > window.scrollY + 0.8 * window.innerHeight
      )
      setActive(activeIndex === -1 ? titles.length - 1 : activeIndex - 1)
    }, 500)

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
