import { useEffect, useState } from 'react'
import mediaQuery from '../utils/mediaQuery'

// React hook for JS media queries
export const useMediaQuery = query => {
  if (typeof window !== `undefined`) {
    query = window.matchMedia(query)
    // eslint-disable-next-line react-hooks/rules-of-hooks
    const [match, setMatch] = useState(query.matches)
    // eslint-disable-next-line react-hooks/rules-of-hooks
    useEffect(() => {
      const handleMatch = q => setMatch(q.matches)
      query.addListener(handleMatch)
      return () => query.removeListener(handleMatch)
    }, [query])
    return match
  }
}

export const useScreenQuery = condition => {
  if (!mediaQuery[condition + `Js`])
    throw new TypeError(
      `useMediaQuery's condition should be one of (min|max)(Phone|Phablet|Tablet|etc.)`
    )
  return useMediaQuery(mediaQuery[condition + `Js`])
}
