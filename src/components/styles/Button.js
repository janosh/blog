import styled, { css } from 'styled-components'
import PropTypes from 'prop-types'

import Link from '../Link'

export const buttonCss = css`
  background: ${props => props.theme.darkBlue};
  color: ${props => props.theme.white} !important;
  border-radius: ${props => props.theme.smallBorderRadius};
  padding: 0.1em 0.6em;
  width: max-content;
  font-size: ${props => props.size};
  transition: ${props => props.theme.shortTrans};
  :hover {
    background: ${props => props.theme.lightBlue};
  }
`

const Button = styled(Link)`
  ${buttonCss};
`

export default Button

Button.propTypes = {
  size: PropTypes.string.isRequired,
}

Button.defaultProps = {
  size: `1.2em`,
}
