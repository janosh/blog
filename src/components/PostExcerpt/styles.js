import styled from 'styled-components'
import { Link } from 'gatsby'

export const Article = styled.article`
  & + & {
    margin-top: 3rem;
  }
`

export const Title = styled.h1`
  margin: 0.5rem 0;
  /* font-size: 1.5rem; */
`

export const TitleLink = styled(Link)`
  color: ${props => props.theme.lightGreen};
`