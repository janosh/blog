// schema.org Person for search engines, passed as page data by the home page and CV so
// the CV data stays out of other pages' bundles.
import { homepage } from '#root/package.json'
import { social } from '#lib/social.js'
import cv from '../../routes/cv/cv.yml'
import portrait from '../../routes/janosh.webp'

const [current_job] = cv.experience
const person = {
  '@context': `https://schema.org`,
  '@type': `Person`,
  name: `Janosh Riebesell`,
  url: homepage,
  image: new URL(portrait, homepage).href,
  jobTitle: current_job.role,
  worksFor: {
    '@type': `Organization`,
    name: current_job.organization,
    url: current_job.href,
  },
  alumniOf: [...new Set(cv.education.map(({ uni }) => uni))].map((name) => ({
    '@type': `CollegeOrUniversity`,
    name,
  })),
  sameAs: social.map(({ url }) => url).filter((url) => url.startsWith(`http`)),
}

// escape `<` so the JSON can't close its script tag early
export const person_json_ld = `<script type="application/ld+json">${JSON.stringify(person).replaceAll(`<`, `\\u003c`)}</script>`
