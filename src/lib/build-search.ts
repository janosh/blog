/// <reference types="node" />

// Build the pagefind index for the static site plus one page per Typst physics note, with a
// section per heading, so searching e.g. "Wick's theorem" opens the note's PDF at the page
// where that section starts (PDF outline entries give the pages).
// Usage: node src/lib/build-search.ts (after `vp build`, part of `pnpm build`)
import { existsSync, globSync, readFileSync } from 'node:fs'
import * as pagefind from 'pagefind'
import { getDocument } from 'pdfjs-dist/legacy/build/pdf.mjs'

const closing: Record<string, string> = { '(': `)`, '{': `}`, '[': `]` }

// Plain text of a Typst note for search: keeps prose, content blocks and math; drops
// comments and code (imports, set/show/let rules, function arguments, CeTZ drawings).
export function typst_text(src: string): string {
  let [out, idx] = [``, 0]
  // index just past the next occurrence of token (or the end of the source)
  const past = (token: string) => {
    const at = src.indexOf(token, idx)
    return at === -1 ? src.length : at + token.length
  }
  // skip a balanced (...), {...} or [...] group starting at src[idx]
  const skip_group = () => {
    const [open, close] = [src[idx], closing[src[idx]]]
    let depth = 0
    do {
      if (src[idx] === open) depth++
      else if (src[idx] === close) depth--
      idx++
    } while (depth > 0 && idx < src.length)
  }
  while (idx < src.length) {
    if (src.startsWith(`//`, idx) && src[idx - 1] !== `:`) idx = past(`\n`)
    else if (src.startsWith(`/*`, idx)) idx = past(`*/`)
    else if (src[idx] === `#` && /[a-z]/iu.test(src[idx + 1] ?? ``)) {
      const name = /^#(?<name>[\w.-]+)/u.exec(src.slice(idx))?.groups?.name ?? ``
      idx += name.length + 1
      if ([`import`, `include`, `let`, `set`, `show`].includes(name)) {
        // a rule runs to the end of its line, including groups that span lines
        while (idx < src.length && src[idx] !== `\n`) {
          if (src[idx] in closing) skip_group()
          else idx++
        }
      } else {
        // call arguments and chained methods, e.g. #counter(heading).update(0)
        while (
          src[idx] === `(` ||
          src[idx] === `{` ||
          /^\.[a-z]/iu.test(src.slice(idx, idx + 2))
        ) {
          if (src[idx] === `.`) idx += /^\.[\w-]+/u.exec(src.slice(idx))?.[0].length ?? 1
          else skip_group()
        }
      }
    } else out += src[idx++]
  }
  return out.replaceAll(/[[\]]/gu, ` `).replaceAll(/\s+/gu, ` `).trim()
}

// Split a Typst note at its headings (`= Title` markup, `#heading(...)[Title]` calls or the
// `#part[Title]` helper of atomic-physics/sheet.typ) into the text before the first heading
// and one { title, text } per heading, in document order.
export function typst_sections(src: string) {
  const [intro, ...chunks] = src.split(/^(?==+\s|#heading\(|#part\[)/mu)
  const sections = chunks.map((chunk) => {
    const [line, ...rest] = chunk.split(`\n`)
    const title = /^=+\s+(?<eq>.+)$|^#(?:heading\([^)]*\)|part)\[(?<call>.+)\]/u.exec(
      line,
    )?.groups
    return {
      title: typst_text(title?.eq ?? title?.call ?? line),
      text: typst_text(rest.join(`\n`)),
    }
  })
  return { intro: typst_text(intro), sections }
}

// 1-based page of each PDF outline entry in document order (Typst bookmarks every heading)
async function outline_pages(path: string): Promise<number[]> {
  const task = getDocument({ data: new Uint8Array(readFileSync(path)) })
  const doc = await task.promise
  const pages: number[] = []
  const walk = async (items: Awaited<ReturnType<typeof doc.getOutline>>) => {
    for (const { dest, items: children } of items ?? []) {
      const ref = (typeof dest === `string` ? await doc.getDestination(dest) : dest)?.[0]
      pages.push(ref ? (await doc.getPageIndex(ref)) + 1 : 1)
      await walk(children)
    }
  }
  await walk(await doc.getOutline())
  await task.destroy()
  return pages
}

const escape = (text: string) =>
  text.replaceAll(`&`, `&amp;`).replaceAll(`<`, `&lt;`).replaceAll(`>`, `&gt;`)

if (import.meta.main) {
  const { index } = await pagefind.createIndex({
    excludeSelectors: [`pre`, `details`, `math`],
  })
  if (!index) throw new Error(`pagefind failed to create an index`)
  await index.addDirectory({ path: `build` })
  // one page per note card with a Typst source, at its PDF URL (as linked by the built card)
  for (const md of globSync(`src/routes/physics/*/+page.md`)) {
    const page = readFileSync(md, `utf8`)
    const topic = /^title: (?<title>.+)$/mu.exec(page)?.groups?.title
    const slug = md.split(`/`).at(-2)
    const html = readFileSync(`build/physics/${slug}.html`, `utf8`)
    for (const { groups } of page.matchAll(
      /<Note file="(?<file>[^"]+)" title="(?<title>[^"]+)"/gu,
    )) {
      const [file, title] = [groups?.file ?? ``, groups?.title ?? ``]
      const typ = md.replace(`+page.md`, `pdfs/${file}.typ`)
      if (!existsSync(typ)) continue
      const card = html.indexOf(`id="${file}"><a href="`)
      if (card === -1)
        throw new Error(`No card for ${file} in build/physics/${slug}.html`)
      const pdf_url = html.slice(card).split(`"`)[3]
      const { intro, sections } = typst_sections(readFileSync(typ, `utf8`))
      const pages = await outline_pages(typ.replace(/\.typ$/u, `.pdf`))
      // without a 1:1 match between source headings and PDF outline, index the note as one page
      const aligned = pages.length === sections.length
      if (!aligned)
        console.warn(`${typ}: ${sections.length} headings, ${pages.length} bookmarks`)
      const body = sections.map(({ title: heading, text }, idx) =>
        aligned
          ? `<h2 id="page=${pages[idx]}">${escape(heading)}</h2><p>${escape(text)}</p>`
          : `<p>${escape(`${heading} ${text}`)}</p>`,
      )
      await index.addHTMLFile({
        url: pdf_url,
        content: `<html lang="en"><body data-pagefind-body><h1 data-pagefind-meta="title">${escape(`${title} · ${topic}`)}</h1><p>${escape(intro)}</p>${body.join(``)}</body></html>`,
      })
    }
  }
  await index.writeFiles({ outputPath: `build/pagefind` })
  await pagefind.close()
}
