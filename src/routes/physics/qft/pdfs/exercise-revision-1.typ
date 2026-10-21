#import "/notes.typ": dd, notes, tagged, task
#import "@preview/cetz:0.5.2": canvas, draw

#show: notes.with(
  title: [Revision of Exercises Relevant for the Exam],
  subtitle: [Quantum Field Theory I, Prof. Jürgen Berges],
  date: [Solutions by Janosh Riebesell, 31.01.2015],
)

#let ck = sym.checkmark
// Levi-Civita symbol with staggered indices epsilon^(ij)_k
#let eijk = $epsilon^(i j)_(#hide($i j$) k)$
#figure(
  table(
    columns: (auto,) + (1.6em,) * 4,
    align: center,
    stroke: (x, y) => (
      left: if x == 1 { 0.6pt } else { none },
      bottom: if y == 0 { 0.6pt } else { none },
    ),
    inset: (x: 4pt, y: 2.5pt),
    [*Sheet*], [*1*], [*2*], [*3*], [*4*],
    [1], [], [#ck], [], [],
    [2], [#ck], [#ck], [#ck], [],
    [3], [], [#ck], [#ck], [],
    [4], [#ck], [#ck], [], [],
    [5], [], [], [#ck], [],
    [6], [], [#ck], [], [],
    [7], [], [#ck], [#ck], [],
    [8], [], [], [], [],
    [9], [#ck], [#ck], [], [#ck],
    [10], [], [], [#ck], [],
    [11], [#ck], [], [], [],
  ),
  caption: [Exercises relevant for the exam (problem number per exercise sheet).],
)

= Problem 1.2 (Classical electrodynamics as a field theory)

#task[
  From classical electrodynamics we recall the following form of the Lagrangian for the electromagnetic field in vacuum
  #tagged(3, $ cal(L) = -1/4 F_(mu nu) F^(mu nu). $)
  Here the field strength tensor $F^(mu nu)$ is defined as $F^(mu nu) = partial^mu A^nu - partial^nu A^mu$ in terms of the gauge potential $A^mu$.
]

#task(label: "a")[Derive the Lorentz transformation property of $F^(mu nu)$ from the fact that $A^mu$ is a 4-vector.]

$A^mu$ being a 4-vector implies that under a Lorentz transformation $Lambda$ it behaves like
$ A'^mu = sum_(nu = 0)^3 Lambda^mu_(#hide($mu$) nu) A^nu = Lambda^mu_(#hide($mu$) nu) A^nu. $
The same holds for $partial^mu$ as can be seen from the following:
$ partial'^mu := partial/(partial x'_mu) = (partial x_nu)/(partial x'_mu) partial/(partial x_nu) = Lambda^mu_(#hide($mu$) nu) partial/(partial x_nu) = Lambda^mu_(#hide($mu$) nu) partial^nu, $
where the Lorentz transformation comes from the fact that
$ (x')^2 = x'_mu x'^mu = x'_mu Lambda^mu_(#hide($mu$) nu) x^nu attach(=, t: !) x_nu x^nu = x^2 quad ==> quad x_nu = x'_mu Lambda^mu_(#hide($mu$) nu). $
Therefore, $F^(mu nu)$ transforms like a rank-2 tensor, i.e.
$
  F'^(mu nu) & = partial'^mu A'^nu - partial'^nu A'^mu = Lambda^mu_(#hide($mu$) alpha) partial^alpha Lambda^nu_(#hide($nu$) beta) A^beta - Lambda^nu_(#hide($nu$) beta) partial^beta Lambda^mu_(#hide($mu$) alpha) A^alpha \
  & = Lambda^mu_(#hide($mu$) alpha) Lambda^nu_(#hide($nu$) beta) (partial^alpha A^beta - partial^beta A^alpha) = Lambda^mu_(#hide($mu$) alpha) Lambda^nu_(#hide($nu$) beta) F^(alpha beta).
$

#task(label: "b")[
  Derive the equations of motion from the general expression for the Euler--Lagrange equations,
  #tagged(4, $ partial_nu (partial cal(L))/(partial(partial_nu phi)) = (partial cal(L))/(partial phi), $)
  with $phi$ replaced by $A^mu$.
]

We need to calculate two terms for which an expression of $cal(L)$ in terms of the gauge potential $A^mu$ will come in handy. We have
$
  cal(L) & = -1/4 (partial_mu A_nu - partial_nu A_mu)(partial^mu A^nu - partial^nu A^mu) = -1/2 (partial_mu A_nu partial^mu A^nu - partial_mu A_nu partial^nu A^mu),
$
$
  cases(reverse: #true, gap: #0.8em, display(partial_nu (partial cal(L))/(partial(partial_nu A^mu)) = -partial_nu (partial^nu A_mu - partial_mu A^nu) = partial_nu F_mu^(#hide($mu$) nu)), display((partial cal(L))/(partial A^mu) = 0)) quad partial_nu F_mu^(#hide($mu$) nu) = partial^nu F_(mu nu) = 0.
$

= Problem 2.1 (Canonical commutation relations)

#task[
  Starting from the mode expansion of the Schrödinger fields,
  #tagged(1, $ phi(arrow(x)) = integral (dd(3, p))/(2 pi)^3 1/sqrt(2 E_p) (a(arrow(p)) e^(i arrow(p) dot arrow(x)) + a^dagger (arrow(p)) e^(-i arrow(p) dot arrow(x))), $)
  #tagged(2, $ pi(arrow(x)) = i integral (dd(3, p))/(2 pi)^3 sqrt(E_p / 2) (a^dagger (arrow(p)) e^(-i arrow(p) dot arrow(x)) - a(arrow(p)) e^(i arrow(p) dot arrow(x))), $)
  we'll derive the canonical commutation relations for the modes $a(arrow(p))$ and $a^dagger (arrow(p))$ using the steps below.
]

#task(label: "a")[Perform a Fourier transformation to deduce the relation between the Fourier modes $tilde(phi)(arrow(p))$, $tilde(pi)(arrow(p))$ and the modes $a(arrow(p))$ and $a^dagger (arrow(p))$.]

$
  tilde(phi)(arrow(p)) & = integral dd(3, x) e^(-i arrow(p) dot arrow(x)) phi(arrow(x)) = integral dd(3, x) e^(-i arrow(p) dot arrow(x)) integral (dd(3, q))/(2 pi)^3 1/sqrt(2 E_q) e^(i arrow(q) dot arrow(x)) (a(arrow(q)) + a^dagger (-arrow(q))) \
  & = integral (dd(3, q))/(2 pi)^3 1/sqrt(2 E_q) (a(arrow(q)) + a^dagger (-arrow(q))) underbrace(integral dd(3, x) e^(i (arrow(q) - arrow(p)) dot arrow(x)), (2 pi)^3 delta^((3)) (arrow(p) - arrow(q))) = 1/sqrt(2 E_p) (a(arrow(p)) + a^dagger (-arrow(p))), \
  tilde(pi)(arrow(p)) & = integral dd(3, x) e^(-i arrow(p) dot arrow(x)) pi(arrow(x)) = integral dd(3, x) e^(-i arrow(p) dot arrow(x)) i integral (dd(3, q))/(2 pi)^3 sqrt(E_q / 2) e^(i arrow(q) dot arrow(x)) (a^dagger (-arrow(q)) - a(arrow(q))) \
  & = i integral (dd(3, q))/(2 pi)^3 sqrt(E_q / 2) (a^dagger (-arrow(q)) - a(arrow(q))) underbrace(integral dd(3, x) e^(i (arrow(q) - arrow(p)) dot arrow(x)), (2 pi)^3 delta^((3)) (arrow(q) - arrow(p))) = i sqrt(E_p / 2) (a^dagger (-arrow(p)) - a(arrow(p))).
$

#task(label: "b")[
  Derive the commutation relation
  #tagged(3, $ [tilde(phi)(arrow(p)), tilde(pi)(arrow(q))] = i (2 pi)^3 delta^((3)) (arrow(p) + arrow(q)) $)
  from the canonical commutation relations for $phi(arrow(x))$ and $pi(arrow(x))$.
]

$ [tilde(phi)(arrow(p)), tilde(pi)(arrow(q))] = integral dd(3, x) e^(-i arrow(p) dot arrow(x)) integral dd(3, y) e^(-i arrow(q) dot arrow(y)) underbrace([phi(arrow(x)), pi(arrow(y))], i delta^((3)) (arrow(x) - arrow(y))) = i integral dd(3, x) e^(-i arrow(p) dot arrow(x)) e^(-i arrow(q) dot arrow(x)) = i (2 pi)^3 delta^((3)) (arrow(p) + arrow(q)). $

#task(label: "c")[
  Conclude that
  #tagged(4, $ [a(arrow(p)), a^dagger (arrow(q))] = (2 pi)^3 delta^((3)) (arrow(p) - arrow(q)), quad [a(arrow(p)), a(arrow(q))] = 0 = [a^dagger (arrow(p)), a^dagger (arrow(q))]. $)
]

$
  [a(arrow(p)), a^dagger (arrow(q))] & = 1/4 [sqrt(2 E_p) tilde(phi)(arrow(p)) + i sqrt(2/E_p) tilde(pi)(arrow(p)), sqrt(2 E_q) tilde(phi)(-arrow(q)) - i sqrt(2/E_q) tilde(pi)(-arrow(q))] \
  & = 1/4 (2 sqrt(E_p E_q) [tilde(phi)(arrow(p)), tilde(phi)(-arrow(q))] - 2 i sqrt(E_p/E_q) [tilde(phi)(arrow(p)), tilde(pi)(-arrow(q))] + 2 i sqrt(E_q/E_p) [tilde(pi)(arrow(p)), tilde(phi)(-arrow(q))] \
    & #h(3em) + 2/sqrt(E_p E_q) [tilde(pi)(arrow(p)), tilde(pi)(-arrow(q))]) \
  & = -i/2 (sqrt(E_p/E_q) i (2 pi)^3 delta^((3)) (arrow(p) - arrow(q)) + sqrt(E_q/E_p) i (2 pi)^3 delta^((3)) (arrow(p) - arrow(q))) = (2 pi)^3 delta^((3)) (arrow(p) - arrow(q)), \
  [a(arrow(p)), a(arrow(q))] & = 1/4 [sqrt(2 E_p) tilde(phi)(arrow(p)) + i sqrt(2/E_p) tilde(pi)(arrow(p)), sqrt(2 E_q) tilde(phi)(arrow(q)) + i sqrt(2/E_q) tilde(pi)(arrow(q))] \
  & = 1/4 (2 sqrt(E_p E_q) [tilde(phi)(arrow(p)), tilde(phi)(arrow(q))] + 2 i sqrt(E_p/E_q) [tilde(phi)(arrow(p)), tilde(pi)(arrow(q))] \
    & #h(3em) + 2 i sqrt(E_q/E_p) [tilde(pi)(arrow(p)), tilde(phi)(arrow(q))] - 2/sqrt(E_p E_q) [tilde(pi)(arrow(p)), tilde(pi)(arrow(q))]) \
  & = i/2 (sqrt(E_p/E_q) i (2 pi)^3 delta^((3)) (arrow(p) + arrow(q)) - sqrt(E_q/E_p) i (2 pi)^3 delta^((3)) (arrow(p) + arrow(q))) = 0,
$
and similarly for $[a^dagger (arrow(p)), a^dagger (arrow(q))]$.

= Problem 2.3 (Rotational symmetry and its corresponding generators)

#task[
  Show that the action for the free classical Klein--Gordon field,
  #tagged(8, $ S = integral dd(4, x) cal(L) = integral dd(4, x) (1/2 partial_mu phi(x) partial^mu phi(x) - 1/2 m^2 phi^2 (x)), $)
  is invariant under the following three transformations
  #tagged(9, $ delta x^i = epsilon epsilon^(i j k) x_k quad "with" quad j in {1, 2, 3}. $)
  Furthermore, construct the corresponding Noether charges.
]

Since $epsilon$ is a continuous parameter, we can write the transformation infinitesimally and justify an expansion in $epsilon$ only to first order:
$
  phi(x) --> phi'(x'(x)) & = phi(x) + epsilon delta phi(x) + epsilon^2/2 delta^2 phi(x) + epsilon^3/3! delta^3 phi(x) + dots.c \
  & = phi(x) + epsilon delta phi(x) + cal(O)(epsilon^2),
$
where $x'(x) = Lambda x = x + delta x$ and $delta x$ is a 4-vector given by
$
  delta x^mu = cases(0 & "for" mu = 0, epsilon eijk x^k & "for" mu = i in {1, 2, 3} "and" j in {1, 2, 3},)
$
$
  j = 1: delta arrow(x) = epsilon vec(0, -x_3, x_2), quad j = 2: delta arrow(x) = epsilon vec(x_3, 0, -x_1), quad j = 3: delta arrow(x) = epsilon vec(-x_2, x_1, 0),
$
$
  j = 1: quad x' & = x + delta x = vec(x^0, x^1, x^2 - epsilon x^3, x^3 + epsilon x^2) = mat(1, 0, 0, 0; 0, 1, 0, 0; 0, 0, 1, -epsilon; 0, 0, epsilon, 1) x = Lambda x, \
  j = 2: quad x' & = x + delta x = vec(x^0, x^1 + epsilon x^3, x^2, x^3 - epsilon x^1) = mat(1, 0, 0, 0; 0, 1, 0, epsilon; 0, 0, 1, 0; 0, -epsilon, 0, 1) x = Lambda x, \
  j = 3: quad x' & = x + delta x = vec(x^0, x^1 - epsilon x^2, x^2 + epsilon x^1, x^3) = mat(1, 0, 0, 0; 0, 1, -epsilon, 0; 0, epsilon, 1, 0; 0, 0, 0, 1) x = Lambda x.
$
We can also write the transformation using the chain rule
$ phi(x) --> phi'(x'(x)) = phi(x) + (partial phi(x))/(partial x^mu) delta x^mu + cal(O)(epsilon^2) = phi(x) + partial_i phi(x) epsilon eijk x^k + cal(O)(epsilon^2), $
from which we see that $delta phi(x) = partial_i phi(x) eijk x^k$. Therefore to first order the Lagrangian transforms as
$
  cal(L) --> cal(L)' & = 1/2 partial_mu phi' partial^mu phi' - 1/2 m^2 phi'^2 = 1/2 [partial_mu (phi + epsilon delta phi) partial^mu (phi + epsilon delta phi) - m^2 (phi + epsilon delta phi)(phi + epsilon delta phi)] \
  & = 1/2 [partial_mu phi partial^mu phi + 2 partial_l phi partial^l epsilon partial_i phi eijk x^k - m^2 phi^2 - 2 m^2 phi epsilon partial_i phi eijk x^k + cal(O)(epsilon^2)] \
  & = cal(L) + epsilon partial_l phi partial^l partial_i phi eijk x^k - epsilon m^2 phi partial_i phi eijk x^k + cal(O)(epsilon^2).
$
After dropping terms of order $cal(O)(epsilon^2)$ and above, the transformed Lagrangian reads
$
  cal(L)' & = cal(L) + epsilon partial_l phi partial^l partial_i phi eijk x^k - epsilon m^2 phi partial_i phi eijk x^k \
  & = cal(L) + epsilon eijk x^k (partial_l phi partial^l partial_i phi - m^2 phi partial_i phi) \
  & = cal(L) + delta x^i (partial_i (1/2 partial_l phi partial^l phi - 1/2 m^2 phi^2)) = cal(L) + delta x^mu partial_mu cal(L),
$
as one would expect from an application of the chain rule as was done for the field $phi(x)$. Making use of the fact that $epsilon^(i j k)$ vanishes whenever two of its indices are identical, we can drag the $x^k$ in $delta x^mu$ into the derivative in front of $cal(L)$, i.e.
$ delta x^mu partial_mu cal(L) = delta x^i partial_i cal(L) = epsilon eijk x^k partial_i cal(L) = partial_i (epsilon eijk x^k cal(L)). $
Inserting this into the transformed action $S'$ gives
$
  S --> S' & = integral dd(4, x) cal(L)' = integral dd(4, x) cal(L) + integral dd(4, x) delta x^mu partial_mu cal(L) = S + integral dd(t) integral dd(3, x) partial_i (epsilon eijk x^k cal(L)) \
  & = S + underbrace(integral dd(t) integral_(partial RR^3) dd(A_i) epsilon eijk x^k cal(L), 0) = S,
$
where the integral over the surface of $RR^3$ is said to vanish because we only look at localized systems fulfilling $cal(L)(phi(x)) attach(-->, t: |x| -> oo) 0$.

Now, we calculate the corresponding Noether charges. Firstly, the currents are given by
$ j^mu = (partial cal(L))/(partial(partial_mu phi)) delta phi - F^mu, quad "where" quad (partial cal(L))/(partial(partial_mu phi)) = partial^mu phi quad "and" quad delta cal(L) = partial_mu F^mu. $
Comparing terms in our expansion of $cal(L)$, we see that
$
  & epsilon delta cal(L) = delta x^mu partial_mu cal(L) = partial_mu (delta x^mu cal(L)) & quad ==> quad & delta cal(L) = 1/epsilon partial_mu (delta x^mu cal(L)), \
  & F^mu = 1/epsilon delta x^mu cal(L) & quad ==> quad & F^0 = 0 quad "because" delta x^0 = 0, \
  & & & F^i = 1/epsilon epsilon eijk x^k cal(L) = eijk x^k cal(L).
$
Therefore, the Noether currents take the form
$
  j^0 & = (partial cal(L))/(partial(partial_0 phi)) delta phi - F^0 = pi delta phi = dot(phi) delta phi, \
  j^i & = (partial cal(L))/(partial(partial_i phi)) delta phi - F^i = partial^i phi delta phi - eijk x^k cal(L) quad "for" j in {1, 2, 3}.
$
The charge is obtained via integration over $j^0$:
$ Q = integral dd(3, x) j^0 = integral dd(3, x) dot(phi) delta phi = integral dd(3, x) dot(phi) eijk x^k partial_i phi quad "for" j in {1, 2, 3}. $

= Problem 3.2 (Quantisation of the complex scalar field)

#task[
  A complex scalar field $phi(x)$ of mass $m$ can be thought of as describing the degrees of freedom of two real scalar fields $phi_1 (x)$ and $phi_2 (x)$ of mass $m$ by writing
  #tagged(2, $ phi(x) = 1/sqrt(2) (phi_1 (x) + i phi_2 (x)). $)
  Using this relation, show the following assertions stated in the lecture:
]

#task(label: "a")[
  The (Schrödinger picture) Hamiltonian can be written as
  #tagged(3, $ H = integral dd(3, x) (pi^dagger (arrow(x)) pi(arrow(x)) + nabla phi^dagger (arrow(x)) dot nabla phi(arrow(x)) + m^2 phi^dagger (arrow(x)) phi(arrow(x))) $)
  with $pi(arrow(x)) = dot(phi)^dagger (arrow(x))$, $pi^dagger (arrow(x)) = dot(phi)(arrow(x))$.
]

If the complex scalar field can be thought of as stated in the problem, it should be possible to write the Lagrangian of the complex scalar field as a sum of two real scalar field Lagrangians, i.e.
$
  cal(L) & = cal(L)_1 + cal(L)_2 = 1/2 partial_mu phi_1 partial^mu phi_1 - 1/2 m^2 phi_1^2 + 1/2 partial_mu phi_2 partial^mu phi_2 - 1/2 m^2 phi_2^2 \
  & = 1/2 partial_mu phi_1 partial^mu phi_1 + i/2 partial_mu phi_1 partial^mu phi_2 - i/2 partial_mu phi_2 partial^mu phi_1 + 1/2 partial_mu phi_2 partial^mu phi_2 - 1/2 m^2 (phi_1^2 + phi_2^2) \
  & = partial_mu 1/sqrt(2) (phi_1 - i phi_2) partial^mu 1/sqrt(2) (phi_1 + i phi_2) - m^2 1/sqrt(2) (phi_1 - i phi_2) 1/sqrt(2) (phi_1 + i phi_2) \
  & = partial_mu phi^dagger partial^mu phi - m^2 phi^dagger phi.
$
From this Lagrangian density, we obtain the following Hamiltonian $H$:
$
  H & = integral dd(3, x) cal(H) := integral dd(3, x) (sum_"d.o.f." (partial cal(L))/(partial(partial_t phi)) dot(phi) - cal(L)) = integral dd(3, x) ((partial cal(L))/(partial(partial_t phi)) dot(phi) + (partial cal(L))/(partial(partial_t phi^dagger)) dot(phi)^dagger - cal(L)) \
  & = integral dd(3, x) (dot(phi)^dagger dot(phi) + dot(phi) dot(phi)^dagger - partial_mu phi^dagger partial^mu phi + m^2 phi^dagger phi) \
  & = integral dd(3, x) (dot(phi)^dagger dot(phi) + nabla phi^dagger dot nabla phi + m^2 phi^dagger phi).
$
This expression for the Hamiltonian agrees with eq. (3), if we use the definition of the canonical conjugate momenta, i.e.
$ pi = (partial cal(L))/(partial(partial_t phi)) = dot(phi)^dagger quad "and" quad pi^dagger = (partial cal(L))/(partial(partial_t phi^dagger)) = dot(phi). $
Then we have
$ H = integral dd(3, x) (pi pi^dagger + nabla phi^dagger dot nabla phi + m^2 phi^dagger phi) = integral dd(3, x) (pi^dagger pi + nabla phi^dagger dot nabla phi + m^2 phi^dagger phi). $

#task(label: "b")[
  The mode expansion of the Schrödinger field $phi(arrow(x))$ is
  #tagged(4, $ phi(arrow(x)) = integral (dd(3, p))/(2 pi)^3 1/sqrt(2 E_p) (a(arrow(p)) e^(i arrow(p) dot arrow(x)) + b^dagger (arrow(p)) e^(-i arrow(p) dot arrow(x))), $)
  #tagged(5, $ phi^dagger (arrow(x)) = integral (dd(3, p))/(2 pi)^3 1/sqrt(2 E_p) (b(arrow(p)) e^(i arrow(p) dot arrow(x)) + a^dagger (arrow(p)) e^(-i arrow(p) dot arrow(x))). $)
  Give $a(arrow(p))$ and $b(arrow(p))$ in terms of the two fields $phi_1$ and $phi_2$.
]

$
  phi & = 1/sqrt(2) (phi_1 + i phi_2) = 1/sqrt(2) integral (dd(3, p))/(2 pi)^3 1/sqrt(2 E_p) (a_1 (arrow(p)) e^(i arrow(p) dot arrow(x)) + a_1^dagger (arrow(p)) e^(-i arrow(p) dot arrow(x))) \
  & quad + i/sqrt(2) integral (dd(3, p))/(2 pi)^3 1/sqrt(2 E_p) (a_2 (arrow(p)) e^(i arrow(p) dot arrow(x)) + a_2^dagger (arrow(p)) e^(-i arrow(p) dot arrow(x))) \
  & = integral (dd(3, p))/(2 pi)^3 1/sqrt(2 E_p) (1/sqrt(2) (a_1 (arrow(p)) + i a_2 (arrow(p))) e^(i arrow(p) dot arrow(x)) + 1/sqrt(2) (a_1^dagger (arrow(p)) + i a_2^dagger (arrow(p))) e^(-i arrow(p) dot arrow(x))).
$
Comparing this result to eq. (4), we see
$ a(arrow(p)) = 1/sqrt(2) (a_1 (arrow(p)) + i a_2 (arrow(p))), quad b^dagger (arrow(p)) = 1/sqrt(2) (a_1^dagger (arrow(p)) + i a_2^dagger (arrow(p))). $
Therefore $a^dagger (arrow(p))$ and $b(arrow(p))$ in terms of the modes of $phi_1$ and $phi_2$ are given by
$ a^dagger (arrow(p)) = 1/sqrt(2) (a_1^dagger (arrow(p)) - i a_2^dagger (arrow(p))), quad b(arrow(p)) = 1/sqrt(2) (a_1 (arrow(p)) - i a_2 (arrow(p))). $

#task(label: "c")[Derive the commutation relations for the modes $a(arrow(p))$, $b(arrow(p))$, $a^dagger (arrow(p))$ and $b^dagger (arrow(p))$. Outline how one could set up the Fock space with particles and anti-particles created from the vacuum $|0 chevron.r$ by $a^dagger (arrow(p))$ and $b^dagger (arrow(p))$.]

Writing $a_i = a_i (arrow(p))$ in the first and $a_i = a_i (arrow(q))$ in the second argument of each commutator,
$
  [a(arrow(p)), b(arrow(q))] & = 1/2 ([a_1, a_1] - i [a_1, a_2] + i [a_2, a_1] + [a_2, a_2]) = 0, \
  [a(arrow(p)), b^dagger (arrow(q))] & = 1/2 ([a_1, a_1^dagger] + i [a_1, a_2^dagger] + i [a_2, a_1^dagger] - [a_2, a_2^dagger]) \
  & = 1/2 ((2 pi)^3 delta^((3)) (arrow(p) - arrow(q)) - (2 pi)^3 delta^((3)) (arrow(p) - arrow(q))) = 0, \
  [a(arrow(p)), a^dagger (arrow(q))] & = 1/2 ([a_1, a_1^dagger] - i [a_1, a_2^dagger] + i [a_2, a_1^dagger] + [a_2, a_2^dagger]) \
  & = 1/2 ((2 pi)^3 delta^((3)) (arrow(p) - arrow(q)) + (2 pi)^3 delta^((3)) (arrow(p) - arrow(q))) = (2 pi)^3 delta^((3)) (arrow(p) - arrow(q)), \
  [a^dagger (arrow(p)), b(arrow(q))] & = 1/2 ([a_1^dagger, a_1] - i [a_1^dagger, a_2] - i [a_2^dagger, a_1] - [a_2^dagger, a_2]) \
  & = 1/2 (-(2 pi)^3 delta^((3)) (arrow(p) - arrow(q)) + (2 pi)^3 delta^((3)) (arrow(p) - arrow(q))) = 0, \
  [a^dagger (arrow(p)), b^dagger (arrow(q))] & = 1/2 ([a_1^dagger, a_1^dagger] + i [a_1^dagger, a_2^dagger] - i [a_2^dagger, a_1^dagger] + [a_2^dagger, a_2^dagger]) = 0, \
  [b(arrow(p)), b^dagger (arrow(q))] & = 1/2 ([a_1, a_1^dagger] + i [a_1, a_2^dagger] - i [a_2, a_1^dagger] + [a_2, a_2^dagger]) \
  & = 1/2 ((2 pi)^3 delta^((3)) (arrow(p) - arrow(q)) + (2 pi)^3 delta^((3)) (arrow(p) - arrow(q))) = (2 pi)^3 delta^((3)) (arrow(p) - arrow(q)).
$
To be able to create all Fock space states from the vacuum, we first need to establish its existence. This can be done by looking at the 4-momentum operator
$
  P^mu & = P_1^mu + P_2^mu = integral (dd(3, p))/(2 pi)^3 p^mu a_1^dagger (arrow(p)) a_1 (arrow(p)) + integral (dd(3, p))/(2 pi)^3 p^mu a_2^dagger (arrow(p)) a_2 (arrow(p)) \
  & = integral (dd(3, p))/(2 pi)^3 p^mu 1/2 (a_1^dagger (arrow(p)) a_1 (arrow(p)) + a_2^dagger (arrow(p)) a_2 (arrow(p)) + a_1^dagger (arrow(p)) a_1 (arrow(p)) + a_2^dagger (arrow(p)) a_2 (arrow(p))) \
  & = integral (dd(3, p))/(2 pi)^3 p^mu 1/2 (a_1^dagger (arrow(p)) a_1 (arrow(p)) + i a_1^dagger (arrow(p)) a_2 (arrow(p)) - i a_2^dagger (arrow(p)) a_1 (arrow(p)) + a_2^dagger (arrow(p)) a_2 (arrow(p)) \
    & #h(7em) + a_1^dagger (arrow(p)) a_1 (arrow(p)) - i a_1^dagger (arrow(p)) a_2 (arrow(p)) + i a_2^dagger (arrow(p)) a_1 (arrow(p)) + a_2^dagger (arrow(p)) a_2 (arrow(p))) \
  & = integral (dd(3, p))/(2 pi)^3 p^mu (a^dagger (arrow(p)) a(arrow(p)) + b^dagger (arrow(p)) b(arrow(p))),
$
from which we gather that the Hamiltonian given by $H = P^0$ is non-negative, i.e.
$ chevron.l Psi | H | Psi chevron.r = integral (dd(3, p))/(2 pi)^3 E_p chevron.l Psi | (a^dagger (arrow(p)) a(arrow(p)) + b^dagger (arrow(p)) b(arrow(p))) | Psi chevron.r >= 0 quad forall Psi, $
where we require that $Psi in cal(F)$, meaning $Psi$ must be an element of the Fock space, on which the number operators
$ n_+ (arrow(p)) = a^dagger (arrow(p)) a(arrow(p)) quad "and" quad n_- (arrow(p)) = b^dagger (arrow(p)) b(arrow(p)) $
are positive semi-definite, $chevron.l Psi | a^dagger a | Psi chevron.r = ||a |Psi chevron.r||^2 >= 0$. From $chevron.l Psi | H | Psi chevron.r >= 0 med forall Psi in cal(F)$, we can deduce that there exists a state that fulfills
$ a(arrow(p)) |0 chevron.r = 0 quad forall arrow(p). $
Otherwise, successive action of $a(arrow(p))$ on any state $|Psi chevron.r$ would lead to negative eigenvalues since
$ P^mu a(arrow(p)) |k chevron.r = a(arrow(p)) P^mu |k chevron.r - p^mu a(arrow(p)) |k chevron.r = a(arrow(p)) k^mu |k chevron.r - p^mu a(arrow(p)) |k chevron.r = (k^mu - p^mu) a(arrow(p)) |k chevron.r, $
i.e. $a(arrow(p))$ subtracts 4-momentum $p^mu$ from any 4-momentum operator eigenstate $|k chevron.r$ (where we used $[P^mu, a(arrow(p))] = -p^mu a(arrow(p))$). Since Fock space states with negative energies were ruled out above, we can infer the existence of such a vacuum. This vacuum we can use to set up the entire Fock space of #box[$n$-particle] states via employment of particle and antiparticle creation operators $a^dagger (arrow(p))$ and $b^dagger (arrow(p))$:
$ |p_1, p_2, dots, p_n, q_1, q_2, dots, q_r chevron.r = product_(i = 1)^n sqrt(2 E_(p_i)) a^dagger (p_i) product_(j = 1)^r sqrt(2 E_(q_j)) b^dagger (q_j) |0 chevron.r. $

= Problem 4.1 (Expression for $a(arrow(p))$ in terms of fields)

#task[
  Show that the creation and annihilation operators in a real scalar theory can be written in terms of the Heisenberg fields as
  #tagged(1, $ a^dagger (arrow(p)) = -i/sqrt(2 E_p) integral dd(3, x) e^(-i p x) accent(partial, arrow.l.r)_0 phi(x), quad a(arrow(p)) = i/sqrt(2 E_p) integral dd(3, x) e^(i p x) accent(partial, arrow.l.r)_0 phi(x), $)
  where in $x := (x^0, arrow(x))$ we can pick $x^0$ arbitrarily and $u accent(partial, arrow.l.r)_0 v = u partial_0 v - v partial_0 u$.
]

Written in a mode expansion, the Heisenberg field $phi^((H)) (t, arrow(x))$ is defined as
$ phi^((H)) (t, arrow(x)) := phi(x) = integral (dd(3, p))/(2 pi)^3 1/sqrt(2 E_p) (a(arrow(p)) e^(-i p x) + a^dagger (arrow(p)) e^(i p x)), $
its time derivative is
$ dot(phi)^((H)) (t, arrow(x)) := dot(phi)(x) = i integral (dd(3, p))/(2 pi)^3 sqrt(E_p / 2) (a^dagger (arrow(p)) e^(i p x) - a(arrow(p)) e^(-i p x)). $
Plugging these expressions into the field expansions of the modes gives
$
  a^dagger (arrow(q)) & = -i/sqrt(2 E_q) integral dd(3, x) (e^(-i q x) i integral (dd(3, p))/(2 pi)^3 sqrt(E_p / 2) (a^dagger (arrow(p)) e^(i p x) - a(arrow(p)) e^(-i p x)) \
    & #h(6em) - integral (dd(3, p))/(2 pi)^3 1/sqrt(2 E_p) (a(arrow(p)) e^(-i p x) + a^dagger (arrow(p)) e^(i p x)) (-i E_q) e^(-i q x)) \
  & = 1/sqrt(2 E_q) integral (dd(3, p))/(2 pi)^3 integral dd(3, x) (sqrt(E_p / 2) (a^dagger (arrow(p)) e^(i (p - q) x) - a(arrow(p)) e^(-i (p + q) x)) + E_q/sqrt(2 E_p) (a(arrow(p)) e^(-i (p + q) x) + a^dagger (arrow(p)) e^(i (p - q) x))) \
  & = 1/sqrt(2 E_q) (sqrt(E_q / 2) (a^dagger (arrow(q)) - a(-arrow(q))) + E_q/sqrt(2 E_q) (a(-arrow(q)) + a^dagger (arrow(q)))) = 1/2 (a^dagger (arrow(q)) - a(-arrow(q)) + a(-arrow(q)) + a^dagger (arrow(q))) = a^dagger (arrow(q)).
$
The proof for $a(arrow(q))$ follows analogously.

= Problem 6.2 (Representation of Lie algebras)

#task[
  An element of a Lie group that is close to the identity can be written as
  #tagged(2, $ g(alpha) = bb(1) + i alpha^a T^a + cal(O)(alpha^2). $)
  The hermitian operators $T^a$ are generators of the Lie algebra. They have the commutation relation
  #tagged(3, $ [T^a, T^b] = i f^(a b c) T^c, $)
  with $f^(a b c)$ the structure constants. The vector space spanned by the generators with the additional Lie bracket structure in eq. (3) is called a Lie algebra.
]

#task(label: "a")[
  Prove the identity
  #tagged(4, $ [T^a, [T^b, T^c]] + [T^b, [T^c, T^a]] + [T^c, [T^a, T^b]] = 0 $)
  and show that this implies
  #tagged(5, $ f^(a d e) f^(b c d) + f^(b d e) f^(c a d) + f^(c d e) f^(a b d) = 0. $)
]

Matching colors mark the pairs of terms that cancel:
#let hl(i, body) = text(fill: (rgb("#c0392b"), rgb("#2471a3"), rgb("#1e8449"), rgb("#b9770e"), rgb("#7d3c98"), rgb("#148f77")).at(i), body)
$
  & [T^a, [T^b, T^c]] + [T^b, [T^c, T^a]] + [T^c, [T^a, T^b]] = #hl(0, $T^a T^b T^c$) - #hl(1, $T^b T^c T^a$) - #hl(2, $T^a T^c T^b$) + #hl(3, $T^c T^b T^a$) \
  & #h(2em) + #hl(1, $T^b T^c T^a$) - #hl(4, $T^c T^a T^b$) - #hl(5, $T^b T^a T^c$) + #hl(2, $T^a T^c T^b$) + #hl(4, $T^c T^a T^b$) - #hl(0, $T^a T^b T^c$) - #hl(3, $T^c T^b T^a$) + #hl(5, $T^b T^a T^c$) = 0.
$
Using eq. (3) twice,
$
  & [T^a, [T^b, T^c]] + [T^b, [T^c, T^a]] + [T^c, [T^a, T^b]] = i (f^(b c d) [T^a, T^d] + f^(c a d) [T^b, T^d] + f^(a b d) [T^c, T^d]) \
  & = i^2 (f^(a d e) f^(b c d) T^e + f^(b d e) f^(c a d) T^e + f^(c d e) f^(a b d) T^e) = -(f^(a d e) f^(b c d) + f^(b d e) f^(c a d) + f^(c d e) f^(a b d)) T^e attach(=, t: !) 0 \
  & ==> f^(a d e) f^(b c d) + f^(b d e) f^(c a d) + f^(c d e) f^(a b d) = 0.
$

#task(label: "b")[What is a representation $t^a$ of a Lie algebra?]

An $n$-dimensional representation $R$ of a group $G$ is a homomorphism (not necessarily invertible)
$ R: G --> "GL"(V), quad R(x) = f, $
where $x in G$ and $f: V -> V$ is an invertible linear map on some $n$-dimensional vector space $V$. Being a homomorphism, $R$ is compatible with the group multiplication of $G$, meaning for $x, y in G$
$ R(x) compose R(y) = R(x y), quad R(x^(-1)) = R^(-1) (x). $
Correspondingly, a representation of a Lie algebra is a linear map $T^a |-> t^a in "End"(V)$ that preserves the Lie bracket, i.e. a set of $n times n$ matrices $t^a$ obeying the same commutation relations $[t^a, t^b] = i f^(a b c) t^c$ as the generators in eq. (3).

#task(label: "c")[
  Assume that the generators in some representation $r$ are normalized according to
  #tagged(6, $ tr(t_r^a t_r^b) = C(r) delta^(a b). $)
  Show that this yields the following representation of the structure constants $f^(a b c) = -i/C(r) tr([t_r^a, t_r^b] t_r^c)$ and that $f^(a b c)$ is totally antisymmetric.
]

A general relation that holds true for the generators of any Lie algebra was given in eq. (3). Together with the normalization in eq. (6), this gives
$ -i/C(r) tr([t_r^a, t_r^b] t_r^c) = -i/C(r) tr(i f^(a b d) t_r^d t_r^c) = -(i^2 f^(a b d))/C(r) tr(t_r^d t_r^c) = f^(a b d)/C(r) C(r) delta^(d c) = f^(a b c). $
Using the invariance of the trace under cyclic permutations, we can show that $f^(a b c)$ is antisymmetric:
$
  f^(a b c) & = underbrace(-i/C(r) tr([t_r^a, t_r^b] t_r^c), -f^(b a c)) = underbrace(-i/C(r) tr([t_r^b, t_r^c] t_r^a), f^(b c a)) = -i/C(r) tr(-[t_r^c, t_r^b] t_r^a) = -f^(c b a) \
  & = underbrace(-i/C(r) tr([t_r^c, t_r^a] t_r^b), f^(c a b)) = -i/C(r) tr(-[t_r^a, t_r^c] t_r^b) = -f^(a c b).
$

#task(label: "d")[Similarly, show that the matrices $(t_G^b)_(a c) = i f^(a b c)$ define a representation (the adjoint representation).]

To prove this we make use of the Jacobi identity and the total antisymmetry of the structure constants:
$
  0 & = f^(a d e) f^(b c d) + f^(b d e) f^(c a d) + f^(c d e) f^(a b d) = (-1)^2 f^(c b d) f^(d a e) - f^(c a d) f^(d b e) + f^(a b d) f^(c d e) \
  & = -(t_G^b)_(c d) (t_G^a)_(d e) + (t_G^a)_(c d) (t_G^b)_(d e) - i f^(a b d) (t_G^d)_(c e) \
  & attach(=, t: c <-> d) (t_G^a)_(d c) (t_G^b)_(c e) - (t_G^b)_(d c) (t_G^a)_(c e) - i f^(a b c) (t_G^c)_(d e) \
  & = ([t_G^a, t_G^b])_(d e) - i f^(a b c) (t_G^c)_(d e) quad ==> quad [t_G^a, t_G^b] = i f^(a b c) t_G^c.
$

= Problem 7.2 (Feynman rules in $phi^3$-theory)

#task(label: "a")[Give the Feynman rules for the propagator, the vertex and the external points in position space and derive from these the Feynman rules in momentum space for the $lambda phi^3$-theory, i.e. $cal(L)_"int" = -lambda/3! phi^3$.]

Feynman rules in position space for
- the propagator: $D_F^((0)) (x - y)$,
- the vertex: $-i lambda integral dd(4, z_i)$,
- external point: $1$.

#let fd(body) = box(baseline: 50%, canvas(length: 1cm, {
  import draw: *
  set-style(stroke: 0.7pt)
  body
}))
#let dotv(pt, r: 0.05) = draw.circle(pt, radius: r, fill: black, stroke: none)

#grid(
  columns: (1fr, auto),
  column-gutter: 1em,
  align: horizon,
  [To obtain the corresponding Feynman rules in momentum space, we compile an expression for a vertex in $lambda phi^3$-theory according to the Feynman rules in position space and then perform the integral over the internal point explicitly. This procedure should not be mistaken for the Fourier transformation of the correlator. Rather it exemplifies the derivation of an equivalent set of rules to the Feynman rules in position space that rely more heavily on writing down expressions based on and calculating integrals over momenta:],
  canvas(length: 1.15cm, {
    import draw: *
    set-style(stroke: (thickness: 0.7pt, dash: "dashed"))
    let z = (0, 0)
    let (x1, x2, x3) = ((-1.5, 1.4), (-1.5, -1.4), (2.4, 0))
    line(x1, z)
    line(x2, z)
    line(x3, z)
    dotv(x1, r: 0.07)
    dotv(x2, r: 0.07)
    dotv(x3, r: 0.07)
    content(x1, $x_1$, anchor: "east", padding: 0.15)
    content(x2, $x_2$, anchor: "east", padding: 0.15)
    content(x3, $x_3$, anchor: "west", padding: 0.15)
    content(x1, text(8pt)[$1$], anchor: "south", padding: 0.12)
    content(x2, text(8pt)[$1$], anchor: "south", padding: 0.12)
    content(x3, text(8pt)[$1$], anchor: "south", padding: 0.12)
    content((-0.75, 0.7), text(8pt)[$D_F^((0)) (x_1 - z)$], anchor: "south-west", padding: 0.08)
    content((-0.75, -0.7), text(8pt)[$D_F^((0)) (x_2 - z)$], anchor: "north-west", padding: 0.08)
    content((1.3, -0.12), text(8pt)[$D_F^((0)) (x_3 - z)$], anchor: "north")
    content((0.25, 0.12), text(8pt)[$-i lambda integral dd(4, z)$], anchor: "south-west")
    content(z, text(8pt)[$z$], anchor: "east", padding: 0.12)
  }),
)

#let ydiag = fd({
  draw.line((-0.3, 0.22), (0, 0))
  draw.line((-0.3, -0.22), (0, 0))
  draw.line((0, 0), (0.35, 0))
})
$
  ydiag & = -i lambda integral dd(4, z) 1^3 D_F^((0)) (x_1 - z) D_F^((0)) (x_2 - z) D_F^((0)) (x_3 - z) \
  & = -i lambda integral dd(4, z) integral (dd(4, p_1))/(2 pi)^4 (i e^(-i p_1 (x_1 - z)))/(p_1^2 - m_0^2 + i epsilon) integral (dd(4, p_2))/(2 pi)^4 (i e^(-i p_2 (x_2 - z)))/(p_2^2 - m_0^2 + i epsilon) integral (dd(4, p_3))/(2 pi)^4 (i e^(-i p_3 (x_3 - z)))/(p_3^2 - m_0^2 + i epsilon) \
  & = -i lambda integral (dd(4, p_1))/(2 pi)^4 integral (dd(4, p_2))/(2 pi)^4 integral (dd(4, p_3))/(2 pi)^4 i/(p_1^2 - m_0^2 + i epsilon) i/(p_2^2 - m_0^2 + i epsilon) i/(p_3^2 - m_0^2 + i epsilon) \
  & #h(4em) times e^(-i p_1 x_1) e^(-i p_2 x_2) e^(-i p_3 x_3) underbrace(integral dd(4, z) e^(i (p_1 + p_2 + p_3) z), (2 pi)^4 delta^((4)) (p_1 + p_2 + p_3)).
$
From the above, we can deduce the Feynman rules in momentum space:
- To each line between two points, associate a factor $display(i/(p^2 - m_0^2 + i epsilon))$.
- To each vertex, associate a factor $-i lambda (2 pi)^4 delta^((4)) (sum p_"in" - sum p_"out")$.
- To each external point, multiply a factor of $e^(-i p x)$ for outgoing, $e^(i p x)$ for ingoing momenta at that point.
- Integrate over all appearing momenta $integral (dd(4, p_i))/(2 pi)^4$.

#task(label: "b")[Calculate the symmetry factors for the following diagrams:]

#let ext(a, b) = {
  draw.line(a, b)
  dotv(a)
  dotv(b)
}
#align(center, grid(
  columns: 3,
  column-gutter: 3.5em,
  row-gutter: 0.6em,
  align: (x, y) => if y == 0 { left } else { center + horizon },
  [1)], [2)], [3)],
  fd({
      import draw: *
      circle((0, 0), radius: 0.5)
      ext((-1.3, 0), (-0.5, 0))
      ext((0.5, 0), (1.3, 0))
  }),
  fd({
      import draw: *
      circle((0, 0), radius: 0.5)
      ext((-1.3, 0), (-0.5, 0))
      ext((0.5, 0), (1.3, 0))
      line((0, 0.5), (0, 0.85))
      circle((0, 1.25), radius: 0.4)
      dotv((0, 0.5))
      dotv((0, 0.85))
      line((0, -0.5), (0, -0.85))
      circle((0, -1.25), radius: 0.4)
      dotv((0, -0.5))
      dotv((0, -0.85))
  }),
  fd({
      import draw: *
      circle((0, 0), radius: 0.5)
      ext((-1.3, 0), (-0.5, 0))
      ext((0.5, 0), (1.3, 0))
      for ang in (90deg, 225deg, 315deg) {
        line((0, 0), (0.5 * calc.cos(ang), 0.5 * calc.sin(ang)))
        dotv((0.5 * calc.cos(ang), 0.5 * calc.sin(ang)))
      }
      dotv((0, 0))
  }),
  $S = 2$, $S = 8$, $S = 1$,
))

= Problem 9.1 (Spin sums and projection operator in momentum space)

#task[
  The four-momentum $p$ satisfies $p^2 = m^2$. Let
  #tagged(1, $ Lambda_plus.minus = 1/(2 m) (m plus.minus gamma dot p). $)
  Using the result $(gamma dot p)^2 = m^2$, show that $Lambda_plus.minus Psi$ is an eigenspinor of $gamma dot p$ with eigenvalues $plus.minus m$. Show further that $Lambda_+ + Lambda_- = 1$, $Lambda_+ Lambda_- = Lambda_- Lambda_+ = 0$, and $Lambda_plus.minus^2 = Lambda_plus.minus$. Find vectors $u_r$, $v_r$, $r in {1, 2}$, such that
  $
    (gamma dot p - m) u_r = 0, quad (gamma dot p + m) v_r = 0, quad r in {1, 2}, \
    overline(u)_r u_s = -overline(v)_r v_s = 2 m delta_(r s), quad overline(u)_r v_s = 0, quad r, s in {1, 2}.
  $
  Deduce that
  #tagged(2, $ Lambda_+ = sum_(r = 1)^2 1/(2 m) u_r overline(u)_r, quad Lambda_- = -sum_(r = 1)^2 1/(2 m) v_r overline(v)_r. $)
]

First we show that $Lambda_plus.minus Psi$ are eigenspinors of the operator $gamma dot p$:
$
  gamma dot p Lambda_plus.minus Psi & = gamma dot p 1/(2 m) (m plus.minus gamma dot p) Psi = 1/(2 m) (m gamma dot p plus.minus (gamma dot p)^2) Psi = 1/(2 m) (m gamma dot p plus.minus m^2) Psi \
  & = plus.minus m 1/(2 m) (m plus.minus gamma dot p) Psi = plus.minus m Lambda_plus.minus Psi.
$
Now we demonstrate that $Lambda_plus.minus$ are projectors:
$
  Lambda_+ + Lambda_- & = 1/(2 m) (m + gamma dot p) + 1/(2 m) (m - gamma dot p) = 1/(2 m) (m + gamma dot p + m - gamma dot p) = 1, \
  Lambda_+ Lambda_- & = 1/(2 m) (m + gamma dot p) 1/(2 m) (m - gamma dot p) = 1/(4 m^2) (m^2 - (gamma dot p)^2) = 0 = Lambda_- Lambda_+, \
  Lambda_plus.minus^2 & = 1/(4 m^2) (m plus.minus gamma dot p)^2 = 1/(4 m^2) (m^2 plus.minus 2 m gamma dot p + (gamma dot p)^2) = 1/(4 m^2) (2 m^2 plus.minus 2 m gamma dot p) = 1/(2 m) (m plus.minus gamma dot p) = Lambda_plus.minus.
$
We move on to finding vectors $u_r$, $v_r$, $r in {1, 2}$, that meet the specified requirements. Note therefore that the product $gamma dot p$ can be written as
$ gamma dot p = gamma_mu p^mu = mat(0, sigma_mu p^mu; sigma^mu p^mu, 0), quad "where" sigma_0 = bb(1)_2 "and" sigma_i, i in {1, 2, 3}, "the Pauli matrices". $
Then
$
  & (gamma dot p - m) u_r = mat(-m bb(1)_2, sigma_mu p^mu; sigma^mu p^mu, -m bb(1)_2) vec(u_(r, 1), u_(r, 2)) = vec(-m u_(r, 1) + sigma_mu p^mu u_(r, 2), sigma^mu p^mu u_(r, 1) - m u_(r, 2)) attach(=, t: !) vec(0, 0) \
  & ==> u_(r, 1) = 1/m sigma_mu p^mu u_(r, 2), quad u_(r, 2) = 1/m sigma^mu p^mu u_(r, 1) = 1/m^2 sigma^mu p^mu sigma_nu p^nu u_(r, 2) = p^2/m^2 u_(r, 2) quad checkmark,
$
where we assumed that $u_(r, i)$ is a two-column vector (or $2 times 2$-matrix) to make the contraction $bb(1)_2 u_(r, i) = u_(r, i)$. The same will be done for $v_r$:
$
  & (gamma dot p + m) v_r = mat(m bb(1)_2, sigma_mu p^mu; sigma^mu p^mu, m bb(1)_2) vec(v_(r, 1), v_(r, 2)) = vec(m v_(r, 1) + sigma_mu p^mu v_(r, 2), sigma^mu p^mu v_(r, 1) + m v_(r, 2)) attach(=, t: !) vec(0, 0) \
  & ==> v_(r, 1) = -1/m sigma_mu p^mu v_(r, 2), quad v_(r, 2) = -1/m sigma^mu p^mu v_(r, 1) = (-1)^2/m^2 sigma^mu p^mu sigma_nu p^nu v_(r, 2) = p^2/m^2 v_(r, 2) quad checkmark.
$
To show that both equations for $u_r$ and $v_r$ are consistent we used
$
  sigma^mu p^mu sigma_nu p^nu & = sigma^0 p^0 sigma^0 p^0 - sigma^i p^i sigma^j p^j = (p^0 bb(1)_2)^2 - p^i p^j sigma^i sigma^j = (p^0)^2 bb(1)_2 - p^i p^j delta_(i j) bb(1)_2 \
  & = (p^0)^2 bb(1)_2 - arrow(p)^2 bb(1)_2 = p^2 bb(1)_2 = m^2 bb(1)_2.
$
So far, we found $u_r$ and $v_r$ to be
$ u_r = vec(u_(r, 1), u_(r, 2)) = vec(1/m sigma_mu p^mu u_(r, 2), u_(r, 2)), quad v_r = vec(v_(r, 1), v_(r, 2)) = vec(-1/m sigma_mu p^mu v_(r, 2), v_(r, 2)). $
One can then make the conventional choice to set $u_(r, 2) = sqrt(p_mu sigma_mu) xi_r = v_(r, 2)$:
$ 1/m sigma_mu p^mu u_(r, 2) = 1/m sqrt(sigma_mu p^mu) sqrt(sigma_mu p^mu) sqrt(p_mu sigma_mu) xi_r = 1/m sqrt(sigma_mu p^mu) sqrt(underbrace(sigma_mu p^mu p_nu sigma_nu, m^2)) xi_r = sqrt(sigma_mu p^mu) xi_r. $
Therefore
$ u_r = vec(sqrt(sigma_mu p^mu) xi_r, sqrt(sigma_mu p_mu) xi_r), quad v_r = vec(-sqrt(sigma_mu p^mu) xi_r, sqrt(sigma_mu p_mu) xi_r). $
We now introduce a basis of the space of two-spinors by $xi_s$ with
$ xi_(1\/2) = vec(1, 0), quad xi_(-1\/2) = vec(0, 1), quad "such that" quad xi_r^dagger xi_s = delta_(r s). $
We then have
$
  overline(u)_r u_s & = u_r^dagger gamma^0 u_s = u_(r, 1)^dagger u_(s, 2) + u_(r, 2)^dagger u_(s, 1) = sqrt(sigma_mu p^mu sigma_nu p_nu) xi_r^dagger xi_s + sqrt(sigma_mu p_mu sigma_nu p^nu) xi_r^dagger xi_s \
  & = 2 m delta_(r s) = -overline(v)_r v_s,
$
$
  sum_(r = 1)^2 u_r overline(u)_r & = sum_(r = 1)^2 u_r u_r^dagger gamma^0 = sum_(r = 1)^2 vec(u_(r, 1), u_(r, 2)) (u_(r, 2)^dagger, u_(r, 1)^dagger) = sum_(r = 1)^2 mat(u_(r, 1) u_(r, 2)^dagger, u_(r, 1) u_(r, 1)^dagger; u_(r, 2) u_(r, 2)^dagger, u_(r, 2) u_(r, 1)^dagger) \
  & = sum_(r = 1)^2 mat(sqrt(sigma_mu p^mu) xi_r (sqrt(sigma_mu p_mu) xi_r)^dagger, sqrt(sigma_mu p^mu) xi_r (sqrt(sigma_mu p^mu) xi_r)^dagger; sqrt(sigma_mu p_mu) xi_r (sqrt(sigma_mu p_mu) xi_r)^dagger, sqrt(sigma_mu p_mu) xi_r (sqrt(sigma_mu p^mu) xi_r)^dagger) \
  & = sum_(r = 1)^2 mat(sqrt(sigma_mu p^mu sigma_nu p_nu) xi_r xi_r^dagger, sigma_mu p^mu xi_r xi_r^dagger; sigma_mu p_mu xi_r xi_r^dagger, sqrt(sigma_mu p_mu sigma_nu p^nu) xi_r xi_r^dagger) = mat(m bb(1)_2, sigma_mu p^mu; sigma_mu p_mu, m bb(1)_2) = gamma dot p + m.
$
The analogous calculation gives $sum_(r = 1)^2 v_r overline(v)_r = gamma dot p - m$, i.e. the sign of the mass term flips. Therefore
$ Lambda_+ = sum_(r = 1)^2 1/(2 m) u_r overline(u)_r = 1/(2 m) (gamma dot p + m), quad Lambda_- = -sum_(r = 1)^2 1/(2 m) v_r overline(v)_r = -1/(2 m) (gamma dot p - m). $

= Problem 9.2 (Gamma matrices and $"SO"(1, 3)$)

#task[
  The Clifford algebra for $gamma$-matrices is described by the anticommutation relations
  #tagged(3, $ {gamma^mu, gamma^nu} = 2 eta^(mu nu) bb(1)_4. $)
]

#task(label: "a")[Show that $[gamma^kappa gamma^lambda, gamma^mu gamma^nu] = 2 eta^(lambda mu) gamma^kappa gamma^nu - 2 eta^(kappa mu) gamma^lambda gamma^nu + 2 eta^(lambda nu) gamma^mu gamma^kappa - 2 eta^(kappa nu) gamma^mu gamma^lambda$.]

$
  [gamma^kappa gamma^lambda, gamma^mu gamma^nu] & = [gamma^kappa gamma^lambda, gamma^mu] gamma^nu + gamma^mu [gamma^kappa gamma^lambda, gamma^nu] = gamma^kappa [gamma^lambda, gamma^mu] gamma^nu + [gamma^kappa, gamma^mu] gamma^lambda gamma^nu \
  & quad + gamma^mu gamma^kappa [gamma^lambda, gamma^nu] + gamma^mu [gamma^kappa, gamma^nu] gamma^lambda \
  & = gamma^kappa gamma^lambda gamma^mu gamma^nu - gamma^kappa gamma^mu gamma^lambda gamma^nu + gamma^kappa gamma^mu gamma^lambda gamma^nu - gamma^mu gamma^kappa gamma^lambda gamma^nu \
  & quad + gamma^mu gamma^kappa gamma^lambda gamma^nu - gamma^mu gamma^kappa gamma^nu gamma^lambda + gamma^mu gamma^kappa gamma^nu gamma^lambda - gamma^mu gamma^nu gamma^kappa gamma^lambda \
  & = gamma^kappa {gamma^lambda, gamma^mu} gamma^nu - {gamma^kappa, gamma^mu} gamma^lambda gamma^nu + gamma^mu gamma^kappa {gamma^lambda, gamma^nu} - gamma^mu {gamma^kappa, gamma^nu} gamma^lambda \
  & = gamma^kappa 2 eta^(lambda mu) bb(1)_4 gamma^nu - 2 eta^(kappa mu) gamma^lambda gamma^nu + gamma^mu gamma^kappa 2 eta^(lambda nu) bb(1)_4 - gamma^mu 2 eta^(kappa nu) bb(1)_4 gamma^lambda \
  & = 2 eta^(lambda mu) gamma^kappa gamma^nu - 2 eta^(kappa mu) gamma^lambda gamma^nu + 2 eta^(lambda nu) gamma^mu gamma^kappa - 2 eta^(kappa nu) gamma^mu gamma^lambda.
$

#task(label: "b")[By expressing $S^(kappa lambda) = 1/4 [gamma^kappa, gamma^lambda]$ as $1/2 (gamma^kappa gamma^lambda - eta^(kappa lambda))$, etc., evaluate $[S^(kappa lambda), S^(mu nu)]$.]

$ S^(kappa lambda) = 1/4 [gamma^kappa, gamma^lambda] = 1/4 (gamma^kappa gamma^lambda - gamma^lambda gamma^kappa) = 1/4 (gamma^kappa gamma^lambda - (-gamma^kappa gamma^lambda + 2 eta^(kappa lambda) bb(1)_4)) = 1/2 (gamma^kappa gamma^lambda - eta^(kappa lambda) bb(1)_4), $
$
  [S^(kappa lambda), S^(mu nu)] & = 1/4 [gamma^kappa gamma^lambda - eta^(kappa lambda) bb(1)_4, gamma^mu gamma^nu - eta^(mu nu) bb(1)_4] \
  & = 1/4 ([gamma^kappa gamma^lambda, gamma^mu gamma^nu] - underbrace([gamma^kappa gamma^lambda, eta^(mu nu) bb(1)_4], 0) - underbrace([eta^(kappa lambda) bb(1)_4, gamma^mu gamma^nu], 0) + underbrace([eta^(kappa lambda) bb(1)_4, eta^(mu nu) bb(1)_4], 0)) \
  & = 1/4 (2 eta^(lambda mu) gamma^kappa gamma^nu - 2 eta^(kappa mu) gamma^lambda gamma^nu + 2 eta^(lambda nu) gamma^mu gamma^kappa - 2 eta^(kappa nu) gamma^mu gamma^lambda) \
  & = 1/2 (eta^(lambda mu) gamma^kappa gamma^nu - eta^(lambda mu) eta^(kappa nu) + #hl(0, $eta^(lambda mu) eta^(kappa nu)$) - eta^(kappa mu) gamma^lambda gamma^nu + eta^(kappa mu) eta^(lambda nu) - #hl(1, $eta^(kappa mu) eta^(lambda nu)$) \
    & #h(3em) + eta^(lambda nu) gamma^mu gamma^kappa - eta^(lambda nu) eta^(mu kappa) + #hl(1, $eta^(lambda nu) eta^(mu kappa)$) - eta^(kappa nu) gamma^mu gamma^lambda + eta^(kappa nu) eta^(mu lambda) - #hl(0, $eta^(kappa nu) eta^(mu lambda)$)) \
  & = eta^(lambda mu) S^(kappa nu) - eta^(kappa mu) S^(lambda nu) + eta^(lambda nu) S^(mu kappa) - eta^(kappa nu) S^(mu lambda),
$
where the colored terms cancel pairwise.

#task(label: "c")[Show that, if $S^i = i/4 epsilon_(i j k) gamma^j gamma^k$, then $[S^i, S^j] = i epsilon_(i j k) S^k$.]

$ S^i = i/4 epsilon_(i j k) gamma^j gamma^k = i/8 epsilon_(i j k) (gamma^j gamma^k - gamma^k gamma^j) = i/8 epsilon_(i j k) [gamma^j, gamma^k] = i/2 epsilon_(i j k) S^(j k) $
$
  ==> i epsilon_(i j k) S^k & = i epsilon_(i j k) i/2 epsilon_(k l m) S^(l m) = -1/2 epsilon_(k i j) epsilon_(k l m) S^(l m) = -1/2 (delta_(i l) delta_(j m) - delta_(i m) delta_(j l)) S^(l m) \
  & = -1/2 (delta_(i l) delta_(j m) S^(l m) - delta_(i m) delta_(j l) S^(l m)) = -1/2 (S^(i j) - S^(j i)) = -1/2 (S^(i j) + S^(i j)) = -S^(i j).
$
$ [S^i, S^j] = -1/4 epsilon_(i k l) epsilon_(j m n) [S^(k l), S^(m n)] = -1/4 epsilon_(i k l) epsilon_(j m n) (-delta_(l m) S^(k n) + delta_(k m) S^(l n) - delta_(l n) S^(m k) + delta_(k n) S^(m l)). $
In the above expression, the indices $k$, $l$, $m$ and $n$ are summed over. Hence, they can be freely relabelled:
$
  [S^i, S^j] & = 1/4 epsilon_(i k l) epsilon_(j m n) (delta_(l m) S^(k n) + delta_(k m) S^(n l) + delta_(l n) S^(m k) + delta_(k n) S^(l m)) \
  & = epsilon_(i k l) epsilon_(j m n) delta_(l m) S^(k n) = epsilon_(i k m) epsilon_(j m n) S^(k n) = epsilon_(m i k) epsilon_(m n j) S^(k n) \
  & = (delta_(i n) delta_(k j) - delta_(i j) delta_(k n)) S^(k n) = S^(j i) - delta_(i j) S^(n n) = S^(j i) = -S^(i j) = i epsilon_(i j k) S^k.
$

#task(label: "d")[Show also that $[gamma^0, S^i] = [gamma^5, S^i] = 0$, where $gamma^5 = i gamma^0 gamma^1 gamma^2 gamma^3$.]

$
  [gamma^0, S^i] & = i/4 epsilon_(i j k) [gamma^0, gamma^j gamma^k] = 0, \
  [gamma^5, S^i] & = i^2/4 epsilon_(i j k) (gamma^0 gamma^1 gamma^2 gamma^3 gamma^j gamma^k - gamma^j gamma^k gamma^0 gamma^1 gamma^2 gamma^3) = i^2/4 epsilon_(i j k) (gamma^j gamma^k gamma^0 gamma^1 gamma^2 gamma^3 - gamma^j gamma^k gamma^0 gamma^1 gamma^2 gamma^3) = 0.
$

#task(label: "e")[Now show that $(S^1)^2 = (S^2)^2 = (S^3)^2 = 1/4$.]

$
  (S^1)^2 & = (i/4 epsilon_(1 j k) gamma^j gamma^k)^2 = -1/16 (gamma^2 gamma^3 - gamma^3 gamma^2)^2 = -1/16 (2 dot underbrace(1/2 [gamma^2, gamma^3], gamma^2 gamma^3 - eta^(2 3)))^2 = -1/4 (gamma^2 gamma^3)^2 \
  & = -1/4 gamma^2 gamma^3 gamma^2 gamma^3 = -1/4 gamma^2 (-gamma^2 gamma^3 + underbrace(2 eta^(3 2), 0)) gamma^3 = 1/4 gamma^2 gamma^2 gamma^3 gamma^3 = 1/4 (-bb(1)_4)(-bb(1)_4) = 1/4 bb(1)_4.
$
$(S^2)^2 = (S^3)^2 = 1/4 bb(1)_4$ can be shown analogously.

#task(label: "f")[
  Verify these results for the particular representation
  $ gamma^0 = mat(bb(1)_2, 0; 0, -bb(1)_2), quad gamma^i = mat(0, sigma^i; -sigma^i, 0) quad "and show" quad S^i = 1/2 mat(sigma^i, 0; 0, sigma^i), quad gamma^5 = mat(0, bb(1)_2; bb(1)_2, 0) $
  in this representation. What can you deduce about rotations and spin in the Dirac field theory?
]

To show the explicit form of $S^i$, we first take a look at the Pauli matrices. They obey both powerful commutation and anticommutation relations:
$ [sigma^i, sigma^j] = 2 i epsilon_(i j k) sigma^k, quad {sigma^i, sigma^j} = sigma^i sigma^j + sigma^j sigma^i = 2 delta^(i j) bb(1)_2. $
From adding a term $sigma^i sigma^j$ to the anticommutator, we see that
$
  2 sigma^i sigma^j & = sigma^i sigma^j - sigma^j sigma^i + 2 delta^(i j) bb(1)_2 = 2 i epsilon_(i j k) sigma^k + 2 delta^(i j) bb(1)_2, \
  epsilon_(i j k) sigma^j sigma^k & = i underbrace(epsilon_(i j k) epsilon_(j k l), 2 delta_(i l)) sigma^l + underbrace(epsilon_(i j k) delta^(j k), 0) bb(1)_2 = 2 i sigma^i.
$
With the above relation, it is easy:
$
  S^i & = i/4 epsilon_(i j k) gamma^j gamma^k = i/4 epsilon_(i j k) mat(0, sigma_j; -sigma_j, 0) mat(0, sigma_k; -sigma_k, 0) = i/4 epsilon_(i j k) mat(-sigma_j sigma_k, 0; 0, -sigma_j sigma_k) = i/4 (-2 i) mat(sigma^i, 0; 0, sigma^i) = 1/2 mat(sigma^i, 0; 0, sigma^i), \
  gamma^5 & = i gamma^0 gamma^1 gamma^2 gamma^3 = i gamma^0 gamma^1 mat(-sigma_2 sigma_3, 0; 0, -sigma_2 sigma_3) = i gamma^0 mat(0, -sigma_1 sigma_2 sigma_3; sigma_1 sigma_2 sigma_3, 0) = i mat(0, -sigma_1 sigma_2 sigma_3; -sigma_1 sigma_2 sigma_3, 0) = mat(0, bb(1)_2; bb(1)_2, 0),
$
where we used in the last step that $sigma_1 sigma_2 = i sigma_3$ and $sigma_3^2 = bb(1)_2$, i.e. $-i sigma_1 sigma_2 sigma_3 = bb(1)_2$. Since $S^(kappa lambda)$ satisfies the Lorentz algebra, we showed that the $S^i$ are a subalgebra of $"so"(1, 3)$. The explicit form of $S^i$ is block diagonal, where each block alone satisfies the $"su"(2)$ algebra. Since the blocks are 2-dimensional, the $S^i$ form a $1/2 plus.o 1/2$ representation.

= Problem 9.4 (Global symmetries of the free Dirac action)

#task(label: "a")[
  Under global translations $x -> x + epsilon$ the Dirac spinor field transforms as
  #tagged(7, $ Psi(x) -> Psi(x) - epsilon^mu partial_mu Psi(x) + cal(O)(epsilon^2). $)
  Review the discussion of the canonical energy momentum tensor in the free scalar theory and deduce the form of the canonical energy momentum tensor $T^(mu nu)$ for the free Dirac action. Also give the form of the conserved 4-momentum operator $P^mu$ and compare $P^0$ with the canonical Hamiltonian. _Hint:_ Since the energy-momentum is only conserved on shell, we can implement the equations of motion directly in $T^(mu nu)$. The final result will then be
  #tagged(8, $ T^(mu nu) = i overline(Psi)(x) gamma^mu partial^nu Psi(x). $)
]

From eq. (7) and $Psi(x) -> Psi(x) + epsilon^mu delta_mu Psi(x) + cal(O)(epsilon^2)$, we gather that
$ delta_mu Psi(x) = -partial_mu Psi(x) = -partial/(partial x^mu) Psi(x). $
$cal(L)$ is known to be a local function of $x$ and therefore transforms as
$ cal(L) -> cal(L) - epsilon^nu partial_nu cal(L) + cal(O)(epsilon^2). $
Again, from comparing the above to an expansion in orders of variations,
$ cal(L) -> cal(L) + epsilon^nu delta_nu cal(L) + cal(O)(epsilon^2), $
we get that $delta_nu cal(L) = -partial_nu cal(L) = -partial_mu eta^mu_(#hide($mu$) nu) cal(L)$. $(F^mu)_nu$ as in $delta_nu cal(L) = partial_mu (F^mu)_nu$ is given by $(F^mu)_nu = -eta^mu_(#hide($mu$) nu) cal(L)$. Even though the first variation of the second degree of freedom of the Dirac field $delta Psi^dagger (x)$ appears in the Noether current as well, it does not need to be computed here because its prefactor $(partial cal(L))/(partial(partial_mu Psi^dagger)) = 0$ vanishes. The four Noether currents $(j^mu)_nu$ (one for each continuous symmetry parameter in $epsilon^nu$) can be written as
$ (j^mu)_nu = (partial cal(L))/(partial(partial_mu Psi)) delta_nu Psi + (partial cal(L))/(partial(partial_mu Psi^dagger)) delta_nu Psi^dagger - (F^mu)_nu = overline(Psi) i gamma^mu (-partial_nu Psi) + eta^mu_(#hide($mu$) nu) cal(L). $
The overall sign of a Noether current is a matter of convention. Choosing it such that the energy comes out positive, the energy-momentum tensor $T^(mu nu) = -(j^mu)^nu$ on-shell, i.e. using $(i gamma^mu partial_mu - m) Psi = 0$ so that $cal(L) = 0$, reads
$ T^(mu nu) = i overline(Psi) gamma^mu partial^nu Psi. $
The conserved 4-momentum operator $P^mu := integral dd(3, x) T^(0 mu)$ and the Hamiltonian $H := P^0$ are
$ P^mu = integral dd(3, x) i Psi^dagger partial^mu Psi, quad H = integral dd(3, x) i Psi^dagger partial_t Psi. $
With the canonical momentum $pi = (partial cal(L))/(partial dot(Psi)) = i Psi^dagger$, the canonical Hamiltonian is $integral dd(3, x) (pi dot(Psi) - cal(L)) = integral dd(3, x) i Psi^dagger partial_t Psi$ on-shell, in agreement with $P^0$.

#task(label: "b")[
  Give the infinitesimal version of the transformation of the Dirac spinor under a Lorentz transformation
  #tagged(9, $ x --> exp(-i/2 omega_(mu nu) cal(J)^(mu nu)) x $)
  with $cal(J)^(mu nu)$ as given in the lecture. Deduce that the conserved current associated with Lorentz invariance can be written as
  #tagged(10, $ (cal(J)^mu)^(rho sigma) = x^sigma T^(mu rho) - x^rho T^(mu sigma) - overline(Psi) gamma^mu S^(rho sigma) Psi. $)
  $partial_mu cal(J)^mu$ vanishes on-shell.
]

To find the spinor representation of the Lorentz algebra $"so"(1, 3)$ we start from the Clifford algebra $"Cliff"(1, 3)$ defined as the algebra spanned by $n times n$-matrices $(gamma^mu)^A_(#hide($A$) B)$, $mu in {0, 1, 2, 3}$ and $A, B in {1, dots, n}$ such that the following anticommutator is fulfilled:
$ {gamma^mu, gamma^nu} = gamma^mu gamma^nu + gamma^nu gamma^mu = 2 eta^(mu nu) bb(1)_4. $
The central point is that given matrices $(gamma^mu)^A_(#hide($A$) B)$ as above, the objects $(S^(rho sigma))^A_(#hide($A$) B)$ defined as
$ (S^(rho sigma))^A_(#hide($A$) B) := i/4 [gamma^rho, gamma^sigma]^A_(#hide($A$) B) $
form a representation of $"so"(1, 3)$, meaning they obey the same commutation relations as the generators $cal(J)^(rho sigma)$ of the Lorentz algebra (cf. problem 9.2 b) with $S^(rho sigma) -> -i S^(rho sigma)$):
$ [S^(rho sigma), S^(tau kappa)] = i (eta^(rho kappa) S^(sigma tau) + eta^(sigma tau) S^(rho kappa) - eta^(rho tau) S^(sigma kappa) - eta^(sigma kappa) S^(rho tau)). $
Thus, every representation of $"Cliff"(1, 3)$ induces a representation of $"so"(1, 3)$. Now, as stated in the problem, a finite Lorentz transformation $Lambda^mu_(#hide($mu$) nu)$ is given by
$ Lambda^mu_(#hide($mu$) nu) = [e^(-i/2 omega_(rho sigma) cal(J)^(rho sigma))]^mu_(#hide($mu$) nu), quad "where" quad (cal(J)^(rho sigma))^(mu nu) := i (eta^(rho mu) eta^(sigma nu) - eta^(rho nu) eta^(sigma mu)). $
A spinor representation for every one of these $Lambda in "SO"(1, 3)$ is given by
$ [S(Lambda)]^A_(#hide($A$) B) = [e^(-i/2 omega_(rho sigma) S^(rho sigma))]^A_(#hide($A$) B), $
where $A, B in {1, 2, 3, 4}$ for $"Cliff"(1, 3)$ are called spinor indices. We are to find an infinitesimal version of the Dirac spinor transformation under the above Lorentz transformation. In general (also finitely), a Dirac spinor transforms as
$ Psi^A (x) --> [S(Lambda)]^A_(#hide($A$) B) Psi^B (Lambda^(-1) x'). $
To find the infinitesimal version, we insert here the above expressions for $S(Lambda)$ and $Lambda$ and expand to first order in $omega_(rho sigma)$:
$
  (Lambda^(-1))^mu_(#hide($mu$) nu) & = [bb(1)_4 + i/2 omega_(rho sigma) cal(J)^(rho sigma) + cal(O)(omega_(rho sigma)^2)]^mu_(#hide($mu$) nu) approx delta^mu_(#hide($mu$) nu) - 1/2 omega_(rho sigma) (eta^(rho mu) eta^sigma_(#hide($sigma$) nu) - eta^rho_(#hide($rho$) nu) eta^(sigma mu)) \
  & = delta^mu_(#hide($mu$) nu) - 1/2 (omega^mu_(#hide($mu$) nu) - omega_nu^(#hide($nu$) mu)) = delta^mu_(#hide($mu$) nu) - 1/2 (omega^mu_(#hide($mu$) nu) - eta_(alpha nu) omega^(alpha mu)) \
  & = delta^mu_(#hide($mu$) nu) - 1/2 (omega^mu_(#hide($mu$) nu) + eta_(alpha nu) omega^(mu alpha)) = delta^mu_(#hide($mu$) nu) - 1/2 (omega^mu_(#hide($mu$) nu) + omega^mu_(#hide($mu$) nu)) = delta^mu_(#hide($mu$) nu) - omega^mu_(#hide($mu$) nu), \
  [S(Lambda)]^A_(#hide($A$) B) & = [bb(1)_4 - i/2 omega_(rho sigma) S^(rho sigma) + cal(O)(omega_(rho sigma)^2)]^A_(#hide($A$) B) approx delta^A_(#hide($A$) B) + 1/8 omega_(rho sigma) [gamma^rho, gamma^sigma]^A_(#hide($A$) B) \
  & = delta^A_(#hide($A$) B) + 1/8 [omega_(rho sigma) gamma^rho gamma^sigma + underbrace(omega_(sigma rho) gamma^sigma gamma^rho, rho <-> sigma)]^A_(#hide($A$) B) = delta^A_(#hide($A$) B) + 1/4 [omega_(rho sigma) gamma^rho gamma^sigma]^A_(#hide($A$) B).
$
Therefore, to first order a Dirac spinor transforms as
$
  Psi(x) --> [S(Lambda)]^A_(#hide($A$) B) Psi^B (Lambda^(-1) x') & = (delta^A_(#hide($A$) B) + 1/4 [omega_(rho sigma) gamma^rho gamma^sigma]^A_(#hide($A$) B)) Psi^B ((delta^mu_(#hide($mu$) nu) - omega^mu_(#hide($mu$) nu)) x'^nu) \
  & = Psi^A (x'^mu - underbrace(omega^mu_(#hide($mu$) nu) x'^nu, epsilon^mu)) + 1/4 [omega_(rho sigma) gamma^rho gamma^sigma]^A_(#hide($A$) B) Psi^B (x'^mu - omega^mu_(#hide($mu$) nu) x'^nu) \
  & approx Psi^A (x'^mu) - omega^mu_(#hide($mu$) nu) x'^nu partial_mu Psi^A (x'^mu) + 1/4 [omega_(rho sigma) gamma^rho gamma^sigma]^A_(#hide($A$) B) Psi^B (x'^mu) + cal(O)[(omega^mu_(#hide($mu$) nu) x'^nu)^2].
$
The conserved current associated with this symmetry transformation will not be derived here.

#task(label: "c")[
  Show that the Dirac action exhibits the following global $U(1)$ symmetry
  $ Psi(x) -> e^(i alpha) Psi(x), quad overline(Psi)(x) -> overline(Psi)(x) e^(-i alpha), quad alpha in RR $
  and deduce the corresponding Noether current $j^mu = -overline(Psi) gamma^mu Psi$. Also give the form of the Noether charge $Q$ in terms of the modes of $Psi(x)$.
]

The Dirac action under a global $U(1)$ transformation behaves as follows:
$
  S' & = integral dd(4, x) cal(L)' = integral dd(4, x) overline(Psi)' (i gamma^mu partial_mu - m) Psi' = integral dd(4, x) overline(Psi) e^(-i alpha) (i gamma^mu partial_mu - m) e^(i alpha) Psi \
  & = integral dd(4, x) overline(Psi) (i gamma^mu partial_mu - m) Psi = integral dd(4, x) cal(L) = S.
$
It remains unchanged, hence the above $U(1)$ transformation is really a symmetry. Since the transformation is generated by a continuous parameter $alpha in RR$, we can write it infinitesimally by expanding $e^(i alpha)$ to first order in $alpha$:
$ Psi(x) --> Psi'(x) = e^(i alpha) Psi(x) = Psi(x) + i alpha Psi(x) + cal(O)(alpha^2). $
By comparing this expression with an expansion of $Psi'(x)$ in orders of variations, i.e. $Psi'(x) = Psi(x) + alpha delta Psi(x) + cal(O)(alpha^2)$, we see that $delta Psi = i Psi$. From $cal(L)' = cal(L)$, we know $delta cal(L) = 0$ and therefore $F^mu$ is constant ($delta cal(L) = partial_mu F^mu$) and can be set to zero as constant terms in a current are of no physical interest. $j^mu$ then reads
$ j^mu = (partial cal(L))/(partial(partial_mu Psi)) delta Psi + underbrace((partial cal(L))/(partial(partial_mu Psi^dagger)), 0) delta Psi^dagger - F^mu = overline(Psi) i gamma^mu i Psi = -overline(Psi) gamma^mu Psi. $
The Noether charge $Q$ in terms of the modes of the field $Psi(x)$ can be obtained by integrating the current's zero component over space and inserting the free mode expansions for $Psi(x)$ and $Psi^dagger (x)$:
$
  Q & = integral dd(3, x) j^0 = integral dd(3, x) (-overline(Psi) gamma^0 Psi) = -integral dd(3, x) Psi^dagger Psi \
  & = -sum_(r, s) integral (dd(3, p))/(2 pi)^3 1/sqrt(2 E_p) integral (dd(3, q))/(2 pi)^3 1/sqrt(2 E_q) (a_s^dagger (p) u_s^dagger (p) + b_s (-p) v_s^dagger (-p)) (a_r (q) u_r (q) + b_r^dagger (-q) v_r (-q)) integral dd(3, x) e^(i (p - q) x) \
  & = -sum_(r, s) integral (dd(3, p))/(2 pi)^3 1/(2 E_p) (a_s^dagger (p) u_s^dagger (p) a_r (p) u_r (p) + a_s^dagger (p) u_s^dagger (p) b_r^dagger (-p) v_r (-p) \
    & #h(9em) + b_s (-p) v_s^dagger (-p) a_r (p) u_r (p) + b_s (p) v_s^dagger (p) b_r^dagger (p) v_r (p)) \
  & = -sum_(r, s) integral (dd(3, p))/(2 pi)^3 1/(2 E_p) (a_s^dagger (p) a_r (p) 2 E_p delta_(r s) + b_s (p) b_r^dagger (p) 2 E_p delta_(r s)) \
  & = -sum_s integral (dd(3, p))/(2 pi)^3 (a_s^dagger (p) a_s (p) - b_s^dagger (p) b_s (p)) - 2 integral dd(3, p) delta^((3)) (0),
$
where we exploited the spinor identities
$ u_s^dagger (arrow(p)) u_r (arrow(p)) = 2 E_p delta_(r s) = v_s^dagger (arrow(p)) v_r (arrow(p)) quad "and" quad u_s^dagger (arrow(p)) v_r (-arrow(p)) = 0 = v_s^dagger (-arrow(p)) u_r (arrow(p)) $
and the anticommutation relation of $b_s (p)$ and $b_r^dagger (q)$,
$ {b_s (p), b_r^dagger (q)} = (2 pi)^3 delta_(r s) delta^((3)) (arrow(p) - arrow(q)). $
The second term in $Q$ is clearly divergent but independent of both $p$ and $x$. It is just an added constant lacking physical meaning. Before applying the charge operator to physical states, this term must be dropped.

#task(label: "d")[
  Show that if $m = 0$ the Dirac action admits, in addition, the so-called axial symmetry
  $ Psi(x) --> e^(i alpha gamma^5) Psi(x), quad overline(Psi)(x) --> overline(Psi)(x) e^(i alpha gamma^5), quad alpha in RR, $
  which you should interpret as an independent rotation of the positive and negative chirality spinors. Here $gamma^5 = i gamma^0 gamma^1 gamma^2 gamma^3$ and ${gamma^5, gamma^mu} = 0$ as discussed in the lecture. Deduce the associated conserved current.
]

For $m = 0$, the Dirac Lagrangian reads $cal(L) = i overline(Psi) gamma^mu partial_mu Psi$. To see how it transforms, we calculate
$
  gamma^mu e^(i alpha gamma^5) & = gamma^mu sum_(n = 0)^oo 1/n! (i alpha gamma^5)^n attach(=, t: {gamma^5, gamma^mu} = 0) sum_(n = 0)^oo (-1)^n/n! (i alpha gamma^5)^n gamma^mu = e^(-i alpha gamma^5) gamma^mu, \
  cal(L)' & = i overline(Psi) e^(i alpha gamma^5) gamma^mu partial_mu e^(i alpha gamma^5) Psi = i overline(Psi) e^(i alpha gamma^5) e^(-i alpha gamma^5) gamma^mu partial_mu Psi = i overline(Psi) gamma^mu partial_mu Psi = cal(L).
$
$cal(L)$ stays invariant and therefore also the action does not change. To find the associated conserved current, we note that
$
  & Psi -> e^(i alpha gamma^5) Psi = Psi + i alpha gamma^5 Psi + cal(O)(alpha^2) quad ==> quad delta Psi = i gamma^5 Psi, quad delta cal(L) = 0 quad ==> quad F^mu equiv 0, \
  & j^mu = (partial cal(L))/(partial(partial_mu Psi)) delta Psi + underbrace((partial cal(L))/(partial(partial_mu Psi^dagger)), 0) delta Psi^dagger - F^mu = i overline(Psi) gamma^mu i gamma^5 Psi = overline(Psi) gamma^5 gamma^mu Psi.
$

= Problem 10.2 (Yukawa interaction and Feynman rules)

#task[
  Consider the following Lagrangian
  $ cal(L) = 1/2 partial_mu phi partial^mu phi - 1/2 m^2 phi^2 + overline(Psi) (i gamma^mu partial_mu - m) Psi - g phi overline(Psi) Psi $
  of a massive Dirac fermion $Psi$ and a massive real scalar $phi$ coupled by a Yukawa interaction with a real coupling constant $g$.
]

#task(label: "a")[Deduce the mass dimension of the coupling $g$.]

In natural units, we set $planck = 1$. Therefore, the action $S$ has mass dimension zero. From this we can deduce dimensions of other quantities:
$
  0 & = [S] = [dd(4, x) cal(L)] = -4 + [cal(L)] & quad ==> quad & [cal(L)] = 4, \
  4 & = [cal(L)] = [m^2 phi^2] = 2 + [phi^2] & quad ==> quad & [phi] = 1, \
  4 & = [cal(L)] = [overline(Psi) m Psi] = 1 + [Psi^2] & quad ==> quad & [Psi] = 3/2, \
  4 & = [cal(L)] = [g phi overline(Psi) Psi] = [g] + 1 + 2 dot 3/2 & quad ==> quad & [g] = 0.
$

#let fline(a, b, t: 0.5) = {
  let mid = (a.at(0) + t * (b.at(0) - a.at(0)), a.at(1) + t * (b.at(1) - a.at(1)))
  draw.line(a, mid, mark: (end: "stealth", fill: black, scale: 0.6))
  draw.line(mid, b)
}
#let yukawa(crossed: false) = fd({
  import draw: *
  let (v1, v2) = ((0, 0), (1.1, 0))
  let (p, pp, k, kp) = ((-0.5, -0.7), (1.6, -0.7), (-0.5, 0.7), (1.6, 0.7))
  fline(p, v1)
  fline(pp, v2)
  fline(v1, if crossed { kp } else { k }, t: 0.75)
  fline(v2, if crossed { k } else { kp }, t: 0.75)
  line(v1, v2, stroke: (dash: "dashed"))
  content(p, text(8pt)[$p$], anchor: "north", padding: 0.05)
  content(pp, text(8pt)[$p'$], anchor: "north", padding: 0.05)
  content(k, text(8pt)[$k$], anchor: "south", padding: 0.05)
  content(kp, text(8pt)[$k'$], anchor: "south", padding: 0.05)
})

#task(label: "b")[
  In the previous exercise, we discussed a quick way to compute the S-matrix to leading order in the coupling constant directly in the quantum mechanical interaction picture. Use this procedure to compute, from scratch, the complete leading order scattering amplitude for scattering of two fermions with ingoing momenta $p$ and $p'$ in Yukawa theory. The result is
  #tagged(6, $ i cal(M) & = #yukawa() + #yukawa(crossed: true) \
    & = (-i g)^2 (overline(u)(k) u(p) 1/((k - p)^2 - m_phi^2) overline(u)(k') u(p') - overline(u)(k) u(p') 1/((k - p')^2 - m_phi^2) overline(u)(k') u(p)). $)
]

This exercise is far too lengthy for the exam and therefore does not need to be considered further at this point.

= Problem 10.3 (Parity)

#task[
  Parity is the discrete map $P: x -> x' = P x$, $P(x^0, arrow(x)) = (x^0, -arrow(x))$. To find the transformation of the Dirac spinor field $Psi(x)$ under parity transformations we seek for a representation of the group of parity transformations
  #tagged(8, $ Psi(x) --> Psi'(x) := P Psi(x) P^(-1) := S(P) Psi(P^(-1) x), $)
  where $S(P)$ acts on the Dirac spinor.
]

#task(label: "a")[Deduce the necessary condition for $S(P)$ such that the Dirac equation is invariant under parity transformation and verify on the basis of the Clifford algebra that $S(P) = gamma^0$ satisfies these.]

We take this as a definition of the parity transformed spinor field, i.e. $Psi(x)$ transforms as
#tagged(10, $ Psi(x) --> eta gamma^0 Psi(P^(-1) x'), quad eta^2 = 1, "where we set" eta = 1. $)
The Dirac equation $(i gamma^mu partial_mu - m) Psi(x) = 0$ is obtained by varying the action of the free classical Dirac field
$ S = integral dd(4, x) overline(Psi) (i gamma^mu partial_mu - m) Psi $
with respect to $Psi^dagger$. Demanding that the Dirac equation stay invariant under parity transformation results in
$ (i gamma^mu partial_mu - m) Psi(x) = 0 quad attach(-->, t: P) quad (i gamma^mu partial^mu - m) S(P) Psi(P^(-1) x') = 0. $
Here, it shouldn't make any difference if we first transform the spinor and then act on it with the transformed operators in the Dirac equation or first let the old operators act on the old spinor and then transform the so obtained spinor, i.e. we can further claim
$ (i gamma^mu partial^mu - m) S(P) Psi(P^(-1) x') attach(=, t: !) S(P) (i gamma^mu partial_mu - m) Psi(P^(-1) x'). $
We have essentially commuted $S(P)$ with $gamma^mu$ and found that this gives us a minus sign in the three spatial components. That is akin to saying $S(P)$ fulfills the following relations:
$ [S(P), gamma^0] = 0, quad {S(P), gamma^i} = 0. $
Incidentally, thanks to the defining relation of the Clifford algebra ${gamma^mu, gamma^nu} = 2 eta^(mu nu) bb(1)_4$, we find that $gamma^0$ satisfies the above. In general, $S(P)$ is therefore given by
$ S(P) = eta gamma^0, $
where we conventionalize by setting $eta = 1$.

#task(label: "b")[
  Show that parity flips chirality, i.e.
  #tagged(11, $ P_plus.minus (S(P) Psi_plus.minus (P^(-1) x')) = 0, quad P_minus.plus (S(P) Psi_plus.minus (P^(-1) x')) = S(P) Psi_plus.minus (P^(-1) x'), $)
  where $P_plus.minus = 1/2 (bb(1)_4 plus.minus gamma^5)$ is the projection operator onto chiral and anti-chiral spinors $Psi_plus.minus = P_plus.minus Psi$. You may use the above representation in eq. (10).
]

Since ${gamma^mu, gamma^nu} = 2 eta^(mu nu) bb(1)_4$, $gamma^0$ anticommutes with $gamma^i$, where $i in {1, 2, 3}$:
$ {gamma^0, gamma^i} = 2 eta^(0 i) bb(1)_4 = 0. $
From this, we can deduce that also $gamma^0$ and $gamma^5$ anticommute:
$ {gamma^0, gamma^5} = gamma^0 i gamma^0 gamma^1 gamma^2 gamma^3 + i gamma^0 gamma^1 gamma^2 gamma^3 gamma^0 = gamma^0 i gamma^0 gamma^1 gamma^2 gamma^3 + (-1)^3 gamma^0 i gamma^0 gamma^1 gamma^2 gamma^3 = 0. $
Since we are allowed to use eq. (10), we can write
$
  P_plus.minus (S(P) Psi_plus.minus (P^(-1) x')) & = 1/2 (bb(1)_4 plus.minus gamma^5) gamma^0 Psi_plus.minus (P^(-1) x') = gamma^0 1/2 (bb(1)_4 minus.plus gamma^5) Psi_plus.minus (P^(-1) x') \
  & = gamma^0 P_minus.plus Psi_plus.minus (P^(-1) x') = gamma^0 P_minus.plus P_plus.minus Psi(P^(-1) x') = 0, \
  P_minus.plus (S(P) Psi_plus.minus (P^(-1) x')) & = 1/2 (bb(1)_4 minus.plus gamma^5) gamma^0 Psi_plus.minus (P^(-1) x') = gamma^0 1/2 (bb(1)_4 plus.minus gamma^5) Psi_plus.minus (P^(-1) x') \
  & = gamma^0 P_plus.minus Psi_plus.minus (P^(-1) x') = gamma^0 P_plus.minus P_plus.minus Psi(P^(-1) x') = gamma^0 P_plus.minus Psi(P^(-1) x') = S(P) Psi_plus.minus (P^(-1) x').
$

#task(label: "c")[
  Determine the transformation behaviour of the spinor bilinears $overline(Psi)(x) Psi(x)$, $overline(Psi)(x) gamma^5 Psi(x)$, $overline(Psi)(x) gamma^mu Psi(x)$, and $overline(Psi)(x) gamma^mu gamma^5 Psi(x)$ under parity transformations and also under continuous Lorentz transformations.

  _Note:_ The object $overline(Psi)(x) gamma^5 Psi(x)$ is called a pseudo-scalar and the object $overline(Psi)(x) gamma^mu gamma^5 Psi(x)$ is called a pseudo-vector or axial vector due to their properties under parity transformations.
]

#let Pto = $attach(-->, t: P)$
#let Lto = $attach(-->, t: Lambda)$
#let xP = $(P^(-1) x')$
#let xL = $(Lambda^(-1) x')$
$
  overline(Psi)(x) Psi(x) & Pto overline(S(P) Psi xP) S(P) Psi xP = [S(P) Psi xP]^dagger underbrace(gamma^0 gamma^0, bb(1)_4) Psi xP \
  & = Psi^dagger xP S^dagger (P) Psi xP = Psi^dagger xP underbrace((gamma^0)^dagger, gamma^0) Psi xP = overline(Psi) xP Psi xP, \
  overline(Psi)(x) Psi(x) & Lto overline(S(Lambda) Psi xL) S(Lambda) Psi xL = Psi^dagger xL S^dagger (Lambda) gamma^0 S(Lambda) Psi xL \
  & = Psi^dagger xL underbrace(gamma^0 gamma^0, bb(1)_4) S^dagger (Lambda) gamma^0 S(Lambda) Psi xL = Psi^dagger xL gamma^0 underbrace(gamma^0 S^dagger (Lambda) gamma^0, S^(-1) (Lambda)) S(Lambda) Psi xL \
  & = overline(Psi) xL Psi xL, \
  overline(Psi)(x) gamma^5 Psi(x) & Pto Psi^dagger xP S^dagger (P) gamma^0 gamma^5 S(P) Psi xP = Psi^dagger xP underbrace(gamma^0 gamma^0, bb(1)_4) gamma^5 gamma^0 Psi xP \
  & = -Psi^dagger xP gamma^0 gamma^5 Psi xP = -overline(Psi) xP gamma^5 Psi xP, \
  overline(Psi)(x) gamma^5 Psi(x) & Lto Psi^dagger xL S^dagger (Lambda) gamma^0 gamma^5 S(Lambda) Psi xL = Psi^dagger xL gamma^0 S^(-1) (Lambda) gamma^5 S(Lambda) Psi xL \
  & = overline(Psi) xL gamma^5 S^(-1) (Lambda) S(Lambda) Psi xL = overline(Psi) xL gamma^5 Psi xL,
$
where we used that $[S^(-1) (Lambda), gamma^5] = 0$ since $S^(-1) (Lambda) = e^(i/2 omega_(mu nu) S^(mu nu))$ and $S^(mu nu) prop [gamma^mu, gamma^nu]$ commutes with $gamma^5$.
$
  overline(Psi)(x) gamma^mu Psi(x) & Pto Psi^dagger xP S^dagger (P) gamma^0 gamma^mu S(P) Psi xP = overline(Psi) xP underbrace(gamma^0 gamma^0, bb(1)_4) gamma_mu Psi xP = overline(Psi) xP gamma_mu Psi xP, \
  overline(Psi)(x) gamma^mu Psi(x) & Lto Psi^dagger xL S^dagger (Lambda) gamma^0 gamma^mu S(Lambda) Psi xL = overline(Psi) xL underbrace(S^(-1) (Lambda) gamma^mu S(Lambda), Lambda^mu_(#hide($mu$) nu) gamma^nu) Psi xL, \
  overline(Psi)(x) gamma^mu gamma^5 Psi(x) & Pto Psi^dagger xP S^dagger (P) gamma^0 gamma^mu gamma^5 S(P) Psi xP = Psi^dagger xP gamma^mu gamma^5 gamma^0 Psi xP \
  & = -Psi^dagger xP gamma^0 gamma_mu gamma^5 Psi xP = -overline(Psi) xP gamma_mu gamma^5 Psi xP, \
  overline(Psi)(x) gamma^mu gamma^5 Psi(x) & Lto Psi^dagger xL S^dagger (Lambda) gamma^0 gamma^mu gamma^5 S(Lambda) Psi xL = overline(Psi) xL S^(-1) (Lambda) gamma^mu gamma^5 S(Lambda) Psi xL \
  & = overline(Psi) xL Lambda^mu_(#hide($mu$) nu) gamma^nu gamma^5 Psi xL.
$

= Problem 11.1 (The Yukawa potential)

#task[
  Here, we will analyse and 'derive' the classical potential for Yukawa theory, where the interactions between fermions are transmitted by a scalar field $phi$. As discussed on assignment 10 in problem 10.2, the Lagrangian of the theory is
  #tagged(1, $ cal(L) = 1/2 partial_mu phi partial^mu phi - 1/2 m^2 phi^2 + overline(Psi) (i gamma^mu partial_mu - m) Psi - g phi overline(Psi) Psi. $)
  The Feynman rules are given in the script. Now analyse the following two processes.
]

// tree-level 2 -> 2 diagram: legs are (outer point, label, incoming?) attached to vertex v1 or v2
#let tree(v1, v2, legs, q, qpos: "south", qpad: 0.08) = fd({
  import draw: *
  line(v1, v2, stroke: (dash: "dashed"))
  content(((v1.at(0) + v2.at(0)) / 2, (v1.at(1) + v2.at(1)) / 2), text(8pt, q), anchor: qpos, padding: qpad)
  for (v, pt, lbl, inward, anc) in legs {
    if inward { fline(pt, v, t: 0.55) } else { fline(v, pt, t: 0.55) }
    content(pt, text(8pt, lbl), anchor: anc, padding: 0.06)
  }
})

#task(label: "a")[Electron-electron scattering: $e^- + e^- -> e^- + e^-$.]

At tree-level, there are just two diagrams contributing to electron-electron scattering. The scattering amplitude is given by
#let (a1, a2) = ((0, 0), (1.5, 0))
$
  i cal(M) & = #tree(a1, a2, (
      (a1, (-0.6, -0.75), $e^- med p, s$, true, "north"),
      (a1, (-0.6, 0.75), $e^- med p', s'$, false, "south"),
      (a2, (2.1, -0.75), $e^- med k, r$, true, "north"),
      (a2, (2.1, 0.75), $e^- med k', r'$, false, "south"),
    ), $q = p - p'$, qpos: "north") - #tree(a1, a2, (
      (a1, (-0.6, -0.75), $e^- med p, s$, true, "north"),
      (a1, (2.1, 0.75), $e^- med k', r'$, false, "south"),
      (a2, (2.1, -0.75), $e^- med k, r$, true, "north"),
      (a2, (-0.6, 0.75), $e^- med p', s'$, false, "south"),
    ), $q = p - k'$, qpos: "north") \
  & = overline(u)_(s') (p') u_s (p) (-i g) i/((p - p')^2 - m_phi^2) (-i g) overline(u)_(r') (k') u_r (k) - overline(u)_(r') (k') u_s (p) (-i g) i/((p - k')^2 - m_phi^2) (-i g) overline(u)_(s') (p') u_r (k) \
  & = -i g^2 (overline(u)_(s') (p') u_s (p) 1/((p - p')^2 - m_phi^2) overline(u)_(r') (k') u_r (k) - overline(u)_(r') (k') u_s (p) 1/((p - k')^2 - m_phi^2) overline(u)_(s') (p') u_r (k)).
$

#task(label: "b")[Electron-positron scattering: $e^- + e^+ -> e^- + e^+$.]

This so-called Bhabha scattering also has two diagrams contributing to the scattering amplitude at tree-level. While the second diagram from part a) is no longer an option because the particles are no longer indistinguishable, we can now have electron-positron annihilation, i.e. an s-channel diagram. It enters with a relative minus sign from Fermi statistics:
$
  i cal(M) & = #tree(a1, a2, (
      (a1, (-0.6, -0.75), $e^- med p, s$, true, "north"),
      (a1, (-0.6, 0.75), $e^- med p', s'$, false, "south"),
      (a2, (2.1, 0.75), $e^+ med k, r$, true, "south"),
      (a2, (2.1, -0.75), $e^+ med k', r'$, false, "north"),
    ), $q = p - p'$, qpos: "north") - #tree(a1, a2, (
      (a1, (-0.6, -0.75), $e^- med p, s$, true, "north"),
      (a1, (-0.6, 0.75), $e^+ med k, r$, true, "south"),
      (a2, (2.1, 0.75), $e^- med p', s'$, false, "south"),
      (a2, (2.1, -0.75), $e^+ med k', r'$, false, "north"),
    ), $q = p + k$, qpos: "north") \
  & = overline(u)_(s') (p') u_s (p) (-i g) i/((p - p')^2 - m_phi^2) (-i g) overline(v)_r (k) v_(r') (k') - overline(v)_r (k) u_s (p) (-i g) i/((p + k)^2 - m_phi^2) (-i g) overline(u)_(s') (p') v_(r') (k') \
  & = -i g^2 (overline(u)_(s') (p') u_s (p) 1/((p - p')^2 - m_phi^2) overline(v)_r (k) v_(r') (k') - overline(v)_r (k) u_s (p) 1/((p + k)^2 - m_phi^2) overline(u)_(s') (p') v_(r') (k')).
$

= Problem 11.2 (The Klein--Nishina formula for Compton scattering)

#task[
  We now look at the process of Compton scattering at tree-level in QED. The Feynman rules for QED are listed in the script in section 4.6.
]

#task(label: "a")[
  Use the Feynman rules to write down the tree-level Compton scattering amplitude and bring it into the form
  $ i cal(M) = -i e^2 epsilon_mu^* (k', lambda') epsilon_nu (k, lambda) overline(u)_(s') (p') ((gamma^mu cancel(k) gamma^nu + 2 gamma^mu p^nu)/(2 p k) + (gamma^nu cancel(k)' gamma^mu - 2 gamma^nu p^mu)/(2 p k')) u_s (p). $
]

At tree-level, Compton scattering can take place in the form of two distinct processes. In $e^- + gamma -> e^- + gamma$, the electron can either first absorb, then emit a photon, making it an s-channel diagram, or first emit, then absorb a photon, which results in u-channel scattering:
#import "@preview/cetz:0.5.2": decorations
#let photon(a, b) = decorations.wave(draw.line(a, b), amplitude: 0.09, segment-length: 0.18)
#let compton(crossed: false) = fd({
  import draw: *
  let (ein, v1, v2, eout) = ((-1.1, 0), (0, 0), (2, 0), (3.1, 0))
  fline(ein, v1)
  fline(v1, v2)
  fline(v2, eout)
  content(ein, text(8pt)[$e^-$], anchor: "east", padding: 0.05)
  content(eout, text(8pt)[$e^-$], anchor: "west", padding: 0.05)
  content((-0.55, 0), text(8pt)[$p, s$], anchor: "south", padding: 0.12)
  content((2.6, 0), text(8pt)[$p', s'$], anchor: if crossed { "south" } else { "north" }, padding: 0.12)
  let (gin, gout) = if crossed { ((0.3, -1.1), (1.7, 1.1)) } else { ((-1, -1.1), (3, 1.1)) }
  let (vin, vout) = if crossed { (v2, v1) } else { (v1, v2) }
  photon(gin, vin)
  photon(vout, gout)
  content(gin, text(8pt)[$gamma med k, lambda$], anchor: "north", padding: 0.08)
  content(gout, text(8pt)[$gamma med k', lambda'$], anchor: "south", padding: 0.08)
  content(v1, text(8pt)[$#if crossed [$mu$] else [$nu$]$], anchor: if crossed { "north" } else { "south-east" }, padding: 0.06)
  content(v2, text(8pt)[$#if crossed [$nu$] else [$mu$]$], anchor: if crossed { "south-west" } else { "north" }, padding: 0.06)
  if crossed {
    // label sits above the outgoing photon with a pointer down to the propagator, as in the sketch
    content((0.35, 1.0), text(8pt)[$q = p - k'$], anchor: "south", padding: 0.04)
    line((0.6, 1.0), (1.0, 0.06), stroke: 0.4pt)
  } else {
    content((1, 0), text(8pt)[$q = p + k$], anchor: "north", padding: 0.14)
  }
})
$
  i cal(M) & = #compton() + #compton(crossed: true) \
  & = overline(u)_(s') (p') epsilon_mu^* (k', lambda') (-i e gamma^mu) (i (gamma (p + k) + m_0))/((p + k)^2 - m_0^2) (-i e gamma^nu) u_s (p) epsilon_nu (k, lambda) \
  & quad + overline(u)_(s') (p') epsilon_nu (k, lambda) (-i e gamma^nu) (i (gamma (p - k') + m_0))/((p - k')^2 - m_0^2) (-i e gamma^mu) u_s (p) epsilon_mu^* (k', lambda') \
  & = -i e^2 epsilon_mu^* (k', lambda') epsilon_nu (k, lambda) overline(u)_(s') (p') (gamma^mu (cancel(p) + cancel(k) + m_0)/(2 p k) gamma^nu + gamma^nu (cancel(p) - cancel(k)' + m_0)/(-2 p k') gamma^mu) u_s (p).
$
Using the Dirac equation and the anticommutation relation of the Clifford algebra, $gamma^mu gamma^nu = -gamma^nu gamma^mu + 2 eta^(mu nu) bb(1)_4$, we can simplify the numerators:
$ (cancel(p) + m_0) gamma^nu u_s (p) = (gamma^mu p_mu + m_0) gamma^nu u_s (p) = 2 eta^(mu nu) bb(1)_4 p_mu u_s (p) + gamma^nu underbrace((-gamma^mu p_mu + m_0) u_s (p), = 0 "(e.o.m.)") = 2 p^nu u_s (p). $
Using this equality, we can write the scattering amplitude $i cal(M)$ as
$ i cal(M) = -i e^2 epsilon_mu^* (k', lambda') epsilon_nu (k, lambda) overline(u)_(s') (p') (gamma^mu (cancel(k) gamma^nu + 2 p^nu)/(2 p k) + gamma^nu (cancel(k)' gamma^mu - 2 p^mu)/(2 p k')) u_s (p). $
Parts b) through g) are too technical for the exam and will thus not be solved here.
