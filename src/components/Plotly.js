import React from 'react'
import Loadable from 'react-loadable'
import { FoldingSpinner } from './Spinners'
import { useDarkMode } from 'hooks'

const Plotly = Loadable({
  loader: () => import(`react-plotly.js`),
  loading: ({ timedOut }) =>
    timedOut ? (
      <blockquote>Error: Loading Plotly timed out.</blockquote>
    ) : (
      <FoldingSpinner />
    ),
  timeout: 10000,
})

export const LazyPlot = ({ layout, style, config, ...rest }) => {
  const [colorMode] = useDarkMode()
  return (
    <Plotly
      layout={{
        margin: { t: 0, r: 0, b: 0, l: 0 },
        paper_bgcolor: `rgba(0, 0, 0, 0)`,
        plot_bgcolor: `rgba(0, 0, 0, 0)`,
        font: {
          color: colorMode !== `light` ? `white` : `black`,
          size: 16,
        },
        // The next 3 options make the plot responsive.
        autosize: true,
        ...layout,
      }}
      style={{ width: `100%`, ...style }}
      useResizeHandler
      config={{
        displayModeBar: false,
        showTips: false,
        ...config,
      }}
      {...rest}
    />
  )
}
