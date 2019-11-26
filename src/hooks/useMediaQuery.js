import { useEffect, useState } from 'react'
import mediaQuery from 'utils/mediaQuery'

const noop = () => {}

// React hook for JS media queries
export const useMediaQuery = query => {
  // Fall back on dummy matchMedia during SSR.
  const matchMedia =
    globalThis.matchMedia || (() => ({ addListener: noop, removeListener: noop }))
  query = matchMedia(query)
  const [matches, setMatches] = useState(query.matches)
  useEffect(() => {
    const handleMatch = q => setMatches(q.matches)
    query.addListener(handleMatch)
    return () => query.removeListener(handleMatch)
  }, [query])
  return matches
}

export const useScreenQuery = condition => {
  if (!mediaQuery[condition + `Js`])
    throw new TypeError(
      `useMediaQuery's condition should be one of (min|max)(Phone|Phablet|Tablet|etc.)`
    )
  return useMediaQuery(mediaQuery[condition + `Js`])
}
