---
title: React Hooks Masonry
slug: /react-hooks-masonry
date: 2019-03-14
cover:
  img: nature-photos-masonry.png
tags:
  - Design
  - Web Dev
  - Tutorial
  - JS
---

Now that we have React Hooks, so many components can (and probably should [despite what Dan said at React Conf](https://youtu.be/dpw9EHDh2bM?t=3365)) be rewritten in a more succinct, readable and maintainable manner. A perfect candidate for this in my own code base was a `Masonry` component that used to rely on CSS grid with very narrow rows and managing the number of rows each child item spans based on its natural height to control their placement. With hooks, it was easy to significantly improve on this approach.

The new implementation uses ony 36 lines of codes and is about as plug-and-play as components get.

```jsx:title=src/components/masonry/index.js
import React, { useRef, useState, useEffect } from 'react'

import { MasonryDiv, Col } from './styles'

export default function Masonry({ children, gap, minWidth = 300 }) {
  const cols = []
  const ref = useRef()
  const [numCols, setNumCols] = useState(3)

  const calcNumCols = () =>
    setNumCols(Math.floor(ref.current.offsetWidth / minWidth))

  const createCols = () => {
    for (let i = 0; i < numCols; i++) cols[i] = []
    children.forEach((child, i) => cols[i % numCols].push(child))
  }

  useEffect(() => {
    calcNumCols()
    window.addEventListener(`resize`, calcNumCols)
    return () => window.removeEventListener(`resize`, calcNumCols)
  })
  createCols()

  return (
    <MasonryDiv ref={ref} gap={gap}>
      {Array(numCols)
        .fill()
        .map((el, i) => (
          <Col key={i} gap={gap}>
            {cols[i]}
          </Col>
        ))}
    </MasonryDiv>
  )
}
```

The styled components `MasonryDiv` and `Col` each create a CSS grid to space out child items according a default gap `1em` or whatever distance in CSS units you pass as a string to `<Masonry gap="calc(1vw + 20px)" />`.

```js:title=src/components/masonry/styled.js
import styled from 'styled-components'

export const MasonryDiv = styled.div`
  display: grid;
  grid-auto-flow: column;
  grid-gap: ${props => props.gap || `1em`};
`

export const Col = styled.div`
  display: grid;
  grid-gap: ${props => props.gap || `1em`};
  grid-auto-rows: max-content;
`
```

Using `Masonry` is as simple as wrapping it around an array of child elements. For example, here's how you'd use it to display a [list of image thumbnails](/nature) in a masonry layout.

```jsx{3,11,24}
import React, { useState, Fragment } from 'react'

import Masonry from '../../components/Masonry'
import Modal from '../../components/Modal'

import { Thumbnail, LargeImg } from './styles'

export default function Photos({ photos }) {
  const [modal, setModal] = useState()
  return (
    <Masonry>
      {photos.map((img, index) => (
        <Fragment key={img.title}>
          <Thumbnail
            onClick={() => setModal(index)}
            alt={img.title}
            src={img.src}
          />
          <Modal {...{ open: index === modal, modal, setModal }}>
            <LargeImg alt={img.title} src={img.src} />
          </Modal>
        </Fragment>
      ))}
    </Masonry>
  )
}
```
