import { startCase } from 'lodash'
import PropTypes from 'prop-types'
import React from 'react'
import { Helmet } from 'react-helmet'

export default function Seo({ site, uri = ``, data, children }) {
  const title = uri.length > 1 ? `${startCase(uri)} | ${site.title}` : site.title
  const pageUrl = site.url + uri
  const desc = data?.page?.excerpt || site.description
  return (
    <Helmet title={title}>
      <meta property="og:type" content="website" />
      <html lang="en" />
      <meta property="og:title" content={title} />
      <meta property="og:url" content={pageUrl} />
      <meta property="og:description" content={desc} />
      <meta name="description" content={desc} />
      <link rel="canonical" href={pageUrl} />
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
  uri: PropTypes.string,
  description: PropTypes.string,
}
