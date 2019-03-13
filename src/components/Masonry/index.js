import React, { useRef, useState, useEffect } from "react"

import { MasonryDiv, Col } from "./styles"

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
