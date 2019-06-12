/* eslint-disable react-hooks/rules-of-hooks */
import React, { useEffect, useState } from "react"
import PropTypes from "prop-types"
import { ThemeProvider } from "styled-components"

import { ModalBackground, ModalContainer, controls } from "./styles"

const { Close, Next, Prev, FullscreenToggle } = controls

const handleArrowKeys = (modal, setModal) => event => {
  if (event.key === `ArrowRight`) setModal(modal + 1)
  else if (event.key === `ArrowLeft`) setModal(modal - 1)
}

export default function Modal({ open, modal, setModal, children, ...rest }) {
  if (open) {
    const { showControls = true, className, whiteControls } = rest
    const [fullscreen, setFullscreen] = useState(rest.fullScreenDefault)
    useEffect(() => {
      document.body.style.overflowY = `hidden`
      const handler = handleArrowKeys(modal, setModal)
      document.addEventListener(`keydown`, handler)
      return () => {
        document.removeEventListener(`keydown`, handler)
        document.body.style.removeProperty(`overflow-y`)
      }
    }, [modal, setModal])
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
