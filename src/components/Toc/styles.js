import styled, { css } from 'styled-components'
import { BookContent } from 'styled-icons/boxicons-regular/BookContent'
import { Close as Cross } from 'styled-icons/material/Close'
import mediaQuery from '../../utils/mediaQuery'

const openTocDiv = css`
  background: ${props => props.theme.background};
  color: ${props => props.theme.textColor};
  padding: 0.7em 1.2em;
  border-radius: 0.5em;
  box-shadow: 0 0 1em rgba(0, 0, 0, 0.5);
  border: 1px solid ${props => props.theme.borderColor};
`

export const TocDiv = styled.div`
  height: max-content;
  max-height: 80vh;
  overflow-y: scroll;
  z-index: 1;
  line-height: 2em;
  -webkit-overflow-scrolling: touch;
  right: 1em;
  max-width: 20em;
  nav {
    max-height: 78vh;
    overflow-y: scroll;
    -webkit-overflow-scrolling: touch;
  }
  ${mediaQuery.maxLaptop} {
    position: fixed;
    bottom: 1em;
    left: 1em;
    ${props => !props.open && `height: 0;`};
    ${props => props.open && openTocDiv};
    visibility: ${props => (props.open ? `visible` : `hidden`)};
    opacity: ${props => (props.open ? 1 : 0)};
    transition: ${props => props.theme.shortTrans};
  }
  ${mediaQuery.minLaptop} {
    font-size: 0.85em;
    grid-column: 4 / -1;
    position: sticky;
    top: 2em;
  }
`

export const Title = styled.h2`
  margin: 0;
  padding-bottom: 0.5em;
  display: grid;
  grid-auto-flow: column;
  align-items: center;
  grid-template-columns: auto auto 1fr;
`

export const TocLink = styled.a`
  color: ${({ theme, active }) => (active ? theme.linkColor : theme.textColor)};
  font-weight: ${props => props.active && `bold`};
  display: block;
  margin-left: ${props => props.depth + `em`};
  border-top: ${props =>
    props.depth === 0 && `1px solid ` + props.theme.lighterGray};
`

export const TocIcon = styled(BookContent)`
  width: 1em;
  margin-right: 0.2em;
`

const openedCss = css`
  position: fixed;
  bottom: 1em;
  left: 0;
  padding: 0.5em 0.6em 0.5em 0.3em;
  background: ${props => props.theme.background};
  z-index: 1;
  box-shadow: 0 0 1em ${props => props.theme.shadowColor};
  border: 1px solid ${props => props.theme.borderColor};
  border-radius: 0 50% 50% 0;
  transform: translate(${props => (props.open ? `-100%` : 0)});
`

const closedCss = css`
  margin-left: 1em;
  border: 1px solid ${props => props.theme.borderColor};
  border-radius: 50%;
`

export const Toggle = styled(Cross).attrs(props => ({
  as: props.opener && BookContent,
  size: props.size || `1.2em`,
}))`
  transition: ${props => props.theme.shortTrans};
  justify-self: end;
  :hover {
    transform: scale(1.1);
  }
  ${mediaQuery.minLaptop} {
    display: none;
  }
  ${props => (props.opener ? openedCss : closedCss)};
`
