import React from 'react'
import { connectSearchBox } from 'react-instantsearch-dom'
import { Form, Input, SearchIcon } from './styles'

export default connectSearchBox(({ refine, size = `1em`, ...rest }) => (
  <Form>
    <Input
      type="text"
      placeholder="Search"
      aria-label="Search"
      onChange={e => refine(e.target.value)}
      // iOS Safari doesn't blur input automatically on tap outside.
      onMouseLeave={e => e.target.blur()}
      size={size}
      {...rest}
    />
    <SearchIcon size={size} />
  </Form>
))
