---
title: JavaScript media queries
subtitle: And how to hook into them
slug: /js-media-queries
date: 2019-04-08
cover:
  img: responsive.svg
  thumbnail: matchMedia.svg
tags:
  - Web Dev
  - Tutorial
  - JS
---

> Note: This post assumes you're using React (16.8 or later).

One thing I like about `styled-components` is that it enables concise and JavaScript-accessible media queries. For this site, I'm using a utility file that exports the following `mediaQuery` object.

```js:title=src/utils/mediaQuery.js
import { titleCase } from '.'

const mediaQuery = {
  screens: {
    // screen sizes in em units
    phone: 30,
    phablet: 40,
    tablet: 50,
    netbook: 60,
    laptop: 70,
    desktop: 100,
  },
}

const min = width => `@media screen and (min-width: ${width}em)`
const max = width => `@media screen and (max-width: ${width}em)`

// this for loop generates the following keys:
//   minPhone: `@media screen and (min-width: 30em)`,
//   maxPhone: `@media screen and (max-width: 30em)`,
//   ...
for (const key of Object.keys(mediaQuery.screens)) {
  const Key = titleCase(key)
  for (const [func, name] of [[min, `min`], [max, `max`]])
    mediaQuery[name + Key] = func(mediaQuery.screens[key])
}

export default mediaQuery
```

With this setup, you get consistent media queries all over your site by simply importing that object wherever you want to use a media query:

```js:title=some styled component
import styled from 'styled-components'

import mediaQuery from 'src/utils/mediaQuery.js'

const { minPhone, maxPhone } = mediaQuery

export default styled.div`
  ${maxPhone} {
    // some styles to apply only on phones
  }
  ${minPhone} {
    // some styles to apply on screens larger than phones
  }
`
```

However, even this close to JavaScript, CSS media queries alone sometimes don't cut it. The cool thing is [`window.matchMedia`](https://developer.mozilla.org/en-US/docs/Web/API/Window/matchMedia) makes it very easy to use your CSS media query directly in JavaScript without any 3rd party dependencies! And it even has great browser support.

![window.matchMedia browser support](matchMedia-browser-support.png)
_[`window.matchMedia` browser support](https://caniuse.com/#search=matchMedia)_

## `window.matchMedia` in React

To use it in a React function component, simply throw in the following code snippet.

```js{3,6-13}
import React, { useState, useEffect } from 'react'

const maxPhone = `screen and (max-width: 30em)`

export default function ResponsiveComponent(props) {
  const query = window.matchMedia(maxPhone)
  const [match, setMatch] = useState(query.matches)
  useEffect(() => {
    const handleMatch = q => setMatch(q.matches)
    query.addListener(handleMatch)
    return () => query.removeListener(handleMatch)
  })
  return match ? <Mobile {...props} /> : <Desktop {...props} />
}
```

Note that we needed to remove the `@media` prefix of CSS media queries from `maxPhone`. `window.matchMedia(maxPhone)` then turns that string into the object `query` which becomes the JavaScript equivalent of `@media screen and (max-width: 30em)`. We then call `useState` to manage whether or not the query _currently_ matches the screen size, followed by `useEffect` which creates a listener to the window size and updates the status of the query when on resize. Finally, we return the `Mobile` or `Desktop` implementation of `ResponsiveComponent`, depending on the state of the query.

If you're using server-side rendering, you'll need to wrap this code in a `if` statement that checks that the `window` object is defined.

```js{6,15}
import React, { useState, useEffect } from 'react'

const maxPhone = `screen and (max-width: 30em)`

export default function ResponsiveComponent(props) {
  if (typeof window !== `undefined`) {
    const query = window.matchMedia(maxPhone)
    const [match, setMatch] = useState(query.matches)
    useEffect(() => {
      const handleMatch = q => setMatch(q.matches)
      query.addListener(handleMatch)
      return () => query.removeListener(handleMatch)
    })
    return match ? <Mobile {...props} /> : <Desktop {...props} />
  } else return null
}
```

## Hook it up!

Since this is functionality you may end up using on a regular basis, it probably makes sense to abstract it into a custom hook, say `useMediaQuery`.

```js
// React hook for JS media queries
export const useMediaQuery = cond => {
  if (typeof window !== `undefined`) {
    const query = window.matchMedia(cond)
    const [match, setMatch] = useState(query.matches)
    useEffect(() => {
      const handleMatch = q => setMatch(q.matches)
      query.addListener(handleMatch)
      return () => query.removeListener(handleMatch)
    })
    return match
  }
}
```

In my case, I export that hook from the same file that holds the above `mediaQuery` object. In fact, since I use the same queries all over my site, I decided to couple that hook to the `mediaQuery` object so that it only needs to be passed the key of the desired query. To that end, you'll have to modify `src/utils/mediaQuery.js` to contain each media query both in its CSS and JS variant, i.e. with and without the `@media` prefix.

```js:title=src/utils/mediaQuery.js
import { titleCase } from '.'

const mediaQuery = {
  screens: {
    // screen sizes in em units
    phone: 30,
    phablet: 40,
    tablet: 50,
    netbook: 60,
    laptop: 70,
    desktop: 100,
  },
}

- const min = width => `@media screen and (min-width: ${width}em)`
- const max = width => `@media screen and (max-width: ${width}em)`
+ const min = width => `screen and (min-width: ${width}em)`
+ const max = width => `screen and (max-width: ${width}em)`

for (const key of Object.keys(mediaQuery.screens)) {
  const Key = titleCase(key)
-   for (const [func, name] of [[min, `min`], [max, `max`]])
-     mediaQuery[name + Key] = func(mediaQuery.screens[key])
+   for (const [func, name] of [[min, `min`], [max, `max`]]) {
+     // css query
+     const query = func(mediaQuery.screens[key])
+     mediaQuery[name + Key] = `@media ` + query
+     // js query (see window.matchMedia)
+     mediaQuery[name + Key + `Js`] = query
+   }
}

export default mediaQuery
// React hook for JS media queries
export const useMediaQuery = cond => {
  if (typeof window !== `undefined`) {
-     const query = window.matchMedia(cond)
+     if (!mediaQuery[cond + `Js`])
+       throw `useMediaQuery's condition should be one of (min|max)(Phone|Phablet|Tablet|etc.)`
+     const query = window.matchMedia(mediaQuery[cond + `Js`])
    const [match, setMatch] = useState(query.matches)
    useEffect(() => {
      const handleMatch = q => setMatch(q.matches)
      query.addListener(handleMatch)
      return () => query.removeListener(handleMatch)
    })
    return match
  }
}
```

And this is how I use that hook on this site to switch between `MobileNav` and `DesktopNav`

```js{4,9-14}
import React from 'react'
import { StaticQuery, graphql } from 'gatsby'

import { useMediaQuery } from '../../utils/mediaQuery'

import MobileNav from './Mobile'
import DesktopNav from './Desktop'

const Nav = props =>
  useMediaQuery(`maxTablet`) ? (
    <MobileNav {...props} />
  ) : (
    <DesktopNav {...props} />
  )

const query = graphql`
  {
    nav: file(base: { eq: "nav.yml" }) {
      nav: childrenNavYaml {
        title
        url
      }
    }
  }
`

export default props => (
  <StaticQuery
    query={query}
    render={data => <Nav {...data.nav} {...props} role="navigation" />}
  />
)
```

For a more elaborate example involving a media query with multiple break points, check out the [`useMedia` post on usehooks.com](https://usehooks.com/useMedia).
