// Deforming the difference of two z-contours around the origin (with w inside) into a single
// contour around w. Shared by string theory solutions 7 and 8.
#import "/string-theory/sheet.typ": arrow-mark, lbl
#import "@preview/cetz:0.5.2": canvas, draw

#let contour-deformation = canvas(length: 0.62cm, {
  import draw: *
  set-style(stroke: 0.6pt)
  let disk(c, notch: none, bulge: none) = {
    let w = (c.at(0) + 1.2, c.at(1) + 0.85)
    if bulge != none {
      circle(w, radius: 0.48, fill: luma(225), stroke: 0.6pt)
      circle(c, radius: 1.6, fill: luma(225), stroke: 0.6pt)
      circle(w, radius: 0.47, fill: luma(225), stroke: none)
      arc((w.at(0) + 0.33, w.at(1) + 0.33), start: 45deg, stop: 120deg, radius: 0.47, mark: arrow-mark, stroke: 0.6pt)
    } else if notch != none {
      circle(c, radius: 1.6, fill: luma(225))
      circle(w, radius: 0.48, fill: white, stroke: 0.6pt)
      arc((w.at(0) - 0.33, w.at(1) - 0.33), start: 225deg, stop: 150deg, radius: 0.47, mark: arrow-mark, stroke: 0.6pt)
    } else {
      circle(c, radius: 1.6, fill: luma(225))
      arc((c.at(0) + 1.35, c.at(1) + 0.86), start: 32deg, stop: 50deg, radius: 1.6, mark: arrow-mark, stroke: 0.6pt)
    }
    circle(c, radius: 0.06, fill: black)
    lbl(c, [0], anchor: "south-west")
    circle(w, radius: 0.06, fill: black)
    lbl(w, $w$, anchor: "west")
  }
  // z-contours of the two original integrals, drawn as small arcs above the disks
  for x in (0, 4.6) {
    disk((x, 0))
    arc((x - 0.9, 1.6), start: 200deg, stop: 120deg, radius: 0.4, mark: arrow-mark, stroke: 0.5pt)
    content((x - 0.2, 2.15), text(size: 6.5pt)[$z$-contour])
  }
  lbl((2.3, 0), $-$)
  lbl((6.85, 0), $->$)
  disk((9.3, 0), bulge: true)
  lbl((11.55, 0), $-$)
  disk((13.8, 0), notch: true)
  lbl((16.1, 0), $=$)
  circle((17.3, 0), radius: 0.06, fill: black)
  lbl((17.3, 0), [0], anchor: "south-west")
  circle((18.45, 0.85), radius: 0.48, fill: luma(225))
  circle((18.45, 0.85), radius: 0.06, fill: black)
  lbl((18.45, 0.85), $w$, anchor: "west")
  arc((18.78, 1.18), start: 45deg, stop: 120deg, radius: 0.47, mark: arrow-mark)
})
