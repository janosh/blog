import styled from 'styled-components'
import { fadeInOnHoverParent } from './'

export const Caption = styled.figcaption`
  position: absolute;
  bottom: 0;
  right: 1em;
  font-size: 0.7em;
  transition: 0.3s;
  color: white;
  padding: 0.2em 0.6em;
  background: rgba(0, 0, 0, 0.7);
  border-radius: 0.5em 0.5em 0 0;
  ${props =>
    props.showOnHoverParent && fadeInOnHoverParent(props.showOnHoverParent)};
`
