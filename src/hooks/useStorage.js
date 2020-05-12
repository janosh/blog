import { useEffect, useState } from 'react'

export const useStorage = (storage, key, initialValue, options = {}) => {
  // storage can be local or session or any instance that supports
  // reading and writing key-value pairs (like any JS object).
  const { deleteKeyIfValueIs = null } = options

  // We pass useState a function that handles initial state creation.
  // That way, the function is executed only once and useStorage
  // returns the correct value on initial render.
  const [value, setValue] = useState(() => {
    // During SSR, storage is unavailable so we go straight to initialValue.
    if (typeof window === `undefined`) return initialValue
    try {
      const value = storage[key]
      // Parse stored JSON if there was any, else return initialValue.
      return value ? JSON.parse(value) : initialValue
    } catch (error) {
      // If error also return initialValue
      console.error(error)
      return initialValue
    }
  })

  useEffect(() => {
    // If key is not in storage, set it to the provided initial value to
    // ensure we store it even if setStoredValue is never called.
    if (storage[key] === undefined) storage[key] = JSON.stringify(value)

    // The CustomEvent triggered by a call to useStorage somewhere
    // else in the app carries the new value as the event.detail.
    const cb = event => setValue(event.detail)

    // Register event listener on initial state creation. Allows us to react
    // to events emitted by setValue below. That way we can keep value in sync
    // between multiple call sites to useStorage with the same key.
    document.addEventListener(`storage:${key}Change`, cb)
    return () => document.removeEventListener(`storage:${key}Change`, cb)
  }, [value, key, storage])

  const setStoredValue = newValue => {
    if (newValue === value) return

    // Conform to useState API by allowing newValue to be a function
    // which takes the current value.
    if (newValue instanceof Function) newValue = newValue(value)

    const event = new CustomEvent(`storage:${key}Change`, {
      detail: newValue,
    })
    document.dispatchEvent(event)

    if (newValue === deleteKeyIfValueIs) delete storage[key]
    else storage[key] = JSON.stringify(newValue)

    setValue(newValue)
  }
  return [value, setStoredValue]
}

export const useLocalStorage = (...args) =>
  useStorage(typeof window !== `undefined` && localStorage, ...args)

export const useSessionStorage = (...args) =>
  useStorage(typeof window !== `undefined` && sessionStorage, ...args)
