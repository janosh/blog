import { useState } from 'react'

export const useLocalStorage = (key, initialValue, options = {}) => {
  const { deleteKeyIfValueIs = null } = options
  // We pass useState a function that handles initial state
  // creation. That way, the function is executed only once.
  const [storedValue, setStoredValue] = useState(() => {
    if (typeof localStorage !== `undefined`) {
      // Register global event listener on initial state creation.
      // This allows us to react to change events emitted by setValue
      // below. That way we can keep storedValue in sync between
      // multiple call sites to useLocalStorage with the same key.
      // Whenever the value of key in localStorage is changed anywhere
      // in the application, all storedValues with that key will
      // reflect the change.
      document.addEventListener(`localStorage:${key}Change`, event =>
        // The new value set somewhere else in the app is saved as the
        // event.detail attribute in CustomEvent below.
        setStoredValue(event.detail)
      )
      const item = localStorage[key]
      if (!item) localStorage[key] = JSON.stringify(initialValue)
      return item ? JSON.parse(item) : initialValue
    } else return initialValue
  })
  const setValue = value => {
    // allow value to be a function which takes the current value
    // to conform to useState API
    const valueToStore = value instanceof Function ? value(storedValue) : value
    setStoredValue(valueToStore)
    const event = new CustomEvent(`localStorage:${key}Change`, {
      detail: valueToStore,
    })
    document.dispatchEvent(event)
    if (value === deleteKeyIfValueIs) delete localStorage[key]
    else localStorage[key] = JSON.stringify(valueToStore)
  }
  return [storedValue, setValue]
}
