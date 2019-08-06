import { useLocalStorage, useMediaQuery } from '.'

export const useDarkMode = (initialValue = `noPreference`) => {
  const [colorMode, setColorMode] = useLocalStorage(`colorMode`, initialValue)
  const setter = value => {
    // Add color and background transition to body here to prevent
    // flashing from light to dark on initial page load.
    document.body.style.transition = `color 0.5s, background 0.5s`
    setColorMode(value)
  }

  // Check if the user has an OS preference for dark mode.
  const prefersDarkMode = useMediaQuery(`(prefers-color-scheme: dark)`)

  // Dark mode is enabled if either the color scheme was set to dark
  // by the user or the media query `prefers-color-scheme: dark` is true.
  const darkModeEnabled = colorMode === `dark` || prefersDarkMode
  return [darkModeEnabled, colorMode, setter]
}
