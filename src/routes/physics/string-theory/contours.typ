// Deforming the difference of two z-contours around the origin (with w inside) into a single
// contour around w. Shared by string theory solutions 7 and 8.
#import "/string-theory/sheet.typ": arrow-mark, lbl
#import "@preview/cetz:0.5.2": canvas, draw


#let contour-deformation = canvas(length: 0.62cm, {
  import draw: *
  set-style(stroke: 0.6pt)
  // radius of the contour around w
  let small = 0.6
  let disk(c, notch: none, bulge: none) = {
    let w = (c.at(0) + 1.2, c.at(1) + 0.85)
    if bulge != none {
      circle(w, radius: small, fill: luma(225), stroke: 0.6pt)
      circle(c, radius: 1.6, fill: luma(225), stroke: 0.6pt)
      circle(w, radius: small - 0.01, fill: luma(225), stroke: none)
      arc(w, start: 45deg, stop: 120deg, radius: small, anchor: "origin", mark: arrow-mark, stroke: 0.6pt)
    } else if notch != none {
      // cut a notch around w out of the disk: only the part of the small circle inside the big
      // one belongs to the contour. It spans the angle `half` either side of the direction to c
      let (dx, dy) = (c.at(0) - w.at(0), c.at(1) - w.at(1))
      let dist = calc.sqrt(dx * dx + dy * dy)
      let half = calc.acos((dist * dist + small * small - 1.6 * 1.6) / (2 * dist * small))
      let towards = calc.atan2(dx, dy)
      circle(c, radius: 1.6, fill: luma(225))
      circle(w, radius: small, fill: white, stroke: none)
      arc(w, start: towards - half, stop: towards + half, radius: small, anchor: "origin")
      arc(w, start: towards - half, stop: towards - 10deg, radius: small, anchor: "origin", mark: arrow-mark)
    } else {
      circle(c, radius: 1.6, fill: luma(225))
      arc(c, start: 42deg, stop: 62deg, radius: 1.6, anchor: "origin", mark: arrow-mark, stroke: 0.6pt)
    }
    circle(c, radius: 0.06, fill: black)
    lbl(c, [0], anchor: "south-west")
    circle(w, radius: 0.06, fill: black)
    // beside a plain disk's rim the label only fits on the inner side of w
    lbl(w, $w$, anchor: if bulge == none and notch == none { "east" } else { "west" }, padding: 3pt)
  }
  // z-contours of the two original integrals, drawn as small arcs above the disks
  for x in (0, 4.6) {
    disk((x, 0))
    bezier((x - 0.72, 2.12), (x - 1.12, 1.42), (x - 1.25, 2.1), mark: arrow-mark, stroke: 0.5pt)
    content((x - 0.68, 2.12), text(size: 6.5pt)[$z$-contour], anchor: "west")
  }
  lbl((2.3, 0), $-$)
  lbl((6.85, 0), $->$)
  disk((9.3, 0), bulge: true)
  lbl((11.55, 0), $-$)
  disk((13.8, 0), notch: true)
  lbl((16.1, 0), $=$)
  circle((17.3, 0), radius: 0.06, fill: black)
  lbl((17.3, 0), [0], anchor: "south-west")
  circle((18.45, 0.85), radius: small, fill: luma(225))
  circle((18.45, 0.85), radius: 0.06, fill: black)
  lbl((18.45, 0.85), $w$, anchor: "west", padding: 3pt)
  arc((18.45, 0.85), start: 45deg, stop: 120deg, radius: small, anchor: "origin", mark: arrow-mark)
})
