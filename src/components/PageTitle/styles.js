import Image from 'gatsby-image'
import styled from 'styled-components'

export const PageTitleDiv = styled.hgroup`
  position: relative;
  color: white;
  /* Use flex instead of grid. Else Safari messes up vertical alignment of children. */
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-content: center;
  min-height: 20em;
  flex: 1; /* for filling height between header and footer on 404 page */
  font-size: calc(1em + 0.5vw);
  text-align: center;
  overflow: hidden;
  /* prettier-ignore */
  > :not(:first-child):not(svg):not(figcaption) {
    justify-self: center;
    max-width: 30em;
    background: rgba(0, 0, 0, 0.7);
    border-radius: 0.2em;
    padding: 0.1em 0.4em;
    margin-right: auto;
    margin-left: auto;
  }
  a {
    color: var(--color-lightLink);
  }
`

export const Img = styled(Image).attrs(
  ({ fluid, src }) => !fluid && src && { as: `img` }
)`
  position: absolute !important;
  z-index: -1;
  width: 100%;
  height: 100%;
  object-fit: cover;
`
