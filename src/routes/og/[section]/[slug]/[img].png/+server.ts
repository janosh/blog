import { Resvg } from '@resvg/resvg-js'
import { error } from '@sveltejs/kit'
import type { RequestHandler } from './$types'

// Social sites don't render SVG og:images, so SVG covers get a PNG copy at build time.
// The root layout links these URLs and the prerender crawler picks them up.
export const prerender = true

const svgs = import.meta.glob<string>(`/src/routes/*/*/*.svg`, {
  // Rolldown's production glob parser requires string literals for these options.
  query: '?raw',
  import: 'default',
  eager: true,
})

export const GET: RequestHandler = ({ params: { section, slug, img } }) => {
  const svg = svgs[`/src/routes/${section}/${slug}/${img}.svg`]
  if (!svg) error(404, `No SVG cover ${img}.svg in ${section}/${slug}`)
  const png = new Resvg(svg, {
    fitTo: { mode: `width`, value: 1200 },
    background: `white`,
  })
    .render()
    .asPng()
  return new Response(new Uint8Array(png), { headers: { 'content-type': `image/png` } })
}
