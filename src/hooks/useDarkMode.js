import { useLocalStorage, useMediaQuery } from 'hooks'
import { useEffect, useCallback } from 'react'
import {
  COLOR_MODE_KEY,
  INITIAL_COLOR_MODE_CSS_PROP,
  MODE_COLORS,
} from 'utils/constants'

const setBodyColors = mode => {
  for (const [name, colorByMode] of Object.entries(MODE_COLORS)) {
    document.body.style.setProperty(`--color-${name}`, colorByMode[mode])
  }
}

export const useDarkMode = () => {
  const [colorMode, setLSColorMode] = useLocalStorage(COLOR_MODE_KEY)

  const prefersDarkFromMQ = useMediaQuery(
    `(prefers-color-scheme: dark)`,
    useCallback(prefersDark => setBodyColors(prefersDark ? `dark` : `light`), [])
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
    // https://stackoverflow.com/a/61735300
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  function setColorMode(newValue) {
    setLSColorMode(newValue)

    // This reassignment happens after setLSColorMode because `osPref`
    // is a valid value for persisting but not for the actual color mode.
    if (newValue === `osPref`) {
      newValue = prefersDarkFromMQ ? `dark` : `light`
    }

    setBodyColors(newValue)
  }

  return [colorMode, setColorMode]
}
