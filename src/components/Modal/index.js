import React from "react"

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
}) => (
  <ModalBackground open={open} onClick={setModal}>
    <ModalContainer
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
    </ModalContainer>
  </ModalBackground>
)

export default Modal
