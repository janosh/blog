/// <reference types="node" />

// Compile typeset physics notes (src/routes/physics/**/pdfs/*.typ) to PDF next to their
// sources and refresh the matching card thumbnails. Needs the typst and magick CLIs.
// Usage: pnpm build-notes [file.typ ...]  (default: all notes)
import { execFileSync } from 'node:child_process'
import { globSync, mkdtempSync, rmSync } from 'node:fs'
import { tmpdir } from 'node:os'
import { join } from 'node:path'

const root = `src/routes/physics`
const args = process.argv.slice(2)
const sources = args.length ? args : globSync(`${root}/**/pdfs/*.typ`)
const scratch = mkdtempSync(join(tmpdir(), `notes-`))

for (const typ of sources) {
  const compile = (out: string, ...flags: string[]) =>
    execFileSync(`typst`, [`compile`, `--root`, root, ...flags, typ, out], {
      stdio: `inherit`,
    })
  compile(typ.replace(/\.typ$/u, `.pdf`))
  // first page at 100 ppi (827 x 1169 px for A4), matching the existing thumbnails
  const png = join(scratch, `page.png`)
  compile(png, `--pages`, `1`, `--ppi`, `100`)
  const thumb = typ.replace(`/pdfs/`, `/thumbnails/`).replace(/\.typ$/u, `.webp`)
  execFileSync(`magick`, [
    png,
    `-background`,
    `white`,
    `-flatten`,
    `-quality`,
    `80`,
    thumb,
  ])
  console.info(`built ${typ}`)
}
rmSync(scratch, { recursive: true })
