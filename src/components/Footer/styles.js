import styled from 'styled-components'

import mediaQuery from '../../utils/mediaQuery'

export const Container = styled.footer`
  background-color: ${props => props.theme.darkGray};
  padding: 5vh 5vw;
  color: ${props => props.theme.mainWhite};
  display: grid;
  justify-items: center;
  grid-gap: 4vh 6vw;
  ${mediaQuery.minPhone} {
    grid-auto-flow: column;
    justify-content: center;
  }
`
