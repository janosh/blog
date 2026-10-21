// Title block and figure helpers shared by the atomic physics exercise solutions (in German).
#import "/notes.typ": notes

// a figure cropped from the original PDF solutions into ../figures (PDF unless the name
// carries its own extension, e.g. for photos)
#let fig(name, width: 100%) = {
  let file = if name.contains(".") { name } else { name + ".pdf" }
  image("/atomic-physics/figures/" + file, width: width)
}

// points for an exercise, set flush right in its heading: = Stern-Gerlach-Experiment #pts(4)
#let pts(n) = [#h(1fr) #text(weight: "regular", size: 0.85em)[(#n Punkte)]]

#let (up, dn) = (sym.arrow.t, sym.arrow.b)

// unnumbered section heading that restarts the exercise numbering after it, e.g. Präsenzaufgaben
#let part(title) = {
  heading(numbering: none, title)
  counter(heading).update(0)
}

// a display equation left out of the equation numbering
#let nonum(body) = math.equation(block: true, numbering: none, body)

// e.g. #show: sheet.with([Übungsblatt 1], [15. April 2014])
#let sheet(subtitle, date, authors: [Alex Ilin, Kristina Klafka, Janosh Riebesell], body) = {
  show: notes.with(
    title: [Atom-, Molekül- und Laserphysik],
    subtitle: [#subtitle #sym.dash.em Physik VI, Universität Hamburg, Sommersemester 2014],
    date: [#authors #sym.dot.c #date],
  )
  set text(lang: "de")
  set heading(numbering: "1")
  set math.equation(numbering: "(1)")
  set enum(numbering: "a)")
  body
}
