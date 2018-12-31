import styled, { css } from 'styled-components'
import { ArrowUpCircle } from 'styled-icons/feather/ArrowUpCircle'
import { ArrowDownCircle } from 'styled-icons/feather/ArrowDownCircle'

const justify = props => {
  switch (props.justify) {
    case 'left':
      return `left: 1em;`
    case 'right':
      return `right: 1em;`
    case 'center':
    default:
      return `left: calc(50vw - ${props.size} / 2);`
  }
}

const arrow = css`
  z-index: 2;
  background: ${props => props.theme.lightGreen};
  color: ${props => props.theme.white};
  border-radius: 50%;
  transition: ${props => props.theme.shortTrans};
  width: ${props => props.size};
  position: ${props => props.position};
  bottom: 1em;
  ${props => justify(props)};
  opacity: ${props => (props.show ? 1 : 0)};
  visibility: ${props => (props.show ? 'visible' : 'hidden')};
  :hover {
    transform: scale(1.15);
    background: ${props => props.theme.orange};
  }
`

export const UpArrow = styled(ArrowUpCircle)`
  ${arrow};
`

export const DownArrow = styled(ArrowDownCircle)`
  ${arrow};
`

export const Arrows = {
  up: UpArrow,
  down: DownArrow,
}
