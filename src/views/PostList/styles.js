import styled, { css } from "styled-components"

import Grid from "../../components/styles/Grid"
import mediaQuery from "../../utils/mediaQuery"

const asRow = css`
  grid-column: 2/-2;
  grid-auto-flow: column;
  overflow: scroll;
  grid-auto-columns: 18em;
  padding: 1em;
`
const inBlog = css`
  ${mediaQuery.maxPhablet} {
    grid-column: 3;
    justify-self: center;
  }
  ${mediaQuery.minPhablet} {
    grid-row: 1;
    grid-column: 2/-3;
  }
`

export const PostGrid = styled(Grid)`
  height: max-content;
  ${props => props.asRow && asRow};
  ${props => props.inBlog && inBlog};
`
