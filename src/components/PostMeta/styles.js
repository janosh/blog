import styled, { css } from 'styled-components'

import mediaQuery from '../../utils/mediaQuery'

export const Meta = styled.div`
  display: grid;
  grid-auto-columns: max-content;
  grid-gap: 0.3rem;
  > span {
    display: flex;
    align-items: center;
  }
  margin: 1.3rem 0;
  font-size: 0.9em;
  ${mediaQuery.minTablet} {
    grid-auto-flow: column;
    grid-gap: 2rem;
  }
  ${props => props.inTitle && css`
    justify-content: center;
    align-items: center;
    justify-items: center;
    max-width: 80%;
    width: max-content;
    padding: 0.2rem 0.6rem;
    margin: 1.5rem;
    color: ${props => props.theme.mainOrange};
    border: ${({theme}) => theme.smallBorder + ' solid ' + theme.mainWhite};
    background: ${props => props.theme.mainGray};
    border-radius: ${props => props.theme.largeBorderRadius};
    ${mediaQuery.minTablet} {
      grid-gap: 0.7rem;
      >:not(:first-child) {
        border-left: ${props => props.theme.smallBorder} solid;
        padding-left: 0.7rem;
      }
    }
  `}
`

export const Categories = styled.div`
  margin: 1rem 0;
  display: grid;
  grid-auto-flow: column;
  grid-auto-columns: max-content;
  grid-gap: 1rem;
`

export const Category = styled.span`
  padding: 0.2rem 0.5rem;
  border-radius: ${props => props.theme.largeBorderRadius};
  color: ${props => props.theme.darkGray};
  background: ${props => props.theme.mainOrange};
`