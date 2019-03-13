---
title: React Hooks Modal
slug: /react-hooks-modal
date: 2019-01-13
cover:
  img: react-hooks-modal.png
tags:
  - WebDev
  - Tutorial
---

What to do on a cold January weekend with bad weather? Why not check out the new [React alpha (16.8)](https://reactjs.org/blog/2018/11/27/react-16-roadmap.html#react-16x-q1-2019-the-one-with-hooks). **The one with hooks** as it's come to be called.

All it took was a little skimming through [the docs](https://reactjs.org/docs/hooks-intro.html), followed by updating to `react@next` and `react-dom@next`

```sh
yarn add react@next react-dom@next
```

That's it. Ready to start coding. But what to do first? One thing that seemed a good fit for hooks are modals. I'd implemented them once or twice before and in both cases came away with the feeling that a component class with all its boilerplate is overkill considering the tiny bit of state management required for modal functionality. As expected, using hooks I was to boil it down quite considerably. This is what I ended up with.

```jsx:title=components/modal/index.js
import React from 'react'

import { ModalBackground, ModalContainer, Close } from './styles'

const Modal = ({ open, closeModal, children }) => {
  return (
    <ModalBackground open={open} onClick={closeModal}>
      <ModalContainer onClick={event => event.stopPropagation()}>
        <Close onClick={closeModal} />
        {children}
      </ModalContainer>
    </ModalBackground>
  )
}

export default Modal
```

And as for the styles:

```js:title=components/modal/styles.js
import styled from 'styled-components'
import { Close as Cross } from 'styled-icons/material/Close'

export const ModalBackground = styled.div`
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
  z-index: 1;
`

export const ModalContainer = styled.div`
  align-self: center;
  justify-self: center;
  background: ${props => props.theme.white};
  max-width: ${props => props.theme.maxWidth};
  max-height: 80vh;
  position: relative;
  overflow: scroll;
  padding: 2em;
  border-radius: ${props => props.theme.mediumBorderRadius};
  box-shadow: 0 0 3em ${props => props.theme.black};
`

export const Close = styled(Cross).attrs({ size: `2em` })`
  position: absolute;
  top: 0.5em;
  right: 0.4em;
  cursor: pointer;
`
```

As you can see, the styles are way longer than the component itself. That's also where most of my time went. Figuring out how to use React hooks took minutes. Props to the React team (pun intended) for the excellent onboarding experience! Getting the css right probably took 5 times longer. Anyways, regarding usage, notice that the modal component doesn't actually handle it's own state. That's done by the parent component. As an example here's my list of [web projects](/web) projects on this very site.

```jsx{1,9,16,20}
import React, { useState, Fragment } from 'react'

import { ProjectExcerpt, Img } from './styles'
import Project from './Project'
import Grid from '../../components/styles/Grid'
import Modal from '../../components/Modal'

const Projects = ({ projects }) => {
  const [modal, setModal] = useState()
  return (
    <Grid min="15em" gap="1em">
      {projects.map(({ node }, index) => {
        const { title, cover } = node.frontmatter
        return (
          <Fragment key={title}>
            <ProjectExcerpt onClick={() => setModal(index)}>
              <Img fluid={cover.img.sharp.fluid} />
              <h3>{title}</h3>
            </ProjectExcerpt>
            <Modal open={index === modal} closeModal={setModal}>
              <Project {...node.frontmatter} html={node.html} />
            </Modal>
          </Fragment>
        )
      })}
    </Grid>
  )
}

export default Projects
```

So basically just 4 lines of code to control the list of modals (and 3 of those do other things as well). All in all a big win for React hooks I'd say. For comparison, this is how much code the class implementation needed.

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

  componentWillMount() {
    this.props.closeOnClickOutside &&
      document.addEventListener('mousedown', this.handleClickOutside)
  }

  componentWillUnmount() {
    document.removeEventListener('mousedown', this.handleClickOutside)
  }

  render() {
    const { modal, name, closeButton, toggleModal, children } = this.props
    if (!modal) return null
    return (
      <div ref={node => (this.node = node)} id={name + '-modal'}>
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

Admittedly this component is bloated even further by using Redux but even without it, it's less readable and less maintainable. So thank you everyone involved for hooks.

One thing I should mention for future readers who actually want to use this `Modal` component: Once Chrome's new [`<dialog>` tag](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/dialog) gets wider [browser support](https://caniuse.com/#feat=dialog), it would certainly improve semantics to use it for the modal container, i.e.

```js
- export const ModalContainer = styled.div`
+ export const ModalContainer = styled.dialog`
```

and then maybe use the `::backdrop` pseudo-element for the modal background.

```js
- export const ModalBackground = styled.div`
+ export const ModalContainer = styled.dialog`
    ...
    ::backdrop {
      ...
    }
  `
```

However, bear in mind that using `::backdrop` would make it much more difficult to close the modal on clicks outside of it, i.e. on the background. This is because (as of now) React is unable to attach the `onClick` prop to pseudo-elements. Perhaps that will change down to the road. If not, a workaround would be to use the new `useRef` and `useEffect` hook to create an event listener on the browser's `window` object that checks for the target of the `click` event. But that would complicate things quite a bit, since the listener would have to trigger on all clicks and check that the modal doesn't include the target before closing.

```jsx:title=components/modal/index.js
import React, { useRef, useEffect } from 'react'

import { ModalBackground, ModalContainer, Close } from './styles'

const handleClickOutside = (node, closeModal) => event => {
  if (node && !node.contains(event.target)) closeModal()
}

const Modal = ({ open, closeModal, children }) => {
  const ref = useRef()
  useEffect(() => {
    const handler = handleClickOutside(ref.current, closeModal)
    document.addEventListener('mousedown', handler)
    return () => document.removeEventListener('mousedown', handler)
  })
  return (
    <ModalContainer ref={ref} open={open}>
      <Close onClick={closeModal} />
      {children}
    </ModalContainer>
  )
}

export default Modal
```

## Update

If you have a list of modals and you'd like users to be able to go to the next or previous modal using the arrow keys, you can again add an event listener for this with the `useEffect` hook as follows.

```jsx{5-8,12-16,25-30}
import React, { useEffect } from 'react'

import { ModalBackground, ModalContainer, Close, Next, Prev } from './styles'

const handleArrowKeys = (modal, setModal) => event => {
  if (event.key === `ArrowRight`) setModal(modal + 1)
  else if (event.key === `ArrowLeft`) setModal(modal - 1)
}

const Modal = ({ open, modal, setModal, children, navigation, className }) => {
  if (open) {
    useEffect(() => {
      const handler = handleArrowKeys(modal, setModal)
      document.addEventListener(`keydown`, handler)
      return () => document.removeEventListener(`keydown`, handler)
    })
    return (
      // passing setModal without arguments will close the modal when triggered
      <ModalBackground open={open} onClick={setModal}>
        <ModalContainer
          onClick={event => event.stopPropagation()}
          className={className}
        >
          <Close onClick={setModal} />
          {navigation && (
            <>
              <Next onClick={() => setModal(modal + 1)} />
              <Prev onClick={() => setModal(modal - 1)} />
            </>
          )}
          {children}
        </ModalContainer>
      </ModalBackground>
    )
  } else return null
}

export default Modal
```
