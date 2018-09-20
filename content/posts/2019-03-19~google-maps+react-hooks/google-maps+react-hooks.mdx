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
showToc: true
---

import GoogleMap from 'components/Map'

Had to share this one since it's so nice and simple. If you're looking for a drop-in, zero-dependency Google Maps React component, look no further.

```js:title=src/components/map.js
import React, { useEffect, useRef } from 'react'

export default function Map({ options, onMount, className, onMountProps }) {
  const ref = useRef()
  const [map, setMap] = useState()

  useEffect(() => {
    const onLoad = () => setMap(new window.google.maps.Map(ref.current, options))
    if (!window.google) {
      const script = document.createElement(`script`)
      script.src =
        `https://maps.googleapis.com/maps/api/js?key=` +
        process.env.GOOGLE_MAPS_API_KEY
      document.head.append(script)
      script.addEventListener(`load`, onLoad)
      return () => script.removeEventListener(`load`, onLoad)
    } else onLoad()
  }, [options])

  if (map && typeof onMount === `function`) onMount(map, onMountProps)

  return (
    <div
      style={{ height: `60vh`, margin: `1em 0`, borderRadius: `0.5em` }}
      {...{ ref, className }}
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

```js:title=src/app.js
import React from 'react'
import Map from 'components/map.js'

export default () => (
  <>
    <h1>Google Maps</h1>
    <Map /> // highlight-line
  </>
)
```

This is what it looks like by default.

<GoogleMap />

## Customization

To change the area shown by the map and its zoom level, pass an `options` object containing the keys `center` and `zoom`.

```js
mapProps = {
  options: {
    center: { lat: 20, lng: 40 },
    zoom: 4,
  },
}

<Map {...mapProps} /> // highlight-line
```

If you'd like to do something more fancy you can also pass an `onMount` function. For example, the following function adds some markers to the map.

```js
function addMarkers(map, links) {
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
  onMount: addMarkers, // highlight-line
  onMountProps: linksComingFromSomewhere, // highlight-line
}

<Map {...mapProps} />
```

`linksComingFromSomewhere` is an array of objects each of which has the following shape:

```js
const link = {
  coords: { lat: 42, lng: 42 }, // required: latitude & longitude at which to display the marker
  title: `Life, the Universe and Everything`, // optional
  url: `https://wikipedia.org/wiki/Life,_the_Universe_and_Everything`, // optional
}
```

You might be wondering why we provide `onMountProps` to the `Map` component if all it does with them is pass them on as second argument to the `onMount` function. Wouldn't it be cleaner to [curry](https://en.wikipedia.org/wiki/Currying) the `onMount` function? Something like `const onMount = onMountProps => map => { ... }` and then pass it into the `Map` as `<Map onMount={addMarkers(links)} />`. That was indeed my first implementation. The problem with this approach is the `Map` component has no way of knowing that it needs to rerender in case the `onMountProps` change (say because the user clicked a button to display another marker on the map). That will only work if `<Map />` receives the new array of markers directly as props.

## Optimization

By default, the `Map` component will rerender whenever the parent component rerenders. There are two problems with this. First, it wastes computation since there's no need to rerender the map if its props didn't change. Second and more importantly, it ruins the user experience since the map will jump back to its initial `center` and `zoom` on every rerender. To prevent this, you can easily create a memoized map with the `useCallback` hook:

```js:title=src/app.js
import React, { useCallback } from 'react' // highlight-line
import Map from 'components/map.js'

const MemoMap = useCallback(<Map />, []) // highlight-line

export default () => (
  <div>
    <h1>This is a memoized map</h1>
    {MemoMap} // highlight-line
  </div>
)
```

In fact, you may want to make memoization part of the `Map` component itself by replacing

```js
export default function Map({ options, onMount, className, onMountProps }) {
  ...
}
```

with

```js:title=src/components/map.js
import { isEqual, omit, functions } from 'lodash'

function Map({ options, onMount, className }) {
  ...
}

function shouldNotUpdate(props, nextProps) {
  const [funcs, nextFuncs] = [functions(props), functions(nextProps)]
  const noPropChange = isEqual(omit(props, funcs), omit(nextProps, nextFuncs))
  const noFuncChange =
    funcs.length === nextFuncs.length &&
    funcs.every(fn => props[fn].toString() === nextProps[fn].toString())
  return noPropChange && noFuncChange
}

export default React.memo(Map, shouldNotUpdate) // highlight-line
```

[`React.memo`](https://reactjs.org/docs/hooks-faq.html#how-do-i-implement-shouldcomponentupdate) shallowly compares props and only rerenders a function component if the comparison returns false. It's the equivalent of `PureComponent` for class components. For components that receive objects, arrays and functions as props which are often referentially different on every render, the default behavior of shallow prop comparison can be overridden by passing a custom comparison function as second argument. It takes the next and previous props as input and returns true if the update should be skipped or false if the component should rerender.

The above `shouldNotUpdate` function uses the `functions` and `omit` utilities imported from [`lodash`](https://lodash.com) to first identify and remove all (top-level) functions from `props` and `nextProps` (in the above example, this only handles the `onMount` function but you may use additional functions in the future that would automatically be handled correctly by `shouldNotUpdate`). It then deep-compares the remaining props using `isEqual` followed by comparing the string representations of all omitted functions. If both comparisons return true, it skips the rerender and the user gets to keep the map's current position and zoom level.

One little gotcha that took me some time to figure out is that you also need to modify the `onLoad` function for `shouldNotUpdate` to work correctly. The problem is that the Google Maps API modifies the `options` object passed to the `Map` constructor _in-place_ (specifically, it adds a `mapTypeId` with default value `'roadmap'`). But only on the first render. The options object of subsequent renders remains unchanged. So on the first call to `shouldNotUpdate`, `props` will have this key (`props.options.mapTypeId`) but `nextProps` won't. Hence the `Map` component will think it needs to rerender even though nothing has changed. To fix this, we simply pass the `Map` constructor a copy of the `options` object rather than the object itself.

```js
const onLoad = () => setMap(new window.google.maps.Map(ref.current, { ...options }))
```

## Final Implementation

Putting all of the above together, here's the full component that I use in production.

```js:title=src/components/map.js
import { functions, isEqual, omit } from 'lodash'
import React, { useState, useEffect, useRef } from 'react'

function Map({ options, onMount, className, onMountProps }) {
  const ref = useRef()
  const [map, setMap] = useState()

  useEffect(() => {
    // The Google Maps API modifies the options object passed to
    // the Map constructor in place by adding a mapTypeId with default
    // value 'roadmap'. { ...options } prevents this by creating a copy.
    const onLoad = () =>
      setMap(new window.google.maps.Map(ref.current, { ...options }))
    if (!window.google) {
      const script = document.createElement(`script`)
      script.src =
        `https://maps.googleapis.com/maps/api/js?key=` +
        process.env.GOOGLE_MAPS_API_KEY
      document.head.append(script)
      script.addEventListener(`load`, onLoad)
      return () => script.removeEventListener(`load`, onLoad)
    } else onLoad()
  }, [options])

  if (map && typeof onMount === `function`) onMount(map, onMountProps)

  return (
    <div
      style={{ height: `60vh`, margin: `1em 0`, borderRadius: `0.5em` }}
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
```
