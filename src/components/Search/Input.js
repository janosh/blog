import React from "react"
import { connectSearchBox } from "react-instantsearch-dom"

import { Loupe, Form, Input } from "./styles"

export default connectSearchBox(({ refine, ...rest }) => (
  <Form>
    <Input
      type="text"
      placeholder="Search"
      aria-label="Search"
      onChange={e => refine(e.target.value)}
      {...rest}
    />
    <Loupe />
  </Form>
))
