import React from 'react'

import { ModalBehind, ModalDiv, Close, Next, Previous } from './styles'

const Modal = ({
  open,
  modal,
  setModal,
  children,
  navigation,
  white,
  className,
}) => (
  <ModalBehind open={open} onClick={setModal}>
    <ModalDiv
      onClick={(event) => event.stopPropagation()}
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

export default Modal
