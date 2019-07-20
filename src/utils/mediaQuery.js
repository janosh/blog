import { startCase } from 'lodash'

const min = width => `only screen and (min-width: ${width}em)`
const max = width => `only screen and (max-width: ${width}em)`

const mediaQuery = {
  screens: {
    // screen sizes in em units
    phone: 30,
    phablet: 40,
    tablet: 50,
    netbook: 60,
    laptop: 70,
    desktop: 100,
  },
}

for (const key of Object.keys(mediaQuery.screens)) {
  const Key = startCase(key)
  for (const [func, name] of [[min, `min`], [max, `max`]]) {
    // css query
    const query = func(mediaQuery.screens[key])
    mediaQuery[name + Key] = `@media ` + query
    // js query (see window.matchMedia)
    mediaQuery[name + Key + `Js`] = query
  }
}

export default mediaQuery
