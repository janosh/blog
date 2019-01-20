import React from 'react'

import { ModelBehind, ModelDiv, Close } from './styles'

const Modal = ({ open, closeModal, children }) => {
  return (
    <ModelBehind open={open} onClick={closeModal}>
      <ModelDiv onClick={(event) => event.stopPropagation()}>
        <Close onClick={closeModal} />
        {children}
      </ModelDiv>
    </ModelBehind>
  )
}

export default Modal
