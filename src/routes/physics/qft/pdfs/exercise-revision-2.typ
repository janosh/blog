#import "/notes.typ": dd, nord, notes, tagged, task
#import "@preview/cetz:0.5.2": canvas, decorations, draw

#show: notes.with(
  title: [Revision of Exercises Somewhat Relevant for the Exam],
  subtitle: [Quantum Field Theory I, Prof. Jürgen Berges],
  date: [Notes by Janosh Riebesell, 08.02.2015],
)

// Feynman slash notation
#let fsl(x) = math.cancel(x, angle: 25deg, length: 110%)

// Feynman diagram helpers: fermion lines carry an arrow at their midpoint, photons are wavy,
// scalars dashed. Coordinates are plain (x, y) tuples in units of `length`.
#let feyn(body, length: 0.6cm) = box(baseline: 50%, inset: (y: 2pt), canvas(length: length, {
  import draw: *
  set-style(stroke: 0.7pt)
  body
}))
#let lerp(a, b, t) = (a.at(0) + t * (b.at(0) - a.at(0)), a.at(1) + t * (b.at(1) - a.at(1)))
#let fermion(a, b, at: 0.58) = {
  draw.line(a, lerp(a, b, at), mark: (end: "stealth", fill: black, scale: 0.5))
  draw.line(lerp(a, b, at - 0.08), b)
}
#let photon(a, b) = decorations.wave(draw.line(a, b), amplitude: 0.1, segment-length: 0.2)
#let scalar(a, b) = draw.line(a, b, stroke: (dash: "dashed", thickness: 0.7pt))
#let vtx(pt) = draw.circle(pt, radius: 0.06, fill: black, stroke: none)
#let lbl(pt, body, anchor: "center") = draw.content(pt, text(size: 7pt, body), anchor: anchor)

// Yukawa 2 -> 2 fermion scattering (problem 10.2): t- and u-channel
#let yuk-t = feyn({
  fermion((-0.6, -0.9), (0, 0)); fermion((0, 0), (-0.6, 0.9)); scalar((0, 0), (1.6, 0))
  fermion((2.2, -0.9), (1.6, 0)); fermion((1.6, 0), (2.2, 0.9))
  lbl((-0.65, -0.9), $p$, anchor: "east"); lbl((-0.65, 0.9), $k$, anchor: "east")
  lbl((2.25, -0.9), $p'$, anchor: "west"); lbl((2.25, 0.9), $k'$, anchor: "west")
})
#let yuk-u = feyn({
  fermion((-0.6, -0.9), (0, 0)); fermion((0, 0), (2.2, 0.9)); scalar((0, 0), (1.6, 0))
  fermion((2.2, -0.9), (1.6, 0)); fermion((1.6, 0), (-0.6, 0.9))
  lbl((-0.65, -0.9), $p$, anchor: "east"); lbl((-0.65, 0.9), $k$, anchor: "east")
  lbl((2.25, -0.9), $p'$, anchor: "west"); lbl((2.25, 0.9), $k'$, anchor: "west")
})
#let yuk-vertex = feyn(length: 0.45cm, {
  fermion((-0.8, -0.7), (0, 0)); fermion((0, 0), (-0.8, 0.7)); scalar((0, 0), (1.2, 0))
  lbl((-0.85, -0.7), $p$, anchor: "east")
})
// Feynman rules of Yukawa theory (problem 10.2 c)
#let rule-in = feyn({ fermion((0, 0), (1.6, 0)); vtx((1.6, 0)); lbl((0.8, 0.15), $p, s$, anchor: "south") })
#let rule-out = feyn({ vtx((0, 0)); fermion((0, 0), (1.6, 0)); lbl((0.8, 0.15), $k, r$, anchor: "south") })
#let rule-scalar = feyn({ scalar((0, 0), (1.8, 0)); lbl((0.9, 0.15), $q$, anchor: "south") })
#let rule-vertex = feyn({
  fermion((-0.7, -0.6), (0, 0)); fermion((0, 0), (-0.7, 0.6)); scalar((0, 0), (1.2, 0)); vtx((0, 0))
  lbl((-0.75, -0.6), $p$, anchor: "east"); lbl((-0.75, 0.6), $k$, anchor: "east"); lbl((0.6, 0.12), $q$, anchor: "south")
})
// Compton scattering (problem 11.2): s- and u-channel
#let compton(crossed) = feyn(length: 0.7cm, {
  let (A, B) = ((1.4, 0), (3, 0))
  fermion((0, 0), A); fermion(A, B); fermion(B, (4.4, 0))
  lbl((0.4, 0.12), $p, s$, anchor: "south"); lbl((4.1, 0.12), $p', s'$, anchor: "south")
  if crossed {
    photon((0.2, -1.2), B); photon(A, (4.2, 1.2))
    lbl((1.3, 0.1), $mu$, anchor: "south-east"); lbl((3, 0.12), $nu$, anchor: "south")
    lbl((3.15, -0.15), $q_2 = p - k'$, anchor: "north-west")
  } else {
    photon((0.2, -1.2), A); photon(B, (4.2, 1.2))
    lbl((1.4, 0.12), $nu$, anchor: "south"); lbl((2.95, 0.1), $mu$, anchor: "south-east")
    lbl((2.2, -0.15), $q_1 = p + k$, anchor: "north")
  }
  lbl((0.15, -1.2), $k, lambda$, anchor: "east"); lbl((4.25, 1.2), $k', lambda'$, anchor: "west")
})
#let compton-s = compton(false)
#let compton-u = compton(true)
// e+ e- -> mu+ mu- via photon exchange (imagined exercise 1)
#let ee-mumu = feyn(length: 0.7cm, {
  let (L, R) = ((0, 0), (1.8, 0))
  fermion((-0.8, 0.8), L); fermion(L, (-0.8, -0.8)); photon(L, R)
  fermion(R, (2.6, 0.8)); fermion((2.6, -0.8), R)
  lbl((-0.85, 0.8), $p, s$, anchor: "east"); lbl((-0.85, -0.8), $k, r$, anchor: "east")
  lbl((2.65, 0.8), $p', s'$, anchor: "west"); lbl((2.65, -0.8), $k', r'$, anchor: "west")
  lbl((0.9, -0.2), $q = p + k$, anchor: "north")
  lbl((0.12, 0.1), $nu$, anchor: "south-west"); lbl((1.68, 0.1), $mu$, anchor: "south-east")
  // antiparticle momentum arrows alongside the lower legs
  draw.line((-0.46, -0.74), (-0.06, -0.34), stroke: 0.45pt, mark: (end: "stealth", fill: black, scale: 0.4))
  draw.line((1.86, -0.34), (2.26, -0.74), stroke: 0.45pt, mark: (end: "stealth", fill: black, scale: 0.4))
})
// Yukawa e- e- -> e- e- (problem 11.1 a): t- and u-channel
#let ee-yuk(crossed) = feyn(length: 0.75cm, {
  let (T, B) = ((1, 0.6), (1, -0.6))
  fermion((0, 1.1), T); fermion((0, -1.1), B); scalar(T, B)
  if crossed { fermion(T, (2, -1.1)); fermion(B, (2, 1.1)) } else { fermion(T, (2, 1.1)); fermion(B, (2, -1.1)) }
  lbl((-0.05, 1.1), $p, s$, anchor: "east"); lbl((-0.05, -1.1), $k, r$, anchor: "east")
  lbl((2.05, 1.1), if crossed [$p', s'$] else [$p', s'$], anchor: "west")
  lbl((2.05, -1.1), $k', r'$, anchor: "west")
  if crossed { lbl((0.88, 0), $q_2 = p - k'$, anchor: "east") } else { lbl((1.12, 0), $q_1 = p - p'$, anchor: "west") }
})
#let ee-t = ee-yuk(false)
#let ee-u = ee-yuk(true)
// Yukawa e+ e- -> e+ e- (problem 11.1 b): t- and s-channel
#let ep-t = feyn(length: 0.75cm, {
  let (T, B) = ((1, 0.6), (1, -0.6))
  fermion((0, 1.1), T); fermion(T, (2, 1.1)); scalar(T, B)
  fermion(B, (0, -1.1)); fermion((2, -1.1), B)
  lbl((-0.05, 1.1), $e^-, p, s$, anchor: "east"); lbl((2.05, 1.1), $e^-, p', s'$, anchor: "west")
  lbl((-0.05, -1.1), $e^+, k, r$, anchor: "east"); lbl((2.05, -1.1), $e^+, k', r'$, anchor: "west")
  lbl((1.12, 0), $t = p - p'$, anchor: "west")
  // positron momentum arrows below the lower legs
  draw.line((0.33, -1.135), (0.83, -0.885), stroke: 0.45pt, mark: (end: "stealth", fill: black, scale: 0.4))
  draw.line((1.17, -0.885), (1.67, -1.135), stroke: 0.45pt, mark: (end: "stealth", fill: black, scale: 0.4))
})
#let ep-s = feyn(length: 0.75cm, {
  let (L, R) = ((0, 0), (1.6, 0))
  fermion((-0.8, 0.8), L); fermion(L, (-0.8, -0.8)); scalar(L, R)
  fermion(R, (2.4, 0.8)); fermion((2.4, -0.8), R)
  lbl((-0.85, 0.8), $e^-, p, s$, anchor: "east"); lbl((-0.85, -0.8), $e^+, k, r$, anchor: "east")
  lbl((2.45, 0.8), $e^-, p', s'$, anchor: "west"); lbl((2.45, -0.8), $e^+, k', r'$, anchor: "west")
  lbl((0.8, 0.15), $s = p + k$, anchor: "south")
  // positron momentum arrows alongside the lower legs
  draw.line((-0.47, -0.73), (-0.07, -0.33), stroke: 0.45pt, mark: (end: "stealth", fill: black, scale: 0.4))
  draw.line((1.67, -0.33), (2.07, -0.73), stroke: 0.45pt, mark: (end: "stealth", fill: black, scale: 0.4))
})

= Problem 1.1 (Lorentz transformation)

#task[
  A Lorentz transformation acts on spacetime 4-vectors $x^mu$ with $mu in {0, i}$ and $i in {1, 2, 3}$ as
  $ x^mu -> x'^mu = Lambda^mu_nu x^nu $
  such that $x^2 = x^mu x^nu eta_(mu nu)$ is invariant with $"diag"(eta_(mu nu)) = (1, -1, -1, -1)$.
]

#task(label: "a")[Given two spacetime points $x^mu$ and $y^mu$, show that if $(x - y)^2 > 0$, one can always find a frame in which the spatial distance vanishes, $x^i = y^i$. Show that if $(x - y)^2 < 0$, one can always find a frame where $x^0 = y^0$.]

The defining relation of the Lorentz algebra $frak(s o)(1, 3)$ is
$ Lambda^alpha_rho Lambda^gamma_sigma eta_(alpha gamma) = eta_(rho sigma), quad "where" quad eta_(alpha gamma) = eta_(rho sigma), $
i.e. $frak(s o)(1, 3)$ is the set of all transformations that leave the metric invariant. For simplicity, we now consider a coordinate system in which it holds that
$ Delta^mu = x^mu - y^mu = (Delta^0, arrow(Delta)) = (Delta^0, Delta^1, 0, 0). $
We can then reduce the problem to two dimensions in which we transform by
$ eta_2 = mat(1, 0; 0, -1) = Lambda^T mat(1, 0; 0, -1) Lambda = Lambda^T eta_2 Lambda, quad "with" quad Lambda = mat(cosh(alpha), -sinh(alpha); -sinh(alpha), cosh(alpha)), $
which gives in the case of $Delta$
$ Delta'_2 = vec(Delta^(0'), Delta^(1')) = mat(cosh(alpha), -sinh(alpha); -sinh(alpha), cosh(alpha)) vec(Delta^0, Delta^1) = vec(Delta^0 cosh(alpha) - Delta^1 sinh(alpha), -Delta^0 sinh(alpha) + Delta^1 cosh(alpha)) = Lambda Delta. $
We now have a system of equations in which we can set $Delta^(0') = Delta^(1') = 0$ to see what conditions arise for $Delta^0$ and $Delta^1$ when we demand $x_2$ and $y_2$ to occur at the same time and place respectively:
#tagged(1, $ Delta^(0') = 0: quad Delta^0 cosh(alpha) = Delta^1 sinh(alpha) quad ==> quad Delta^0 = tanh(alpha) Delta^1, $)
#tagged(2, $ Delta^(1') = 0: quad Delta^0 sinh(alpha) = Delta^1 cosh(alpha) quad ==> quad Delta^1 = tanh(alpha) Delta^0. $)
Since $tanh(alpha) in (-1, 1) med forall alpha in RR$ and therefore in particular $tanh(alpha) < 1 med forall alpha in RR$, we have found that if $(x - y)^2 > 0$ or rather $(x_2 - y_2)^2 = Delta^2 = (Delta^0)^2 - (Delta^1)^2 > 0$, i.e. $Delta^0 > Delta^1$, we can indeed find such an $alpha$ that fulfills (1)
$ Delta^0 = tanh(alpha) Delta^1, $
which implies $Delta^(0') = 0$. In other words, if $(x - y)^2 > 0$ there exists such an $alpha$ that the reference frame reached by transforming with $Lambda(alpha)$ observes $x$ and $y$ to occur at the same time. However, there can be no $alpha in RR$ such that $Delta^1 = tanh(alpha) Delta^0$ in this setup. On the other hand, if we look at $(x - y)^2 < 0$ which amounts to $Delta^0 < Delta^1$, there can be no $alpha$ to fulfill (1) but instead (2) is possible, suggesting that for this setup, there is always a frame in which $x$ and $y$ happen at the same place.

#task(label: "b")[Given a scalar field theory with Lagrangian $cal(L)(phi(x), partial_mu phi(x))$, show that the object $(partial cal(L)(x))/(partial(partial_mu phi(x)))$ transforms like a 4-vector under Lorentz transformations.]

We show this by simply applying a Lorentz transformation to this expression, where we keep in mind that $cal(L)$ is necessarily a Lorentz scalar. We define $partial_(mu') = partial/(partial x'^mu)$.
$
  (partial cal(L)(x))/(partial(partial_mu phi(x))) & --> (partial cal(L)(x'))/(partial(partial_(mu') phi(x'))) = (partial cal(L)(x'))/(partial(partial_rho phi(x'))) (partial(partial_rho phi(x')))/(partial(partial_(mu') phi(x'))) = (partial cal(L)(x))/(partial(partial_rho phi(x'))) partial/(partial(partial_(mu') phi(x'))) underbrace((partial x'^nu)/(partial x^rho), "constant") (partial phi(x'))/(partial x'^nu) \
  & = underbrace((partial x'^nu)/(partial x^rho), Lambda^nu_rho) (partial cal(L)(x))/(partial(partial_rho phi(x))) underbrace((partial(partial_nu phi(x')))/(partial(partial_(mu') phi(x'))), delta_(mu' nu)) = Lambda^(mu')_mu (partial cal(L)(x'))/(partial(partial_mu phi(x'))).
$

= Problem 10.1 (LSZ versus Interaction picture perturbation theory)

#task[
  We would like to compare the exact LSZ result for the scattering matrix with a more naive approach which is inspired by Quantum Mechanical perturbation theory in the Interaction picture.

  We model the in- and outgoing states as free particle states in the Interaction picture
  $ |p_I chevron.r = sqrt(2 E_p) a_I^dagger (p) |0 chevron.r, $
  where $a_I^dagger (p)$ are the modes of the free Interaction picture fields and $|0 chevron.r$ is the free vacuum in the Interaction picture. The time-evolution of such Interaction picture states is governed by the time-evolution operator $U(t, t_0)$ such that
  $ |p_I (t) chevron.r = U(t, t_0) |p_I (t_0) chevron.r, quad "where" quad U(t, t_0) = T exp(-i integral_(t_0)^t H_I (t') dif t'). $
  The scattering amplitude is then given by
  $ chevron.l p_I^1, ..., p_I^n | T exp(-i integral_(-oo)^oo H_I (t') dif t') | q_I^1, ..., q_I^n chevron.r. $
]

#task(label: "a")[Critise this prescription from your understanding of the exact LSZ result and the underlying theory of asymptotic in- and outstates.]

Asymptotic in- and outstates derive from the full interacting theory. Consequently, while not interacting with each other for $t -> plus.minus oo$, they perform self-interactions, thereby accounting for central features of the interacting theory such as the wavefunction renormalization $Z = 1 + cal(O)(lambda)$ and the fully renormalized mass $m != m_0$. In the Interaction picture perturbation theory approach, in- and outgoing states are modelled as free particle states which discards all of the above mentioned corrections. Moreover, these states are created from the free vacuum $|0 chevron.r$ as opposed to the vacuum of the full interacting theory $|Omega chevron.r$ used in the LSZ formalism.

To leading order in the interacting theory's coupling, both formalisms agree because
- we consider only amputated, fully connected diagrams, where the amputated means that we have no factors of $1/(p^2 - m^2)$ in which the renormalized mass $m != m_0$ could show up.
- both $|Omega chevron.r$ and $Z$ are of the form $|Omega chevron.r = (1 + cal(O)(lambda)) |0 chevron.r$ and $Z = 1 + cal(O)(lambda)$, so that to leading order only the $1$ contributes.

#task(label: "b")[
  In the Interaction picture approach, we can perform leading-order scattering amplitude computations very explicitly and from scratch. Compute the amplitude for 2-2 scattering in $phi^4$-theory in this fashion by evaluating
  $ chevron.l p_I^1, p_I^2 | T integral dd(4, x) (-i lambda)/4! phi_I^4 (x) | q_I^1, q_I^2 chevron.r. $
  _Hint:_ Expand $phi_I (x) = phi_I^+ (x) + phi_I^- (x)$. Argue that only terms with precisely two copies of $phi_I^+ (x)$ and $phi_I^- (x)$ contribute and evaluate the matrix elements by commuting creation and annihilation operators appropriately.
]

We first note that when applying Wick's theorem, we need not consider internal contractions since we are looking specifically at nontrivial scattering of four particles by one vertex that can have only four connections.
$
  T phi_I^4 (x) & = nord(phi_I^4 (x)) + "'terms with internal contractions (will be dropped henceforth)'" \
  & = nord(phi_I^+ phi_I^+ phi_I^+ phi_I^+ + phi_I^+ phi_I^+ phi_I^+ phi_I^- + phi_I^+ phi_I^+ phi_I^- phi_I^+ + phi_I^+ phi_I^+ phi_I^- phi_I^- + phi_I^+ phi_I^- phi_I^+ phi_I^+ \
    & quad + phi_I^+ phi_I^- phi_I^+ phi_I^- + phi_I^+ phi_I^- phi_I^- phi_I^+ + phi_I^+ phi_I^- phi_I^- phi_I^- + "'same again with" phi_I^- "in front'").
$
As hinted, we consider only those of these 16 terms which contain each two $phi_I^+$ and $phi_I^-$. We can understand why this is legitimate from looking at how $phi_I^+$ and $a^dagger (p)$ commute
$ [phi_I^+ (x), a^dagger (p)] = integral (dd(3, q))/(2 pi)^3 e^(-i q x)/sqrt(2 E_q) [a(q), a^dagger (p)] = integral (dd(3, q))/(2 pi)^3 e^(-i q x)/sqrt(2 E_q) (2 pi)^3 delta^((3)) (arrow(q) - arrow(p)) = e^(-i p x)/sqrt(2 E_p) =: alpha_p/sqrt(2 E_p), $
$
  phi_I^+ (x) phi_I^+ (x) |p_I^1, p_I^2 chevron.r & = phi_I^+ (x) phi_I^+ (x) sqrt(2 E_(p_1)) sqrt(2 E_(p_2)) a_I^dagger (p_1) a_I^dagger (p_2) |0 chevron.r \
  & = sqrt(2 E_(p_1)) sqrt(2 E_(p_2)) phi_I^+ (x) a_I^dagger (p_1) phi_I^+ (x) a_I^dagger (p_2) |0 chevron.r + alpha_(p_1) sqrt(2 E_(p_2)) phi_I^+ (x) a_I^dagger (p_2) |0 chevron.r \
  & = sqrt(2 E_(p_1)) sqrt(2 E_(p_2)) phi_I^+ (x) a_I^dagger (p_1) a_I^dagger (p_2) underbrace(phi_I^+ (x) |0 chevron.r, 0) + alpha_(p_2) sqrt(2 E_(p_1)) phi_I^+ (x) a_I^dagger (p_1) |0 chevron.r \
  & quad + alpha_(p_1) sqrt(2 E_(p_2)) a_I^dagger (p_2) underbrace(phi_I^+ (x) |0 chevron.r, 0) + alpha_(p_1) alpha_(p_2) |0 chevron.r \
  & = alpha_(p_2) sqrt(2 E_(p_1)) a_I^dagger (p_1) underbrace(phi_I^+ (x) |0 chevron.r, 0) + alpha_(p_1) alpha_(p_2) |0 chevron.r + alpha_(p_1) alpha_(p_2) |0 chevron.r = 2 alpha_(p_1) alpha_(p_2) |0 chevron.r.
$
Now since $alpha_i = e^(-i p_i x) in CC$ ($in.not$ state space), we see that as soon as we act on the state $|p_I^1, p_I^2 chevron.r$ with another set of positive frequency modes, it vanishes. This also holds true for the state $chevron.l p_I^1, p_I^2|$ acted upon by $phi_I^- (x) phi_I^- (x)$ because
$ chevron.l p_I^1, p_I^2 | phi_I^- (x) phi_I^- (x) = (phi_I^+ (x) phi_I^+ (x) |p_I^1, p_I^2 chevron.r)^dagger = (2 alpha_(p_1) alpha_(p_2) |0 chevron.r)^dagger = chevron.l 0 | 2 alpha_(p_1)^* alpha_(p_2)^*. $
As soon as we act on $chevron.l p_I^1, p_I^2|$ with a third $phi_I^- (x)$, it too vanishes. We therefore have for the time-ordered product of $phi^4 (x)$
$
  T phi_I^4 (x) & = nord(phi_I^+ phi_I^- phi_I^+ phi_I^- + phi_I^+ phi_I^- phi_I^- phi_I^+ + phi_I^- phi_I^+ phi_I^+ phi_I^- + phi_I^- phi_I^+ phi_I^- phi_I^+ + phi_I^- phi_I^- phi_I^+ phi_I^+ + phi_I^+ phi_I^+ phi_I^- phi_I^-) \
  & quad + "'terms not contributing to scattering amplitude'" \
  & = 6 phi_I^- (x) phi_I^- (x) phi_I^+ (x) phi_I^+ (x) + "'terms not contributing to scattering amplitude'".
$
Inserting this finding into the expression we would like to evaluate gives
$
  chevron.l p_I^1, p_I^2 | T integral dd(4, x) (-i lambda)/4! phi_I^4 (x) | q_I^1, q_I^2 chevron.r & = -(i lambda)/4! integral dd(4, x) chevron.l p_I^1, p_I^2 | 6 phi_I^- (x) phi_I^- (x) phi_I^+ (x) phi_I^+ (x) | q_I^1, q_I^2 chevron.r \
  & = -(i lambda)/4 integral dd(4, x) chevron.l 0 | 2 alpha_(p_1)^* alpha_(p_2)^* 2 alpha_(q_1) alpha_(q_2) | 0 chevron.r = -i lambda integral dd(4, x) e^(i p_1 x) e^(i p_2 x) e^(-i q_1 x) e^(-i q_2 x) underbrace(chevron.l 0 | 0 chevron.r, 1) \
  & = -i lambda (2 pi)^4 delta^((4)) (p_1 + p_2 - q_1 - q_2),
$
where $cal(M) = -lambda$ is the actual scattering amplitude.

= Problem 10.2 (Yukawa interactions and Feynman rules)

#task[
  Consider the following Lagrangian
  $ cal(L) = 1/2 partial_mu phi partial^mu phi - 1/2 m_phi^2 phi^2 + overline(Psi) (i gamma^mu partial_mu - m) Psi - g phi overline(Psi) Psi $
  of a massive Dirac fermion $Psi$ and a massive real scalar field $phi$ coupled by what is called a Yukawa interaction with a real coupling constant $g$.
]

#task(label: "a")[Deduce the mass dimension of the coupling $g$.]

Evidently $[S] = 0 -> [cal(L)] = 4 -> [phi] = 1, [Psi] = 3/2 -> [g] = 0$.

#task(label: "b")[
  In the previous exercise, we discussed a quick way to compute the $S$-matrix to leading order in the coupling constant directly in the quantum mechanical Interaction picture. Use this procedure to compute, from scratch, the complete leading order scattering amplitude for the scattering of two fermions with ingoing momenta $p$ and $p'$ in Yukawa theory. The result is
  $
    i cal(M) & = #yuk-t + #yuk-u \
    & = (-i g)^2 (overline(u)(k) u(p) 1/((k - p)^2 - m_phi^2) overline(u)(k') u(p') - overline(u)(k') u(p) 1/((k - p')^2 - m_phi^2) overline(u)(k) u(p')).
  $
]

By taking $p, p'$ and $k, k'$ to be distinct, we effectively exclude zero-vertex diagrams, i.e. $chevron.l k, k' | p, p' chevron.r = 0$. From looking at the Yukawa interaction $cal(L)_"int" = -g phi overline(Psi) Psi$ however, it is immediately obvious that one-vertex diagrams, i.e. #yuk-vertex, cannot produce this type of scattering either. Leading order in this case therefore means second order in the coupling constant.
$
  S_(f i) & = chevron.l k, k' | U(oo, -oo) | p, p' chevron.r = chevron.l k, k' | T exp(-i integral_(-oo)^oo H_I (t) dif t) | p, p' chevron.r = underbrace(chevron.l k\, k' | T bb(1) | p\, p' chevron.r, 0) \
  & quad + underbrace(chevron.l k\, k' | T(-i integral_(-oo)^oo H_I (t) dif t) | p\, p' chevron.r, 0) + chevron.l k, k' | T 1/2! (-i integral_(-oo)^oo H_I (t) dif t)^2 | p, p' chevron.r + cal(O)(g^3),
$
where the integral over time can be expanded to an integral over spacetime via
$
  integral_(-oo)^oo H_I (t) dif t & = integral_(-oo)^oo integral_(RR^3) cal(H)_I (t, arrow(x)) dd(3, x) dif t = integral dd(4, x) e^(i H_0 (t - t_0)) underbrace(cal(H)_"int", -cal(L)_"int") e^(-i H_0 (t - t_0)) \
  & = g integral dd(4, x) e^(i H_0 (t - t_0)) phi e^(-i H_0 (t - t_0)) e^(i H_0 (t - t_0)) overline(Psi) e^(-i H_0 (t - t_0)) e^(i H_0 (t - t_0)) Psi e^(-i H_0 (t - t_0)) = g integral dd(4, x) phi_I overline(Psi)_I Psi_I.
$
Inserting the integral over Interaction picture into $S = S_(f i) - cal(O)(g^3)$ gives
#tagged(1, $ S = 1/2 (-i g)^2 integral dd(4, x) integral dd(4, y) chevron.l k, k' | T phi_I (x) overline(Psi)_I (x) Psi_I (x) phi_I (y) overline(Psi)_I (y) Psi_I (y) | p, p' chevron.r. $)
We now apply Wick's theorem to the above time-ordered product of six fields, where we keep in mind that terms relevant for our type of scattering need to contain exactly four uncontracted fermions and zero uncontracted scalars. For brevity, we write $phi_I (x)$, $overline(Psi)_I (x)$ and $Psi_I (x)$ as $phi_x$, $overline(Psi)_x$ and $Psi_x$.
$ T phi_x overline(Psi)_x Psi_x phi_y overline(Psi)_y Psi_y = nord(overbracket(phi_x phi_y) overline(Psi)_x Psi_x overline(Psi)_y Psi_y) + "'terms not contributing to our type of scattering'" $
In the only relevant term of the Wick expansion, the contracted scalar fields form a propagator $overbracket(phi_x phi_y) = D_F^phi (x - y)$, which is merely a complex number and can therefore be pulled out of the normal-ordering. When normal-ordering the four remaining fermionic fields, we get a total of 16 terms. Of these, we again need to consider only those that contain precisely two copies of $Psi^+$ and $overline(Psi)^-$.
$
  nord(overline(Psi)_x Psi_x overline(Psi)_y Psi_y) = & nord(overline(Psi)_x^+ Psi_x^+ overline(Psi)_y^+ Psi_y^+ + overline(Psi)_x^+ Psi_x^+ overline(Psi)_y^+ Psi_y^- + overline(Psi)_x^+ Psi_x^+ overline(Psi)_y^- Psi_y^+ + overline(Psi)_x^+ Psi_x^+ overline(Psi)_y^- Psi_y^- \
    & + overline(Psi)_x^+ Psi_x^- overline(Psi)_y^+ Psi_y^+ + overline(Psi)_x^+ Psi_x^- overline(Psi)_y^+ Psi_y^- + overline(Psi)_x^+ Psi_x^- overline(Psi)_y^- Psi_y^+ + overline(Psi)_x^+ Psi_x^- overline(Psi)_y^- Psi_y^- \
    & + overline(Psi)_x^- Psi_x^+ overline(Psi)_y^+ Psi_y^+ + overline(Psi)_x^- Psi_x^+ overline(Psi)_y^+ Psi_y^- + overline(Psi)_x^- Psi_x^+ overline(Psi)_y^- Psi_y^+ + overline(Psi)_x^- Psi_x^+ overline(Psi)_y^- Psi_y^- \
    & + overline(Psi)_x^- Psi_x^- overline(Psi)_y^+ Psi_y^+ + overline(Psi)_x^- Psi_x^- overline(Psi)_y^+ Psi_y^- + overline(Psi)_x^- Psi_x^- overline(Psi)_y^- Psi_y^+ + overline(Psi)_x^- Psi_x^- overline(Psi)_y^- Psi_y^-) \
  = & (-1)^4 overline(Psi)_y^- Psi_y^- overline(Psi)_x^+ Psi_x^+ + (-1)^3 Psi_x^- Psi_y^- overline(Psi)_x^+ overline(Psi)_y^+ + (-1)^2 Psi_x^- overline(Psi)_y^- overline(Psi)_x^+ Psi_y^+ \
    & + (-1)^2 overline(Psi)_x^- Psi_y^- Psi_x^+ overline(Psi)_y^+ + (-1) overline(Psi)_x^- overline(Psi)_y^- Psi_x^+ Psi_y^+ + overline(Psi)_x^- Psi_x^- overline(Psi)_y^+ Psi_y^+ \
    & + "'terms not contributing'"
$
Of these six normal-ordered terms above only one represents a possible scattering process involving only fermions (as opposed to antifermions), namely those not containing any $Psi^-$ and $overline(Psi)^+$ since those contain the $b$-modes for whom a pure fermion state is indistinguishable from the vacuum.
$
  Psi(x) & = Psi^+ (x) + Psi^- (x) = sum_s (integral (dd(3, p))/(2 pi)^3 1/sqrt(2 E_p) a_s (p) u_s (p) e^(-i p x) + integral (dd(3, p))/(2 pi)^3 1/sqrt(2 E_p) b_s^dagger (p) v_s (p) e^(i p x)), \
  overline(Psi)(x) & = overline(Psi)^- (x) + overline(Psi)^+ (x) = sum_s (integral (dd(3, p))/(2 pi)^3 1/sqrt(2 E_p) a_s^dagger (p) overline(u)_s (p) e^(i p x) + integral (dd(3, p))/(2 pi)^3 1/sqrt(2 E_p) b_s (p) overline(v)_s (p) e^(-i p x)),
$
$ Psi^- |p_1, ..., p_n chevron.r = chevron.l p_1, ..., p_n | overline(Psi)^+ = 0, quad "where the" p_i "are an arbitrary number of fermions." $
Inserting this one relevant term for the time-ordered product in eq. (1),
$ S = -1/2 (-i g)^2 integral dd(4, x) integral dd(4, y) D_F^phi (x - y) chevron.l p, p' | overline(Psi)_x^- overline(Psi)_y^- Psi_x^+ Psi_y^+ | k, k' chevron.r, quad "where" quad |p, p' chevron.r = sqrt(2 E_p) sqrt(2 E_(p')) a_s^dagger (p) a_(s')^dagger (p') |0 chevron.r. $
We would like to commute the fields through the modes in the above expression. To do so, we calculate their commutation relations
$
  {Psi^+ (x), a_s^dagger (p)} & = sum_(s') integral (dd(3, p'))/(2 pi)^3 e^(-i p' x)/sqrt(2 E_(p')) u_(s') (p') {a_(s') (p'), a_s^dagger (p)} = e^(-i p x)/sqrt(2 E_p) u_s (p), \
  {overline(Psi)^- (x), a_s (p)} & = sum_(s') integral (dd(3, p'))/(2 pi)^3 e^(i p' x)/sqrt(2 E_(p')) overline(u)_(s') (p') {a_(s')^dagger (p'), a_s (p)} = e^(i p x)/sqrt(2 E_p) overline(u)_s (p).
$
With these we can simplify $Psi_x^+ Psi_y^+ |k, k' chevron.r$ to
$
  Psi_x^+ Psi_y^+ & sqrt(2 E_k) sqrt(2 E_(k')) a_r^dagger (k) a_(r')^dagger (k') |0 chevron.r = -sqrt(2 E_k) sqrt(2 E_(k')) Psi_x^+ a_r^dagger (k) Psi_y^+ a_(r')^dagger (k') |0 chevron.r + sqrt(2 E_(k')) e^(-i k y) u_r (k) Psi_x^+ a_(r')^dagger (k') |0 chevron.r \
  & = sqrt(2 E_k) sqrt(2 E_(k')) Psi_x^+ a_r^dagger (k) a_(r')^dagger (k') underbrace(Psi_y^+ |0 chevron.r, 0) - sqrt(2 E_k) e^(-i k' y) u_(r') (k') Psi_x^+ a_r^dagger (k) |0 chevron.r - sqrt(2 E_(k')) e^(-i k y) u_r (k) a_(r')^dagger (k') underbrace(Psi_x^+ |0 chevron.r, 0) \
  & quad + e^(-i k y) e^(-i k' x) u_r (k) u_(r') (k') |0 chevron.r = sqrt(2 E_k) e^(-i k' y) u_(r') (k') a_r^dagger (k) underbrace(Psi_x^+ |0 chevron.r, 0) - e^(-i k' y) e^(-i k x) u_(r') (k') u_r (k) |0 chevron.r \
  & quad + e^(-i k y) e^(-i k' x) u_r (k) u_(r') (k') |0 chevron.r = (e^(-i k y) e^(-i k' x) u_r (k) u_(r') (k') - e^(-i k' y) e^(-i k x) u_r (k) u_(r') (k')) |0 chevron.r.
$
Similarly,
$
  chevron.l 0 | a_s (p) & a_(s') (p') sqrt(2 E_p) sqrt(2 E_(p')) overline(Psi)_x^- overline(Psi)_y^- = -chevron.l 0 | a_s (p) overline(Psi)_x^- a_(s') (p') overline(Psi)_y^- sqrt(2 E_p) sqrt(2 E_(p')) \
  & quad + chevron.l 0 | a_s (p) overline(Psi)_y^- sqrt(2 E_p) e^(i p' x) overline(u)_(s') (p') = -chevron.l 0 | a_s (p) overline(Psi)_x^- sqrt(2 E_p) e^(i p' y) overline(u)_(s') (p') \
  & quad + chevron.l 0 | e^(i p' x) e^(i p y) overline(u)_s (p) overline(u)_(s') (p') = -chevron.l 0 | e^(i p x) e^(i p' y) overline(u)_s (p) overline(u)_(s') (p') + chevron.l 0 | e^(i p' x) e^(i p y) overline(u)_s (p) overline(u)_(s') (p') \
  & = chevron.l 0 | (e^(i p' x) e^(i p y) overline(u)_s (p) overline(u)_(s') (p') - e^(i p x) e^(i p' y) overline(u)_(s') (p') overline(u)_s (p)),
$
$
  chevron.l p, p' | overline(Psi)_x^- overline(Psi)_y^- Psi_x^+ Psi_y^+ | k, k' chevron.r & = chevron.l 0 | e^(i (p' - k') x) e^(i (p - k) y) overline(u)_s (p) overline(u)_(s') (p') u_r (k) u_(r') (k') | 0 chevron.r \
  & quad - chevron.l 0 | e^(i (p' - k) x) e^(i (p - k') y) overline(u)_s (p) overline(u)_(s') (p') u_r (k) u_(r') (k') | 0 chevron.r \
  & quad - chevron.l 0 | e^(i (p - k') x) e^(i (p' - k) y) overline(u)_(s') (p') overline(u)_s (p) u_r (k) u_(r') (k') | 0 chevron.r \
  & quad + chevron.l 0 | e^(i (p - k) x) e^(i (p' - k') y) overline(u)_(s') (p') overline(u)_s (p) u_r (k) u_(r') (k') | 0 chevron.r.
$
Inserting $D_F^phi (x - y) = integral (dd(4, q))/(2 pi)^4 (i e^(-i q (x - y)))/(q^2 - m_phi^2)$ into $S$, we can perform all integrals explicitly
$
  S & = -1/2 (-i g)^2 integral (dd(4, q))/(2 pi)^4 i/(q^2 - m_phi^2) integral dd(4, x) integral dd(4, y) (e^(i (p' - k' - q) x) e^(i (p - k + q) y) overline(u)_s (p) overline(u)_(s') (p') u_r (k) u_(r') (k') \
    & quad - e^(i (p' - k - q) x) e^(i (p - k' + q) y) overline(u)_s (p) overline(u)_(s') (p') u_r (k) u_(r') (k') - e^(i (p - k' - q) x) e^(i (p' - k + q) y) overline(u)_(s') (p') overline(u)_s (p) u_r (k) u_(r') (k') \
    & quad + e^(i (p - k - q) x) e^(i (p' - k' + q) y) overline(u)_(s') (p') overline(u)_s (p) u_r (k) u_(r') (k')) \
  & = -1/2 (-i g)^2 (overline(u)_(s') (p') u_(r') (k') i/((p' - k')^2 - m_phi^2) overline(u)_s (p) u_r (k) (2 pi)^4 delta^((4)) (p' - k' + p - k) \
    & quad - overline(u)_(s') (p') u_r (k) i/((p' - k)^2 - m_phi^2) overline(u)_s (p) u_(r') (k') (2 pi)^4 delta^((4)) (p' - k + p - k') \
    & quad - overline(u)_s (p) u_(r') (k') i/((p - k')^2 - m_phi^2) overline(u)_(s') (p') u_r (k) (2 pi)^4 delta^((4)) (p - k' + p' - k) \
    & quad + overline(u)_s (p) u_r (k) i/((p - k)^2 - m_phi^2) overline(u)_(s') (p') u_(r') (k') (2 pi)^4 delta^((4)) (p - k + p' - k')) \
  & attach(=, t: p + p' = k + k') (-i g)^2 (overline(u)_s (p) u_r (k) i/((p - k)^2 - m_phi^2) overline(u)_(s') (p') u_(r') (k') - overline(u)_s (p) u_(r') (k') i/((p - k')^2 - m_phi^2) overline(u)_(s') (p') u_r (k)) \
    & quad times (2 pi)^4 delta^((4)) (p + p' - k - k').
$

#task(label: "c")[Based on this computation, guess the Feynman rules for the Yukawa interaction $-g phi overline(Psi) Psi$.]

From the calculation performed in part b), we can guess the following Feynman rules:
- for every ingoing fermion $Psi$ of momentum $p$ and spin $s$, associate a factor of $u_s (p) hat(=)$ #rule-in
- for every outgoing fermion $overline(Psi)$ of momentum $k$ and spin $r$, associate a factor of $overline(u)_r (k) hat(=)$ #rule-out
- for every internal scalar $phi$ of momentum $q$, associate a factor of $i/(q^2 - m_phi^2) hat(=)$ #rule-scalar
- for every vertex $-g phi overline(Psi) Psi$, associate a factor of $-i g (2 pi)^4 delta^((4)) (p + k - q) hat(=)$ #rule-vertex
- integrate over undetermined internal momenta $integral dd(4, q_i)$
- sum up all distinct Feynman diagrams to given order (with a relative minus for every two fermions crossing).

= Problem 11.2 (The Klein--Nishina formula)

#task[We now look at the process of Compton scattering at tree-level in QED.]

#task(label: "a")[
  Use the Feynman rules in the script to write down the tree-level Compton scattering amplitude and bring it into the form
  $ i cal(M) = i e^2 epsilon_mu^* (k', lambda') epsilon_nu (k, lambda) overline(u)_(s') (p') ((gamma^mu fsl(k) gamma^nu + 2 gamma^mu p^nu)/(2 p k) + (gamma^nu fsl(k)' gamma^mu - 2 gamma^nu p^mu)/(2 p k')) u_s (p). $
]

Compton scattering has contributions from exactly two distinct fully connected, amputated diagrams at tree-level
$
  i cal(M) & = #compton-s + #compton-u \
  & = overline(u)_(s') (p') (-i e gamma^mu) epsilon_mu^* (k', lambda') (i (fsl(q)_1 + m_psi))/(q_1^2 - m_psi^2) epsilon_nu (k, lambda) (-i e gamma^nu) u_s (p) \
  & quad + overline(u)_(s') (p') (-i e gamma^nu) epsilon_nu (k, lambda) (i (fsl(q)_2 + m_psi))/(q_2^2 - m_psi^2) epsilon_mu^* (k', lambda') (-i e gamma^mu) u_s (p) \
  & = -i e^2 epsilon_mu^* (k', lambda') epsilon_nu (k, lambda) overline(u)_(s') (p') (gamma^mu (fsl(p) + fsl(k) + m_psi)/((p + k)^2 - m_psi^2) gamma^nu + gamma^nu (fsl(p) - fsl(k)' + m_psi)/((p - k')^2 - m_psi^2) gamma^mu) u_s (p).
$
Using the energy-momentum relation of fermions and photons, we can simplify the denominators to $(p + k)^2 - m_psi^2 = p^2 + 2 p k + underbrace(k^2, 0) - m_psi^2 = 2 p k$ and $(p - k')^2 - m_psi^2 = -2 p k'$.
Simplification of the numerators requires $gamma$-matrix manipulations and the Dirac eq.
$ (fsl(p) + m_psi) gamma^nu u_s (p) = (-gamma^nu fsl(p) + 2 eta^(mu nu) p_mu + m_psi gamma^nu) u_s (p) = gamma^nu underbrace((-fsl(p) + m_psi) u_s (p), 0) + 2 p^nu u_s (p), $
$ i cal(M) = -i e^2 epsilon_mu^* (k', lambda') epsilon_nu (k, lambda) overline(u)_(s') (p') ((gamma^mu fsl(k) gamma^nu + 2 gamma^mu p^nu)/(2 p k) + (gamma^nu fsl(k)' gamma^mu - 2 gamma^nu p^mu)/(2 p k')) u_s (p). $

#task(label: "b")[Parts b) through g) of this exercise are not relevant for the exam.]

= Imagined Exercise 1 (Electron-positron-to-muon-antimuon scattering)

#task[Apply the momentum space Feynman rules of quantum electrodynamics to derive an algebraic expression for the full leading-order scattering amplitude of the process $e^+ + e^- -> mu^+ + mu^-$.]

Electron-positron-to-muon-antimuon scattering has one diagram contributing at tree-level (leading order). The scattering amplitude therefore reads
$
  i cal(M) = #ee-mumu & = overline(u)_(s') (p') (-i e gamma^mu) v_(r') (k') (-i eta_(mu nu))/q^2 overline(v)_r (k) (-i e gamma^nu) u_s (p) \
  & = i e^2 overline(u)_(s') (p') gamma^mu v_(r') (k') 1/(p + k)^2 overline(v)_r (k) gamma_mu u_s (p) = i/2 e^2 overline(u)_(s') (p') gamma^mu v_(r') (k') 1/(m^2 + p k) overline(v)_r (k) gamma_mu u_s (p).
$

= Problem 9.3 (Trace identities)

#task[
  Using just the algebra ${gamma^mu, gamma^nu} = 2 eta^(mu nu) bb(1)_4$ (i.e. without resorting to a particular representation) and $gamma^5 = i gamma^0 gamma^1 gamma^2 gamma^3$ as defined above with $fsl(p) = p_mu gamma^mu$ and $S^(mu nu) = 1/4 [gamma^mu, gamma^nu]$, prove the following results:

  _Hint:_ It's helpful to note the cyclic properties of the trace, i.e. $"Tr"(A B C) = "Tr"(B C A)$, and you may find inserting $(gamma^5)^2 = bb(1)_4$ into a trace quite useful in some cases.
]

#task(label: "a")[$"Tr"(gamma^mu) = 0$]

$ "Tr"(gamma^mu) = "Tr"(gamma^mu (gamma^5)^2) = "Tr"(gamma^mu gamma^5 gamma^5) = "Tr"(gamma^5 gamma^mu gamma^5) = -"Tr"(gamma^mu gamma^5 gamma^5) quad ==> quad "Tr"(gamma^mu) = 0. $

#task(label: "b")[$"Tr"(gamma^mu gamma^nu) = 4 eta^(mu nu)$]

$ "Tr"(gamma^mu gamma^nu) = "Tr"(gamma^mu gamma^nu + gamma^nu gamma^mu - gamma^nu gamma^mu) = underbrace("Tr"(2 eta^(mu nu) bb(1)_4), 8 eta^(mu nu)) - "Tr"(gamma^mu gamma^nu) quad ==> quad "Tr"(gamma^mu gamma^nu) = 4 eta^(mu nu). $

#task(label: "c")[$"Tr"(gamma^mu gamma^nu gamma^lambda) = 0$]

$ "Tr"(gamma^mu gamma^nu gamma^lambda) = "Tr"((gamma^5)^2 gamma^mu gamma^nu gamma^lambda) = "Tr"(gamma^5 gamma^mu gamma^nu gamma^lambda gamma^5) = (-1)^3 "Tr"(gamma^5 gamma^5 gamma^mu gamma^nu gamma^lambda) quad ==> quad "Tr"(gamma^mu gamma^nu gamma^lambda) = 0. $

#task(label: "d")[$(gamma^5)^2 = bb(1)_4$]

$
  (gamma^5)^2 & = i gamma^0 gamma^1 gamma^2 gamma^3 i gamma^0 gamma^1 gamma^2 gamma^3 = -(-1)^3 underbrace((gamma^0)^2, bb(1)_4) gamma^1 gamma^2 gamma^3 gamma^1 gamma^2 gamma^3 = (-1)^2 underbrace((gamma^1)^2, -bb(1)_4) gamma^2 gamma^3 gamma^2 gamma^3 \
  & = -(-1) underbrace((gamma^2)^2, -bb(1)_4) underbrace((gamma^3)^2, -bb(1)_4) = bb(1)_4.
$

#task(label: "e")[$"Tr"(gamma^5) = 0$]

$ "Tr"(gamma^5) = "Tr"(i gamma^0 gamma^1 gamma^2 gamma^3) = "Tr"(i gamma^1 gamma^2 gamma^3 gamma^0) = (-1)^3 "Tr"(i gamma^0 gamma^1 gamma^2 gamma^3) = -"Tr"(gamma^5) quad ==> quad "Tr"(gamma^5) = 0. $

#task(label: "f")[$fsl(p) fsl(q) = 2 p q - fsl(q) fsl(p) = p q + 2 S^(mu nu) p_mu q_nu$]

$
  fsl(p) fsl(q) & = p_mu gamma^mu q_nu gamma^nu = p_mu q_nu gamma^mu gamma^nu = p_mu q_nu (-gamma^nu gamma^mu + 2 eta^(mu nu) bb(1)_4) = 2 p_mu q^mu bb(1)_4 - q_nu gamma^nu p_mu gamma^mu \
  & = 2 p q bb(1)_4 - fsl(q) fsl(p) \
  & = p_mu q_nu (gamma^mu gamma^nu - 1/2 gamma^nu gamma^mu + 1/2 gamma^nu gamma^mu) = p_mu q_nu (2 S^(mu nu) + 1/2 underbrace((gamma^mu gamma^nu + gamma^nu gamma^mu), 2 eta^(mu nu) bb(1)_4)) = p q + 2 S^(mu nu) p_mu q_nu.
$

#task(label: "g")[$"Tr"(fsl(p) fsl(q)) = 4 p q$]

$ "Tr"(fsl(p) fsl(q)) = "Tr"(p_mu gamma^mu q_nu gamma^nu) = p_mu q_nu "Tr"(gamma^mu gamma^nu) attach(=, t: "part b)") p_mu q_nu 4 eta^(mu nu) = 4 p q. $

#task(label: "h")[$"Tr"(fsl(p)_1 dots.c fsl(p)_n) = 0$ if $n$ is odd]

$ "Tr"(fsl(p)_1 dots.c fsl(p)_n) = "Tr"((gamma^5)^2 fsl(p)_1 dots.c fsl(p)_n) = "Tr"(gamma^5 fsl(p)_1 dots.c fsl(p)_n gamma^5) = (-1)^n "Tr"((gamma^5)^2 fsl(p)_1 dots.c fsl(p)_n) quad ==> quad 0 "if" n "is odd". $

#task(label: "i")[$"Tr"(fsl(p)_1 fsl(p)_2 fsl(p)_3 fsl(p)_4) = 4 [(p_1 p_2)(p_3 p_4) + (p_1 p_4)(p_2 p_3) - (p_1 p_3)(p_2 p_4)]$]

$
  "Tr"(fsl(p)_1 fsl(p)_2 fsl(p)_3 fsl(p)_4) & = p_(1 alpha) p_(2 beta) p_(3 gamma) p_(4 delta) "Tr"(gamma^alpha gamma^beta (-gamma^delta gamma^gamma + 2 eta^(gamma delta) bb(1)_4)) \
  & = p_(1 alpha) p_(2 beta) p_(3 gamma) p_(4 delta) (2 eta^(gamma delta) "Tr"(gamma^alpha gamma^beta bb(1)_4) - "Tr"(gamma^alpha gamma^beta gamma^delta gamma^gamma)) \
  & = p_(1 alpha) p_(2 beta) p_(3 gamma) p_(4 delta) (8 eta^(gamma delta) eta^(alpha beta) - "Tr"(gamma^alpha (-gamma^delta gamma^beta + 2 eta^(beta delta)) gamma^gamma)) \
  & = p_(1 alpha) p_(2 beta) p_(3 gamma) p_(4 delta) (8 eta^(gamma delta) eta^(alpha beta) + "Tr"(gamma^alpha gamma^delta gamma^beta gamma^gamma) - 2 eta^(beta delta) "Tr"(gamma^alpha gamma^gamma)) \
  & = p_(1 alpha) p_(2 beta) p_(3 gamma) p_(4 delta) (8 eta^(gamma delta) eta^(alpha beta) - 8 eta^(beta delta) eta^(alpha gamma) + "Tr"((-gamma^delta gamma^alpha + 2 eta^(alpha delta)) gamma^beta gamma^gamma)) \
  & = p_(1 alpha) p_(2 beta) p_(3 gamma) p_(4 delta) (8 eta^(gamma delta) eta^(alpha beta) - 8 eta^(beta delta) eta^(alpha gamma) - "Tr"(gamma^delta gamma^alpha gamma^beta gamma^gamma) + 2 eta^(alpha delta) "Tr"(gamma^beta gamma^gamma)) \
  & = 8 (p_1 p_2)(p_3 p_4) - 8 (p_2 p_4)(p_1 p_3) + 8 (p_1 p_4)(p_2 p_3) - "Tr"(fsl(p)_4 fsl(p)_1 fsl(p)_2 fsl(p)_3) \
  & = 8 [(p_1 p_2)(p_3 p_4) + (p_1 p_4)(p_2 p_3) - (p_1 p_3)(p_2 p_4)] - "Tr"(fsl(p)_1 fsl(p)_2 fsl(p)_3 fsl(p)_4).
$

#task(label: "j")[Parts j) through n) are skipped due to negligible relevance w.r.t. the exam.]

= Problem 11.1 (The Yukawa potential)

#task[
  Here, we'll analyse and 'derive' the classical potential for Yukawa theory, where the interactions between fermions are transmitted by a scalar field $phi$. As discussed on assignment 10 in problem 10.2, the Lagrangian of this theory is
  $ cal(L) = 1/2 partial_mu phi partial^mu phi - 1/2 m_phi^2 phi^2 + overline(Psi) (i gamma^mu partial_mu - m) Psi - g phi overline(Psi) Psi. $
  Analyse the following processes using the Feynman rules for Yukawa theory.
]

#task(label: "a")[electron-electron scattering: $e^- + e^- -> e^- + e^-$.]

$
  i cal(M) & = #ee-t quad - quad #ee-u \
  & = overline(u)_(s') (p') (-i g) u_s (p) i/(q_1^2 - m_phi^2) overline(u)_(r') (k') (-i g) u_r (k) - overline(u)_(r') (k') (-i g) u_s (p) i/(q_2^2 - m_phi^2) overline(u)_(s') (p') (-i g) u_r (k) \
  & = -i g^2 (overline(u)_(s') (p') u_s (p) 1/((p - p')^2 - m_phi^2) overline(u)_(r') (k') u_r (k) - overline(u)_(r') (k') u_s (p) 1/((p - k')^2 - m_phi^2) overline(u)_(s') (p') u_r (k)).
$

#task(label: "b")[electron-positron scattering: $e^+ + e^- -> e^+ + e^-$.]

$
  i cal(M) & = #ep-t - #ep-s \
  & = overline(u)_(s') (p') (-i g) u_s (p) i/(t^2 - m_phi^2) overline(v)_r (k) (-i g) v_(r') (k') - overline(v)_r (k) (-i g) u_s (p) i/(s^2 - m_phi^2) overline(u)_(s') (p') (-i g) v_(r') (k') \
  & = -i g^2 (overline(u)_(s') (p') u_s (p) 1/((p - p')^2 - m_phi^2) overline(v)_r (k) v_(r') (k') - overline(v)_r (k) u_s (p) 1/((p + k)^2 - m_phi^2) overline(u)_(s') (p') v_(r') (k')).
$

#task[Comparing your result to that of the Born approximation to the scattering amplitudes in nonrelativistic quantum mechanics, deduce the form and the sign of the classical Yukawa potential.]

As part of the Born approximation, scattering electrons are regarded as distinguishable particles. Thus, of the two tree-level diagrams drawn in part a) only one survives since with distinguishable particles, we can uniquely identify every outgoing particle with its ingoing counterpart. We consider the first one.
To evaluate its amplitude in the nonrelativistic limit, we keep only terms to lowest possible order in the 3-momenta, which is the second here, $cal(O)(arrow(p)^2, arrow(p)'^2, arrow(k)^2, arrow(k)'^2)$, where
$ p = (m, arrow(p)), quad p' = (m, arrow(p)'), quad k = (m, arrow(k)), quad k' = (m, arrow(k)'). $
Therefore $(p - p')^2 = (m - m)^2 - (arrow(p) - arrow(p)')^2 = -(arrow(p) - arrow(p)')^2$ and $u_s (p) = sqrt(m) vec(xi_s, xi_s)$, $u_(s') (p') = sqrt(m) vec(xi_(s'), xi_(s'))$, etc., where $xi_s$ is a two-component constant spinor normalized to $xi_s^dagger xi_(s') = delta_(s s')$. The spinor products in the result of part a) are then
$
  overline(u)_(s') (p') u_s (p) & = sqrt(m) (xi_(s')^dagger, xi_(s')^dagger) gamma^0 sqrt(m) vec(xi_s, xi_s) = 2 m xi_(s')^dagger xi_s = 2 m delta_(s s'), \
  overline(u)_(r') (k') u_r (k) & = sqrt(m) (xi_(r')^dagger, xi_(r')^dagger) gamma^0 sqrt(m) vec(xi_r, xi_r) = 2 m xi_(r')^dagger xi_r = 2 m delta_(r r').
$
From the above, we can infer that the spin of each particle has to be separately conserved. With this result, we can rewrite the scattering amplitude as
$ i cal(M) = -i g^2 2 m delta_(s s') 1/(-(arrow(p) - arrow(p)')^2 - m_phi^2) 2 m delta_(r r') = (i g^2)/((arrow(p) - arrow(p)')^2 + m_phi^2) (2 m)^2 delta_(s s') delta_(r r'). $
This can be compared with an analogous expression obtained by applying the Born approximation to solve this nonrelativistic scattering interaction:
$ chevron.l arrow(p)' | i T | arrow(p) chevron.r = -i tilde(V)(arrow(q)) (2 pi) delta(E_(p') - E_p), quad arrow(q) = arrow(p)' - arrow(p). $
When making this comparison, we should be mindful of the different normalization of momentum eigenstates employed in relativistic QFT and nonrelativistic QM, which gives us excess factors of $2m$ in the scattering amplitude. Also, the surplus factor of $(2 pi)^3 delta^((3)) (arrow(p) - arrow(p)')$ that appears in the upper expression for the scattering amplitude when elevating it to the full $S$-matrix element disappears when performing the integral over the momentum of the target. Therefore, we can learn from our comparison that
$ tilde(V)(arrow(q)) = (-g^2)/(arrow(q)^2 + m_phi^2). $
To find an expression for the potential $V(arrow(x))$ in position space, we Fourier transform
$
  V(arrow(x)) & = integral (dd(3, q))/(2 pi)^3 e^(i arrow(q) dot arrow(x)) tilde(V)(arrow(q)) = integral (dd(3, q))/(2 pi)^3 (-g^2 e^(i arrow(q) dot arrow(x)))/(arrow(q)^2 + m_phi^2) = -g^2/(2 pi)^3 integral_0^oo dd(q) integral_0^pi dd(theta) integral_0^(2 pi) dd(phi) (q^2 sin theta)/(q^2 + m_phi^2) e^(i q r cos theta), quad mat(delim: #none, y = cos theta; dif y = -sin theta dif theta) \
  & = g^2/(4 pi^2) integral_0^oo dd(q) integral_1^(-1) q^2/(q^2 + m_phi^2) e^(i q r y) dif y = -g^2/(4 pi^2) integral_0^oo dd(q) q^2/(q^2 + m_phi^2) 1/(i q r) (e^(i q r) - e^(-i q r)) \
  & = -g^2/(4 pi^2 i r) (integral_0^oo dd(q) q/(q^2 + m_phi^2) e^(i q r) - integral_0^(-oo) (-dif q) (-q)/(q^2 + m_phi^2) e^(i q r)) = -g^2/(4 pi^2 i r) integral_(-oo)^oo dd(q) underbrace(q/(q^2 + m_phi^2) e^(i q r), f(q)).
$
This can be evaluated as a complex contour integral by closing it in the upper half plane of $CC$, where we pick up the residue of the first order pole at $q = i m_phi$ [since $q^2 + m_phi^2 = (q - i m_phi)(q + i m_phi)$] which is given by
$ "Res"(f(q), q = i m_phi) = lim_(q -> i m_phi) (q - i m_phi) f(q) = lim_(q -> i m_phi) q/(q + i m_phi) e^(i q r) = (i m_phi)/(2 i m_phi) e^(-m_phi r) = 1/2 e^(-m_phi r). $
Now applying the residue theorem, we get
$ V(arrow(x)) = -g^2/(4 pi^2 i r) 2 pi i sum_(q_0 in CC_+) "Res"(f(q), q = q_0) = -g^2/(4 pi^2 i r) 2 pi i 1/2 e^(-m_phi r) = -g^2/(4 pi r) e^(-m_phi r), $
which is an attractive potential since it shrinks with decreasing $r$. The same result, i.e. an attractive force produced by the Yukawa potential, is obtained when considering scattering of antifermions and fermions with antifermions.

= Problem 8.1 (Relativistic kinematics for 2-2 scattering)

#task[
  Consider the $S$-matrix element for non-trivial scattering of two particles
  $ chevron.l arrow(p)_3, arrow(p)_4 | S | arrow(p)_1, arrow(p)_2 chevron.r = i (2 pi)^4 delta^((4)) (p_3 + p_4 - p_1 - p_2) cal(M)(p_1, p_2, p_3, p_4). $
]

#task(label: "a")[
  Show that the total cross-section is
  $ sigma = 1/2! 1/(64 pi^2 s) integral dd(2, Omega_3) |cal(M)|^2, $
  or equivalently the differential cross-section $(dif sigma)/(dd(2, Omega_3)) = 1/2! 1/(64 pi^2 s) |cal(M)|^2$. Here, we make use of the relativistically invariant Mandelstam variable $s = (p_1 + p_2)^2$ and $integral dd(2, Omega_3)$ refers to integration over $arrow(p)_3$ as $integral dd(3, p_3) = integral dif |arrow(p)_3| integral dd(2, Omega_3)$.
]

In the rest frame of particle 2, it holds that
$ 4 |arrow(p)_1| m sigma = 1/2! integral (dd(3, p_3))/(2 pi)^3 1/(2 E_3) integral (dd(3, p_4))/(2 pi)^3 1/(2 E_4) (2 pi)^4 delta^((4)) (p_3 + p_4 - p_1 - p_2) |cal(M)(p_1, p_2, p_3, p_4)|^2. $
To perform the right-hand integral, we may move into the centre-of-mass system since all parts of the above expression are Lorentz-invariant and therefore valid in any frame of reference. In the CoM frame, we have $p_1 + p_2 = p_3 + p_4 = (sqrt(s), 0, 0, 0)$ and hence $arrow(p)_1 + arrow(p)_2 = arrow(p)_3 + arrow(p)_4 = arrow(0)$. We can therefore write for the above
$
  4 |arrow(p)_1| m sigma & = 1/(8 (2 pi)^2) integral dd(3, p_3) integral dd(3, p_4) 1/(E_3 E_4) delta^((1)) (E_3 + E_4 - E_1 - E_2) delta^((3)) (arrow(p)_3 + arrow(p)_4 - underbrace((arrow(p)_1 + arrow(p)_2), arrow(0))) |cal(M)(p_1, p_2, p_3, p_4)|^2 \
  & = 1/(32 pi^2) integral dd(3, p_3) integral dd(3, p_4) 1/(E_3 E_4) delta^((1)) (E_3 + E_4 - sqrt(s)) delta^((3)) (arrow(p)_3 + arrow(p)_4) |cal(M)(p_1, p_2, p_3, p_4)|^2 \
  & = 1/(32 pi^2) integral dd(3, p_3) 1/E_3^2 delta^((1)) (2 E_3 - sqrt(s)) |cal(M)(p_1, p_2, p_3)|^2, quad "where" quad integral dd(3, p_3) = integral dd(2, Omega_3) integral dif |arrow(p)_3|.
$
Here, we can use that $delta(f(x)) = sum_(i=1)^n delta(x - x_i)/(|f'(x_i)|)$, where $i$ iterates over the (by necessity) finite set of simple zeros of $f(x)$. In this case
$
  delta^((1)) (2 E_3 - sqrt(s)) & = delta^((1)) (underbrace(2 sqrt(arrow(p)_3^2 + m^2), f(|arrow(p)_3|)) - sqrt(s)(|arrow(p)_3|)) = 1/(|f'(|arrow(p)_3|)|) delta^((1)) (f^(-1)(f(|arrow(p)_3|)) - f^(-1)(sqrt(s)(|arrow(p)_3|))) \
  & = ((2 |arrow(p)_3|)/sqrt(arrow(p)_3^2 + m^2))^(-1) delta^((1)) (|arrow(p)_3| - sqrt(s/4 - m^2)).
$
Inserting this reformulation of the delta distribution into our integral gives
$
  4 |arrow(p)_1| sigma m & = 1/(32 pi^2) integral dd(2, Omega_3) integral dif |arrow(p)_3| |arrow(p)_3|^2 1/(arrow(p)_3^2 + m^2) sqrt(arrow(p)_3^2 + m^2)/(2 |arrow(p)_3|) delta(|arrow(p)_3| - sqrt(s/4 - m^2)) |cal(M)(p_1, p_2, p_3)|^2 \
  & = 1/(64 pi^2) integral dd(2, Omega_3) sqrt(s/4 - m^2)/sqrt(s/4 - m^2 + m^2) |cal(M)(p_1, p_2, Omega_3)|^2 = 1/(64 pi^2) sqrt((s - 4 m^2)/s) integral dd(2, Omega_3) |cal(M)(p_1, p_2, Omega_3)|^2.
$
In the lab frame (rest frame of particle 2), we have $p_2 = (m, 0, 0, 0)$, $p_1 = (E_1^L, arrow(p)_1^L)$,
$ s = (p_1 + p_2)^2 = p_1^2 + 2 p_1 p_2 + p_2^2 = 2 m^2 + 2 m E_1^L quad ==> quad E_1^L = (s - 2 m^2)/(2 m), $
$ |arrow(p)_1^L| = sqrt((E_1^L)^2 - m^2) = sqrt((s - 2 m^2)^2/(4 m^2) - (4 m^4)/(4 m^2)) = sqrt((s^2 - 4 s m^2 + 4 m^4 - 4 m^4)/(4 m^2)) = sqrt(s (s - 4 m^2))/(2 m). $
And therefore, we can write
$
  sigma & = 1/(4 |arrow(p)_1^L| m) 1/(64 pi^2) sqrt((s - 4 m^2)/s) integral dd(2, Omega_3) |cal(M)(p_1, p_2, Omega_3)|^2 = 1/(2 sqrt(s (s - 4 m^2))) 1/(64 pi^2) sqrt((s - 4 m^2)/s) integral dd(2, Omega_3) |cal(M)(p_1, p_2, Omega_3)|^2 \
  & = 1/(128 pi^2 s) integral dd(2, Omega_3) |cal(M)(p_1, p_2, Omega_3)|^2.
$
