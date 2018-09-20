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
