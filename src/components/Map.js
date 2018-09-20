import { functions, isEqual, omit } from 'lodash'
import React, { useEffect, useRef, useState } from 'react'

const apiKey = process.env.GATSBY_GOOGLE_MAPS_API_KEY

function Map({ options, onMount, className, onMountProps }) {
  const ref = useRef()
  const [map, setMap] = useState()

  useEffect(() => {
    // The Map constructor modifies its options object in place by adding
    // a mapTypeId with default value 'roadmap'. This confuses shouldNotUpdate.
    // { ...options } prevents this by passing in a copy.
    const onLoad = () =>
      setMap(new window.google.maps.Map(ref.current, { ...options }))
    if (!window.google) {
      const script = document.createElement(`script`)
      script.src = `https://maps.googleapis.com/maps/api/js?key=` + apiKey
      document.head.append(script)
      script.addEventListener(`load`, onLoad)
      return () => script.removeEventListener(`load`, onLoad)
    } else onLoad()
  }, [options])

  if (map && typeof onMount === `function`) onMount(map, onMountProps)

  return (
    <div
      css="height: 35em; max-height: 70vh; margin: 1em 0; border-radius: 0.5em;"
      {...{ ref, className }}
    />
  )
}

function shouldNotUpdate(props, nextProps) {
  const [funcs, nextFuncs] = [functions(props), functions(nextProps)]
  const noPropChange = isEqual(omit(props, funcs), omit(nextProps, nextFuncs))
  const noFuncChange =
    funcs.length === nextFuncs.length &&
    funcs.every(fn => props[fn].toString() === nextProps[fn].toString())
  return noPropChange && noFuncChange
}

export default React.memo(Map, shouldNotUpdate)

Map.defaultProps = {
  options: {
    center: { lat: 48, lng: 8 },
    zoom: 5,
  },
}

// https://github.com/gatsbyjs/gatsby/issues/17341
export const MapEmbed = ({ place, ...rest }) => (
  <iframe
    src={`https://google.com/maps/embed/v1/place?q=${place}&key=${apiKey}`}
    css="height: 35em; max-height: 70vh; width: 100%; border: 0; border-radius: 0.3em;"
    {...rest}
  />
)
