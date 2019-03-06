import styled from "styled-components"
import mediaQuery from "../../utils/mediaQuery"
export { Tags as TagsIcon } from "styled-icons/fa-solid/Tags"
import { Grid } from "styled-icons/boxicons-regular/Grid"
import { Web } from "styled-icons/material/Web"
import { ChalkboardTeacher } from "styled-icons/fa-solid/ChalkboardTeacher"
import { Python } from "styled-icons/fa-brands/Python"
import { Database } from "styled-icons/fa-solid/Database"
import { WeatherSunny } from "styled-icons/typicons/WeatherSunny"
import { Lab } from "styled-icons/icomoon/Lab"
import { Atom } from "styled-icons/fa-solid/Atom"
import { ColorLens } from "styled-icons/material/ColorLens"
import { Cpu } from "styled-icons/feather/Cpu"
import { Robot } from "styled-icons/fa-solid/Robot"
import { Graph } from "styled-icons/octicons/Graph"

export const Tag = styled.button`
  font-size: 1em;
  outline: none;
  cursor: pointer;
  width: max-content;
  white-space: nowrap;
  color: ${props => props.theme.darkGray};
  border-radius: ${props => props.theme.smallBorderRadius};
  background: ${({ active, theme }) =>
    active ? theme.orange : theme.lightGray};
  ${mediaQuery.maxPhablet} {
    padding: 0.1em 0.5em 0.2em;
    margin: 0 1em 1em 0;
  }
`

export const TagList = styled.div`
  display: grid;
  grid-gap: 1em;
  grid-column: -3;
  height: max-content;
  h2 {
    margin: 0;
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

export const tagIcons = {
  All: Grid,
  "Web Development": Web,
  Tutorial: ChalkboardTeacher,
  "Machine Learning": Python,
  "Data Science": Database,
  Sustainability: WeatherSunny,
  Science: Lab,
  Physics: Atom,
  Design: ColorLens,
  Technology: Cpu,
  Future: Robot,
  Bayesian: Graph,
}
