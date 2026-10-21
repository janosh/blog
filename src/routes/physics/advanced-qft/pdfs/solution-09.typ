#import "/notes.typ": dd, notes, tagged, task
#import "@preview/cetz:0.5.2": canvas, draw

#show: notes.with(
  title: [Quantum Field Theory II -- Assignment 9],
  subtitle: [Exercise sheet 9, Advanced QFT, Prof. Jürgen Berges],
  date: [Solutions by Janosh Riebesell, 17.06.2015],
)

// Feynman slash
#let sl(body) = math.cancel(body, length: 90%, angle: 30deg)

// Feynman diagrams drawn inline in text and equations
#let diag(body, baseline: 45%, length: 1cm) = box(baseline: baseline, inset: (y: 2pt), canvas(length: length, {
  import draw: *
  set-style(stroke: 0.7pt)
  body
}))
#let dashed-stroke = (dash: "dashed", thickness: 0.7pt)
// scalar line
#let sline(a, b) = draw.line(a, b, stroke: dashed-stroke)
// fermion line with an arrow at its midpoint
#let fline(a, b) = {
  let m = ((a.at(0) + b.at(0)) / 2, (a.at(1) + b.at(1)) / 2)
  draw.line(a, m, mark: (end: ">", fill: black, scale: 0.5))
  draw.line(m, b)
}
// momentum arrow drawn next to a line
#let mom(a, b, label, anchor: "south") = {
  draw.line(a, b, mark: (end: ">", fill: black, scale: 0.4), stroke: 0.5pt)
  draw.content(((a.at(0) + b.at(0)) / 2, (a.at(1) + b.at(1)) / 2), text(size: 7pt, $#label$), anchor: anchor, padding: 2pt)
}
#let blob(c, r: 0.17) = draw.circle(c, radius: r, fill: luma(175))
#let vtx(c) = draw.circle(c, radius: 0.04, fill: black, stroke: none)
// counterterm vertex
#let ctvert(c, r: 0.11) = {
  draw.circle(c, radius: r, fill: white)
  let d = r * 0.707
  draw.line((c.at(0) - d, c.at(1) - d), (c.at(0) + d, c.at(1) + d))
  draw.line((c.at(0) - d, c.at(1) + d), (c.at(0) + d, c.at(1) - d))
}
// propagator counterterm insertion
#let xmark(c, s: 0.08) = {
  draw.line((c.at(0) - s, c.at(1) - s), (c.at(0) + s, c.at(1) + s), stroke: 0.9pt)
  draw.line((c.at(0) - s, c.at(1) + s), (c.at(0) + s, c.at(1) - s), stroke: 0.9pt)
}
// arc of a bubble between two points, bulging by h
#let arc2(a, b, h) = {
  let m = ((a.at(0) + b.at(0)) / 2, (a.at(1) + b.at(1)) / 2)
  let dx = b.at(0) - a.at(0)
  let dy = b.at(1) - a.at(1)
  draw.bezier(a, b, (m.at(0) - dy * h * 2, m.at(1) + dx * h * 2))
}
#let bubble(a, b, h: 0.45) = {
  arc2(a, b, h)
  arc2(a, b, -h)
}

// scalar self-energy pieces
#let sprop = diag(sline((0, 0), (1, 0)))
#let tadpole = diag({
  sline((0, 0), (1.3, 0))
  draw.circle((0.65, 0.3), radius: 0.3, stroke: dashed-stroke)
  vtx((0.65, 0))
}, baseline: 25%)
#let floop(labels: false) = diag({
  sline((-0.15, 0), (0.35, 0))
  sline((1.15, 0), (1.65, 0))
  draw.circle((0.75, 0), radius: 0.4)
  draw.mark((0.75, 0.4), (0.85, 0.4), symbol: ">", fill: black, scale: 0.5)
  draw.mark((0.75, -0.4), (0.65, -0.4), symbol: ">", fill: black, scale: 0.5)
  if labels {
    draw.content((0.75, 0.4), text(size: 7pt, $p + k$), anchor: "south", padding: 2pt)
    draw.content((0.75, -0.4), text(size: 7pt, $k$), anchor: "south", padding: 2pt)
    draw.content((0.05, 0), text(size: 7pt, $p$), anchor: "south", padding: 2pt)
    draw.content((1.45, 0), text(size: 7pt, $p$), anchor: "south", padding: 2pt)
  }
  vtx((0.35, 0))
  vtx((1.15, 0))
})
#let sct = diag({
  sline((0, 0), (1, 0))
  xmark((0.5, 0))
})
#let sblob = diag({
  sline((0, 0), (0.35, 0))
  sline((0.65, 0), (1, 0))
  blob((0.5, 0), r: 0.15)
})

// phi^4 four-point diagrams (solid lines)
#let legs(c, dir) = {
  // two external legs leaving vertex c towards the left (dir = -1) or right (dir = 1)
  draw.line(c, (c.at(0) + dir * 0.45, c.at(1) + 0.45))
  draw.line(c, (c.at(0) + dir * 0.45, c.at(1) - 0.45))
}
#let tree = diag(length: 0.85cm, {
  draw.line((-0.45, -0.45), (0.45, 0.45))
  draw.line((-0.45, 0.45), (0.45, -0.45))
  vtx((0, 0))
})
#let sbub(left: "v", right: "v") = diag(length: 0.85cm, {
  legs((0, 0), -1)
  legs((0.8, 0), 1)
  bubble((0, 0), (0.8, 0))
  for (c, k) in (((0, 0), left), ((0.8, 0), right)) {
    if k == "ct" { ctvert(c, r: 0.09) } else { vtx(c) }
  }
})
#let tbub = diag(length: 0.85cm, {
  bubble((0, 0.35), (0, -0.35), h: 0.4)
  draw.line((0, 0.35), (-0.5, 0.65))
  draw.line((0, 0.35), (0.5, 0.65))
  draw.line((0, -0.35), (-0.5, -0.65))
  draw.line((0, -0.35), (0.5, -0.65))
  vtx((0, 0.35))
  vtx((0, -0.35))
})
#let ubub = diag(length: 0.85cm, {
  bubble((0, 0.35), (0, -0.35), h: 0.4)
  draw.line((0, 0.35), (-0.5, 0.65))
  draw.line((0, 0.35), (0.55, -0.7))
  draw.line((0, -0.35), (-0.5, -0.65))
  draw.line((0, -0.35), (0.55, 0.7))
  vtx((0, 0.35))
  vtx((0, -0.35))
})
#let ct4(label) = diag(length: 0.85cm, {
  draw.line((-0.45, -0.45), (0.45, 0.45))
  draw.line((-0.45, 0.45), (0.45, -0.45))
  ctvert((0, 0), r: 0.12)
  draw.content((0.14, 0.14), text(size: 6.5pt, label), anchor: "south-west")
})
#let chain = diag(length: 0.85cm, {
  legs((0, 0), -1)
  legs((1.6, 0), 1)
  bubble((0, 0), (0.8, 0))
  bubble((0.8, 0), (1.6, 0))
  vtx((0, 0))
  vtx((0.8, 0))
  vtx((1.6, 0))
})
// two-loop diagram with a t-type bubble on one side of an s-channel loop
#let side(mirror: false) = diag(length: 0.85cm, {
  let s = if mirror { -1 } else { 1 }
  let a = (0, 0)
  let b = (s * 0.9, 0.4)
  let c = (s * 0.9, -0.4)
  legs(a, -s)
  draw.line(a, b)
  draw.line(a, c)
  bubble(b, c, h: 0.3)
  draw.line(b, (s * 1.35, 0.75))
  draw.line(c, (s * 1.35, -0.75))
  vtx(a)
  vtx(b)
  vtx(c)
})
#let ext4 = diag({
  blob((0, 0), r: 0.2)
  // incoming p_1, p_2 on the left, outgoing p_3, p_4 on the right
  for (x, y, l) in ((-1, 1, $p_1$), (1, 1, $p_3$), (-1, -1, $p_2$), (1, -1, $p_4$)) {
    draw.line((x * 0.14, y * 0.14), (x * 0.55, y * 0.55))
    draw.content((x * 0.55, y * 0.55), text(size: 7pt, l), anchor: if y > 0 { "south" } else { "north" })
    let (o, i) = ((x * 0.45 - x * 0.08, y * 0.45 + y * 0.08), (x * 0.22 - x * 0.08, y * 0.22 + y * 0.08))
    let (a, b) = if x < 0 { (o, i) } else { (i, o) }
    draw.line(a, b, mark: (end: ">", fill: black, scale: 0.4), stroke: 0.5pt)
  }
})
#let blob4 = diag({
  draw.line((-0.45, -0.45), (0.45, 0.45))
  draw.line((-0.45, 0.45), (0.45, -0.45))
  blob((0, 0), r: 0.17)
})
#let circled(n) = box(baseline: 20%, circle(radius: 5.5pt, inset: 0pt, stroke: 0.5pt, align(center + horizon, text(size: 7pt, [#n]))))

= Problem 9.1 (Renormalisation of Yukawa theory)

#task[
  Consider the pseudoscalar Yukawa Lagrangian
  $ cal(L)_"YT" = 1/2 (partial phi_0)^2 - 1/2 m_(0, phi)^2 phi_0^2 + overline(psi)_0 (i sl(partial) - m_(0, psi)) psi_0 - i g_0 phi_0 overline(psi)_0 gamma^5 psi_0, $
  where $phi_0$ is a real scalar field and $psi_0$ is a Dirac fermion. This Lagrangian is invariant under the parity transformation $psi(t, arrow(x)) -> gamma^0 psi(t, -arrow(x))$ and $phi(t, arrow(x)) -> -phi(t, -arrow(x))$.
]

#task(label: "a")[Determine the superficially divergent amplitudes and work out the Feynman rules for renormalized perturbation with this Lagrangian. Show that the theory contains a superficially divergent $4 phi$-amplitude.]

Since Yukawa theory differs from QED only to the extent that the gauge field $A^mu$ is replaced by the scalar field $phi$, Yukawa theory's superficial degree of divergence (SDD) $D$ may be obtained from QED's by the same substitution,
$ D_"QED"^(d = 4) = 4 - E_gamma - 3/2 E_psi quad ==> quad D_"YT"^(d = 4) = 4 - E_phi - 3/2 E_psi =: D. $
Since $E_phi$, $E_psi$ appear with a negative sign in $D$, we may conclude that Yukawa theory possesses only a finite number of superficially divergent amplitudes, seven to be precise. They are

#let amp(n, body, d) = (text(size: 10pt)[#n)], diag(body, baseline: 50%), $D = #d$)
#align(center, grid(
  columns: (auto, 2.2cm, auto, 1.5cm, auto, 2.2cm, auto),
  column-gutter: 6pt,
  row-gutter: 6pt,
  align: horizon,
  ..amp(1, blob((0, 0)), 4), [],
  ..amp(5, {
    blob((0, 0))
    for (x, y) in ((-1, 1), (1, 1), (-1, -1), (1, -1)) { sline((x * 0.12, y * 0.12), (x * 0.6, y * 0.4)) }
  }, 0),
  ..amp(2, { blob((0, 0)); sline((0.17, 0), (0.8, 0)) }, 3), [],
  ..amp(6, { fline((-0.8, 0), (-0.17, 0)); blob((0, 0)); fline((0.17, 0), (0.8, 0)) }, 1),
  ..amp(3, { sline((-0.8, 0), (-0.17, 0)); blob((0, 0)); sline((0.17, 0), (0.8, 0)) }, 2), [],
  ..amp(7, { fline((-0.7, -0.45), (-0.13, -0.08)); fline((-0.13, 0.08), (-0.7, 0.45)); blob((0, 0)); sline((0.17, 0), (0.8, 0)) }, 0),
  ..amp(4, {
    sline((-0.7, 0.4), (-0.14, 0.08))
    sline((-0.7, -0.4), (-0.14, -0.08))
    blob((0, 0))
    sline((0.17, 0), (0.8, 0))
  }, 1), [], [], [], [],
))

All other Yukawa theory amplitudes are superficially finite. Of these seven we may immediately discard amplitudes 2) and 4) as harmless since we know all purely scalar diagrams with an odd number of external legs to vanish due to the Lagrangian's invariance under parity. The remaining five amplitudes are remedied by absorbing their divergencies into the following counterterms,
- 1): absorbed into the free-to-choose vacuum energy density in a theory without gravity,
- 3): $delta_(Z_phi)$, $delta_(m_phi)$ #h(2em) 5): $delta_lambda$ #h(2em) 6): $delta_(Z_psi)$, $delta_(m_psi)$ #h(2em) 7): $delta_g$,

which we may use to rewrite the Lagrangian as
$
  cal(L)_"YT" & = cal(L)_("YT", r) + cal(L)_("YT", "ct") + delta cal(L) \
  & = 1/2 (partial phi)^2 - 1/2 m^2 phi^2 - lambda/4! phi^4 + overline(psi) (i sl(partial) - m_psi) psi - i g phi overline(psi) gamma^5 psi \
  & quad + 1/2 delta_(Z_phi) (partial phi)^2 - 1/2 delta_(m_phi) phi^2 - delta_lambda/4! phi^4 + overline(psi) (i delta_(Z_psi) sl(partial) - delta_(m_psi)) psi - i delta_g phi overline(psi) gamma^5 psi,
$
in which we employed the renormalized fields
$ phi = Z_phi^(-1/2) phi_0, quad psi = Z_psi^(-1/2) psi_0 $
and added a $phi^4$-interaction and -counterterm, the former to remain 'natural' and the latter to deal with the divergence in amplitude 5). In this notation, the counterterms are given by
$
  delta_(Z_phi) & = Z_phi - 1, quad && delta_(m_phi) = m_0^2 Z_phi - m^2, quad && delta_lambda = lambda_0 Z_phi^2 - lambda, \
  delta_(Z_psi) & = Z_psi - 1, quad && delta_(m_psi) = m_(0, psi) Z_psi - m_psi, quad && delta_g = g_0 Z_phi^(1/2) Z_psi - g.
$
Thus, looking at the Lagrangian, we see that the theory requires a total of eight Feynman rules.

#let rule(body, rhs) = (diag(body, baseline: 50%), math.equation(math.display(rhs.body)))
#align(center, grid(
  columns: (auto, auto, 1.2cm, auto, auto),
  column-gutter: 6pt,
  row-gutter: 10pt,
  align: (right + horizon, left + horizon, center, right + horizon, left + horizon),
  ..rule({ sline((0, 0), (1.4, 0)); mom((0.45, 0.15), (0.95, 0.15), $k$) }, $= i/(k^2 - m_phi^2)$),
  [],
  ..rule({ sline((0, 0), (1.4, 0)); xmark((0.7, 0)); mom((0.45, 0.17), (0.95, 0.17), $k$) }, $= i (k^2 delta_(Z_phi) - delta_(m_phi))$),
  ..rule({ sline((-0.5, -0.4), (0.5, 0.4)); sline((-0.5, 0.4), (0.5, -0.4)); vtx((0, 0)) }, $= -i lambda$),
  [],
  ..rule({ sline((-0.5, -0.4), (0.5, 0.4)); sline((-0.5, 0.4), (0.5, -0.4)); ctvert((0, 0)) }, $= -i delta_lambda$),
  ..rule({ fline((0, 0), (1.4, 0)); mom((0.45, 0.15), (0.95, 0.15), $p$) }, $= i/(sl(p) - m_psi) = (i (sl(p) + m_psi))/(p^2 - m_psi^2)$),
  [],
  ..rule({ fline((0, 0), (0.7, 0)); fline((0.7, 0), (1.4, 0)); xmark((0.7, 0)); mom((0.45, 0.17), (0.95, 0.17), $p$) }, $= i (sl(p) delta_(Z_psi) - delta_(m_psi))$),
  ..rule({ fline((-0.6, -0.4), (0, 0)); fline((0, 0), (-0.6, 0.4)); sline((0, 0), (0.7, 0)); vtx((0, 0)) }, $= g gamma^5$),
  [],
  ..rule({ fline((-0.6, -0.4), (0, 0)); fline((0, 0), (-0.6, 0.4)); sline((0, 0), (0.7, 0)); ctvert((0, 0)) }, $= delta_g gamma^5$),
))

Since we considered all superficially divergent amplitudes, the above Feynman rules cover all possible diagrams in Yukawa theory. No further interactions are required.

#task(label: "b")[Compute the divergent part (the pole as $d -> 4$) of each counterterm, to one-loop order of perturbation theory, implementing the renormalization conditions specified in part a). Disregard finite parts of the counterterms. Since the divergent parts must have a fixed dependence on the external momenta, you can simplify this calculation by choosing the momenta the simplest possible way.]

In order to compute the divergent part of each of the four counterterms introduced in part a), we follow the standard renormalization procedure of calculating the divergent amplitudes to a given order in perturbation theory, in this case one-loop, and then specifying their divergencies by imposing renormalization conditions such that the previously divergent amplitudes are rendered finite.

- #diag(blob((0, 0), r: 0.13)): trivially absorbable into $V_0$, no renormalization required.
- #diag({ sline((-0.7, 0), (-0.13, 0)); blob((0, 0), r: 0.13) }): vanishes due to the action's invariance under parity, also no renormalization required.
- $ sblob = sprop + tadpole + floop() + sct + "'higher order corrections'" $

The first contribution, #sprop, is finite and does not need to be considered further. Applying dimensional regularization with $d = 4 - epsilon$, we get
$
  tadpole & = underbrace(-i/2, "symmetry factor") lambda integral (dd(d, k))/(2 pi)^d i/(k^2 - m_phi^2 + i epsilon) attach(=, t: k^0 = i k_E^0) -(i lambda)/2 integral (dd(d, k_E))/(2 pi)^d 1/(k_E^2 + m_phi^2) = -(i lambda)/(2 (2 pi)^d) integral_0^oo dd(k_E) integral dd(Omega_d) k_E^(d-1)/(k_E^2 + m_phi^2).
$
Here, we can make use of
$
  sqrt(pi)^d & = (integral_(-oo)^oo dd(x) e^(-x^2))^d = integral dd(d, x) e^(-sum_(i=1)^d x_i^2) = integral dd(Omega_d) integral_0^oo dd(x) x^(d-1) e^(-x^2), quad t = x^2, dif t = 2 x dif x \
  & = integral dd(Omega_d) integral_0^oo (dif t)/2 t^(d/2 - 1) e^(-t) = integral dd(Omega_d) 1/2 Gamma(d/2) quad ==> quad integral dd(Omega_d) = (2 pi^(d/2))/Gamma(d/2),
$
$
  integral_0^oo dd(k_E) k_E^(d-1)/(k_E^2 + m_phi^2) & = integral_1^0 (k_E^2 + m_phi^2)^2/(-2 m_phi^2 k_E) k_E^(d-1)/(k_E^2 + m_phi^2) dif x, quad x = m_phi^2/(k_E^2 + m_phi^2), quad dif x = (-2 m_phi^2 k_E)/(k_E^2 + m_phi^2)^2 dif k_E \
  & = m_phi^(d-2)/2 integral_0^1 (1/x - 1)^(d/2 - 1)/x dif x = m_phi^(d-2)/2 integral_0^1 x^(-d/2) (1 - x)^(d/2 - 1) dif x = m_phi^(d-2)/2 B(alpha = -d/2 + 1, beta = d/2),
$
where $B(alpha = -d/2 + 1, beta = d/2) = (Gamma(-d/2 + 1) Gamma(d/2))/Gamma(-d/2 + 1 + d/2) = Gamma(1 - d/2) Gamma(d/2)$. Thus,
$ tadpole = -(i lambda)/(2 (2 pi)^d) (2 pi^(d/2))/Gamma(d/2) m_phi^(d-2)/2 Gamma(1 - d/2) Gamma(d/2) = -(i lambda m_phi^(d-2))/(2 (4 pi)^(d/2)) Gamma(1 - d/2), $
where
$
  Gamma(1 - d/2) & = Gamma(2 - d/2)/(1 - d/2) = Gamma(epsilon/2)/(epsilon/2 - 1) = 1/(epsilon/2 - 1) (2/epsilon - gamma + cal(O)(epsilon)) = -sum_(n=0)^oo (epsilon/2)^n (2/epsilon - gamma + cal(O)(epsilon)) \
  & = -(2/epsilon - gamma + 1 + cal(O)(epsilon)).
$
Putting everything together, we find
$ tadpole attach(=, t: d -> 4) (i lambda m_phi^2)/(4 pi)^2 (1/epsilon - gamma/2 + 1/2). $

Now on to the fermionic loop,
$
  floop(labels: #true) & attach(=, t: *_1) -g^2 integral (dd(d, k))/(2 pi)^d "Tr"((i (sl(k) + m_psi))/(k^2 - m_psi^2 + i epsilon) gamma^5 (i (sl(k) + sl(p) + m_psi))/((k + p)^2 - m_psi^2 + i epsilon) gamma^5) \
  & = g^2 integral (dd(d, k))/(2 pi)^d ("Tr"((sl(k) + m_psi) gamma^5 (sl(k) + sl(p) + m_psi) gamma^5))/((k^2 - m_psi^2 + i epsilon)((k + p)^2 - m_psi^2 + i epsilon)),
$
where we use the notation Tr for a trace in spinor space and tr for a trace over space-time indices. The overall sign stems from the fermionic loop, which reads (up to commutative bosonic factors)
$ D = overline(psi)_1 psi_1 dot overline(psi)_2 psi_2 dots.c overline(psi)_n psi_n = (-1)^(2n - 1) "Tr"(psi_1 overline(psi)_2 dot psi_2 overline(psi)_3 dots.c psi_n overline(psi)_1) $
(with each $psi_i$ contracted with $overline(psi)_(i+1)$ and $psi_n$ with $overline(psi)_1$) for a loop with $n$ vertices along its arc. We commuted $overline(psi)_1$ through to the end earning an odd number of $2n - 1$ signs to obtain $n$ propagators and a trace since the propagators meet up after running around the loop, closing the summation over Dirac matrix indices. (In the path integral approach, the $psi_i$ are anticommuting Grassmann numbers.)

We first simplify the numerator using gamma-matrix trace identities,
$
  "Tr"((sl(k) + m_psi) gamma^5 (sl(k) + sl(p) + m_psi) gamma^5) & = "Tr"(sl(k) gamma^5 (sl(k) + sl(p)) gamma^5) + "Tr"(sl(k) gamma^5 m_psi gamma^5) \
  & quad + "Tr"(m_psi gamma^5 (sl(k) + sl(p)) gamma^5) + "Tr"(m_psi^2 underbrace((gamma^5)^2, bb(1)_4)) = -"Tr"(sl(k)^2 + sl(k) sl(p)) + m_psi underbrace("Tr"(sl(k)), 0) \
  & quad + m_psi underbrace("Tr"(sl(k) + sl(p)), 0) + 4 m_psi^2 = -4 (k^2 + k p - m_psi^2).
$
Reinsertion gives
$
  floop(labels: #true) & = -4 g^2 integral (dd(d, k))/(2 pi)^d (k^2 + k p - m_psi^2)/((k^2 - m_psi^2 + i epsilon)((k + p)^2 - m_psi^2 + i epsilon)) \
  & = -4 g^2 integral (dd(d, k))/(2 pi)^d integral_0^1 dd(x) (k^2 + k p - m_psi^2)/[x((k + p)^2 - m_psi^2 + i epsilon) + (1 - x)(k^2 - m_psi^2 + i epsilon)]^2,
$
where we used the identity (involving the so-called Feynman parameter $x$)
$ 1/(A B) = integral_0^1 dd(x) 1/[x A + (1 - x) B]^2, $
with $A = (k + p)^2 - m_psi^2 + i epsilon$ and $B = k^2 - m_psi^2 + i epsilon$ in our case. Having thus combined the denominator, we complete the square in $k$ and substitute,
$
  & x((p + k)^2 - m_psi^2 + i epsilon) + (1 - x)(k^2 - m_psi^2 + i epsilon) = x(p^2 + 2 p k) + x(k^2 - m_psi^2 + i epsilon) \
  & quad + (k^2 - m_psi^2 + i epsilon) - x(k^2 - m_psi^2 + i epsilon) = k^2 + 2 x p k + x p^2 - m_psi^2 + i epsilon + x^2 p^2 - x^2 p^2 \
  & = (k + x p)^2 + x(1 - x) p^2 - m_psi^2 + i epsilon =: l^2 + Delta,
$
to rewrite the integral as
$
  floop(labels: #true) & = -4 g^2 integral_0^1 dd(x) integral (dd(d, l))/(2 pi)^d (k^2 + k p - m_psi^2)/(l^2 + Delta)^2 attach(=, t: k = l - x p) -4 g^2 integral_0^1 dd(x) integral (dd(d, l))/(2 pi)^d (l^2 - x(1 - x) p^2 - m_psi^2)/(l^2 + Delta)^2 \
  & = -4 g^2 integral_0^1 dd(x) (-i)/(4 pi)^(d/2) ((d/2 Gamma(1 - d/2))/(-Delta)^(1 - d/2) + ((Delta + 2 m_psi^2) Gamma(2 - d/2))/(-Delta)^(2 - d/2)) \
  & = (4 i g^2)/(4 pi)^(d/2) integral_0^1 dd(x) ((d - 1) Gamma(1 - d/2)/(-Delta)^(1 - d/2) + (2 m_psi^2 Gamma(2 - d/2))/(-Delta)^(2 - d/2)) \
  & = (4 i g^2 (p^2 - 2 m_psi^2))/(4 pi)^2 1/epsilon.
$
Since
$ -i M^2 (p^2) = #diag({ sline((0, 0), (0.3, 0)); draw.circle((0.55, 0), radius: 0.25, fill: white); draw.content((0.55, 0), text(size: 6.5pt)[1PI]); sline((0.8, 0), (1.1, 0)) }) = tadpole + floop() + sct, $
our usual choice of renormalization conditions
$ "i)" M^2 (p^2)|_(p^2 = m_phi^2) = 0 quad "and" quad "ii)" dif/(dif p^2) M^2 (p^2)|_(p^2 = m_phi^2) = 0 $
amounts to the following counterterms
$
  -i M^2 (p^2 = m_phi^2) & = (i lambda m_phi^2)/(4 pi)^2 (1/epsilon - gamma/2 + 1/2) + (4 i g^2)/(4 pi)^2 (p^2 - 2 m_psi^2) 1/epsilon + i(p^2 delta_(Z_phi) - delta_(m_phi))|_(p^2 = m_phi^2) \
  & = (i lambda m_phi^2)/(4 pi)^2 1/epsilon + (4 i g^2)/(4 pi)^2 (m_phi^2 - 2 m_psi^2) 1/epsilon + i(m_phi^2 delta_(Z_phi) - delta_(m_phi)) + "finite terms" attach(=, t: !) 0, \
  dif/(dif p^2) (-i M^2 (p^2))|_(p^2 = m_phi^2) & = (4 i g^2)/(4 pi)^2 1/epsilon + i delta_(Z_phi) attach(=, t: !) 0 quad ==> quad delta_(Z_phi) = -g^2/(4 pi^2) 1/epsilon, quad delta_(m_phi) = (lambda m_phi^2 - 8 g^2 m_psi^2)/(4 pi)^2 1/epsilon.
$

#line(length: 30%, stroke: 0.4pt)
#text(size: 9.5pt)[$*_1$ _Remark:_ Diagrams of Yukawa theory (and QED) always have symmetry factor one, since the fields $phi$, $overline(psi)$, $psi$ ($A_mu$, $overline(psi)$, $psi$) cannot substitute for one another in contractions.]

= Problem 9.2 (Asymptotic behavior of diagrams in $phi^4$-theory)

#task[
  Compute the leading terms in the S-matrix element for boson-boson scattering in $phi^4$-theory in the limit $s -> oo$, $t$ fixed. Ignore all masses on internal lines and keep external masses non-zero only as infrared regulators where these are needed. Show that
  #tagged(3, $ i M(s, t) prop -i lambda - (i lambda^2)/(4 pi)^2 log(s) - (5 i lambda^3)/(2 (4 pi)^4) log^2(s) + dots.c $)
]

The process of boson-boson scattering in $lambda phi^4$-theory is represented by
$ ext4 = i M(p_1, p_2 -> p_3, p_4). $
We will investigate all elements of a perturbative expansion of this process up to the two-loop level. The expansion yields
$
  blob4 = & underbrace(attach(tree, t: circled(1)), "tree-level (0-loop)") + underbrace((attach(sbub(), t: V(s), b: circled(2)) + attach(tbub, t: V(t), b: circled(3)) + attach(ubub, t: V(u), b: circled(4)) + attach(#ct4([1]), b: circled(5))), "1-loop") \
  & + (attach(chain, b: circled(6)) + attach(side(), b: circled(7)) + attach(side(mirror: #true), b: circled(8)) \
    & quad + attach(#sbub(right: "ct"), b: circled(9)) + attach(#sbub(left: "ct"), b: circled(10)) + attach(#ct4([2,s]), b: circled(11)) + (t"-channel") + (u"-channel")) quad "(2-loop)".
$
Before proceeding, we note the implications of the limit $s -> oo$, $t$ fixed.
$
  s + t + u & = 2 m^2 + 2 p_1 p_2 + 2 m^2 - 2 p_1 p_3 + 2 m^2 - 2 p_1 p_4 = 6 m^2 + 2 p_1 underbrace((p_2 - p_3 - p_4), -p_1) \
  & = 4 m^2.
$
Thus as $s -> oo$, $t$ and $4 m^2$ both remain constant quickly becoming irrelevant, so that $s approx -u$.

Returning to our loop expansion, we make use of the fact that the first five diagrams (tree- and 1-loop level) were already computed as part of problem 7.1 b). We briefly recall our findings:
$
  i M(p_1, p_2 -> p_3, p_4)|_"1-loop" & = -i lambda + (-i lambda)^2/2 integral (dd(d, k))/(2 pi)^d i/(k^2 - m^2) [i/((p_s - k)^2 - m^2) + i/((p_t - k)^2 - m^2) \
    & #h(14em) + i/((p_u - k)^2 - m^2)] - i delta_lambda \
  & approx (i lambda^2)/(2 (4 pi)^2) [3 (2/epsilon - gamma + log(4 pi)) - log(s) - log(t) - log(u)] - i delta_lambda - i lambda \
  & = -i lambda - (i lambda^2)/(2 (4 pi)^2) [log(s) + log(t) + underbrace(log(u), log(-s) = log(s) + i pi)] approx -(i lambda^2)/(4 pi)^2 log(s), quad "for" s -> oo, t "fixed".
$
We set up the $delta_lambda$ coefficient at 1-loop order to absorb the divergence
$ delta_lambda = (3 lambda^2)/(2 (4 pi)^2) (2/epsilon - gamma + log(4 pi)). $
It contains finite terms which we could have left as part of $i M(p_1, p_2 -> p_3, p_4)$. Absorbing additional constants besides the actual (momentum-independent) divergencies into counterterms merely results in a change to the theory's parameter this particular counterterm was set up to renormalize (in this instance $lambda$).

_Note:_ We will also encounter momentum-dependent divergencies. These always need to cancel among all diagrams of a given loop order.

We now tread on untarnished ground by calculating all two-loop corrections.
$
  circled(6) & = (-i lambda)^3/4 [integral (dd(d, k))/(2 pi)^d i/k^2 i/(p_s - k)^2]^2 = (-i lambda)^3 (i V(s))^2 = -i lambda^3 (-Gamma(epsilon/2)/(2 (4 pi)^2) 1/s^(epsilon/2))^2 \
  & approx -i lambda^3 [-1/(4 pi)^2 (1/epsilon - 1/2 ln(s) + epsilon/8 ln^2(s))]^2 = -(i lambda^3)/(4 pi)^4 (1/epsilon^2 - 1/epsilon ln(s) + 1/2 ln^2(s)),
$
$
  circled(7) = circled(8) & = (-i lambda)^3/2 integral (dd(d, k))/(2 pi)^d integral (dd(d, q))/(2 pi)^d i/k^2 i/(p_s + k)^2 i/q^2 i/(k + p_3 + q)^2 \
  & = (-i lambda)^3 integral (dd(d, k))/(2 pi)^d i/k^2 i/(k + p_s)^2 i V((k + p_3)^2) = (lambda^3 (-1)^(2 - d/2) Gamma(2 - d/2))/(2 (4 pi)^(d/2)) underbrace(integral (dd(d, k))/(2 pi)^d 1/k^2 1/(k + p_s)^2 1/((k + p_3)^2)^(2 - d/2), Sigma),
$
$
  Sigma & = integral_0^1 dd(y) integral_0^1 dd(z) z^(1 - d/2)/(l^2 - Delta)^(4 - d/2) underbrace(Gamma(4 - d/2)/Gamma(2 - d/2), beta), quad "where" l = k + y p_s + z p_3, \
  & #h(14em) Delta = 2 y z p_s p_3 - y(1 - y) p_s^2 attach(approx, t: "in the limit" -u approx s -> oo) y(y + z - 1) s \
  & = integral_0^1 (dif y)/y^epsilon integral_0^1 (dif z)/z^(1 - epsilon/2) 1/(y + z - 1)^epsilon beta \
  & = beta integral_0^1 dd(y) y^(-epsilon) (y - 1)^(-epsilon) integral_0^1 (dif z)/z^(1 - epsilon/2) = beta (Gamma(1 - epsilon) Gamma(1 - epsilon))/Gamma(1 - epsilon + 1 - epsilon) overbrace((-1)^(-epsilon), -> 1 "for" epsilon -> 0) (1 - (1 - epsilon/2))^(-1),
$
$
  circled(7) = circled(8) & = -(i lambda^3)/(4 pi)^4 Gamma(epsilon) 1/s^epsilon 1/epsilon = -(i lambda^3)/(4 pi)^4 (1/epsilon - gamma + cal(O)(epsilon)) (1 - epsilon ln(s) + 1/2 epsilon^2 ln^2(s) + cal(O)(epsilon^3)) 1/epsilon \
  & = -(i lambda^3)/(4 pi)^4 (1/epsilon^2 - 1/epsilon ln(s) + 1/2 ln^2(s) - underbrace(cancel(gamma/epsilon), << ln(s)) + cal(O)(epsilon)),
$
$
  circled(9) = circled(10) & = (-i lambda)(-i delta_lambda^1) i V(p^2), quad "where" V(p^2) = -Gamma(epsilon/2)/(2 (4 pi)^2) 1/(p^2)^(epsilon/2) quad "and" quad delta_lambda^1 = (3 lambda^2)/(4 pi)^2 1/epsilon \
  & = (3 i lambda^3)/(4 pi)^4 (1/epsilon^2 - 1/(2 epsilon) ln(s) + 1/8 ln^2(s)),
$
$ sum_("sum over" \ "2-loop diagrams") (s"-channel") = (i lambda^3)/(4 pi)^4 (3/epsilon^2 - 3/4 ln^2(s)). $

#align(center, box(stroke: 0.6pt, inset: 8pt, $ blob4 = -i lambda - (i lambda^2)/(4 pi)^2 ln(s) - (3 i lambda^3)/(2 (4 pi)^4) ln^2(s). $))
The $ln^2(s)$ coefficient $3/2$ falls short of the $5/2$ in eq. (3), so the two-loop diagrams evaluated above (only those in the $s$- and $u$-channel) do not capture all $ln^2(s)$ contributions.
