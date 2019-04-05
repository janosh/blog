import styled from "styled-components"
import { Link } from "gatsby"

import mediaQuery from "../../utils/mediaQuery"

export const HeaderContainer = styled.header`
  background: ${props => props.theme.darkBlue};
  display: grid;
  grid-gap: 3vw;
  z-index: 2;
  justify-items: center;
  align-items: center;
  justify-content: space-between;
  grid-template-areas: "nav title social search";
  grid-template-columns: auto 1fr auto auto;
  padding: 2vmin 3vmin;
  ${mediaQuery.minPhablet} {
    justify-items: start;
    grid-template-areas: "title nav social search";
  }
`

export const Logo = styled(Link)`
  grid-area: title;
  font-size: 2.4em;
  color: white;
  transform: scale(1, 0.85);
`
