import styled from 'styled-components'
import { Link } from 'gatsby'

import mediaQuery from '../../utils/mediaQuery'

export const Container = styled.header`
  color: ${props => props.theme.mainWhite};
  display: flex;
  flex-direction: column;
  align-items: center;
  margin: 10vh 0;
  a {
    color: inherit;
  }
`

export const Title = styled.h1`
  text-align: center;
  margin: 1rem;
  ${mediaQuery.minTablet} {
    margin: 3rem;
    /* font-size: 2rem; */
  }
`

export const BackLink = styled(Link)`
  display: block;
  margin-top: 2rem;
  width: max-content;
  padding: 0.2rem 0.6rem;
  border-radius: ${props => props.theme.largeBorderRadius};
  border: ${props => props.theme.smallBorder} solid;
  background: rgba(0, 0, 0, 0.5);
`