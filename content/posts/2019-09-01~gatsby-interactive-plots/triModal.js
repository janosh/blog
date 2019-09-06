import React from 'react'
import { withTheme } from 'styled-components'
import { LazyPlot } from '../../../src/components/Loadable'

const [points, middle] = [51, 25]
const range = Array.from(Array(points), (e, i) => 0.5 * (i - middle))
const data = range.map(x =>
  range.map(
    y =>
      Math.exp(-0.05 * (x * x + y * y)) +
      0.7 * Math.exp(-0.1 * (Math.pow(x - 10, 2) + y * y)) +
      0.5 * Math.exp(-0.1 * (Math.pow(x + 7, 2) + Math.pow(y - 7, 2)))
  )
)

export default withTheme(({ theme }) => (
  <LazyPlot
    data={[
      {
        z: data,
        x: range,
        y: range,
        type: `surface`,
        contours: {
          z: {
            show: true,
            usecolormap: true,
            highlightcolor: `white`,
            project: { z: true },
          },
        },
        showscale: false,
      },
    ]}
    layout={{
      margin: { t: 0, r: 0, l: 35 },
      paper_bgcolor: `rgba(0, 0, 0, 0)`,
      plot_bgcolor: `rgba(0, 0, 0, 0)`,
      font: {
        color: theme.textColor,
        size: 16,
      },
      autosize: true,
    }}
    style={{ width: `100%`, height: `30em` }}
    useResizeHandler
    config={{
      displayModeBar: false,
      showTips: false,
    }}
  />
))
