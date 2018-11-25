import styled, { css } from 'styled-components'
import { Search } from 'styled-icons/fa-solid/Search'
import Input from './SearchBox'

export const Root = styled.div`
  position: relative;
  display: grid;
  grid-gap: 1em;
`

export const Loupe = styled(Search)`
  width: 1em;
  margin: 0.3em;
  pointer-events: none;
`

const collapse = css`
  width: 0;
  cursor: pointer;
  color: ${props => props.theme.lightBlue};
  + ${Loupe} {
    color: ${props => props.theme.mainWhite};
  }
  :focus {
    background: ${props => props.theme.mainWhite};
    color: ${props => props.theme.mainGray};
    cursor: text;
    width: 5em;
    + ${Loupe} {
      color: ${props => props.theme.mainGray};
    }
  }
  ::placeholder {
    color: ${props => props.theme.mainGray};
  }
`

const expand = css`
  background: ${props => props.theme.lightGray};
  width: 6em;
`

export const SearchBox = styled(Input)`
  display: flex;
  flex-direction: row-reverse;
  align-items: center;
  input {
    outline: none;
    border: none;
    font-size: 1em;
    background: transparent;
    transition: ${props => props.theme.shortTrans};
    margin-left: -1.6em;
    padding-left: 1.6em;
    border-radius: ${props => props.theme.smallBorderRadius};
    ${props => (props.collapse ? collapse : expand)};
  }
`

const list = css`
  position: absolute;
  right: 0;
  top: calc(100% + 0.5em);
  width: calc(4em + 40vw);
  max-width: 30em;
  box-shadow: 0 0 5px 0;
  padding: 0.7em 1em 0.4em;
  background: ${props => props.theme.mainWhite};
  border-radius: ${props => props.theme.smallBorderRadius};
  > * + * {
    padding-top: 1em !important;
    border-top: 2px solid ${props => props.theme.darkGray};
  }
  li + li {
    margin-top: 0.7em;
    padding-top: 0.7em;
    border-top: 1px solid ${props => props.theme.lightGray};
  }
`

const grid = css`
  ul {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(15em, 1fr));
    grid-gap: 1em;
    li {
      padding: 0.3em 0.5em;
      background: ${props => props.theme.veryLightGray};
      border-radius: ${props => props.theme.smallBorderRadius};
    }
  }
`

export const HitsWrapper = styled.div`
  display: ${props => (props.show ? `grid` : `none`)};
  max-height: 80vh;
  overflow: scroll;
  z-index: 2;
  ${props => (props.hitsAsGrid ? grid : list)};
  * {
    margin-top: 0;
    padding: 0;
  }
  ul {
    list-style: none;
  }
  mark {
    color: ${props => props.theme.mainWhite};
    background: ${props => props.theme.darkBlue};
  }
  header {
    display: flex;
    justify-content: space-between;
  }
  h2 {
    margin: 0 0 0.5em;
  }
  h3 {
    margin-bottom: 0.3em;
  }
`

export const By = styled.span`
  font-size: 0.6em;
  text-align: end;
  padding: 0;
`
