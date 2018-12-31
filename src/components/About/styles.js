import styled from 'styled-components'
import { KeyboardArrowRight } from 'styled-icons/material/KeyboardArrowRight'
import mediaQuery from '../../utils/mediaQuery'

export const AboutContainer = styled.div`
  grid-area: about;
  display: grid;
  align-items: center;
  justify-items: center;
  grid-auto-flow: column;
  justify-content: space-between;
  grid-template-areas:
    'dots'
    'text'
    'arrow';
  ${mediaQuery.minPhone} {
    grid-template-areas:
      'dots dots'
      'text arrow';
  }
`

export const Text = styled.div`
  grid-area: text;
`

export const Arrow = styled(KeyboardArrowRight)`
  grid-area: arrow;
  transition: ${props => props.theme.shortTrans};
  border-radius: ${props => props.theme.smallBorderRadius};
  :hover {
    color: ${props => props.theme.orange};
    background: rgba(0, 0, 0, 0.2);
  }
`
