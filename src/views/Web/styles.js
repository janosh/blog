import RawModal from 'components/Modal'
import { Grid } from 'components/styles'
import styled, { css } from 'styled-components'
import { Link } from 'styled-icons/boxicons-regular/Link'
import { Npm } from 'styled-icons/fa-brands/Npm'
import { PackageIcon } from 'styled-icons/feather/PackageIcon'
import { Github } from 'styled-icons/icomoon/Github'
import { Calendar } from 'styled-icons/octicons/Calendar'

const asRow = css`
  grid-column: 2/-2;
  grid-auto-flow: column;
  overflow: scroll;
  padding: 1em;
  grid-auto-columns: 15em;
`

export const ProjectGrid = styled(Grid)`
  ${props => props.asRow && asRow};
`

export const Thumbnail = styled.div`
  border-radius: 0.5em;
  overflow: hidden;
  display: grid;
  box-shadow: 0 0 1em var(--color-shadow);
  transition: 0.5s;
  position: relative;
  h3 {
    position: absolute;
    color: white;
    align-self: center;
    justify-self: center;
    background: rgba(0, 0, 0, 0.8);
    padding: 0.3em 0.7em;
    text-align: center;
    border-radius: 1em;
    max-width: 70%;
  }
  &:hover {
    transform: scale(1.03);
  }
`

export const Modal = styled(RawModal)`
  padding: 1em 2em 0;
  max-width: 45em;
  &:after {
    content: '';
    display: block;
    height: 1em;
    width: 100%;
  }
`

export const Meta = styled.div`
  margin: 1em 0;
  border-left: 0.2em solid var(--color-green-light);
`

const iconCss = css`
  width: 1em;
  vertical-align: -0.15em;
  margin: 0 0.3em 0 1em;
`

export const Date = styled(Calendar)`
  ${iconCss}
`

export const GitHub = styled(Github)`
  ${iconCss}
`

export const NPM = styled(Npm)`
  ${iconCss};
  width: 1.7em;
  vertical-align: -0.7em;
`

export const Tech = styled(PackageIcon)`
  ${iconCss}
`

export const Homepage = styled(Link)`
  ${iconCss}
`
