import { useState } from 'react'

const handleParam = (key, value, options = {}) => {
  if (typeof location !== `undefined`) {
    // historyMethod: push or replace (https://developer.mozilla.org/docs/Web/API/History)
    const { historyMethod = `replace`, nullDeletes = true } = options
    const params = new URLSearchParams(location.search)

    if (value === undefined) value = params.get(key)
    else if (value === null && nullDeletes) params.delete(key)
    else params.set(key, value)

    let target = location.pathname + `?` + params.toString()
    target = target.replace(/\/?\?$/, ``) // remove empty search string

    history[historyMethod + `State`]({ path: value }, ``, target)

    return value
  }
}

export const useQueryParam = (key, value, options) => {
  const [param, setParam] = useState(handleParam(key, value, options))

  const setter = (newValue, override) =>
    setParam(handleParam(key, newValue, { ...options, ...override }))

  return [param, setter]
}
