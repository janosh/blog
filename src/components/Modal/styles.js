import styled, { css } from 'styled-components'
import { ExitFullscreen, Fullscreen } from 'styled-icons/boxicons-regular'
import { Close as Cross, NavigateBefore, NavigateNext } from 'styled-icons/material'

export const ModalBehind = styled.div`
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: grid;
  visibility: ${props => (props.open ? `visible` : `hidden`)};
  opacity: ${props => (props.open ? `1` : `0`)};
  transition: 0.5s;
  z-index: 2;
`

const fullscreen = css`
  max-height: none;
  width: 100vw;
  height: 100vh;
  margin: 0;
  border-radius: 0;
`

export const ModalDiv = styled.div`
  display: grid;
  align-items: center;
  box-sizing: border-box;
  align-self: center;
  justify-self: center;
  background: var(--color-background);
  height: max-content;
  max-height: 80vh;
  width: 80vw;
  position: relative;
  overflow: scroll;
  border-radius: 0.5em;
  transition: 0.3s;
  box-shadow: 0 0 3em black;
  margin: calc(0.5em + 2vw);
  ${props => props.fullscreen && fullscreen}
`

const controlsCss = css`
  position: absolute;
  cursor: pointer;
  z-index: 1;
  padding: 0.1em;
  transition: 0.3s;
  width: 1.6em;
  :hover {
    transform: scale(1.07);
  }
`

const FullscreenToggle = styled(Fullscreen).attrs(props => ({
  as: props.fullscreen && ExitFullscreen,
}))`
  ${controlsCss};
  border-radius: 0.4em;
  top: 0.5em;
  right: 2.8em;
`

const Close = styled(Cross)`
  ${controlsCss};
  border-radius: 0.4em;
  top: 0.5em;
  right: 0.5em;
`

const Next = styled(NavigateNext)`
  ${controlsCss};
  border-radius: 50%;
  top: 50%;
  right: 0.3em;
`

const Prev = styled(NavigateBefore)`
  ${controlsCss};
  border-radius: 50%;
  top: 50%;
  left: 0.3em;
`

export const controls = { Close, Next, Prev, FullscreenToggle }
