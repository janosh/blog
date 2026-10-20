#import "/notes.typ": dd, nord, notes, tagged, task
#import "@preview/cetz:0.5.2": canvas, draw

#show: notes.with(
  title: [Mid-Semester Exam on Quantum Field Theory I],
  subtitle: [Devised by Jürgen Berges, written on 10.12.2014],
  date: [Solutions by Janosh Riebesell, 23.01.2015],
)

// vacuum bubbles of phi^4 theory, drawn inline in equations
#let bubble(body, width: 0.9) = box(baseline: 45%, canvas(length: 1cm, {
  import draw: *
  set-style(stroke: 0.7pt)
  body
}))
// colored underline pairing terms that cancel each other
#let u(paint, body) = box(stroke: (bottom: 0.8pt + paint), outset: (bottom: 2.5pt), body)
#let k1 = rgb("#1f5fa8")
#let k2 = rgb("#b22222")
#let k3 = rgb("#2e7d32")
#let k4 = rgb("#c75b00")
#let k5 = rgb("#7b3fa0")
#let k6 = rgb("#00838f")
#let vertex(pt) = draw.circle(pt, radius: 0.045, fill: black, stroke: none)
// optional vertex labels (x, y) as in the handwritten diagrams
#let vlbl(pt, body, anchor) = if body != none { draw.content(pt, text(size: 7.5pt, body), anchor: anchor) }
#let figure-eight(s: 0.22, x: none) = bubble({
  draw.circle((0, s), radius: s)
  draw.circle((0, -s), radius: s)
  vertex((0, 0))
  vlbl((s + 0.02, 0), x, "west")
})
#let double-eight(s: 0.16, x: none, y: none) = bubble({
  draw.circle((0, 0), radius: 2 * s)
  draw.circle((0, 3 * s), radius: s)
  draw.circle((0, -3 * s), radius: s)
  vertex((0, 2 * s))
  vertex((0, -2 * s))
  vlbl((1.5 * s, 2 * s), x, "west")
  vlbl((1.5 * s, -2 * s), y, "west")
})
#let melon(r: 0.36, x: none, y: none) = bubble({
  draw.circle((0, 0), radius: r)
  for c in (-0.45 * r, 0.45 * r) { draw.bezier((0, r), (0, -r), (c * 2.2, 0)) }
  vertex((0, r))
  vertex((0, -r))
  vlbl((0, r + 0.05), x, "south")
  vlbl((0, -r - 0.05), y, "north")
})

= Problem 1 (5 points)

#task[
  Consider a free complex scalar field $phi(x)$ with action
  #tagged(1, $ S = integral dd(4, x) (partial^mu phi^dagger partial_mu phi - m^2 phi^dagger phi), quad phi = phi(x) "and" phi^dagger = phi^dagger (x). $)
]

#task(label: "a")[Derive the equation of motion for $phi(x)$.]

Equations of motion can be deduced from a system's action $S$ by applying to it Hamilton's principle of stationary action $delta S = 0$. Hamilton's principle states that of all possible evolutions of a system, the (only) true evolution $phi(t, arrow(x)) = phi(x)$ is the one which lies at a stationary point of the action functional $S[phi(x)]$, i.e. a point where the variation $delta S[phi(x)]$ with respect to $phi$ and $partial_mu phi$, subject to $delta phi|_"boundary" = delta partial_mu phi|_"boundary" = 0$, is zero. This yields
$
  0 & attach(=, t: !) delta S = delta (integral dd(4, x) cal(L)(phi, partial_mu phi)) = integral dd(4, x) ((partial cal(L))/(partial phi) delta phi + (partial cal(L))/(partial(partial_mu phi)) delta partial_mu phi) \
  & = integral dd(4, x) ((partial cal(L))/(partial phi) delta phi + (partial cal(L))/(partial(partial_mu phi)) partial_mu delta phi) = underbrace((partial cal(L))/(partial(partial_mu phi)) delta phi |_"boundary", 0) + integral dd(4, x) ((partial cal(L))/(partial phi) - partial_mu (partial cal(L))/(partial(partial_mu phi))) delta phi.
$
Since the variation of $phi$ is in general nonzero throughout spacetime, for the above to hold requires
$ (partial cal(L))/(partial phi) - partial_mu (partial cal(L))/(partial(partial_mu phi)) = 0. $
Inserting the Lagrangian in brackets in (1) into this expression and varying with respect to $phi^dagger$, since we are tasked to find the equation of motion for $phi$, results in
$ -m^2 phi - partial_mu (partial^mu phi) = 0 quad ==> quad (partial^2 + m^2) phi = 0. $

#task(label: "b")[Derive the expression for the canonically conjugate momentum density to $phi(x)$ and compute the Hamiltonian density $cal(H)$.]

The canonically conjugate momentum density is defined as
$ pi(x) = (partial cal(L))/(partial(partial_t phi(x))) = partial_t phi^dagger (x) = dot(phi)^dagger (x). $
The Hamiltonian density in turn is defined as
$ cal(H) = sum_i pi_i (x) dot(phi)_i (x) - cal(L), $
where the sum runs over all independent pairs of conjugate fields and momentum densities. Since the complex scalar field has two degrees of freedom, $phi(x)$ and $phi^dagger (x)$, this sum contributes two terms:
$
  cal(H) & = pi dot(phi) + pi^dagger dot(phi)^dagger - partial^mu phi^dagger partial_mu phi + m^2 phi^dagger phi \
  & = (partial_t phi^dagger) dot(phi) + (partial_t phi) dot(phi)^dagger - partial_t phi^dagger partial_t phi + nabla phi^dagger dot nabla phi + m^2 phi^dagger phi \
  & = pi^dagger pi + nabla phi^dagger dot nabla phi + m^2 phi^dagger phi.
$

#task(label: "c")[
  The mode expansion for $phi(x)$ takes the form
  #tagged(2, $ phi(x) = integral (dd(3, p))/(2 pi)^3 1/sqrt(2 E_p) (a(p) e^(-i p x) + b^dagger (p) e^(i p x)). $)
  Make an ansatz for the commutation relations of the modes $a(p)$, $a^dagger (p)$, $b(p)$ and $b^dagger (p)$ such that when you explicitly compute the equal-time commutator $[phi(t, arrow(x)), dot(phi)^dagger (t, arrow(y))]$ you obtain the right result for canonical quantization.
]

Quantization is performed by promoting the fields $phi(x)$ and $phi^dagger (x)$ to operators acting on states in a system's Hilbert space. This process is considered canonical when the resulting operators fulfill a certain commutation relation, namely
$ [phi(t, arrow(x)), dot(phi)^dagger (t, arrow(y))] = i delta^((3)) (arrow(x) - arrow(y)). $
To achieve this relation, we impose the following commutators for the creation and annihilation operators:
$
  [a(p), a^dagger (q)] & = [b(p), b^dagger (q)] = (2 pi)^3 delta^((3)) (arrow(p) - arrow(q)), \
  [a(p), a(q)] & = [a^dagger (p), a^dagger (q)] = [b(p), b(q)] = [b^dagger (p), b^dagger (q)] = underbrace(dots.c, "other permutations") = 0.
$
_Remark:_ These commutators need not be guessed. They can be computed by carrying over the creation and annihilation commutation relations from the real free scalar field and writing $a = 1/sqrt(2) (a_1 + i a_2)$, $b^dagger = 1/sqrt(2) (a_1^dagger + i a_2^dagger)$.

Inserting (2) and the mode expansion for $dot(phi)^dagger (t, arrow(y))$,
$
  dot(phi)^dagger (t, arrow(y)) & = partial_t integral (dd(3, q))/(2 pi)^3 1/sqrt(2 E_q) (a^dagger (q) e^(i q y) + b(q) e^(-i q y)) \
  & = i integral (dd(3, q))/(2 pi)^3 sqrt(E_q / 2) (a^dagger (q) e^(i q y) - b(q) e^(-i q y)),
$
into the equal-time commutator yields
$
  [phi(t, arrow(x)), dot(phi)^dagger (t, arrow(y))] & = i integral (dd(3, p))/(2 pi)^3 1/sqrt(2 E_p) e^(-i p x) integral (dd(3, q))/(2 pi)^3 sqrt(E_q / 2) e^(i q y) [a(p) + b^dagger (-p), a^dagger (q) - b(-q)] \
  & = i/2 integral (dd(3, p))/(2 pi)^3 integral (dd(3, q))/(2 pi)^3 sqrt(E_q / E_p) e^(i(q y - p x)) ([a(p), a^dagger (q)] - underbrace([a(p), b(-q)], 0) + overbrace([b^dagger (-p), a^dagger (q)], 0) - [b^dagger (-p), b(-q)]) \
  & = i/2 integral (dd(3, p))/(2 pi)^3 integral (dd(3, q))/(2 pi)^3 sqrt(E_q / E_p) e^(i(q y - p x)) ((2 pi)^3 delta^((3)) (arrow(p) - arrow(q)) + (2 pi)^3 delta^((3)) (-arrow(p) + arrow(q))) \
  & = i integral (dd(3, p))/(2 pi)^3 e^(i p (y - x)) = i integral (dd(3, p))/(2 pi)^3 e^(i E_p (t - t) - i arrow(p) dot (arrow(y) - arrow(x))) = i integral (dd(3, p))/(2 pi)^3 e^(i arrow(p) dot (arrow(x) - arrow(y))) \
  & = i delta^((3)) (arrow(x) - arrow(y)).
$

#task(label: "d")[
  Show that the action (1) is invariant under the transformation
  $ phi(x) -> e^(i alpha) phi(x), quad alpha in RR $
  and derive the associated Noether current and the Noether charge $Q$ in terms of the fundamental fields. _Hint:_ $Q = integral dd(3, x) j^0 (x)$ and $j^mu (x) = (partial cal(L))/(partial(partial_mu phi)) delta phi - F^mu$.
]

$ S' = integral dd(4, x) \(partial^mu phi^dagger (x) underbrace(e^(-i alpha) partial_mu e^(i alpha), partial_mu) phi(x) - m^2 phi^dagger (x) underbrace(e^(-i alpha) e^(i alpha), 1) phi(x)\) = S. $
Since $alpha in RR$ generates a continuous symmetry, we can Taylor expand the transformed fields in terms of infinitesimal variations of the original fields, i.e.
$
  phi(x) -> phi'(x, alpha) & = phi(x) + alpha delta phi(x) + alpha^2/2 delta^2 phi(x) + alpha^3/3! delta^3 phi(x) + dots.c \
  & = phi(x) + alpha delta phi(x) + cal(O)(alpha^2).
$
Since $phi'(x, alpha) = e^(i alpha) phi(x) = (1 + i alpha + (i alpha)^2 / 2 + dots.c) phi = phi + alpha i phi - alpha^2/2 phi + dots.c$, we can deduce $delta phi(x) = i phi(x)$, and similarly $delta phi^dagger (x) = -i phi^dagger (x)$.

After the transformation, the Lagrangian depends on the new fields and therefore on the transformation parameter $alpha in RR$. Therefore, it too can be expanded in $alpha$:
$
  cal(L) -> cal(L)' & = cal(L) + alpha delta cal(L) + alpha^2/2 delta^2 cal(L) + alpha^3/3! delta^3 cal(L) + dots.c \
  & = cal(L) + alpha delta cal(L) + cal(O)(alpha^2).
$
However, since we already know that the Lagrangian as well as the action remain unchanged by the transformation, it follows that
$ delta^n cal(L) = 0 quad forall n in NN. $
We now have all the necessary parts to assemble the Noether current $j^mu$ associated with this transformation:
$ j^mu = sum_"d.o.f." (partial cal(L))/(partial(partial_mu phi)) delta phi - F^mu = (partial cal(L))/(partial(partial_mu phi)) delta phi + (partial cal(L))/(partial(partial_mu phi^dagger)) delta phi^dagger - F^mu = (partial^mu phi^dagger) i phi - (partial^mu phi) i phi^dagger - F^mu, $
where $F^mu$, due to $partial_mu F^mu := delta cal(L) = 0$, is just a constant which can be set to zero, i.e.
$ j^mu = i (phi partial^mu phi^dagger - phi^dagger partial^mu phi). $
The charge then follows as
$
  Q & = integral dd(3, x) j^0 (x) = i integral dd(3, x) (phi partial^0 phi^dagger - phi^dagger partial^0 phi) = i integral dd(3, x) (phi partial_t phi^dagger - phi^dagger partial_t phi) \
  & = i integral dd(3, x) integral (dd(3, p))/(2 pi)^3 e^(-i p x)/sqrt(2 E_p) i integral (dd(3, q))/(2 pi)^3 sqrt(E_q / 2) e^(i q x) ([a(p) + b^dagger (-p)][a^dagger (q) - b(-q)] + [a^dagger (p) + b(-p)][a(q) - b^dagger (-q)]) \
  & = -1/2 integral (dd(3, p))/(2 pi)^3 integral (dd(3, q))/(2 pi)^3 sqrt(E_q / E_p) integral dd(3, x) e^(i (q - p) x) (a(p) a^dagger (q) - a(p) b(-q) + b^dagger (-p) a^dagger (q) - b^dagger (-p) b(-q) \
    & #h(9em) + a^dagger (p) a(q) - a^dagger (p) b^dagger (-q) + b(-p) a(q) - b(-p) b^dagger (-q)) \
  & = -1/2 integral (dd(3, p))/(2 pi)^3 integral (dd(3, q))/(2 pi)^3 sqrt(E_q / E_p) (2 pi)^3 delta^((3)) (arrow(q) - arrow(p)) e^(i (E_q - E_p) t) (dots.c) \
  & = -1/2 integral (dd(3, p))/(2 pi)^3 (a(p) a^dagger (p) - #u(k1, $a(p) b(-p)$) + #u(k2, $b^dagger (-p) a^dagger (p)$) - b^dagger (-p) b(-p) \
    & #h(9em) + a^dagger (p) a(p) - #u(k2, $a^dagger (p) b^dagger (-p)$) + #u(k1, $b(-p) a(p)$) - b(-p) b^dagger (-p)),
$
where the mixed terms cancel pairwise because $a$ and $b$ operators commute. Normal ordering with the commutators from part c) gives
$
  Q & = -1/2 integral (dd(3, p))/(2 pi)^3 (a^dagger (p) a(p) + (2 pi)^3 delta^((3)) (0) - b^dagger (p) b(p) + a^dagger (p) a(p) - b^dagger (p) b(p) - (2 pi)^3 delta^((3)) (0)) \
  & = -1/2 integral (dd(3, p))/(2 pi)^3 (2 a^dagger (p) a(p) - 2 b^dagger (p) b(p)) = -integral (dd(3, p))/(2 pi)^3 (a^dagger (p) a(p) - b^dagger (p) b(p)).
$

#task(label: "e")[
  The expression for the Noether charge $Q$ in terms of the modes reads (in some overall normalization)
  $ Q = integral (dd(3, p))/(2 pi)^3 (a^dagger (p) a(p) - b^dagger (p) b(p)). $
  Compute the charge, i.e. the eigenvalue with respect to $Q$, of the states $a^dagger (p) |0 chevron.r$ and $b^dagger (p) |0 chevron.r$.
]

Since $a^dagger (p) |0 chevron.r$ and $b^dagger (p) |0 chevron.r$ are states consisting of just one particle and antiparticle, respectively, one would expect their charges to be $1$ and $-1$:
$
  Q a^dagger (p) |0 chevron.r & = integral (dd(3, q))/(2 pi)^3 (a^dagger (q) a(q) - b^dagger (q) b(q)) a^dagger (p) |0 chevron.r \
  & = integral (dd(3, q))/(2 pi)^3 (a^dagger (q) (a^dagger (p) a(q) + (2 pi)^3 delta^((3)) (arrow(q) - arrow(p))) - a^dagger (p) b^dagger (q) b(q)) |0 chevron.r \
  & = integral (dd(3, q))/(2 pi)^3 a^dagger (q) (2 pi)^3 delta^((3)) (arrow(q) - arrow(p)) |0 chevron.r = +a^dagger (p) |0 chevron.r, \
  Q b^dagger (p) |0 chevron.r & = integral (dd(3, q))/(2 pi)^3 (a^dagger (q) a(q) - b^dagger (q) b(q)) b^dagger (p) |0 chevron.r \
  & = integral (dd(3, q))/(2 pi)^3 (b^dagger (p) a^dagger (q) a(q) - b^dagger (q) (b^dagger (p) b(q) + (2 pi)^3 delta^((3)) (arrow(q) - arrow(p)))) |0 chevron.r \
  & = -integral (dd(3, q))/(2 pi)^3 b^dagger (q) (2 pi)^3 delta^((3)) (arrow(q) - arrow(p)) |0 chevron.r = -b^dagger (p) |0 chevron.r,
$
where we used $a(q) |0 chevron.r = b(q) |0 chevron.r = 0$ both times in the second-to-last step.

= Problem 2 (5 points)

#task[This time consider the real scalar field $phi(x)$.]

#task(label: "a")[Show that the time-ordered product $T phi(x_1) phi(x_2)$ and the normal-ordered product $nord(phi(x_1) phi(x_2))$ are both symmetric under the interchange of $x_1$ and $x_2$.]

$ T phi(x_1) phi(x_2) = cases(phi(x_1) phi(x_2) & "if" x_1^0 > x_2^0, phi(x_2) phi(x_1) & "if" x_2^0 > x_1^0) = T phi(x_2) phi(x_1). $
Splitting the field into its annihilation and creation parts, $phi = phi^+ + phi^-$, and moving all creation parts to the left,
$
  nord(phi(x_1) phi(x_2)) & = nord([phi^+ (x_1) + phi^- (x_1)][phi^+ (x_2) + phi^- (x_2)]) \
  & = nord(phi^+ (x_1) phi^+ (x_2)) + nord(phi^+ (x_1) phi^- (x_2)) + nord(phi^- (x_1) phi^+ (x_2)) + nord(phi^- (x_1) phi^- (x_2)) \
  & = phi^+ (x_1) phi^+ (x_2) + phi^- (x_2) phi^+ (x_1) + phi^- (x_1) phi^+ (x_2) + phi^- (x_1) phi^- (x_2), \
  nord(phi(x_2) phi(x_1)) & = phi^+ (x_2) phi^+ (x_1) + phi^- (x_1) phi^+ (x_2) + phi^- (x_2) phi^+ (x_1) + phi^- (x_2) phi^- (x_1),
$
which agree since $phi^+$ commutes with $phi^+$ and $phi^-$ with $phi^-$. #h(1fr) $square$

#task(label: "b")[Deduce that the Feynman propagator, $D_F (x_1 - x_2)$, has the same symmetry property.]

$ D_F (x_1 - x_2) := chevron.l 0 | T phi(x_1) phi(x_2) | 0 chevron.r attach(=, t: "a)") chevron.l 0 | T phi(x_2) phi(x_1) | 0 chevron.r = D_F (x_2 - x_1). $

#task(label: "c")[
  Check Wick's theorem for the case of three scalar fields,
  #tagged(5, $ T phi(x_1) phi(x_2) phi(x_3) & = nord(phi(x_1) phi(x_2) phi(x_3)) + phi(x_1) D_F (x_2 - x_3) \
    & quad + phi(x_2) D_F (x_3 - x_1) + phi(x_3) D_F (x_1 - x_2). $)
]

For brevity, instead of $phi(x_1)$, $phi(x_2)$ and $phi(x_3)$ we write $phi_1$, $phi_2$ and $phi_3$. Now assuming $x_1^0 >= x_2^0 >= x_3^0$, we can write
$
  T phi_1 phi_2 phi_3 = phi_1 phi_2 phi_3 & = (phi_1^+ + phi_1^-)(phi_2^+ + phi_2^-)(phi_3^+ + phi_3^-) \
  & = phi_1^+ phi_2^+ phi_3^+ + phi_1^+ phi_2^+ phi_3^- + phi_1^+ phi_2^- phi_3^+ + phi_1^+ phi_2^- phi_3^- \
  & quad + phi_1^- phi_2^+ phi_3^+ + phi_1^- phi_2^+ phi_3^- + phi_1^- phi_2^- phi_3^+ + phi_1^- phi_2^- phi_3^-.
$
On the other hand, we can compute
$
  & nord(phi_1 phi_2 phi_3) + phi_1 D_F (x_2 - x_3) + phi_2 D_F (x_3 - x_1) + phi_3 D_F (x_1 - x_2) \
  & = phi_1^+ phi_2^+ phi_3^+ + phi_3^- phi_1^+ phi_2^+ + phi_2^- phi_1^+ phi_3^+ + phi_2^- phi_3^- phi_1^+ + phi_1^- phi_2^+ phi_3^+ + phi_1^- phi_3^- phi_2^+ + phi_1^- phi_2^- phi_3^+ + phi_1^- phi_2^- phi_3^- \
  & quad + (phi_1^+ + phi_1^-)[phi_2^+, phi_3^-] + (phi_2^+ + phi_2^-)[phi_1^+, phi_3^-] + (phi_3^+ + phi_3^-)[phi_1^+, phi_2^-],
$
where we used
$ D_F (x_1 - x_2) = chevron.l 0 | T phi(x_1) phi(x_2) | 0 chevron.r = cases([phi^+ (x_1), phi^- (x_2)] & "for" x_1^0 > x_2^0, [phi^+ (x_2), phi^- (x_1)] & "for" x_2^0 > x_1^0.) $
Making use of the fact that the commutators of the free modes $phi^+ (x)$ and $phi^- (y)$ are simply c-numbers, i.e.
$ [phi^+ (x), phi^- (y)] = integral (dd(3, p))/(2 pi)^3 e^(-i p x)/sqrt(2 E_p) integral (dd(3, q))/(2 pi)^3 e^(i q y)/sqrt(2 E_q) underbrace([a(p), a^dagger (q)], (2 pi)^3 delta^((3)) (arrow(p) - arrow(q))) = integral (dd(3, p))/(2 pi)^3 e^(-i p (x - y))/(2 E_p) = D(x - y), $
we can move them past any free mode. Writing out each commutator, $[phi_i^+, phi_j^-] = phi_i^+ phi_j^- - phi_j^- phi_i^+$, the second terms cancel the normal-ordered products of the first line that have a creation part to the left of an annihilation part, and the first terms restore them in time order (cancelling pairs underlined in matching colors):
$
  & = phi_1^+ phi_2^+ phi_3^+ + phi_3^- phi_1^+ phi_2^+ + phi_2^- phi_1^+ phi_3^+ + phi_2^- phi_3^- phi_1^+ + phi_1^- phi_2^+ phi_3^+ + phi_1^- phi_3^- phi_2^+ + phi_1^- phi_2^- phi_3^+ + phi_1^- phi_2^- phi_3^- \
  & quad + phi_1^+ [phi_2^+, phi_3^-] + phi_1^- [phi_2^+, phi_3^-] + [phi_1^+, phi_3^-] phi_2^+ + phi_2^- [phi_1^+, phi_3^-] + [phi_1^+, phi_2^-] phi_3^+ + [phi_1^+, phi_2^-] phi_3^- \
  & = phi_1^+ phi_2^+ phi_3^+ + #u(k1, $phi_3^- phi_1^+ phi_2^+$) + #u(k2, $phi_2^- phi_1^+ phi_3^+$) + #u(k3, $phi_2^- phi_3^- phi_1^+$) + phi_1^- phi_2^+ phi_3^+ + #u(k4, $phi_1^- phi_3^- phi_2^+$) + phi_1^- phi_2^- phi_3^+ + phi_1^- phi_2^- phi_3^- \
  & quad + phi_1^+ phi_2^+ phi_3^- - #u(k5, $phi_1^+ phi_3^- phi_2^+$) + phi_1^- phi_2^+ phi_3^- - #u(k4, $phi_1^- phi_3^- phi_2^+$) + #u(k5, $phi_1^+ phi_3^- phi_2^+$) - #u(k1, $phi_3^- phi_1^+ phi_2^+$) \
  & quad + #u(k6, $phi_2^- phi_1^+ phi_3^-$) - #u(k3, $phi_2^- phi_3^- phi_1^+$) + phi_1^+ phi_2^- phi_3^+ - #u(k2, $phi_2^- phi_1^+ phi_3^+$) + phi_1^+ phi_2^- phi_3^- - #u(k6, $phi_2^- phi_1^+ phi_3^-$) \
  & = phi_1^+ phi_2^+ phi_3^+ + phi_1^+ phi_2^+ phi_3^- + phi_1^+ phi_2^- phi_3^+ + phi_1^- phi_2^+ phi_3^+ + phi_1^+ phi_2^- phi_3^- + phi_1^- phi_2^+ phi_3^- + phi_1^- phi_2^- phi_3^+ + phi_1^- phi_2^- phi_3^- \
  & = (phi_1^+ + phi_1^-) phi_2^+ phi_3^+ + phi_1^- phi_2^- (phi_3^+ + phi_3^-) + (phi_1^+ + phi_1^-) phi_2^+ phi_3^- + phi_1^+ phi_2^- (phi_3^+ + phi_3^-) \
  & = phi_1 phi_2^+ (phi_3^+ + phi_3^-) + (phi_1^+ + phi_1^-) phi_2^- phi_3 = phi_1 phi_2^+ phi_3 + phi_1 phi_2^- phi_3 = phi_1 phi_2 phi_3 = T phi_1 phi_2 phi_3.
$
Since we have shown in parts a) and b) that both the normal-ordered product and the Feynman propagator are symmetric under the exchange of arguments, this result has to hold for any time ordering, e.g. $T phi_1 phi_2 phi_3 = phi_2 phi_1 phi_3$, i.e. without the initial assumption $x_1^0 > x_2^0 > x_3^0$.

#task[
  Now consider an interacting real scalar field theory with Lagrangian density
  $ cal(L) = 1/2 partial_mu phi partial^mu phi - 1/2 m^2 phi^2 - lambda/4! phi^4. $
]

#task(label: "d")[Examine $chevron.l 0 | S | 0 chevron.r$ to order $lambda^2$ in this theory and identify the different diagrams that arise from an application of Wick's theorem. _Hint:_ $chevron.l 0 | S | 0 chevron.r = chevron.l 0 | T exp[-i integral_(-oo)^oo dd(t) H_I (t)] | 0 chevron.r$.]

To expand the expression given as a hint to second order in the coupling constant $lambda$, we first need a relation between $H_I (t)$ and $cal(L)_"int" = -lambda/4! phi^4$. Differing from what one might expect from the definitions of interaction picture operators such as
$ phi_I (t, arrow(x)) := e^(i H_0 (t - t_0)) phi(t_0, arrow(x)) e^(-i H_0 (t - t_0)) quad "and" quad pi_I (t, arrow(x)) := e^(i H_0 (t - t_0)) pi(t_0, arrow(x)) e^(-i H_0 (t - t_0)), $
$H_I (t)$ is not equal to $e^(i H_0 (t - t_0)) H(t_0) e^(-i H_0 (t - t_0))$ but rather
$ H_I (t) := e^(i H_0 (t - t_0)) H_"int" (t_0) e^(-i H_0 (t - t_0)), quad "where" quad H(t) = H_0 (t) + H_"int" (t). $
Now since $L = L_0 + L_"int"$ and $H = integral dd(3, x) pi(t, arrow(x)) dot(phi)(t, arrow(x)) - L_0 - L_"int" = H_0 + H_"int"$, we can see that $H_"int" = -L_"int"$, i.e. performing a Legendre transformation to move from the Lagrangian to the Hamiltonian does not introduce new interaction terms as long as the Lagrangian does not contain interactions with time derivatives of the field. Otherwise
$ pi(t, arrow(x)) = (partial cal(L))/(partial dot(phi)(t, arrow(x))) $
would contain higher powers of the field than just the first. We now have the necessary relation
$
  H_I & = integral dd(3, x) e^(i H_0 (t - t_0)) (-cal(L)_"int") e^(-i H_0 (t - t_0)) = integral dd(3, x) e^(i H_0 (t - t_0)) lambda/4! phi^4 e^(-i H_0 (t - t_0)) \
  & = integral dd(3, x) lambda/4! e^(i H_0 (t - t_0)) phi e^(-i H_0 (t - t_0)) e^(i H_0 (t - t_0)) phi e^(-i H_0 (t - t_0)) dots.c e^(i H_0 (t - t_0)) phi e^(-i H_0 (t - t_0)) = integral dd(3, x) lambda/4! phi_I^4
$
and can expand $chevron.l 0 | S | 0 chevron.r$ into
$
  chevron.l 0 | S | 0 chevron.r & = chevron.l 0 | T bb(1) | 0 chevron.r + chevron.l 0 | T (-i lambda/4! integral dd(4, x) phi^4) | 0 chevron.r + chevron.l 0 | T 1/2 (-i lambda/4! integral dd(4, x) phi^4)^2 | 0 chevron.r + cal(O)(lambda^3) \
  & = 1 - i lambda/4! integral dd(4, x) chevron.l 0 | T phi^4 (x) | 0 chevron.r - lambda^2/(2 dot 4!^2) integral dd(4, x) integral dd(4, y) chevron.l 0 | T phi^4 (x) phi^4 (y) | 0 chevron.r + cal(O)(lambda^3).
$
To find the Feynman diagrams these terms represent, we should be aware that we are looking at vacuum-to-vacuum processes without external particles. Therefore, when applying Wick's theorem, we need all fields to be contracted. We first look at $chevron.l 0 | T phi^4 (x) | 0 chevron.r$. Its normal-ordered part has vanishing vacuum expectation value, and the four fields can be fully contracted in 3 ways:
$ chevron.l 0 | T phi^4 (x) | 0 chevron.r = underbrace(chevron.l 0 | nord(phi^4 (x)) | 0 chevron.r, 0) + 3 D_F (0)^2 = 3 #figure-eight(x: $x$), quad 1/S = 3/4! = 1/8. $
The second-order term gives, with $9 + 72 + 24 = 105 = 7!!$ full contractions of eight fields,
$
  chevron.l 0 | T phi^4 (x) phi^4 (y) | 0 chevron.r & = 9 D_F (0)^4 + 72 D_F (0)^2 D_F (x - y)^2 + 24 D_F (x - y)^4 \
  & = 9 #figure-eight(x: $x$) #figure-eight(x: $y$) + 72 #double-eight(x: $x$, y: $y$) + 24 #melon(x: $x$, y: $y$),
$
with symmetry factors $1/S = 9/(2 dot 4!^2) = 1/128$, $72/(2 dot 4!^2) = 1/16$ and $24/(2 dot 4!^2) = 1/48$, respectively.

#task(label: "e")[
  Confirm that, to order $lambda^2$, the combinatorial (symmetry) factors work out such that the vacuum-to-vacuum amplitude is given by the exponential sum of distinct vacuum bubble types,
  $ chevron.l 0 | S | 0 chevron.r = exp(#figure-eight() + #double-eight() + #melon() + dots.c). $
]

Combining all diagrams and their combinatorial factors found in d) into a sum,
$ chevron.l 0 | S | 0 chevron.r = 1 + (-i lambda) (1/8 #figure-eight()) + (-i lambda)^2/2 (1/8 #figure-eight())^2 + (-i lambda)^2/2 (1/8 #double-eight()) + (-i lambda)^2/2 (1/24 #melon()) + cal(O)(lambda^3), $
which agrees to order $lambda^2$ with the expansion of the exponential, $exp(X) = 1 + X + X^2/2 + dots.c$, where each bubble type $X$ carries its factor $-i lambda / S$ and the square of the first-order bubble reproduces the disconnected diagram.
