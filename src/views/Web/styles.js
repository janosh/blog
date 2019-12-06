import styled, { css } from 'styled-components'
import { Link } from 'styled-icons/boxicons-regular/Link'
import { Npm } from 'styled-icons/fa-brands/Npm'
import { PackageIcon } from 'styled-icons/feather/PackageIcon'
import { Github } from 'styled-icons/icomoon/Github'
import { Calendar } from 'styled-icons/octicons/Calendar'
import { Grid } from 'components/styles'

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
  border-radius: ${props => props.theme.mediumBorderRadius};
  overflow: hidden;
  display: grid;
  box-shadow: 0 0 1em ${props => props.theme.shadowColor};
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

export const Meta = styled.div`
  margin: 1em 0;
  border-left: ${({ theme }) => `${theme.largeBorder} solid ${theme.lightGreen}`};
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
  vertical-align: middle;
`

export const Tech = styled(PackageIcon)`
  ${iconCss}
`

export const Homepage = styled(Link)`
  ${iconCss}
`
