import styled, { css } from 'styled-components'
import { Grid } from 'components/styles'
import { mediaQueries } from 'utils/mediaQueries'

const asRow = css`
  grid-column: 2/-2;
  grid-auto-flow: column;
  overflow: scroll;
  grid-auto-columns: 18em;
  padding: 1em;
`

const inBlog = css`
  ${mediaQueries.maxPhablet} {
    grid-column: 3;
    justify-self: center;
  }
  ${mediaQueries.minPhablet} {
    grid-column: 2/-3;
  }
`

export const PostGrid = styled(Grid)`
  height: max-content;
  ${props => props.asRow && asRow};
  ${props => props.inBlog && inBlog};
`
