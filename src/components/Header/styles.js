import { Link } from 'gatsby'
import styled from 'styled-components'
import mediaQuery from 'utils/mediaQuery'

export const HeaderDiv = styled.header`
  background: var(--color-b);
  display: grid;
  grid-gap: calc(1em + 1vw);
  z-index: 3;
  align-items: center;
  justify-content: space-between;
  padding: 1em;
  color: white;
  font-size: 1.2em;
  grid-template-columns: 1fr auto auto;
  grid-template-areas: 'title darkmode search';
  justify-items: start;
  border-bottom: 1px solid var(--color-a);
  ${mediaQuery.minPhablet} {
    grid-template-columns: auto 1fr auto auto;
  }
`

export const Logo = styled(Link)`
  font-size: 2.4em;
  transform: scale(1, 0.85);
  color: inherit;
`
