---
title: Google Maps + React Hooks
slug: /google-maps+react-hooks
date: 2019-03-19
cover:
  img: google-maps+react-hooks.svg
tags:
  - Web Dev
  - Tutorial
  - JS
---

Had to share this one since it's so nice and simple. If you're looking for a drop-in, zero-dependency Google Maps React component, look no further. Here it is:

```js:title=src/components/map.js
import React, { useEffect, useRef } from 'react'

export default function Map({ options, onMount, className }) {
  const props = { ref: useRef(), className }
  const onLoad = () => {
    const map = new window.google.maps.Map(props.ref.current, options)
    onMount && onMount(map)
  }

  useEffect(() => {
    if (!window.google) {
      const script = document.createElement(`script`)
      script.type = `text/javascript`
      script.src =
        `https://maps.google.com/maps/api/js?key=` +
        process.env.GOOGLE_MAPS_API_KEY
      const headScript = document.getElementsByTagName(`script`)[0]
      headScript.parentNode.insertBefore(script, headScript)
      script.addEventListener(`load`, onLoad)
      return () => script.removeEventListener(`load`, onLoad)
    } else onLoad()
  })

  return (
    <div
      {...props}
      style={{ height: `70vh`, margin: `1em 0`, borderRadius: `0.5em` }}
    />
  )
}

Map.defaultProps = {
  options: {
    center: { lat: 48, lng: 8 },
    zoom: 5,
  },
}
```

To use it, simply grab a free Google Maps API key from [Google's cloud console](https://console.cloud.google.com) ([here's a guide for that](https://developers.google.com/maps/documentation/javascript/get-api-key)) and either add it to your `.env` file or paste it in directly for `process.env.GOOGLE_MAPS_API_KEY`.

Then simply drop in the above `Map` component wherever you'd like to display a Google map.

```js{7}:title=src/app.js
import React from 'react'
import Map from './components/map.js'

export default () => (
  <div>
    <h1>Google Maps</h1>
    <Map />
  </div>
)
```

To change the area shown by the map and its zoom level, pass it an `options` object containing the keys `center` and `zoom`.

```js
mapProps = {
  options: {
    center: { lat: 20, lng: 40 },
    zoom: 4,
  },
}

<Map {...mapProps} />
```

If you'd like to do something more fancy, for instance add some markers to the map, you can also pass in an `onMount` function:

```js{17}
const addMarkers = links => map => {
  links.forEach((link, index) => {
    const marker = new window.google.maps.Marker({
      map,
      position: link.coords,
      label: `${index + 1}`,
      title: link.title,
    })
    marker.addListener(`click`, () => {
      window.location.href = link.url
    })
  })
}

mapProps = {
  options: { center: { lat: 20, lng: 40 }, zoom: 4 },
  onMount: addMarkers(linksComingFromSomewhere),
}

<Map {...mapProps} />
```

`link.coords` should be an object of the same structure as `center`, i.e. with `lat` and `lng` keys for the latitude and longitude at which to display each marker.

Note that the `onMount` function must be curried since the `Map` component itself passes in the `map` object on which to apply `onMount`.

## Optimization

By default, when using the `Map` component it will rerender whenever the parent component rerenders. Not only does this waste computation since there's no need to rerender the map if its props didn't change, even more importantly, it also ruins the user experience since the map will jump back to its initial `center` and `zoom` on every rerender. To prevent this, you can easily create a memoized map with the `useCallback` hook:

```js{1,4,9}:title=src/app.js
import React, { useCallback } from 'react'
import Map from './components/map.js'

const MemoMap = useCallback(<Map />, [])

export default () => (
  <div>
    <h1>This is a memoized map</h1>
    {MemoMap}
  </div>
)
```

In fact, you may want to make memoization part of the `Map` component itself by replacing

```js
export default function Map({ options, onMount, className }) {
  ...
}
```

with

```js{7,15}:title=src/components/map.js
import { isEqual, omit, functions } from 'lodash'

function Map({ options, onMount, className }) {
  ...
}

const shouldUpdate = (prevProps, nextProps) => {
  const [prevFuncs, nextFuncs] = [functions(prevProps), functions(nextProps)]
  return (
    isEqual(omit(prevProps, prevFuncs), omit(nextProps, nextFuncs)) &&
    prevFuncs.every(fn => prevProps[fn].toString() === nextProps[fn].toString())
  )
}

export default React.memo(Map, shouldUpdate)
```

[`React.memo`](https://reactjs.org/docs/hooks-faq.html#how-do-i-implement-shouldcomponentupdate) shallowly compares props and only rerenders a function component if the comparison returns false. It's the function component equivalent to `PureComponent` for class components. For components that receive objects, arrays and functions as props which can be referentially different on every render, the default behavior of shallow prop comparison can be overriden by passing a custom comparison function as second argument. It takes the next and previous props as input and returns true if the update should be skipped or false if the component should rerender.

The above `shouldUpdate` function uses the `functions` and `omit` utilities imported from [`lodash`](https://lodash.com) to first identify and remove all (top-level) functions from `prevProps` and `nextProps` (in the above example, this only handles the `onMount` function but you may use additional functions in the future that would automatically be handled correctly by `shouldUpdate`). It then deep-compares the remaining props using `isEqual` followed by comparing the string representations of all omitted functions. If both comparisons return true, it skips the rerender and the user gets to keep the map's current position and zoom level.
