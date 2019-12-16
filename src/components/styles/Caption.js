import styled from 'styled-components'
import { fadeInOnHoverParent } from './'

export const Caption = styled.figcaption`
  position: absolute;
  bottom: 0;
  right: 1em;
  font-size: 0.8em;
  transition: ${props => props.theme.shortTrans};
  color: white;
  padding: 0.1em 0.5em;
  background: rgba(0, 0, 0, 0.7);
  border-radius: ${props => (props.theme.mediumBorderRadius + ` `).repeat(2)} 0 0;
  a {
    color: ${props => props.theme.lighterBlue};
    transition: 0.3s;
    :hover {
      color: ${props => props.theme.orange};
    }
  }
  ${props =>
    props.showOnHoverParent && fadeInOnHoverParent(props.showOnHoverParent)};
`
