import { useEventListener } from '.'

export function useOnClickOutside(ref, handler, events) {
  if (!events) events = [`mousedown`, `touchstart`]
  const detectClickOutside = event =>
    ref.current && event && !ref.current.contains(event.target) && handler(event)
  useEventListener(events, detectClickOutside)
}
