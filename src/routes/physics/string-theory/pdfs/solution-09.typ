#import "/notes.typ": note, task, vb, ev, tag, eqby
#import "/string-theory/sheet.typ": NO, cR, zb, wb, arrow-mark, lbl, sheet, SP
#import "/string-theory/plane-to-torus.typ": plane-to-torus
#import "@preview/cetz:0.5.2": canvas, draw

#show: sheet.with(9, [December 8th, 2015], [December 16th, 2015])

#let db = $macron(partial)$
#let (bk, bX, bu, bv, bh, bM) = ($vb(k)$, $vb(X)$, $vb(u)$, $vb(v)$, $vb(h)$, $vb(M)$)
#let S2 = $bb(S)^2$
#let D2 = $bb(D)^2$
#let Vol = $"Vol"_("Diff" times "Weyl")$
#let hateq = $hat(=)$
#let propby(l) = $limits(prop)^#tag(l)$

#let gray-dot(pt) = draw.circle(pt, radius: 0.07, fill: luma(130), stroke: none)

// The map S(w) = (w + i)/(i w + 1) from the unit disk to the upper half plane, sending the
// boundary circle to the real line and the marked points w_k to z_k.
#let disk-to-half-plane = canvas(length: 0.85cm, {
  import draw: *
  set-style(stroke: 0.6pt)
  let (blue, red) = (rgb("#1a1aa6"), rgb("#a01a1a"))
  circle((0, 0), radius: 1.3, fill: luma(240), stroke: none)
  line((-2.6, 0), (2.6, 0), mark: (start: "stealth", end: "stealth", fill: black, scale: 0.6))
  line((0, -2.6), (0, 2.6), mark: (start: "stealth", end: "stealth", fill: black, scale: 0.6))
  lbl((2.6, 0), $x$, anchor: "west")
  lbl((0, 2.6), $y$, anchor: "south")
  // right half of the circle maps to the positive, left half to the negative real line
  arc((0, -1.3), start: -90deg, stop: 90deg, radius: 1.3, stroke: blue + 0.9pt)
  arc((0, 1.3), start: 90deg, stop: 270deg, radius: 1.3, stroke: red + 0.9pt)
  for (angle, paint) in ((-40deg, blue), (40deg, blue), (140deg, red), (220deg, red)) {
    let pt = (1.3 * calc.cos(angle), 1.3 * calc.sin(angle))
    // blue runs counterclockwise from -i to i, red clockwise, matching the image's orientation
    let sign = if paint == blue { 1 } else { -1 }
    let tangent = (-sign * calc.sin(angle), sign * calc.cos(angle))
    let to = (pt.at(0) + 0.05 * tangent.at(0), pt.at(1) + 0.05 * tangent.at(1))
    line(pt, to, stroke: paint + 0.9pt, mark: (end: "stealth", fill: paint, scale: 0.6))
  }
  lbl((-0.5, 0.7), $bb(D)^2$)
  for (pt, name, anchor) in (
    ((0, 0), $w_0 = 0$, none),
    ((1.3, 0), $w_1 = 1$, "north"),
    ((0, -1.3), $w_2 = -i$, "west"),
    ((-1.3, 0), $w_3 = -1$, "north"),
    ((0, 1.3), $w_4 = i$, "south-west"),
  ) {
    gray-dot(pt)
    if anchor != none { lbl(pt, name, anchor: anchor, padding: 3pt) }
  }
  line((0.1, 0.05), (1.5, 0.5), stroke: luma(120) + 0.4pt)
  lbl((1.5, 0.5), $w_0 = 0$, anchor: "south-west")
  line((3.2, 0), (5.2, 0), mark: arrow-mark, stroke: 0.8pt)
  lbl((4.2, 0.85), $z = S(w)$, padding: 0pt)
  lbl((4.3, 0.35), $= (w + i)/(i w + 1)$, padding: 0pt)
  // upper half plane
  let o = (8.3, 0)
  rect((o.at(0) - 2.6, 0), (o.at(0) + 2.6, 2.6), fill: luma(240), stroke: none)
  lbl((o.at(0) - 2.3, 2.3), $bb(H)$)
  line((o.at(0), -2.6), (o.at(0), 2.6), mark: (start: "stealth", end: "stealth", fill: black, scale: 0.6))
  line((o.at(0) - 2.6, 0), o, stroke: red + 0.9pt, mark: (start: "stealth", fill: red, scale: 0.6))
  line(o, (o.at(0) + 2.6, 0), stroke: blue + 0.9pt, mark: (end: "stealth", fill: blue, scale: 0.6))
  for dx in (-0.6, -1.9) {
    line((o.at(0) + dx, 0), (o.at(0) + dx - 0.05, 0), stroke: red + 0.9pt, mark: (end: "stealth", fill: red, scale: 0.6))
    line((o.at(0) - dx, 0), (o.at(0) - dx + 0.05, 0), stroke: blue + 0.9pt, mark: (end: "stealth", fill: blue, scale: 0.6))
  }
  lbl((o.at(0) + 2.6, 0), $u$, anchor: "west")
  lbl((o.at(0), 2.6), $v$, anchor: "south-west")
  lbl((o.at(0), 2.45), $z_4 = +i infinity$, anchor: "west", padding: 4pt)
  for (dx, dy, name, anchor) in ((0, 1.3, $z_0 = i$, "west"), (1.3, 0, $z_1 = 1$, "north"), (-1.3, 0, $z_3 = -1$, "north")) {
    gray-dot((o.at(0) + dx, dy))
    lbl((o.at(0) + dx, dy), name, anchor: anchor, padding: 4pt)
  }
  gray-dot(o)
  line((o.at(0) - 0.1, 0.1), (o.at(0) - 0.9, 0.7), stroke: luma(120) + 0.4pt)
  lbl((o.at(0) - 0.9, 0.7), $z_2 = 0$, anchor: "south")
})

// The six cyclically inequivalent orderings of four vertex operators on the real line once
// y_1 = 0, y_2 = 1 and y_3 = infinity are fixed: y_4 ranges over one of the three intervals.
#let ordering(n, labels, brace) = canvas(length: 0.62cm, {
  import draw: *
  set-style(stroke: 0.6pt)
  line((0, 0), (6.5, 0), mark: (end: "stealth", fill: black, scale: 0.5))
  lbl((6.5, 0), $RR$, anchor: "west")
  lbl((-0.3, 0), [#n.], anchor: "east")
  for (x, below) in ((0, $-infinity$), (2, $0$), (4, $1$), (6, $infinity$)) {
    circle((x, 0), radius: 0.08, fill: black)
    lbl((x, 0), below, anchor: "north", padding: 3pt)
  }
  for (x, name) in labels { lbl((x, 0.75), name) }
  let (a, b) = brace
  draw.merge-path(stroke: 0.5pt, {
    bezier((a, 0.15), ((a + b) / 2, 0.45), (a, 0.4), ((a + b) / 2 - 0.3, 0.3))
    bezier(((a + b) / 2, 0.45), (b, 0.15), ((a + b) / 2 + 0.3, 0.3), (b, 0.4))
  })
})
#let orderings = grid(
  columns: 2,
  column-gutter: 2em,
  row-gutter: 1em,
  ordering(1, ((1, $y_4$), (2, $y_1$), (4, $y_2$), (6, $y_3$)), (0, 2)),
  ordering(2, ((1, $y_4$), (2, $y_2$), (4, $y_1$), (6, $y_3$)), (0, 2)),
  ordering(3, ((2, $y_1$), (3, $y_4$), (4, $y_2$), (6, $y_3$)), (2, 4)),
  ordering(4, ((2, $y_2$), (3, $y_4$), (4, $y_1$), (6, $y_3$)), (2, 4)),
  ordering(5, ((2, $y_1$), (4, $y_2$), (5, $y_4$), (6, $y_3$)), (4, 6)),
  ordering(6, ((2, $y_2$), (4, $y_1$), (5, $y_4$), (6, $y_3$)), (4, 6)),
)

// The lattice of identified points spanned by 2 pi u and 2 pi v, before and after rotating and
// rescaling coordinates such that u = (1, 0).
#let lattice-panel(u, v, u-label, v-label, uv-label) = canvas(length: 0.9cm, {
  import draw: *
  set-style(stroke: 0.6pt)
  let navy = rgb("#1a1a80")
  rect((-1.3, -1.25), (3.8, 3.4), stroke: 0.5pt)
  line((-1.3, 0), (3.8, 0), mark: (end: "stealth", fill: black, scale: 0.4))
  line((0, -1.25), (0, 3.4), mark: (end: "stealth", fill: black, scale: 0.4))
  let s = 1.6
  let p(a, b) = (s * (a * u.at(0) + b * v.at(0)), s * (a * u.at(1) + b * v.at(1)))
  // dashed lattice lines through neighbouring cells, clipped to the frame (Liang-Barsky)
  let clip(a, b) = {
    let (x0, y0, x1, y1) = (-1.3, -1.25, 3.8, 3.4)
    let (dx, dy) = (b.at(0) - a.at(0), b.at(1) - a.at(1))
    let (t0, t1) = (0.0, 1.0)
    for (d, q) in ((-dx, a.at(0) - x0), (dx, x1 - a.at(0)), (-dy, a.at(1) - y0), (dy, y1 - a.at(1))) {
      // parallel to this edge: entirely outside if on its far side, else unconstrained
      if d == 0 { if q < 0 { t1 = -1.0 }; continue }
      let t = q / d
      if d < 0 { t0 = calc.max(t0, t) } else { t1 = calc.min(t1, t) }
    }
    if t0 >= t1 { none } else { ((a.at(0) + t0 * dx, a.at(1) + t0 * dy), (a.at(0) + t1 * dx, a.at(1) + t1 * dy)) }
  }
  for k in (-1, 1, 2) {
    for (a, b) in ((p(k, -3), p(k, 3)), (p(-3, k), p(3, k))) {
      let seg = clip(a, b)
      if seg != none { line(..seg, stroke: (paint: luma(160), dash: "dashed", thickness: 0.35pt)) }
    }
  }
  line(p(0, 0), p(1, 0), p(1, 1), p(0, 1), close: true, fill: luma(215), stroke: 0.4pt)
  for (to, name, anchor) in ((p(1, 0), u-label, "north"), (p(0, 1), v-label, "south-east"), (p(1, 1), uv-label, "west")) {
    line(p(0, 0), to, stroke: navy + 0.9pt, mark: (end: "stealth", fill: navy, scale: 0.6))
    content(to, box(stroke: 0.4pt, inset: 2pt, fill: white, text(size: 7pt, name)), anchor: anchor, padding: 2pt)
  }
})
#let lattice-rotation = align(center, grid(
  columns: 3,
  column-gutter: 0.6em,
  align: horizon,
  lattice-panel((1, 0.25), (0.15, 1), $2 pi bu$, $2 pi bv$, $2 pi (bu + bv)$),
  canvas(length: 0.9cm, {
    import draw: *
    line((0, 0), (1.2, 0), mark: (start: "|", end: "stealth", fill: black, scale: 0.6), stroke: 0.7pt)
    content((0.6, 0.1), text(size: 7pt)[$bu = (1, 0)$], anchor: "south")
  }),
  lattice-panel((1, 0), (0.15, 1), $2 pi$, $2 pi bv$, $2 pi [(1, 0) + bv]$),
))

// Fundamental domain F_0 of the modular group (light gray) and its image F_0' under
// tau -> -1/tau (dark gray), with the boundary pieces that get identified.
#let fundamental-domain = canvas(length: 2.6cm, {
  import draw: *
  set-style(stroke: 0.6pt)
  let (blue, red, green) = (rgb("#1a1aa6"), rgb("#a01a1a"), rgb("#1a801a"))
  let h = calc.sqrt(3) / 2
  let top = 2
  merge-path(fill: luma(215), stroke: none, {
    line((-0.5, top), (-0.5, h))
    arc((-0.5, h), start: 120deg, stop: 60deg, radius: 1)
    line((0.5, h), (0.5, top))
  })
  merge-path(fill: luma(160), stroke: none, {
    arc((0.5, h), start: 60deg, stop: 120deg, radius: 1)
    arc((-0.5, h), start: 60deg, stop: 0deg, radius: 1)
    arc((0, 0), start: 180deg, stop: 120deg, radius: 1)
  })
  line((-1.05, 0), (1.05, 0), mark: arrow-mark)
  line((0, -0.1), (0, top), mark: arrow-mark)
  arc((1, 0), start: 0deg, stop: 180deg, radius: 1, stroke: red)
  arc((0, 0), start: 0deg, stop: 90deg, radius: 1, stroke: green)
  arc((0, 0), start: 180deg, stop: 90deg, radius: 1, stroke: green)
  for x in (-0.5, 0.5) {
    line((x, 0), (x, top), stroke: blue, mark: (end: "stealth", fill: blue, scale: 0.5))
    line((x, -0.03), (x, 0.03))
  }
  lbl((-0.5, 0), $-1/2$, anchor: "north", padding: 4pt)
  lbl((0.5, 0), $1/2$, anchor: "north", padding: 4pt)
  lbl((0, 1), $i$, anchor: "north-west", padding: 3pt)
  circle((0, 1), radius: 0.015, fill: black)
  lbl((0.03, 1.5), $F_0$, anchor: "west")
  lbl((-0.12, 0.78), $F'_0$)
  content((-0.55, 1.5), text(size: 9pt, fill: blue, $A$), anchor: "east")
  content((0.55, 1.5), text(size: 9pt, fill: blue, $A'$), anchor: "west")
  content((-0.25, 1.02), text(size: 9pt, fill: red, $B$), anchor: "south")
  content((0.25, 1.02), text(size: 9pt, fill: red, $B'$), anchor: "south")
  content((-0.3, 0.45), text(size: 9pt, fill: green, $C$))
  content((0.3, 0.45), text(size: 9pt, fill: green, $C'$))
})

= Gaussian integral

#task[
  Our aim is to prove the formula
  $ S_S2 (bk_1, ..., bk_n) = lr(chevron.l product_(j=1)^n NO(e^(i k_j dot X(z_j, zb_j))) chevron.r) prop delta^D (sum_(j=1)^n k_j) product_(j<l) |z_j - z_l|^(alpha' k_j dot k_l) $ <eq:s-sphere>
  for the tree-level S-matrix describing the scattering of $n$ closed string tachyons propagating in D dimensions. \
  We do so by evaluating the functional integral
  $ Z_S2 [J] = integral cal(D) X exp[integral_CC dif z dif zb (1/(2 pi alpha') X dot partial db X + i J dot X)] $ <eq:z-sphere>
  involving the source $J^mu (z, zb)$.
  + Give the form of $J^mu (z, zb)$ relevant to the S-matrix @eq:s-sphere and convince yourself that indeed the problem reduces to the one defined in eq. @eq:z-sphere.
  + This Gaussian integral is best performed by expanding the fields into eigenmodes $X_I (z, zb)$ of the Laplace operator $partial db$:
    $ partial db X_I (z, zb) = -omega_I^2 X_I (z, zb). $ <eq:eigenmodes>
    These form a complete set:
    $ X^mu (z, zb) = sum_I x_I^mu X_I (z, zb), #h(3em) x_I^mu = integral_CC dif z dif zb X^mu (z, zb) X_I (z, zb), $ <eq:expansion>
    $ integral_CC dif z dif zb X_I (z, zb) X_(I') (z, zb) = delta_(I I'), #h(3em) sum_I X_I (z, zb) X_I (z', zb') = delta(z - z') delta(zb - zb'). $ <eq:completeness>
    Use this to arrive at
    $ Z_S2 [J] = product_(I,mu) integral dif x_I^mu exp(-w_I^2/(2 pi alpha') x_I^mu x_(I,mu) + i x_I^mu J_(I,mu)), $
    where
    $ J_I^mu = integral_CC dif z dif zb J^mu (z, zb) X_I (z, zb). $ <eq:j-modes>
  + By considering the zero mode $I = 0$ with $omega_0 = 0$ and the non-zero modes $I != 0$ separately argue that
    $ Z_S2 [J] = i (2 pi)^D delta^D (J_0) product_(I != 0) ((2 pi^2 alpha')/omega_I^2)^(D/2) exp(-(pi alpha' J_I^mu J_(I,mu))/(2 omega_I^2)). $
  + This can be rewritten as
    $ Z_S2 [J] = i (2 pi)^D delta^D (J_0) det'(-(partial db)/(2 pi^2 alpha'))^(-D/2) exp(-1/2 integral_CC dif z dif zb dif z' dif zb' J(z, zb) dot J(z', zb') G'(z, zb, z', zb')) $ <eq:z-det>
    where the notation $det'$ indicates that we omit zero modes in the functional determinant. Argue that the Green's function $G'(z, zb, z', zb')$ satisfies
    $ -1/(pi alpha') partial db G'(z, zb, z', zb') = sum_(I != 0) X_I (z, zb) X_I (z', zb') = delta(z - z') delta(zb - zb') - X_0^2. $ <eq:green-eq>
    *Remark:* Without proof we state that the effect of $X_0^2$ above is that self-contractions of the fields at $z_i = z_j$ are cancelled. With this knowledge we can continue with the Green's function $G(z, zb, z', zb')$ where the term $X_0^2$ in eq. @eq:green-eq is omitted and omit self-contractions. Argue that
    $ G(z, zb, z', zb') = -alpha'/2 ln(|z - z'|^2). $
  + Now we return to the amplitude @eq:s-sphere. Deduce this result from the above considerations.
]

+ #note[Equation @eq:s-sphere is already a simplified expression valid only at tree-level. Normally, to obtain the full scattering amplitude, the S-matrix would contain a sum over all compact worldsheet topologies as well as integrals over the moduli spaces of these topologies, and be divided by the volume of Weyl transformations and diffeomorphisms $"Vol"_("Weyl" times "diff")$. However, since we restrict ourselves to the tree-level S-matrix contribution on the sphere where no such moduli exist, the S-matrix simplifies to the one given in eq. @eq:s-sphere.]
  To generate the scattering matrix @eq:s-sphere from the partition function @eq:z-sphere, we need to insert the source
  $ J^mu (z, zb) = sum_(j=1)^n k_j^mu delta(z - z_j) delta(zb - zb_j), $ <eq:source>
  since then
  $
    Z_S2 [J]/Z_S2 & = 1/Z_S2 integral cal(D) X exp[integral_CC dif z dif zb (1/(2 pi alpha') X dot partial db X + i J dot X)] \
    & = 1/Z_S2 integral cal(D) X exp[integral_CC dif z dif zb (1/(2 pi alpha') X dot partial db X) + sum_(j=1)^n i k_j dot X] \
    & = 1/Z_S2 integral cal(D) X e^(-S[X]) product_(j=1)^n NO(e^(i k_j dot X)) = lr(chevron.l product_(j=1)^n NO(e^(i k_j dot X)) chevron.r) = S_S2 (bk_1, ..., bk_n),
  $ <eq:z-ratio>
  where we used that after partial integration (with boundary terms vanishing at infinity), the action of the free boson on the sphere can be written as
  $ S[X] = 1/(2 pi alpha') integral_CC dif z dif zb partial_z X_mu (z, zb) partial_zb X^mu (z, zb) = -1/(2 pi alpha') integral_CC dif z dif zb X_mu (z, zb) partial_z partial_zb X^mu (z, zb). $
+ Expanding the exponent in the partition function into eigenmodes $X_I (z, zb)$ of the complex Laplace operator $partial db$, we get
  $
    integral_CC dif z dif zb X_mu partial db X^mu & eqby("eq:expansion") integral_CC dif z dif zb X_mu partial db (sum_I x_I^mu X_I (z, zb)) \
    & eqby("eq:eigenmodes") -sum_I omega_I^2 x_I^mu integral_CC dif z dif zb X_mu X_I (z, zb) eqby("eq:expansion") -sum_I omega_I^2 x_I^mu x_(I,mu).
  $
  Similarly, the second exponential becomes
  $ integral_CC dif z dif zb J_mu X^mu eqby("eq:expansion") integral_CC dif z dif zb J_mu sum_I x_I^mu X_I (z, zb) eqby("eq:j-modes") sum_I x_(I,mu) J_I^mu. $
  Using that the path integration $cal(D) X$ over all field configurations can be rewritten as the product of integrations over all mode coefficients $x_I^mu$, i.e.
  $ cal(D) X = product_mu cal(D) X^mu = product_(mu,I) dif x_I^mu, $
  we can write the partition function as
  $
    Z_S2 [J] & = integral (product_(I,mu) dif x_I^mu) exp(-sum_I w_I^2/(2 pi alpha') x_I^nu x_(I,nu) + i sum_I x_(I,nu) J_I^nu) \
    & = integral product_(I,mu) dif x_I^mu exp(-w_I^2/(2 pi alpha') x_I^nu x_(I,nu) + i x_I^nu J_(I,nu)).
  $
  Since the integrand now factorizes both into dimensions $nu$ and into mode numbers $I$, we can write the whole multi-dimensional integral as a product of many one-dimensional integrations,
  $ Z_S2 [J] = product_(I,mu) integral_(-infinity)^infinity dif x_I^mu exp(-w_I^2/(2 pi alpha') x_I^mu x_(I,mu) + i x_I^mu J_(I,mu)). $
+ Pulling out the $I = 0$-term for which $omega_0 = 0$,
  $ product_(mu=0)^(D-1) integral_(-infinity)^infinity dif x_0^mu exp(-omega_0^2/(2 pi alpha') x_0^mu x_(0,mu) + i x_0^mu J_(0,mu)) = product_(mu=0)^(D-1) integral_(-infinity)^infinity dif x_0^mu e^(i x_0^mu J_(0,mu)), $
  we can treat it separately using the integral representation of the Dirac delta,
  $ integral_(-infinity)^infinity dif x e^(i J x) = 2 pi delta(J), $
  to get
  $ product_(mu=0)^(D-1) integral_(-infinity)^infinity dif x_0^mu e^(i x_0^mu J_(0,mu)) = product_(mu=0)^(D-1) 2 pi delta(J_0^mu) = (2 pi)^D delta^D (J_0). $
  As for the remaining $I != 0$, we would like to solve them as Gaussian integrals. Note however that since spacetime in string theory is simply flat Minkowski space,#footnote[In particular, the spacetime metric is completely unaffected by any fancy geometry the string CFT may adopt.] and since $mu$ is a spacetime, not a worldsheet index, the $x_I^0$-term in $x_I^2 = x_(I,mu) x_I^mu$ has the wrong sign. This can be remedied by a simple Wick rotation $x_I^0 -> i x_I^0$. Then all scalar products become Euclidean and the integration measure $dif x_I^0 -> i dif x_I^0$ produces an extra factor of $i$. Thus the partition function becomes
  $
    Z_S2 [J] & = i (2 pi)^D delta^D (J_0) product_(I != 0) product_(mu=0)^(D-1) integral_(-infinity)^infinity dif x_I^mu exp(-w_I^2/(2 pi alpha') x_I^mu x_(I,mu) + i x_I^mu J_(I,mu)) \
    & = i (2 pi)^D delta^D (J_0) product_(I != 0) product_(mu=0)^(D-1) sqrt(pi/(omega_I^2 \/ (2 pi alpha'))) exp((i J_(I,mu))^2/(4 omega_I^2 \/ (2 pi alpha'))) \
    & = i (2 pi)^D delta^D (J_0) product_(I != 0) ((2 pi^2 alpha')/omega_I^2)^(D/2) exp(-(pi alpha' J_I^mu J_(I,mu))/(2 omega_I^2)),
  $ <eq:z-gauss>
  where we used the formula
  $ integral_(-infinity)^infinity dif x e^(-a x^2 + b x + c) = sqrt(pi/a) e^(b^2/(4 a) + c). $
+ To see how eq. @eq:z-det comes about, note that the operator $(-(partial db)/(2 pi^2 alpha'))^(-D/2)$ has eigenvalues $(omega_I^2/(2 pi^2 alpha'))^(-D/2)$. Since its determinant is precisely the product of its eigenvalues, we have
  $ product_(I != 0) (omega_I^2/(2 pi^2 alpha'))^(-D/2) = det'(-(partial db)/(2 pi^2 alpha'))^(-D/2). $ <eq:det>
  As for the exponential, we can simply reverse our application of eq. @eq:j-modes to obtain
  $
    product_(I != 0) exp(-(pi alpha' J_I^mu J_(I,mu))/(2 omega_I^2)) & eqby("eq:j-modes") exp(-sum_(I != 0) (pi alpha')/(2 omega_I^2) integral_CC dif z dif zb J^mu (z, zb) X_I (z, zb) integral_CC dif z' dif zb' J_mu (z', zb') X_I (z', zb')) \
    & equiv exp(-1/2 integral_CC dif z dif zb integral_CC dif z' dif zb' J^mu (z, zb) J_mu (z', zb') G'(z, zb, z', zb')),
  $ <eq:exp-green>
  where we defined
  $ G'(z, zb, z', zb') equiv sum_(I != 0) (pi alpha')/omega_I^2 X_I (z, zb) X_I (z', zb'). $ <eq:green-def>
  Inserting eqs. @eq:det and @eq:exp-green into eq. @eq:z-gauss, we indeed reproduce eq. @eq:z-det,
  $ Z_S2 [J] = i (2 pi)^D delta^D (J_0) det'(-(partial db)/(2 pi^2 alpha'))^(-D/2) exp(-1/2 integral_CC dif z dif zb dif z' dif zb' J(z, zb) dot J(z', zb') G'(z, zb, z', zb')) $ <eq:z-final>
  Using eq. @eq:eigenmodes, i.e. $partial db X_I (z, zb) = -omega_I^2 X_I (z, zb)$, the definition @eq:green-def immediately yields eq. @eq:green-eq,
  $
    -1/(pi alpha') partial db G'(z, zb, z', zb') & = -sum_(I != 0) 1/omega_I^2 partial db X_I (z, zb) X_I (z', zb') \
    & = sum_(I != 0) X_I (z, zb) X_I (z', zb') eqby("eq:completeness") delta(z - z') delta(zb - zb') - X_0^2,
  $
  where the last equality holds due to the eigenmodes' completeness relation. \
  To demonstrate that the _full_ Green's function is given by
  $ G(z, zb, z', zb') = -alpha'/2 ln(|z - z'|^2), $ <eq:green-full>
  we show that it satisfies eq. @eq:green-eq with the self-contraction cancelling $X_0^2$-term omitted,
  $ -1/(pi alpha') partial db G(z, zb, z', zb') = 1/(2 pi) partial db ln[(z - z')(zb - zb')] = 1/(2 pi) partial (z - z')/((z - z')(zb - zb')) = 1/(2 pi) partial 1/(zb - zb'). $
  Using now the relation $2 pi delta(z) delta(zb) = partial_z 1/zb$ which we proved in exercise 1.b) on assignment 8, we indeed get
  $ -1/(pi alpha') partial db G(z, zb, z', zb') = delta(z - z') delta(zb - zb'). $
  #note[Of course, we could add any harmonic function $f(z, zb, z', zb')$ to $G(z, zb, z', zb')$ that fulfills $partial db f(z, zb, z', zb') = 0$ and would still reproduce eq. @eq:green-eq.]
+ Coming back to the tree-level scattering matrix of $n$ closed string tachyons propagating in $D$ dimensions, we deduce that it is indeed of the form given in eq. @eq:s-sphere by inserting the source $J^mu (z, zb) = sum_(j=1)^n k_j^mu delta(z - z_j) delta(zb - zb_j)$ as defined in eq. @eq:source of part a) into the partition function on the sphere as derived in eq. @eq:z-final, more specifically its exponential part @eq:exp-green,
  $ exp(-1/2 integral_CC dif z dif zb integral_CC dif z' dif zb' J(z, zb) dot J(z', zb') G'(z, zb, z', zb')) = exp(-1/2 sum_(j != l = 1)^n k_j dot k_l G(z_j, zb_j, z'_l, zb'_l)). $
  Since setting $j != l$ takes care of avoiding self-contractions, we may insert the full Green's function @eq:green-full to simplify further
  $ exp(-1/2 sum_(j != l = 1)^n k_j dot k_l G(z_j, zb_j, z'_l, zb'_l)) eqby("eq:green-full") exp(alpha'/4 sum_(j != l = 1)^n k_j dot k_l ln(|z_j - z'_l|^2)). $
  Now it is clear that the sum is symmetric under $j <-> l$, so we may restrict to $j < l$ and receive a factor of 2 in return.
  $ exp(alpha'/2 sum_(j<l)^n k_j dot k_l ln(|z_j - z'_l|^2)) = product_(j<l)^n exp(ln(|z_j - z'_l|^(alpha' k_j dot k_l))) = product_(j<l)^n |z_j - z'_l|^(alpha' k_j dot k_l). $
  Inserting nice and compact expression into the partition function eq. @eq:z-final, we finally arrive at the tree-level closed string scattering matrix on the sphere,
  $
    #box(stroke: 0.5pt, inset: 6pt, $display(S_S2 (bk_1, ..., bk_n) eqby("eq:z-ratio") Z_S2 [J]/Z_S2 = (i (2 pi)^D)/Z_S2 delta^D (J_0) det'(-(partial db)/(2 pi^2 alpha'))^(-D/2) product_(j<l)^n |z_j - z'_l|^(alpha' k_j dot k_l) \
    prop delta^D (sum_(j=1)^n k_j) product_(j<l)^n |z_j - z'_l|^(alpha' k_j dot k_l),)$)
  $
  where we used that the functional determinant $det'(-(partial db)/(2 pi^2 alpha'))^(-D/2)$ is a constant independent of both the $k_j$ and $z_j$, and that
  $ delta^D (J_0) eqby("eq:j-modes") delta^D (integral_CC dif z dif zb J(z, zb) X_0 (z, zb)) eqby("eq:source") delta^D (sum_(j=1)^n k_j X_0 (z_j, zb_j)) prop delta^D (sum_(j=1)^n k_j). $
  In the last step, we made use of the fact that the string field $X(z, zb)$ lives on the compact space $S2$ for which $X_0 (z, zb) = X_0 in CC$ constant is a valid and, in particular, normalizable choice.

= The Veneziano Amplitude

#task[
  The computation of the Veneziano amplitude, i.e. the 4-point amplitude for 4 open string tachyons on the disk, proceeds in a manner analogous to the closed string counterpart discussed in the lecture. The only difference is that the insertion of the vertex operators on the boundary of the disk requires summing over orderings. We perform the computation on the upper half-plane with vertex operators inserted on the real line with coordinate $y$.
  + Show that
    $ S_D2 (bk_1, bk_2, bk_3, bk_4) = i g_o^4 C_D2^X (2 pi)^26 delta^((26)) (sum_i bk_i) integral_(-infinity)^infinity dif y_4 |y_4|^(-alpha' u - 2) |1 - y_4|^(-alpha' t - 2) + (t <-> s), $ <eq:veneziano>
    after fixing $y_1 = 0$, $y_2 = 1$, $y_3 -> infinity$ by $P S L(2, RR)$ invariance.

    You may use that
    $ lr(chevron.l product_(j=1)^m e^(i bk_j dot bX(y_j)) chevron.r)_D2 = i C_D2^X (2 pi)^26 delta^((26)) (sum_(j=1)^m bk_j) product_(j<l)^m |y_j - y_l|^(2 alpha' bk_j dot bk_l). $ <eq:disk-correlator>
  + Now split the integral into the three ranges $-infinity < y_4 < 0$, $0 < y_4 < 1$, $1 < y_4 < infinity$. Draw the orderings of the vertex operators 1, 2, 3, 4 corresponding to these ranges for both terms in eq. @eq:veneziano. Argue that these ranges can be transformed into each other by $P S L(2, RR)$ invariance and deduce
    $ S_D2 (bk_1, bk_2, bk_3, bk_4) = 2 i C_D2^X (2 pi)^26 delta^((26)) (sum_(j=1)^4 bk_j) (I(s, t) + I(t, u) + I(u, s)) $
    with
    $ I(s, t) = integral_0^1 dif y thin y^(-alpha' s - 2) (1 - y)^(-alpha' t - 2) equiv B(-alpha' s - 1, -alpha' t - 1). $ <eq:beta>
    *Note:* The function $B(a, b)$ is the Euler Beta-function and can be shown to be related to the Euler $Gamma$-function via
    $ B(a, b) = (Gamma(a) Gamma(b))/Gamma(a + b). $
]

+ Before we dive into the calculation, let's collect some background information.
  #note[
    In string theory, scattering processes at tree-level occur exclusively on worldsheets that are Riemann surfaces with positive Euler characteristic $chi$.#footnote[Of course, for higher-loop corrections more intricate topologies with negative $chi$ arise. The worldsheet topology does, however, _not_ depend on the number of states participating in a scattering. This is taken care of entirely by the insertion of vertex operators. Whether we want to compute the vacuum amplitude or two-to-two open string scattering at tree-level, both scenarios take place on the disk, just with four instead of zero open string vertex operators inserted.] Exactly three such surfaces exist:
    - The *two-sphere* $S2$ acts as a stage for tree-level oriented closed string scattering.
    - The *disk* $D2$ hosts oriented open string scatterings. Vertex operators have to be inserted on the boundary.
    - The *real projective plane* $bb(R) P^2$ accommodates scattering processes in unoriented string theory.

    Crucially, all these surfaces are moduli-free. As a result, no anti-ghost insertions $1/(4 pi) (b|partial_alpha hat(h))$ nor integrations $integral_F dif t^alpha$ over the moduli's fundamental domains are necessary when computing tree-level scatterings in string theory.
  ]
  We start our calculation from the heuristic expression for the S-matrix given in the lecture:
  $ S(bk_1, ..., bk_n) = sum_("compact" \ "topologies") (integral cal(D) X integral cal(D) h)/Vol e^(-SP - lambda chi) product_(i=1)^n V_"ot" (bk_i). $ <eq:s-heuristic>
  The Veneziano amplitude describes scattering of $n = 4$ open string tachyons and incorporates just the tree-level contribution to this process so we truncate the sum over compact topologies right after the disk. Note that open string vertex operators are inserted on the worldsheet's boundary. Since different points on the boundary correspond to different $tau$, the disk admits a notion of time-ordering for the vertex operator insertions. The sum over topologies, even if only carried out to tree-level, contains all six cyclically inequivalent orderings that are possible with $n = 4$ insertions. Equation @eq:s-heuristic thus becomes
  $ S_D2 (bk_1, ..., bk_4) = sum_(pi in S_4 \/ ZZ_4) (integral cal(D) X integral cal(D) h)/Vol e^(-SP - lambda chi_D2) product_(i=1)^4 V_"ot" (bk_i). $ <eq:s-disk>
  One of the important results from our analysis of conformal field theory was the *operator-state correspondence*. In particular, we found that the localized vertex operator $V_"ot" (y)$ for the creation of one open string tachyon from the $P S L(2, CC)$-invariant vacuum is the primary field $NO(e^(i bk dot bX(y)))$. However, what furnishes the integrand of the path integral in eq. @eq:s-disk is not the localized but the integrated vertex operator. Integration $integral_(partial Sigma) dif y$ over all possible insertion points on the worldsheet boundary#footnote[For the closed string, we would integrate over the _whole_ worldsheet, i.e. $integral_Sigma dif z dif zb$.] $partial Sigma$ ensures invariance of the full amplitude under worldsheet-diffeomorphisms. Hence
  $ V_"ot" (bk_i) = g_o integral_(partial Sigma) dif y_i NO(e^(i bk_i dot bX(y_i))), $
  where the normalization conventionally includes one power of the string coupling $g_o$ (respectively $g_c = g_o^2$ for closed string vertex operators). Inserting this expression into eq. @eq:s-disk yields
  $
    S_D2 (bk_1, ..., bk_4) & = sum_(pi in S_4 \/ ZZ_4) (integral cal(D) X integral cal(D) h)/Vol e^(-SP - lambda chi_D2) product_(i=1)^4 g_o integral_(I_pi) dif y_i NO(e^(i bk_i dot bX(y_i))) \
    & = g_o^4/Vol sum_(pi in S_4 \/ ZZ_4) integral_(I_pi) dif y_1 dif y_2 dif y_3 dif y_4 integral cal(D) X integral cal(D) h e^(-SP - lambda chi_D2) product_(i=1)^4 NO(e^(i bk_i dot bX(y_i))) \
    & = g_o^4/Vol sum_(pi in S_4 \/ ZZ_4) integral_(I_pi) dif y_1 dif y_2 dif y_3 dif y_4 lr(chevron.l product_(i=1)^4 NO(e^(i bk_i dot bX(y_i))) chevron.r)_D2,
  $ <eq:s-disk-2>
  where in the last step we assumed a normalized partition function $Z_D2 = 1$. Each permutation of the insertion points gives rise to a different integration scheme $I_pi = {y_(pi(1)) < y_(pi(2)) < y_(pi(3)) < y_(pi(4))}$.

  We divide by the volume of the group of diffeomorphisms and Weyl transformations because these are pure gauge degrees of freedom and would lead to overcounting in the path integral. An alternative way to deal with this redundancy is to actually _use_ it to fix the position of some of the vertex operator insertions. After all, we only integrated over the insertion points to preserve diffeomorphism invariance on the worldsheet in the first place, so we should be able to reverse this operation until all gauge freedom is used up at which point we are left with an S-matrix containing only truly physical contributions to the scattering amplitude.

  The conformal group on $D2$ is $P S L(2, RR)$, i.e. the Möbius group over $RR$ (hence $Vol = "Vol"_(P S L(2, RR))$). We demonstrated in exercise 3 on assignment 7 that $P S L(2, RR)$-transformations allow us to map any three distinct points to any other three distinct points on $RR$.

  Combined with the conformal map $S(w) = (w + i)/(i w + 1) in P S L(2, CC)$ which maps $D2$ to the half plane $bb(H)$ (following convention, we choose the upper half) and in particular the disk's boundary $partial D2$ to the real line $partial bb(H) = RR union infinity$ compactified by adding the point at infinity#footnote[Note that the point at $w_4 = i$ is special in the sense that $S(w = i) = i infinity$ as in the illustration, but the counterclockwise limit gives $lim_(w -> i^+) S(w) = infinity$, whereas the clockwise limit is $lim_(w -> i^-) S(w) = -infinity$. So the point $w_4 = i$ on the disk corresponds to the compactification point $z = infinity$ where the real line jumps back to $-infinity$.], this allows us to set e.g. $y_1 = 0$, $y_2 = 1$, $y_3 -> infinity$ and change the integration domain of the remaining variable $y_4$ from $partial Sigma$ to $(-infinity, infinity]$. The action of $S(w)$ is illustrated in the following diagram.
  #align(center, disk-to-half-plane)
  There is a subtlety that has to be taken care of when fixing the gauge: Following the prescription ensuing eq. (5.45) of the lecture notes for the general gauge-fixed S-matrix, we need to add a $c$-ghost insertion for every tachyon vertex operator whose position we fix. Constraining $V_"ot" (bk_1)$, $V_"ot" (bk_2)$, and $V_"ot" (bk_3)$, we thus get a factor $ev(c(y_1) c(y_2) c(y_3))_D2$. Invariance of the vacuum under conformal transformations requires that a general CFT $n$-point function transforms as
  $ ev(phi_i (z_1) phi_j (z_2) phi_k (z_3)) limits(=)^! ev(phi'_i (z'_1) phi'_j (z'_2) phi'_k (z'_3)). $
  This completely fixes the spacetime-dependence of the three-point function of quasi-primaries to
  $ ev(phi_i (z_1) phi_j (z_2) phi_k (z_3)) limits(=)^! C_(i j k)/((z_1 - z_2)^(h_i + h_j - h_k) (z_2 - z_3)^(h_j + h_k - h_i) (z_1 - z_3)^(h_i + h_k - h_j)), $ <eq:three-point>
  where the structure constant $C_(i j k)$ is closely related to the coefficients appearing in the OPE of the corresponding fields. Since the $c$-ghosts are primaries of weight $h_c = -1$, eq. @eq:three-point for $ev(c(y_1) c(y_2) c(y_3))_D2$ reads
  $ ev(c(y_1) c(y_2) c(y_3)) prop 1/((y_1 - y_2)^(-1) (y_2 - y_3)^(-1) (y_1 - y_3)^(-1)), $ <eq:ghost-correlator>
  Gauge fixing the expectation value in eq. @eq:s-disk-2 thus reduces it to
  $
    integral_(I_pi) dif y_1 dif y_2 dif y_3 dif y_4 lr(chevron.l product_(i=1)^4 NO(e^(i bk_i dot bX(y_i))) chevron.r)_D2 & = integral_(y_(pi(1)))^(y_(pi(2))) dif y_4 lr(chevron.l c(y_1) c(y_2) c(y_3) product_(i=1)^4 NO(e^(i bk_i dot bX(y_i))) chevron.r)_D2 \
    & propby("eq:ghost-correlator") (y_1 - y_2)(y_2 - y_3)(y_1 - y_3) integral_(y_(pi(1)))^(y_(pi(2))) dif y_4 lr(chevron.l product_(i=1)^4 NO(e^(i bk_i dot bX(y_i))) chevron.r)_D2,
  $ <eq:gauge-fixed>
  where in the last step we used that the gauge-fixed action contains no ghost-matter interaction terms so that the correlators in the two sectors factorize. \
  For $y_1 = 0$, $y_2 = 1$, $y_3 -> infinity$, the $y$-terms in front simplify to
  $ (y_1 - y_2)(y_2 - y_3)(y_1 - y_3) = -y_3^2. $
  Dropping the factor $Vol^(-1)$ (since we have now used up all gauge freedom and no longer have to worry about overcounting), and inserting everything $y_i$-dependent back into eq. @eq:s-disk-2, we get
  $ S_D2 (bk_1, ..., bk_4) prop g_o^4 sum_(pi in S_4 \/ ZZ_4) integral_(y_(pi(1)))^(y_(pi(2))) dif y_4 y_3^2 lr(chevron.l product_(i=1)^4 NO(e^(i bk_i dot bX(y_i))) chevron.r)_D2. $
  We can now use the hint provided by the exercise and insert eq. @eq:disk-correlator.
  $ S_D2 (bk_1, ..., bk_4) eqby("eq:disk-correlator") i (2 pi)^26 g_o^4 C'^X_D2 delta^((26)) (sum_(j=1)^m bk_j) sum_(pi in S_4 \/ ZZ_4) integral_(y_(pi(1)))^(y_(pi(2))) dif y_4 y_3^2 product_(j<l)^4 |y_j - y_l|^(2 alpha' bk_j dot bk_l), $ <eq:s-inserted>
  where we absorbed the proportionality factor from eq. @eq:gauge-fixed into $C_D2^X -> C'^X_D2$, which can be fixed by unitarity later. \
  For $y_1 = 0$, $y_2 = 1$, $y_3 -> infinity$, the product in eq. @eq:s-inserted simplifies to
  $
    y_3^2 product_(j<l)^4 |y_j - y_l|^(2 alpha' bk_j dot bk_l) & = y_3^2 underbrace(|y_1 - y_2|, 1)^(2 alpha' bk_1 dot bk_2) underbrace(|y_1 - y_3|, y_3)^(2 alpha' bk_1 dot bk_3) underbrace(|y_1 - y_4|, |y_4|)^(2 alpha' bk_1 dot bk_4) \
    & quad dot underbrace(|y_2 - y_3|, y_3)^(2 alpha' bk_2 dot bk_3) underbrace(|y_2 - y_4|, |1 - y_4|)^(2 alpha' bk_2 dot bk_4) underbrace(|y_3 - y_4|, y_3)^(2 alpha' bk_3 dot bk_4) \
    & = y_3^2 y_3^(2 alpha' overbrace((bk_1 + bk_2 + bk_4), -bk_3) dot bk_3) |y_4|^(2 alpha' bk_1 dot bk_4) |1 - y_4|^(2 alpha' bk_2 dot bk_4)
  $
  Now we see that sending $y_3 -> infinity$ was chosen wisely, as the $y_3$-dependence completely disappears,#footnote[As it must since we no longer integrate over $y_3$ and the final S-matrix should not depend on it.]
  $ y_3^2 y_3^(-2 alpha' bk_3^2) = y_3^(2 - 2 alpha' 1/alpha') = 1. $
  Reinserting the remaining $|y_4|^(2 alpha' bk_1 dot bk_4) |1 - y_4|^(2 alpha' bk_2 dot bk_4)$, eq. @eq:s-inserted reads
  $ S_D2 (bk_1, ..., bk_4) = i (2 pi)^26 g_o^4 C'^X_D2 delta^((26)) (sum_(j=1)^m bk_j) sum_(pi in S_4 \/ ZZ_4) integral_(y_(pi(1)))^(y_(pi(2))) dif y_4 |y_4|^(2 alpha' bk_(pi(1)) dot bk_4) |1 - y_4|^(2 alpha' bk_(pi(2)) dot bk_4). $ <eq:s-orderings>
  It's time to take care of the sum $sum_(pi in S_4 \/ ZZ_4)$. Having mapped all insertion points to the real line, the six inequivalent orderings of four vertex operator are as follows:
  #align(center, orderings)
  Note that the order of $y_1$, $y_2$, and $y_3$ is identical on the left and right with only the integrated over $y_4$ changing place. We can thus add up orderings to get two terms, each with an integration domain of $y_4 in (-infinity, infinity]$. In the left case we then get $bk_(pi(1)) = bk_1$, $bk_(pi(2)) = bk_2$, whereas $bk_(pi(1)) = bk_1$, $bk_(pi(2)) = bk_3$ on the right so that eq. @eq:s-orderings can be written as
  $
    S_D2 (bk_1, ..., bk_4) = i (2 pi)^26 g_o^4 C'^X_D2 delta^((26)) (sum_(j=1)^m bk_j) integral_(-infinity)^infinity dif y_4 ( & |y_4|^(2 alpha' bk_1 dot bk_4) |1 - y_4|^(2 alpha' bk_2 dot bk_4) \
    & + |y_4|^(2 alpha' bk_1 dot bk_4) |1 - y_4|^(2 alpha' bk_3 dot bk_4)),
  $ <eq:s-two-terms>
  Using again the mass-shell condition $bk^2 = 1/alpha'$ and the Mandelstam variables $s = -(bk_1 + bk_2)^2$, $t = -(bk_2 + bk_4)^2$, $u = -(bk_1 + bk_4)^2$, we have
  $
    2 alpha' bk_1 dot bk_4 & = alpha' [(bk_1 + bk_4)^2 - bk_1^2 - bk_4^2] = -alpha' u - 2, \
    2 alpha' bk_2 dot bk_4 & = alpha' [(bk_2 + bk_4)^2 - bk_2^2 - bk_4^2] = -alpha' t - 2, \
    2 alpha' bk_3 dot bk_4 & = alpha' [(bk_3 + bk_4)^2 - bk_3^2 - bk_4^2] = -alpha' s - 2.
  $
  Reinsertion into eq. @eq:s-two-terms yields the S-matrix for the tree-level scattering of four open string tachyons as given in eq. @eq:veneziano,
  $ S_D2 = i (2 pi)^26 g_o^4 C'^X_D2 delta^((26)) (sum_(j=1)^m bk_j) integral_(-infinity)^infinity dif y_4 |y_4|^(-alpha' u - 2) (|1 - y_4|^(-alpha' t - 2) + |1 - y_4|^(-alpha' s - 2)). $ <eq:s-final>
+ We can also add up the six orderings horizontally in pairs of two rather than vertically in threes. This amounts to splitting the integral in eq. @eq:s-final into the three pieces $(-infinity, infinity] -> (-infinity, 0] + (0, 1] + (1, infinity]$. The middle term then exactly fits eq. @eq:beta,
  $ I(u, t) + I(u, s) eqby("eq:beta") integral_0^1 dif y_4 |y_4|^(-alpha' u - 2) (|1 - y_4|^(-alpha' t - 2) + |1 - y_4|^(-alpha' s - 2)). $ <eq:middle>
  Using the $P S L(2, RR)$ transformations $x = 1/(-y + 1)$ and $x = 1/y$ which map $(-infinity, 0]$ and $(1, infinity]$ to $(0, 1]$, respectively, we can perform a change of variable in the first and third integrals. Thanks to the above mentioned $P S L(2, RR)$ invariance, they then each give a contribution equal to eq. @eq:middle up to interchange of vertex operators. Combined, the integrals yield all three cyclic permutations of $I(a, b)$, $a, b in {s, t, u}$ twice so that eq. @eq:s-final is equal to
  $ S_D2 (bk_1, bk_2, bk_3, bk_4) = 2 i C_D2^X (2 pi)^26 delta^((26)) (sum_(j=1)^4 bk_j) (I(s, t) + I(t, u) + I(u, s)). $
  We get an $I(s, t)$ from orderings 2 and 5, an $I(t, u)$ from orderings 3 and 4, and an $I(u, s)$ from orderings 1 and 6.

= The moduli space of $bb(T)^2$

#task[
  Consider a torus $bb(T)^2 = bb(S)^1 times bb(S)^1$, parametrized by
  $ (sigma_1, sigma_2) hateq (sigma_1, sigma_2) + 2 pi (m, n) wide "for" quad m, n in ZZ. $ <eq:torus-periodicity>
  + Convince yourself that, up to an overall rescaling, the most general metric is given by
    $ dif s^2 = |dif sigma_1 + tau dif sigma_2|^2, #h(3em) "for" quad tau in CC. $ <eq:torus-metric>
  + Argue that Weyl transformations and diffeomorphisms can be used to define new coordinates $xi_i$ in terms of which the metric takes the standard form $dif s^2 = |dif xi_1 + i dif xi_2|^2$.

    *Hint:* Use that $chi = 1/(4 pi) integral_(bb(T)^2) dif^2 xi sqrt(h) R = 2 - 2 g = 0$.

    Argue that the new periodicities are given by
    $ xi_1 tilde.eq xi_1 + 2 pi (m + n v_1), #h(3em) xi_2 tilde.eq xi_2 + 2 pi n v_2, $
    for some vector $(v_1, v_2)$.
  + Now define the complex variable $z = sigma_1 + tau sigma_2$ such that in the first picture $dif s^2 = dif z dif zb$. Convince yourself that the identification @eq:torus-periodicity implies the identification
    $ z tilde.eq z + 2 pi (m + n tau), $ <eq:z-periodicity>
    i.e. $bb(T)^2$ is a lattice in $CC$.

    *Remark:* The upshot is the following: We can parametrize the torus in two equivalent ways: In the first picture @eq:torus-periodicity, the coordinates $sigma_1$, $sigma_2$ have standard periodicity $2 pi$, but there appears a modulus $tau$ -- the so-called Teichmüller parameter -- in the metric @eq:torus-metric. Alternatively, we can choose coordinates $z$, $zb$ such that the metric has the standard flat form $dif s^2 = dif z dif zb$, but now in general the periodicity @eq:z-periodicity contains a modulus $tau$ that cannot be removed by conformal transformations.
  + Consider now the transformations
    $ S : tau -> tau + 1, #h(3em) T : tau -> -1/tau, #h(3em) U : tau -> tau/(tau + 1). $
    Determine their action on the parameters $(m, n)$ in eq. @eq:z-periodicity and use this to argue that $T$, $S$ and $U$ leave the torus invariant. Argue that $T$, $S$ and $U$ generate the group $S L(2, ZZ)$, whose action on $tau$ is
    $ tau -> (a tau + b)/(c tau + d), #h(3em) "where" quad a d - b c = 1, quad a, b, c, d in ZZ. $ <eq:sl2z>
    Argue that the full modular group of $bb(T)^2$ is $P S L(2, ZZ) = S L(2, ZZ) \/ ZZ_2$.

    *Note:* In fact, $S$ and $T$ suffice to generate $S L(2, ZZ) \/ ZZ_2$, but this is non-trivial to show.
  + Use $P S L(2, ZZ)$ invariance to show that $tau$ can always be brought to the fundamental domain
    $ F_0 = {tau in CC mid(|) -1/2 <= "Re"(tau) <= 1/2, |tau| >= 1}. $
    Represent $F_0$ graphically and discuss the various identifications of its boundaries.
]

+ We study the metric on the two-torus $bb(T)^2$ parametrized by the coordinates $(sigma_1, sigma_2)$ such that $sigma_1$ is identified with $sigma_1 + 2 pi$ and $sigma_2$ is identified with $sigma_2 + 2 pi$.#footnote[The length of the period is arbitrary. Any value besides $2 pi$ could have been chosen. $2 pi$ is simplest when parametrizing the embedding into three-dimensional space via sine and cosine.] The following series of diagrams illustrates how the periodicity $(sigma_1, sigma_2) hateq (sigma_1, sigma_2) + 2 pi (m, n)$, $m, n in ZZ$ describes a torus.
  #align(center, plane-to-torus)
  We start from an arbitrary line element $dif s^2 = h_(a b) dif sigma^a dif sigma^b$, $a, b in {1, 2}$ with a general worldsheet metric $h_(a b) (sigma_1, sigma_2)$. In exercise 2.d) on assignment 2, we had calculated the Ricci scalar's behavior under a Weyl transformation $h_(a b) -> e^(omega(sigma_1, sigma_2)) h_(a b)$ to be
  $ cR[e^omega h_(a b)] = e^(-omega) [cR - nabla^2 omega]. $
  We can therefore find a suitable Weyl transformation $e^(omega(sigma_1, sigma_2))$ that makes the Ricci scalar vanish locally. Recalling further our result that due to its many symmetries, the Riemann tensor in two dimensions has just one degree of freedom given by
  $ R_(a b c d) = 1/2 (h_(a c) h_(b d) - h_(a d) h_(b c)) cR, $
  this automatically implies $R_(a b c d) = 0 thick forall a, b, c, d in {sigma_1, sigma_2}$. Hence in two dimensions, regardless of topology, we can always stretch and bend space such that in a neighborhood around any given point $(sigma_1, sigma_2)$ on the worldsheet, it is flat. Globally, however, there is a topological obstruction: by the Gauss-Bonnet theorem, a globally flat metric requires vanishing Euler characteristic $chi$. The torus is special in this regard because $chi = 0$. To see this, note that the Euler characteristic $chi = 1/(4 pi) integral_Sigma dif^2 sigma sqrt(h) cR$ of a closed surface $Sigma$ with $partial Sigma = 0$ fulfills the variational identity#footnote[Incidentally, this is how the vacuum Einstein equations are derived from the action principle.]
  $ delta chi = 1/(4 pi) delta (integral_Sigma dif^2 sigma sqrt(h) cR) = 1/(4 pi) integral_Sigma dif^2 sigma sqrt(h) delta h^(a b) (R_(a b) - 1/2 cR h_(a b)) = 0, $
  where $h = det(h)$ and the Einstein tensor vanishes identically in two dimensions (exercise 2.c) on assignment 2). From this it follows that the Euler characteristic $chi$ is a topological invariant, i.e. remains unchanged under continuous variations of the metric. We can thus reshape the metric into unit form, $h_(a b) = delta_(a b)$ to explicitly calculate $chi$ on $bb(T)^2$:
  $ chi_(bb(T)^2) = 1/(4 pi) integral_(bb(T)^2) dif^2 sigma sqrt(h) cR limits(=)^(h_(a b) = delta_(a b)) 1/(4 pi) integral_0^(2 pi) integral_0^(2 pi) cR dif sigma_1 dif sigma_2 = 0. $
  Hence, on the two-torus, our usual procedure of fixing the gauge by fixing the metric to that of flat space can even be carried out globally. It is then a simple matter to find a diffeomorphism of the form
  $ bb(1) = bM bh bM^"T" $
  with $M^a zws_b = (partial sigma^a)/(partial xi^b)$, where the new coordinates $xi_1$, $xi_2$ are such that the metric again assumes unit form. The line element for a unit metric expressed i.t.o. complex coordinates $z = sigma_1 + i sigma_2$, $zb = sigma_1 - i sigma_2$ reads $dif s^2 = dif z dif zb$. Of course, there is no reason to assume that the new coordinates should still fulfill the original periodicity. Instead, $(sigma_1, sigma_2) hateq (sigma_1, sigma_2) + 2 pi (m, n)$, transforms under diffeomorphisms as
  $ xi_a hateq xi_a + 2 pi (m u_a + n v_a), #h(3em) a in {1, 2}, $
  with worldsheet translations $u_a$, $v_a$. This means the equivalent values of $xi_a$ form a lattice spanned by $u_a$ and $v_a$. By rotating and rescaling the coordinate system, accompanied by a shift in $omega$ to keep the metric normalized, we can achieve $bu = (1, 0)$.
  #lattice-rotation
  This leaves just two unfixed parameters between both the periodicity and the metric of the torus, namely the components of $bv$. Defining $tau = v_1 + i v_2$, the periodicity becomes
  $ z hateq z + 2 pi (m + n tau). $
  To reproduce the original periodicity $(sigma_1, sigma_2) hateq (sigma_1, sigma_2) + 2 pi (m, n)$, we can absorb $tau$ into the complex coordinate $z = sigma_1 + tau sigma_2$ so that the line element becomes
  $ dif s^2 = dif z dif zb = |dif sigma_1 + tau dif sigma_2|^2. $
  #note[Tori that have different values for the Teichmüller parameter $tau$ cannot in general be mapped into each other using a combination of diffeomorphisms and Weyl rescalings. Hence, there is a one-parameter family of conformally inequivalent tori. The integral over all metrics in the Polyakov path integral can be reduced to an integral over the single parameter $tau$ by appropriate gauge fixing, but this final integral remains and has to be done by hand.]
#block(inset: (left: 1.2em))[b), c) #h(0.5em) See part a).]
#set enum(start: 4)
+ Acting with $S$ on the r.h.s. of eq. @eq:z-periodicity yields
  $ z + 2 pi (m + n tau) limits(-->)^S z + 2 pi [m + n(tau + 1)] = z + 2 pi [(m + n) + n tau]. $
  Thus $S(m, n) = (m + n, n)$ establishes a one-to-one mapping from $ZZ^2$ to $ZZ^2$ and generates an equivalent set of identifications of points on the plane. What this means is that every $tau$ differing from any other one by only an integer introduces redundancy, i.e. gauge freedom, into our description. We will find a way to remove it in part e) by restricting $tau$ to a certain region of the $tau$-plane that contains only inequivalent values for the modulus.

  Moving on, $T$ does not leave the lattice invariant all on its own, but when combined with a rescaling $z -> tau z$:
  $ z + 2 pi (m + n tau) limits(-->)^T z + 2 pi (m - n/tau) limits(-->)^(z -> tau z) tau [z + 2 pi (m - n/tau)] = tau z + 2 pi (-n + tau m). $
  Hence $T(m, n) = (-n, m)$ together with $z -> tau z$ which leaves the theory invariant due its conformal symmetry also generates an equivalent lattice.

  By the same arguments, combining $U$ and $z -> (tau + 1) z$
  $
    z + 2 pi (m + n tau) & limits(-->)^U z + 2 pi (m + (n tau)/(tau + 1)) limits(-->)^(z -> (tau + 1) z) (tau + 1) z + 2 pi ((tau + 1) m + n tau) \
    & = (tau + 1) z + 2 pi (m + (m + n) tau)
  $
  reveals that $U(m, n) = (m, m + n)$ and $z -> (tau + 1) z$ combine to give a redundant lattice.

  It is now easy to see that repeated applications of $S$, $T$ (as mentioned above, we don't need $U$ for this) reproduce an $S L(2, ZZ)$ transformation of the form @eq:sl2z. Without any particular order, we start with $p in ZZ$#footnote[Naturally, $S^p$ with $p < 0$ denotes $p$ applications of the inverse of $S$, i.e. $S^(-1) : tau -> tau - 1$.] applications of $S$,
  $ tau limits(-->)^(S^p) tau + p, $
  followed by an application of $T$
  $ tau limits(-->)^(T S^p) (-1)/tau + p = (p tau - 1)/tau. $
  Repeating the whole procedure, this time with $q in ZZ$ applications of $S$ instead of $p$, we get
  $ tau limits(-->)^(T S^q T S^p) (p (q tau - 1)/tau - 1)/((q tau - 1)/tau) = (p(q tau - 1) - tau)/(q tau - 1) = ((p q - 1) tau - p)/(q tau - 1). $
  To introduce a third parameter, we apply $S$ another $r in ZZ$ times:
  $ tau limits(-->)^(S^r T S^q T S^p) ((p q - 1) tau + (p q - 1) r - p)/(q tau + q r - 1). $
  Finally, the fourth parameter $s in ZZ$ comes from applying $S^s T$:
  $
    tau & limits(-->)^(T S^r T S^q T S^p) (-(p q - 1) 1/tau + (p q - 1) r - p)/(-q 1/tau + q r - 1) = (-(p q - 1) + [(p q - 1) r - p] tau)/(-q + (q r - 1) tau), \
    tau & limits(-->)^(S^s T S^r T S^q T S^p) ([(p q - 1) r - p] tau + [(p q - 1) r - p] s - (p q - 1))/((q r - 1) tau + (q r - 1) s - q).
  $
  Thus by identifying
  $
    a & = (p q - 1) r - p, #h(3em) && b = [(p q - 1) r - p] s - (p q - 1), \
    c & = (q r - 1), && d = (q r - 1) s - q,
  $
  we find
  $ a d - b c = -q [(p q - 1) r - p] + (p q - 1)(q r - 1) = 1 $
  identically for all $p, q, r, s in ZZ$, as it must be since $S$ and $T$ both correspond to matrices of unit determinant. Hence repeated applications of $S$ and $T$ produce $S L(2, ZZ)$ transformations. That conversely every integer-valued $2 times 2$-matrix with unit determinant arises (up to an overall sign) from some sufficiently long word in $S$ and $T$, i.e. that they generate the full group, is the non-trivial statement mentioned in the note of the exercise.

  However, the group on the $tau$-plane, i.e. the _modular group_ of $tau$-transformations relating equivalent lattices is $S L(2, ZZ) \/ ZZ_2 = P S L(2, ZZ)$, because
  $ mat(a, b; c, d) limits(-->)^(ZZ_2) mat(-a, -b; -c, -d). $
  and the transformation remains unchanged if all signs of $a$, $b$, $c$, $d$ are reversed.
+ Starting with an arbitrary $tau in CC$, we can apply $T : tau -> -1/tau$ to map all $tau$ with $|tau| <= 1$ to the area $|tau| >= 1$. We can further map all $tau$ that lie outside $-1/2 <= "Re"(tau) <= 1/2$ to this strip by repeated application of $S : tau -> tau + 1$. Thus the fundamental domain $F_0$ is of the form of the lightly gray shaded area in the following illustration.
  #align(center, fundamental-domain)
  The edges $A$ and $A'$ are identified as are the parts $B$ and $B'$ of the red half circle.
  #note[An alternative fundamental region $F'_0$ that is obtained from $F_0$ by an application of $T$ is the dark gray area. Again, $B$ and $B'$ as well as $C$ and $C'$ are identified.]
