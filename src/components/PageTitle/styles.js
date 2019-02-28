import styled, { css } from "styled-components"
import Image from "gatsby-image"

export const PageTitleContainer = styled.hgroup`
  grid-column: 1 / -1;
  position: relative;
  color: ${props => props.theme.white};
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  min-height: 60vh;
`

const backdrop = css`
  > * {
    background: rgba(0, 0, 0, 0.7);
    border-radius: ${props => props.theme.smallBorderRadius};
    justify-self: center;
    padding: 0.1em 0.4em;
  }
`

export const Title = styled.div`
  grid-column: 2 / -2;
  grid-row: 1;
  text-align: center;
  font-size: calc(1em + 0.5vw);
  ${props => props.backdrop && backdrop};
`

export const Img = styled(Image)`
  position: absolute !important;
  z-index: -1;
  width: 100%;
  height: 100%;
  background: linear-gradient(
    28deg,
    rgba(255, 113, 0, 1) 0%,
    rgba(9, 9, 121, 1) 50%,
    rgba(0, 212, 255, 1) 100%
  );
`

export const Caption = styled.span`
  position: absolute;
  bottom: 0;
  right: 1em;
  font-size: 0.8em;
  transition: ${props => props.theme.shortTrans};
  color: ${props => props.theme.white};
  visibility: hidden;
  opacity: 0;
  padding: 0.1em 0.5em;
  border-radius: ${props => (props.theme.mediumBorderRadius + ` `).repeat(2)} 0
    0;
  a {
    color: ${props => props.theme.lightBlue};
    transition: ${props => props.theme.shortTrans};
    :hover {
      color: ${props => props.theme.orange};
    }
  }
  ${PageTitleContainer}:hover & {
    visibility: visible;
    opacity: 1;
    background: rgba(0, 0, 0, 0.7);
  }
`
