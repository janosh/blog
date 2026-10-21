// Worldsheet topologies of the oriented open and closed string, shared by the string theory
// exam sheet and exam solution.
#import "@preview/cetz:0.5.2": canvas, draw

// Worldsheets of open and closed strings at tree level and one loop (top) and the compact
// surfaces they are conformally equivalent to (bottom), with in/out states at tau_1, tau_2.
// tau runs along the worldsheet, sigma along the string.
#let dashed = (dash: (1.3pt, 1pt), thickness: 0.35pt)
#let thin = 0.35pt
#let head = (symbol: "straight", scale: 0.3)
#let tip = (end: head)
#let tips = (start: head, end: head)

// height of the S-shaped tree-level strip (length 3, drop 0.8) above its right end
#let strip-top(x) = 0.8 * calc.pow(1 - x / 3, 2) * (1 + 2 * x / 3)
// upper boundary of the one-loop worldsheet (length 5), bulging from 0.3 to 1 around the hole
#let bulge(x) = {
  let frac = calc.min(x, 5 - x) / 2.5
  0.3 + 0.7 * (3 * frac * frac - 2 * frac * frac * frac)
}
#let hole = (0.62, 0.3)
// upper edge of the hole of the one-loop worldsheet, centred on (2.5, 0)
#let hole-top(x) = hole.at(1) * calc.sqrt(1 - calc.pow((x - 2.5) / hole.at(0), 2))
#let (cut-1, cut-2) = (2.14, 2.86)
// points of f sampled over [start, stop] and lifted by offset, for arrows that follow a boundary
#let along(f, start, stop, offset) = range(13).map(idx => {
  let x = start + (stop - start) * idx / 12
  (x, f(x) + offset)
})

#let shapes(size) = {
  import draw: *
  let lbl(pt, body, anchor: "center") = content(pt, text(size: size, body), anchor: anchor, padding: 1.2pt)
  let tree-outline = {
    bezier((0, 0.8), (3, 0), (1, 0.8), (2, 0))
    bezier((0, 0), (3, -0.8), (1, 0), (2, -0.8))
    lbl((1, strip-top(1) - 0.8), $tau_1$, anchor: "north")
    lbl((2, strip-top(2) - 0.8), $tau_2$, anchor: "north")
    line(..along(strip-top, 0.1, 1.5, 0.2), mark: tip, stroke: thin)
    lbl((0.7, strip-top(0.7) + 0.22), $tau$, anchor: "south")
  }
  let loop-outline = {
    bezier((0, 0.3), (2.5, 1), (2.5 / 3, 0.3), (5 / 3, 1))
    bezier((2.5, 1), (5, 0.3), (10 / 3, 1), (12.5 / 3, 0.3))
    bezier((0, -0.3), (2.5, -1), (2.5 / 3, -0.3), (5 / 3, -1))
    bezier((2.5, -1), (5, -0.3), (10 / 3, -1), (12.5 / 3, -0.3))
    circle((2.5, 0), radius: hole)
    lbl((cut-1 - 0.08, bulge(cut-1)), $tau_1$, anchor: "south")
    lbl((cut-2 + 0.08, bulge(cut-2)), $tau_2$, anchor: "south")
    line(..along(bulge, 0.1, 1.3, 0.18), mark: tip, stroke: thin)
    lbl((0.6, bulge(0.6) + 0.2), $tau$, anchor: "south")
  }
  let open-tree = {
    tree-outline
    line((0, 0), (0, 0.8))
    line((3, -0.8), (3, 0))
    for x in (1, 2) { line((x, strip-top(x) - 0.8), (x, strip-top(x)), stroke: dashed) }
    line((-0.18, 0), (-0.18, 0.8), mark: tip, stroke: thin)
    lbl((-0.18, 0), $sigma$, anchor: "north")
  }
  let open-loop = {
    loop-outline
    line((0, -0.3), (0, 0.3))
    line((5, -0.3), (5, 0.3))
    for x in (cut-1, cut-2) {
      line((x, hole-top(x)), (x, bulge(x)), stroke: dashed)
      line((x, -hole-top(x)), (x, -bulge(x)), stroke: dashed)
    }
    line((-0.18, -0.3), (-0.18, 0.3), mark: tip, stroke: thin)
    lbl((-0.18, -0.3), $sigma$, anchor: "north")
  }
  let closed-tree = {
    tree-outline
    arc((0, 0.4), start: 90deg, stop: 270deg, radius: (0.14, 0.4), anchor: "origin")
    circle((3, -0.4), radius: (0.22, 0.4))
    for x in (1, 2) {
      arc((x, strip-top(x) - 0.4), start: -90deg, stop: 90deg, radius: (0.13, 0.4), anchor: "origin", stroke: dashed)
    }
    arc((0, 0.4), start: 235deg, stop: 125deg, radius: (0.32, 0.52), anchor: "origin", mark: tip, stroke: thin)
    lbl((-0.2, -0.05), $sigma$, anchor: "north")
  }
  let closed-loop = {
    loop-outline
    arc((0, 0), start: 90deg, stop: 270deg, radius: (0.12, 0.3), anchor: "origin")
    circle((5, 0), radius: (0.2, 0.3))
    for (x, bend) in ((cut-1, 0.1), (cut-2, -0.1)) {
      let (inner, outer) = (hole-top(x), bulge(x))
      bezier((x, inner), (x, outer), (x + bend, (inner + outer) / 2), stroke: dashed)
      bezier((x, -inner), (x, -outer), (x - bend, -(inner + outer) / 2), stroke: dashed)
    }
    arc((0, 0), start: 235deg, stop: 125deg, radius: (0.3, 0.42), anchor: "origin", mark: tip, stroke: thin)
    lbl((-0.2, -0.36), $sigma$, anchor: "north")
  }
  let disk = {
    circle((0, 0), radius: 0.8)
    for (y, name) in ((0.3, $tau_2$), (-0.3, $tau_1$)) {
      let half = calc.sqrt(0.64 - y * y)
      line((-half, y), (half, y), stroke: dashed)
      lbl((half + 0.05, y), name, anchor: "west")
    }
    line((-0.4, -0.14), (0.4, -0.14), mark: tip, stroke: thin)
    lbl((0, -0.14), $sigma$, anchor: "south")
    arc((0, 0), start: 145deg, stop: 215deg, radius: 0.95, anchor: "origin", mark: tips, stroke: thin)
    lbl((-0.95, 0), $tau$, anchor: "east")
  }
  let cylinder = {
    let (radius, depth, cut) = (0.65, 0.17, 0.38)
    let edge = depth * calc.sqrt(1 - calc.pow(cut / radius, 2))
    circle((0, 0.7), radius: (radius, depth))
    arc((0, -0.7), start: 180deg, stop: 360deg, radius: (radius, depth), anchor: "origin")
    for x in (-radius, radius) { line((x, -0.7), (x, 0.7)) }
    for (x, name) in ((-cut, $tau_1$), (cut, $tau_2$)) {
      line((x, -0.7 - edge), (x, 0.7 - edge), stroke: dashed)
      lbl((x, -0.7 - edge), name, anchor: "north")
    }
    bezier((-0.45, 1.05), (0.45, 1.05), (0, 1.22), mark: tips, stroke: thin)
    lbl((-0.5, 1.08), $tau$, anchor: "east")
    line((0.95, -0.7), (0.95, 0.7), mark: tip, stroke: thin)
    lbl((0.98, 0), $sigma$, anchor: "west")
  }
  let sphere = {
    circle((0, 0), radius: 0.8)
    bezier((-0.1, 0.79), (-0.1, -0.79), (-0.36, 0), stroke: dashed)
    bezier((0.42, 0.68), (0.3, -0.74), (0.72, -0.05), stroke: dashed)
    lbl((0.46, 0.7), $tau_1$, anchor: "south-west")
    lbl((0.1, -0.8), $tau_2$, anchor: "north")
    arc((0, 0), start: 205deg, stop: 160deg, radius: 0.5, anchor: "origin", mark: tip, stroke: thin)
    lbl((-0.5, 0), $sigma$, anchor: "east")
    arc((0, 0), start: 145deg, stop: 215deg, radius: 0.95, anchor: "origin", mark: tips, stroke: thin)
    lbl((-0.95, 0), $tau$, anchor: "east")
  }
  let torus = {
    let (outer, inner, cut) = ((1.1, 0.7), (0.5, 0.24), 0.3)
    let rim = outer.at(1) * calc.sqrt(1 - calc.pow(cut / outer.at(0), 2))
    let lip = inner.at(1) * calc.sqrt(1 - calc.pow(cut / inner.at(0), 2))
    circle((0, 0), radius: outer)
    circle((0, 0), radius: inner)
    for (x, bend, name) in ((-cut, 0.08, $tau_1$), (cut, -0.08, $tau_2$)) {
      bezier((x, lip), (x, rim), (x + bend, (lip + rim) / 2), stroke: dashed)
      bezier((x, -lip), (x, -rim), (x - bend, -(lip + rim) / 2), stroke: dashed)
      lbl((x, -rim), name, anchor: "north")
    }
    arc((0, 0), start: 165deg, stop: 95deg, radius: (1.28, 0.88), anchor: "origin", mark: tip, stroke: thin)
    lbl((-1.2, 0.5), $tau$, anchor: "east")
    bezier((-1, 0.02), (-0.56, 0.02), (-0.78, 0.26), mark: tip, stroke: thin)
    lbl((-0.8, -0.02), $sigma$, anchor: "north")
  }
  (open-tree, open-loop, disk, cylinder, closed-tree, closed-loop, sphere, torus)
}

// length sets the scale of the drawings, size that of their labels
#let ws-topologies(length: 0.36cm, size: 5pt) = {
  // the compact surfaces are drawn larger than the worldsheets so their labels fit inside
  let draw-shape(shape, zoom: 1) = canvas(length: zoom * length, {
    draw.set-style(stroke: 0.5pt)
    shape
  })
  let (open-tree, open-loop, disk, cylinder, closed-tree, closed-loop, sphere, torus) = shapes(size)
  let (open-tree, open-loop, closed-tree, closed-loop) = (open-tree, open-loop, closed-tree, closed-loop).map(draw-shape)
  let (disk, cylinder, sphere, torus) = (disk, cylinder, sphere, torus).map(draw-shape.with(zoom: 1.5))
  // vertical equals sign linking a worldsheet to the surface it is equivalent to
  let equals-down = box(inset: (y: 2pt), stack(dir: ltr, spacing: 0.22 * length, ..(line(angle: 90deg, length: 0.7 * length, stroke: 0.5pt),) * 2))
  let panel(tree, loop, bottom-tree, bottom-loop) = grid(
    columns: (auto, auto, auto),
    align: center + horizon,
    column-gutter: 0.3 * length,
    row-gutter: 0.2 * length,
    tree, text(size: size + 2pt)[$+$], loop,
    equals-down, [], equals-down,
    bottom-tree, [], bottom-loop,
  )
  set block(breakable: false)
  grid(
    columns: (1fr, 1fr),
    align: center,
    stroke: (x, y) => if x == 0 { (right: 0.5pt) },
    inset: (x: 2pt, y: 2pt),
    grid.cell(align: left, text(size: size + 3pt, weight: "bold")[Open string]),
    grid.cell(align: left, text(size: size + 3pt, weight: "bold")[Closed string]),
    panel(open-tree, open-loop, disk, cylinder), panel(closed-tree, closed-loop, sphere, torus),
  )
}
