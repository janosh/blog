---
title: useDarkMode
date: 2019-07-01
cover:
  img: useDarkMode.svg
tags:
  - JS
  - Tutorial
  - Web Dev
---

<!-- import DarkToggle from 'components/DarkToggle'
import { BorderBox } from 'components/styles' -->

All the cool kids these days have websites with a dark color scheme. The really cool kids even have a dark _and_ a light mode with a neat little toggle for you to pick your preference. Being regularly annoyed myself when browsing pages that insist on being eye-piercingly bright even late in the evening, I decided my site needs a dark mode as well. In this post, I'll share my implementation. It's API is a simple `useDarkMode` React hook. Internally, it relies on

- `localStorage` to persist the user's preference across visits,
- a custom event bus for keeping multiple call sites to `useDarkMode` in sync across the application,
- the [`prefers-color-scheme`](https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-color-scheme) media query to adopt the OS's color scheme (unless the user makes an explicit choice otherwise),
- CSS custom properties to specify the color theme,
- Gatsby's server-side rendering (SSR) API to prevent light theme colors from briefly flashing up on initial page load. (This part is separate from the `useDarkMode` hook and not necessary if your app isn't server-rendered.)

The last two parts of this implementation were heavily inspired by [Joshua Comeau](https://github.com/joshwcomeau), a Gatsby core member. You can read about his dark mode implementation in [this awesome post](https://joshwcomeau.com/gatsby/dark-mode).

To try out the dark mode on this site, click/tap this toggle:

<!-- <BorderBox>
  <DarkToggle />
</BorderBox> -->

Here's an overview of everything we'll need to build to get this working:

1. The [`useDarkMode`](#usedarkmode) hook informs the user-facing `DarkToggle` component which color scheme the user prefers and provides a setter function to change the current setting.

2. The [`useLocalStorage`](#usestorage) hook is called by `useDarkMode` to persist the user's preference in `localStorage` across visits to the site.

3. The [`useMediaQuery`](#usemediaquery) hook allows us to check the `prefers-color-scheme` setting of the reader's device. It also sets up an event listener that updates the active theme when the state of the media query changes.

4. [`DarkToggle`](#darktoggle) allows to pick either the dark or light color scheme or to 'unset' the preference with "auto" in which case we fall back to whatever color scheme the user's OS is currently set to.

5. The [`onRenderBody`](#onrenderbody) API in `gatsby-ssr.js` to prevent flashing colors on initial page load.

You can take a look at an **MVP** and play around with a **live demo** of all these parts working together [over on GitHub](https://github.com/janosh/dark-mode-minimal).

Considering how neatly `useDarkMode`, `useLocalStorage` and `useMediaQuery` fit together to accomplish this fairly sophisticated piece of functionality, I think it's fair to say that implementing a dark mode is an excellent use case for hooks. It demonstrates how hooks allow us to isolate and reuse pieces of logic and bring them together in ways where they become more than the sum of their parts. Or as Gabe Ragland on [usehooks.com](https://usehooks.com) put it:

> It's almost as if hooks bring the compositional power of React components to stateful logic! 🤯

By the way, [usehooks.com](https://usehooks.com) offers yet another simpler, although not as feature-rich [implementation of `useDarkMode`](https://usehooks.com/useDarkMode).

With this overview out of the way, let's get cracking.

## `useDarkMode`

The `useDarkMode` hook which we will import in `DarkToggle/index.js` reads as follows.

```js:title=src/hooks/useDarkMode.js
import { useLocalStorage, useMediaQuery } from 'hooks'
import { useEffect } from 'react'
import { COLOR_MODE_KEY, INITIAL_COLOR_MODE_CSS_PROP, COLORS } from 'utils/constants'

export const useDarkMode = () => {
  const [colorMode, setLSColorMode] = useLocalStorage(COLOR_MODE_KEY)

  const prefersDarkFromMQ = useMediaQuery(
    `(prefers-color-scheme: dark)`,
    prefersDarkFromMQ => setBodyColors(prefersDarkFromMQ ? `dark` : `light`)
  )

  // Place useDarkMode initialization in useEffect to exclude it from SSR.
  // The code inside will run on the client after React rehydration.
  // Because colors matter a lot for the initial page view, we're not
  // setting them here but in gatsby-ssr. That way it happens before
  // the React component tree mounts.
  useEffect(() => {
    const initialColorMode = document.body.style.getPropertyValue(
      INITIAL_COLOR_MODE_CSS_PROP
    )
    setLSColorMode(initialColorMode)
  }, []) // empty deps because of https://stackoverflow.com/a/61735300

  function setColorMode(newValue) {
    setLSColorMode(newValue)

    // This reassignment happens after setLSColorMode because `auto`
    // is a valid value for persisting but not for the actual color mode.
    if (newValue === `auto`) {
      newValue = prefersDarkFromMQ ? `dark` : `light`
    }

    setBodyColors(newValue)
  }

  return [colorMode, setColorMode]
}

const setBodyColors = mode => {
  for (const [name, colorByMode] of Object.entries(COLORS)) {
    document.body.style.setProperty(`--color-${name}`, colorByMode[mode])
  }
}
```

Thanks to the now ubiquitous [`prefers-color-scheme`](https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-color-scheme) media query (which only [recently landed in all major browsers including Firefox, Chrome, Safari and Edge](https://caniuse.com/#search=prefers-color-scheme)) we can ask the user's OS for their current color scheme in just a single line. So if the user's device is set to dark mode, the app will automatically respect that and display in dark mode as well.

You may have noted we imported three constants in `useDarkMode`: `COLOR_MODE_KEY`, `INITIAL_COLOR_MODE_CSS_PROP` and `COLORS`. These are shared between `useDarkMode` and `gatsby-ssr` and ensure a smooth handover between the server-rendered app and its hydrated version on the clint. To make sure we don't accidentally break this handover when we change our implementation later, we create a single source of truth for both files:

```js:title=src/utils/constants.js
export const COLOR_MODE_KEY = `color-mode`

export const INITIAL_COLOR_MODE_CSS_PROP = `--initial-color-mode`

const colors = {
  gray: {
    default: `#464849`,
    dark: `#3d3d3d`,
    darker: `#1a1d23`,
    darkest: `#060606`,
    light: `#bcbcbc`,
    lighter: `#e5e5e5`,
    lightest: `#f7f7f7`,
  },
  blue: {
    default: `#2202a9`,
    dark: `#150956`,
    darker: `#0a051e`,
    darkest: `#00040c`,
    light: `#1f59cd`,
    lighter: `#279AF1`,
  },
  // ...
}

const { gray, blue, orange } = colors

export const COLORS = {
  text: {
    light: `black`,
    dark: gray.lighter,
  },
  background: {
    light: `white`,
    dark: blue.darker,
  },
  shadow: {
    light: gray.lighter,
    dark: `black`,
  },
  link: {
    light: blue.light,
    dark: blue.lighter,
  },
  gray: {
    light: gray.regular,
    dark: gray.light,
  },
  lightGray: {
    light: gray.lightest,
    dark: gray.darker,
  },
  darkGray: {
    light: gray.default,
    dark: gray.darkest,
  },
  a: {
    light: orange.default,
    dark: orange.darker,
  },
  b: {
    light: blue.dark,
    dark: blue.darkest,
  },
  // ...
}
```

## `useStorage`

The `useStorage` hook looks a little complicated at first but that's mostly just because it includes a custom event bus. In other words, it dispatches and listens to some events that make different calls to `useStorage` across the application but with the same key stay in sync. If you change the value associated with `key` at one call site, all others will update to this value as well.

```js:title=src/hooks/useStorage.js
import { useEffect, useState } from 'react'

export const useStorage = (storage, key, initialValue, options = {}) => {
  // storage can be local or session or any instance that supports
  // reading and writing key-value pairs (like any JS object).
  const { deleteKeyIfValueIs = null } = options

  // We pass useState a function that handles initial state creation.
  // That way, the function is executed only once and useStorage
  // returns the correct value on initial render.
  const [value, setValue] = useState(() => {
    // During SSR, storage is unavailable so we go straight to initialValue.
    if (typeof window === `undefined`) return initialValue
    try {
      const value = storage[key]
      // Parse stored JSON if there was any, else return initialValue.
      return value ? JSON.parse(value) : initialValue
    } catch (error) {
      // If error also return initialValue
      console.error(error)
      return initialValue
    }
  })

  useEffect(() => {
    // If key is not in storage, set it to the provided initial value to
    // ensure we store it even if setStoredValue is never called.
    if (storage[key] === undefined) storage[key] = JSON.stringify(value)

    // The CustomEvent triggered by a call to useStorage somewhere
    // else in the app carries the new value as the event.detail.
    const cb = event => setValue(event.detail)

    // Register event listener on initial state creation. Allows us to react
    // to events emitted by setValue below. That way we can keep value in sync
    // between multiple call sites to useStorage with the same key.
    document.addEventListener(`storage:${key}Change`, cb)
    return () => document.removeEventListener(`storage:${key}Change`, cb)
  }, [value, key, storage])

  const setStoredValue = newValue => {
    if (newValue === value) return

    // Conform to useState API by allowing newValue to be a function
    // which takes the current value.
    if (newValue instanceof Function) newValue = newValue(value)

    const event = new CustomEvent(`storage:${key}Change`, {
      detail: newValue,
    })
    document.dispatchEvent(event)

    if (newValue === deleteKeyIfValueIs) delete storage[key]
    else storage[key] = JSON.stringify(newValue)

    setValue(newValue)
  }
  return [value, setStoredValue]
}

export const useLocalStorage = (...args) =>
  useStorage(typeof window !== `undefined` && localStorage, ...args)

export const useSessionStorage = (...args) =>
  useStorage(typeof window !== `undefined` && sessionStorage, ...args)
```

Another option here besides custom events is to use [React's Context API](https://reactjs.org/docs/context.html). By wrapping the root element of your app in a context provider whose value is the current `colorMode` and its setter function, you can make both available throughout React's component tree. You can take a look at Joshua's implementation to see how to do that in Gatsby. However, I found that approach to be little more cumbersome since you need to import the React context wherever you want to use or set the current color scheme.

## `useMediaQuery`

Last but not least in our list of hooks is `useMediaQuery`. It uses the [`window.matchMedia` API](https://developer.mozilla.org/en-US/docs/Web/API/Window/matchMedia) to parse the `query` string and turn it into a [`MediaQueryList`](https://developer.mozilla.org/en-US/docs/Web/API/MediaQueryList) object. It couples that with a call to `useState` to instantiate a boolean `match` indicating whether the query currently matches and registers an event listener to update that variable whenever the state of the `query` changes. Lastly, it accepts a callback function `cb` that takes the current state of the query. In the case of our dark mode implementation, this will be the function that updates the values of CSS custom properties on the `document`'s `body`.

```js:title=src/hooks/useMediaQuery.js
import { useEffect, useState } from 'react'

export const useMediaQuery = (query, cb) => {
  const [matches, setMatches] = useState(false)

  useEffect(() => {
    const qry = window.matchMedia(query)
    setMatches(qry.matches)

    const handleMatch = q => {
      setMatches(q.matches)
      if (cb instanceof Function) cb(q.matches)
    }

    qry.addListener(handleMatch)
    return () => qry.removeListener(handleMatch)
  }, [query, cb])

  return matches
}
```

## `DarkToggle`

The user-facing `DarkToggle` component provides a three-state button to choose between dark mode, light mode or auto in which case we fall back to the OS color mode. The latter is the default value and the component just cycles through these states when clicked.

It also displays a little notification with the name of the mode for one second below the mode's icon (sun, moon or sun-slash-moon for the auto setting). It uses [react-spring](https://github.com/react-spring/react-spring) to animate the icon transition between modes and a simple [CSS animation](https://developer.mozilla.org/en-US/docs/Web/CSS/animation) for the notifications.

<!-- TODO maybe restore this live example -->
<!-- <BorderBox>
  <DarkToggle />
</BorderBox> -->

```js:title=src/components/DarkToggle/index.js
import React from 'react'
import { useTransition } from 'react-spring'
import { useDarkMode } from 'hooks'
import { Box, Div, Icons, Notification } from './styles'

const modes = {
  light: [`Light Mode`, Icons.Sun, `dark`],
  dark: [`Dark Mode`, Icons.Moon, `auto`],
  auto: [`Auto`, Icons.SunMoon, `light`],
}

export default function DarkToggle(props) {
  const [colorMode, setColorMode] = useDarkMode()
  if (colorMode && ![`light`, `dark`, `auto`].includes(colorMode))
    console.error(`Invalid color mode: ${colorMode}`)

  const transitions = useTransition(colorMode, null, {
    initial: null,
    from: { opacity: 0, transform: `translateX(100%)` },
    enter: { opacity: 1, transform: `translateX(0%)` },
    leave: { opacity: 0, transform: `translateX(-100%)` },
  })

  return (
    <Box {...props}>
      {transitions.map(({ item, props: style, key }) => {
        // Since we can't know the value of media queries or localStorage during SSR,
        // defer any rendering of the toggle until after rehydration on the client.
        if (!item) return null
        const [title, Icon, nextMode] = modes[item]
        return (
          <Div key={key} style={style}>
            <Icon title={title} onClick={() => setColorMode(nextMode)} />
            <Notification>{title}</Notification>
          </Div>
        )
      })}
    </Box>
  )
}
```

The index file imports the following styled components:

```js:title=src/components/DarkToggle/styles.js
import React from 'react'
import { animated } from 'react-spring'
import styled from 'styled-components'
import { Moon, Sun } from 'styled-icons/fa-solid'

export const Box = styled.div`
  cursor: pointer;
  display: grid;
  > * {
    grid-area: 1/1;
  }
`

// Needed as a selector in Notification below.
export const Div = styled(animated.div)`
  svg {
    vertical-align: -0.1em;
  }
`

export const Notification = styled.div`
  position: absolute;
  top: calc(100% + 1em);
  width: max-content;
  color: white;
  text-align: center;
  background: rgba(0, 0, 0, 0.9);
  padding: 0.1em 0.3em;
  border-radius: 0.2em;
  left: 50%;
  transform: translateX(-50%);
  opacity: 0;
  transition: 0.5s;
  ${Div}:hover & {
    opacity: 1;
  }
`

const SunSlashMoon = props => (
  <svg {...props} viewBox="0 0 512 512" fill="currentColor">
    <path
      d="m283.211 512c78.962 0 151.079-35.925 198.857-94.792 7.068-8.708-.639-21.43-11.562-19.35-124.203 23.654-238.262-71.576-238.262-196.954 0-72.222 38.662-138.635 101.498-174.394 9.686-5.512 7.25-20.197-3.756-22.23-15.429-2.845-31.086-4.278-46.775-4.28-141.309 0-256 114.511-256 256 0 141.309 114.511 256 256 256z"
      transform="matrix(.556976 0 0 .499999 241.983 256)"
    />
    <path
      d="m256 160c-52.9 0-96 43.1-96 96s43.1 96 96 96 96-43.1 96-96-43.1-96-96-96zm246.4 80.5-94.7-47.3 33.5-100.4c4.5-13.6-8.4-26.5-21.9-21.9l-100.4 33.5-47.4-94.8c-6.4-12.8-24.6-12.8-31 0l-47.3 94.7-100.5-33.5c-13.6-4.5-26.5 8.4-21.9 21.9l33.5 100.4-94.7 47.4c-12.8 6.4-12.8 24.6 0 31l94.7 47.3-33.5 100.5c-4.5 13.6 8.4 26.5 21.9 21.9l100.4-33.5 47.3 94.7c6.4 12.8 24.6 12.8 31 0l47.3-94.7 100.4 33.5c13.6 4.5 26.5-8.4 21.9-21.9l-33.5-100.4 94.7-47.3c13-6.5 13-24.7.2-31.1zm-155.9 106c-49.9 49.9-131.1 49.9-181 0s-49.9-131.1 0-181 131.1-49.9 181 0 49.9 131.1 0 181z"
      transform="matrix(.550782 0 0 .550782 -.000096 -.000096)"
    />
    <path
      d="m384.097 72.796c0-1.543-1.579-2.796-3.524-2.796h-7.049c-1.945 0-3.524 1.253-3.524 2.796v407.408c0 1.543 1.579 2.796 3.524 2.796h7.049c1.945 0 3.524-1.253 3.524-2.796z"
      transform="matrix(.871418 .871418 -.891126 .891126 183.83 -308.963)"
    />
  </svg>
)

export const Icons = {
  Sun: props => <Sun css="transform: scale(1.05);" {...props} />,
  Moon: props => <Moon css="transform: scale(0.95);" {...props} />,
  SunMoon: props => <SunSlashMoon {...props} width={props.size} />,
}
```

## `onRenderBody`

Now comes the tricky SSR bit where we need to set the theme colors correctly based on the current preference prior to first paint and in particular before React even has a chance to load. As you might have guessed, that means we can only rely on browser APIs to accomplish this. No hooks, no Context API, nothing from React land will be available yet.

```js
import React from 'react'
import App from 'components/App'
import {
  COLORS,
  COLOR_MODE_KEY,
  INITIAL_COLOR_MODE_CSS_PROP,
} from 'utils/constants'

function setColorsByTheme() {
  // Don't use backticks around emojis. Breaks replacement in boundFn below.
  const [colors, colorModeKey, colorModeCssProp] = ['🌈', '🔑', '⚡️']
  // Default value if the user never used DarkToggle is to use the OS color mode.
  let colorMode = `auto`

  // Only try to parse value from localStorage if there is one.
  const persistedPreference =
    localStorage[colorModeKey] && JSON.parse(localStorage[colorModeKey])
  if ([`light`, `dark`, `auto`].includes(persistedPreference))
    colorMode = persistedPreference

  document.body.style.setProperty(colorModeCssProp, colorMode)

  // Here we set the actual colors for the page after SSR.
  // colorByMode only supports `dark` or `light`. So if colorMode
  // is `auto` we pick either of those depending on prefersDarkFromMQ.
  if (colorMode === `auto`) {
    const mq = window.matchMedia(`(prefers-color-scheme: dark)`)
    const prefersDarkFromMQ = mq.matches
    colorMode = prefersDarkFromMQ ? `dark` : `light`
  }

  for (const [name, colorByMode] of Object.entries(colors))
    document.body.style.setProperty(`--color-${name}`, colorByMode[colorMode])
}

function RssSetColorsByTheme() {
  const boundFn = String(setColorsByTheme)
    .replace(`'🌈'`, JSON.stringify(COLORS))
    .replace(`🔑`, COLOR_MODE_KEY)
    .replace(`⚡️`, INITIAL_COLOR_MODE_CSS_PROP)

  // Turn boundFn into an IIFE so it runs asap. Also avoids polluting global namespace.
  return <script dangerouslySetInnerHTML={{ __html: `(${boundFn})()` }} />
}

// If the user disabled JS, the injected script setColorsByTheme will
// never run and no colors will be set. Everything will be default
// black and white. By injecting a `<style>` tag into the head of the
// document, we can set default values for all of our colors. Only
// light mode will be available for users with JS disabled.
function FallbackStyles({ cssColors = `` }) {
  // Create a string holding each CSS variable:
  // `--color-text: black;\n--color-background: white;\n...`

  for (const [name, colorByMode] of Object.entries(COLORS))
    cssColors += `--color-${name}: ${colorByMode.light};\n`

  const wrappedInSelector = `html { ${cssColors} }`

  return <style>{wrappedInSelector}<\/style>
}

export const onRenderBody = ({ setPreBodyComponents, setHeadComponents }) => {
  // Keys just to prevent warning: Each child in a list should have a unique "key" prop.
  setHeadComponents(<FallbackStyles key="foo" />)
  setPreBodyComponents(<RssSetColorsByTheme key="bar" />)
}

export const wrapPageElement = ({ element, props }) => {
  return <App {...props}>{element}</App>
}
```

## Using CSS custom props

So much for the all of the infrastructure. All we need to do now is write some components that actually make use of our CSS custom color properties and thereby become responsive to the currently active color mode.

I use styled-component's `createGlobalStyle` for this combined with Gatsby's `wrapPageElement` API which we need to implement in both `gatsby-ssr.js` and `gatsby-browser.js`.

```js:title=src/components/Global.js
import React from 'react'
import { createGlobalStyle } from 'styled-components'
import { graphql, useStaticQuery } from 'gatsby'

const GlobalStyle = createGlobalStyle`
  body {
    background: var(--color-background);
    color: var(--color-text);
    a {
      color: var(--color-link);
      :hover {
        color: var(--color-link-hover);
      }
    }
  }
`

export function PageComponents({ children, ...rest }) {
  const { site } = useStaticQuery(graphql`
    {
      site {
        site: siteMetadata {
          title
          url
          description
        }
      }
    }
  `)
  return (
    <>
      <GlobalStyle /> // highlight-line
      <Seo {...site} {...rest} />
      <Header {...site} />
      {children}
      <Footer />
    </>
  )
}
```

```js:title=gatsby-ssr.js
import { PageComponents } from 'components/Global'

export const wrapPageElement = ({ element, props }) => {
  return <PageComponents {...props}>{element}</PageComponents>
}
```

```js:title=gatsby-browser.js
import { PageComponents } from 'components/Global'

export const wrapPageElement = ({ element, props }) => {
  return <PageComponents {...props}>{element}</PageComponents>
}
```

## Conclusion

To be honest, implementing a dark mode using React hooks from start to finish took way longer and involved many more complications than I had originally anticipated. All the more reason to write this up in a blog post, right? Hopefully this is helpful to other's in the future. If you have questions, let me know in the comments!
