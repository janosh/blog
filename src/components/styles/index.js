import { css } from "styled-components"

export * from "./ButtonGroup"
export * from "./PageBody"
export * from "./Grid"
export * from "./Caption"

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
