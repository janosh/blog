/* eslint-disable react-hooks/rules-of-hooks */
import PropTypes from 'prop-types'
import React, { useEffect, useState } from 'react'
import { ThemeProvider } from 'styled-components'
import { useEventListener } from 'hooks'
import { controls, ModalBackground, ModalContainer } from './styles'

const { Close, Next, Prev, FullscreenToggle } = controls

const handleArrowKeys = setModal => event => {
  if (event && event.key === `ArrowRight`) setModal(m => m + 1)
  else if (event && event.key === `ArrowLeft`) setModal(m => m - 1)
}

export default function Modal({ open, modal, setModal, children, ...rest }) {
  if (open) {
    const { showControls = true, className, whiteControls } = rest
    const [fullscreen, setFullscreen] = useState(rest.fullScreenDefault)
    useEventListener(`keydown`, handleArrowKeys(setModal))
    useEffect(() => {
      document.body.style.overflowY = `hidden`
      return () => document.body.style.removeProperty(`overflow-y`)
    }, [])
    return (
      // calling setModal without arguments will close the modal
      <ModalBackground open={open} onClick={setModal}>
        <ModalContainer
          onClick={event => event.stopPropagation()}
          {...{ className, fullscreen }}
        >
          <ThemeProvider theme={{ whiteControls }}>
            {showControls && (
              <>
                <Close onClick={setModal} />
                <FullscreenToggle
                  onClick={() => setFullscreen(!fullscreen)}
                  {...{ fullscreen }}
                />
                <Next onClick={() => setModal(modal + 1)} />
                <Prev onClick={() => setModal(modal - 1)} />
              </>
            )}
          </ThemeProvider>
          {children}
        </ModalContainer>
      </ModalBackground>
    )
  } else {
    typeof document !== `undefined` &&
      document.body.style.removeProperty(`overflow-y`)
    return null
  }
}

Modal.propTypes = {
  setModal: PropTypes.func.isRequired,
}
