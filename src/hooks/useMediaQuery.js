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

const validKeys = Object.keys(mediaQueries).filter(key => !key.includes(`Js`))

export const useScreenQuery = (key, cb) => {
  if (!mediaQueries[key + `Js`])
    throw new TypeError(
      `useScreenQuery received invalid key: ${key}. Should be one of ${validKeys}`
    )
  return useMediaQuery(mediaQueries[key + `Js`], cb)
}
