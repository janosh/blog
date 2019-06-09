import { useMediaQuery, useLocalStorage } from "."

export const useDarkMode = () => {
  const [darkMode, setDarkMode] = useLocalStorage(`darkMode`)
  const setter = value => {
    // Add color and background transition to body here to prevent
    // flashing from light to dark on initial page load.
    document.body.style.transition = `color 0.5s, background 0.5s`
    setDarkMode(value)
  }

  // Check if user has an OS preference for dark mode.
  const prefersDarkMode = useMediaQuery(`(prefers-color-scheme: dark)`)

  // If darkMode was found in local storage use it, else fallback to prefersDarkMode.
  // Allows user to override OS setting.
  const enabled = typeof darkMode !== `undefined` ? darkMode : prefersDarkMode
  return [enabled, setter]
}
