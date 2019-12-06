import React, { useEffect, useState, useRef } from 'react'
import { ThemeProvider } from 'styled-components'
import { useEventListener } from 'hooks'
import { controls, ModalBackground, ModalContainer } from './styles'

const { Close, Next, Prev, FullscreenToggle } = controls

const handleArrowKeys = setModal => event => {
  if (event && event.key === `ArrowRight`) setModal(m => m + 1)
  else if (event && event.key === `ArrowLeft`) setModal(m => m - 1)
  else if (event && event.key === `Escape`) setModal()
}

export default function Modal({ open, modal, setModal, children, ...rest }) {
  const ref = useRef()
  const { showArrows, className, whiteControls } = rest
  const [fullscreen, setFullscreen] = useState(rest.fullScreenDefault)
  useEventListener(`keydown`, handleArrowKeys(setModal))
  useEffect(() => {
    if (open) document.body.style.overflowY = `hidden`
    if (ref.current) ref.current.closest(`main`).style.zIndex = 3
  }, [open])
  if (open)
    return (
      <ModalBackground open={open} onClick={setModal}>
        <ModalContainer
          onClick={event => event.stopPropagation()}
          {...{ className, fullscreen, ref }}
        >
          <ThemeProvider theme={{ whiteControls }}>
            <Close onClick={setModal} />
            <FullscreenToggle
              onClick={() => setFullscreen(!fullscreen)}
              {...{ fullscreen }}
            />
            {showArrows && (
              <>
                <Next onClick={() => setModal(modal + 1)} />
                <Prev onClick={() => setModal(modal - 1)} />
              </>
            )}
          </ThemeProvider>
          {children}
        </ModalContainer>
      </ModalBackground>
    )
  else {
    if (typeof document !== `undefined`)
      document.body.style.removeProperty(`overflow-y`)
    if (ref.current) ref.current.closest(`main`).style.removeProperty(`z-index`)
    return null
  }
}
