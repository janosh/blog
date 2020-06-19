import { startCase } from 'lodash'
import React from 'react'
import { Helmet } from 'react-helmet'
import favicon from '../../content/favicon.svg'

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
      <link rel="icon" href={favicon} type="image/svg+xml" sizes="any" />
      {children}
    </Helmet>
  )
}
