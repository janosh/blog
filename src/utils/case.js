export const paramCase = str => str.toLowerCase().replace(` `, `-`)

export const titleCase = str =>
  str
    ? str
      .split(` `)
      .map(word => word[0].toUpperCase() + word.substr(1).toLowerCase())
      .join(` `)
    : str
