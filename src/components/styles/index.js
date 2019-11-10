import { css } from 'styled-components'

export * from './ButtonGroup'
export * from './Caption'
export * from './Grid'
export * from './PageBody'
export * from './BorderBox'

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
