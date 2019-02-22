import React, { useEffect } from "react"

import { ModalBehind, ModalDiv, Close, Next, Previous } from './styles'

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
    <ModalBehind open={open} onClick={setModal}>
      <ModalDiv
        onClick={event => event.stopPropagation()}
        className={className}
      >
        <Close onClick={setModal} white={white} />
        {children}
        {navigation && (
          <>
            <Next onClick={() => setModal(modal + 1)} white={white} />
            <Previous onClick={() => setModal(modal - 1)} white={white} />
          </>
        )}
        {children}
      </ModalDiv>
    </ModalBehind>
  )
}

export default Modal
