import styled from 'styled-components'
import { Grid } from 'styled-icons/boxicons-regular'
import { JsSquare, Python } from 'styled-icons/fa-brands'
import {
  Atom,
  Brain,
  ChalkboardTeacher,
  Database,
  Robot,
  ToggleOff,
  ToggleOn,
} from 'styled-icons/fa-solid'
import { Cpu } from 'styled-icons/feather'
import { Lab, Sigma } from 'styled-icons/icomoon'
import { ColorLens, Web } from 'styled-icons/material'
import { WeatherSunny } from 'styled-icons/typicons'
import mediaQuery from 'utils/mediaQuery'
export { Tags as TagsIcon } from 'styled-icons/fa-solid'

export const TagGrid = styled.aside`
  display: grid;
  grid-gap: 1em;
  grid-column: -3;
  height: max-content;
  h2 {
    margin: 0;
  }
  ${mediaQuery.minPhablet} {
    position: sticky;
    top: 6em;
  }
  ${mediaQuery.maxPhablet} {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    margin: 0 0 2em;
    grid-area: 1/3;
    h2 {
      width: 100%;
      margin-bottom: 1em;
      text-align: center;
    }
  }
`

export const Tag = styled.button`
  font-size: 1em;
  outline: none;
  border: 1px solid var(--color-shadow);
  cursor: pointer;
  width: max-content;
  white-space: nowrap;
  color: ${p => (p.active ? `black` : `var(--color-text)`)};
  font-weight: 300;
  border-radius: 0.2em;
  background: ${p =>
    p.active ? `var(--color-a)` : `var(--color-accentBackground)`};
  ${mediaQuery.maxPhablet} {
    padding: 0.1em 0.5em 0.2em;
    margin: 0 1em 1em 0;
    transition: 0.6s;
    visibility: ${props => (props.open ? `visible` : `hidden`)};
    margin-bottom: ${props => (props.open ? `1em` : `-2em`)};
    opacity: ${props => (props.open ? 1 : 0)};
  }
`

export const Toggle = styled(ToggleOff).attrs(props => ({
  as: props.open && ToggleOn,
  size: `1em`,
}))`
  margin-left: 0.5em;
  cursor: pointer;
  ${mediaQuery.minPhablet} {
    display: none;
  }
`

export const tagIcons = {
  All: Grid,
  'Web Dev': Web,
  Tutorial: ChalkboardTeacher,
  'Machine Learning': Brain,
  'Data Science': Database,
  Sustainability: WeatherSunny,
  Science: Lab,
  Physics: Atom,
  Design: ColorLens,
  Technology: Cpu,
  Future: Robot,
  JS: JsSquare,
  Python,
  Statistics: Sigma,
}
