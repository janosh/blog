import { useEffect, useRef } from 'react'

export function useEventListener(eventNames, handler, element = globalThis) {
  // Create a ref that stores the handler.
  const savedHandler = useRef()
  if (!Array.isArray(eventNames)) eventNames = [eventNames]

  // Save handler to ref.current on initial call to useEventListener
  // and then update ref.current whenever the handler changes.
  // This allows the second useEffect below to always get the latest
  // handler without needing to have it in than hooks deps array which
  // could cause the effect to re-run every render.
  useEffect(() => (savedHandler.current = handler), [handler])

  useEffect(() => {
    if (!element.addEventListener) return // element doesn't support a listener, abort.

    // Create event listener that calls handler function stored in ref
    const listener = event => savedHandler.current(event)
    for (const e of eventNames) element.addEventListener(e, listener)
    return () => {
      for (const e of eventNames) element.removeEventListener(e, listener)
    }
  }, [element, eventNames])
}
