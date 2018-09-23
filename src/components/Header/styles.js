import styled, { css } from 'styled-components'
import { Link } from 'gatsby'

import mediaQuery from '../../utils/mediaQuery'

const transparent = css`
  position: absolute;
  background: rgba(0, 0, 0, 0.5);
  width: fill-available;
  z-index: 2;
`

const opaque = css`
  background: ${props => props.theme.darkBlue};
`

export const Container = styled.div`
  ${props => (props.transparent ? transparent : opaque)};
  display: grid;
  grid-gap: 5vmin;
  align-items: center;
  justify-content: space-between;
  grid-template-areas: 'nav title social';
  padding: 2vmin 3vmin;
  ${mediaQuery.minPhablet} {
    grid-template-areas: 'title nav social';
    grid-template-columns: auto 1fr auto;
  }
`

export const Logo = styled(Link)`
  grid-area: title;
  font-size: 2.4em;
  color: white;
  transform: scale(1, 0.85);
`
