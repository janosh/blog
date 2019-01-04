import React from 'react'
import { connectSearchBox } from 'react-instantsearch-dom'

import { Loupe, Form, Input } from './styles'

export default connectSearchBox(({ refine, ...rest }) => (
  <Form>
    <Input
      type="text"
      placeholder="Suche"
      aria-label="Suche"
      onChange={e => refine(e.target.value)}
      {...rest}
    />
    <Loupe />
  </Form>
))
