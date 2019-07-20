import { functions, isEqual, omit } from 'lodash'
import React, { useEffect, useRef } from 'react'

function Map({ options, onMount, className }) {
  const divProps = { ref: useRef(), className }

  useEffect(() => {
    const onLoad = () => {
      const map = new window.google.maps.Map(divProps.ref.current, options)
      onMount && onMount(map)
    }
    if (!window.google) {
      const script = document.createElement(`script`)
      script.type = `text/javascript`
      script.src =
        `https://maps.googleapis.com/maps/api/js?key=` +
        process.env.GATSBY_GOOGLE_MAPS_API_KEY
      const headScript = document.getElementsByTagName(`script`)[0]
      headScript.parentNode.insertBefore(script, headScript)
      script.addEventListener(`load`, onLoad)
      return () => script.removeEventListener(`load`, onLoad)
    } else onLoad()
  }, [divProps.ref, onMount, options])

  return (
    <div
      css="height: 70vh; margin: 1em 0; border-radius: 0.5em;"
      {...divProps}
    />
  )
}

const shouldUpdate = (prevProps, nextProps) => {
  delete prevProps.options.mapTypeId
  const [prevFuncs, nextFuncs] = [functions(prevProps), functions(nextProps)]
  return (
    isEqual(omit(prevProps, prevFuncs), omit(nextProps, nextFuncs)) &&
    prevFuncs.every(fn => prevProps[fn].toString() === nextProps[fn].toString())
  )
}

export default React.memo(Map, shouldUpdate)

Map.defaultProps = {
  options: {
    center: { lat: 48, lng: 8 },
    zoom: 5,
  },
}
