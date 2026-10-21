// Worldsheet topologies of the oriented open and closed string, shared by the string theory
// exam sheet and exam solution.
#import "@preview/cetz:0.5.2": canvas, draw

// Worldsheets of open and closed strings at tree level and one loop (top) and the compact
// surfaces they are conformally equivalent to (bottom), with in/out states at tau_1, tau_2.
#let lbl(pt, body, anchor: "center") = draw.content(pt, text(size: 6pt, body), anchor: anchor)
#let tau-arrow(a, b) = draw.line(a, b, mark: (end: "stealth", fill: black, scale: 0.4), stroke: 0.4pt)
#let dashed = (dash: "dashed", thickness: 0.4pt)
#let open-tree = {
  import draw: *
  bezier((0, 0), (3, -0.4), (1.5, 0.4), (1.5, -0.8))
  bezier((0, 0.8), (3, 0.4), (1.5, 1.2), (1.5, 0))
  line((0, 0), (0, 0.8), stroke: 0.4pt)
  line((3, -0.4), (3, 0.4), stroke: 0.4pt)
  line((1, 0.02), (1, 0.85), stroke: dashed)
  line((2, -0.25), (2, 0.55), stroke: dashed)
  lbl((1, 0), $tau_1$, anchor: "north")
  lbl((2, -0.3), $tau_2$, anchor: "north")
  tau-arrow((0.4, 1.15), (1.4, 1.15))
  lbl((0.9, 1.15), $tau$, anchor: "south")
  tau-arrow((-0.15, 0.1), (-0.15, 0.7))
  lbl((-0.15, 0.4), $sigma$, anchor: "east")
}
#let open-loop = {
  import draw: *
  bezier((0, 0), (3.6, 0), (1.2, -0.8), (2.4, -0.8))
  bezier((0, 1), (3.6, 1), (1.2, 1.8), (2.4, 1.8))
  line((0, 0), (0, 1), stroke: 0.4pt)
  line((3.6, 0), (3.6, 1), stroke: 0.4pt)
  circle((1.8, 0.5), radius: (0.5, 0.28))
  line((1.3, -0.48), (1.3, 1.48), stroke: dashed)
  line((2.3, -0.48), (2.3, 1.48), stroke: dashed)
  lbl((1.3, 1.5), $tau_1$, anchor: "south")
  lbl((2.3, 1.5), $tau_2$, anchor: "south")
  tau-arrow((0.3, 1.45), (1.1, 1.6))
}
#let closed-tree = {
  import draw: *
  bezier((0, 0), (3, -0.4), (1.5, 0.4), (1.5, -0.8))
  bezier((0, 0.8), (3, 0.4), (1.5, 1.2), (1.5, 0))
  circle((0, 0.4), radius: (0.12, 0.4))
  circle((3, 0), radius: (0.12, 0.4))
  circle((1, 0.45), radius: (0.1, 0.4), stroke: dashed)
  circle((2, 0.15), radius: (0.1, 0.4), stroke: dashed)
  lbl((1, 0.02), $tau_1$, anchor: "north")
  lbl((2, -0.28), $tau_2$, anchor: "north")
  tau-arrow((0.4, 1.15), (1.4, 1.15))
  lbl((0.9, 1.15), $tau$, anchor: "south")
}
#let closed-loop = {
  import draw: *
  bezier((0, 0), (3.6, 0), (1.2, -0.8), (2.4, -0.8))
  bezier((0, 1), (3.6, 1), (1.2, 1.8), (2.4, 1.8))
  circle((0, 0.5), radius: (0.12, 0.5))
  circle((3.6, 0.5), radius: (0.12, 0.5))
  circle((1.8, 0.5), radius: (0.5, 0.28))
  circle((1.3, 0.5), radius: (0.12, 0.98), stroke: dashed)
  circle((2.3, 0.5), radius: (0.12, 0.98), stroke: dashed)
  lbl((1.3, 1.5), $tau_1$, anchor: "south")
  lbl((2.3, 1.5), $tau_2$, anchor: "south")
  tau-arrow((0.3, 1.45), (1.1, 1.6))
}
#let disk = {
  import draw: *
  circle((0, 0), radius: 0.6)
  line((-0.55, 0.22), (0.55, 0.22), stroke: dashed)
  line((-0.55, -0.22), (0.55, -0.22), stroke: dashed)
  lbl((0.6, 0.25), $tau_2$, anchor: "west")
  lbl((0.6, -0.25), $tau_1$, anchor: "west")
}
#let cylinder = {
  import draw: *
  circle((0, 0.6), radius: (0.45, 0.13))
  arc((-0.45, -0.6), start: 180deg, stop: 360deg, radius: (0.45, 0.13))
  line((-0.45, -0.6), (-0.45, 0.6))
  line((0.45, -0.6), (0.45, 0.6))
  line((-0.15, -0.72), (-0.15, 0.48), stroke: dashed)
  line((0.15, -0.72), (0.15, 0.48), stroke: dashed)
  lbl((-0.15, -0.75), $tau_1$, anchor: "north")
  lbl((0.15, -0.75), $tau_2$, anchor: "north")
}
#let sphere = {
  import draw: *
  circle((0, 0), radius: 0.6)
  circle((0, 0.3), radius: (0.52, 0.1), stroke: dashed)
  circle((0, -0.3), radius: (0.52, 0.1), stroke: dashed)
  lbl((0, 0.6), $tau_1$, anchor: "south")
  lbl((0, -0.6), $tau_2$, anchor: "north")
}
#let torus = {
  import draw: *
  circle((0, 0), radius: (0.85, 0.5))
  arc((-0.35, 0.05), start: 200deg, stop: 340deg, radius: (0.37, 0.15))
  arc((-0.25, -0.03), start: 160deg, stop: 20deg, radius: (0.27, 0.1))
  circle((-0.35, -0.25), radius: (0.08, 0.25), stroke: dashed)
  circle((0.35, -0.25), radius: (0.08, 0.25), stroke: dashed)
  lbl((-0.35, -0.5), $tau_1$, anchor: "north")
  lbl((0.35, -0.5), $tau_2$, anchor: "north")
}
#let equals-down = text(size: 7pt)[$||$]
#let ws-topologies(length: 0.42cm) = {
  let panel(top1, top2, bot1, bot2) = grid(
    columns: (auto, auto, auto),
    align: center + horizon,
    column-gutter: 2pt,
    row-gutter: 3pt,
    canvas(length: length, top1), text(size: 7pt)[$+$], canvas(length: length, top2),
    equals-down, [], equals-down,
    canvas(length: length, bot1), [], canvas(length: length, bot2),
  )
  grid(
    columns: (1fr, 1fr),
    column-gutter: 4pt,
    stroke: (x, y) => if x == 0 { (right: 0.5pt) },
    inset: (x: 3pt),
    text(size: 8pt, weight: "bold")[Open string],
    text(size: 8pt, weight: "bold")[Closed string],
    panel(open-tree, open-loop, disk, cylinder), panel(closed-tree, closed-loop, sphere, torus),
  )
}

