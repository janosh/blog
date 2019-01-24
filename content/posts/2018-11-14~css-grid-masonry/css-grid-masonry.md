---
title: Masonry Layout with CSS Grid
slug: css-grid-masonry
date: 2018-11-14
cover: ocean-artup-blog.png
tags:
  - Design
  - Web Development
  - Tutorial
---

Back in early January, [Wes Bos](https://github.com/wesbos) asked [Rachel Andrew](https://github.com/rachelandrew) the excellent [question](https://github.com/rachelandrew/cssgrid-ama/issues/19) if CSS grid could be used to produce a masonry layout (think Pinterest). Turns out the spec doesn't support it. Makes sense if you think about. A proper masonry layout doesn't have rows and without rows, it's not a grid. Still it would have been cool if CSS grid had you covered, anyway. At least for now though, that is late 2018, almost 2 years after the question it still doesn't.

No matter though. That just means we have to get a little creative. And indeed, that's exactly what [Jamie Perkins](https://github.com/inorganik) did. In the above linked GitHub issue, he [presents a neat flexbox solution](https://codepen.io/inorganik/pen/pREYPJ) that requires just 13 lines of JavaScript.

Rewriting his approach in modern JS shaves off another 4 lines, bringing it down to just 9:

```js
const numCols = 3
const colHeights = Array(numCols).fill(0)
const container = document.getElementById(`container`)
Array.from(container.children).forEach((child, i) => {
  const order = i % numCols
  child.style.order = order
  colHeights[order] += parseFloat(child.clientHeight)
})
container.style.height = Math.max(...colHeights) + `px`
```

However, flexbox gave me some trouble. The `flex` items kept disregarding the parent container width, causing massive overflows. I tried for almost an hour but couldn't get them to behave.

So I really wanted to make it happen with `grid` instead. If you're using **`react`** and **`styled-components`**, the suggested solution by Rachel Andrews is quite easy to implement. She proposed to have lots of small rows of height $h_\text{r}$, where small means $h_\text{r} \ll h_\text{item}$ with $h_\text{item}$ the typical grid item height, and then manage how many rows each grid item should span. In other words, we compute the smallest integer $n$ that when multiplied with the row height $h_\text{r}$ exceeds the current grid item's height $h_\text{item}$, $n = \lceil h_\text{r}/h_\text{item}\rceil$ and then tell `grid` to make that item span $n$ rows. Here's the implementation:

```jsx
// masonry/index.js
import React, { Component, createRef } from 'react'

import { Parent, Child } from './styles'

export default class Masonry extends Component {
  static defaultProps = {
    rowHeight: 40, // in pixels
    colWidth: `17em`,
  }

  state = { spans: [] }
  ref: createRef()
  // sums up the heights of all child nodes for each grid item
  sumUp = (acc, node) => acc + node.scrollHeight

  computeSpans = () => {
    const { rowHeight } = this.props
    const spans = []
    Array.from(this.ref.current.children).forEach(child => {
      const childHeight = Array.from(child.children).reduce(this.sumUp, 0)
      const span = Math.ceil(childHeight / rowHeight)
      spans.push(span + 1)
      child.style.height = span * rowHeight + `px`
    })
    this.setState({ spans })
  }

  componentDidMount() {
    this.computeSpans()
    window.addEventListener('resize', this.computeSpans)
  }

  componentWillUnmount() {
    window.removeEventListener('resize', this.computeSpans)
  }

  render() {
    return (
      <Parent ref={this.ref} {...this.props}>
        {this.props.children.map((child, i) => (
          <Child key={i} span={this.state.spans[i]}>
            {child}
          </Child>
        ))}
      </Parent>
    )
  }
}
```

and the styled components:

```js
// masonry/styles.js
import styled from 'styled-components'

export const Parent = styled.div`
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(${props => props.colWidth}, 1fr));
  grid-auto-rows: calc(${props => props.rowHeight}px - 2em);
  grid-gap: 2em;
`

export const Child = styled.div`
  grid-row: span ${props => props.span};
  height: max-content;
`
```

To create your own masonry with the above implementation, just copy the above two files into your project, change the default props for `rowHeight` and `colWidth` to suit your needs and use the `Masonry` component like so:

```jsx
import React from 'react'

import Masonry from './Masonry'
import PostExcerpt from './PostExcerpt'

const PostList = ({ posts }) => (
  <Masonry>
    {posts.map(post => (
      <PostExcerpt key={post.slug} {...post} />
    ))}
  </Masonry>
)

export default PostList
```
