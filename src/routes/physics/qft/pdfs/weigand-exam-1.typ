#import "/notes.typ": dd, notes, tagged, task
#import "@preview/cetz:0.5.2": canvas, decorations, draw

#show: notes.with(
  title: [Exam on Quantum Field Theory I],
  subtitle: [Devised by Timo Weigand, written on 12.02.2013],
  date: [Solutions by Janosh Riebesell, 22.01.2015],
)

// Feynman diagram helpers: fermion lines carry an arrow at their midpoint, photons are wavy,
// (charged) scalars dashed. Coordinates are plain (x, y) tuples in units of `length`.
#let feyn(body, length: 0.85cm) = box(baseline: 50%, canvas(length: length, {
  import draw: *
  set-style(stroke: 0.7pt)
  body
}))
#let lerp(a, b, t) = (a.at(0) + t * (b.at(0) - a.at(0)), a.at(1) + t * (b.at(1) - a.at(1)))
#let fermion(a, b, at: 0.58) = {
  draw.line(a, lerp(a, b, at), mark: (end: "stealth", fill: black, scale: 0.55))
  draw.line(lerp(a, b, at - 0.08), b)
}
#let photon(a, b) = decorations.wave(draw.line(a, b), amplitude: 0.08, segment-length: 0.17)
#let scalar(a, b, arrow: false) = {
  draw.line(a, b, stroke: (dash: "dashed", thickness: 0.7pt))
  if arrow { draw.line(lerp(a, b, 0.45), lerp(a, b, 0.6), mark: (end: "stealth", fill: black, scale: 0.55)) }
}
// Feynman slash notation
#let fsl(x) = math.cancel(x, angle: 25deg, length: 110%)
#let lbl(pt, body, anchor: "center") = draw.content(pt, text(size: 8pt, body), anchor: anchor)

// e+ e- -> e+ e- building blocks: s-channel (photon between left vertex L and right vertex R)
// and t-channel (photon between top vertex T and bottom vertex B)
#let s-legs(L, R, d: 0.85) = {
  fermion((L.at(0) - d, L.at(1) + d), L)
  fermion(L, (L.at(0) - d, L.at(1) - d))
  fermion(R, (R.at(0) + d, R.at(1) + d))
  fermion((R.at(0) + d, R.at(1) - d), R)
}
#let t-legs(T, B, d: 0.85) = {
  fermion((T.at(0) - d, T.at(1) + d), T)
  fermion(T, (T.at(0) + d, T.at(1) + d))
  fermion(B, (B.at(0) - d, B.at(1) - d))
  fermion((B.at(0) + d, B.at(1) - d), B)
}
// vertex correction: a photon joining the two legs a and b leaving vertex v
#let vertex-corr(v, a, b, t: 0.6) = {
  let (pa, pb) = (lerp(v, a, t), lerp(v, b, t))
  photon(pa, pb)
}

= Problem 1 (5 points)

#task[
  Consider a free real scalar field with the following action
  #tagged(1, $ S = integral dd(4, x) (1/2 partial_mu phi partial^mu phi - 1/2 m^2 phi^2). $)
]

#task(label: "a")[Derive the equation of motion for $phi$ using the variational principle. _Hint:_ To do this, substitute $phi -> phi + delta phi$, expand $S$ to first order in the small quantity $delta phi$ and impose $delta S = 0$.]

We vary $S$ with respect to $phi$ and $partial_mu phi$ whereby the boundaries are held fixed,
$ delta phi|_"boundary" = 0, quad delta partial_mu phi|_"boundary" = 0. $
Varying $phi$ by $phi -> phi' = phi + delta phi$ transforms the action
$
  S -> S' = S + delta S & = integral dd(4, x) (1/2 partial_mu (phi + delta phi) partial^mu (phi + delta phi) - 1/2 m^2 (phi + delta phi)^2) \
  & = integral dd(4, x) (1/2 partial_mu phi partial^mu phi + 1/2 partial_mu phi partial^mu delta phi + 1/2 partial_mu delta phi partial^mu phi + 1/2 partial_mu delta phi partial^mu delta phi \
    & #h(5em) - 1/2 m^2 phi^2 - m^2 phi delta phi - 1/2 m^2 delta phi^2) \
  & = S + integral dd(4, x) (partial_mu phi partial^mu delta phi + cal(O)((partial delta phi)^2) - m^2 phi delta phi + cal(O)(delta phi^2)),
$
$
  0 attach(=, t: !) delta S & approx integral dd(4, x) (partial_mu phi partial^mu delta phi - m^2 phi delta phi) = underbrace(partial_mu phi delta phi|_"boundary", 0) + integral dd(4, x) (-(partial_mu partial^mu phi) delta phi - m^2 phi delta phi) \
  & = -integral dd(4, x) (partial^2 phi + m^2 phi) delta phi.
$
Now since $delta phi$ is not zero along all integration paths, we can infer that for $delta S = 0$ to be true in general necessarily
$ partial^2 phi + m^2 phi = (partial^2 + m^2) phi = 0. $

#task(label: "b")[
  Consider the operator
  #tagged(2, $ phi(arrow(x), t) = integral (dd(3, p))/(2 pi)^3 1/sqrt(2 p_0) (a_p^dagger e^(i p x) + a_p e^(-i p x))|_(p_0 = sqrt(arrow(p)^2 + m^2)). $)
  Show that (2) satisfies the equation of motion $(square + m^2) phi(x) = 0$.
]

$
  (square + m^2) phi(x) & = integral (dd(3, p))/(2 pi)^3 1/sqrt(2 p_0) (partial^2 + m^2)(a_p^dagger e^(i p x) + a_p e^(-i p x)) \
  & = integral (dd(3, p))/(2 pi)^3 1/sqrt(2 p_0) underbrace((-p^2 + m^2), 0) (a_p^dagger e^(i p x) + a_p e^(-i p x)) = 0.
$

#task(label: "c")[Calculate from (1), the Lagrangian, the canonical conjugate momentum density, $pi(x)$, to $phi(x)$. Show that $pi(x) = dot(phi)(x)$ and use (2) to write down $pi(x)$ in a form analogous to (2).]

$
  pi(x) & = (partial cal(L)(phi(x), partial phi(x)))/(partial dot(phi)(x)) = partial/(partial dot(phi)(x)) (1/2 (partial phi)^2 - 1/2 m^2 phi^2) = partial/(partial dot(phi)(x)) (1/2 dot(phi)^2 - 1/2 (nabla phi)^2 - 1/2 m^2 phi^2) \
  & = dot(phi)(x),
$
$ pi(x) = partial/(partial t) integral (dd(3, p))/(2 pi)^3 1/sqrt(2 p_0) (a_p^dagger e^(i p x) + a_p e^(-i p x)) = i integral (dd(3, p))/(2 pi)^3 sqrt(p_0/2) (a_p^dagger e^(i p x) - a_p e^(-i p x)). $

#task(label: "d")[
  Propose commutation relations for $a_p$ and $a_p^dagger$ such that $pi$ and $phi$ fulfill the canonical commutation relations. Verify your ansatz by explicitly evaluating the commutators
  $ [pi(arrow(x), t), pi(arrow(y), t)] = [phi(arrow(x), t), phi(arrow(y), t)] = 0 quad "and" quad [phi(arrow(x), t), pi(arrow(y), t)] = i delta^((3)) (arrow(x) - arrow(y)). $
]

_Proposition:_
$ [a_p, a_q] = [a_p^dagger, a_q^dagger] = 0 quad "and" quad [a_p, a_q^dagger] = (2 pi)^3 delta^((3)) (arrow(p) - arrow(q)). $
_Verification:_
$ [pi(arrow(x), t), pi(arrow(y), t)] = i integral (dd(3, p))/(2 pi)^3 sqrt(p_0/2) e^(i p x) i integral (dd(3, q))/(2 pi)^3 sqrt(q_0/2) e^(i q y) [a_p^dagger - a_(-p), a_q^dagger - a_(-q)] = 0, $
since
$
  [a_p^dagger - a_(-p), a_q^dagger - a_(-q)] & = underbrace([a_p^dagger, a_q^dagger], 0) - [a_p^dagger, a_(-q)] - [a_(-p), a_q^dagger] + underbrace([a_(-p), a_(-q)], 0) \
  & = (2 pi)^3 delta^((3)) (-arrow(q) - arrow(p)) - (2 pi)^3 delta^((3)) (-arrow(p) - arrow(q)) = 0.
$
$ [phi(arrow(x), t), phi(arrow(y), t)] = integral (dd(3, p))/(2 pi)^3 e^(i p x)/sqrt(2 p_0) integral (dd(3, q))/(2 pi)^3 e^(i q y)/sqrt(2 q_0) [a_p^dagger + a_(-p), a_q^dagger + a_(-q)] = 0, $
since
$
  [a_p^dagger + a_(-p), a_q^dagger + a_(-q)] & = underbrace([a_p^dagger, a_q^dagger], 0) + [a_p^dagger, a_(-q)] + [a_(-p), a_q^dagger] + underbrace([a_(-p), a_(-q)], 0) \
  & = -(2 pi)^3 delta^((3)) (-arrow(q) - arrow(p)) + (2 pi)^3 delta^((3)) (-arrow(p) - arrow(q)) = 0.
$
$ [phi(arrow(x), t), pi(arrow(y), t)] = integral (dd(3, p))/(2 pi)^3 e^(i p x)/sqrt(2 p_0) i integral (dd(3, q))/(2 pi)^3 sqrt(q_0/2) e^(i q y) [a_p^dagger + a_(-p), a_q^dagger - a_(-q)] $
#align(center)[
  #box(stroke: 0.5pt, inset: (x: 6pt, y: 4pt))[
    $[a_p^dagger + a_(-p), a_q^dagger - a_(-q)] = -[a_p^dagger, a_(-q)] + [a_(-p), a_q^dagger] = (2 pi)^3 delta^((3)) (-arrow(q) - arrow(p)) + (2 pi)^3 delta^((3)) (-arrow(p) - arrow(q))$
  ]
]
$
  & = i integral (dd(3, p))/(2 pi)^3 e^(i p x)/sqrt(2 p_0) integral (dd(3, q))/(2 pi)^3 sqrt(q_0/2) e^(i q y) 2 (2 pi)^3 delta^((3)) (-arrow(p) - arrow(q)) \
  & = i integral (dd(3, p))/(2 pi)^3 e^(i p x) e^(-i p y) = i delta^((3)) (arrow(x) - arrow(y)).
$

= Problem 2 (5 points)

#task[
  The fermionic part of the QED Lagrangian density is given by
  #tagged(3, $ cal(L) = overline(Psi) (i fsl(partial) - m) Psi - e overline(Psi) fsl(A) Psi. $)
]

#task(label: "a")[Using the Clifford algebra in $D = 4$, calculate $gamma^mu gamma_mu$ and $gamma^mu gamma^rho gamma_mu$.]

The Clifford algebra $"Cliff"(1, 3)$ is defined as the algebra spanned by $n times n$-matrices $(gamma^mu)^A_B$, $mu in {0, 1, 2, 3}$ and $A, B in {1, ..., n}$ such that
$ {gamma^mu, gamma^nu} = gamma^mu gamma^nu + gamma^nu gamma^mu = 2 eta^(mu nu) bb(1). $
Therefore,
$ gamma^mu gamma^nu = cases(eta^(mu nu) bb(1) & "for" mu = nu, -gamma^nu gamma^mu & "for" mu != nu) quad "and" quad cases((gamma^0)^2 = gamma^0 gamma^0 = eta^(00) bb(1) = bb(1), (gamma^i)^2 = gamma^i gamma^i = eta^(i i) bb(1) = -bb(1)), $
$ gamma^mu gamma_mu = (gamma^0)^2 - (gamma^1)^2 - (gamma^2)^2 - (gamma^3)^2 = bb(1) - (-bb(1)) - (-bb(1)) - (-bb(1)) = 4 dot bb(1), $
$
  gamma^mu gamma^rho gamma_mu & = (2 eta^(mu rho) bb(1) - gamma^rho gamma^mu) gamma_mu = 2 eta^(mu rho) gamma_mu bb(1) - gamma^rho gamma^mu gamma_mu \
  & = 2 gamma^rho - 4 gamma^rho = -2 gamma^rho.
$

#task(label: "b")[Draw the Feynman graphs for the non-trivial scattering amplitude $e^+ + e^- -> e^+ + e^-$ to order $e^2$.]

Non-trivial scattering excludes the term $delta_(f i)$ from the $S$-matrix element $chevron.l f | S | i chevron.r$ represented by the diagram
#feyn(length: 0.8cm, {
  fermion((0, 0.5), (1.4, 0.5))
  fermion((0, 0), (1.4, 0))
  lbl((1.1, 0.55), $e^+$, anchor: "south")
  lbl((1.1, -0.05), $e^-$, anchor: "north")
})
(order $e^0$).

#grid(
  columns: (auto, 1fr),
  row-gutter: 1em,
  column-gutter: 1em,
  align: (left + horizon, left + horizon),
  [Order $e^1$:], [none.],
  [Order $e^2$:],
  [
    #feyn({
      s-legs((0, 0), (2, 0))
      photon((0, 0), (2, 0))
      lbl((-0.9, 0.85), $e^-, p$, anchor: "east")
      lbl((-0.9, -0.85), $e^+, k$, anchor: "east")
      lbl((2.9, 0.85), $e^-, p'$, anchor: "west")
      lbl((2.9, -0.85), $e^+, k'$, anchor: "west")
      lbl((1, -0.2), $q = p + k$, anchor: "north")
    })
    #h(1.2em) $+$ #h(1.2em)
    #feyn({
      t-legs((0, 0.6), (0, -0.6))
      photon((0, 0.6), (0, -0.6))
      lbl((-0.9, 1.45), $e^-, p$, anchor: "east")
      lbl((0.9, 1.45), $e^-, p'$, anchor: "west")
      lbl((-0.9, -1.45), $e^+, k$, anchor: "east")
      lbl((0.9, -1.45), $e^+, k'$, anchor: "west")
      lbl((0.2, 0), $q = p - p'$, anchor: "west")
    })
  ],
)

#task(label: "c")[Write down the invariant matrix element $i cal(M)$ for this process.]

$
  i cal(M) & = overline(u)_(s') (p') (-i e gamma^mu) u_s (p) (-i eta_(mu nu))/(p - p')^2 overline(v)_r (k) (-i e gamma^nu) v_(r') (k') \
  & quad - overline(u)_(s') (p') (-i e gamma^mu) v_(r') (k') (-i eta_(mu nu))/(p + k)^2 overline(v)_r (k) (-i e gamma^nu) u_s (p) \
  & = i e^2 ((overline(u)_(s') (p') gamma^mu u_s (p) thin overline(v)_r (k) gamma_mu v_(r') (k'))/(p - p')^2 - (overline(u)_(s') (p') gamma^mu v_(r') (k') thin overline(v)_r (k) gamma_mu u_s (p))/(p + k)^2),
$
where the relative minus sign between the $t$- and $s$-channel diagrams stems from Fermi statistics.

#task(label: "d")[As b) but this time the Feynman diagrams of order $e^4$.]

#let wide = 2.6
#align(center)[
  #feyn({
    s-legs((0, 0), (wide, 0))
    photon((0, 0), (0.85, 0))
    draw.circle((1.3, 0), radius: 0.45)
    draw.line((1.28, 0.45), (1.36, 0.45), mark: (end: "stealth", fill: black, scale: 0.5))
    draw.line((1.32, -0.45), (1.24, -0.45), mark: (end: "stealth", fill: black, scale: 0.5))
    photon((1.75, 0), (wide, 0))
    lbl((-0.9, 0.85), $e^-, p$, anchor: "east")
    lbl((-0.9, -0.85), $e^+, k$, anchor: "east")
    lbl((wide + 0.9, 0.85), $e^-, p'$, anchor: "west")
    lbl((wide + 0.9, -0.85), $e^+, k'$, anchor: "west")
    lbl((1.3, 0.5), $r_1$, anchor: "south")
    lbl((1.3, -0.5), $r_2$, anchor: "north")
    lbl((0.42, -0.15), $q_1$, anchor: "north")
    lbl((2.18, -0.15), $q_2$, anchor: "north")
  })
  #h(0.8em) $+$ #h(0.8em)
  #feyn({
    let L = (0, 0)
    s-legs(L, (2, 0))
    photon(L, (2, 0))
    vertex-corr(L, (-0.85, 0.85), (-0.85, -0.85))
  })
  #h(0.8em) $+$ #h(0.8em)
  #feyn({
    let R = (2, 0)
    s-legs((0, 0), R)
    photon((0, 0), R)
    vertex-corr(R, (2.85, 0.85), (2.85, -0.85))
  })

  #v(0.6em)
  #feyn({
    let T = (0, 0.6)
    t-legs(T, (0, -0.6))
    photon(T, (0, -0.6))
    vertex-corr(T, (-0.85, 1.45), (0.85, 1.45))
  })
  #h(0.8em) $+$ #h(0.8em)
  #feyn({
    let B = (0, -0.6)
    t-legs((0, 0.6), B)
    photon((0, 0.6), B)
    vertex-corr(B, (-0.85, -1.45), (0.85, -1.45))
  })

  #v(0.6em)
  #let (top, bot) = (1.1, 0)
  #feyn({
    fermion((0, top), (0.8, top))
    fermion((0.8, top), (1.8, top))
    fermion((1.8, top), (2.6, top))
    fermion((0.8, bot), (0, bot))
    fermion((1.8, bot), (0.8, bot))
    fermion((2.6, bot), (1.8, bot))
    photon((0.8, top), (0.8, bot))
    photon((1.8, top), (1.8, bot))
  })
  #h(0.6em) $+$ #h(0.6em)
  #feyn({
    fermion((0, top), (0.8, top))
    fermion((0.8, top), (1.8, top))
    fermion((1.8, top), (2.6, top))
    fermion((0.8, bot), (0, bot))
    fermion((1.8, bot), (0.8, bot))
    fermion((2.6, bot), (1.8, bot))
    photon((0.8, top), (1.8, bot))
    photon((1.8, top), (0.8, bot))
  })
  #h(0.6em) $+$ #h(0.6em)
  #feyn({
    fermion((0, top), (0.8, top))
    fermion((0.8, top), (0.8, bot))
    fermion((0.8, bot), (0, bot))
    photon((0.8, top), (1.8, top))
    photon((0.8, bot), (1.8, bot))
    fermion((1.8, bot), (1.8, top))
    fermion((1.8, top), (2.6, top))
    fermion((2.6, bot), (1.8, bot))
  })
  #h(0.6em) $+$ #h(0.6em)
  #feyn({
    fermion((0, top), (0.8, top))
    fermion((0.8, top), (0.8, bot))
    fermion((0.8, bot), (0, bot))
    photon((0.8, top), (1.8, bot))
    photon((0.8, bot), (1.8, top))
    fermion((1.8, bot), (1.8, top))
    fermion((1.8, top), (2.6, top))
    fermion((2.6, bot), (1.8, bot))
  })
]

= Problem 3 (5 points)

#task[
  For the $lambda phi^4$-theory the propagator is given by
  #tagged(4, $ i/(p^2 - m_0^2 - Pi(p^2)) = (i Z)/(p^2 - m^2) + integral_(m_t^2)^oo dd(m)'^2 sigma(m'^2) i/(p^2 - m'^2) $)
  with physical mass $m$, Lagrangian mass parameter $m_0$, self-energy $Pi(p^2)$ and the two-particle threshold $m_t$.
]

#task(label: "a")[From the position of the 1-particle pole in this equation, deduce a relation between $m_0$ and $m$.]

Not covered in our treatment of QFT!

#task(label: "b")[By comparing the residues at the 1-particle poles, deduce a relation between $Z$ and $m^2$. _Hint:_ Use the fact that the integral on the right hand side of (4) has no poles near $p^2 = m^2$. Perform a first-order Taylor expansion of $Pi(p^2)$ at $p^2 = m^2$.]

Not covered either by Berges' QFT lecture!

= Problem 4 (5 points)

#task[
  The Lagrangian density of scalar QED is given by
  #tagged(5, $ cal(L) = -1/4 F_(mu nu) F^(mu nu) + (D_mu phi)^dagger D^mu phi - m^2 phi^dagger phi $)
  with $D_mu = partial_mu + i e A_mu$ and $F_(mu nu) = partial_mu A_nu - partial_nu A_mu$.
]

#task(label: "a")[Show that the action (5) is invariant under $phi -> e^(i e theta) phi$ with $theta in RR$.]

$
  cal(L) -> cal(L)' & = -1/4 F_(mu nu) F^(mu nu) + (D_mu e^(i e theta) phi)^dagger D^mu e^(i e theta) phi - m^2 (e^(i e theta) phi)^dagger e^(i e theta) phi \
  & = -1/4 F_(mu nu) F^(mu nu) + (D_mu phi)^dagger underbrace(e^(-i e theta) e^(i e theta), 1) D^mu phi - m^2 phi^dagger underbrace(e^(-i e theta) e^(i e theta), 1) phi = cal(L).
$

#task(label: "b")[Calculate the Noether current and charge corresponding to the symmetry transformation of a).]

For the continuous symmetry in a), we can write infinitesimally
$ phi -> phi' = e^(i e theta) phi = [1 + i e theta + cal(O)(theta^2)] phi = phi + theta underbrace(i e phi, delta phi) + cal(O)(theta^2). $
Furthermore, from $cal(L) = cal(L)'$ we can deduce that
$ cal(L) -> cal(L)' = cal(L) + theta underbrace(delta cal(L), 0) + underbrace(cal(O)(theta^2), 0), quad "i.e. since" delta cal(L) = partial_mu F^mu, quad F^mu = 0. $
Then, using the definition of the Noether current, we find
$ j^mu := (partial cal(L))/(partial(partial_mu phi)) delta phi + (partial cal(L))/(partial(partial_mu phi^dagger)) delta phi^dagger - F^mu = (D^mu phi)^dagger i e phi + (D^mu phi)(-i e phi^dagger). $
From this, the Noether charge can be calculated by integrating the current's zero component over space. Using the mode expansion of the free field (i.e. to zeroth order in $e$ inside $D^0$, so that $D^0 phi -> dot(phi)$),
$ phi(x) = integral (dd(3, p))/(2 pi)^3 1/sqrt(2 E_p) (a_p e^(-i p x) + b_p^dagger e^(i p x)), $
the terms oscillating as $e^(plus.minus 2 i E_p t)$ cancel after the $x$-integration and we find
$
  Q & = integral dd(3, x) j^0 (t, arrow(x)) = i e integral dd(3, x) (phi dot(phi)^dagger - phi^dagger dot(phi)) = -e integral (dd(3, p))/(2 pi)^3 (a_p^dagger a_p - b_p b_p^dagger) \
  & = -e integral (dd(3, p))/(2 pi)^3 (a_p^dagger a_p - b_p^dagger b_p) + "const",
$
where the infinite constant from reordering $b_p b_p^dagger$ is dropped by normal ordering.

#task(label: "c")[Expand the Lagrangian in terms of the interaction terms and state the Feynman rules for the vertices of scalar QED. _Hint:_ What does a derivative $partial^mu$ correspond to in momentum space?]

The only term in (5) representing interaction is the middle one.
$
  (D_mu phi)^dagger D^mu phi & = (partial_mu - i e A_mu) phi^dagger (partial^mu + i e A^mu) phi \
  & = partial_mu phi^dagger partial^mu phi + (partial_mu phi^dagger) i e A^mu phi - i e A_mu phi^dagger partial^mu phi + e^2 A_mu phi^dagger A^mu phi \
  & = partial_mu phi^dagger partial^mu phi + i e (phi partial_mu phi^dagger - phi^dagger partial_mu phi) A^mu + e^2 A_mu A^mu phi^dagger phi.
$
Therefore, the interaction Lagrangian reads
$ cal(L)_"int" = i e (phi partial_mu phi^dagger - phi^dagger partial_mu phi) A^mu + e^2 A_mu A^mu phi^dagger phi. $
The Feynman rules for the vertices of scalar QED are
$
  #feyn({
    scalar((-0.8, -0.7), (0, 0), arrow: true)
    scalar((0, 0), (-0.8, 0.7), arrow: true)
    photon((0, 0), (1.4, 0))
    lbl((-0.85, -0.7), $p$, anchor: "east")
    lbl((-0.85, 0.7), $p'$, anchor: "east")
    lbl((1.45, 0), $mu$, anchor: "west")
  })
  = -i e (p + p')^mu, #h(4em)
  #feyn({
    scalar((-0.7, -0.7), (0, 0))
    scalar((0, 0), (0.7, -0.7))
    photon((-0.7, 0.7), (0, 0))
    photon((0, 0), (0.7, 0.7))
    lbl((-0.75, 0.75), $mu$, anchor: "east")
    lbl((0.75, 0.75), $nu$, anchor: "west")
  })
  = 2 i e^2 eta^(mu nu).
$

= Problem 5 (5 points)

#task(label: "a")[Describe how the Ward--Takahashi identity guarantees that no negative norm states are created in interactions for a massive vector field.]

Same as 3. a) and b), was not discussed in this lecture!

#task(label: "b")[Explain how one can see that the Dirac spinor representation of the Lorentz group is reducible in four dimensions.]

An important concept in representation theory is that of an _irreducible representation_ (irrep). Its representation space does not split into a direct sum of two vector spaces in a manner respected by the group action, i.e. it is not possible to find a basis of the representation space in which
$ R(Lambda) = mat(* , 0; 0, *) quad forall Lambda, $
where $R$ is an automorphism and $Lambda$ a Lorentz transformation.

The Dirac spinor representation of $"Cliff"(1, 3)$ is not irreducible as a representation of $"Spin"(1, 3)$ since the Dirac matrices can be chosen as
$ gamma^0 = mat(0, bb(1); bb(1), 0), quad gamma^i = mat(0, sigma_i; -sigma_i, 0), $
in which case $psi^A$ transforms under a spatial rotation and Lorentz boost ($omega_(0 i) = chi_i$) as
$ psi -> mat(e^(-i/2 alpha arrow(n) dot arrow(sigma)), 0; 0, e^(-i/2 alpha arrow(n) dot arrow(sigma))) psi, quad psi -> mat(e^(-1/2 arrow(chi) dot arrow(sigma)), 0; 0, e^(1/2 arrow(chi) dot arrow(sigma))) psi. $
Thus, the subspaces spanned by $psi_-^T = (psi^1, psi^2, 0, 0)$ and $psi_+^T = (0, 0, psi^3, psi^4)$ transform separately.

Irrespective of the concrete representation, the reducibility of the Dirac spinor representation as a representation for $"Spin"(1, 3)$ can be seen as follows: Define $gamma^5 = i gamma^0 gamma^1 gamma^2 gamma^3$, then the orthogonal projection operators
$ P_plus.minus = 1/2 (bb(1) plus.minus gamma^5) $
have the properties $(P_plus.minus)^2 = P_plus.minus$, $P_+ P_- = 0 = P_- P_+$, and $P_+ + P_- = bb(1)$. If we now define $psi_plus.minus := P_plus.minus psi$, we have $P_plus.minus psi_minus.plus = 0$. Since $[S^(rho sigma), gamma^5] = 0$, we have $P_minus.plus S[Lambda] psi_plus.minus = 0$, i.e. the $+$ and $-$ subspaces of the $"Cliff"(1, 3)$ algebra transform separately under $"Spin"(1, 3)$.

_Remark:_ The $psi_plus.minus$ are called positive (negative) chirality spinors.

#task(label: "c")[
  Consider a scalar field $phi(x)$ in $D$ (instead of 4) dimensions with action
  #tagged(6, $ S = integral dd(D, x) (1/2 partial_mu phi partial^mu phi - 1/2 m^2 phi^2). $)
  State the mass dimension of $phi(x)$. _Hint:_ In units where $planck = c = 1$, what is the mass dimension of an action?
]

Irrespective of the number of spacetime dimensions $D$, the action $S$ in natural units has mass dimension $[S] = 0$. Now since both space and time have mass dimension $[x^mu] = -1$ $forall mu$, every term in the Lagrangian needs $[cal(L)] = D$ for $[S]$ to be zero. Together with $[m^2] = 2$, this requires
$ D = [cal(L)] = [m^2] + [phi^2] = 2 + [phi^2] quad => quad [phi] = 1/2 (D - 2) = D/2 - 1. $

#task(label: "d")[Consider the process $e^+ + e^- -> e^+ + e^-$ in Quantum Electrodynamics. Argue that this process is ultra-violet finite to every order in perturbation theory. _Hint:_ Draw the process in terms of resummed 1PI subdiagrams -- no explicit expansion order by order in perturbation theory. Use general properties and relations of these resummed 1PI diagrams to show that all divergencies cancel.]

Not discussed in our treatment of QFT! Will follow at the beginning of QFT II.
