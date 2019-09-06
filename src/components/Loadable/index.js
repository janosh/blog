import React, { useState } from 'react'
import Loadable from 'react-loadable'
import { SpinnerDiv } from './styles'

export const Spinner = () => {
  const [active, setActive] = useState(true)
  return (
    <SpinnerDiv active={active} onClick={() => setActive(!active)}>
      {Array(4).fill(<div />)}
    </SpinnerDiv>
  )
}

export const LazyPlot = Loadable({
  loader: () => import(`react-plotly.js`),
  loading: () => <Spinner />,
})
