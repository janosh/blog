import React from 'react'
import Loadable from 'react-loadable'
import { FoldingSpinner } from './Spinners'
import { withTheme } from 'styled-components'

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

export const LazyPlot = withTheme(({ theme, layout, style, config, ...rest }) => (
  <Plotly
    layout={{
      margin: { t: 0, r: 0, b: 0, l: 0 },
      paper_bgcolor: `rgba(0, 0, 0, 0)`,
      plot_bgcolor: `rgba(0, 0, 0, 0)`,
      font: {
        color: theme.textColor,
        size: 16,
      },
      // The next 3 directives make the plot responsive.
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
))
