import styled from 'styled-components'
import { ArrowDownCircle as Down, ArrowUpCircle as Up } from 'styled-icons/feather'

export const Arrow = styled(Down).attrs(props => ({
  as: props.direction === `up` && Up,
}))`
  background: var(--color-green-light);
  color: white;
  border-radius: 50%;
  transition: 0.3s;
  position: absolute;
  bottom: 1em;
  right: calc(50vw - ${props => props.size} / 2);
  opacity: ${props => (props.show ? 1 : 0)};
  visibility: ${props => (props.show ? `visible` : `hidden`)};
  width: ${props => props.size};
  height: ${props => props.size};
  :hover {
    transform: scale(1.15);
    background: var(--color-orange-default);
  }
`
