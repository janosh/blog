import styled, { css } from "styled-components"
import { Share } from "styled-icons/material/Share"
import { Email } from "styled-icons/material/Email"
import { Youtube } from "styled-icons/fa-brands/Youtube"
import { LinkedinIn as Linkedin } from "styled-icons/fa-brands/LinkedinIn"
import { FacebookF as Facebook } from "styled-icons/fa-brands/FacebookF"
import { Github } from "styled-icons/fa-brands/Github"

import mediaQuery from "../../utils/mediaQuery"
import { fadeInOnHoverParent } from "../styles"

export const Wrapper = styled.div`
  position: relative;
`

const collapse = css`
  grid-gap: 2vh;
  position: absolute;
  background: ${props => props.theme.black};
  border-radius: ${props => props.theme.smallBorderRadius};
  padding: 1vmin;
  font-size: 1.6em;
  transition: ${props => props.theme.shortTrans};
  ${fadeInOnHoverParent(Wrapper)};
`

const display = css`
  grid-auto-flow: column;
  grid-gap: 1.5vw;
  ${props => props.styles};
`

export const Container = styled.div`
  display: grid;
  justify-content: center;
  ${mediaQuery.maxTablet} {
    ${props => (props.collapse ? collapse : display)};
  }
  ${mediaQuery.minTablet} {
    ${display};
  }
`

export const Toggle = styled(Share)`
  cursor: pointer;
  font-size: 1.3em;
  ${props => props.styles};
  ${mediaQuery.minTablet} {
    display: none;
  }
`

export const Link = styled.a`
  ${props => props.styles};
  svg {
    display: block;
  }
`

export const Icons = {
  Email: styled(Email)`
    vertical-align: -0.15em;
    transform: scale(1, 1.1);
  `,
  Youtube: styled(Youtube)`
    transform: scale(1, 1.15);
  `,
  Linkedin,
  Facebook,
  Github,
}
