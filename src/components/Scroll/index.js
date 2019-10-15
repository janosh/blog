import { throttle } from 'lodash'
import React, { useState } from 'react'
import { useEventListener } from 'hooks'
import { Arrow } from './styles'

export default function Scroll({ direction = `up`, by, to, ...rest }) {
  const { showBelow, className, size = `calc(0.6em + 30px)` } = rest
  if (![`up`, `down`].includes(direction))
    throw TypeError(
      `Scroll component's direction prop must be either 'up' or 'down'`
    )
  if (to && (typeof to !== `number` || to <= 0))
    throw TypeError(`Scroll component's to prop must be a positive number`)
  if (by && typeof by !== `number`)
    throw TypeError(`Scroll component's by prop must be a number`)

  const [show, setShow] = useState(showBelow ? false : true)

  const scroll = ({ mode, to }) =>
    window[`scroll` + mode]({ top: to, behavior: `smooth` })

  const handleScroll = throttle(() => {
    if (!showBelow) return
    if (window.scrollY > showBelow) {
      if (!show) setShow(true)
    } else {
      if (show) setShow(false)
    }
  }, 300)
  useEventListener(`scroll`, handleScroll)

  const handleClick = () => {
    if (to) scroll({ mode: `To`, to: to * window.innerHeight })
    else if (by) scroll({ mode: `By`, to: by * window.innerHeight })
    else if (direction === `up`) scroll({ mode: `To`, to: 0 })
    else scroll({ mode: `To`, to: document.body.scrollHeight })
  }

  const arrowProps = { show, direction, className, size }
  return <Arrow onClick={handleClick} {...arrowProps} />
}
