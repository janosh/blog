#import "/notes.typ": dd, dm, nord, notes, vb, bra, ket
#import "@preview/cetz:0.5.2": canvas, decorations, draw

#show: notes.with(
  title: [Quantum Field Theory I],
  subtitle: [Lecture Revisions],
  date: [Janosh Riebesell, winter semester 2014/15],
)

#let (bp, bq, bx, by) = (vb($p$), vb($q$), vb($x$), vb($y$))
#let fsl(x) = math.cancel(x, angle: 25deg, length: 110%)

// Feynman diagram helpers in units of `length`, set inline on the baseline of the text.
#let diagram(body, length: 0.55cm, baseline: 50%) = box(baseline: baseline, canvas(length: length, {
  import draw: *
  set-style(stroke: 0.6pt)
  body
}))
#let arrow-mark = (end: "stealth", fill: black, scale: 0.6)
#let vertex(pt, label: none, anchor: "north") = {
  draw.circle(pt, radius: 0.07, fill: black, stroke: none)
  if label != none { draw.content(pt, text(size: 9pt, label), anchor: anchor, padding: 3pt) }
}
#let fermion(a, b) = {
  let mid = ((a.at(0) + b.at(0)) / 2, (a.at(1) + b.at(1)) / 2)
  draw.line(a, mid, mark: arrow-mark)
  draw.line(mid, b)
}
#let photon(a, b) = decorations.wave(draw.line(a, b), amplitude: 0.12, segment-length: 0.3)

// Integration contour along the real p^0 axis that dodges the poles at -2 and 2 by
// semicircles, going over (+1) or under (-1) each of them
#let contour(left, right) = diagram(length: 0.6cm, {
  import draw: *
  let r = 0.6
  for (pole, side) in ((-2, left), (2, right)) {
    circle((pole, 0.25 * side), radius: 0.05, fill: black, stroke: none)
    arc((pole - r, 0), start: 180deg, stop: if side > 0 { 0deg } else { 360deg }, radius: r)
    line((pole - 0.05, side * r), (pole + 0.05, side * r), mark: arrow-mark)
  }
  line((-5, 0), (-2 - r, 0))
  line((-2 + r, 0), (2 - r, 0))
  line((2 + r, 0), (5, 0))
})

// propagator x -- y with optional tadpole or sunset insertion
#let line-xy(..labels) = {
  let pts = labels.pos()
  let n = pts.len()
  draw.line((0, 0), (2.4, 0))
  for (i, lbl) in pts.enumerate() { vertex((2.4 * i / (n - 1), 0), label: lbl) }
}
#let free-prop = diagram(line-xy($x$, $y$))
#let tadpole = diagram({
  line-xy($x$, $z$, $y$)
  draw.circle((1.2, 0.35), radius: 0.35)
})
#let sunset = diagram({
  draw.line((0, 0), (3, 0))
  draw.circle((1.5, 0), radius: 0.55)
  for (x, lbl) in ((0, $x$), (0.95, $z_1$), (2.05, $z_2$), (3, $y$)) { vertex((x, 0), label: lbl) }
})

// vacuum bubbles: a chain of n loops stacked vertically, joined at vertices z_1 ... z_(n-1)
#let bubble-chain(n) = diagram({
  for i in range(n) { draw.circle((0, -0.7 * i), radius: (0.25, 0.35)) }
  for i in range(n - 1) {
    vertex((0, -0.35 - 0.7 * i), label: $z_#(i + 1)$, anchor: "east")
  }
})
#let watermelon = diagram({
  draw.circle((0, 0), radius: (0.12, 0.7))
  draw.circle((0, 0), radius: (0.35, 0.7))
  vertex((0, 0.7), label: $z_1$, anchor: "south")
  vertex((0, -0.7), label: $z_2$, anchor: "north")
})

= Revision 1 (13.10.2014)

Lecturer: Prof. Jürgen Berges \
Website: #link("http://www.thphys.uni-heidelberg.de/~berges/") \
Email: #link("mailto:berges@thphys.uni-heidelberg.de")[berges\@thphys.uni-heidelberg.de] \
Literature:
- Lecture notes "Quantum Field Theory I & II" by Timo Weigand, Chapters 1 to 6
- "An Introduction to Quantum Field Theory" by Peskin and Schröder

Tutorials: organized by Dr. Viraf Mehta (v.mehta\@thphys.uni-heidelberg.de), online registration \
The course is passed by successfully standing the written examination at the end of the semester. \
Plan:
+ The free scalar field
+ The interacting scalar field
+ Quantizing spin-$1/2$-fields
+ Quantizing spin-1-fields
+ Quantum electrodynamics (QED)
+ Classical non-abelian gauge theory

= Revision 2 (17.10.2014)

== Why Quantum Field Theory?

We will focus on elementary particle physics, hence relativistic QFT. However, virtually the same methods play a role in nuclear, atomic and condensed matter physics. In any relativistic field theory, the particle number is not conserved; since $E^2 = c^2 bp^2 + m^2 c^4$, energy can always be converted into particles and vice versa. This requires a _multiparticle_ framework different from quantum mechanics.

QFT is a change of perspective from quantum mechanics in the following regards:
- The fundamental entities are not the particles but rather "the field" -- an abstract object that "penetrates" spacetime.
- Particles are the "excitations" of the field.

= Revision 3 (20.10.2014)

- Free scalar field theory ($phi.alt^* = phi.alt$): $S = 1/2 integral_(RR^4) dd(4, x) [partial_mu phi.alt partial^mu phi.alt - m^2 phi.alt^2]$
- Euler-Lagrange: #dm($(partial cal(L))/(partial phi.alt) = partial_mu (partial cal(L))/(partial (partial_mu phi.alt))$)
- Symmetry: $phi.alt -> phi.alt + epsilon.alt dot delta phi.alt + cal(O)(epsilon.alt^2)$ #h(1fr) $(partial phi.alt = partial_nu phi.alt(x^mu))$ #h(3em) \
  #h(4.6em) $cal(L) -> cal(L) + epsilon.alt partial_mu F^mu + cal(O)(epsilon.alt^2)$
- Noether current: #dm($j^mu = (partial cal(L))/(partial (partial_mu phi.alt)) delta phi.alt - F^mu$)
- Conserved charge: $partial_mu j^mu = 0$, $Q = integral_(RR^3) dd(3, x) j^0$

= Revision 4 (22.10.2014)

- Energy-momentum tensor: #dm($T^(mu nu) = (partial cal(L))/(partial (partial_mu phi.alt)) partial^nu phi.alt - eta^(mu nu) cal(L)$)

  For this tensor, one has $partial_mu T^(mu nu) = 0$, $E = integral_(RR^3) dd(3, x) T^(00)$, and $p^i = integral_(RR^3) dd(3, x) T^(0 i)$.

  Free scalar field: #dm($E = integral_(RR^3) dd(3, x) [1/2 dot(phi.alt)^2 + 1/2 (nabla phi.alt)^2 + 1/2 m^2 phi.alt^2]$), $bp = -integral_(RR^3) dd(3, x) (dot(phi.alt) nabla phi.alt)$
- Canonical quantization
  #set enum(numbering: "i)")
  + Conjugate momentum density: #dm($pi(bx, t) = (partial cal(L))/(partial (dot(phi.alt)(bx, t)))$)
  + #dm($H = integral_(RR^3) dd(3, x) cal(H) = integral_(RR^3) dd(3, x) [pi dot(phi.alt) - cal(L)] limits(=)^"free theory" integral_(RR^3) dd(3, x) [1/2 dot(phi.alt)^2 + 1/2 (nabla phi.alt)^2 + 1/2 m^2 phi.alt^2]$)
  + Promote $phi.alt(bx)$ and $pi(bx)$ to operators:
    - $[phi.alt(bx), pi(by)] = i delta^((3)) (bx - by)$
    - $[phi.alt(bx), phi.alt(by)] = [pi(bx), pi(by)] = 0$

= Revision 5 (27.10.2014)

- Mode expansion:
  $
    phi.alt(bx) & = integral_(RR^3) (dif^3 p)/(2 pi)^3 1/sqrt(2 omega_bp) (a(bp) e^(i bp bx) + a^dagger (bp) e^(-i bp bx)) \
     pi(bx) & = integral_(RR^3) (dif^3 p)/(2 pi)^3 (-i) sqrt(omega_bp/2) (a(bp) e^(i bp bx) - a^dagger (bp) e^(-i bp bx))
  $
- $[a(bp), a^dagger (bq)] = (2 pi)^3 delta^((3)) (bp - bq)$ \
  $[a(bp), a(bq)] = [a^dagger (bp), a^dagger (bq)] = 0 quad forall bp, bq$
- 4-momentum: #dm($P^mu = integral_(RR^3) (dif^3 p)/(2 pi)^3 p^mu a^dagger (bp) a(bp)$), where $p^mu = (p^0, bp)$ and $p^0 = omega_bp = E_bp = sqrt(bp^2 + m^2)$ \
  $[P^mu, a(bp)] = -p^mu a(bp)$ \
  $[P^mu, a^dagger (bp)] = p^mu a^dagger (bp)$
- Vacuum: $a(bp) ket(0) = 0 quad forall bp$ \
  $a^dagger (bp)$ creates 1-particle state with momentum $bp$: $P^mu a^dagger (bp) ket(0) = p^mu a^dagger (bp) ket(0)$ \
  $N$-particle state $a^dagger (bp_1) ... a^dagger (bp_N) ket(0)$ with energy $E = sum_(i=1)^N E_(bp, i)$ and momentum $bp = sum_(i=1)^N bp_i$. \
  $=>$ QFT is a multi-particle framework

= Revision 6 (29.10.2014)

- $N$-particle momentum eigenstates \
  $ket(bp_1\, ...\, bp_N) = product_(i=1)^N sqrt(2 omega_(bp_i)) a^dagger (bp_i) ket(0)$ \
  $chevron.l bq|bp chevron.r = (2 pi)^3 2 omega_bp delta^((3)) (bp - bq)$
- Position eigenstates \
  #dm($ket(bx) = phi.alt(bx) ket(0) = integral_(RR^3) (dif^3 p)/(2 pi)^3 1/(2 omega_bp) e^(-i bp bx) ket(bp)$)#footnote[All these mode expansions and creating a particle at position $bx$ as simple as $ket(bx) = phi.alt(bx) ket(0)$ are only valid in the free theory without interaction and therefore without any influence of particle creation on nearby particles.]
- Renormalization #dm($H = integral_(RR^3) (dif^3 p)/(2 pi)^3 omega_bp a^dagger (bp) a(bp) + Delta_H$), \
  where #dm($epsilon.alt_0 = Delta_H/"Vol"_(RR^3) = integral_(RR^3) (dif^3 p)/(2 pi)^3 omega_bp/2 -> infinity$) (UV divergent) \
  To renormalize, we absorb $epsilon.alt_0$ into $V_0$ in the Lagrangian $cal(L) = 1/2 (partial_mu phi.alt)^2 - 1/2 m^2 phi.alt^2 - V_0$

= Revision 7 (3.11.2014)

- Complex scalar field \
  $cal(L) = partial_mu phi.alt^dagger partial^mu phi.alt - m^2 phi.alt^dagger phi.alt$ \
  $pi(t, bx) = dot(phi.alt)^dagger (t, bx)$, $pi^dagger (t, bx) = dot(phi.alt)(t, bx)$ \
  $[phi.alt(bx), pi(by)] = [phi.alt^dagger (bx), pi^dagger (by)] = i delta^((3)) (bx - by)$, all other commutators vanish
- Mode expansion \
  #dm($phi.alt(bx) = integral_(RR^3) (dif^3 p)/(2 pi)^3 1/sqrt(2 omega_bp) (a(bp) e^(i bp bx) + b^dagger (bp) e^(-i bp bx))$) \
  $a^dagger (bp) ket(0)$: particle with momentum $bp$ and charge $-1$, \
  $b^dagger (bp) ket(0)$: particle with momentum $bp$ and charge $1$
- Heisenberg Picture \
  $phi.alt(t, bx) = phi.alt^((H)) (t, bx) = e^(i H^((S)) t) phi.alt^((S)) (bx) e^(-i H^((S)) t)$ \
  equal-time commutation relations $[phi.alt(t, bx), pi(t, by)] = i delta^((3)) (bx - by)$ \
  Klein-Gordon operator equation $(partial^2 + m^2) phi.alt(t, bx) = 0$

= Revision 8 (5.11.2014)

- Propagator: 2-point correlation function \
  #dm($D(x - y) = bra(0) phi.alt(x) phi.alt(y) ket(0) limits(=)^"free scalar theory" integral_(RR^3) (dif^3 p)/(2 pi)^3 1/(2 E_bp) e^(-i p(x - y))$)
- Commutator \
  $Delta(x - y) = [phi.alt(x), phi.alt(y)] = D(x - y) - D(y - x)$

= Revision 9 (10.11.2014)

- Feynman propagator \
  #dm($D_"F" (x - y) = bra(0) T phi.alt(x) phi.alt(y) ket(0) = cases(bra(0) phi.alt(x) phi.alt(y) ket(0) quad & x^0 >= y^0, bra(0) phi.alt(y) phi.alt(x) ket(0) quad & x^0 < y^0)$)
  - Free theory (without interaction) #dm($D_"F" (x - y) = integral_(RR^4) (dif^4 p)/(2 pi)^4 i/(p^2 - m^2 + i epsilon.alt) e^(-i p(x - y))$) \
    where the $i epsilon.alt$-term represents time-ordering
    #figure(contour(-1, 1), caption: [This integration path in the complex momentum plane yields the (time-ordered) Feynman propagator $D_"F" (x - y)$.])
- causally retarded and advanced propagators require different integration schemes
  - $D_"A" (x - y)$
    #figure(contour(-1, -1), caption: [This integration path in the complex momentum plane yields the advanced propagator $D_"A" (x - y)$.])
  - $D_"R" (x - y)$
    #figure(contour(1, 1), caption: [This integration path in the complex momentum plane yields the retarded propagator $D_"R" (x - y)$.])
  - $D_"R" (x - y) \/ D_"A" (x - y)$ propagates information forward (backward) in time
  - $D_"F" (x - y)$ propagates positive frequency modes ($e^(-i p x)$) forward in time and negative frequency modes ($e^(i p x)$) backward in time

= Revision 10 (12.11.2014)

Interacting scalar field theory
- $V(phi.alt) = 1/2 m_0^2 phi.alt^2 + 1/3! g phi.alt^3 + 1/4! lambda phi.alt^4 + ...$
- $H ket(lambda_bp) = E_bp (lambda) ket(lambda_bp)$ \
  $vb(P) ket(lambda_bp) = bp ket(lambda_bp)$
  - The state parameter $lambda_bp$ denotes 1-particle, multi-particle and bound states; it hides much of the complexity that comes with interaction.
- #dm($bb(1) = ket(Omega) bra(Omega) + sum_lambda integral_(RR^3) (dif^3 p)/(2 pi)^3 1/(2 E_bp (lambda)) ket(lambda_bp) bra(lambda_bp)$)
- #dm($bra(Omega) phi.alt(x) phi.alt(y) ket(Omega) = sum_lambda integral_(RR^3) (dif^3 p)/(2 pi)^3 1/(2 E_bp (lambda)) e^(-i p(x - y)) underbrace(|bra(Omega) phi.alt(0) ket(lambda_0)|^2, "field strength")$)

  Note: $E_bp (lambda) = sqrt(bp^2 + m_lambda^2)$ involves the rest energy $m_lambda$ of the state $lambda$ (e.g. the invariant mass of a multi-particle or bound state) rather than a single particle mass $m$

= Revision 11 (17.11.2014)

- #dm($bra(Omega) T phi.alt(x) phi.alt(y) ket(Omega) = integral_0^infinity (dif M^2)/(2 pi) rho(M^2) D_"F" (x - y, M^2)$) \
  spectral density #dm($rho(M^2) = sum_lambda 2 pi delta(M^2 - m_lambda^2) |bra(Omega) phi.alt(0) ket(lambda_0)|^2$)
- Lesson: the full propagator $bra(Omega) T phi.alt(x) phi.alt(y) ket(Omega)$ yields the mass "$m$" as the first pole
- The propagator is a two-point correlation function.
- $n$-point correlation function: $bra(Omega) T phi.alt(x_1) phi.alt(x_2) ... phi.alt(x_n) ket(Omega)$
- scattering $ket(i) -> ket(f)$ asymptotic in-/out-states as $t -> plus.minus infinity$ \
  $ket(i)$, $ket(f)$ are separated, freely traveling single-particle states

= Revision 12 (19.11.2014)

- $S$-matrix $<->$ residues of on-shell correlation functions
  $
    & product_(k=1)^n integral_(RR^4) dd(4, y_k) e^(i p_k y_k) product_(l=1)^r integral_(RR^4) dd(4, x_l) e^(i q_l x_l) lr(chevron.l Omega mid(|) T product_k phi.alt(y_k) product_l phi.alt(x_l) mid(|) Omega chevron.r) \
    & quad = product_(k=1)^n (i sqrt(Z))/(p_k^2 - m^2) product_(l=1)^r (i sqrt(Z))/(q_l^2 - m^2) lr(chevron.l p_1 ... p_n |S| q_1 ... q_r chevron.r|)_"connected"
  $
- General aim in quantum field theory is to compute correlation functions of the form \
  $bra(Omega) T product_(i=1)^n phi.alt(x_i) ket(Omega)$#footnote[Later also for excited states, not only the vacuum.]

= Revision 13 (24.11.2014)

- Relate $phi.alt(x)$ to "free field" $phi.alt_"I" (x)$ in the interaction picture
- $phi.alt(t, bx) = U^dagger (t, t_0) phi.alt_"I" (t, bx) U(t, t_0)$ \
  where
  $
    U(t, t_0) & = e^(i H_0 (t - t_0)) e^(-i H (t - t_0)) = T e^(-i integral_(t_0)^t H_"I" (t') dif t'), \
              & = sum_(n=0)^infinity (-i)^n/n! integral_(t_0)^t dd(t_1) ... integral_(t_0)^t dd(t_n) T H_"I" (t_1) ... H_"I" (t_n)
  $
- Property: $(partial^2 + m_0^2) phi.alt_"I" = 0$, $a_"I" (bp) ket(0) = 0$ "free field", where $ket(0)$: free vacuum
- Relate $ket(Omega)$ to $ket(0)$ on which $a_"I" (bp)$ and $a_"I"^dagger (bp)$ act: \
  #dm($ket(Omega) = lim_(T -> infinity (1 - i epsilon.alt)) e^(-i H T)/(e^(-i E_Omega T) chevron.l Omega|0 chevron.r) ket(0)$), #h(1em) where $H ket(Omega) = E_Omega ket(Omega)$ with respect to the energy gauge $H_0 ket(0) = 0$

= Revision 14 (26.11.2014)

- Correlation function in the full interaction theory $cal(L) = cal(L)_0 + cal(L)_"int"$
  $
    bra(Omega) T product_(i=1)^n phi.alt(x_i) ket(Omega) = lr(chevron.l 0 mid(|) T product_(i=1)^n phi.alt_"I" (x_i) e^(i integral_(RR^4) dif^4 x cal(L)_"int") mid(|) 0 chevron.r)/lr(chevron.l 0 mid(|) T e^(i integral_(RR^4) dif^4 x cal(L)_"int") mid(|) 0 chevron.r)
  $
- Wick's theorem \
  $T phi.alt(x_1) ... phi.alt(x_N) = nord(phi.alt(x_1) ... phi.alt(x_N) + "all possible contractions of operator pairs")$, \
  where $bra(0) nord(cal(O)) ket(0) = 0$ except when $cal(O) = c dot bb(1)$, $c in CC$
- $bra(0) T phi.alt(x_1) ... phi.alt(x_(2N)) ket(0) = D_"F" (x_1 - x_2) D_"F" (x_3 - x_4) ... D_"F" (x_(2N - 1) - x_(2N))$ \
  #h(9.5em) $+ "all other contractions"$ \
  with #dm($D_"F" (x - y) = integral_(RR^4) (dif^4 p)/(2 pi)^4 i/(p^2 - m^2 + i epsilon.alt) e^(-i p(x - y))$) \
  $chevron.l T nord(phi.alt^4 (x)) nord(phi.alt^4 (x)) phi.alt(y_1) ... phi.alt(y_n) chevron.r$

= Revision 15 (1.12.2014)

- #dm($lim_(T -> infinity (1 - i epsilon.alt)) bra(0) T phi.alt(x) phi.alt(y) e^(-i integral_(-T)^T dif t H_"I" (t)) ket(0) = sum "connected diagrams" dot e^(sum "disconnected diagrams")$), \
  where $(sum "connected diagrams")$ is illustrated in @connected and $(sum "disconnected diagrams")$ in @disconnected.
  #figure(
    $#free-prop + #tadpole + #sunset + ...$,
    caption: [Sum of all at least partially connected diagrams with $n$ external points],
  ) <connected>
- #dm($lim_(T -> infinity (1 - i epsilon.alt)) bra(0) T e^(-i integral_(-T)^T dif t H_"I" (t)) ket(0) = e^(sum "disconnected diagrams")$)
  #figure(
    $#bubble-chain(2) + #bubble-chain(3) + #bubble-chain(4) + #watermelon + ...$,
    caption: [Sum of all entirely disconnected diagrams without external points],
  ) <disconnected>
- such that
  $
    bra(Omega) T phi.alt(x) phi.alt(y) ket(Omega) & = lim_(T -> infinity (1 - i epsilon.alt)) (bra(0) T phi.alt(x) phi.alt(y) e^(-i integral_(-T)^T dif t H_"I" (t)) ket(0))/(bra(0) T e^(-i integral_(-T)^T dif t H_"I" (t)) ket(0)) \
    & = sum "connected diagrams" \
    & = #free-prop + #tadpole + #sunset + ...
  $
- more generally #dm($bra(Omega) T product_(i=1)^n phi.alt(x_i) ket(Omega) = sum_("diagrams with" n "external points")^("over all (partially) connected")$)

= Revision 16 (3.12.2014)

- $lr(chevron.l p_1 ... p_n |S| q_1 ... q_r chevron.r|)_"connected"$ #h(2em) (amputated correlation functions)
- $chevron.l f|S|i chevron.r = delta_(f i) + i (2 pi)^4 delta^((4)) (p_f - p_i) cal(M)_(f i)$
- #dm($omega_(f i) = P_(ket(i) -> ket(f))/("vol"_RR dot "time")$) #h(2em) (transition rate)
- #dm($omega_(f i) = 1/N! product_(n=1)^N integral_(RR^3) (dif^3 k)/(2 pi)^3 1/(2 E_n) (2 pi)^4 delta^4 (sum_k p_k - sum_l q_l) |cal(M)_(f i)|^2$)

= Revision 17 (8.12.2014)

- No revision for this lecture.

= Revision 18 (10.12.2014)

- Lorentz transformation laws for fields \
  $x^mu |-> x'^mu = Lambda^mu zws_nu x^nu$, #h(1fr) where $mu, nu in {0, 1, 2, 3}$ \
  $phi.alt^a (x) |-> phi.alt'^a (x) = R^a zws_b (Lambda) phi.alt^b (Lambda^(-1) x)$, #h(1fr) where $a, b in {1, 2, ..., n}$
  - scalar: $R(Lambda) = 1$ #h(2em) (trivial representation, spin 0 particles)
  - vector: $R^mu zws_nu (Lambda) = Lambda^mu zws_nu$ #h(2em) (vector representation, spin 1, in the special case of the fundamental representation, we have $a, b = mu, nu$) \
    $Lambda^mu zws_nu = (e^(-i/2 omega_(rho sigma) J^(rho sigma)))^mu zws_nu$, \
    where $(J^(rho sigma))^(mu nu) = i (eta^(rho mu) eta^(sigma nu) - eta^(rho nu) eta^(sigma mu))$ \
    and $[J^(mu nu), J^(rho sigma)] = i (eta^(nu rho) J^(mu sigma) - eta^(mu rho) J^(nu sigma) - eta^(nu sigma) J^(mu rho) + eta^(mu sigma) J^(nu rho))$ \
    E.g. spatial rotation by angle $alpha$ around axis $vb(n)$:
    $
      omega_(i j) = alpha epsilon.alt_(i j k) n^k, "which for" n = (1, 0, 0)^dagger "gives" omega = mat(0, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, alpha; 0, 0, -alpha, 0) \
      "and the corresponding rotation matrix" Lambda = mat(1, 0, 0, 0; 0, 1, 0, 0; 0, 0, cos(alpha), -sin(alpha); 0, 0, sin(alpha), cos(alpha))
    $
  - spinor representation? we look for fields that transform as \
    $Psi^A (x) |-> Psi'^A (x) = (Lambda_(1\/2))^A zws_B Psi^B (Lambda^(-1) x)$, #h(1em) where $(Lambda_(1\/2))^A zws_B = (e^(-i/2 omega_(rho sigma) J^(rho sigma)))^A zws_B$ \
    representing spin $1/2$ ($mu, nu in {0, 1, 2, 3}$ and $A, B in {1, 2, ..., n}$) \
    answer: $(S^(mu nu))^A zws_B = i/4 [gamma^mu, gamma^nu]^A zws_B$, where $gamma^mu$ are $n times n$-matrices satisfying ${gamma^mu, gamma^nu} = 2 eta^(mu nu)$

= Revision 19 (15.12.2014)

- Spin-1/2-fields \
  $Psi^dagger = (Psi^*)^T$, $Psi^dagger Psi$ not a Lorentz scalar because $Lambda_(1/2)^dagger != Lambda_(1/2)^(-1)$ \
  $gamma^mu$, $mu in {0, 1, 2, 3}$ \
  $(gamma^0)^dagger = gamma^0$, $(gamma^i)^dagger = -gamma^i$ \
  $gamma^0 Lambda_(1/2)^dagger gamma^0 = Lambda_(1/2)^(-1)$ \
  #box(stroke: 0.5pt, inset: 4pt)[$macron(Psi) = Psi^dagger gamma^0$] #h(1em) Dirac conjugate spinor \
  $|m| hat(=) "mass of" Psi$ \
  #box(stroke: 0.5pt, inset: 4pt)[$S = integral_(RR^4) dd(4, x) macron(Psi) (i gamma^mu partial_mu - m) Psi$] #h(1em) Dirac action \
  $(i gamma^mu partial_mu - m) Psi = 0$ #h(1em) Dirac equation

= Revision 20 (15.12.2014)

No revision.

= Revision 21 (7.1.2015)

- Start from classical Lagrangian \
  $S = integral_(RR^4) dd(4, x) macron(Psi) (i gamma^mu partial_mu - m) Psi$ \
  #dm($Pi_A = (partial cal(L))/(partial dot(Psi)^A) = i Psi_A^dagger$), $A in {1, 2, 3, 4}$ spinor indices \
  and impose canonical _anti_\commutation relations \
  ${Psi^A (bx), Psi_B^dagger (by)} = delta^A zws_B delta^((3)) (bx - by)$ \
  ${Psi^A (bx), Psi^B (by)} = 0 = {Psi_A^dagger (bx), Psi_B^dagger (by)}$ \
  with the anticommutator ${M, N} = M N + N M = {N, M}$. \
  For mode expansion \
  #dm($Psi(bx) = sum_(s = plus.minus 1/2) integral_(RR^3) (dif^3 p)/(2 pi)^3 1/sqrt(2 E_bp) (a_s (bp) u_s (bp) e^(i bp bx) + b_s^dagger (bp) v_s (bp) e^(-i bp bx))$) \
  where $u_s (bp)$ and $v_s (bp)$ are spinor solutions to \
  $(gamma dot p - m) u_s (bp) = 0$, $(gamma dot p + m) v_s (bp) = 0$ \
  We have ${a_s (bp), a_r^dagger (bq)} = (2 pi)^3 delta_(s r) delta^3 (bp - bq) = {b_s (bp), b_r^dagger (bq)}$, while all other commutators vanish.
- Hamiltonian: #dm($H = integral_(RR^3) (dif^3 p)/(2 pi)^3 E_bp sum_(s = plus.minus 1/2) (a_s^dagger (bp) a_s (bp) + b_s^dagger (bp) b_s (bp))$), #h(1em) (after dropping vacuum energy)

= Revision 22 (12.1.2015)

- Anticommutator \
  $S^A zws_B (x - y) = {Psi^A (x), macron(Psi)_B (y)}$
  $
    S(x - y) & = integral_(RR^3) (dif^3 p)/(2 pi)^3 1/(2 E_bp) [(gamma dot p + m_0) e^(-i p(x - y)) + (gamma dot p - m_0) e^(i p(x - y))] \
             & = (i gamma dot partial + m_0) [D^((0)) (x - y) - D^((0)) (y - x)] \
    D^((0)) (x - y) & = integral_(RR^3) (dif^3 p)/(2 pi)^3 1/(2 E_bp) e^(-i p(x - y)) quad "free scalar propagator"
  $
- Feynman propagator $S_"F" (x - y) = bra(0) T Psi(x) macron(Psi)(y) ket(0)$ \
  Time-ordering symbol #dm($T Psi(x) macron(Psi)(y) = cases(Psi(x) macron(Psi)(y)\, quad & "if" x^0 >= y^0, -macron(Psi)(y) Psi(x)\, quad & "if" y^0 > x^0)$)

= Revision 23 (14.1.2015)

No revision.

= Revision 24 (19.1.2015)

- Free Maxwell action \
  #dm($S = integral_(RR^4) dd(4, x) (-1/4 F_(mu nu) F^(mu nu))$), #h(1em) where $F_(mu nu) = partial_mu A_nu - partial_nu A_mu$ \
  gauge invariance $A_mu <- A_mu + partial_mu alpha$
- If Lorenz condition $partial dot A = partial_mu A^mu = 0$ imposed, then residual gauge symmetry remains \
  $A_mu <- A_mu + partial_mu alpha$ for $square alpha = 0$
- Quantisation: start from gauge-fixed Lagrangian $cal(L) = -1/2 partial_mu A_nu partial^mu A^nu$ together with constraint $partial_mu A^mu = 0$
- #dm($Pi_mu (x) = -dot(A)_mu (x)$), where #dm($A_mu (x) = integral_(RR^3) (dif^3 p)/(2 pi)^3 1/sqrt(2 |bp|) sum_(lambda=0)^3 epsilon.alt^mu (bp, lambda) [a_lambda (bp) e^(-i p x) + a_lambda^dagger (bp) e^(i p x)]$) \
  and $epsilon.alt^mu (bp, lambda) epsilon.alt_mu (bp, lambda') = eta_(lambda lambda')$
- $[a_lambda (bp), a_(lambda')^dagger (bq)] = -eta_(lambda lambda') (2 pi)^3 delta^((3)) (bp - bq)$
- #dm($H = integral_(RR^3) (dif^3 p)/(2 pi)^3 |bp| (sum_(i=1)^3 a_i^dagger (bp) a_i (bp) - a_0^dagger (bp) a_0 (bp))$)
- $ket(bp\, lambda) = sqrt(2 E_bp) a_lambda^dagger (bp) ket(0)$, $E_bp = |bp|$

= Revision 25 (21.1.2015)

- QED Lagrangian $cal(L) = -1/4 F_(mu nu) F^(mu nu) - lambda/2 (partial_mu A^mu)^2 + macron(Psi) (i gamma^mu D_mu - m) Psi$, where $F_(mu nu) = partial_mu A_nu - partial_nu A_mu$ and $D_mu = partial_mu + i e A_mu$, $lambda = 1$ is called Feynman gauge
- photon propagator #h(1em) #diagram({
    photon((0, 0), (2.6, 0))
    draw.content((0, 0), text(size: 9pt, $mu$), anchor: "north", padding: 4pt)
    draw.content((2.6, 0), text(size: 9pt, $nu$), anchor: "north", padding: 4pt)
  }) #dm($hat(=) (-i eta_(mu nu))/(p^2 + i epsilon.alt)$)
- Fermion propagator #h(1em) #diagram(fermion((0, 0), (2.6, 0))) #dm($hat(=) (i (gamma dot p + m_0))/(p^2 - m_0^2 + i epsilon.alt)$)
- interaction vertex #h(1em) #diagram({
    fermion((-0.9, 0.5), (0, 0))
    fermion((0, 0), (-0.9, -0.5))
    photon((0, 0), (2, 0))
    vertex((0, 0))
  }) $hat(=) -i e gamma^mu$

= Revision 26 (26.1.2015)

- 1-loop electron propagator in QED \
  $bra(Omega) T Psi(x) macron(Psi)(y) ket(Omega) = #diagram({
      fermion((2.6, 0), (0, 0))
      vertex((0, 0), label: $x$, anchor: "east")
      vertex((2.6, 0), label: $y$, anchor: "west")
    }) + #diagram({
      fermion((2.6, 0), (1.9, 0))
      fermion((1.9, 0), (0.7, 0))
      fermion((0.7, 0), (0, 0))
      decorations.wave(draw.arc((0.7, 0), start: 180deg, stop: 0deg, radius: 0.6), amplitude: 0.1, segment-length: 0.25)
      vertex((0, 0), label: $x$, anchor: "east")
      vertex((2.6, 0), label: $y$, anchor: "west")
    }) + ...$ #h(1em) (second diagram: self-energy at 1-loop) \
  self energy: #dm($-i Sigma_2 (fsl(p)) = (-i e)^2 integral_(RR^4) (dif^4 k)/(2 pi)^4 gamma^mu (i (fsl(k) + m_0))/(k^2 - m_0^2 + i epsilon.alt) gamma_mu (-i)/((p - k)^2 - mu^2 + i epsilon.alt)$)

= Revision 27 (28.1.2015)

- regularised electron mass at 1-loop (order $cal(O)(alpha^2)$)
  $ m - m_0 = Sigma_2 (fsl(p) = m_0) + cal(O)(alpha^2) = alpha_0/(2 pi) m_0 integral_0^1 dd(x) (2 - x) log((x Lambda^2)/((1 - x)^2 m_0^2 + x mu^2)) $
  gives $m_0 = m_0 (m, Lambda)$ for the bare mass $m_0$ in terms of the measured physical mass $m$, and $Lambda$; plug in everywhere for bare quantities expressions of the form $m_0 (m, Lambda)$, etc., then $Lambda$ disappears for all physical quantities such as scattering amplitudes (this process is called renormalisation)
- Photon propagator (in Feynman gauge)
  $ lr(chevron.l Omega |T A_mu (x) A_nu (y)| Omega chevron.r) = integral_(RR^4) (dif^4 q)/(2 pi)^4 e^(-i q(x - y)) ((-i)/(q^2 (1 - Pi(q^2))) (eta_(mu nu) - (q_mu q_nu)/q^2) + (-i)/q^2 (q_mu q_nu)/q^2) $
