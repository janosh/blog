import styled from 'styled-components'
import ParticlesJs from 'react-particles-js'

import params from './params'

export default styled(ParticlesJs).attrs({
  params,
})`
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: -1;
  background: rgba(0, 0, 0, 0.05);
  color: red;
`
