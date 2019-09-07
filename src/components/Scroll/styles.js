import styled from 'styled-components'
import { ArrowDownCircle as Down } from 'styled-icons/feather/ArrowDownCircle'
import { ArrowUpCircle as Up } from 'styled-icons/feather/ArrowUpCircle'

export const Arrow = styled(Down).attrs(props => ({
  as: props.direction === `up` && Up,
}))`
  background: ${props => props.theme.lightGreen};
  color: white;
  border-radius: 50%;
  transition: ${props => props.theme.shortTrans};
  position: absolute;
  bottom: 1em;
  right: calc(50vw - ${props => props.size} / 2);
  opacity: ${props => (props.show ? 1 : 0)};
  visibility: ${props => (props.show ? `visible` : `hidden`)};
  width: ${props => props.size};
  height: ${props => props.size};
  :hover {
    transform: scale(1.15);
    background: ${props => props.theme.orange};
  }
`
