#import "/notes.typ": dd, notes, tagged, task
#import "@preview/cetz:0.5.2": canvas, decorations, draw

#show: notes.with(
  title: [Quantum Field Theory II -- Relevant Exercises],
  subtitle: [Exam preparation, Advanced QFT, Prof. Jürgen Berges],
  date: [Solutions by Janosh Riebesell, 05.07.2015],
)

// Feynman slash notation
#let fsl(x) = math.cancel(x, angle: 25deg, length: 110%)

// inline Feynman diagrams
#let fd(body, length: 0.5cm) = box(baseline: 40%, inset: (x: 1pt), canvas(length: length, {
  import draw: *
  set-style(stroke: 0.65pt)
  body
}))
#let ph(a, b) = decorations.wave(draw.line(a, b), amplitude: 0.13, segment-length: 0.3)
// fermion line with an arrow in the middle
#let fe(a, b) = {
  let m = ((a.at(0) + b.at(0)) / 2, (a.at(1) + b.at(1)) / 2)
  draw.line(a, m, mark: (end: ">", fill: black, scale: 0.6))
  draw.line(m, b)
}
#let hatch = tiling(size: (3pt, 3pt), line(start: (0%, 100%), end: (100%, 0%), stroke: 0.4pt))
#let blob(pt, r: 0.32, label: none) = {
  draw.circle(pt, radius: r, fill: if label == none { hatch } else { white })
  if label != none { draw.content(pt, text(size: 6pt, label)) }
}
#let cross(pt, d: 0.17) = {
  draw.line((pt.at(0) - d, pt.at(1) - d), (pt.at(0) + d, pt.at(1) + d), stroke: 0.9pt)
  draw.line((pt.at(0) - d, pt.at(1) + d), (pt.at(0) + d, pt.at(1) - d), stroke: 0.9pt)
}
#let otimes(pt, r: 0.28) = {
  draw.circle(pt, radius: r, fill: white)
  cross(pt, d: r * 0.7)
}
#let mom(a, b, label, dy: 0.38, dx: 0) = {
  draw.line(a, b, mark: (end: ">", fill: black, scale: 0.5), stroke: 0.45pt)
  draw.content(((a.at(0) + b.at(0)) / 2 + dx, (a.at(1) + b.at(1)) / 2 + dy), text(size: 7pt, label))
}
#let lab(pt, body) = draw.content(pt, text(size: 7pt, body))

#let sc(a, b) = draw.line(a, b, stroke: (thickness: 0.65pt, dash: "dashed"))
// leg of kind "f" (fermion), "p" (photon/gluon) or "s" (scalar) from the origin at the given angle
#let leg(kind, ang, len: 1.3) = {
  let e = (len * calc.cos(ang), len * calc.sin(ang))
  if kind == "p" { ph((0, 0), e) } else if kind == "s" { sc((0, 0), e) } else { draw.line((0, 0), e) }
}
// amplitude blob with external legs, e.g. nblob(("p", 180deg), ("p", 0deg))
#let nblob(..legs, center: "blob", tag: none) = fd({
  for (kind, ang) in legs.pos() { leg(kind, ang) }
  if center == "blob" { blob((0, 0)) } else if center == "otimes" { otimes((0, 0)) }
  if tag != none { lab((0, -0.75), tag) }
})
// fermion triangle with three photon legs; dir = 1 clockwise fermion flow, -1 anticlockwise
#let triangle(dir, labels) = fd({
  let r = 0.85
  draw.circle((0, 0), radius: r)
  for (ang, name, mo) in ((90deg, $mu, p_1$, (0, 2.2)), (210deg, $lambda, p_3$, (-2.1, -1.35)), (330deg, $nu, p_2$, (2.1, -1.35))) {
    let v = (r * calc.cos(ang), r * calc.sin(ang))
    ph(v, (v.at(0) + 1.1 * calc.cos(ang), v.at(1) + 1.1 * calc.sin(ang)))
    lab(mo, name)
    // incoming external momentum arrow beside the photon leg
    let n = if ang == 90deg { (0.3, 0) } else { (0.15 * calc.cos(ang) / calc.abs(calc.cos(ang)), 0.26) }
    let at(t) = ((r + t) * calc.cos(ang) + n.at(0), (r + t) * calc.sin(ang) + n.at(1))
    draw.line(at(0.95), at(0.4), mark: (end: ">", fill: black, scale: 0.5), stroke: 0.45pt)
  }
  for (i, ang) in (150deg, 30deg, 270deg).enumerate() {
    let p = (r * calc.cos(ang), r * calc.sin(ang))
    let t = (dir * calc.sin(ang) * 0.08, -dir * calc.cos(ang) * 0.08)
    draw.line((p.at(0) - t.at(0), p.at(1) - t.at(1)), (p.at(0) + t.at(0), p.at(1) + t.at(1)), mark: (end: ">", fill: black, scale: 0.6))
    let lp = (1.55 * r * calc.cos(ang), 1.45 * r * calc.sin(ang))
    lab(lp, labels.at(i))
  }
}, length: 0.55cm)

// scalar propagator with an insertion: blob, cross or nothing
#let sprop(kind: none, p: $p$) = fd({
  draw.line((0, 0), (2.4, 0))
  if kind == "blob" { blob((1.2, 0)) }
  if kind == "cross" { cross((1.2, 0)) }
  if kind == none { mom((0.8, 0.35), (1.6, 0.35), p) } else {
    mom((0.2, 0.35), (0.7, 0.35), p)
    mom((1.7, 0.35), (2.2, 0.35), p)
  }
})
// phi^4 tadpole correction to the propagator
#let tadpole-prop = fd({
  draw.line((0, 0), (3, 0))
  draw.circle((1.5, 0.55), radius: 0.55)
  draw.line((1.45, 1.1), (1.55, 1.1), mark: (end: ">", fill: black, scale: 0.5))
  lab((1.5, 0.55), $k$)
  mom((0.2, 0.35), (0.7, 0.35), $p$)
  mom((2.3, 0.35), (2.8, 0.35), $p$)
})
// 4-point function with a central insertion
#let four-point(kind: "vertex", labels: false) = fd({
  let c = (0, 0)
  for (x, y) in ((-1, -1), (1, -1), (-1, 1), (1, 1)) { draw.line(c, (x, y)) }
  if kind == "blob" { blob(c, r: 0.35) }
  if kind == "otimes" { otimes(c) }
  if labels {
    // momentum arrows: p_1, p_2 incoming, p_3, p_4 outgoing
    for (a, b) in (((-0.85, -0.85), (-0.55, -0.55)), ((0.85, -0.85), (0.55, -0.55)), ((-0.55, 0.55), (-0.85, 0.85)), ((0.55, 0.55), (0.85, 0.85))) {
      draw.line(a, b, mark: (end: ">", fill: black, scale: 0.5))
    }
    lab((-1.2, -0.75), $p_1$)
    lab((1.2, -0.75), $p_2$)
    lab((-1.2, 0.75), $p_3$)
    lab((1.2, 0.75), $p_4$)
  }
})
// one-loop "fish" diagrams in the s-, t- and u-channel
#let fish(channel) = fd({
  if channel == "s" {
    draw.circle((0, 0), radius: 0.6)
    for (a, b) in (((-0.6, 0), (-1.4, 0.7)), ((-0.6, 0), (-1.4, -0.7)), ((0.6, 0), (1.4, 0.7)), ((0.6, 0), (1.4, -0.7))) {
      draw.line(a, b)
    }
  } else if channel == "t" {
    draw.circle((0, 0), radius: 0.6)
    for (a, b) in (((0, 0.6), (-0.8, 1.2)), ((0, 0.6), (0.8, 1.2)), ((0, -0.6), (-0.8, -1.2)), ((0, -0.6), (0.8, -1.2))) {
      draw.line(a, b)
    }
  } else {
    draw.circle((0, 0), radius: 0.6)
    draw.line((0, 0.6), (-0.8, 1.2))
    draw.line((0, 0.6), (0.9, -1.2))
    draw.line((0, -0.6), (-0.8, -1.2))
    draw.line((0, -0.6), (0.9, 1.2))
  }
})

= Problem 7.1 (One-loop structure of $phi^4$ theory)

#task(label: "a")[Renormalization of the scalar propagator #sprop(kind: "blob") $= i/(p^2 - m^2 - M^2 (p^2))$ up to one-loop order.]

Renormalization condition:
$ #sprop(kind: "blob") |_(p^2 = m^2) = i/(p^2 - m^2). $
This requirement is equivalent to
$ "i)" M^2 (p^2)|_(p^2 = m^2) = 0, #h(4em) "ii)" dif/(dif p^2) M^2 (p^2)|_(p^2 = m^2) = 0. $
At one-loop order, #sprop(kind: "blob") receives contributions from
$
  #sprop(kind: "blob") |_"1-loop" & = #sprop() + #tadpole-prop + #sprop(kind: "cross") \
  & = i/(p^2 - m^2) + (-i lambda)/underbrace(2, "symmetry factor") integral (dd(4, k))/(2 pi)^4 i/(k^2 - m^2) + i (p^2 delta_Z - delta_m).
$
This follows from the Feynman rules obtained by splitting up the $lambda phi^4$ theory Lagrangian like so
$
  cal(L)_(lambda phi^4) & = 1/2 (partial phi_0)^2 - 1/2 m_0^2 phi_0^2 - lambda_0/4! phi_0^4 \
  & = 1/2 (partial phi)^2 - 1/2 m^2 phi^2 - lambda/4! phi^4 + 1/2 delta_Z (partial phi)^2 - 1/2 delta_m phi^2 - delta_lambda/4! phi^4,
$
where $phi = Z^(-1\/2) phi_0$, $delta_Z = Z - 1$, $delta_m = Z m_0^2 - m^2$, $delta_lambda = Z^2 lambda_0 - lambda$. We know that
$ -i M^2 (p^2)|_"1-loop" = #fd({ draw.line((0, 0), (2.4, 0)); blob((1.2, 0), r: 0.42, label: [1PI]) }) |_"1-loop" = #tadpole-prop + #sprop(kind: "cross"), $
thus i) and ii) imply
$
  dif/(dif p^2) M^2 (p^2)|_(p^2 = m^2) & = -delta_Z = 0, \
  M^2 (p^2)|_(p^2 = m^2) & = lambda/2 integral (dd(4, k))/(2 pi)^4 i/(k^2 - m^2) + delta_m = 0.
$
Thus to complete the renormalization of the propagator of $lambda phi^4$ theory at one-loop order, we simply need to calculate
$
  delta_m = -lambda/2 integral (dd(d, k))/(2 pi)^d i/(k^2 - m^2) & attach(=, t: k^0 -> i k_E^0) -lambda/2 integral (dd(d, k_E))/(2 pi)^d 1/(k_E^2 + m^2) = -lambda/2 integral (dif Omega_d)/(2 pi)^d integral dd(k_E) k_E^(d-1)/(k_E^2 + m^2),
$
where $integral dd(Omega_d) = (2 pi^(d\/2))/Gamma(d/2)$. We substitute $x = m^2/(k_E^2 + m^2)$, $dif x = -(2 m^2 k_E)/(k_E^2 + m^2)^2 dif k_E$, $k_E = m (1/x - 1)^(1\/2)$:
$
  delta_m & = -(2 pi^(d\/2) lambda)/(2 (2 pi)^d Gamma(d/2)) integral (-(k_E^2 + m^2)^2/(2 m^2 k_E) dif x) k_E^(d-1)/(k_E^2 + m^2) \
  & = lambda/(2 (4 pi)^(d\/2) Gamma(d/2)) integral dd(x) 1/x k_E^(d-2) = (m^(d-2) lambda)/(2 (4 pi)^(d\/2) Gamma(d/2)) integral dd(x) underbrace(1/x (1/x - 1)^(d/2 - 1), x^(-d\/2) (1 - x)^(d/2 - 1)) \
  & = (m^(d-2) lambda)/(2 (4 pi)^(d\/2) Gamma(d/2)) (Gamma(1 - d/2) Gamma(d/2))/Gamma(1 - d/2 + d/2) = (lambda m^(d-2))/(2 (4 pi)^(d\/2)) underbrace(Gamma(1 - d/2), Gamma(2 - d\/2)/(1 - d\/2)) \
  & = (lambda m^(2 - epsilon))/(2 (4 pi)^(2 - epsilon\/2)) Gamma(epsilon/2)/(-(1 - epsilon/2)) = -(lambda m^(2 - epsilon))/(2 (4 pi)^(2 - epsilon\/2)) (1 + epsilon/2 + cal(O)(epsilon^2)) (2/epsilon - gamma + cal(O)(epsilon)) \
  & stretch(->)^(epsilon -> 0) -(m^2 lambda)/(2 (4 pi)^2) (2/epsilon - gamma + 1) = -(m^2 lambda)/(32 pi^2) (2/epsilon - gamma + 1).
$
In the end, we found $M^2 (p^2) = 0 thick forall p$, at least to one-loop order. This is a surprising result and a specialty of $phi^4$ theory in $d = 4$ dimensions.

#task(label: "b")[Renormalization of the two-particle scattering amplitude at one loop.]

$
  i cal(M)(p_1 p_2 -> p_3 p_4) & = #four-point(kind: "blob", labels: true) = #four-point() + #fish("s") + #fish("t") + #fish("u") + #four-point(kind: "otimes") \
  & = -i lambda + (-i lambda)^2 (i V(s) + i V(t) + i V(u)) - i delta_lambda.
$
Our renormalization condition is
$ i cal(M)(p_1 p_2 -> p_3 p_4)|_(s = 4 m^2, t = u = 0) = #four-point(kind: "blob") |_(s = 4 m^2, t = u = 0) = -i lambda. $
This amounts to $delta_lambda = (-i lambda)^2 (V(4 m^2) + 2 V(0))$, so all we need to do here is calculate $V(p^2)$, whose structure is irrespective of whether the diagram is $s$-, $t$- or $u$-channel.
$
  #fd({
    draw.circle((0, 0), radius: 0.7)
    fe((-1.1, -1.3), (0, -0.7)); fe((1.1, -1.3), (0, -0.7))
    fe((0, 0.7), (-1.1, 1.3)); fe((0, 0.7), (1.1, 1.3))
    draw.line((-0.7, 0.05), (-0.7, -0.05), mark: (end: ">", fill: black, scale: 0.5))
    draw.line((0.7, -0.05), (0.7, 0.05), mark: (end: ">", fill: black, scale: 0.5))
    lab((-1.0, 0), $k$); lab((1.5, 0), $p + k$)
    mom((0, -1.75), (0, -1.15), $p$, dx: 0.25, dy: 0)
  }) & = 1/2 (-i lambda)^2 integral (dd(d, k))/(2 pi)^d i/(k^2 - m^2) i/((p + k)^2 - m^2) = (-i lambda)^2 i V(p^2), \
  V(p^2) & = i/2 integral (dd(d, k))/(2 pi)^d 1/(k^2 - m^2) 1/((p + k)^2 - m^2) = i/2 integral_0^1 dd(x) integral (dd(d, k))/(2 pi)^d 1/(x ((p + k)^2 - m^2) + (1 - x)(k^2 - m^2))^2,
$
$
  x ((p + k)^2 - m^2) + (1 - x)(k^2 - m^2) & = x p^2 + 2 x p k + x (k^2 - m^2) + k^2 - m^2 - x (k^2 - m^2) \
  & = k^2 + 2 x p k + x^2 p^2 - x^2 p^2 + x p^2 - m^2 = (underbrace(k + x p, l))^2 + underbrace(x (1 - x) p^2 - m^2, Delta^2),
$
$
  V(p^2) & = i/2 integral_0^1 dd(x) integral (dd(d, l))/(2 pi)^d 1/(l^2 + Delta^2)^2 = -1/2 integral_0^1 dd(x) integral (dd(d, l_E))/(2 pi)^d 1/(l_E^2 - Delta^2)^2 = -1/2 integral_0^1 dd(x) integral (dif Omega_d)/(2 pi)^d integral_0^oo dd(l_E) l_E^(d-1)/(l_E^2 - Delta^2)^2 \
  & = -1/2 integral_0^1 dd(x) (2 pi^(d\/2))/((2 pi)^d Gamma(d/2)) integral_1^0 (l_E^2 - Delta^2)^2/(-2 Delta^2 l_E) l_E^(d-1)/(l_E^2 - Delta^2)^2 dif z, quad z = Delta^2/(l_E^2 - Delta^2), thick l_E = Delta (1/z - 1)^(1\/2), thick dif z = (-2 Delta^2 l_E)/(l_E^2 - Delta^2)^2 dif l_E \
  & = -1/(2 (4 pi)^(d\/2) Gamma(d/2)) integral_0^1 dd(x) underbrace(integral_0^1 dd(z) z^(1 - d/2) (1 - z)^(d/2 - 1), Gamma(2 - d\/2) Gamma(d\/2) \/ Gamma(2 - d\/2 + d\/2)) Delta^(d-4) = -Gamma(2 - d/2)/(2 (4 pi)^(d\/2)) integral_0^1 dd(x) Delta^(d-4).
$
Using $Gamma(2 - d/2) = Gamma(epsilon/2) = 2/epsilon - gamma + cal(O)(epsilon)$, $X^(-epsilon\/2) = e^(ln X^(-epsilon\/2)) = e^(-epsilon/2 ln X) = 1 - epsilon/2 ln X + cal(O)(epsilon^2)$, we get
$
  V(p^2) & = -Gamma(epsilon/2)/(2 (4 pi)^2) (4 pi)^(epsilon\/2) integral_0^1 dd(x) (x (1 - x) p^2 - m^2)^(-epsilon\/2) \
  & = -1/(32 pi^2) (2/epsilon - gamma + cal(O)(epsilon)) (1 + epsilon/2 ln(4 pi) + cal(O)(epsilon^2)) integral_0^1 dd(x) [1 - epsilon/2 ln(x (1 - x) p^2 - m^2) + cal(O)(epsilon^2)] \
  & = -1/(32 pi^2) integral_0^1 dd(x) [2/epsilon - gamma + ln(4 pi) - ln(x (1 - x) p^2 - m^2) + cal(O)(epsilon)].
$
So the divergent counterterm $delta_lambda$ is given by
$ delta_lambda = (-i lambda)^2 (V(4 m^2) + 2 V(0)) = lambda^2/(32 pi^2) integral_0^1 dd(x) [6/epsilon - 3 gamma + 3 ln(4 pi) - ln(x (1 - x) 4 m^2 - m^2) - 2 ln(m^2)] $
and for the two-particle scattering amplitude, we obtain the lengthy but finite result of
$ i cal(M)(p_1 p_2 -> p_3 p_4) = -i lambda - (i lambda^2)/(32 pi^2) integral_0^1 dd(x) [ln((x (1 - x) s - m^2)/(x (1 - x) 4 m^2 - m^2)) + ln((x (1 - x) t - m^2)/m^2) + ln((x (1 - x) u - m^2)/m^2)]. $

= Problem 8.1 (Superficial degree of divergence)

Aim: derivation of the superficial degree of divergence $D$ of QED.

Notation:
- $E_(f\/gamma)$: number of external fermion/photon lines
- $P_(f\/gamma)$: number of internal fermion/photon lines (propagators)
- $V$: number of vertices
- $L$: number of loops

In $d = 4$ dimensions, every loop gives a four-momentum integral. Every fermionic/photonic propagator gives one/two inverse powers of momentum. Thus,
$ D = 4 L - P_f - 2 P_gamma. $
Every propagator connects to two vertices while every external line connects to one vertex, since we are concerned solely with fully connected amputated diagrams, i.e. no external lines simply going through and no propagators on external lines. Further, every vertex connects two fermionic lines to one photon, so
$ V = 1/2 (E_f + 2 P_f) = E_gamma + 2 P_gamma, $
and each propagator yields an integral over its undetermined momentum while every vertex gives a delta distribution, determining one momentum. Of these delta distributions, however, one is used up to assure overall momentum conservation. So the number of momentum integrals (equals number of loops) is
$ L = P_f + P_gamma - (V - 1) = P_f + P_gamma - V + 1. $
Putting everything together, we can construct an expression for $D$ which depends only on the external lines:
$
  D & = 4 L - P_f - 2 P_gamma = 4 P_f + 4 P_gamma - 4 V + 4 - P_f - 2 P_gamma \
  & = 4 + 3 P_f + 2 P_gamma - 3 V - V \
  & = 4 + 3 P_f + 2 P_gamma - 3/2 (E_f + 2 P_f) - E_gamma - 2 P_gamma \
  & = 4 - 3/2 E_f - E_gamma.
$

= Problem 8.2 (One-loop structure of QED)

#task(label: "a")[We are to give $D$ for the following seven amplitudes.]

#grid(
  columns: (auto, auto, auto),
  column-gutter: 1.5em,
  row-gutter: 0.9em,
  align: (left + horizon, center + horizon, left + horizon),
  [i) vacuum energy], nblob(), [$E_f = E_gamma = 0$, $D = 4$],
  [ii) photon propagator], nblob(("p", 180deg), ("p", 0deg)), [$E_f = 0$, $E_gamma = 2$, $D = 2$],
  [iii) electron propagator], nblob(("f", 180deg), ("f", 0deg)), [$E_f = 2$, $E_gamma = 0$, $D = 1$],
  [iv) electron-electron-photon vertex], nblob(("f", 150deg), ("f", 210deg), ("p", 0deg)), [$E_f = 2$, $E_gamma = 1$, $D = 0$],
  [v) 1-photon amplitude], nblob(("p", 180deg)), [$E_f = 0$, $E_gamma = 1$, $D = 3$],
  [vi) 3-photon amplitude], nblob(("p", 150deg), ("p", 210deg), ("p", 0deg)), [$E_f = 0$, $E_gamma = 3$, $D = 1$],
  [vii) 4-photon amplitude], nblob(("p", 150deg), ("p", 210deg), ("p", 30deg), ("p", -30deg)), [$E_f = 0$, $E_gamma = 4$, $D = 0$],
)

#task(label: "b")[Aim: Show that the one-loop photon one-point function vanishes by the discrete symmetry under charge conjugation.]

The only way for an external photon to enter a diagram is via a QED vertex, so we may 'drag' that out of #fd({ blob((0, 0)) }) and write
$
  #fd({ ph((0, 0), (2, 0)); blob((0, 0)); mom((1.4, -0.35), (0.8, -0.35), $q$, dy: -0.3); lab((2.3, 0.1), $mu$) }) = #fd({
    draw.line((0, 0), (1, -0.25)); draw.line((0, 0), (1, 0.25)); ph((1, 0), (2.6, 0)); blob((0, 0))
    mom((2.2, -0.35), (1.6, -0.35), $q$, dy: -0.3); lab((2.9, 0.1), $mu$)
  }) = -i e integral dd(4, x) e^(-i q x) chevron.l Omega | T j^mu (x) | Omega chevron.r,
$
with $j^mu (x) = overline(Psi)(x) gamma^mu Psi(x)$. Since $hat(C)$ is a symmetry of QED, i.e. $hat(C) |Omega chevron.r = |Omega chevron.r$, but changes the sign of any current $j^mu (x)$, the amplitude must be zero:
$
  chevron.l Omega | T j^mu (x) | Omega chevron.r & = chevron.l Omega | underbrace(hat(C)^2, bb(1)) T j^mu (x) underbrace(hat(C)^2, bb(1)) | Omega chevron.r = chevron.l Omega | hat(C) T underbrace(hat(C) j^mu (x) hat(C), -j^mu (x)) hat(C) | Omega chevron.r \
  & = -chevron.l Omega | T j^mu (x) | Omega chevron.r = 0.
$

Aim: Show that the two diagrams contributing to the photon three-point function at one-loop order cancel.

The contributions to $Gamma^((3))$ at one-loop order are given by fermionic loops that differ only in their direction of momentum flow. Using the fermion propagator $S_F (k) = i/(fsl(k) - m)$, we write
$
  Gamma^((3))|_"1-loop" & = #triangle(1, ($k$, $k + p_1$, $k + p_1 + p_2$)) + #triangle(-1, ($-k$, $-k - p_1$, $-k - p_1 - p_2$)) \
  & = (-i e)^3 integral (dd(4, k))/(2 pi)^4 [-tr(S_F (k) gamma^mu S_F (k + p_1) gamma^nu S_F (k + p_1 + p_2) gamma^lambda) \
    & #h(8em) - tr(S_F (-k) gamma^mu S_F (-k - p_1) gamma^nu S_F (-k - p_1 - p_2) gamma^lambda)].
$
The only thing in a fermionic propagator $S_F (k)$ affected by charge conjugation is the $gamma$-matrix. By requiring that charge conjugation of the Dirac equation for a field $Psi$ with charge $e$ gives the Dirac equation for a field $Psi^c$ with charge $-e$, we obtain the condition $hat(C) gamma^mu hat(C) = -(gamma^mu)^T$. Thus
$ hat(C) S_F (-k) hat(C) = hat(C) i/(-fsl(k) - m) hat(C) = hat(C) (i (-fsl(k) + m))/(k^2 - m^2) hat(C) = (i ((gamma^mu)^T k_mu + m))/(k^2 - m^2) = (i (fsl(k)^T + m))/(k^2 - m^2) = S_F^T (k). $
Applying this to $i Gamma^((3))|_"1-loop"$, we find
$
  i Gamma^((3))|_"1-loop" & = (-i e)^3 integral (dd(4, k))/(2 pi)^4 [-tr(S_F (k) gamma^mu S_F (k + p_1) gamma^nu S_F (k + p_1 + p_2) gamma^lambda) \
    & #h(8em) - tr(hat(C)^2 S_F (-k) hat(C)^2 gamma^mu hat(C)^2 S_F (-k - p_1) hat(C)^2 gamma^nu hat(C)^2 S_F (-k - p_1 - p_2) hat(C)^2 gamma^lambda)] \
  & = (-i e)^3 integral (dd(4, k))/(2 pi)^4 [-tr(S_F (k) gamma^mu S_F (k + p_1) gamma^nu S_F (k + p_1 + p_2) gamma^lambda) \
    & #h(8em) + tr(S_F^T (k) (gamma^mu)^T S_F^T (k + p_1) (gamma^nu)^T S_F^T (k + p_1 + p_2) (gamma^lambda)^T)] = 0.
$

Aim: Show that the diagrams contributing to any $n$-point photon amplitude, for $n$ odd, cancel in pairs.

Obviously, we may employ the above scheme for any fermionic loop with an odd number of vertices.

= Problem 9.1 (Renormalization of Yukawa theory)

#task[
  $ cal(L)_Y = 1/2 (partial phi_0)^2 - 1/2 m_0^2 phi_0^2 + overline(Psi)_0 (i fsl(partial) - M_0) Psi_0 - i g_0 phi_0 overline(Psi)_0 gamma^5 Psi_0 $
  is invariant under parity $Psi(t, arrow(x)) -> gamma^0 Psi(t, -arrow(x))$ and $phi(t, arrow(x)) -> -phi(t, -arrow(x))$.
]

#task(label: "a")[Determine the superficially divergent amplitudes and work out the Feynman rules for renormalized perturbation theory.]

The superficial degree of divergence is the same as that of QED since the Lagrangian has the same structure; we only need to replace the gauge field $A_mu$ with the scalar field $phi$:
$
  mat(delim: #(none, "}"), align: #left, D = 4 L - P_f - 2 P_phi; L = P_f + P_phi - V + 1; V = 1/2 (E_f + 2 P_f) = E_phi + 2 P_phi) quad ==> quad D = 4 - 3/2 E_f - E_phi.
$
Superficially divergent amplitudes are those with $D >= 0$:
#align(center, grid(
  columns: 6,
  column-gutter: (0.6em, 2.5em, 0.6em, 2.5em, 0.6em),
  row-gutter: 0.8em,
  align: horizon,
  nblob(), [$D = 4$], nblob(("s", 0deg), ("s", 150deg), ("s", 210deg)), [$D = 1$], nblob(("s", 150deg), ("s", 210deg), ("s", 30deg), ("s", -30deg)), [$D = 0$],
  nblob(("s", 0deg)), [$D = 3$], nblob(("f", 180deg), ("f", 0deg)), [$D = 1$], nblob(("f", 150deg), ("f", 210deg), ("s", 0deg)), [$D = 0$],
  nblob(("s", 180deg), ("s", 0deg)), [$D = 2$], [], [], [], [],
))
To obtain the Feynman rules, we split up $cal(L) = cal(L)_Y + delta cal(L)$, $delta cal(L) = -lambda_0/4! phi_0^4$,
$
  cal(L) & = 1/2 (partial phi)^2 - 1/2 m^2 phi^2 + overline(Psi) (i fsl(partial) - M) Psi - i g phi overline(Psi) gamma^5 Psi - lambda/4! phi^4 \
  & quad + 1/2 delta_phi (partial phi)^2 - 1/2 delta_m phi^2 + overline(Psi) (i delta_Psi fsl(partial) - delta_M) Psi - i delta_g phi overline(Psi) gamma^5 Psi - delta_lambda/4! phi^4
$
into renormalized fields, $phi = Z_phi^(-1\/2) phi_0$, and parameters $m$, $M$, $g$, and the counterterms,
$ delta_phi = Z_phi - 1, quad delta_m = m_0 Z - m, quad delta_Psi = Z_Psi - 1, quad delta_M = M_0 Z - M, quad delta_g = g Z_phi^(1\/2) Z_Psi, quad delta_lambda = lambda_0 Z^2 - lambda: $
#align(center, grid(
  columns: 3,
  column-gutter: 1em,
  row-gutter: 0.9em,
  align: (right + horizon, center + horizon, left + horizon),
  $1/2 (partial phi)^2 - 1/2 m^2 phi^2 hat(=)$, fd({ sc((0, 0), (2.4, 0)); mom((0.9, -0.35), (1.5, -0.35), $k$, dy: -0.3) }), $= i/(k^2 - m^2)$,
  $overline(Psi) (i fsl(partial) - M) Psi hat(=)$, fd({ fe((0, 0), (2.4, 0)); lab((1.2, -0.4), $p$) }), $= i/(fsl(p) - M) = (i (fsl(p) + M))/(p^2 - M^2)$,
  $-i g phi overline(Psi) gamma^5 Psi hat(=)$, fd({ draw.line((-1.1, 0.7), (0, 0)); draw.line((0, 0), (-1.1, -0.7)); sc((0, 0), (1.4, 0)) }), $= g gamma^5,$,
  $-lambda/4! phi^4 hat(=)$, fd({ sc((-0.8, -0.6), (0.8, 0.6)); sc((-0.8, 0.6), (0.8, -0.6)) }), $= -i lambda$,
  $1/2 delta_phi (partial phi)^2 - 1/2 delta_m phi^2 hat(=)$, fd({ sc((0, 0), (2.4, 0)); cross((1.2, 0)) }), $= i (p^2 delta_phi - delta_m)$,
  $overline(Psi) (i delta_Psi fsl(partial) - delta_M) Psi hat(=)$, fd({ draw.line((0, 0), (2.4, 0)); cross((1.2, 0)) }), $= i (fsl(p) delta_Psi - delta_M)$,
  $-i delta_g phi overline(Psi) gamma^5 Psi hat(=)$, fd({ draw.line((-1.1, 0.7), (0, 0)); draw.line((0, 0), (-1.1, -0.7)); sc((0, 0), (1.4, 0)); otimes((0, 0)) }), $= delta_g gamma^5$,
  $-delta_lambda/4! phi^4 hat(=)$, fd({ sc((-0.8, -0.6), (0.8, 0.6)); sc((-0.8, 0.6), (0.8, -0.6)); otimes((0, 0)) }), $= -i delta_lambda$,
))

#task(label: "b")[Aim: compute the divergent part of each counterterm to one-loop order.]

- #nblob() no computation necessary, can be trivially absorbed into the vacuum energy constant $V_0$ in the Lagrangian.
- #nblob(("s", 0deg)) $= 0$ by parity invariance of the Lagrangian.

#let scalar-tadpole = fd({
  sc((0, 0), (3, 0))
  draw.circle((1.5, 0.55), radius: 0.55, stroke: (thickness: 0.65pt, dash: "dashed"))
  draw.line((1.55, 1.1), (1.45, 1.1), mark: (end: ">", fill: black, scale: 0.5))
  lab((1.5, 1.4), $k$)
})
#let fermion-bubble(top: $p + k$, bottom: $k$) = fd({
  sc((0, 0), (1, 0))
  sc((2.6, 0), (3.6, 0))
  draw.circle((1.8, 0), radius: 0.8)
  draw.line((1.75, 0.8), (1.85, 0.8), mark: (end: ">", fill: black, scale: 0.6))
  draw.line((1.85, -0.8), (1.75, -0.8), mark: (end: ">", fill: black, scale: 0.6))
  lab((1.8, 1.15), top)
  lab((1.8, -1.15), bottom)
  lab((0.3, 0.3), $p$)
  lab((3.3, 0.3), $p$)
})
$
  #fd({ sc((0, 0), (2.4, 0)); blob((1.2, 0)) }) |_"1-loop" & = #fd({ sc((0, 0), (2.4, 0)) }) + #scalar-tadpole + #fermion-bubble() + #fd({ sc((0, 0), (2.4, 0)); cross((1.2, 0)) }) \
  & = #fd({ sc((0, 0), (2.4, 0)) }) + overbrace(i M^2 (p^2)|_"1-loop", = 0 "at" p^2 = m^2),
$
$
  #scalar-tadpole & = -i/2 lambda integral (dd(4, k))/(2 pi)^4 i/(k^2 - m^2) = -(i m^2 lambda)/(32 pi^2) (2/epsilon - gamma + 1 + ln(4 pi)), \
  #fermion-bubble() & = -g^2 integral (dd(4, k))/(2 pi)^4 tr(gamma^5 (fsl(k) + M) gamma^5 (fsl(k) + fsl(p) + M))/((k^2 - M^2)((k + p)^2 - M^2)),
$
$ tr(gamma^5 (fsl(k) + M) gamma^5 (fsl(k) + fsl(p) + M)) = tr(-fsl(k)^2 - fsl(k) fsl(p) + fsl(p) M + M^2) = 4 (M^2 - k^2 - k dot p). $
For the denominator, we use a Feynman parametrization,
$
  (k^2 - M^2)^(-1) ((k + p)^2 - M^2)^(-1) & = integral_0^1 dd(x) 1/[x ((k + p)^2 - M^2) + (1 - x)(k^2 - M^2)]^2, \
  x ((k + p)^2 - M^2) + (1 - x)(k^2 - M^2) & = x p^2 + 2 x k p + k^2 - M^2 = (underbrace(k + x p, l))^2 underbrace(- x (1 - x) p^2 - M^2, -Delta),
$
$
  #fermion-bubble(top: $k$, bottom: $p + k$) & = 4 g^2 integral (dd(d, k))/(2 pi)^d integral_0^1 dd(x) (k^2 - M^2 + k p)/(l^2 - Delta)^2 = 4 g^2 integral (dd(d, l))/(2 pi)^d integral_0^1 dd(x) (l^2 - overbrace(2 x l p, 0) + x^2 p^2 - M^2 + overbrace(l p, 0) - x p^2)/(l^2 - Delta)^2 \
  & = 4 g^2 integral (dd(d, l))/(2 pi)^d integral_0^1 dd(x) (l^2 - x (1 - x) p^2 - M^2)/(l^2 - Delta)^2.
$
Using the formulae of dimensional regularization,
$
  integral (dd(d, l))/(2 pi)^d 1/(l^2 - Delta)^n & = (i (-1)^n)/(4 pi)^(d\/2) Gamma(n - d/2)/Gamma(n) Delta^(d/2 - n), \
  integral (dd(d, l))/(2 pi)^d l^2/(l^2 - Delta)^n & = (i (-1)^(n-1))/(4 pi)^(d\/2) Gamma(n - d/2 - 1)/Gamma(n) Delta^(1 + d/2 - n),
$
we get
$
  #fermion-bubble(top: $k$, bottom: $p + k$) & = 4 g^2 integral_0^1 dd(x) ((-i Gamma(1 - d/2))/(4 pi)^(d\/2) Delta^(d/2 - 1) - (i Gamma(2 - d/2))/(4 pi)^(d\/2) Delta^(d/2 - 2) (x (1 - x) p^2 + M^2)) \
  & = -(4 i g^2)/(4 pi)^(d\/2) integral_0^1 dd(x) Gamma(underbrace(2 - d/2, epsilon\/2)) underbrace((1 - 1/(1 - epsilon\/2)), epsilon\/2 + cal(O)(epsilon^2)) Delta^(d/2 - 1) \
  & = -(4 i g^2)/(16 pi^2) (4 pi)^(epsilon\/2) (2/epsilon - gamma + cal(O)(epsilon)) (epsilon/2 + cal(O)(epsilon^2)) integral_0^1 dd(x) (x (1 - x) p^2 + M^2)^(1 - epsilon\/2) \
  & = -(i g^2)/(4 pi^2) (1 + epsilon/2 ln(4 pi) + cal(O)(epsilon^2)) (2/epsilon - gamma + 1 + cal(O)(epsilon)) integral_0^1 dd(x) [x (1 - x) p^2 + M^2] [1 - epsilon/2 (x (1 - x) p^2 + M^2) + cal(O)(epsilon^2)] \
  & = -(i g^2)/(4 pi^2) (2/epsilon - gamma + 1 + ln(4 pi) + cal(O)(epsilon)) integral_0^1 dd(x) [x (1 - x) p^2 + M^2 - epsilon/2 (x (1 - x) p^2 + M^2)^2 + cal(O)(epsilon^2)] \
  & = -(i g^2)/(4 pi^2) (2/epsilon - gamma + 1 + ln(4 pi)) [p^2/6 + M^2 - epsilon/2 (p^4/30 + p^2/3 M^2 + M^4) + cal(O)(epsilon^2)] \
  & = -(i g^2)/(4 pi^2) [(2/epsilon - gamma + 1 + ln(4 pi)) (p^2/6 + M^2) - (p^4/30 + p^2/3 M^2 + M^4)].
$

= Problem 10.1 (One-loop $beta$-function in QED)

#task(label: "a")[Aim: compute the one-loop $beta$-function in QED.]

$
  beta_e (mu) & = mu partial/(partial mu) (-e delta_1 + e delta_2 + 1/2 e delta_3), \
  delta_1 & = -e^2/(4 pi)^(d\/2) integral_0^1 dd(z) (1 - z) [Gamma(2 - d/2)/[(1 - z)^2 m^2 + z M^2]^(2 - d\/2) (2 - epsilon)^2/2 \
    & #h(9em) + Gamma(3 - d/2)/[(1 - z)^2 m^2 + z M^2]^(3 - d\/2) (2 (1 - 4 z + z^2) - epsilon (1 - z)^2) m^2], \
  delta_2 & = -e^2/(4 pi)^(d\/2) integral_0^1 dd(z) Gamma(2 - d/2)/[(1 - z)^2 m^2 + z M^2]^(2 - d\/2) [(2 - epsilon) z - epsilon/2 (2 z (1 - z) m^2)/((1 - z)^2 m^2 + z M^2) (4 - 2 z - epsilon (1 - z))], \
  delta_3 & = -e^2/(4 pi)^(d\/2) integral_0^1 dd(z) Gamma(2 - d/2)/(m^2)^(2 - d\/2) (8 z (1 - z)),
$
where $M$ is an IR cutoff and $m$ is the electron mass, playing the role of the renormalization scale $mu$. Since $M$ is just an IR cutoff and QED is well-defined in the IR, we can, right from the outset, set it to zero. Thus
$
  m (partial delta_1)/(partial m) & = m partial/(partial m) [-e^2/(4 pi)^(d\/2) integral_0^1 dd(z) (1 - z) [Gamma(epsilon/2)/((1 - z) m)^epsilon (2 - epsilon)^2/2 + Gamma(1 + epsilon/2)/((1 - z)^(2 + epsilon) m^epsilon) (2 (1 - 4 z + z^2) - epsilon (1 - z)^2)]] \
  & = (epsilon e^2)/((4 pi)^(d\/2) m^epsilon) integral_0^1 dd(z) [(2/epsilon - gamma + cal(O)(epsilon))/(2 (1 - z)^(epsilon - 1)) (4 - 4 epsilon + epsilon^2) + (epsilon/2 (2/epsilon - gamma + cal(O)(epsilon)))/(1 - z)^(1 + epsilon) (2 (1 - 4 z + z^2) - epsilon (1 - z)^2)] \
  & stretch(->)^(epsilon -> 0) e^2/(4 pi)^2 integral_0^1 dd(z) 4 (1 - z) = e^2/(8 pi^2), \
  m (partial delta_2)/(partial m) & = m partial/(partial m) (-e^2/(4 pi)^(d\/2) integral_0^1 dd(z) Gamma(epsilon/2)/((1 - z) m)^epsilon [(2 - epsilon) z - epsilon/2 2 z (4 - 2 z - epsilon (1 - z))]) \
  & = (epsilon e^2)/((4 pi)^(d\/2) m^epsilon) integral_0^1 dd(z) (2/epsilon - gamma + cal(O)(epsilon))/(1 - z)^epsilon [(2 - epsilon) z - epsilon (4 - 2 z - epsilon (1 - z))] \
  & stretch(->)^(epsilon -> 0) e^2/(4 pi)^2 integral_0^1 dd(z) 2 = e^2/(8 pi^2), \
  m (partial delta_3)/(partial m) & = m partial/(partial m) (-e^2/(4 pi)^(d\/2) integral_0^1 dd(z) Gamma(epsilon/2)/m^epsilon 8 z (1 - z)) = (epsilon e^2)/((4 pi)^(d\/2) m^epsilon) integral_0^1 dd(z) (2/epsilon - gamma + cal(O)(epsilon)) 8 z (1 - z) \
  & stretch(->)^(epsilon -> 0) e^2/(4 pi)^2 integral_0^1 dd(z) 16 z (1 - z) = e^2/(6 pi^2).
$
Inserting $delta_1$, $delta_2$, $delta_3$ into the one-loop $beta$-function of QED, we get
$ beta_e (m) = -e e^2/(8 pi^2) + e e^2/(8 pi^2) + 1/2 e e^2/(6 pi^2) = e^3/(12 pi^2). $

#task(label: "b")[Aim: Integrate the RG equation to find the running of the coupling.]

RG equation:
$ dif/(dif ln mu) e(mu) = beta_e (mu) = (e^3 (mu))/(12 pi^2) quad ==> quad 12 pi^2 (dif e(mu))/(e^3 (mu)) = dif ln mu, $
$
  integral_(mu^*)^mu 12 pi^2 (dif e(mu'))/(e^3 (mu')) & attach(=, t: (*)) integral_(mu^*)^mu 12 pi^2 (2 pi)/e(mu') dif alpha(mu') 1/(e^3 (mu')) = 3/2 pi integral_(mu^*)^mu (dif alpha(mu'))/(alpha^2 (mu')) = -3/2 pi (1/alpha(mu) - 1/underbrace(alpha(mu^*), =: alpha^*)) \
  & = integral_(mu^*)^mu dd(ln) mu' = ln(mu/mu^*) quad ==> quad 1/alpha(mu) - 1/alpha^* = -2/(3 pi) ln(mu/mu^*),
$
where in $(*)$ we substituted $alpha(mu) = e^2 (mu)\/(4 pi)$, $dif alpha(mu) = e(mu)\/(2 pi) dif e(mu)$.
$ alpha(mu) = 1/(1/alpha^* - 2/(3 pi) ln(mu/mu^*)) = alpha^* /(1 - (2 alpha^*)/(3 pi) ln(mu/mu^*)), quad "pole at" 1 = (2 alpha^*)/(3 pi) ln(mu/mu^*) ==> mu = mu^* e^((3 pi)/(2 alpha^*)). $
#align(center, canvas(length: 1cm, {
  import draw: *
  set-style(stroke: 0.7pt)
  line((-0.3, 0), (6, 0), mark: (end: ">", fill: black))
  line((0, -0.3), (0, 4), mark: (end: ">", fill: black))
  content((6.3, 0), $mu$)
  content((-0.6, 3.9), $alpha(mu)$)
  content((-0.25, -0.3), $0$)
  let pole = 4.5
  let pts = range(0, 89).map(i => {
    let x = i * 0.05
    (x, 0.6 / (pole - x) - 0.6 / pole)
  })
  line(..pts, stroke: 1pt)
  line((pole, 0), (pole, 4), stroke: (thickness: 0.5pt, dash: "dashed"))
  content((pole, -0.45), $mu^* e^((3 pi)/(2 alpha^*))$)
  content((5.8, 1.5), [Landau pole], name: "lp")
  line((5.4, 1.2), (pole + 0.1, 0.15), mark: (end: ">", fill: black, scale: 0.6), stroke: 0.5pt)
}))
$e(mu)$ ceases to be perturbative if it is of the order $e(mu) approx 1$, i.e.
$ 1/(4 pi) = 1/(1/alpha^* - 2/(3 pi) ln(mu/mu^*)) quad ==> quad ln(mu/mu^*) = (3 pi)/2 (1/alpha^* - 4 pi), quad mu = mu^* e^((3 pi)/2 (1/alpha^* - 4 pi)). $

= Problem 11.2 (Fermion-antifermion annihilation in Yang--Mills theory at tree level)

#task(label: "a")[Aim: Use the Feynman rules to compute the $t$- and $u$-channel of this process.]

#let tu-diagram(crossed: false) = fd({
  // fermion line: p2 in at the right, through the propagator, out as the antifermion p1 at the left
  fe((3.3, -1.1), (2.2, 0))
  fe((2.2, 0), (0, 0))
  fe((0, 0), (-1.1, -1.1))
  let (ga, gb) = if crossed { ((3.0, 1.4), (-0.8, 1.4)) } else { ((-0.8, 1.4), (3.0, 1.4)) }
  ph((0, 0), ga)
  ph((2.2, 0), gb)
  lab((-1.35, 1.6), $mu, a$)
  lab((3.5, 1.6), $nu, b$)
  lab((-1.3, -0.75), $p_1$)
  lab((3.5, -0.75), $p_2$)
  // momentum arrows: p_1, p_2 towards the vertices, k_1, k_2 out along the gluons, q along the propagator
  let arr(a, b) = draw.line(a, b, mark: (end: ">", fill: black, scale: 0.5), stroke: 0.45pt)
  arr((-0.86, -0.46), (-0.475, -0.075))
  arr((3.06, -0.46), (2.675, -0.075))
  if crossed {
    arr((1.5, -0.3), (0.7, -0.3))
    lab((1.1, -0.6), $q$)
    arr((0.27, 0.57), (-0.63, 0.99))
    lab((-0.3, 0.45), $k_1$)
    arr((1.93, 0.57), (2.83, 0.99))
    lab((2.5, 0.45), $k_2$)
  } else {
    arr((1.5, 0.3), (0.7, 0.3))
    lab((1.1, 0.6), $q$)
    arr((-0.54, 0.34), (-0.9, 0.97))
    lab((-1.1, 0.45), $k_1$)
    arr((2.74, 0.34), (3.1, 0.97))
    lab((3.3, 0.45), $k_2$)
  }
}, length: 0.55cm)
$
  i cal(M)_1^(a b) & = #tu-diagram() = overline(v)(p_1) (i g gamma^mu T^a) (i (fsl(q) + m))/(q^2 - m^2) (i g gamma^nu T^b) u(p_2) epsilon_mu^* (k_1) epsilon_nu^* (k_2), \
  i cal(M)_2^(a b) & = #tu-diagram(crossed: true) = overline(v)(p_1) (i g gamma^nu T^b) (i (fsl(q) + m))/(q^2 - m^2) (i g gamma^mu T^a) u(p_2) epsilon_mu^* (k_1) epsilon_nu^* (k_2),
$
where the internal fermion carries $q = -(p_1 - k_1) = p_2 - k_2$ in the first ($t$-channel) and $q = -(p_1 - k_2) = p_2 - k_1$ in the second ($u$-channel) diagram.
$
  i cal(M)_(1+2)^(a b) = i cal(M)_1^(a b) + i cal(M)_2^(a b) = -i (i g)^2 overline(v)(p_1) [& gamma^mu T^a (fsl(p)_1 - fsl(k)_1 - m)/((p_1 - k_1)^2 - m^2) T^b gamma^nu \
    & + gamma^nu T^b (fsl(p)_1 - fsl(k)_2 - m)/((p_1 - k_2)^2 - m^2) T^a gamma^mu] u(p_2) epsilon_mu^* (k_1) epsilon_nu^* (k_2).
$
If $epsilon_nu^* (k_2) = k_(2 nu)$, we may use the Dirac equation to intelligently add zero:
$
  fsl(k)_2 u(p_2) & = -(fsl(p)_2 - fsl(k)_2 - m) u(p_2) = (fsl(p)_1 - fsl(k)_1 + m) u(p_2), & "since" quad -(fsl(p)_2 - m) u(p_2) = 0, \
  overline(v)(p_1) fsl(k)_2 & = -overline(v)(p_1) (fsl(p)_1 - fsl(k)_2 + m), & "since" quad -overline(v)(p_1) (fsl(p)_1 + m) = 0.
$
Thus, for $epsilon_nu^* (k_2) = k_(2 nu)$, $i cal(M)_(1+2)^(a b)$ becomes
$
  i cal(M)_(1+2)^(a b) & = -i (i g)^2 overline(v)(p_1) [gamma^mu T^a (fsl(p)_1 - fsl(k)_1 - m)/((p_1 - k_1)^2 - m^2) T^b fsl(k)_2 + fsl(k)_2 T^b (fsl(p)_1 - fsl(k)_2 - m)/((p_1 - k_2)^2 - m^2) T^a gamma^mu] u(p_2) epsilon_mu^* (k_1) \
  & = -i (i g)^2 overline(v)(p_1) [gamma^mu T^a ((p_1 - k_1)^2 - m^2)/((p_1 - k_1)^2 - m^2) T^b - T^b ((p_1 - k_2)^2 - m^2)/((p_1 - k_2)^2 - m^2) T^a gamma^mu] u(p_2) epsilon_mu^* (k_1) \
  & = (i g)^2 overline(v)(p_1) [-i gamma^mu [T^a, T^b]] u(p_2) epsilon_mu^* (k_1).
$

#task(label: "b")[Aim: Use the Feynman rules to compute the $s$-channel.]

#let s-diagram = fd({
  fe((1.1, -2.6), (0, -1.6))
  fe((0, -1.6), (-1.1, -2.6))
  ph((0, -1.6), (0, 0))
  ph((0, 0), (-1.2, 1.1))
  ph((0, 0), (1.2, 1.1))
  lab((-1.5, 1.35), $mu, a$)
  lab((1.5, 1.35), $nu, b$)
  lab((-0.75, -0.8), $rho, c$)
  lab((2.1, -0.8), $k_3 = -(p_1 + p_2)$)
  lab((0, -2.1), $sigma$)
  lab((-1.35, -1.8), $p_1$)
  lab((1.35, -1.8), $p_2$)
  // momentum arrows: p_1, p_2 towards the vertex, k_3 down the propagator, k_1, k_2 out along the gluons
  let arr(a, b) = draw.line(a, b, mark: (end: ">", fill: black, scale: 0.5), stroke: 0.45pt)
  arr((-0.99, -2.17), (-0.5, -1.71))
  arr((0.99, -2.17), (0.5, -1.71))
  arr((0.32, -0.35), (0.32, -1.25))
  arr((-0.55, 0.12), (-1.09, 0.62))
  lab((-1.1, 0.05), $k_1$)
  arr((0.55, 0.12), (1.09, 0.62))
  lab((1.1, 0.05), $k_2$)
}, length: 0.55cm)
$
  i cal(M)_3^(a b) & = #s-diagram = overline(v)(p_1) (i g gamma^sigma T^c) u(p_2) (-i eta_(rho sigma))/k_3^2 g f^(a b c) [eta^(mu nu) (k_1 - k_2)^rho \
    & #h(12em) + eta^(nu rho) (k_2 - k_3)^mu + eta^(rho mu) (k_3 - k_1)^nu] epsilon_mu^* (k_1) epsilon_nu^* (k_2) \
  & = g^2 overline(v)(p_1) gamma_rho u(p_2) 1/k_3^2 f^(a b c) T^c [eta^(mu nu) (k_1 - k_2)^rho + eta^(nu rho) (k_2 - k_3)^mu + eta^(rho mu) (k_3 - k_1)^nu] epsilon_mu^* (k_1) epsilon_nu^* (k_2).
$
Again assuming longitudinal polarization, $epsilon_nu^* (k_2) = k_(2 nu)$, for one outgoing photon and transverse polarization, $epsilon_mu^* (k_1) k_1^mu = 0$, for the other, we get
$ i cal(M)_3^(a b) = g^2 overline(v)(p_1) gamma_rho u(p_2) 1/k_3^2 f^(a b c) T^c [k_2^mu (k_1 - k_2)^rho + k_2^rho (k_2 - k_3)^mu + eta^(mu rho) (k_3 - k_1) dot k_2] epsilon_mu^* (k_1), $
$
  & [k_2^mu (k_1 - k_2)^rho + k_2^rho (k_2 - k_3)^mu + eta^(mu rho) (k_3 - k_1) dot k_2] epsilon_mu^* (k_1) \
  & = [-(k_1 + k_3)^mu (2 k_1 + k_3)^rho + (k_1 + k_3)^rho (k_1 + 2 k_3)^mu - eta^(mu rho) (k_3 - k_1) dot (k_1 + k_3)] epsilon_mu^* (k_1) \
  & attach(=, t: k_2 = -k_1 - k_3) [-2 k_1^mu k_1^rho - cancel(k_1^mu k_3^rho) - cancel(2 k_1^rho k_3^mu) - k_3^mu k_3^rho + k_1^mu k_1^rho + cancel(2 k_1^rho k_3^mu) + cancel(k_1^mu k_3^rho) + 2 k_3^mu k_3^rho + eta^(mu rho) (underbrace(k_1^2, 0) - k_3^2)] epsilon_mu^* (k_1) \
  & = [-k_1^mu k_1^rho + k_3^mu k_3^rho - eta^(mu rho) k_3^2] epsilon_mu^* (k_1) = (k_3^mu k_3^rho - eta^(mu rho) k_3^2) epsilon_mu^* (k_1)
$
$
  ==> i cal(M)_3^(a b) & = g^2 overline(v)(p_1) gamma_rho u(p_2) 1/k_3^2 f^(a b c) T^c (k_3^mu k_3^rho - eta^(mu rho) k_3^2) epsilon_mu^* (k_1) \
  & = -g^2 overline(v)(p_1) gamma^mu u(p_2) f^(a b c) T^c epsilon_mu^* (k_1),
$
where the first term vanishes because
$
  overline(v)(p_1) gamma_rho u(p_2) k_3^rho & = overline(v)(p_1) fsl(k)_3 u(p_2) = overline(v)(p_1) (underbrace(fsl(k)_3 + fsl(p)_1, -fsl(p)_2) - fsl(p)_1 - m + m) u(p_2) \
  & = underbrace(overline(v)(p_1) (-fsl(p)_1 - m), 0) u(p_2) + overline(v)(p_1) underbrace((-fsl(p)_2 + m) u(p_2), 0) = 0.
$

#task(label: "c")[Aim: Compute $i cal(M)_3^(a b)$ for $epsilon_mu^* (k_1) = epsilon_mu^+ (k_1)$, $epsilon_nu^* (k_2) = epsilon_nu^- (k_2)$ with $epsilon^(plus.minus) (k) = 1/(sqrt(2) |arrow(k)|) (k^0, plus.minus arrow(k))$.]

In this setup, the polarization vector $epsilon_nu^* (k_2)$ is still longitudinal, just of different length than in part b). We may thus quote our result from b) as it was just before using that $epsilon_mu (k_1)$ is transverse:
$
  i cal(M)_3^(a b) & = g^2 overline(v)(p_1) gamma_rho u(p_2) 1/k_3^2 f^(a b c) T^c [-k_1^mu k_1^rho + k_3^mu k_3^rho - eta^(mu rho) k_3^2] 1/(sqrt(2) |arrow(k)_2|) epsilon_mu^+ (k_1) \
  & = 1/(sqrt(2) |arrow(k)_2|) i cal(M)_(3, "b)")^(a b)|_(epsilon_mu^* (k_1) = epsilon_mu^+ (k_1)) - g^2 overline(v)(p_1) gamma_rho u(p_2) 1/k_3^2 f^(a b c) T^c underbrace((k_1^mu k_1^rho)/(sqrt(2) |arrow(k)_2|) k_(1 mu)/(sqrt(2) |arrow(k)_1|), k_1^rho |arrow(k)_1| \/ |arrow(k)_2|", since" k_1^2 = 0),
$
where the $k_3^mu k_3^rho$-term again vanishes by the same argument and the $-eta^(mu rho) k_3^2$-term gives just a scaled version of the result of part b).
