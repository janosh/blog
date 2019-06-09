import { useState } from "react"

export const useLocalStorage = (key, initialValue) => {
  // pass initial state function to useState so logic is only executed once
  const [storedValue, setStoredValue] = useState(() => {
    if (typeof localStorage !== `undefined`) {
      const item = localStorage[key]
      return item ? JSON.parse(item) : initialValue
    } else return initialValue
  })
  const setValue = value => {
    if (typeof localStorage !== `undefined`) {
      if (value === undefined) return delete localStorage[key]
      // allow value to be a function to conform to useState API
      const valueToStore =
        value instanceof Function ? value(storedValue) : value
      setStoredValue(valueToStore)
      localStorage[key] = JSON.stringify(valueToStore)
    }
  }
  return [storedValue, setValue]
}
