import React from 'react'
import { useTransition } from 'react-spring'
import { useDarkMode } from '../../hooks'
import { Box, Div, Icons, Notification } from './styles'

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
          <Div key={key} style={props}>
            <Icon title={title} onClick={() => setColorScheme(nextMode)} />
            <Notification>
              {title}
              {item === `noPreference` && (
                <a href="/blog/use-dark-mode">
                  <Icons.info />
                </a>
              )}
            </Notification>
          </Div>
        )
      })}
    </Box>
  )
}
