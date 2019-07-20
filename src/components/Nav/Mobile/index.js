import React, { memo, useRef, useState } from 'react'
import { animated, useSpring } from 'react-spring'
import { useOnClickOutside, useSize } from '../../../hooks'
import { Children, Icons, Item, Menu, MobileNavDiv, NavLink } from './styles'

const Tree = memo(({ text, url, children }) => {
  const ref = useRef()
  const [open, setOpen] = useState(false)
  const treeHeight = useSize(ref, `height`)
  const { height, opacity, transform } = useSpring({
    from: { height: 0, opacity: 0, transform: `translateX(1em)` },
    to: {
      height: open ? treeHeight : 0,
      opacity: open ? 1 : 0,
      transform: `translateX(${open ? 0 : 1}em)`,
    },
  })
  const Icon = Icons[children ? (open ? `Less` : `More`) : `Arrow`]
  return (
    <Item>
      <Icon onClick={() => setOpen(!open)} />
      <NavLink to={url}>{text}</NavLink>
      {children && (
        <Children style={{ opacity, height }} open={open}>
          <animated.div style={{ transform }} ref={ref}>
            {children}
          </animated.div>
        </Children>
      )}
    </Item>
  )
})

export default function MobileNav({ nav }) {
  const ref = useRef()
  const [open, setOpen] = useState(false)
  useOnClickOutside(ref, () => open && setOpen(false))
  return (
    <>
      <Menu onClick={() => setOpen(!open)} />
      <MobileNavDiv ref={ref} open={open} onScroll={e => e.preventDefault()}>
        {nav.map(({ title, url, subNav }) => (
          <Tree key={url} url={url} text={title}>
            {subNav &&
              subNav.map(item => (
                <Tree key={item.url} url={url + item.url} text={item.title} />
              ))}
          </Tree>
        ))}
      </MobileNavDiv>
    </>
  )
}
