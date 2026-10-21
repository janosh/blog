// Render the single-page CV PDF served at /cv.pdf (and via /cv/pdf). Runs after
// `vp build`: serves build/ locally and prints /cv?single-page with headless Chrome, the
// same layout as the CV page's "Export PDF → Single tall page".
import { execFile } from 'node:child_process'
import { existsSync, readFileSync, statSync } from 'node:fs'
import { createServer } from 'node:http'
import { extname, join, resolve } from 'node:path'
import { promisify } from 'node:util'

const build_dir = resolve(`build`)
const out_file = join(build_dir, `cv.pdf`)
const chrome = [
  process.env.CHROME_PATH,
  `/Applications/Google Chrome.app/Contents/MacOS/Google Chrome`,
  `/usr/bin/google-chrome`, // GitHub's Ubuntu runners
  `/usr/bin/chromium`,
].find((path) => path && existsSync(path))
if (!chrome) throw new Error(`No Chrome found; set CHROME_PATH to a Chrome binary`)

// Chrome needs these MIME types (module scripts, stylesheets, SVG images); it sniffs the rest
const types: Record<string, string> = {
  '.html': `text/html`,
  '.js': `text/javascript`,
  '.css': `text/css`,
  '.svg': `image/svg+xml`,
}
// static server resolving /path to /path.html like GitHub Pages
const server = createServer((req, res) => {
  const path = join(
    build_dir,
    decodeURIComponent(new URL(req.url ?? ``, `http://x`).pathname),
  )
  const file = [path, `${path}.html`].find((candidate) =>
    statSync(candidate, { throwIfNoEntry: false })?.isFile(),
  )
  if (!file) res.writeHead(404).end()
  else
    res
      .writeHead(200, { 'content-type': types[extname(file)] ?? `` })
      .end(readFileSync(file))
})
await new Promise<void>((done) => {
  server.listen(0, `127.0.0.1`, done)
})
const { port } = server.address() as { port: number }

try {
  // async so the server above keeps answering Chrome's requests
  await promisify(execFile)(
    chrome,
    [
      `--headless=new`,
      `--disable-gpu`,
      `--no-sandbox`,
      `--no-pdf-header-footer`,
      `--virtual-time-budget=15000`,
      `--print-to-pdf=${out_file}`,
      `http://127.0.0.1:${port}/cv?single-page`,
      // virtual time pauses on pending requests, so a stalled remote logo could hang forever
    ],
    { timeout: 120_000 },
  )
} finally {
  server.close()
}
// fail loudly if Chrome wrote nothing or the page never applied its one-page @page size
if (!/\/Count 1\b/u.test(readFileSync(out_file, `latin1`)))
  throw new Error(`${out_file} is not a single page; /cv?single-page did not size it`)
process.stdout.write(
  `wrote ${out_file} (${Math.round(statSync(out_file).size / 1024)} KB)\n`,
)
