---
title: useDarkMode
subtitle: React hook for adding dark color schemes
slug: /use-dark-mode
date: 2019-07-01
cover:
  img: useDarkMode.svg
tags:
  - JS
  - Tutorial
  - Web Dev
showToc: true
---

All the cool kids these days have websites with a dark color scheme. The really cool kids even have a dark *and* a light mode and allow you, the valued reader, to choose. In an attempt to make it easier for everyone to attain the status of really cool kid, I'll share my implementation of a dark mode for this very site. You can try it out by clicking the sun/moon icon in the header above.

In fact we'll even go a step further and use the new [`prefers-color-scheme`](https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-color-scheme) media query which just [recently landed in Safari, Firefox, Chrome and Edge](https://caniuse.com/#search=prefers-color-scheme). It will allow us to query the user's OS for a color scheme preference. So if the user's device is set to dark mode, your site will automatically respect that and display in dark mode as well.

Here's an overview of everything we're going to build to achieve this:

1. The user-facing component [`DarkMode`](#darkmode) allows to pick either the dark or light color scheme or to reset the preference. In that case, we'll go back to querying the OS setting. All the logic to achieve this will be abstracted out of this component with React hooks.

2. The [`useDarkMode`](#usedarkmode) hook informs the `DarkMode` component which color scheme the user prefers and provides a setter function to change the current setting.

3. The [`useLocalStorage`](#uselocalstorage) hook is called by `useDarkMode` to persist the user's preference in `localStorage` across visits to your site.

4. The [`useMediaQuery`](#usemediaquery) hook allows us to check the `prefers-color-scheme` setting of the reader's device.

It turns out implementing a dark mode is a perfect use case for hooks as it really makes hook composability shine. Or as Gabe Ragland on [usehooks.com](https://usehooks.com) put it:

> It's almost as if hooks bring the compositional power of React components to stateful logic! 🤯

By the way, you should really check out [usehooks.com](https://usehooks.com). They offer another structurally -- although not feature-wise -- [similar implementation of `useDarkMode`](https://usehooks.com/useDarkMode).

Anyway, with this overview out of the way, let's get cracking.

## `DarkMode`

The user-facing `DarkMode` component provides a three-state button to choose between dark mode, light mode or the OS setting. The latter is the default value and the component just cycles through these states when clicked.

It also displays a little notification with the name of the mode for one second below the mode's icon (a sun for light, moon for dark and a sun and moon separated by a slash for the OS setting). It uses [react-spring](https://github.com/react-spring/react-spring) to animate the icon transition between modes and a simple [CSS animation](https://developer.mozilla.org/en-US/docs/Web/CSS/animation) for the notifications.

```js:title=src/components/DarkMode/index.js
import React from 'react'
import { animated, useTransition } from 'react-spring'
import { useDarkMode } from '../../hooks'
import { Box, Icons, Notification } from './styles'

export default function DarkMode() {
  const [colorScheme, setColorScheme] = useDarkMode().slice(1)
  const Modes = {
    light: { Icon: Icons.light, title: `Light Mode`, nextMode: `dark` },
    dark: { Icon: Icons.dark, title: `Dark Mode`, nextMode: `noPreference` },
    noPreference: {
      Icon: Icons.noPref,
      title: `Use OS setting`,
      nextMode: `light`,
    },
  }
  const transitions = useTransition(colorScheme, null, {
    initial: null,
    from: { opacity: 0, transform: `translateX(100%)` },
    enter: { opacity: 1, transform: `translateX(0%)` },
    leave: { opacity: 0, transform: `translateX(-100%)` },
  })
  return (
    <Box>
      {transitions.map(({ item, props, key }) => {
        const { Icon, title, nextMode } = Modes[item]
        return (
          <animated.div key={key} style={props}>
            <Icon title={title} onClick={() => setColorScheme(nextMode)} />
            <Notification>
              {title}
            </Notification>
          </animated.div>
        )
      })}
    </Box>
  )
}
```

The index file imports the following styled components:

```js:title=src/components/DarkMode/styles.js
import React from 'react'
import styled from 'styled-components'
import { Moon } from 'styled-icons/fa-solid/Moon'
import { Sun } from 'styled-icons/fa-solid/Sun'
import { Info } from 'styled-icons/icomoon/Info'

export const Box = styled.div`
  display: grid;
  > * {
    /* for vertical centering */
    display: flex;
    grid-area: 1/1;
  }
`

export const Notification = styled.div`
  position: absolute;
  top: calc(100% + 1em);
  width: max-content;
  background: rgba(0, 0, 0, 0.9);
  padding: 0 0.4em;
  border-radius: 0.2em;
  left: 50%;
  transform: translateX(-50%);
  animation: fade-in-out 2s forwards;
  &:hover {
    animation-play-state: paused;
  }
  @keyframes fade-in-out {
    0% {
      opacity: 0;
    }
    25% {
      opacity: 1;
    }
    75% {
      opacity: 1;
    }
    100% {
      opacity: 0;
    }
  }
`

const SunSlashMoon = props => (
  <svg
    viewBox="0 0 512 512"
    {...props}
    fill="currentColor"
    style={{ transform: `scale(1.2)`, height: `1em` }}
  >
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
      transform="matrix(1.25716 1.25716 -.891126 .891126 38.3872 -454.406)"
    />
  </svg>
)

const iconProps = {
  size: `1em`,
  css: `cursor: pointer;`,
}

export const Icons = {
  light: props => <Sun {...iconProps} {...props} />,
  dark: props => <Moon {...iconProps} {...props} />,
  noPref: props => <SunSlashMoon {...iconProps} {...props} />,
  info: props => (
    <Info size="1em" css="margin-left: 0.3em; color: white;" {...props} />
  ),
}
```

## `useDarkMode`

The `useDarkMode` hook imported in `DarkMode/index.js` reads as follows.

```js:title=src/hooks/useDarkMode.js
import { useLocalStorage, useMediaQuery } from '.'

export const useDarkMode = (initialValue = `noPreference`) => {
  const [colorScheme, setColorScheme] = useLocalStorage(
    `colorScheme`,
    initialValue
  )
  const setter = value => {
    // Add half-second transitions to the body's color and background
    // properties here rather than in CSS to prevent flashing from
    // light to dark on initial page load.
    document.body.style.transition = `color 0.5s, background 0.5s`
    setColorScheme(value)
  }

  // Check if the user has an OS preference for dark mode.
  const prefersDarkMode = useMediaQuery(`(prefers-color-scheme: dark)`)

  // Dark mode is enabled if either the color scheme was set to dark
  // by the user or the media query `prefers-color-scheme: dark` is true.
  const darkModeEnabled = colorScheme === `dark` || prefersDarkMode
  return [darkModeEnabled, colorScheme, setter]
}
```

It in turn imports the `useLocalStorage` and `useMediaQuery` hooks.

## `useLocalStorage`

The `useLocalStorage` hook looks a little complicated at first but that's mostly just because it contains some event dispatching and listening that makes it (and by extension `useDarkMode`) global. By global I mean that all invocations of `useLocalStorage` with the same `key` will stay in sync. If one changes the value associated with `key` at one call site, all others will update to this value as well.

This is quite useful for implementing dark mode (and probably other use cases) because the component that controls the site's color scheme might be much further up the component tree than the user-facing component `DarkMode` which actually changes the color scheme setting. This way you don't have to use [React's Context API](https://reactjs.org/docs/context.html) or pass the value and setter function for `colorScheme` down a component chain.

```js:title=src/hooks/useLocalStorage.js
import { useState } from 'react'

export const useLocalStorage = (key, initialValue, options = {}) => {
  const { deleteKeyIfValueIs = null } = options
  // We pass useState a function that handles initial state
  // creation. That way, the function is executed only once.
  const [storedValue, setStoredValue] = useState(() => {
    if (typeof localStorage !== `undefined`) {
      // Register global event listener on initial state creation.
      // This allows us to react to change events emitted by setValue
      // below. That way we can keep storedValue in sync between
      // multiple call sites to useLocalStorage with the same key.
      // Whenever the value of key in localStorage is changed anywhere
      // in the application, all storedValues with that key will
      // reflect the change.
      document.addEventListener(`localStorage:${key}Change`, event =>
        // The new value set somewhere else in the app is saved as the
        // event.detail attribute in CustomEvent below.
        setStoredValue(event.detail)
      )
      const item = localStorage[key]
      if (!item) localStorage[key] = JSON.stringify(initialValue)
      return item ? JSON.parse(item) : initialValue
    } else return initialValue
  })
  const setValue = value => {
    // allow value to be a function which takes the current value
    // to conform to useState API
    const valueToStore = value instanceof Function ? value(storedValue) : value
    setStoredValue(valueToStore)
    const event = new CustomEvent(`localStorage:${key}Change`, {
      detail: valueToStore,
    })
    document.dispatchEvent(event)
    if (value === deleteKeyIfValueIs) delete localStorage[key]
    else localStorage[key] = JSON.stringify(valueToStore)
  }
  return [storedValue, setValue]
}
```

## `useMediaQuery`

Last but not least in our list of hooks is `useMediaQuery`. It uses the [`window.matchMedia` API](https://developer.mozilla.org/en-US/docs/Web/API/Window/matchMedia) to parse the `query` string and turn it into a [`MediaQueryList`](https://developer.mozilla.org/en-US/docs/Web/API/MediaQueryList) object. It then calls `useState` to instantiate a boolean `match` indicating whether the query currently matches and registers an event listener to update that variable whenever the state of the `query` changes.

The check ``typeof window !== `undefined` `` is just there to ensure this hook plays nicely with server-side rendering where `window` will be unavailable. If you don't need SSR, just get rid of it.

```js:title=src/hooks/useLocalStorage.js
import { useEffect, useState } from 'react'

// React hook for JS media queries
export const useMediaQuery = query => {
  if (typeof window !== `undefined`) {
    query = window.matchMedia(query)
    const [match, setMatch] = useState(query.matches)
    useEffect(() => {
      const handleMatch = q => setMatch(q.matches)
      query.addListener(handleMatch)
      return () => query.removeListener(handleMatch)
    }, [query])
    return match
  }
}
```

## Controlling the site's theme

So much for the all of the infrastructure. All we need to do now is call `useDarkMode` in the component that controls the site's color theme and turn that theme into a function that returns different colors depending on which color scheme is currently enabled. In my case that component is called `Global`.

```js:title=src/components/Global/index.js
import { graphql, useStaticQuery } from 'gatsby'
import React from 'react'
import { ThemeProvider } from 'styled-components'
import { useDarkMode } from '../../hooks'
import theme from '../../utils/theme'
import App from '../App'
import { GlobalStyle } from './styles'

export default function Global() {
  const darkMode = useDarkMode()[0]
  return (
    <ThemeProvider theme={theme(darkMode)}>
      <>
        <GlobalStyle />
        <App />
      </>
    </ThemeProvider>
  )
}
```

The `theme` function is very simple.

```js:title=src/utils/theme.js

export default darkMode =>
  darkMode ? { ...theme, ...darkTheme } : { ...theme, ...lightTheme }
```

with the objects `theme`, `lightTheme` and `darkTheme` looking something like this

```js
export const theme = {
  blue: `#2202a9`,
  darkBlue: `#190c65`,
  darkerBlue: `#150956`,
  darkestBlue: `#0f073b`,
  lightBlue: `#1f59cd`,
  lighterBlue: `#279AF1`,
  lightestBlue: `#83aaff`,

  green: `#3f7912`,
  darkGreen: `#0c511a`,
  lightGreen: `#00d69b`,
  paleDarkGreen: `#104F55`,

  yellow: `#f9ff00`,
  darkYellow: `#d0d500`,
  lightYellow: `#fbff6c`,

  orange: `#efbf00`,
  darkOrange: `#ff9100`,
  lightOrange: `#ffbe41`,

  gray: `#464849`,
  darkGray: `#3d3d3d`,
  darkerGray: `#1a1d23`,
  darkestGray: `#060606`,
  lightGray: `#bcbcbc`,
  lighterGray: `#e5e5e5`,
  lightestGray: `#f7f7f7`,
}

export const lightTheme = {
  background: `white`,
  textColor: `black`,
  quoteBg: theme.lightestGray,

  links: theme.blue,
  hoveredLinks: theme.orange,

  shadowColor: theme.lighterGray,
  borderColor: theme.lighterGray,

  headerBg: theme.darkerBlue,
  footerBg: theme.darkerGray,

  buttonBg: theme.blue,
  hoveredButtonBg: theme.lightBlue,
  grayButtonBg: theme.lightestGray,
  grayHoveredButtonBg: theme.orange,

  inlineCodeColor: theme.lighterGray,
}

export const darkTheme = {
  background: theme.darkerGray,
  textColor: theme.lighterGray,
  quoteBg: theme.darkestGray,

  links: theme.lighterBlue,
  hoveredLinks: theme.orange,

  shadowColor: `black`,
  borderColor: `black`,

  headerBg: theme.darkestBlue,
  footerBg: theme.darkestGray,

  buttonBg: theme.darkGreen,
  hoveredButtonBg: theme.green,
  grayButtonBg: theme.darkGray,
  grayHoveredButtonBg: theme.orange,

  inlineCodeColor: theme.darkGray,
}
```

As you can see, they each specify different values for parts of the site that are color-scheme dependent. Thanks to [`styled-components`'s ThemeProvider](https://www.styled-components.com/docs/api#themeprovider) any part of your site below `Global` in the component tree can then simply consume this theme. For instance the `GlobalStyle` component above does this as follows.

```js
import { createGlobalStyle } from 'styled-components'

export const GlobalStyle = createGlobalStyle`
  body {
    margin: 0;
    hyphens: auto;
    /* below rules enable dark mode */
    background: ${props => props.theme.background};
    color: ${props => props.theme.textColor};
    a {
      text-decoration: none;
      color: ${props => props.theme.links};
      :hover {
        color: ${props => props.theme.hoveredLinks};
      }
    }
  }
`
```

## Conclusion

So there you have it. Implementing a dark mode using React hooks and styled-components from start to finish. To be honest, this took more work and thought than I had originally anticipated but all the more reason to write this up in a blog post, right? I hope this makes it easier for other's in the future. Definitely let me know in the comments if anything is unclear and and could do with some further explanation.
