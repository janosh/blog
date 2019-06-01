import React from "react"
import PropTypes from "prop-types"
import { Helmet } from "react-helmet"

export default function Seo({ site, pageTitle, path = ``, ...rest }) {
  const { description, children } = rest
  const title = pageTitle ? `${pageTitle} | ${site.title}` : site.title
  const pageUrl = site.url + path
  const desc = description || site.description
  return (
    <Helmet>
      <title>{title}</title>
      <meta property="og:type" content="website" />
      <html lang="en" />
      {pageTitle && <meta property="og:title" content={pageTitle} />}
      <meta property="og:url" content={pageUrl} />
      <meta property="og:description" content={desc} />
      <meta name="description" content={desc} />
      {children}
    </Helmet>
  )
}

Seo.propTypes = {
  site: PropTypes.shape({
    title: PropTypes.string.isRequired,
    url: PropTypes.string.isRequired,
    description: PropTypes.string.isRequired,
  }),
  pageTitle: PropTypes.string,
  path: PropTypes.string,
  description: PropTypes.string,
}
