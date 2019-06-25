import { useState } from "react"

export const useLocalStorage = (key, initialValue) => {
  // pass initial state function to useState so logic is only executed once
  const [storedValue, setStoredValue] = useState(() => {
    if (typeof localStorage !== `undefined`) {
      // register global event listener on initial state creation to
      // react to change events emitted by setValue below
      // this keeps storedValue in sync between multiple call sites
      // of useLocalStorage with the same key
      // whenever the value of key in localStorage is changed anywhere
      // in the application, all storedValues with that key will reflect that change
      document.addEventListener(`localStorage:${key}Change`, event =>
        setStoredValue(event.detail)
      )
      const item = localStorage[key]
      return item ? JSON.parse(item) : initialValue
    } else return initialValue
  })
  const setValue = value => {
    if (value === undefined) return delete localStorage[key]
    // allow value to be a function which takes the current value
    // to conform to useState API
    const valueToStore = value instanceof Function ? value(storedValue) : value
    setStoredValue(valueToStore)
    localStorage[key] = JSON.stringify(valueToStore)
    const event = new CustomEvent(`localStorage:${key}Change`, {
      detail: valueToStore,
    })
    document.dispatchEvent(event)
  }
  return [storedValue, setValue]
}
