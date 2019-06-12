import React, { useEffect, useRef } from "react"

export default function Map({ options, onMount, className }) {
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
        `https://maps.google.com/maps/api/js?key=` +
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

Map.defaultProps = {
  options: {
    center: { lat: 48, lng: 8 },
    zoom: 5,
  },
}
