const min = width => `@media only screen and (min-width: ${width}em)`
const max = width => `@media only screen and (max-width: ${width}em)`

export const screenSize = {
  // screen sizes in em units
  phone: 30,
  phablet: 40,
  tablet: 50,
  netbook: 60,
  laptop: 70,
  desktop: 100,
}

const mediaQuery = {
  phone: max(screenSize.phone),
  tablet: max(screenSize.tablet),
  phablet: max(screenSize.phablet),
  netbook: max(screenSize.netbook),
  laptop: max(screenSize.laptop),
  desktop: max(screenSize.desktop),

  minPhone: min(screenSize.phone),
  minTablet: min(screenSize.tablet),
  minPhablet: min(screenSize.phablet),
  minNetbook: min(screenSize.netbook),
  minLaptop: min(screenSize.laptop),
  minDesktop: min(screenSize.desktop),
}

export default mediaQuery
