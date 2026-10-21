// Cover for this post: typst compile compiling-vasp-m1-mac.typ compiling-vasp-m1-mac.svg
// Content stays within the central ~800pt so the posts list's card crop keeps it whole.
#set page(width: 2000pt, height: 500pt, margin: 0pt, fill: rgb("#05070d"))
// faint crystal lattice (offset rows) across the full width
#let dot = circle(radius: 3pt, fill: rgb(90, 120, 200, 70))
#place(rect(width: 100%, height: 100%, fill: tiling(size: (50pt, 100pt))[
  #place(dx: -3pt, dy: -3pt, dot)
  #place(dx: 22pt, dy: 47pt, dot)
]))
#let rainbow = gradient.linear(..color.map.plasma, angle: 45deg)
// chip with a glowing rainbow edge, right of center
#let (chip-x, chip-y, size) = (1075pt, 120pt, 260pt)
#for (pad, alpha) in ((36pt, 6%), (24pt, 12%), (12pt, 25%)) {
  place(dx: chip-x - pad, dy: chip-y - pad, rect(
    width: size + 2 * pad, height: size + 2 * pad, radius: 40pt + pad,
    fill: gradient.linear(..color.map.plasma.map(c => c.transparentize(100% - alpha)), angle: 45deg),
  ))
}
#place(dx: chip-x - 6pt, dy: chip-y - 6pt, rect(width: size + 12pt, height: size + 12pt, radius: 44pt, fill: rainbow))
#place(dx: chip-x, dy: chip-y, rect(
  width: size, height: size, radius: 38pt,
  fill: gradient.linear(rgb("#2b2f38"), rgb("#0d0f14"), angle: 90deg),
))
#place(dx: chip-x, dy: chip-y, box(width: size, height: size, align(center + horizon,
  text(font: "Helvetica Neue", weight: "medium", size: 104pt, fill: rgb("#e8e8ec"), [M1]),
)))
// VASP wordmark left of the chip, inside the central region the post cards crop to
#place(dx: 600pt, dy: 0pt, box(width: 440pt, height: 500pt, align(right + horizon,
  text(font: "Helvetica Neue", weight: "bold", size: 150pt, fill: white, tracking: 4pt, [VASP]),
)))
