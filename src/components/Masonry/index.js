import React, { useEffect, useRef, useState } from 'react'
import { useEventListener } from '../../hooks'
import { Col, MasonryDiv } from './styles'

const createCols = (children, cols, numCols) => {
  for (let i = 0; i < numCols; i++) cols[i] = []
  children.forEach((child, i) => cols[i % numCols].push(child))
}

export default function Masonry({ children, gap, minWidth = 500 }) {
  const cols = []
  const ref = useRef()
  const [numCols, setNumCols] = useState(3)
  createCols(children, cols, numCols)

  const resizeHandler = () =>
    setNumCols(Math.ceil(ref.current.offsetWidth / minWidth))
  useEffect(resizeHandler, [])
  useEventListener(`resize`, resizeHandler)

  return (
    <MasonryDiv ref={ref} gap={gap}>
      {Array.from({ length: numCols }, (_, index) => (
        <Col key={index} gap={gap}>
          {cols[index]}
        </Col>
      ))}
    </MasonryDiv>
  )
}
