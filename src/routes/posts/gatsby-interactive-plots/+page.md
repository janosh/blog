---
title: Gatsby Interactive Plots
date: 2019-08-30
cover:
  img: gatsby-interactive-plots.svg
tags:
  - JS
  - Tutorial
  - Web Dev
  - Science
---

<!-- import fpProps from './frameworkPopularity'
import saddleProps from './saddle'
import triModalProps from './triModal'
import { FoldingSpinner } from 'components/Spinners' -->

The possibilities and authoring experience when creating content for the web have advanced by leaps and bounds in recent years. MDX -- the latest in a long line of game-changing innovations -- allows writers to sprinkle snippets of JSX directly into their markdown content (hence MDX). Think WordPress shortcodes but fancier. Not only does this open up seemingly endless possibilities in terms of more interactive and engaging content, it also facilitates the clear separation of code and content (i.e. no more need to write text directly into `.js` files).

There are plenty of excellent guides already on how to use MDX with a [few different site generators like Gatsby and Next.js](https://mdxjs.com/getting-started). What I couldn't find was a guide on how to create interactive research-grade 2d and 3d plots displayed alongside regular markdown content. This is my attempt at providing one. Assuming you're starting out from a Gatsby site that's already up and running, what follows are step-by-step instructions on how to combine [MDX](https://mdxjs.com), [Gatsby](https://gatsbyjs.org) and [Plotly](https://plot.ly/javascript) -- the latter being the tough guy in this three-way marriage.

## Setting up MDX

The first step is to equip your existing site with MDX-support. Gatsby provides an [official and excellent guide on how to do that](https://gatsbyjs.org/docs/mdx). The process has gotten much simpler in recent months and by now is pretty much reduced to adding [`mdx`](https://github.com/mdx-js/mdx) and [`gatsby-plugin-mdx`](https://gatsbyjs.org/packages/gatsby-plugin-mdx) to your dependencies,

```sh
yarn add gatsby-plugin-mdx @mdx-js/mdx @mdx-js/react
```

followed by including it in your `gatsby-config.js`

```js:title=gatsby-config.js
module.exports = {
  plugins: [
    // ....
    `gatsby-plugin-mdx`, // highlight-line
  ],
}
```

That's the most basic setup. Just like that, you can start adding `.mdx` files to your `src/pages` folder and they'll be automatically converted to HTML pages including any React components you import. Once you've started getting the hang of [MDX's capabilities](https://gatsbyjs.org/docs/mdx/writing-pages) you'll probably want to look into how to create MDX pages programmatically in `gatsby-node.js`. There's an entire section on that in the [Gatsby docs](https://gatsbyjs.org/docs/mdx/programmatically-creating-pages).

## Setting up Plotly

Next we'll need to install a plotting library. I went with Plotly because

- it's been around for a while, it's consistently added new features over that period and hence has accumulated extensive functionality in both 2d and 3d data visualization.
- it provides [official React support](https://github.com/plotly/react-plotly.js).
- it has multiple language bindings including Python and R.
- I looked at more than a dozen other Javascript plotting libraries and nothing else seemed to provide the functionality needed for scientific plots.
- they've really fleshed out their docs over the last year or two.

Plotly offers loads of customization options, perhaps at the expense of being a little more verbose than other options. If you're more interested in financial data visualization where (I think) people use more standardized plots, you might want to take a look at [Highcharts](https://highcharts.com) instead which also offers [official React support](https://github.com/highcharts/highcharts-react). [Recharts](http://recharts.org) also looked quite nice. However, both seem to be 2d only and only the former seems to be actively maintained.

To start using Plotly, we need to install it and its React components along with [`react-loadable`](https://github.com/jamiebuilds/react-loadable)

```sh
yarn add plotly.js react-plotly.js react-loadable
```

The reason we need `react-loadable` is that `react-plotly.js` as yet [doesn't support server-side rendering (SSR)](https://github.com/plotly/react-plotly.js/issues/21). [They rely on several browser APIs](https://github.com/plotly/react-plotly.js/issues/40#issuecomment-528851177) such as the global `document` variable, [bounding boxes](https://developer.mozilla.org/en-US/docs/Web/API/Element/getBoundingClientRect) and [WebGL contexts](https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext) which don't exist in `node`, making it hard for them to support SSR.

[I read elsewhere](https://elcess.us/Integrating-Plotly-with-Gatsby/) that working around this issue is as simple as customizing Gatsby's Webpack config to use a null loader for Plotly by adding the following export to `gatsby-node.js`

```js:title=gatsby-node.js
exports.onCreateWebpackConfig = ({ stage, loaders, actions }) => {
  if (stage === `build-html`) {
    actions.setWebpackConfig({
      module: {
        rules: [
          {
            test: /plotly/,
            use: loaders.null(),
          },
        ],
      },
    })
  }
}
```

That did not work for me, though. I was still getting [`Minified React error #130`](https://reactjs.org/docs/error-decoder.html/?invariant=130&args[]=object&args[]=) during builds.

Hence I scrapped the Webpack config and used `react-loadable` to turn the `<Plot />` component (the default export of `react-plotly.js`) into a lazily-loading version that's only executed on the client where `document` and all the other browser APIs are available. Here's how `LazyPlot` is implemented:

```js:title=src/components/Plotly.js
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
```

It was surprisingly easy to add dark mode support. All it took was a transparent background and calling the `useDarkMode` hook to adjust `font.color` depending on the current `colorMode`. I also threw in a cool `<FoldingSpinner />` courtesy of [Tobias Ahlin](https://tobiasahlin.com/spinkit) refactored with `styled-components` to support dark mode as well. It is displayed while the plot is still loading to let the user know more content is about to appear in the spinner's place. Here's what it looks like in action. (You can click it to pause the animation if it disturbs your reading.)

<!-- <FoldingSpinner /> -->

And here's how it's implemented.

```js:title=src/components/Spinners/styles.js
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
```

```js:title=src/components/Spinners/styles.js
import styled from 'styled-components'

export const FoldingDiv = styled.div`
  margin: 2em auto;
  width: 2em;
  height: 2em;
  transform: rotateZ(45deg);
  div {
    float: left;
    width: 50%;
    height: 50%;
    position: relative;
    transform: scale(1.1);
  }
  div::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: var(--color-text);
    ${props => props.active && `animation: foldCube 2.4s infinite linear both`};
    transform-origin: 100% 100%;
  }
  ${[2, 4, 3]
    .map(
      (el, idx) => `div:nth-child(${el}) {
        transform: scale(1.1) rotateZ(${90 * (idx + 1)}deg);
      }
      div:nth-child(${el})::before {
        animation-delay: ${0.3 * (idx + 1)}s;
      }`
    )
    .join(`\n`)}
  @keyframes foldCube {
    0%,
    10% {
      transform: perspective(140px) rotateX(-180deg);
      opacity: 0;
    }
    25%,
    75% {
      transform: perspective(140px) rotateX(0deg);
      opacity: 1;
    }
    90%,
    100% {
      transform: perspective(140px) rotateY(180deg);
      opacity: 0;
    }
  }
```

Finally, to make the `LazyPlot` globally available in all your MDX files, wrap your app's root component in `MDXProvider` and pass it an object of global components.

```js:title=src/components/App.js
import React from 'react'
import { MDXProvider } from '@mdx-js/react' // highlight-line
import { LazyPlot } from './Plotly'

// highlight-start
const components = {
  LazyPlot,
}
// highlight-end

export default function App(props) {
  return (
    // highlight-start
    <MDXProvider components={components}>
      <main {...props} />
    </MDXProvider>
    // highlight-end
  )
}
```

[As mentioned in the MDX docs](https://mdxjs.com/advanced/components#caveats), it's important not to define this component inline with your JSX. This would make it referentially unstable and cause it to trigger a rerender of your entire page during _every_ render cycle (even if most of the DOM remains unchanged). This results in bad performance and can cause unwanted side effects like breaking in-page browser navigation (e.g. clicking on headings in a table of contents). Avoid this by declaring your mapping as a variable.

Note that every component passed to `MDXProvider` in this way will be directly added to your page bundle which can quickly add up and increase load times. So while it makes your life as an author easier because you don't have to clutter your MDX files with import statements, you don't want to do this with too many components. (If I understand correctly, I believe `gatsby-plugin-mdx` is actually doing that with all components at the moment, no matter if they're imported in a file or globally provided. But that's expected to be remedied soon.)

That's it for the setup. We're now ready to produce some actual plots.

## Demos

### Framework Popularity

Let's start simple with a 2d plot.

<!-- <LazyPlot {...fpProps} /> -->

_Frontend framework popularity over time measured by Google search frequency. Source: [Google Trends](https://trends.google.com/trends/explore?date=2012-01-01%202018-08-31&geo=US&q=%2Fm%2F012l1vxv,%2Fm%2F0j45p7w,%2Fg%2F11c6w0ddw9,%2Fg%2F11c0vmgx5d)_

All the MDX this requires is

```mdx
import fpProps from './frameworkPopularity'

### Frontend Framework Popularity

<LazyPlot {...fpProps} />
```

```js:title=frameworkPopularity.js
const colors = [`red`, `green`, `blue`, `orange`]

const months = [`2012/01`, `2012/02`, `2012/03`, `2012/04`, `2012/05`, `2012/06`, `2012/07`, `2012/08`, `2012/09`, `2012/10`, `2012/11`, `2012/12`, `2013/01`, `2013/02`, `2013/03`, `2013/04`, `2013/05`, `2013/06`, `2013/07`, `2013/08`, `2013/09`, `2013/10`, `2013/11`, `2013/12`, `2014/01`, `2014/02`, `2014/03`, `2014/04`, `2014/05`, `2014/06`, `2014/07`, `2014/08`, `2014/09`, `2014/10`, `2014/11`, `2014/12`, `2015/01`, `2015/02`, `2015/03`, `2015/04`, `2015/05`, `2015/06`, `2015/07`, `2015/08`, `2015/09`, `2015/10`, `2015/11`, `2015/12`, `2016/01`, `2016/02`, `2016/03`, `2016/04`, `2016/05`, `2016/06`, `2016/07`, `2016/08`, `2016/09`, `2016/10`, `2016/11`, `2016/12`, `2017/01`, `2017/02`, `2017/03`, `2017/04`, `2017/05`, `2017/06`, `2017/07`, `2017/08`, `2017/09`, `2017/10`, `2017/11`, `2017/12`, `2018/01`, `2018/02`, `2018/03`, `2018/04`, `2018/05`, `2018/06`, `2018/07`, `2018/08`]

const data = {
  React: [2, 2, 3, 3, 3, 2, 2, 2, 3, 3, 3, 3, 2, 3, 3, 3, 2, 2, 3, 3, 3, 4, 4, 3, 4, 4, 5, 5, 5, 5, 6, 7, 7, 10, 10, 10, 13, 18, 18, 19, 20, 21, 24, 25, 27, 28, 29, 29, 32, 39, 39, 41, 42, 43, 41, 43, 41, 47, 49, 50, 55, 65, 68, 68, 71, 79, 76, 83, 73, 80, 74, 66, 74, 82, 88, 89, 94, 95, 98, 100],
  AngularJS: [1, 1, 1, 2, 3, 3, 4, 4, 4, 6, 8, 9, 11, 13, 17, 17, 20, 22, 25, 24, 23, 30, 33, 35, 39, 41, 45, 49, 53, 53, 58, 51, 48, 52, 58, 61, 60, 61, 69, 74, 67, 67, 65, 58, 57, 53, 61, 62, 59, 59, 64, 56, 59, 51, 53, 51, 51, 54, 57, 62, 55, 55, 55, 51, 52, 47, 46, 41, 34, 37, 41, 38, 37, 38, 38, 35, 35],
  Angular: [2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 5, 5, 6, 6, 8, 7, 9, 9, 12, 12, 11, 13, 15, 15, 16, 17, 20, 20, 21, 20, 24, 22, 20, 24, 27, 26, 29, 30, 33, 35, 33, 34, 31, 30, 29, 29, 32, 36, 33, 37, 40, 35, 36, 38, 36, 38, 36, 42, 48, 52, 49, 49, 55, 48, 55, 49, 52, 51, 44, 48, 53, 53, 54, 56, 54, 60, 56],
  Vue: [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 1, 2, 3, 3, 3, 3, 3, 4, 5, 5, 6, 6, 8, 8, 8, 9, 10, 10, 12, 12, 12, 12, 12, 14, 14, 16, 16, 16, 18, 18, 19]
}

export default {
  data: Object.keys(data).map((key, index) => ({
    x: months,
    y: data[key],
    type: `scatter`,
    mode: `lines+markers`,
    name: key,
    marker: { color: colors[index] },
  })),
}
```

### Saddle

Next, let's aim a little higher and visualize the saddle point of $x^2 - y^2$ at $(0,0)$.

<!-- <LazyPlot {...saddleProps} /> -->

_The surface $x^2 - y^2$ plotted over the domain $[-10,10]^2$._

In your MDX, you again have

```mdx
import saddleProps from './saddle'

### Saddle

<LazyPlot {...saddleProps} />
```

where `saddleProps` is exported as:

```js:title=saddle.js
const [points, middle] = [21, 10]
const range = Array.from(Array(points), (e, i) => i - middle)
const z = range.map(x => range.map(y => x * x - y * y))

export default {
  data: [
    {
      z,
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
    },
  ],
  style: { height: `30em` },
}
```

### Trimodal Distribution

Here's another surface, this one a tri-modal distribution consisting of three unnormalized Gaussians.

<!-- <LazyPlot {...triModalProps} /> -->

_$\exp[-\frac{1}{20}(x^2 + y^2)] + \exp\{-\frac{1}{10}[(x-10)^2 + y^2]\} + \exp\{-\frac{1}{10}[(x-7)^2 + (y-7)^2]\}$._

This is generated by

```mdx
import triModalProps from './triModal'

### Trimodal Distribution

<LazyPlot {...triModalProps} />
```

```js:title=triModal.js
const [points, middle] = [51, 25]
const range = Array.from(Array(points), (e, i) => 0.5 * (i - middle))
const z = range.map(x =>
  range.map(
    y =>
      Math.exp(-0.05 * (x ** 2 + y ** 2)) +
      0.7 * Math.exp(-0.1 * ((x - 10) ** 2 + y ** 2)) +
      0.5 * Math.exp(-0.1 * ((x + 7) ** 2 + (y - 7) ** 2))
  )
)

export default {
  data: [
    {
      z,
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
  ],
  style: { height: `30em` },
}
```

## Conclusion

I'm still getting the hang of Plotly's APIs but the possibilities already seem endless. What a great time to be developing for the web!

If you have questions or cool ideas for more plots to add to the demo, let me know in the comments!
