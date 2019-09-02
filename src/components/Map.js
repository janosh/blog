import { functions, isEqual, omit } from 'lodash'
import React, { useEffect, useRef } from 'react'

const apiKey = process.env.GATSBY_GOOGLE_MAPS_API_KEY

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
      script.src = `https://maps.googleapis.com/maps/api/js?key=` + apiKey
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

// https://github.com/gatsbyjs/gatsby/issues/17341
export const MapEmbed = ({ place, ...rest }) => (
  <iframe
    src={`https://google.com/maps/embed/v1/place?q=${place}&key=${apiKey}`}
    css="height: 60vh; width: 100%; border: 0; border-radius: 0.5em;"
    {...rest}
  />
)
