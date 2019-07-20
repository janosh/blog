/* eslint-disable react-hooks/rules-of-hooks */
import { useState } from 'react'

const handleParam = (key, value, options = {}) => {
  const { historyState = `replace`, nullDeletes = true } = options
  const params = new URLSearchParams(location.search)

  if (value === undefined) value = params.get(key)
  if (value === null && nullDeletes) params.delete(key)
  else params.set(key, value)

  const target =
    location.pathname.replace(/\/$/, ``) +
    (params.toString() ? `?` + params.toString() : ``)

  history[historyState + `State`]({ path: value }, ``, target)

  return value
}

export const useQueryParam = (key, value, options) => {
  if (typeof location !== `undefined`) {
    const [param, setParam] = useState(handleParam(key, value, options))
    return [
      param,
      (newValue, override) =>
        setParam(handleParam(key, newValue, { ...options, ...override })),
    ]
  } else return useState(value)
}
