// Shared style for typeset lecture notes and exam solutions on janosh.dev/physics.
// Compile from the blog root: typst compile --root src/routes/physics <file>.typ

// === Delimiter sizing ===
// Annotated braces whose annotation should not count towards the height of enclosing delimiters.
#let braces = (math.underbrace, math.overbrace, math.underbracket, math.overbracket, math.underparen, math.overparen)
// Copy of math content with every annotated brace replaced by its body, and whether there was one.
#let strip-braces(it) = {
  if type(it) != content { return (it, false) }
  let func = it.func()
  if func in braces { return (strip-braces(it.body).first(), true) }
  if func == math.equation { return strip-braces(it.body) }
  if it.has("children") {
    let parts = it.children.map(strip-braces)
    return (parts.map(part => part.first()).join(), parts.any(part => part.last()))
  }
  if func == math.frac {
    let (num, denom) = (strip-braces(it.num), strip-braces(it.denom))
    return (math.frac(num.first(), denom.first()), num.last() or denom.last())
  }
  if func == math.attach {
    let fields = it.fields()
    let (base, found) = strip-braces(fields.remove("base"))
    return (math.attach(base, ..fields), found)
  }
  if func == math.lr {
    let (body, found) = strip-braces(it.body)
    return (math.lr(body, size: it.at("size", default: 100%)), found)
  }
  if func in (math.limits, math.scripts, math.cancel, math.display, math.inline) {
    let (body, found) = strip-braces(it.body)
    return (func(body), found)
  }
  if it.has("child") and it.has("styles") {
    let (child, found) = strip-braces(it.child)
    return (func(child, it.styles), found)
  }
  (it, false)
}
// Height of the delimiters around body in a display equation. A body broken over several lines
// gets delimiters as tall as its tallest line, not as tall as all lines together.
#let delimiter-height(body) = {
  let lines = if body.has("children") { body.children.split(linebreak()).map(line => line.join()) } else { (body,) }
  calc.max(..lines.filter(line => line != none).map(line => measure(math.equation(block: true, math.lr(line))).height))
}

#let notes(title: none, subtitle: none, date: none, body) = {
  set document(title: title, author: "Janosh Riebesell")
  set page(paper: "a4", margin: (x: 2.2cm, y: 2.3cm), numbering: "1")
  set text(font: "New Computer Modern", size: 11pt, lang: "en")
  set par(justify: true, leading: 0.62em)
  set math.equation(numbering: none)
  show math.equation.where(block: true): set block(breakable: true)
  // pad fractions on both sides like TeX's \nulldelimiterspace (1.2pt), so neighbouring
  // factors don't touch the fraction bar. The class keeps the padded fraction an ordinary atom,
  // else neighbouring operators lose their spacing (a = b/c + d rendered as a =b/c+d).
  show math.frac: it => math.class("normal", h(1.2pt) + it + h(1.2pt))
  // Size parentheses and brackets by the expression they enclose, not by the annotations of
  // under- and overbraces inside it or by the line breaks it spans, which otherwise blow them up.
  show math.lr: it => {
    if it.size != 100% { return it }
    let (bare, found) = strip-braces(it.body)
    let multiline = it.body.has("children") and linebreak() in it.body.children
    if not found and not multiline { return it }
    context math.lr(size: delimiter-height(bare), it.body)
  }
  // Scripts on such delimiters are attached to the closing one, else they sit at the height of
  // the annotations.
  show math.attach: it => {
    let base = it.base
    if base.func() != math.lr or base.at("size", default: 100%) != 100% or not base.body.has("children") { return it }
    let (bare, found) = strip-braces(base.body)
    if not found { return it }
    let fields = it.fields()
    let _ = fields.remove("base")
    let parts = base.body.children
    context {
      let height = delimiter-height(bare)
      math.lr(size: height, parts.slice(0, -1).join())
      math.attach(math.stretch(parts.last(), size: height), ..fields)
    }
  }
  // Shrink display equations wider than the text column instead of letting them spill into
  // the margins. Measure an inline copy in display style so this rule doesn't recurse. A
  // numbered equation is centred between two gutters as wide as its number, so it keeps clear of it.
  show math.equation.where(block: true): it => layout(region => {
    let width = measure(math.equation(block: false, math.display(it.body))).width
    let number = if it.numbering == none { 0pt } else { 5em.to-absolute() }
    let column = region.width - number
    if width <= column { it } else { scale(column / width * 100%, reflow: true, it) }
  })
  // cite equations by their number in parentheses, e.g. (3), like LaTeX's \eqref
  show ref: it => {
    let el = it.element
    if el == none or el.func() != math.equation { return it }
    link(el.location(), numbering(el.numbering, ..counter(math.equation).at(el.location())))
  }
  // code listings on a light background between two rules, like LaTeX's lstlisting
  show raw.where(block: true): set text(size: 8.5pt)
  show raw.where(block: true): it => block(
    width: 100%,
    fill: luma(248),
    inset: (x: 6pt, y: 5pt),
    stroke: (top: 0.6pt, bottom: 0.6pt),
    it,
  )
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

// A remark set off from the solution by a shaded box with a rule on its left.
#let note(label: [Note:], body) = block(
  width: 100%,
  inset: (left: 9pt, rest: 7pt),
  fill: luma(243),
  stroke: (left: 1pt + luma(40)),
  above: 1em,
  below: 1em,
  [*#label* #body],
)

// A display equation carrying the label the problem sheet uses, e.g. (1).
#let tagged(label, eq) = grid(
  columns: (1fr, auto),
  align: (center + horizon, right + horizon),
  eq, [(#label)],
)

// Display-style math inside running text (LaTeX's \displaystyle in $...$), padded vertically since
// Typst doesn't open up the line spacing around tall inline content the way TeX does.
#let dm(eq) = box(inset: (y: 0.3em), math.equation(math.display(eq.body)))

// Normal ordering :X: with tight colons (a bare colon gets relation spacing in math).
#let nord(body) = $class("normal", :) body class("normal", :)$

// Integral measure d^n x (or d x after an integral sign): pull the variable towards d^n and leave
// the same distance before the integrand, so only the variable moves.
#let dd(..args) = {
  let (n, v) = if args.pos().len() == 2 { args.pos() } else { (none, args.pos().first()) }
  if n == none { $dif #v #h(1pt)$ } else { $dif^#n #h(-1pt) #v #h(1pt)$ }
}

// === Math shorthands ===
#let vb(x) = math.bold(x)
#let eps = $epsilon.alt$
#let kB = $k_upright(B)$
#let tr = math.op("tr")
#let one = $bb(1)$
#let unit(u) = $thin upright(#u)$
#let ev(x) = $lr(chevron.l #x chevron.r)$
#let bra(x) = $lr(chevron.l #x|)$
#let ket(x) = $lr(|#x chevron.r)$
// inner product or matrix element: braket(a, b) = ⟨a|b⟩, braket(a, op, b) = ⟨a|op|b⟩
#let braket(..parts) = $lr(chevron.l #parts.pos().join($|$) chevron.r)$
// partial derivative at fixed variables, e.g. pd(S, T, V) = (∂S/∂T)|_V
#let pd(f, x, held) = $lr((partial #f)/(partial #x) |)_#held$
// small equation reference for annotating relations, e.g. "=" by eq. (3): eqby("eq:euler")
#let tag(eq-label) = text(size: 7pt, ref(label(eq-label)))
#let eqby(eq-label) = $limits(=)^#tag(eq-label)$

// Two-column exam cheat sheet in small type. Use as #show: cheatsheet after #show: notes.with(..).
#let cheatsheet(body) = {
  set text(size: 8.6pt)
  set par(leading: 0.5em, spacing: 0.7em)
  set list(spacing: 0.45em, indent: 0.2em, body-indent: 0.4em)
  set enum(spacing: 0.45em)
  set heading(numbering: "1")
  show heading.where(level: 1): set text(size: 11pt)
  show heading.where(level: 1): set block(above: 1.1em, below: 0.6em)
  columns(2, gutter: 1.4em, body)
}
