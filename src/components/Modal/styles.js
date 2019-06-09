import styled, { css } from 'styled-components'
import { Close as Cross } from 'styled-icons/material/Close'
import { NavigateNext } from 'styled-icons/material/NavigateNext'
import { NavigateBefore } from 'styled-icons/material/NavigateBefore'
import { Fullscreen } from 'styled-icons/boxicons-regular/Fullscreen'
import { ExitFullscreen } from 'styled-icons/boxicons-regular/ExitFullscreen'

export const ModalBackground = styled.div`
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
  width: 100vw;
  height: 100vh;
  margin: 0;
  border-radius: 0;
`

export const ModalContainer = styled.div`
  box-sizing: border-box;
  align-self: center;
  justify-self: center;
  background: ${props => props.theme.background};
  height: 80vh;
  width: 80vw;
  position: relative;
  overflow: scroll;
  border-radius: ${props => props.theme.mediumBorderRadius};
  transition: ${props => props.theme.shortTrans};
  box-shadow: 0 0 3em black;
  margin: calc(0.5em + 2vw);
  ${props => props.fullscreen && fullscreen}
`

const controlsCss = css`
  position: absolute;
  cursor: pointer;
  z-index: 1;
  color: ${props => props.theme.whiteControls && `white`};
  background: ${props => props.theme.whiteControls && `rgba(0, 0, 0, 0.5)`};
  padding: 0.1em;
  transition: ${props => props.theme.shortTrans};
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

export const controls = { FullscreenToggle, Close, Next, Prev }
