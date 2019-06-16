import { useEffect } from "react"

export const useOnClickOutside = (ref, handler, events) => {
  if (!events) events = [`mousedown`, `touchstart`]
  useEffect(() => {
    const detectClickOutside = event =>
      ref.current && !ref.current.contains(event.target) && handler(event)
    for (const event of events)
      document.addEventListener(event, detectClickOutside)
    return () => {
      for (const event of events)
        document.removeEventListener(event, detectClickOutside)
    }
    // By default, the handler will be a new function on every render
    // and hence cause the effect and cleanup to run on every render.
    // To optimize performance, wrap the handler with useCallback
    // before passing it to useOnClickOutside.
  }, [ref, handler, events])
}
