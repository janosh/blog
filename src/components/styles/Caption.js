import styled, { css } from "styled-components"

const Caption = styled.figcaption`
  position: absolute;
  bottom: 0;
  right: 1em;
  font-size: 0.8em;
  transition: ${props => props.theme.shortTrans};
  color: ${props => props.theme.white};
  padding: 0.1em 0.5em;
  background: rgba(0, 0, 0, 0.7);
  border-radius: ${props => (props.theme.mediumBorderRadius + ` `).repeat(2)} 0
    0;
  a {
    color: ${props => props.theme.lightBlue};
    transition: ${props => props.theme.shortTrans};
    :hover {
      color: ${props => props.theme.orange};
    }
  }
  ${props =>
    props.showOnHoverParent &&
    css`
      visibility: hidden;
      opacity: 0;
      ${props.showOnHoverParent}:hover & {
        visibility: visible;
        opacity: 1;
      }
    `}
`

export default Caption
