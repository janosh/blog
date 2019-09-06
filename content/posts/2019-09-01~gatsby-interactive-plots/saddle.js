import React from 'react'
import { withTheme } from 'styled-components'
import { LazyPlot } from '../../../src/components/Loadable'

const [points, middle] = [21, 10]
const range = Array.from(Array(points), (e, i) => i - middle)
const data = range.map(x => range.map(y => x * x - y * y))

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
            highlightcolor: `#42f462`,
            project: { z: true },
          },
        },
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
