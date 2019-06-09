import React from "react"
import styled, { css } from "styled-components"

import { Sun } from "styled-icons/fa-solid/Sun"
import { Moon } from "styled-icons/fa-solid/Moon"
import { Close } from "styled-icons/material/Close"

import { fadeInOnHoverParent } from "../styles"

// ensures the Reset cross does not disappear when moving
// cursor off the right edge of the toggle track
const withResetCss = css`
  &::after {
    content: "";
    position: absolute;
    top: 0;
    bottom: 0;
    right: -0.3em;
    width: 0.3em;
  }
`

export const Track = styled.div`
  position: relative;
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: ${props => `calc(2.2 * ${props.size})`};
  height: ${props => props.size};
  background: rgba(255, 255, 255, 0.3);
  border-radius: ${props => `calc(0.5 * ${props.size})`};
  ${props => props.withReset && withResetCss}
`

export const Thumb = styled.div`
  background: white;
  position: absolute;
  width: ${props => `calc(${props.size})`};
  height: ${props => `calc(${props.size})`};
  border-radius: 50%;
  transition: 0.3s;
  transform: ${props =>
    !props.checked && `translateX(calc(1.2 * ${props.size}))`};
`

const iconCss = css`
  padding: 0.1em;
  box-sizing: border-box;
  color: ${props => props.theme.lightYellow};
  width: 1em;
  overflow: visible;
`

export const SunIcon = props => <Sun css={iconCss} {...props} />
export const MoonIcon = props => <Moon css={iconCss} {...props} />

export const Reset = styled(Close)`
  pointer-events: none;
  position: absolute;
  right: -1.3em;
  border-radius: 50%;
  color: white;
  width: 1em;
  background: rgba(255, 255, 255, 0.3);
  ${fadeInOnHoverParent(Track)};
  transition-delay: 0.4s;
`
