// Shared style for typeset lecture notes and exam solutions on janosh.dev/physics.
// Compile from the blog root: typst compile --root src/routes/physics <file>.typ

#let margin-x = 2.2cm

#let notes(title: none, subtitle: none, date: none, body) = {
  set document(title: title, author: "Janosh Riebesell")
  set page(paper: "a4", margin: (x: margin-x, y: 2.3cm), numbering: "1")
  set text(font: "New Computer Modern", size: 11pt, lang: "en")
  set par(justify: true, leading: 0.62em)
  set math.equation(numbering: none)
  show math.equation.where(block: true): set block(breakable: true)
  // pad fractions on both sides like TeX's \nulldelimiterspace (1.2pt), so neighbouring
  // factors don't touch the fraction bar
  show math.frac: it => h(1.2pt) + it + h(1.2pt)
  // Shrink display equations wider than the text column instead of letting them spill into
  // the margins. Measure an inline copy in display style so this rule doesn't recurse.
  show math.equation.where(block: true): it => context {
    let width = measure(math.equation(block: false, math.display(it.body))).width
    let column = page.width - 2 * margin-x
    if width <= column { it } else { scale(column / width * 100%, reflow: true, it) }
  }
  show heading.where(level: 1): set text(size: 13pt)
  show heading.where(level: 1): set block(above: 1.6em, below: 0.9em)

  align(center)[
    #text(size: 17pt, weight: "bold", title) \
    #if subtitle != none { v(2pt); text(size: 11.5pt, subtitle) } \
    #if date != none { v(1pt); text(size: 10pt, fill: luma(90), date) }
  ]
  v(0.6em)
  body
}

// An exam or exercise statement, set apart from the solution that follows it.
#let task(label: none, body) = block(
  width: 100%,
  inset: (x: 9pt, y: 7pt),
  radius: 3pt,
  fill: luma(238),
  above: 1.1em,
  below: 0.8em,
  [#if label != none [*#label)* ] #body],
)

// A display equation carrying the label the problem sheet uses, e.g. (1).
#let tagged(label, eq) = grid(
  columns: (1fr, auto),
  align: (center + horizon, right + horizon),
  eq, [(#label)],
)

// Normal ordering :X: with tight colons (a bare colon gets relation spacing in math).
#let nord(body) = $class("normal", :) body class("normal", :)$

// Integral measure d^n x (or d x after an integral sign): pull the variable towards d^n and leave
// the same distance before the integrand, so only the variable moves.
#let dd(..args) = {
  let (n, v) = if args.pos().len() == 2 { args.pos() } else { (none, args.pos().first()) }
  if n == none { $dif #v #h(1pt)$ } else { $dif^#n #h(-1pt) #v #h(1pt)$ }
}
