import styled from 'styled-components'

import mediaQuery from '../../utils/mediaQuery'

export const FooterContainer = styled.footer`
  background-color: ${props => props.theme.darkGray};
  padding: 5vh 5vw;
  color: ${props => props.theme.white};
  a {
    color: ${props => props.theme.lightBlue};
    :hover {
      color: ${props => props.theme.orange};
    }
  }
  display: grid;
  justify-items: center;
  align-items: center;
  grid-template-areas:
    'cpr'
    'source'
    'poweredBy';
  grid-gap: 4vh 6vw;
  ${mediaQuery.minPhone} {
    grid-template-areas:
      'cpr source'
      'poweredBy poweredBy';
  }
  ${mediaQuery.minTablet} {
    grid-template-areas: 'cpr source poweredBy';
  }
`

export const Cpr = styled.span`
  grid-area: cpr;
`

export const Source = styled.span`
  grid-area: source;
`

export const PoweredBy = styled.div`
  grid-area: poweredBy;
  display: grid;
  grid-auto-flow: column;
  grid-auto-columns: max-content;
  grid-gap: 1em;
  a {
    height: 1.5em;
    width: 1.5em;
  }
`
