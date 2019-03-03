import React, { useEffect } from "react"
import PropTypes from "prop-types"

import { ModalBehind, ModalDiv, Close, Next, Prev } from "./styles"

const handleArrowKeys = (modal, setModal) => event => {
  if (event.key === `ArrowRight`) setModal(modal + 1)
  else if (event.key === `ArrowLeft`) setModal(modal - 1)
}

const Modal = ({
  open,
  modal,
  setModal,
  children,
  navigation,
  className,
  white,
}) => {
  if (open) {
    useEffect(() => {
      const handler = handleArrowKeys(modal, setModal)
      document.addEventListener(`keydown`, handler)
      return () => document.removeEventListener(`keydown`, handler)
    })
    return (
      // passing setModal without arguments will close the modal when triggered
      <ModalBehind open={open} onClick={setModal}>
        <ModalDiv
          onClick={event => event.stopPropagation()}
          className={className}
        >
          <Close onClick={setModal} white={white} />
          {navigation && (
            <>
              <Next onClick={() => setModal(modal + 1)} white={white} />
              <Prev onClick={() => setModal(modal - 1)} white={white} />
            </>
          )}
          {children}
        </ModalDiv>
      </ModalBehind>
    )
  } else return null
}

export default Modal

Modal.propTypes = {
  setModal: PropTypes.func.isRequired,
}
