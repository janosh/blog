import React, { useState } from 'react'
import { FoldingDiv } from './styles'

export const FoldingSpinner = props => {
  const [active, setActive] = useState(true)
  return (
    <FoldingDiv {...props} active={active} onClick={() => setActive(!active)}>
      {Array(4)
        .fill()
        .map((e, i) => (
          <div key={i} />
        ))}
    </FoldingDiv>
  )
}
