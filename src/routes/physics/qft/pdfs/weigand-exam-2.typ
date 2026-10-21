#import "/notes.typ": dd, notes, tagged, task
#import "@preview/cetz:0.5.2": canvas, draw

#show: notes.with(
  title: [Exam on Quantum Field Theory I],
  subtitle: [Devised by Timo Weigand, written on 03.04.2014],
  date: [Solutions by Janosh Riebesell, 02.04.2015],
)

// Feynman diagram helpers: solid lines for sigma, dashed lines for phi.
#let feyn(body, length: 0.9cm) = box(baseline: 50%, canvas(length: length, {
  import draw: *
  set-style(stroke: 0.7pt)
  body
}))
#let scalar(a, b) = draw.line(a, b, stroke: (dash: "dashed", thickness: 0.7pt))
#let vtx(pt) = draw.circle(pt, radius: 0.05, fill: black, stroke: none)
#let lbl(pt, body, anchor: "center") = draw.content(pt, text(size: 8pt, body), anchor: anchor)
#let mom(a, b) = draw.line(a, b, stroke: 0.5pt, mark: (end: "stealth", fill: black, scale: 0.45))

= Problem 1 (11 points)

#task[
  The action for a complex scalar field $phi(x)$ is given by
  #tagged(1, $ S = integral dd(4, x) (partial_mu phi^dagger (x) partial^mu phi(x) - M^2 phi^dagger (x) phi(x)). $)
  The mode expansion of $phi(x)$ is given by
  $ phi(x) = integral (dd(3, p))/(2 pi)^3 1/sqrt(2 E_p) lr((a(p) e^(-i p x) + b^dagger (p) e^(i p x)) |)_(p^0 = E_p), $
  where the creation and annihilation operators satisfy the commutation relations
  $ [a(p), a^dagger (q)] = [b(p), b^dagger (q)] = (2 pi)^3 delta^((3)) (arrow(p) - arrow(q)). $
]

#task(label: "a")[
  For a theory of several fields $chi_k$ the canonical stress-energy tensor is
  $ T^(mu nu) = sum_k (partial cal(L))/(partial(partial_mu chi_k)) partial^nu chi_k - eta^(mu nu) cal(L). $
  Show that $partial_mu T^(mu nu) = 0$ on shell for the theory of a complex scalar field given by (1).
]

$
  T^(mu nu) & = partial^mu phi^dagger partial^nu phi + partial^mu phi partial^nu phi^dagger - eta^(mu nu) partial_alpha phi^dagger partial^alpha phi + eta^(mu nu) M^2 phi^dagger phi, \
  partial_mu T^(mu nu) & = partial_mu (partial^mu phi^dagger partial^nu phi) + partial_mu (partial^mu phi partial^nu phi^dagger) - partial^nu (partial_alpha phi^dagger partial^alpha phi) + partial^nu (M^2 phi^dagger phi) \
  & = partial^2 phi^dagger partial^nu phi + underline(underline(partial^mu phi^dagger partial_mu partial^nu phi)) + partial^2 phi partial^nu phi^dagger + underline(partial^mu phi partial_mu partial^nu phi^dagger) \
  & quad - underline(partial^nu partial_alpha phi^dagger partial^alpha phi) - underline(underline(partial_alpha phi^dagger partial^nu partial^alpha phi)) + M^2 phi^dagger partial^nu phi + M^2 phi partial^nu phi^dagger \
  & = underbrace((partial^2 phi^dagger + M^2 phi^dagger), = 0 "(e.o.m.)") partial^nu phi + underbrace((partial^2 phi + M^2 phi), = 0 "(e.o.m.)") partial^nu phi^dagger = 0.
$
We see that on-shell, i.e. when imposing the Klein-Gordon eq. -- the equation of motion for the free scalar field -- $(partial^2 + M^2) phi = 0$ to be true, the stress-energy tensor's total derivative vanishes.

#task(label: "b")[
  From the stress-tensor components we define conserved charges as $Q^nu = integral dd(3, x) T^(0 nu)$. Show that the charges $Q^i$ for $i in {1, 2, 3}$ are given by
  $ Q^i = integral (dd(3, p))/(2 pi)^3 p^i (a^dagger (p) a(p) + b^dagger (p) b(p)). $
  _Hint:_ Perform the integral $integral dd(3, x)$ before performing any momentum integral.
]

From part a) we can deduce $T^(0 i)$ with $i in {1, 2, 3}$ to be
$ T^(0 i) = partial^0 phi^dagger partial^i phi + partial^0 phi partial^i phi^dagger = partial_t phi^dagger partial/(partial x_i) phi + partial_t phi partial/(partial x_i) phi^dagger, $
where
$
  partial_t phi & = i integral (dd(3, p))/(2 pi)^3 sqrt(E_p / 2) (b^dagger (p) e^(i p x) - a(p) e^(-i p x)), \
  partial^i phi & = -i integral (dd(3, p))/(2 pi)^3 p^i/sqrt(2 E_p) (a(p) e^(-i p x) - b^dagger (p) e^(i p x)).
$
Inserting the above expressions into the charge, we get
$
  Q^i & = integral dd(3, x) (partial_t phi^dagger partial^i phi + partial_t phi partial^i phi^dagger) = 1/2 integral (dd(3, p))/(2 pi)^3 p^i (a^dagger (p) a(p) - a^dagger (p) b^dagger (-p) \
  & quad - b(p) a(-p) + b(p) b^dagger (p) + b^dagger (p) b(p) - b^dagger (p) a^dagger (-p) - a(p) b(-p) + a(p) a^dagger (p)) \
  & = 1/2 integral (dd(3, p))/(2 pi)^3 p^i (2 a^dagger (p) a(p) + 2 b^dagger (p) b(p) + 2 dot (2 pi)^3 delta^((3)) (0)) \
  & quad - 1/2 integral (dd(3, p))/(2 pi)^3 (underbrace(p^i (a^dagger (p) b^dagger (-p) + a^dagger (-p) b^dagger (p)), "antisymmetric under" p^i -> -p^i) + underbrace(p^i (a(p) b(-p) + a(-p) b(p)), "antisymmetric under" p^i -> -p^i)) \
  & = integral (dd(3, p))/(2 pi)^3 p^i (a^dagger (p) a(p) + b^dagger (p) b(p)) + integral dd(3, p) p^i delta^((3)) (0).
$
We could get an overall minus sign in front of the charge, which would be no issue since we allow charges to take positive and negative values and which we call which is up to us. The last term is formally divergent ($delta^((3)) (0)$ is the volume of space) but its integrand is odd in $p^i$, so it vanishes under symmetric integration. (Unlike for the energy $Q^0$, the vacuum carries no momentum.)

#task(label: "c")[Consider the action of $Q^i$ on the states $a^dagger (k) |0 chevron.r$ and $b^dagger (q) |0 chevron.r$ and hence give a physical interpretation for the charges $Q^i$.]

$
  Q^i a^dagger (k) |0 chevron.r & = integral (dd(3, p))/(2 pi)^3 p^i (a^dagger (p) a(p) + b^dagger (p) b(p)) a^dagger (k) |0 chevron.r \
  & = integral (dd(3, p))/(2 pi)^3 p^i (a^dagger (p) (a^dagger (k) a(p) + (2 pi)^3 delta^((3)) (p - k)) + a^dagger (k) b^dagger (p) b(p)) |0 chevron.r \
  & = integral (dd(3, p))/(2 pi)^3 p^i a^dagger (p) (2 pi)^3 delta^((3)) (p - k) |0 chevron.r = k^i a^dagger (k) |0 chevron.r, \
  Q^i b^dagger (q) |0 chevron.r & = integral (dd(3, p))/(2 pi)^3 p^i (a^dagger (p) a(p) + b^dagger (p) b(p)) b^dagger (q) |0 chevron.r \
  & = integral (dd(3, p))/(2 pi)^3 p^i (b^dagger (q) a^dagger (p) a(p) + b^dagger (p) (b^dagger (q) b(p) + (2 pi)^3 delta^((3)) (p - q))) |0 chevron.r \
  & = integral (dd(3, p))/(2 pi)^3 p^i b^dagger (p) (2 pi)^3 delta^((3)) (p - q) |0 chevron.r = q^i b^dagger (q) |0 chevron.r,
$
where we used that the annihilation operators $a(p)$, $b(p)$ destroy the vacuum
$ a(p) |0 chevron.r = b(p) |0 chevron.r = 0 quad forall p. $
We find that $Q^i$'s eigenvalues corresponding to the 1-particle states $a^dagger (k) |0 chevron.r$ and $b^dagger (q) |0 chevron.r$ are the spatial components of the momenta $k$ and $q$.

= Problem 2 (6 points)

#task[
  The Lagrangian density for a massless vector field $A^mu$ is given by
  #tagged(2, $ cal(L) = -1/4 F_(mu nu) F^(mu nu), quad "where" F_(mu nu) = partial_mu A_nu - partial_nu A_mu. $)
]

#task(label: "a")[
  What problem does arise if one tries to quantise the theory given by eq. (2) by enforcing canonical equal-time commutation relations
  $ [A^mu (t, arrow(x)), pi_nu (t, arrow(y))] = i delta^mu_nu delta^((3)) (arrow(x) - arrow(y)) ? $
]

The Lagrangian in eq. (2) is not suitable for quantisation because it produces an unphysical conjugate momentum density. Specifically, $pi_mu$ turns out to be
$ pi_mu = (partial cal(L))/(partial dot(A)^mu) = F_(mu 0), $
which yields immediately that $pi_0 = F_(00) = 0$ since $F_(mu nu)$ is antisymmetric. Hence we must concede that $(A^mu, pi_mu)$ are no good canonical variables.

#task(label: "b")[Sketch briefly how the problem can be overcome.]

The problem stems from the gauge redundancy of $A^mu$: not all four components are physical degrees of freedom, and $A^0$ has no conjugate momentum. It can be overcome by fixing the gauge, e.g. by adding the Lorenz gauge-fixing term $-1/(2 xi) (partial_mu A^mu)^2$ to the Lagrangian. This yields $pi_0 = -1/xi partial_mu A^mu != 0$, so the canonical commutation relations can be imposed on all four components. The unphysical (timelike and longitudinal) photon states this introduces are removed from the physical Hilbert space by the Gupta-Bleuler condition $partial_mu A^(mu, +) |"phys" chevron.r = 0$, leaving all physical observables unchanged.

= Problem 3 (12 points)

#task[
  The Lagrangian density for a free Dirac fermion is given by
  #tagged(3, $ cal(L)(x) = macron(Psi)(x) (i gamma^mu partial_mu - m) Psi(x). $)
  Consider a Lorentz transformation where we keep the coordinate axes fixed and only transform the fields, i.e.
  $ x^mu -> x^mu "(unchanged)", quad partial^mu -> partial^mu "(unchanged)", quad Psi(x) -> Lambda_(1/2) Psi(Lambda^(-1) x), $
  where $Lambda_(1/2) = exp(i/2 omega_(mu nu) S^(mu nu))$ with $S^(mu nu) = i/4 [gamma^mu, gamma^nu]$. We also work in a basis where
  $ gamma^0 = mat(0, bb(1)_2; bb(1)_2, 0), quad gamma^i = mat(0, sigma^i; -sigma^i, 0) $
  for $i in {1, 2, 3}$, where $bb(1)_2$ is the $2 times 2$ unit matrix and $sigma^i$ are the Pauli matrices.
]

#task(label: "a")[Show that $(S^(mu nu))^dagger gamma^0 = gamma^0 S^(mu nu)$.]

$
  (S^(mu nu))^dagger gamma^0 & = -i/4 [(gamma^nu)^dagger, (gamma^mu)^dagger] gamma^0 = i/4 ((gamma^mu)^dagger (gamma^nu)^dagger gamma^0 - (gamma^nu)^dagger (gamma^mu)^dagger gamma^0) \
  & = i/4 (underbrace(gamma^0 gamma^0, bb(1)_4) (gamma^mu)^dagger gamma^0 gamma^0 (gamma^nu)^dagger gamma^0 - gamma^0 gamma^0 (gamma^nu)^dagger gamma^0 underbrace(gamma^0 (gamma^mu)^dagger gamma^0, gamma^mu)) = gamma^0 i/4 [gamma^mu, gamma^nu] = gamma^0 S^(mu nu),
$
where we used that $(gamma^0)^2 = bb(1)_4$, which follows directly from the defining relation of the Clifford algebra ${gamma^mu, gamma^nu} = 2 eta^(mu nu) bb(1)_4$ for $mu = nu = 0$, and that $(gamma^mu)^dagger = gamma^0 gamma^mu gamma^0$ which holds specifically for our choice of gamma matrices, where $(gamma^0)^dagger = gamma^0$ and $(gamma^i)^dagger = -gamma^i$. Together with the Clifford algebra's anticommutator, this yields
$ (gamma^mu)^dagger = cases(gamma^mu = gamma^0 gamma^0 gamma^mu = gamma^0 gamma^mu gamma^0 & "for" mu = 0, -gamma^mu = -gamma^mu gamma^0 gamma^0 = gamma^0 gamma^mu gamma^0 & "for" mu in {1, 2, 3}.) $

#task(label: "b")[Using the result from part a) and the fact that $(Lambda_(1/2))^(-1) gamma^mu Lambda_(1/2) = Lambda^mu_(med nu) gamma^nu$ show that under a Lorentz transformation the Lagrangian density transforms as $cal(L)(x) -> cal(L)(Lambda^(-1) x)$.]

$
  cal(L)(x) & attach(-->, t: Lambda_(1/2)) (Lambda_(1/2) Psi(Lambda^(-1) x))^dagger gamma^0 (i gamma^mu partial_mu - m) Lambda_(1/2) Psi(Lambda^(-1) x) \
  & = Psi^dagger (Lambda^(-1) x) e^(-i/2 omega_(mu nu) (S^(mu nu))^dagger) gamma^0 (i gamma^mu partial_mu - m) Lambda_(1/2) Psi(Lambda^(-1) x) \
  & = macron(Psi)(Lambda^(-1) x) underbrace(e^(-i/2 omega_(mu nu) S^(mu nu)), (Lambda_(1/2))^(-1)) (i gamma^mu partial_mu - m) Lambda_(1/2) Psi(Lambda^(-1) x) \
  & = macron(Psi)(Lambda^(-1) x) (i Lambda^mu_(med nu) gamma^nu partial_mu - m) Psi(Lambda^(-1) x) = cal(L)(Lambda^(-1) x),
$
where we used that
$ e^((S^(mu nu))^dagger) gamma^0 = sum_(n = 0)^oo ((S^(mu nu))^(dagger n))/n! gamma^0 attach(=, t: "a)") gamma^0 sum_(n = 0)^oo (S^(mu nu))^n/n! = gamma^0 e^(S^(mu nu)) $
and in the last step the chain rule $partial_mu (Psi(Lambda^(-1) x)) = [Lambda^(-1)]^rho_(med mu) (partial_rho Psi)(Lambda^(-1) x)$ together with $Lambda^mu_(med nu) [Lambda^(-1)]^rho_(med mu) = delta^rho_nu$.

#task(label: "c")[Define $Psi_plus.minus = P_plus.minus Psi$ where $P_plus.minus = 1/2 (bb(1)_4 plus.minus gamma^5)$ and $gamma^5 = i gamma^0 gamma^1 gamma^2 gamma^3$. Show that $macron(Psi_plus.minus) = macron(Psi) P_minus.plus$. Rewrite the Lagrangian density (3) in terms of $Psi_+$ and $Psi_-$. Derive the equation of motion for $Psi_+$ and $Psi_-$. _Note:_ You can use identities involving $gamma^5$ without proof.]

$
  (gamma^5)^dagger & = -i (gamma^3)^dagger (gamma^2)^dagger (gamma^1)^dagger (gamma^0)^dagger = -i (-gamma^3) (-gamma^2) (-gamma^1) gamma^0 = i gamma^3 gamma^2 gamma^1 gamma^0 = (-1)^3 i gamma^0 gamma^3 gamma^2 gamma^1 \
  & = (-1)^5 i gamma^0 gamma^1 gamma^3 gamma^2 = (-1)^6 i gamma^0 gamma^1 gamma^2 gamma^3 = gamma^5, \
  macron(Psi_plus.minus) & = (Psi_plus.minus)^dagger gamma^0 = (P_plus.minus Psi)^dagger gamma^0 = Psi^dagger P_plus.minus^dagger gamma^0 = Psi^dagger 1/2 (bb(1)_4 plus.minus (gamma^5)^dagger) gamma^0 = Psi^dagger gamma^0 1/2 (bb(1)_4 plus.minus (-1)^3 gamma^5) \
  & = macron(Psi) 1/2 (bb(1)_4 minus.plus gamma^5) = macron(Psi) P_minus.plus.
$
To rewrite the Lagrangian in eq. (3) in terms of $Psi_+$ and $Psi_-$, we note that
$
  P_+ + P_- & = 1/2 (bb(1)_4 + gamma^5) + 1/2 (bb(1)_4 - gamma^5) = bb(1)_4 quad ==> quad Psi_+ + Psi_- = P_+ Psi + P_- Psi = (P_+ + P_-) Psi = Psi, \
  macron(Psi) & = Psi^dagger gamma^0 = (Psi_+ + Psi_-)^dagger gamma^0 = Psi_+^dagger gamma^0 + Psi_-^dagger gamma^0 = macron(Psi)_+ + macron(Psi)_-, \
  cal(L) & = macron(Psi)_+ (i gamma^mu partial_mu - m) Psi_+ + macron(Psi)_+ (i gamma^mu partial_mu - m) Psi_- + macron(Psi)_- (i gamma^mu partial_mu - m) Psi_+ + macron(Psi)_- (i gamma^mu partial_mu - m) Psi_- \
  & = macron(Psi)_+ i gamma^mu partial_mu Psi_+ - macron(Psi)_+ m Psi_+ + macron(Psi)_+ i gamma^mu partial_mu Psi_- - macron(Psi)_+ m Psi_- \
  & quad + macron(Psi)_- i gamma^mu partial_mu Psi_+ - macron(Psi)_- m Psi_+ + macron(Psi)_- i gamma^mu partial_mu Psi_- - macron(Psi)_- m Psi_- \
  & = macron(Psi)_+ i gamma^mu partial_mu Psi_+ + macron(Psi)_- i gamma^mu partial_mu Psi_- - macron(Psi)_+ m Psi_- - macron(Psi)_- m Psi_+,
$
where we used in the last step that $macron(Psi)_plus.minus Psi_plus.minus = macron(Psi) P_minus.plus P_plus.minus Psi = 0$ and $macron(Psi)_plus.minus gamma^mu Psi_minus.plus = macron(Psi) P_minus.plus gamma^mu Psi_minus.plus = macron(Psi) gamma^mu P_plus.minus P_minus.plus Psi = 0$ because $P_plus.minus P_minus.plus = 1/4 (bb(1)_4 - (gamma^5)^2) = 1/4 (bb(1)_4 - bb(1)_4) = 0$. Applying the Euler-Lagrange equation $partial_mu (partial cal(L))/(partial(partial_mu Psi)) = (partial cal(L))/(partial Psi)$ to the new Lagrangian gives
$
  Psi_+ & : quad partial_mu macron(Psi)_+ i gamma^mu + m macron(Psi)_- = 0, & quad macron(Psi)_+ & : quad i gamma^mu partial_mu Psi_+ - m Psi_- = 0, \
  Psi_- & : quad partial_mu macron(Psi)_- i gamma^mu + m macron(Psi)_+ = 0, & quad macron(Psi)_- & : quad i gamma^mu partial_mu Psi_- - m Psi_+ = 0.
$

#task(label: "d")[The spinors $Psi_+$ and $Psi_-$ correspond to two-component Weyl spinors. What are the properties of a particle which can be represented by a single Weyl spinor?]

For a particle to be described by a single Weyl spinor, the above equations of motion would have to be decoupled. We can see that this is only the case for $m = 0$. Such a particle is massless and has definite chirality, which for a massless particle coincides with its helicity $plus.minus 1/2$.

= Problem 4 (11 points)

#task[
  Consider the following theory for a complex scalar field $phi$ and a real scalar field $sigma$:
  $ cal(L) = partial_mu phi^dagger partial^mu phi + 1/2 partial_mu sigma partial^mu sigma - M^2 phi^dagger phi - m^2/2 sigma^2 - lambda sigma phi^dagger phi - lambda^2 sigma^2 phi^dagger phi. $
]

#task(label: "a")[State the momentum space Feynman rules for calculating scattering amplitudes for this theory. (No calculation required.)]

To compute the amplitude for a scattering process with $n$ ingoing momenta $p_1, dots, p_n$ and $r$ outgoing momenta $q_1, dots, q_r$ in this theory, we perform the following:
- Draw all relevant fully connected amputated diagrams with $(n + r)$ external points to given order in $lambda$.
- Assign ingoing momenta labels $p_k$, $k in {1, dots, n}$ and outgoing momenta labels $q_l$, $l in {1, dots, r}$ and label momenta of internal lines with $k_j$.
- Each three-particle vertex gets a factor $-i lambda$, each four-particle vertex $-2 i lambda^2$ (the factor 2 from the two identical $sigma$ legs).
- To each internal line, we associate a propagator
  $ i/(k_j^2 - M^2) & quad "if it is a" phi "field", \
  i/(k_j^2 - m^2) & quad "if it is a" sigma "field". $
- We then integrate over all undetermined internal momenta $product_j integral (dd(4, k_j))/(2 pi)^4$.
- Sum up all diagrams divided by their symmetry factors and multiply by $sqrt(Z)^(n + r)$ to given order in $lambda$.

#task(label: "b")[Draw all Feynman graphs to order $lambda^2$ for the non-trivial scattering of $phi^dagger phi -> sigma sigma$.]

#let exchange(crossed: false) = feyn({
  let (a, b) = ((1.2, 1.6), (1.2, 0.2))
  scalar((0, 1.8), a)
  scalar((0, 0), b)
  scalar(a, b)
  draw.line(a, if crossed { (2.4, 0) } else { (2.4, 1.8) })
  draw.line(b, if crossed { (2.4, 1.8) } else { (2.4, 0) })
  vtx(a)
  vtx(b)
  lbl((-0.1, 1.8), $phi^dagger$, anchor: "east")
  lbl((-0.1, 0), $phi$, anchor: "east")
  lbl((2.5, 1.8), $q_1$, anchor: "west")
  lbl((2.5, 0), $q_2$, anchor: "west")
  lbl((1.0, 0.9), $phi$, anchor: "east")
})

#align(center, stack(dir: ltr, spacing: 1.2cm, feyn({
  let c = (1.2, 0.9)
  for p in ((0, 1.8), (0, 0)) { scalar(p, c) }
  for p in ((2.4, 1.8), (2.4, 0)) { draw.line(p, c) }
  vtx(c)
  lbl((-0.1, 1.8), $phi^dagger$, anchor: "east")
  lbl((-0.1, 0), $phi$, anchor: "east")
  lbl((2.5, 1.8), $sigma$, anchor: "west")
  lbl((2.5, 0), $sigma$, anchor: "west")
  mom((0.35, 1.75), (0.75, 1.45))
  mom((0.35, 0.05), (0.75, 0.35))
  mom((1.65, 1.03), (2.05, 1.33))
  mom((1.65, 0.35), (2.05, 0.05))
  lbl((0.5, 1.8), $p_1$, anchor: "south-west")
  lbl((0.5, 0), $p_2$, anchor: "north-west")
  lbl((2.1, 1.2), $q_1$, anchor: "north-west")
  lbl((1.9, 0), $q_2$, anchor: "north-east")
  lbl((1.2, 1.05), $lambda^2$, anchor: "south")
}), exchange(), exchange(crossed: true)))

#task(label: "c")[Now write down the matrix element $i cal(M)$ for the process $phi^dagger phi -> sigma sigma$ to order $lambda^2$. What is the matrix element $i cal(M)$ for the process $phi phi -> sigma sigma$ to order $lambda^2$?]

$ i cal(M) = -2 i lambda^2 + (-i lambda)^2 (i/((p_1 - q_1)^2 - M^2) + i/((p_1 - q_2)^2 - M^2)) = -i lambda^2 (2 + 1/((p_1 - q_1)^2 - M^2) + 1/((p_1 - q_2)^2 - M^2)). $

The process $phi phi -> sigma sigma$ violates the conservation of the $U(1)$ charge (both interaction terms contain $phi^dagger phi$), so its amplitude vanishes, $i cal(M) = 0$, at order $lambda^2$ and indeed to all orders.

#task(label: "d")[Draw Feynman diagrams to and including order $lambda^4$ which contribute to the 1PI self energy (i.e. the 1PI contributions to the propagator) of the field $sigma$.]

#let bubble(quartic: false) = feyn({
  draw.line((0, 0), (1, 0))
  draw.line((2.2, 0), (3.2, 0))
  if quartic { draw.line((1, 0), (2.2, 0)) }
  draw.circle((1.6, 0), radius: 0.6, stroke: (dash: "dashed", thickness: 0.7pt))
  vtx((1, 0))
  vtx((2.2, 0))
  lbl((-0.1, 0), $sigma$, anchor: "east")
  lbl((3.3, 0), $sigma$, anchor: "west")
  lbl((1.6, 0.7), $phi$, anchor: "south")
  lbl((1.6, -0.7), $phi^dagger$, anchor: "north")
  let l = if quartic { $lambda^2$ } else { $lambda$ }
  lbl((0.95, 0.15), l, anchor: "south-east")
  lbl((2.25, 0.15), l, anchor: "south-west")
})

#let seagull = feyn({
  draw.line((0, 0), (2.4, 0))
  draw.circle((1.2, 0.6), radius: 0.6, stroke: (dash: "dashed", thickness: 0.7pt))
  vtx((1.2, 0))
  lbl((-0.1, 0), $sigma$, anchor: "east")
  lbl((2.5, 0), $sigma$, anchor: "west")
  lbl((1.2, 1.3), $phi$, anchor: "south")
  lbl((1.2, -0.1), $lambda^2$, anchor: "north")
})

$ #bubble() quad + quad #seagull quad + quad #bubble(quartic: true) quad + quad dots $

The first two diagrams are the complete one-loop contributions (both of order $lambda^2$). At order $lambda^4$ there are a number of two-loop diagrams, the third being one example; the others are obtained by inserting a further cubic or quartic vertex into the $phi$ loops of the first two diagrams.

= Problem 5 (9 points)

#task(label: "a")[
  Discuss the difference between the bare mass $m_0$ and the physical mass $m$ of an electron in Quantum Electrodynamics. Your answer should include
  - which of both quantities is cutoff-dependent,
  - their relation to the wavefunction renormalization $Z_2$ and the electron self-energy.
  Also sketch how you would calculate $Z_2$ in perturbation theory.
]

Only the physical mass $m$ is an observable; it is the rest mass of an electron as measured in experiments. By contrast $m_0$, the so-called bare mass, is merely a parameter that specifies the Lagrangian. It can never be measured directly. Rather the Lagrangian produces measurable quantities, the scattering amplitudes, which depend on $m_0$.

This fact allows us to absorb the divergent quantity $delta m := m - m_0$ completely into $m_0$, making the latter a function of the measured physical mass and the cutoff $Lambda$, $m_0 = m_0 (m, Lambda)$.

The physical mass is the pole of the full propagator $i/(cancel(p) - m_0 - Sigma(cancel(p)))$, i.e. $m - m_0 = Sigma(cancel(p) = m)$, where $Sigma$ is the 1PI electron self-energy (to order $alpha$ the one-loop photon exchange diagram), and the wavefunction renormalization $Z_2$ is defined as
$ Z_2 := lr((1 - (dif Sigma(cancel(p)))/(dif cancel(p)))^(-1) |)_(cancel(p) = m). $

#task(label: "b")[Draw all Feynman diagrams in QED which contribute to vertex renormalization at order $e_0^4$ exactly.]

This topic was unaddressed by our coverage of QFT. Part c) likewise.
