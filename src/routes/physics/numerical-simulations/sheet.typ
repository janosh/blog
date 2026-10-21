// Title block and figure helpers shared by the numerical simulations exercise solutions.
#import "/notes.typ": notes

// a simulation plot cropped from the original PDF solutions into ../figures (PDF unless the
// name carries its own extension, e.g. for photos)
#let fig(name, width: 100%) = {
  let file = if name.contains(".") { name } else { name + ".pdf" }
  image("/numerical-simulations/figures/" + file, width: width)
}

// a row-major grid of subfigures, each a (name, caption) pair, labelled (a), (b), ...
#let panels(columns, items) = grid(
  columns: (1fr,) * columns,
  column-gutter: 1em,
  row-gutter: 0.8em,
  ..items.enumerate().map(((i, (name, caption))) => {
    align(center, stack(spacing: 0.4em, fig(name), text(size: 9pt)[(#numbering("a", i + 1)) #caption]))
  }),
)

// booktabs-style table: rules at the top, below the header and at the bottom
#let booktable(..args, header: (), body: ()) = table(
  stroke: none,
  inset: (x: 6pt, y: 2.5pt),
  ..args,
  table.hline(stroke: 0.8pt),
  table.header(..header),
  table.hline(stroke: 0.5pt),
  ..body,
  table.hline(stroke: 0.8pt),
)

#let cO = $cal(O)$

// e.g. #show: sheet.with(1, [October 23rd, 2015], [Issues of floating point arithmetic])
#let sheet(n, date, topic, body) = {
  show: notes.with(
    title: [Fundamentals of Simulation Methods],
    subtitle: [Exercise Sheet #n #sym.dash.em #topic],
    date: [Daniel Rosenblüh, Janosh Riebesell #sym.dot.c Lecturer: Volker Springel #sym.dot.c #date],
  )
  set heading(numbering: "1")
  set math.equation(numbering: "(1)")
  set enum(numbering: "(a)")
  body
}
