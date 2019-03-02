import styled from "styled-components"

import Grid from "../../components/styles/Grid"
import mediaQuery from "../../utils/mediaQuery"

export const PostGrid = styled(Grid)`
  height: max-content;
  ${mediaQuery.maxPhablet} {
    grid-column: 3;
    justify-self: center;
  }
  ${mediaQuery.minPhablet} {
    grid-row: 1;
    grid-column: 2/-3;
  }
`
