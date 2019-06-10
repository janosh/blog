import { css } from "styled-components"

export { ButtonGroup } from "./ButtonGroup"
export { PageBody } from "./PageBody"
export { Grid } from "./Grid"
export { Caption } from "./Caption"

export const fadeInOnHoverParent = parent => css`
  opacity: 0;
  visibility: hidden;
  transition: ${props => props.theme.shortTrans};
  pointer-events: none;
  ${parent}:hover & {
    opacity: 1;
    visibility: visible;
    pointer-events: initial;
  }
`
