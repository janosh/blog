import React from "react"

import { Track, Thumb, SunIcon, MoonIcon, Reset } from "./styles"

export default function Toggle({ children, checked, onClick, ...rest }) {
  const { size = `1em`, withReset } = rest
  return (
    <Track {...{ size, onClick, withReset }}>
      <Thumb {...{ size, checked }} />
      {children}
    </Track>
  )
}

export const DarkModeToggle = ({ darkMode, setDarkMode }) => (
  <Toggle
    withReset
    {...{ checked: darkMode, onClick: () => setDarkMode(!darkMode) }}
  >
    <SunIcon title="Light Mode" />
    <MoonIcon title="Dark Mode" />
    <Reset
      title="Reset dark mode. Falls back to OS dark mode setting."
      onClick={event => event.stopPropagation() || setDarkMode()}
    />
  </Toggle>
)
