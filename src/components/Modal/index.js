import React, { useEffect } from "react"
import PropTypes from "prop-types"

import {
  ModalBackground,
  ModalContainer,
  Close,
  Next,
  Previous,
} from "./styles"

const Modal = ({
  open,
  modal,
  setModal,
  children,
  navigation,
  white,
  className,
}) => {
  const handleArrowKeys = event => {
    if (open && event.key === `ArrowRight`) setModal(modal + 1)
    else if (open && event.key === `ArrowLeft`) setModal(modal - 1)
  }
  useEffect(() => {
    document.addEventListener(`keydown`, handleArrowKeys)
    return () => document.removeEventListener(`keydown`, handleArrowKeys)
  })
  return (
    // passing setModal without arguments will close the modal when triggered
    <ModalBackground open={open} onClick={setModal}>
      <ModalContainer
        onClick={event => event.stopPropagation()}
        className={className}
      >
        <Close onClick={setModal} white={white} />
        {navigation && (
          <>
            <Next onClick={() => setModal(modal + 1)} white={white} />
            <Previous onClick={() => setModal(modal - 1)} white={white} />
          </>
        )}
        {children}
      </ModalContainer>
    </ModalBackground>
  )
}

export default Modal

Modal.propTypes = {
  setModal: PropTypes.func.isRequired,
}
