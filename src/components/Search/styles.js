import React from 'react'
import styled, { css } from 'styled-components'
import { Algolia } from 'styled-icons/fa-brands/Algolia'
import { Search } from 'styled-icons/fa-solid/Search'

export const Root = styled.div`
  position: relative;
  display: grid;
  grid-gap: 1em;
  color: ${props => props.theme.textColor};
`

export const SearchIcon = styled(Search)`
  width: 1em;
  pointer-events: none;
  color: white;
`

const focus = css`
  background: white;
  color: ${props => props.theme.darkerBlue};
  cursor: text;
  width: 5em;
  + ${SearchIcon} {
    color: ${props => props.theme.darkerBlue};
    margin: 0 0.3em;
  }
`

const collapsed = css`
  width: 0;
  cursor: pointer;
  color: ${props => props.theme.lighterBlue};
  ${props => props.focus && focus}
  margin-left: ${props => (props.focus ? `-1.6em` : `-1em`)};
  padding-left: ${props => (props.focus ? `1.6em` : `1em`)};
  ::placeholder {
    color: ${props => props.theme.gray};
  }
`

const expanded = css`
  background: ${props => props.theme.lighterGray};
  width: 6em;
  margin-left: -1.6em;
  padding-left: 1.6em;
  + ${SearchIcon} {
    margin: 0.3em;
  }
`

export const Input = styled.input`
  outline: none;
  border: none;
  font-size: 1em;
  background: transparent;
  transition: 0.3s;
  border-radius: ${props => props.theme.smallBorderRadius};
  ${props => (props.collapse ? collapsed : expanded)};
`

export const Form = styled.form`
  display: flex;
  flex-direction: row-reverse;
  align-items: center;
`

export const HitsWrapper = styled.div`
  display: ${props => (props.show ? `grid` : `none`)};
  background: ${props => props.theme.background};
  max-height: 80vh;
  overflow: scroll;
  z-index: 2;
  position: absolute;
  right: 0;
  top: calc(100% + 0.5em);
  width: 80vw;
  max-width: 30em;
  box-shadow: 0 0 5px 0 black;
  padding: 0.7em 1em 0.4em;
  border-radius: ${props => props.theme.smallBorderRadius};
  * {
    margin-top: 0;
  }
  > div {
    padding-top: 0.6em;
  }
  div + div {
    margin-top: 0.6em;
    border-top: 1px solid ${props => props.theme.lighterGray};
  }
  mark {
    color: ${props => props.theme.lighterBlue};
    background: ${props => props.theme.darkerBlue};
  }
  header {
    display: flex;
    justify-content: space-between;
    border-bottom: 2px solid ${props => props.theme.darkGray};
    h3 {
      color: white;
      background: ${props => props.theme.gray};
      padding: 0.1em 0.4em;
      border-radius: ${props => props.theme.smallBorderRadius};
      margin-bottom: 0.3em;
    }
  }
  * + header {
    padding-top: 1em;
  }
  h4 {
    margin-bottom: 0.3em;
  }
`

export const PoweredBy = () => (
  <span css="font-size: 0.6em; text-align: end; padding: 0;">
    Powered by{` `}
    <a href="https://algolia.com">
      <Algolia size="1em" /> Algolia
    </a>
  </span>
)
