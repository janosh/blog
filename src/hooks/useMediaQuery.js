import { useEffect, useState } from 'react'
import { mediaQueries } from 'utils/mediaQueries'

export const useMediaQuery = (query, cb) => {
  const [matches, setMatches] = useState(false)

  useEffect(() => {
    const qry = window.matchMedia(query)
    setMatches(qry.matches)

    const handleMatch = q => {
      setMatches(q.matches)
      if (cb instanceof Function) cb(q.matches)
    }

    qry.addListener(handleMatch)
    return () => qry.removeListener(handleMatch)
  }, [query, cb])

  return matches
}

export const useScreenQuery = condition => {
  if (!mediaQueries[condition + `Js`])
    throw new TypeError(
      `useMediaQuery's condition should be one of (min|max)(Phone|Phablet|Tablet|etc.)`
    )
  return useMediaQuery(mediaQueries[condition + `Js`])
}
