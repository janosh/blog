import { useEventListener } from 'hooks'
import React, { useEffect, useRef, useState } from 'react'
import { controls, ModalBehind, ModalDiv } from './styles'

const { Close, Next, Prev, FullscreenToggle } = controls

const handleArrowKeys = setModal => event => {
  if (event?.key === `ArrowRight`) setModal(m => m + 1)
  else if (event?.key === `ArrowLeft`) setModal(m => m - 1)
  else if (event?.key === `Escape`) setModal()
}

export default function Modal({ open, modal, setModal, children, ...rest }) {
  const ref = useRef()
  const { showArrows, className } = rest
  const [fullscreen, setFullscreen] = useState(rest.fullScreenDefault)
  useEventListener(`keydown`, handleArrowKeys(setModal))
  useEffect(() => {
    if (open) document.body.style.overflowY = `hidden`
    if (ref.current) ref.current.closest(`main`).style.zIndex = 3
  }, [open])
  if (open)
    return (
      <ModalBehind open={open} onClick={() => setModal()}>
        <ModalDiv
          onClick={event => event.stopPropagation()}
          {...{ className, fullscreen, ref }}
        >
          <Close onClick={() => setModal()} />
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
          {children}
        </ModalDiv>
      </ModalBehind>
    )
  else {
    if (typeof document !== `undefined`)
      document.body.style.removeProperty(`overflow-y`)
    if (ref.current) ref.current.closest(`main`).style.removeProperty(`z-index`)
    return null
  }
}
