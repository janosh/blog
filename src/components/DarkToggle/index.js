import React from 'react'
import { useTransition } from 'react-spring'
import { useDarkMode } from 'hooks'
import { Box, Div, Icons, Notification } from './styles'

const modes = {
  light: [`Light Mode`, Icons.Sun, `dark`],
  dark: [`Dark Mode`, Icons.Moon, `osPref`],
  osPref: [`OS setting`, Icons.SunMoon, `light`],
}

export default function DarkToggle({ size = `1em`, ...rest }) {
  const [colorMode, setColorMode] = useDarkMode()
  if (colorMode && ![`light`, `dark`, `osPref`].includes(colorMode))
    console.error(`Invalid color mode: ${colorMode}`)

  const transitions = useTransition(colorMode, null, {
    initial: null,
    from: { opacity: 0, transform: `translateX(100%)` },
    enter: { opacity: 1, transform: `translateX(0%)` },
    leave: { opacity: 0, transform: `translateX(-100%)` },
  })

  return (
    <Box {...rest}>
      {transitions.map(({ item, props: style, key }) => {
        // Since we can't know the value of media queries or localStorage during SSR,
        // defer any rendering of the toggle until after rehydration on the client.
        if (!item) return null
        const [title, Icon, nextMode] = modes[item]
        return (
          <Div key={key} style={style}>
            <Icon size={size} title={title} onClick={() => setColorMode(nextMode)} />
            <Notification>{title}</Notification>
          </Div>
        )
      })}
    </Box>
  )
}
