---
title: React Hooks Modal
slug: /react-hooks-modal
date: 2019-01-13
cover:
  img: modal.svg
  source: Codyhouse
  url: https://codyhouse.co/gem/svg-modal-window
tags:
  - JS
  - Web Dev
  - Tutorial
---

What to do on a cold and wet January weekend? Why not check out the new [React alpha (16.8)](https://reactjs.org/blog/2018/11/27/react-16-roadmap.html#react-16x-q1-2019-the-one-with-hooks). **The one with Hooks** as it's come to be called.

All it took was a little skimming through [the docs](https://reactjs.org/docs/hooks-intro.html), followed by updating `react` and `react-dom`.

```sh
yarn add react@next react-dom@next
```

That's it. Ready to start coding. But what to do first? One thing that seemed a good fit for hooks are modals. I'd implemented them once or twice before and in both cases came away with the feeling that a class component with all its boilerplate is overkill considering the tiny bit of state management required for modal functionality. As expected, using hooks I was able to boil it down quite considerably. This is what I ended up with.

```jsx:title=src/components/modal/index.js
import React from 'react'

import { ModalBehind, ModalDiv, Close } from './styles'

const Modal = ({ open, closeModal, children }) => {
  return (
    <ModalBehind open={open} onClick={closeModal}>
      <ModalDiv onClick={event => event.stopPropagation()}>
        <Close onClick={closeModal} />
        {children}
      </ModalDiv>
    </ModalBehind>
  )
}

export default Modal
```

And here are the styled components imported on line 3.

```js:title=src/components/modal/styles.js
import styled from 'styled-components'
import { Close as Cross } from 'styled-icons/material'

export const ModalBehind = styled.div`
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: grid;
  visibility: ${props => (props.open ? `visible` : `hidden`)};
  opacity: ${props => (props.open ? `1` : `0`)};
  transition: 0.5s;
  z-index: 2;
`

export const ModalDiv = styled.div`
  display: grid;
  align-items: center;
  box-sizing: border-box;
  align-self: center;
  justify-self: center;
  background: var(--color-background);
  height: max-content;
  max-height: 80vh;
  width: 80vw;
  position: relative;
  overflow: scroll;
  border-radius: 0.5em;
  transition: 0.3s;
  box-shadow: 0 0 3em black;
  margin: calc(0.5em + 2vw);
`

export const Close = styled(Cross).attrs({ size: `2em` })`
  position: absolute;
  top: 0.5em;
  right: 0.4em;
  cursor: pointer;
`
```

As you can see, the styles are longer than the component itself. That's where I spent most of my time too. Figuring out how to use React hooks took mere minutes. Props to the React team (pun intended) for the excellent onboarding experience!

Anyways, regarding usage, notice that the modal component doesn't actually handle it's own state. That's done by the parent component. As an example here's a [list of photos](/nature) that when clicked enter a higher-resolution modal view.

```js
import React, { useState, Fragment } from 'react' // highlight-line

import Masonry from 'components/Masonry'
import Modal from 'components/Modal'

import { Thumbnail, LargeImg } from './styles'

export default function Photos({ photos }) {
  const [modal, setModal] = useState() // highlight-line
  return (
    <Masonry>
      {photos.map((img, index) => (
        <Fragment key={img.title}>
          <Thumbnail
            onClick={() => setModal(index)} // highlight-line
            alt={img.title}
            src={img.src}
          />
          // highlight-next-line
          <Modal open={index === modal} {...{ modal, setModal }}>
            <LargeImg alt={img.title} src={img.src} />
          </Modal>
        </Fragment>
      ))}
    </Masonry>
  )
}
```

So basically just 4 lines of code to control the list of modals (and 2 of those do other things as well). I have to say, I was pretty impressed by that. For comparison, this is how much code the class implementation needed (just the JS, no styles yet).

```jsx
import React from 'react'
import { connect } from 'react-redux'

import { toggleModal } from '../redux/actions'
import './Modal.css'

class Modal extends React.Component {
  handleClickOutside = event => {
    if (this.node && !this.node.contains(event.target)) {
      const { dispatch, name } = this.props
      dispatch(toggleModal(name))
    }
  }

  componentDidMount() {
    if (this.props.closeOnClickOutside)
      document.addEventListener(`mousedown`, this.handleClickOutside)
  }

  componentWillUnmount() {
    document.removeEventListener(`mousedown`, this.handleClickOutside)
  }

  render() {
    const { modal, name, closeButton, toggleModal, children } = this.props
    if (!modal) return null
    return (
      <div ref={node => (this.node = node)} id={name + `-modal`}>
        {closeButton && (
          <button className="close-button" onClick={toggleModal}>
            &#10005;
          </button>
        )}
        {children}
      </div>
    )
  }
}

const mapStateToProps = (state, { name }) => {
  return {
    modal: state.modals[name],
  }
}

export default connect(mapStateToProps)(Modal)
```

Admittedly this component is bloated further by using Redux but even without it, it's much harder to read and maintain. I'd call this use case a definite win for React Hooks!

## Semantic HTML

One thing I should mention for future readers who want to use this `Modal` component: Once Chrome's new [`<dialog>` tag](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/dialog) gets better [browser support](https://caniuse.com/#feat=dialog), it would improve semantics to use it for the modal container, i.e.

```js
// previously: styled.div
export const ModalDiv = styled.dialog`
  ...;
`
```

and then maybe use the `::backdrop` pseudo-element for the modal background.

```js
export const ModalDiv = styled.dialog`
  ::backdrop {
    ...;
  }
`
```

However, bear in mind that using `::backdrop` would make it more difficult to close the modal on clicks outside of it, i.e. on the background. This is because React is unable to attach `onClick` event handlers to pseudo-elements and it seems unlikely this will change down the road. A workaround would be to use the new `useRef` and `useEffect` hook to create an event listener on the browser's `window` object that checks for the target of the `click` event. That would complicate things a little, though, since the listener would have to trigger on _all_ clicks and check that the modal doesn't include the target before closing. Something like so:

```jsx:title=components/modal/index.js
import React, { useRef, useEffect } from 'react'

import { ModalBehind, ModalDiv, Close } from './styles'

const handleClickOutside = (node, closeModal) => event => {
  if (node && !node.contains(event.target)) closeModal()
}

export default function Modal({ open, closeModal, children }) {
  const ref = useRef()
  useEffect(() => {
    const handler = handleClickOutside(ref.current, closeModal)
    document.addEventListener('mousedown', handler)
    return () => document.removeEventListener('mousedown', handler)
  })
  return (
    <ModalDiv ref={ref} open={open}>
      <Close onClick={closeModal} />
      {children}
    </ModalDiv>
  )
}
```

## Keyboard controls

If you have a list of modals and you'd like users to be able to go to the next or previous modal using the arrow keys, you can add an event listener with the `useEffect` hook for this as well.

```js:title=src/components/modal/index.js
import React, { useEffect } from 'react'

import { ModalBehind, ModalDiv, Close, Next, Prev } from './styles'

// highlight-start
const handleArrowKeys = (modal, setModal) => event => {
  if (event?.key === `ArrowRight`) setModal(modal + 1)
  else if (event?.key === `ArrowLeft`) setModal(modal - 1)
  else if (event?.key === `Escape`) setModal()
}
// highlight-end

export default function Modal({ open, modal, setModal, ...rest }) {
  // highlight-start
  const { showArrows, className, children } = rest
  useEffect(() => {
    const handler = handleArrowKeys(modal, setModal)
    document.addEventListener(`keydown`, handler)
    return () => document.removeEventListener(`keydown`, handler)
  })
  // highlight-end
  if (open) {
    return (
      // Passing setModal to onClick without arguments implicitly
      // sets to undefined, i.e. closes the modal.
      <ModalBehind open={open} onClick={setModal}>
        <ModalDiv onClick={event => event.stopPropagation()} className={className}>
          <Close onClick={setModal} />
          // highlight-start
          {showArrows && (
            <>
              <Next onClick={() => setModal(modal + 1)} />
              <Prev onClick={() => setModal(modal - 1)} />
            </>
          )}
          // highlight-end
          {children}
        </ModalDiv>
      </ModalBehind>
    )
  } else return null
}

export default Modal
```

The new styled components `Next` and `Prev` share most of their CSS with `Close` so it makes sense to reuse that:

```js:title=src/components/modal/styles.js
import styled, { css } from 'styled-components'

import { Close as Cross, NavigateNext, NavigateBefore } from 'styled-icons/material'

const controlsCss = css`
  position: absolute;
  cursor: pointer;
  z-index: 1;
  color: ${props => props.white && `white`};
  background: ${props => props.white && `rgba(0, 0, 0, 0.5)`};
  border-radius: 50%;
  padding: 0.1em;
  transition: 0.3s;
  :hover {
    transform: scale(1.07);
  }
`

export const Close = styled(Cross).attrs({ size: `2em` })`
  ${controlsCss};
  top: 0.5em;
  right: 0.4em;
`

export const Next = styled(NavigateNext).attrs({ size: `2em` })`
  ${controlsCss};
  top: 50%;
  right: 0.4em;
`

export const Prev = styled(NavigateBefore).attrs({ size: `2em` })`
  ${controlsCss};
  top: 50%;
  left: 0.4em;
`
```

For the full and most up to date implementation of this component, check out [this site's Github repo](https://github.com/janosh/blog/tree/master/src/components/Modal).
