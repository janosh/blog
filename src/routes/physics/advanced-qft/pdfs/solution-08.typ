#import "/notes.typ": dd, notes, tagged, task
#import "@preview/cetz:0.5.2": canvas, decorations, draw

#show: notes.with(
  title: [Quantum Field Theory II -- Assignment 8],
  subtitle: [Exercise sheet 8, Advanced QFT, Prof. Jürgen Berges],
  date: [Solutions by Janosh Riebesell, 07.06.2015],
)

#let O = $cal(O)$
#let Cop = $hat(C)$
#let ks = $cancel(k)$
#let ps = $cancel(p)$

// QED diagram helpers, drawn inline in equations
#let fd(body, s: 0.75) = box(baseline: 50%, inset: (y: 2pt), canvas(length: s * 1cm, {
  import draw: *
  set-style(stroke: 0.7pt)
  body
}))
#let lbl(pt, body) = draw.content(pt, text(size: 7pt, body))
#let hblob(pt, r: 0.22) = draw.circle(pt, radius: r, fill: luma(160))
#let photon(a, b) = decorations.wave(draw.line(a, b), amplitude: 0.07, segment-length: 0.18)
#let arrowhead = (end: ">", fill: black, scale: 0.55)
// fermion line from a to b with an arrow at its midpoint
#let fermion(a, b) = {
  let m = ((a.at(0) + b.at(0)) / 2, (a.at(1) + b.at(1)) / 2)
  draw.line(a, m, mark: arrowhead)
  draw.line(m, b)
}
#let polar(c, r, a) = (c.at(0) + r * calc.cos(a), c.at(1) + r * calc.sin(a))
// fermion loop through the vertices at the given angles (in order), arrows at arc midpoints
#let floop(c, r, angles) = {
  let n = angles.len()
  for i in range(n) {
    let a = angles.at(i)
    let b = if i + 1 < n { angles.at(i + 1) } else { angles.at(0) + (if angles.at(1) > angles.at(0) { 360deg } else { -360deg }) }
    let m = (a + b) / 2
    draw.arc(polar(c, r, a), start: a, stop: m, radius: r, mark: arrowhead)
    draw.arc(polar(c, r, m), start: m, stop: b, radius: r)
  }
}
// photon leg attached to a loop of radius r at angle a
#let pleg(c, r, a, len: 0.7, label: none) = {
  photon(polar(c, r, a), polar(c, r + len, a))
  if label != none { lbl(polar(c, r + len + 0.22, a), label) }
}
// one-loop photon box with the four vertices labeled clockwise from top-left
#let pbox(tl, tr, br, bl) = fd(s: 0.62, {
  draw.circle((0, 0), radius: 0.45)
  for (a, l) in ((135deg, tl), (45deg, tr), (-45deg, br), (-135deg, bl)) { pleg((0, 0), 0.45, a, len: 0.6, label: l) }
})

= Problem 8.1 (Superficial degree of divergence for QED)

#task[
  Review the Feynman rules of quantum electrodynamics and derive the superficial degree of divergence $D$ for this theory. Proceed similarly to the derivation of $D$ for the $phi^4$-theory as it was presented in the lecture.
]

The superficial degree of divergence $D$ is given by the power of momenta in the highest order, i.e. most divergent, contribution to an amplitude. Every loop yields a momentum integral $integral dd(4, k_i)$ and therefore $d = 4$ powers of momentum. All other powers derive from the propagators of internal lines. To specify these, we recall the QED Feynman rules for propagators
$
  "internal fermion line:" quad & #fd({ fermion((-0.9, 0), (0.9, 0)); lbl((0, 0.25), $p$) }) hat(=) (i(ps + m_0))/(p^2 - m_0^2) = (i(ps + m_0))/((ps + m_0)(ps - m_0)) = i/(ps - m_0), \
  "internal photon line:" quad & #fd({ photon((-0.9, 0), (0.9, 0)); lbl((-1.1, 0), $mu$); lbl((1.1, 0), $nu$); lbl((0, 0.3), $q$) }) hat(=) -(i eta_(mu nu))/q^2, \
  ("vertex:" quad & #fd({
    fermion((-0.8, -0.7), (0, 0))
    fermion((0, 0), (-0.8, 0.7))
    photon((0, 0), (1.1, 0))
    lbl((-1, -0.75), $p_1$)
    lbl((-1, 0.75), $p_2$)
    lbl((0.55, 0.3), $q$)
    lbl((1.3, 0), $mu$)
  }) hat(=) -i e gamma^mu delta^((4)) (p_1 - p_2 - q)).
$
We expect $D$ to be a function of any of the following
$ D = D(E_f, I_f, E_gamma, I_gamma, V, L), $
where the arguments are the numbers of
$
  & E_f: "external fermions", quad && I_f: "internal fermions", \
  & E_gamma: "external photons", quad && I_gamma: "internal photons", \
  & V: "QED vertices", quad && L: "QED loops".
$
From the Feynman rules, we easily see the UV-structure of QED amplitudes is given by
$ A_"UV" tilde integral (product_(l=1)^L dd(4, k_l))/(product_(i=1)^(I_f) (ps_i - m_0) dot product_(j=1)^(I_gamma) q_j^2), $
resulting in a superficial degree of divergence of
$ D = 4L - I_f - 2 I_gamma. $
We proceed by inserting for the number of loop integrations
$ L = I_f + I_gamma - (V - 1), $
which again follows from the Feynman rules as they attribute one momentum integral to each internal line $I = I_f + I_gamma$ while each vertex contributes one $delta^((4))$, one of whom only enforces overall momentum integration. Thus
$ D = 4(I_f + I_gamma - (V - 1)) - I_f - 2 I_gamma = 4 - 4V + 3 I_f + 2 I_gamma. $
The number of vertices can also be reexpressed by
$ V = 2 I_gamma + E_gamma = 1/2 (2 I_f + E_f), $
since every QED vertex has one photon- and two fermion-lines, and every internal line is connected to two vertices. Altogether, we get
$
  D & = 4 - (2 I_gamma + E_gamma) - 3 dot 1/2 (2 I_f + E_f) + 3 I_f + 2 I_gamma \
  & = 4 - E_gamma - 3/2 E_f.
$
_Additional note:_ Looking at $cal(L)_"QED" = -1/4 F_(mu nu) F^(mu nu) + overline(psi) (i gamma dot partial - m_0) psi - e A_mu overline(psi) gamma^mu psi$, we see that since $[psi] = 3/2$, $[A_mu] = 1$, QED's coupling has mass-dimension $[e] = 0$. From this, we conclude that QED is renormalizable in 4, i.e. has finitely many divergencies, but at every order in perturbation theory.

= Problem 8.2 (One-loop structure of QED)

#task[
  From problem 8.1, you should have found that the superficial degree of divergence of a QED-amplitude with an interaction-Lagrangian $cal(L)_"int" = overline(psi) gamma^mu A_mu psi$ is
  #tagged(1, $ D = 4 - E_gamma - 3/2 E_f. $)
  Since $[e] = 0$, the theory is renormalizable.
]

#task(label: "a")[Give $D$ for each of the following amplitudes.]

#let amp(body, ext, d) = grid(
  columns: (3.4cm, 3.2cm, 1fr),
  align: horizon,
  inset: (y: 3pt),
  body, ext, d,
)

i) The vacuum energy.
#amp(fd(hblob((0, 0))), $E_f = E_gamma = 0,$, $D = 4 - E_gamma - 3/2 E_f = 4$)
ii) The photon propagator.
#amp(
  fd({ photon((-1, 0), (1, 0)); hblob((0, 0)); lbl((-1.2, 0), $mu$); lbl((1.2, 0), $nu$) }),
  $E_f = 0, E_gamma = 2,$,
  $D = 4 - E_gamma = 2$,
)
iii) The electron propagator.
#amp(fd({ fermion((-1, 0), (0, 0)); fermion((0, 0), (1, 0)); hblob((0, 0)) }), $E_f = 2, E_gamma = 0,$, $D = 4 - 3/2 E_f = 1$)
iv) The electron-electron-photon vertex.
#amp(
  fd({
    fermion((-0.7, -0.6), (0, 0))
    fermion((0, 0), (-0.7, 0.6))
    photon((0, 0), (1, 0))
    lbl((-0.9, -0.7), $p_1$)
    lbl((-0.9, 0.7), $p_2$)
    lbl((1.2, 0), $mu$)
  }),
  $E_f = 2, E_gamma = 1,$,
  $D = 4 - E_gamma - 3/2 E_f = 0$,
)
v) The 1-photon amplitude.
#amp(fd({ photon((-1, 0), (0, 0)); hblob((0, 0)) }), $E_f = 0, E_gamma = 1,$, $D = 4 - E_gamma = 3$)
vi) The 3-photon amplitude.
#amp(
  fd({ photon((0, 0), (1, 0)); photon((0, 0), (-0.55, 0.75)); photon((0, 0), (-0.55, -0.75)); hblob((0, 0)) }),
  $E_f = 0, E_gamma = 3,$,
  $D = 4 - E_gamma = 1$,
)
vii) The 4-photon amplitude.
#amp(
  fd({ for p in ((-0.8, 0.5), (0.8, 0.5), (-0.8, -0.5), (0.8, -0.5)) { photon((0, 0), p) }; hblob((0, 0)) }),
  $E_f = 0, E_gamma = 4,$,
  $D = 4 - E_gamma = 0$,
)

#task(label: "b")[
  Verify explicitly that the one-loop diagram contributing to the one-point function vanishes using the discrete symmetry of charge conjugation, $j^mu -> -j^mu$, $A^mu -> -A^mu$. There are two Feynman diagrams contributing to the three-point function at one-loop order. Show that these cancel. Show that the diagrams contributing to any $n$-point photon amplitude, for $n$ odd, cancel in pairs.
]

Charge conjugation $Cop$ is a symmetry of QED, meaning
$ Cop |Omega chevron.r = |Omega chevron.r. $
Since $j^mu (x)$ changes sign under charge conjugation,
$ Cop j^mu (x) Cop^dagger = -j^mu (x), quad "where" Cop^dagger Cop = "id", $
we infer that its vacuum expectation value vanishes at one-loop (and any other number of loops),
$
  chevron.l Omega | T j^mu (x) | Omega chevron.r & = chevron.l Omega | j^mu (x) | Omega chevron.r = chevron.l Omega | Cop^dagger Cop j^mu (x) Cop^dagger Cop | Omega chevron.r \
  & = -chevron.l Omega | j^mu (x) | Omega chevron.r = 0.
$
This carries over to the photon one-point function
$
  #fd({ hblob((0, 0)); photon((0.22, 0), (1.3, 0)); lbl((0.75, -0.3), $q$); lbl((1.5, 0), $mu$) })
  = #fd({ draw.circle((0, 0), radius: (0.35, 0.22)); hblob((-0.5, 0)); photon((0.35, 0), (1.4, 0)); lbl((0.85, -0.3), $q$); lbl((1.6, 0), $mu$) })
  = -i e integral dd(4, x) e^(-i q x) chevron.l Omega | T j^mu (x) | Omega chevron.r = 0,
$
where $j^mu (x) = overline(psi)(x) gamma^mu psi(x)$.

More explicitly, we may also write the one-point amplitude at one-loop as
$ Gamma^((1) mu)|_"1-loop" = -i e integral (dd(4, k))/(2 pi)^4 (-i "tr"[gamma^mu (ks + m)])/(k^2 - m^2) = -e integral (dd(4, k))/(2 pi)^4 (4 k^mu)/(k^2 - m^2) = 0, $
where we used $"tr"(gamma^mu gamma^nu) = 4 eta^(mu nu)$ and $"tr"(gamma^mu) = 0$ (see pr. 9.3, QFT I), and which vanishes, since $k^mu$ is odd and $1/(k^2 - m^2)$ is even.

#let tri(rev) = fd(s: 1.1, {
  let c = (0, 0)
  let r = 0.9
  floop(c, r, if rev { (90deg, 210deg, 330deg) } else { (90deg, -30deg, -150deg) })
  pleg(c, r, 90deg, len: 0.6, label: $mu$)
  pleg(c, r, -30deg, len: 0.6, label: $nu$)
  pleg(c, r, -150deg, len: 0.6, label: $lambda$)
  // incoming external momenta
  for (a, d) in ((90deg, -1), (-30deg, -1), (-150deg, 1)) {
    let off = d * 0.13
    let shift(pt) = (pt.at(0) - off * calc.sin(a), pt.at(1) + off * calc.cos(a))
    draw.line(shift(polar(c, r + 0.5, a)), shift(polar(c, r + 0.15, a)), mark: arrowhead)
  }
  lbl(polar(c, r + 0.3, 69deg), $p_1$)
  lbl(polar(c, r + 0.3, -51deg), $p_2$)
  lbl(polar(c, r + 0.3, -129deg), $p_3$)
  let (a1, a2, a3) = if rev { (150deg, -90deg, 30deg) } else { (30deg, -90deg, 150deg) }
  lbl(polar(c, r + 0.3, a1), $k$)
  lbl(polar(c, r + 0.25, a2), if rev { $k + p_3$ } else { $k + p_2$ })
  lbl(polar(c, r + 0.75, a3), $k + p_2 + p_3$)
})
The three-point amplitude at one-loop consists of the two diagrams
$
  i Gamma^((3) mu nu lambda)|_"1-loop" = #tri(false) + #tri(true)
$
$
  & = -(-i e)^3 integral (dd(4, k))/(2 pi)^4 {"tr"[gamma^mu S_F (k) gamma^nu S_F (k + p_2) gamma^lambda S_F (k + p_2 + p_3)] \
  & #h(8em) + "tr"[gamma^mu S_F (-k) gamma^nu S_F (-k - p_2) gamma^lambda S_F (-k - p_2 - p_3)]},
$
where $S_F (k) := 1/(ks - m) = (ks + m)/(k^2 - m^2)$. To show that this vanishes, we use $gamma^mu$'s and $S_F$'s behavior under charge conjugation,
$ Cop^dagger gamma^mu Cop = (gamma^mu)^T, quad Cop^dagger S_F (k) Cop = -S_F (-k), $
and the cyclicity of the trace (to send the last $Cop^dagger$ to the front). Thus
$
  & "tr"\[gamma^mu underbrace(Cop Cop^dagger, "id") S_F (-k) Cop Cop^dagger gamma^nu Cop Cop^dagger S_F (-k - p_2) Cop Cop^dagger gamma^lambda Cop Cop^dagger S_F (-k - p_2 - p_3) Cop Cop^dagger\] \
  & = "tr"[(gamma^mu)^T (-S_F (k)) (gamma^nu)^T (-S_F (k + p_2)) (gamma^lambda)^T (-S_F (k + p_2 + p_3))] \
  & = -"tr"[gamma^mu S_F (k) gamma^nu S_F (k + p_2) gamma^lambda S_F (k + p_2 + p_3)].
$
Reinserting into $i Gamma^((3))|_"1-loop"$ yields immediately $i Gamma^((3))|_"1-loop" = 0$.

We turn to the general case of all diagrams contributing to a photon $n$-point function where $n$ is odd. First note, that every fermionic loop with an odd number of vertices has a counterpart in which the momenta point along the loop in opposite direction
#let nloop(cw) = fd(s: 1, {
  let c = (0, 0)
  let r = 0.5
  let angles = (90deg, 45deg, 0deg, -45deg, -90deg, -135deg, -180deg, -225deg)
  let labels = ($1$, $2$, $3$, $4$, $5$, $6$, $7$, $n$)
  floop(c, r, if cw { angles } else { angles.rev() })
  for (a, l) in angles.zip(labels) {
    pleg(c, r, a, len: 0.5, label: l)
  }
  draw.line(polar(c, r + 0.15, -195deg), polar(c, r + 0.45, -212deg), stroke: (dash: "dotted"))
})
$ #nloop(true) = - #nloop(false). $
Since an $n$-point photon function receives contributions from $(n - 1)!$, and $n!$ is even for $n > 2$ (the case $n = 1$, i.e. the one-loop diagram #fd(s: 0.6, { photon((-1, 0), (0, 0)); draw.circle((0.3, 0), radius: 0.3) }), we already showed to be vanishing in the beginning) we can always arrange all contributing diagrams in pairs of two, where for the special case of $n$ odd, we may partner each diagram with its oppositely running counterpart in order to let each pair of our partition vanish individually.

#task(label: "c")[
  The photon four-point amplitude is a sum of six diagrams. Show explicitly that the potential logarithmic divergences of these diagrams cancel.
]

The six diagrams are
$
  Gamma^((4) mu nu rho sigma) = & #pbox($mu$, $nu$, $sigma$, $rho$) + #pbox($mu$, $nu$, $rho$, $sigma$) + #pbox($mu$, $rho$, $sigma$, $nu$) \
  + & #pbox($mu$, $rho$, $nu$, $sigma$) + #pbox($mu$, $sigma$, $nu$, $rho$) + #pbox($mu$, $sigma$, $rho$, $nu$),
$
where we omit momentum arrows in the fermion loops since clock- and counterclockwise running are equal for an even number of vertices.

The potential log-divergence of $i Gamma^((4) mu nu rho sigma)$ stems entirely from integrating over the internal momentum, i.e.
$ i Gamma_"div"^((4) mu nu rho sigma) tilde integral dd(4, k) (ks)^4/(k^2)^4, $
and is the same irrespective of a change in external momenta $p_i$, $i in {1, 2, 3, 4}$, or, for that matter, the fermion mass $m$. To speed up calculations, we may therefore set both to zero.

The divergent part $i Gamma_"div"^((4) mu nu rho sigma)$ of the photon 4-point amplitude may then be written much more compactly as
$
  i Gamma_"div"^((4) mu nu rho sigma) = integral (dd(4, k))/(2 pi)^4 (-1)/(k^2)^4 [ & "tr"(gamma^mu ks gamma^nu ks gamma^rho ks gamma^sigma ks) + "tr"(gamma^mu ks gamma^nu ks gamma^sigma ks gamma^rho ks) \
    + & "tr"(gamma^mu ks gamma^rho ks gamma^nu ks gamma^sigma ks) + "tr"(gamma^mu ks gamma^rho ks gamma^sigma ks gamma^nu ks) \
    + & "tr"(gamma^mu ks gamma^sigma ks gamma^nu ks gamma^rho ks) + "tr"(gamma^mu ks gamma^sigma ks gamma^rho ks gamma^nu ks)].
$
To get a grasp on this expression, we concern ourselves solely with the first trace initially. Using the gamma-matrices' anti-commutation relations and some of the trace identities worked out in problem 9.3 of QFT I, it can be expressed as
$
  "tr"(gamma^mu ks gamma^nu ks gamma^rho ks gamma^sigma ks) = & 32 k^mu k^nu k^rho k^sigma - 8 k^2 (k^mu k^nu g^(rho sigma) + k^rho k^sigma g^(mu nu) \
    & + k^mu k^sigma g^(nu rho) + k^nu k^rho g^(mu sigma)) + 4 k^4 (g^(mu nu) g^(rho sigma) - g^(mu rho) g^(nu sigma) + g^(mu sigma) g^(nu rho)).
$
We symmetrize products of $k$ by sending $k^mu k^nu -> k^2/4 g^(mu nu)$ and $k^mu k^nu k^rho k^sigma -> k^4/24 (g^(mu nu) g^(rho sigma) + g^(mu rho) g^(nu sigma) + g^(mu sigma) g^(nu rho))$ to obtain
$ "tr"(gamma^mu ks gamma^nu ks gamma^rho ks gamma^sigma ks) = 4/3 k^4 (g^(mu nu) g^(rho sigma) - 2 g^(mu rho) g^(nu sigma) + g^(mu sigma) g^(nu rho)). $
From this expression, the other five traces follow simply by permutations of indices. Since the metric is symmetric, they all sum up to zero.
