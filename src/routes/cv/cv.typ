// The CV PDF served at /cv.pdf (and via /cv), typeset from cv.yml, intro.md,
// src/lib/oss.yml (project links and stars), src/lib/papers.yaml, the logo SVGs in
// src/lib and svelte-widgets' icon glyphs.
// Build from the repo root: typst compile --root . src/routes/cv/cv.typ build/cv.pdf

#let cv = yaml("cv.yml")
#let oss = yaml("../../lib/oss.yml").projects
#let papers = yaml("../../lib/papers.yaml").references
#let intro = read("intro.md").replace("**", "*").trim()

#set document(title: "Janosh Riebesell – CV", author: "Janosh Riebesell")
#set page(paper: "a4", margin: (x: 1.7cm, y: 1.5cm))
#set text(size: 9.6pt) // Typst's bundled default font, same output on every machine
#set par(leading: 0.55em)
#let accent = rgb("#1a5fb4")
#show link: set text(fill: accent)

// === Icons ===
// A logo SVG from src/lib at text height. Logos drawn white for the site's dark theme
// (color_invert: light) get black fills, since the PDF is always on white paper.
#let logo(file, invert: none) = {
  let svg = read("../../lib/" + file)
  if invert == "light" { svg = svg.replace("fill=\"white\"", "fill=\"black\"") }
  // text height, but wide logos (IOP, MRS) are capped at 1.6em wide so they don't dominate
  context {
    let natural = measure(image(bytes(svg), format: "svg", height: 1.1em)).width
    let size = if natural > 1.6em.to-absolute() { (width: 1.6em) } else { (height: 1.1em) }
    box(baseline: 20%, image(bytes(svg), format: "svg", ..size))
  }
}
// A svelte-widgets glyph (single-path SVG data in its generated icon module) by export name
#let glyphs = read("../../../node_modules/svelte-widgets/dist/icons/generated.js")
#let glyph(name) = {
  let found = glyphs.match(regex("export const " + name + " = \\{ viewBox: `([^`]+)`, d: `([^`]+)`"))
  assert(found != none, message: "no svelte-widgets icon named " + name)
  let (view_box, path) = found.captures
  let svg = "<svg xmlns='http://www.w3.org/2000/svg' viewBox='" + view_box + "'><path fill='#444' d='" + path + "'/></svg>"
  box(baseline: 15%, image(bytes(svg), format: "svg", height: 1em))
}
// A logo in a fixed-width slot so the names after it line up down a list
#let row_logo(file, invert: none) = box(width: 1.95em, logo(file, invert: invert))
// The logo file or glyph a cv.yml row names
#let icon(item) = if "logo" in item { logo(item.logo) } else { glyph(item.icon) }

#let section(title) = {
  v(0.55em)
  text(size: 11.5pt, weight: "bold", fill: accent, title)
  v(-0.75em)
  line(length: 100%, stroke: 0.5pt + accent)
  v(-0.2em)
}
#let entry(left, right: none, body) = {
  grid(columns: (1fr, auto), text(weight: "bold", left), text(fill: luma(90), right))
  if body != none { pad(left: 0.6em, top: -0.25em, body) }
}

// === Header ===
#let current = cv.experience.first()
#align(center)[
  #text(size: 20pt, weight: "bold")[Janosh Riebesell]
  #v(-0.6em)
  #text(size: 10.5pt)[#current.role, #current.organization]
  #v(-0.5em)
  #text(size: 8.8pt)[
    #link("mailto:janosh.riebesell@gmail.com")[janosh.riebesell\@gmail.com] ·
    #link("https://janosh.dev")[janosh.dev] ·
    #link("https://github.com/janosh")[github.com/janosh] ·
    #link("https://scholar.google.com/citations?user=Lfw6Id0AAAAJ")[Google Scholar] ·
    #link("https://orcid.org/0000-0001-5233-3462")[ORCID] ·
    #link("https://linkedin.com/in/janosh-riebesell")[LinkedIn]
  ]
]

#eval(intro, mode: "markup")

// === Experience ===
#section[Experience]
#for job in cv.experience {
  let title = if "role" in job [#job.organization — #job.role] else [#job.organization]
  entry([#row_logo(job.logo)#link(job.href, title)], right: job.dates, list(..job.contributions))
}

// === Open source ===
#section[Selected open source]
#for selection in cv.selected_projects {
  let matches = oss.filter(project => project.name == selection.name)
  assert(matches.len() == 1, message: "unknown CV project " + selection.name)
  let project = matches.first() + selection
  let links = (
    if "url" in project { link(project.url)[site] },
    link(project.repo)[code],
    if "stars" in project [#project.stars stars],
  ).filter(item => item != none)
  let mark = row_logo(project.logo, invert: project.at("color_invert", default: none))
  entry([#mark#project.name — #project.role], right: links.join[ · ], list(project.contribution))
}

// === Publications ===
#let me(author) = author.given == "Janosh" and author.family == "Riebesell"
#let initials(author) = author.given.first() + ". " + author.family
// First, own and last author with … for gaps, as on the /cv page
#let authors(list) = {
  let my_idx = list.position(me)
  assert(my_idx != none, message: "Janosh Riebesell missing from a publication")
  let last = list.len() - 1
  let shown = if list.len() <= 3 { range(list.len()) } else {
    (0, if my_idx > 0 and my_idx < last { my_idx } else { 1 }, last)
  }
  let parts = ()
  for (pos, idx) in shown.enumerate() {
    if pos > 0 and idx - shown.at(pos - 1) > 1 { parts.push[…] }
    let name = initials(list.at(idx))
    parts.push(if idx == my_idx { strong(name) } else { name })
  }
  parts.join[, ]
}
#let year(paper) = paper.issued.first().year
#let date(paper) = {
  let issued = paper.issued.first()
  issued.year * 10000 + issued.at("month", default: 0) * 100 + issued.at("day", default: 0)
}
// * first or joint first author, † senior (last) author
#let marker(paper) = if me(paper.author.first()) or paper.id in cv.joint_first_author [\* ] else if me(paper.author.last()) [† ]

#section[Publications]
#text(size: 8.8pt)[\* first or joint first author, † senior author]
#[
  #set text(size: 9.1pt)
  #set enum(spacing: 0.5em)
  #for paper in papers.sorted(key: paper => -date(paper)) {
    let venue = paper.at("container-title", default: "preprint")
    let href = if "DOI" in paper { "https://doi.org/" + paper.DOI } else { paper.at("URL", default: none) }
    enum.item[
      #marker(paper)#authors(paper.author). #paper.title. _#venue;_ (#year(paper)).
      #if href != none { link(href)[link] }
    ]
  }
]

// === Education ===
#section[Education]
#for degree in cv.education {
  let thesis = degree.thesis
  let thesis_title = if "url" in thesis and thesis.url.starts-with("http") { link(thesis.url, thesis.title) } else { thesis.title }
  entry([#row_logo(degree.logo)#degree.title — #degree.uni], [Thesis: #thesis_title])
}

// === Skills, community, languages ===
#section[Skills]
#grid(
  columns: (auto, 1fr), column-gutter: 1em, row-gutter: 0.5em,
  ..cv.skills.map(group => (strong(group.name), group.items.map(item => [#icon(item) #item.name]).join(h(1em)))).flatten(),
)

#section[Community]
// one paragraph per role, hanging-indented past its icon so wrapped lines line up;
// reviewing lists its journals instead of linking one page
#[
  #set par(hanging-indent: 1.95em, spacing: 0.55em)
  #for item in cv.community {
    let label = if "journals" in item {
      [#item.name for #item.journals.map(journal => link(journal.href, journal.name)).join(", ")]
    } else { link(item.href, item.name) }
    par[#box(width: 1.95em, icon(item))#label · #item.date]
  }
]

#section[Languages, nationality and interests]
#cv.languages.map(lang => [#lang.name (#lang.level)]).join(", ").
#cv.nationality.map(nation => nation.title).join(" and ") citizen. \
#cv.hobbies.map(hobby => {
  let label = [#glyph(hobby.icon) #hobby.name]
  if "href" in hobby { link(hobby.href, label) } else { label }
}).join(h(1em))
