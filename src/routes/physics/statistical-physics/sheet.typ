// Helpers and figures shared by the statistical physics notes.
#import "/notes.typ": notes
#import "@preview/cetz:0.5.2": canvas
#import "@preview/cetz-plot:0.1.4": plot

// title block of an exercise sheet solution, e.g. #show: sheet.with(2, [November 11th, 2016])
#let sheet(n, date, body) = {
  show: notes.with(
    title: [Theoretical Statistical Physics],
    subtitle: [Solution to Exercise Sheet #n],
    date: [Janosh Riebesell, Adrian van Kan #sym.dot.c Lecturer: Manfred Salmhofer #sym.dot.c #date],
  )
  set heading(numbering: "1")
  set math.equation(numbering: "(1)")
  set enum(numbering: "a)")
  body
}

#let (cE, cF, cH, cP, cS) = ($cal(E)$, $cal(F)$, $cal(H)$, $cal(P)$, $cal(S)$)
#let (hH, hN) = ($hat(H)$, $hat(N)$)
// Fock state |{n_i}_i^s> with occupation numbers n_i, s = + for bosons, - for fermions
#let ni(s) = $lr(|{n_i}_i^#s chevron.r)$

// right-aligned point count after an exercise heading, e.g. "(3 points)"
#let points(n) = h(1fr) + text(size: 9pt, weight: "regular")[(#n points)]

// Bose-Einstein, Maxwell-Boltzmann and Fermi-Dirac occupation numbers vs beta (eps - mu)
#let distributions(size: (7, 3.2)) = canvas(plot.plot(
  size: size,
  x-label: $beta (epsilon.alt - mu)$,
  y-label: $lr(chevron.l n chevron.r)$,
  x-tick-step: 2,
  y-tick-step: 0.5,
  axis-style: "school-book",
  legend: "inner-north-east",
  y-min: 0,
  y-max: 1.75,
  x-min: -7,
  x-max: 7,
  {
    plot.add(x => 1 / (calc.exp(x) - 1), domain: (0.45, 7), samples: 200, style: (stroke: blue + 0.8pt), label: text(size: 7pt)[Bose-Einstein])
    plot.add(x => calc.exp(-x), domain: (-0.56, 7), samples: 200, style: (stroke: rgb("#ff8000") + 0.8pt), label: text(size: 7pt)[Boltzmann])
    plot.add(x => 1 / (calc.exp(x) + 1), domain: (-7, 7), samples: 200, style: (stroke: red + 0.8pt), label: text(size: 7pt)[Fermi-Dirac])
  },
))
