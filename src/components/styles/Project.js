import styled from 'styled-components'

export default styled.div`
  background: ${props => props.theme.veryLightGray};
  border-radius: ${props => props.theme.mediumBorderRadius};
  overflow: hidden;
  max-height: calc(20em + 20vh);
  overflow: scroll;
  > * {
    margin: 8%;
  }
  p:first-child {
    margin: 0;
  }
  .gatsby-resp-image-wrapper {
    height: 11em;
    object-fit: cover;
    overflow: hidden;
  }
`
