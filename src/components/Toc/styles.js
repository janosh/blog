import styled, { css } from "styled-components"
import { Link } from "gatsby"

import { Close as Cross } from "styled-icons/material/Close"
import { BookContent } from "styled-icons/boxicons-regular/BookContent"

import mediaQuery from "../../utils/mediaQuery"

const openTocDiv = css`
  background: white;
  padding: 0.7em 1.2em;
  border-radius: 0.5em;
  border: 1px solid ${props => props.theme.lighterGray};
`

export const TocDiv = styled.div`
  height: max-content;
  max-height: 80vh;
  overflow-y: scroll;
  z-index: 1;
  line-height: 2.2em;
  -webkit-overflow-scrolling: touch;
  ${mediaQuery.maxLaptop} {
    max-width: 16em;
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
    max-width: 15em;
    font-size: 0.85em;
    grid-column: 4 / -1;
    position: sticky;
    top: 2em;
    right: 2em;
  }
`

export const Title = styled.h2`
  padding-bottom: 0.5em;
  display: grid;
  grid-auto-flow: column;
  align-items: center;
  grid-template-columns: auto auto 1fr;
`

export const TocLink = styled(Link)`
  display: block;
  margin-left: ${props => props.depth + `em`};
  border-top: ${props =>
    props.depth === 0 && `1px solid ` + props.theme.lighterGray};
`

export const TocIcon = styled(BookContent)`
  width: 1em;
  margin-right: 0.2em;
`

const openerCss = `
  position: fixed;
  bottom: 1em;
  left: 1em;
`

const closerCss = css`
  background: ${props => props.theme.lighterGray};
  border-radius: 50%;
`

export const Toggle = styled(Cross).attrs(props => ({
  as: props.opener && BookContent,
  size: props.size || `1.4em`,
}))`
  transition: ${props => props.theme.shortTrans};
  justify-self: end;
  :hover {
    transform: scale(1.1);
  }
  ${mediaQuery.minLaptop} {
    display: none;
  }
  ${props => (props.opener ? openerCss : closerCss)};
`
