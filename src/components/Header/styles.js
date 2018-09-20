import styled, { css } from 'styled-components'
import { Link } from 'gatsby'

import mediaQuery from '../../utils/mediaQuery'
import LogoComp from '../../assets/logo'

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

export const SiteTitle = styled(Link)`
  grid-area: title;
  height: 3em;
  width: 3em;
  background: ${props => props.theme.mainWhite};
`

export const Logo = styled(LogoComp)`
  height: 3em;
  width: 3em;
  object-fit: cover;
  object-position: top;
  border-radius: 50%;
  border: ${({ theme }) => theme.smallBorder + ' solid ' + theme.mainWhite};
`
