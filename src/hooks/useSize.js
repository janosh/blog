import { useEffect, useState } from 'react'

export const useSize = (ref, quantity) => {
  const [size, setSize] = useState(0)
  // useState for performance, prevents ResizeObserver from being invoked on every rerender
  const [observer] = useState(
    new ResizeObserver(([entry]) => setSize(entry.contentRect[quantity]))
  )
  useEffect(() => {
    if (ref.current) observer.observe(ref.current)
    return () => observer.disconnect()
  }, [observer, ref])
  return size
}
