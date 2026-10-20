import { Resvg } from '@resvg/resvg-js'
import { error } from '@sveltejs/kit'
import { readFileSync } from 'node:fs'
import sharp from 'sharp'
import type { RequestHandler } from './$types'

// Social sites don't render SVG and some don't render WebP/AVIF og:images, so at build time
// SVG covers get a PNG copy (<stem>.png) and WebP/AVIF covers a 1200x630 JPEG crop
// (<stem>.jpg). The root layout links these URLs and the prerender crawler picks them up.
export const prerender = true

const svgs = import.meta.glob<string>(`/src/routes/*/*/*.svg`, {
  // Rolldown's production glob parser requires string literals for these options.
  query: '?raw',
  import: 'default',
  eager: true,
})
const rasters = Object.keys(import.meta.glob(`/src/routes/*/*/*.{webp,avif}`))

export const GET: RequestHandler = async ({ params: { section, slug, img } }) => {
  const stem = `/src/routes/${section}/${slug}/${img.replace(/\.(?:png|jpg)$/u, ``)}`
  const svg = img.endsWith(`.png`) && svgs[`${stem}.svg`]
  if (svg) {
    const png = new Resvg(svg, {
      fitTo: { mode: `width`, value: 1200 },
      background: `white`,
    })
      .render()
      .asPng()
    return new Response(new Uint8Array(png), { headers: { 'content-type': `image/png` } })
  }
  const raster =
    img.endsWith(`.jpg`) && rasters.find((path) => path.startsWith(`${stem}.`))
  if (!raster) error(404, `No cover for ${img} in ${section}/${slug}`)
  const jpg = await sharp(readFileSync(`.${raster}`))
    .resize(1200, 630, { fit: `cover` })
    .jpeg({ quality: 85, mozjpeg: true })
    .toBuffer()
  return new Response(new Uint8Array(jpg), { headers: { 'content-type': `image/jpeg` } })
}
