import React, { useRef, useState, useEffect } from "react"
import { throttle } from "lodash"

import { useClickOutside } from "../../hooks"
import { TocDiv, TocLink, TocIcon, Title, Toggle } from "./styles"

const accumulateOffsetTop = (el, totalOffset = 0) => {
  while (el) {
    totalOffset += el.offsetTop - el.scrollTop + el.clientTop
    el = el.offsetParent
  }
  return totalOffset
}

export default function Toc({
  headingSelector = Array.from({ length: 6 }, (_, i) => `main h` + (i + 1)),
  title = `Contents`,
  getDepth = node => Number(node.nodeName[1]),
}) {
  const [headings, setHeadings] = useState({
    titles: [],
    nodes: [],
    minDepth: 0,
  })
  const [open, setOpen] = useState(false)
  const [active, setActive] = useState()
  const ref = useRef()
  useClickOutside(ref, () => setOpen(false))
  useEffect(() => {
    const nodes = Array.from(document.querySelectorAll(headingSelector))
    const titles = nodes.map(node => ({
      title: node.innerText,
      depth: getDepth(node),
    }))
    const minDepth = Math.min(...titles.map(h => h.depth))
    setHeadings({ titles, nodes, minDepth })

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
  }, [getDepth, headingSelector, headings])

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
