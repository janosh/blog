const min = width => `only screen and (min-width: ${width}em)`
const max = width => `only screen and (max-width: ${width}em)`

// screen sizes in em units
export const screens = {
  phone: 30,
  phablet: 40,
  tablet: 50,
  netbook: 60,
  laptop: 70,
  desktop: 100,
}

const mediaQuery = {}

for (const key of Object.keys(screens)) {
  const Key = key[0].toUpperCase() + key.substr(1)
  for (const [func, name] of [
    [min, `min`],
    [max, `max`],
  ]) {
    // css query
    const query = func(screens[key])
    mediaQuery[name + Key] = `@media ` + query
    // js query (see window.matchMedia)
    mediaQuery[name + Key + `Js`] = query
  }
}

export default mediaQuery
