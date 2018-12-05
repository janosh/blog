import styled, { css } from 'styled-components'
import { Share } from 'styled-icons/material/Share'
import { Email } from 'styled-icons/material/Email'
import { Youtube } from 'styled-icons/fa-brands/Youtube'
import { LinkedinIn as Linkedin } from 'styled-icons/fa-brands/LinkedinIn'
import { FacebookF as Facebook } from 'styled-icons/fa-brands/FacebookF'
import { Github } from 'styled-icons/fa-brands/Github'

import mediaQuery from '../../utils/mediaQuery'

export const Wrapper = styled.div`
  position: relative;
`

const collapse = css`
  grid-gap: 2vh;
  visibility: hidden;
  opacity: 0;
  position: absolute;
  background: ${props => props.theme.darkGray};
  border: 1px solid ${props => props.theme.mainWhite};
  border-radius: ${props => props.theme.smallBorderRadius};
  padding: 1vmin;
  font-size: 1.8em;
  transition: ${props => props.theme.shortTrans};
  ${Wrapper}:hover & {
    visibility: visible;
    opacity: 1;
  }
`

const display = css`
  grid-area: social;
  grid-auto-flow: column;
  grid-gap: 1.5vw;
  align-items: end;
  grid-auto-columns: max-content;
  ${props => props.styles};
`

export const Container = styled.div`
  display: grid;
  justify-content: center;
  ${mediaQuery.minTablet} {
    ${display};
  }
  ${mediaQuery.tablet} {
    ${props => (props.collapse ? collapse : display)};
  }
`

export const Toggle = styled(Share)`
  cursor: pointer;
  font-size: 1.4em;
  ${props => props.styles};
  ${mediaQuery.minTablet} {
    display: none;
  }
`

export const Link = styled.a`
  ${props => props.styles};
`

export const Icons = {
  Email,
  Youtube,
  Linkedin,
  Facebook,
  Github,
}
