export const paramCase = str => str.toLowerCase().replace(` `, `-`)

export const titleCase = str =>
  str
    ? str
      .split(` `)
      .map(word => word[0].toUpperCase() + word.substr(1).toLowerCase())
      .join(` `)
    : str

export const disqusConfig = ({ slug, title }) => ({
  shortname: process.env.GATSBY_DISQUS_NAME,
  config: { identifier: slug, title },
})
