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
  maxPhone: max(screenSize.phone),
  maxPhablet: max(screenSize.phablet),
  maxTablet: max(screenSize.tablet),
  maxNetbook: max(screenSize.netbook),
  maxLaptop: max(screenSize.laptop),
  maxDesktop: max(screenSize.desktop),

  minPhone: min(screenSize.phone),
  minPhablet: min(screenSize.phablet),
  minTablet: min(screenSize.tablet),
  minNetbook: min(screenSize.netbook),
  minLaptop: min(screenSize.laptop),
  minDesktop: min(screenSize.desktop),
}

export default mediaQuery
