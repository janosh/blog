import React from "react"
import { DownArrow } from "styled-icons/boxicons-regular/DownArrow"

import { NavEntry, SubNav, NavLink, DesktopNavDiv } from "./styles"

export default ({ nav }) => (
  <DesktopNavDiv>
    {nav.map(({ url, title, subNav }) => (
      <NavEntry key={url}>
        <NavLink to={url || subNav[0].url} title={title}>
          {title} {subNav && <DownArrow size="0.5em" />}
        </NavLink>
        {subNav && (
          <SubNav>
            {subNav.map(item => (
              <NavLink key={item.url} to={url + item.url} title={item.title}>
                {item.title}
              </NavLink>
            ))}
          </SubNav>
        )}
      </NavEntry>
    ))}
  </DesktopNavDiv>
)
