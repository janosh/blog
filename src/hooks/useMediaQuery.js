/* eslint-disable react-hooks/rules-of-hooks */
import { useState, useEffect } from "react"

import mediaQuery from "../utils/mediaQuery"

// React hook for JS media queries
export const useMediaQuery = query => {
  if (typeof window !== `undefined`) {
    const mediaQuery = window.matchMedia(query)
    const [match, setMatch] = useState(mediaQuery.matches)
    useEffect(() => {
      const handleMatch = q => setMatch(q.matches)
      mediaQuery.addListener(handleMatch)
      return () => mediaQuery.removeListener(handleMatch)
    }, [mediaQuery])
    return match
  }
}

// React hook for JS screen queries
export const useScreenQuery = cond => {
  if (!mediaQuery[cond + `Js`])
    throw `useMediaQuery's condition should be one of (min|max)(Phone|Phablet|Tablet|etc.)`
  return useMediaQuery(mediaQuery[cond + `Js`])
}
