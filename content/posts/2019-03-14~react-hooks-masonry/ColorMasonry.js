import React, { useState } from 'react'
import Masonry from 'components/Masonry'
import shuffle from 'lodash/shuffle'
import styled from 'styled-components'

const ColorBox = styled.div`
  border-radius: 1em;
  transition: 0.2s;
  justify-content: center;
  align-content: center;
  display: grid;
  color: white;
  cursor: pointer;
  :hover {
    transform: scale(1.1);
    box-shadow: 0 0 1em 0 var(--color-shadow);
  }
`

const data = [
  [`5em`, `linear-gradient(45deg, #f05f70, #164b78)`],
  [`2em`, `linear-gradient(45deg, #5cb767, #2e9fff)`],
  [`4em`, `linear-gradient(45deg, #e0c3fc, #8ec5fc)`],
  [`7em`, `linear-gradient(45deg, #f093fb, #f5576c)`],
  [`1em`, `linear-gradient(45deg, #ffd34f, #2e9fff)`],
  [`3em`, `linear-gradient(45deg, #d299c2, #fef9d7)`],
  [`2em`, `linear-gradient(45deg, #f6d365, #fda085)`],
  [`5em`, `linear-gradient(45deg, #164b78, #ffd34f)`],
  [`5em`, `linear-gradient(45deg, #96fbc4, #f9f586)`],
]

export default function MasonryExample() {
  const [divs, setDivs] = useState(data.concat(data))
  return (
    <Masonry minWidth={300} css="margin: 2em 0;">
      {divs.map(([minHeight, background], index) => (
        <ColorBox
          key={index}
          style={{ background, minHeight }}
          onClick={() => setDivs(shuffle)}
        >
          {index + 1}
        </ColorBox>
      ))}
    </Masonry>
  )
}
