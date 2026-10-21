// Table showing which of the 26 spacetime dimensions each D-brane stack fills, shaded darker
// for higher-dimensional branes, with the number of branes in the stack in each filled cell.
// Shared by the string theory exam solution and solution 5.

// stacks: array of (name, count, dims) with dims the filled dimensions
#let brane-table(..stacks) = {
  set text(size: 6.5pt)
  let shades = (luma(110), luma(150), luma(200))
  let cells(count, dims, fill) = range(26).map(d => table.cell(
    fill: if d in dims { fill } else { none },
    text(fill: if d in dims and fill != shades.last() { white } else { black }, if d in dims [#count] else []),
  ))
  align(center, table(
    columns: (auto,) + (1fr,) * 26,
    stroke: none,
    inset: (x: 1pt, y: 2pt),
    align: center,
    table.hline(stroke: 0.6pt),
    [$d$], ..range(26).map(d => [#d]),
    table.hline(stroke: 0.4pt),
    ..stacks.pos().enumerate().map(((i, (name, count, dims))) => ([#name], ..cells(count, dims, shades.at(i)))).flatten(),
    table.hline(stroke: 0.6pt),
  ))
}
