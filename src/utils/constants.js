export const COLOR_MODE_KEY = `color-mode`

export const INITIAL_COLOR_MODE_CSS_PROP = `--initial-color-mode`

export const COLORS = {
  gray: {
    default: `#464849`,
    dark: `#3d3d3d`,
    darker: `#1a1d23`,
    darkest: `#060606`,
    light: `#bcbcbc`,
    lighter: `#e5e5e5`,
    lightest: `#f7f7f7`,
  },
  blue: {
    default: `#2202a9`,
    dark: `#150956`,
    darker: `#0a051e`,
    darkest: `#00040c`,
    light: `#1f59cd`,
    lighter: `#279AF1`,
  },
  orange: {
    default: `#d2ae00`,
    dark: `#ff9100`,
    darker: `#ff7600`,
    darkest: `#b75500`,
  },
  green: {
    light: `#00948f`,
  },
}

const { gray, blue, orange } = COLORS

export const MODE_COLORS = {
  text: {
    light: `black`,
    dark: gray.lighter,
  },
  background: {
    light: `white`,
    dark: blue.darker,
  },
  shadow: {
    light: gray.lighter,
    dark: `black`,
  },
  link: {
    light: blue.light,
    dark: blue.lighter,
  },
  lightLink: {
    light: blue.lighter,
    dark: blue.lighter,
  },
  accentBackground: {
    light: `rgba(0, 0, 0, 0.05)`,
    dark: `rgba(0, 0, 0, 0.7)`,
  },
  gray: {
    light: gray.regular,
    dark: gray.light,
  },
  lightGray: {
    light: gray.lightest,
    dark: gray.darker,
  },
  darkGray: {
    light: gray.default,
    dark: gray.darkest,
  },
  a: {
    light: orange.default,
    dark: orange.darker,
  },
  b: {
    light: blue.dark,
    dark: blue.darkest,
  },
  c: {
    light: blue.light,
    dark: blue.lighter,
  },
  d: {
    light: orange.darker,
    dark: orange.darkest,
  },
}
