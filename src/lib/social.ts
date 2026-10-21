// Profile links shown on the home page, the CV and in every page's footer. Kept out of
// cv.yml so the footer doesn't pull the whole CV into every page's bundle.
import { Email, GitHub, GoogleScholar, LinkedIn, ORCID } from 'svelte-widgets/icons'

export const social = [
  { name: `GitHub`, url: `https://github.com/janosh`, icon: GitHub },
  {
    name: `Google Scholar`,
    url: `https://scholar.google.com/citations?user=Lfw6Id0AAAAJ`,
    icon: GoogleScholar,
    style: `transform: scale(1.15);`,
  },
  { name: `ORCID`, url: `https://orcid.org/0000-0001-5233-3462`, icon: ORCID },
  { name: `LinkedIn`, url: `https://linkedin.com/in/janosh-riebesell`, icon: LinkedIn },
  {
    name: `Email`,
    url: `mailto:janosh.riebesell@gmail.com`,
    icon: Email,
    style: `transform: translateY(-2px) scale(1.25); vertical-align: middle;`,
  },
]
