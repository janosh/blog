#import "/notes.typ": dd, notes, tagged, task
#import "@preview/cetz:0.5.2": canvas, decorations, draw

#show: notes.with(
  title: [General Relativity -- Exercise Sheet 3],
  subtitle: [Exercise sheet 3, General Relativity, Prof. Björn Schäfer],
  date: [Solutions by Roland Walz and Janosh Riebesell, 01.05.2015],
)

// index set {0,1,2,3} under a component matrix
#let idx(..i) = $#i.pos().join($,$) in {0, 1, 2, 3}$
// equality that holds once restricted to the sphere r = const
#let seq = $attach(=, t: *)$
// smaller type for wide matrices
#let wide(body) = {
  set text(size: 8.5pt)
  body
}

= Problem 1: Fun with Indices (10 points)

#task[Consider the metric $g^(mu nu)$ with $"diag"({g^(mu nu)}_(#idx($mu$, $nu$))) = (a, b, -b^(-1), tan(d))$.]

#task(label: "a")[Calculate $g_(mu nu)$.]

As stated in lecture 5, $g_(mu nu)$ is simply the inverse of $g^(mu nu)$. Since $g^(mu nu)$ is diagonal, its inverse can be computed by inverting all entries.
$ g_(mu nu) = (g^(mu nu))^(-1) quad ==> quad "diag"({g_(mu nu)}_(#idx($mu$, $nu$))) = (1/a, 1/b, -b, cot(d)). $

#task(label: "b")[Let's assume that we're in Cartesian coordinates $(t, x, y, z)$. What is the line element $dif s^2$?]

$ dif s^2 = dif arrow(s) dot dif arrow(s) = dif s_mu dif s^mu = g_(mu nu) dif s^mu dif s^nu = 1/a dif t^2 + 1/b dif x^2 - b dif y^2 + cot(d) dif z^2. $

#task(label: "c")[Given ${x^mu}_(mu in {0, 1, 2, 3}) = (1, 0, 1, 0)^T$, what is $x_mu$?]

$ {x_mu}_(mu in {0, 1, 2, 3}) = {g_(mu nu)}_(#idx($mu$, $nu$)) {x^nu}_(nu in {0, 1, 2, 3}) = (1/a, 0, -b, 0). $

#task(label: "d")[
  You're given the line element
  $ dif s^2 = c^2 dif t^2 - dif r^2 - r^2 dif phi^2. $
  What sort of coordinate system are we using? What does the metric look like?
]

There is no unique answer to the above questions. Two obvious possibilities are
$ dif arrow(s) = (c dif t, dif r, r dif phi)^T quad "and" quad dif arrow(s) = (dif t, dif r, dif phi)^T, $
in which cases the metric is given by
$ g = mat(1, 0, 0; 0, -1, 0; 0, 0, -1) quad "and" quad g = mat(c^2, 0, 0; 0, -1, 0; 0, 0, -r^2), $
respectively. There are more.

= Problem 2: Metric tensor and equations of motion (10 points)

#task[
  The metric can be written as
  $ g_(mu nu) = eta_(rho sigma) (partial x'^rho)/(partial x^mu) (partial x'^sigma)/(partial x^nu). $
  In three-dimensional Euclidean space, this is just a coordinate transformation.
]

#task(label: "a")[Find $g_(mu nu)$ for polar coordinates $(r, theta, phi)$. Neglect the zero-components, i.e. $mu = i in I = {1, 2, 3}$.]

#grid(
  columns: (1fr, auto),
  gutter: 10pt,
  [
    The transformation to polar coordinates is given by
    $
      x & = x(r, theta, phi) = r cos phi sin theta, quad y = y(r, theta, phi) = r sin phi sin theta, \
      z & = z(r, theta) = r cos theta, quad "where" r in RR_+, theta in [0, pi], phi in [0, 2 pi).
    $
  ],
  align(horizon, canvas(length: 1cm, {
    import draw: *
    set-style(stroke: 0.6pt)
    let o = (0, 0)
    // oblique projection: y-axis drawn towards the lower left
    let p3(x, y, z) = (x - 0.5 * y, z - 0.4 * y)
    line(o, p3(1.9, 0, 0), mark: (end: ">"))
    line(o, p3(0, 0, 1.8), mark: (end: ">"))
    line(o, p3(0, 2.2, 0), mark: (end: ">"))
    content(p3(2.1, 0, 0), text(8pt)[$x$])
    content((rel: (-0.15, 0), to: p3(0, 0, 1.9)), text(8pt)[$z$])
    content((rel: (-0.15, -0.1), to: p3(0, 2.3, 0)), text(8pt)[$y$])
    let (px, py, pz) = (1.1, 0.9, 1.2)
    let p = p3(px, py, pz)
    let q = p3(px, py, 0)
    line(o, p, stroke: 0.9pt)
    circle(p, radius: 0.04, fill: black)
    line(p, q, stroke: (dash: "dashed"))
    line(o, q, stroke: (dash: "dashed"))
    line(q, p3(px, 0, 0), stroke: (dash: "dashed"))
    line(q, p3(0, py, 0), stroke: (dash: "dashed"))
    content((rel: (0.12, 0.1), to: p3(px / 2, py / 2, pz / 2)), text(8pt)[$r$])
    // braces marking the Cartesian components of the point
    let br = (amplitude: 0.1, stroke: 0.5pt)
    decorations.flat-brace(o, p3(0, 0, pz), ..br)
    content((-0.27, pz / 2), text(7pt)[$z$])
    decorations.flat-brace(o, p3(px, 0, 0), ..br)
    content((px / 2 + 0.3, 0.24), text(7pt)[$x$])
    decorations.flat-brace(p3(0, py, 0), o, ..br)
    content((-0.4, -0.02), text(7pt)[$y$])
    // theta between z-axis and r, phi between x-axis and the projection of r
    bezier(p3(0, 0, 0.55), p3(0.3, 0.25, 0.38), p3(0.12, 0.08, 0.55))
    content(p3(0.12, 0.05, 0.75), text(7pt)[$theta$])
    bezier(p3(0.6, 0, 0), p3(0.42, 0.36, 0), p3(0.6, 0.2, 0))
    content((0.8, -0.1), text(7pt)[$phi$])
  })),
)
To calculate the metric with the above formula, we need the Jacobian $J$ of this transformation:
$
  J = {J^k_i}_(k, i in I) = mat((partial x)/(partial r), (partial x)/(partial theta), (partial x)/(partial phi); (partial y)/(partial r), (partial y)/(partial theta), (partial y)/(partial phi); (partial z)/(partial r), (partial z)/(partial theta), (partial z)/(partial phi)) = mat(cos phi sin theta, r cos phi cos theta, -r sin phi sin theta; sin phi sin theta, r sin phi cos theta, r cos phi sin theta; cos theta, -r sin theta, 0).
$
#wide[
  $
    {g_(i j)}_(i, j in I) & = underbrace({eta_(k l)}_(k, l in I), -bb(1)_3) {J^k_i}_(k, i in I) {J^l_j}_(l, j in I) = -J^T J \
    & = -mat(cos phi sin theta, sin phi sin theta, cos theta; r cos phi cos theta, r sin phi cos theta, -r sin theta; -r sin phi sin theta, r cos phi sin theta, 0) mat(cos phi sin theta, r cos phi cos theta, -r sin phi sin theta; sin phi sin theta, r sin phi cos theta, r cos phi sin theta; cos theta, -r sin theta, 0) \
    & = -mat((J^T J)_11, (J^T J)_12, (J^T J)_13; (J^T J)_21, (J^T J)_22, (J^T J)_23; (J^T J)_31, (J^T J)_32, (J^T J)_33), quad "with" \
    (J^T J)_11 & = cos^2 phi sin^2 theta + sin^2 phi sin^2 theta + cos^2 theta = 1, \
    (J^T J)_12 = (J^T J)_21 & = r cos^2 phi sin theta cos theta + r sin^2 phi sin theta cos theta - r sin theta cos theta = 0, \
    (J^T J)_13 = (J^T J)_31 & = -r sin phi cos phi sin^2 theta + r sin phi cos phi sin^2 theta = 0, \
    (J^T J)_22 & = r^2 cos^2 phi cos^2 theta + r^2 sin^2 phi cos^2 theta + r^2 sin^2 theta = r^2, \
    (J^T J)_23 = (J^T J)_32 & = -r^2 sin phi cos phi sin theta cos theta + r^2 sin phi cos phi sin theta cos theta = 0, \
    (J^T J)_33 & = r^2 sin^2 phi sin^2 theta + r^2 cos^2 phi sin^2 theta = r^2 sin^2 theta, \
    ==> quad {g_(i j)}_(i, j in I) & = -mat(1, 0, 0; 0, r^2, 0; 0, 0, r^2 sin^2 theta).
  $
]

#task(label: "b")[
  Now limit yourself to the surface of a sphere in $RR^3$, i.e. a 2-sphere. Calculate all remaining Christoffel symbols $Gamma^alpha_(mu nu)$ using
  $ Gamma^alpha_(mu nu) = g^(alpha beta)/2 (g_(nu beta, mu) + g_(mu beta, nu) - g_(mu nu, beta)). $
]

_Remark:_ In the above formula, a shorthand notation is employed, in which nabla symbols and partial derivatives are dropped and instead the indices with respect to which a quantity is derivated are separated by semicolons and commas, respectively. E.g. $g_(nu beta, mu)$ stands for $(partial g_(nu beta))/(partial x^mu)$.

On a three-dimensional manifold, there are a total of $n^3 = 3^3 = 27$ Christoffel symbols. However, since $Gamma^alpha_(mu nu)$ is symmetric in its lower indices, i.e. $Gamma^alpha_(mu nu) = Gamma^alpha_(nu mu)$, a total of 9 symbols occur twice so that we only need to calculate 18 Christoffel symbols. In $RR^3$, we write the formula for $Gamma^alpha_(mu nu)$ as
$ Gamma^a_(i j) = g^(a k)/2 ((partial g_(j k))/(partial x^i) + (partial g_(i k))/(partial x^j) - (partial g_(i j))/(partial x^k)), quad "where" a, i, j, k in I = {1, 2, 3} "and" x^i = cases(r & "for" i = 1, theta & "for" i = 2, phi & "for" i = 3). $
With this preparation, we calculate the following symbols ($*$ when limited to sphere, $r = "const"$):
#wide[
  $
    Gamma^1_11 & = 1/2 g^(1 k) ((partial g_(1 k))/(partial x^1) + (partial g_(1 k))/(partial x^1) - (partial g_11)/(partial x^k)) = g^(1 k) underbrace((partial g_(1 k))/(partial x^1), 0 "for all" k) - 1/2 g^(1 k) underbrace((partial g_11)/(partial x^k), 0 "for all" k) = 0, \
    Gamma^1_12 & = 1/2 g^(1 k) ((partial g_(2 k))/(partial x^1) + underbrace((partial g_(1 k))/(partial x^2), 0) - underbrace((partial g_12)/(partial x^k), 0)) = 1/2 g^12 (partial g_22)/(partial x^1) = 1/2 dot 0 dot (partial r^2)/(partial r) = 0 dot r = 0 = Gamma^1_21, \
    Gamma^1_13 & = 1/2 g^(1 k) ((partial g_(3 k))/(partial x^1) + underbrace((partial g_(1 k))/(partial x^3), 0) - underbrace((partial g_13)/(partial x^k), 0)) = 1/2 g^13 (partial g_33)/(partial x^1) = 1/2 dot 0 dot (partial r^2 sin^2 theta)/(partial r) = 0 = Gamma^1_31, \
    Gamma^1_22 & = 1/2 g^(1 k) (underbrace((partial g_(2 k))/(partial x^2), 0) + underbrace((partial g_(2 k))/(partial x^2), 0) - (partial g_22)/(partial x^k)) = 1/2 g^11 (-(partial g_22)/(partial x^1)) = -1/2 (-1) (partial r^2)/(partial r) = r quad (Gamma^1_22 seq 0), \
    Gamma^1_23 & = 1/2 g^(1 k) ((partial g_(3 k))/(partial x^2) + underbrace((partial g_(2 k))/(partial x^3), 0) - underbrace((partial g_23)/(partial x^k), 0)) = 1/2 g^13 (partial g_33)/(partial x^2) = 1/2 dot 0 dot (partial r^2 sin^2 theta)/(partial theta) = 0 = Gamma^1_32, \
    Gamma^1_33 & = 1/2 g^(1 k) (underbrace((partial g_(3 k))/(partial x^3), 0) + underbrace((partial g_(3 k))/(partial x^3), 0) - (partial g_33)/(partial x^k)) = -1/2 (g^11 (partial g_33)/(partial x^1) + underbrace(g^12, 0) (partial g_33)/(partial x^2)) = -1/2 (-1) (partial r^2 sin^2 theta)/(partial r) = r sin^2 theta quad (Gamma^1_33 seq 0), \
    Gamma^2_11 & = 1/2 g^(2 k) (underbrace((partial g_(1 k))/(partial x^1), 0) + underbrace((partial g_(1 k))/(partial x^1), 0) - underbrace((partial g_11)/(partial x^k), 0)) = 0, \
    Gamma^2_12 & = 1/2 g^(2 k) ((partial g_(2 k))/(partial x^1) + underbrace((partial g_(1 k))/(partial x^2), 0) - underbrace((partial g_12)/(partial x^k), 0)) = 1/2 g^22 (partial g_22)/(partial x^1) = 1/r = Gamma^2_21 quad (Gamma^2_12 = Gamma^2_21 seq 0), \
    Gamma^2_13 & = 1/2 g^(2 k) ((partial g_(3 k))/(partial x^1) + underbrace((partial g_(1 k))/(partial x^3), 0) - underbrace((partial g_13)/(partial x^k), 0)) = 1/2 g^23 (partial g_33)/(partial x^1) = 1/2 dot 0 dot (partial r^2 sin^2 theta)/(partial r) = 0 = Gamma^2_31, \
    Gamma^2_22 & = 1/2 g^(2 k) (underbrace((partial g_(2 k))/(partial x^2), 0) + underbrace((partial g_(2 k))/(partial x^2), 0) - (partial g_22)/(partial x^k)) = 1/2 g^21 (partial g_22)/(partial x^1) = 1/2 dot 0 dot (partial r^2)/(partial r) = 0, \
    Gamma^2_23 & = 1/2 g^(2 k) ((partial g_(3 k))/(partial x^2) + underbrace((partial g_(2 k))/(partial x^3), 0) - underbrace((partial g_23)/(partial x^k), 0)) = 1/2 g^23 (partial g_33)/(partial x^2) = 1/2 dot 0 dot (partial r^2 sin^2 theta)/(partial theta) = 0 = Gamma^2_32, \
    Gamma^2_33 & = 1/2 g^(2 k) (underbrace((partial g_(3 k))/(partial x^3), 0) + underbrace((partial g_(3 k))/(partial x^3), 0) - (partial g_33)/(partial x^k)) = -1/2 (underbrace(g^21, 0) (partial g_33)/(partial x^1) + g^22 (partial g_33)/(partial x^2)) = -1/2 (-1/r^2) (partial (r^2 sin^2 theta)(-1))/(partial theta) = -sin theta cos theta, \
    Gamma^3_11 & = 1/2 g^(3 k) (underbrace((partial g_(1 k))/(partial x^1), 0) + underbrace((partial g_(1 k))/(partial x^1), 0) - underbrace((partial g_11)/(partial x^k), 0)) = 0, \
    Gamma^3_12 & = 1/2 g^(3 k) ((partial g_(2 k))/(partial x^1) + underbrace((partial g_(1 k))/(partial x^2), 0) - underbrace((partial g_12)/(partial x^k), 0)) = 1/2 underbrace(g^32, 0) (partial g_22)/(partial x^1) = 0 = Gamma^3_21, \
    Gamma^3_13 & = 1/2 g^(3 k) ((partial g_(3 k))/(partial x^1) + underbrace((partial g_(1 k))/(partial x^3), 0) - underbrace((partial g_13)/(partial x^k), 0)) = 1/2 g^33 (partial g_33)/(partial x^1) = 1/2 (-1)/(r^2 sin^2 theta) (partial r^2 sin^2 theta)/(partial r) = -1/r = Gamma^3_31 quad (Gamma^3_13 = Gamma^3_31 seq 0), \
    Gamma^3_22 & = 1/2 g^(3 k) (underbrace((partial g_(2 k))/(partial x^2), 0) + underbrace((partial g_(2 k))/(partial x^2), 0) - (partial g_22)/(partial x^k)) = -1/2 underbrace(g^31, 0) (partial g_22)/(partial x^1) = 0, \
    Gamma^3_23 & = 1/2 g^(3 k) ((partial g_(3 k))/(partial x^2) + underbrace((partial g_(2 k))/(partial x^3), 0) - underbrace((partial g_23)/(partial x^k), 0)) = cot theta = Gamma^3_32, \
    Gamma^3_33 & = 1/2 g^(3 k) (underbrace((partial g_(3 k))/(partial x^3), 0) + underbrace((partial g_(3 k))/(partial x^3), 0) - (partial g_33)/(partial x^k)) = -1/2 g^33 underbrace((partial g_33)/(partial x^3), 0) = 0.
  $
]

#task(label: "c")[
  Write down the equation of motion by using the geodesic equation,
  #tagged(1, $ dot.double(x)^mu + Gamma^mu_(alpha beta) dot(x)^alpha dot(x)^beta = 0 quad ("in" RR^3: dot.double(x)^i + Gamma^i_(a b) dot(x)^a dot(x)^b = 0 "with" i, a, b in I = {1, 2, 3}). $)
]

#wide[
  $
    x^1 = r: & quad dot.double(x)^1 + Gamma^1_(a b) dot(x)^a dot(x)^b = dot.double(x)^1 + Gamma^1_22 dot(x)^2 dot(x)^2 + Gamma^1_33 dot(x)^3 dot(x)^3 = dot.double(r) + r dot(theta)^2 + r sin^2 theta dot(phi)^2 = 0, \
    x^2 = theta: & quad dot.double(x)^2 + Gamma^2_(a b) dot(x)^a dot(x)^b = dot.double(x)^2 + Gamma^2_12 dot(x)^1 dot(x)^2 + Gamma^2_21 dot(x)^2 dot(x)^1 + Gamma^2_33 dot(x)^3 dot(x)^3 = dot.double(theta) + 2/r dot(r) dot(theta) - sin theta cos theta dot(phi)^2 = 0, \
    x^3 = phi: & quad dot.double(x)^3 + Gamma^3_(a b) dot(x)^a dot(x)^b = dot.double(x)^3 + Gamma^3_13 dot(x)^1 dot(x)^3 + Gamma^3_31 dot(x)^3 dot(x)^1 + Gamma^3_23 dot(x)^2 dot(x)^3 + Gamma^3_32 dot(x)^3 dot(x)^2 = dot.double(phi) - 2/r dot(r) dot(phi) + 2 cot theta dot(theta) dot(phi) = 0.
  $
]
When limited to the surface of a sphere, the e.o.m.s simplify to
$ r: dot.double(r) = 0, quad theta: dot.double(theta) - sin theta cos theta dot(phi)^2 = 0, quad phi: dot.double(phi) + 2 cot theta dot(theta) dot(phi) = 0. $

= Problem 3: Weak field I: Equations of motion (10 points)

#task[
  Consider the weak-field limit of general relativity with a central potential $Phi(r) = -1/c^2 (G M)/r$. The line element reads
  $ dif s^2 = (1 + 2 Phi(r)) dif t^2 - (1 - 2 Phi(r)) (dif r^2 + r^2 dif Omega^2), quad "with" dif Omega^2 = dif theta^2 + sin^2 theta dif phi^2. $
]

#task(label: "a")[Find the action $S = -m c integral dd(tau) sqrt(dot(x)_mu dot(x)^mu)$.]

$
  dot(x)^2 & = dot(x)_mu dot(x)^mu = (dif s_mu)/(dif tau) (dif s^mu)/(dif tau) = ((dif s)/(dif tau))^2 = (1 + 2 Phi(r)) ((dif t)/(dif tau))^2 - (1 - 2 Phi(r)) (((dif r)/(dif tau))^2 + r^2 ((dif theta)/(dif tau))^2 + r^2 sin^2 theta ((dif phi)/(dif tau))^2) \
  & = (1 + 2 Phi(r)) dot(t)^2 - (1 - 2 Phi(r)) (dot(r)^2 + r^2 dot(theta)^2 + r^2 sin^2 theta dot(phi)^2), \
  S & = -m c integral dd(tau) [(1 + 2 Phi(r)) dot(t)^2 - (1 - 2 Phi(r)) (dot(r)^2 + r^2 dot(theta)^2 + r^2 sin^2 theta dot(phi)^2)]^(1/2).
$

#task(label: "b")[
  You can now read off a Lagrangian $L$. Why could it also be given as
  $ L = (1 + 2 Phi(r)) dot(t)^2 - (1 - 2 Phi(r)) (dot(r)^2 + r^2 dot(theta)^2 + r^2 sin^2 theta dot(phi)^2)? $
]

We read off $L = -m c [(1 + 2 Phi(r)) dot(t)^2 - (1 - 2 Phi(r)) (dot(r)^2 + r^2 dot(theta)^2 + r^2 sin^2 theta dot(phi)^2)]^(1/2)$.

In exercise 2 of sheet 1, we showed that the e.o.m.s don't change under transformations of the type
$ cal(L)(q, dot(q), t) -> cal(L)'(q, dot(q), t) = alpha cal(L)(q, dot(q), t) + dif/(dif t) f(q, t). $
In our case, $alpha_1 = -m c$ can therefore be dropped. A square also has no effect on the e.o.m.s:
$ 0 attach(=, t: !) delta S = delta integral dd(tau) L = integral dd(tau) delta L quad <==> quad 0 attach(=, t: !) delta S = delta integral dd(tau) sqrt(L) = integral dd(tau) (delta L)/underbrace(2 sqrt(L), alpha_2). $
Applying a variation to $S$, the square root gives just another scaling factor $alpha_2$.

#task(label: "c")[Compute the equations of motion from the Euler-Lagrange equations. (Hint: Only keep terms that are linear in $Phi$ or quadratic in $dot(q)_i$.)]

#wide[
  $
    r: quad & dif/(dif tau) (partial L)/(partial dot(r)) - (partial L)/(partial r) = -dif/(dif tau) [2 (1 - 2 Phi(r)) dot(r)] - 2 (partial Phi(r))/(partial r) dot(t)^2 - 2 (partial Phi(r))/(partial r) (dot(r)^2 + r^2 dot(theta)^2 + r^2 sin^2 theta dot(phi)^2) \
    & #h(2em) + 2 (1 - 2 Phi(r)) r dot(theta)^2 + 2 (1 - 2 Phi(r)) r sin^2 theta dot(phi)^2 = 0 \
    <==> quad & dot.double(r) - (Phi(r) dot(t)^2)/((1 - 2 Phi(r)) r) - Phi(r)/((1 - 2 Phi(r)) r) (dot(r)^2 + r^2 dot(theta)^2 + r^2 sin^2 theta dot(phi)^2) - r dot(theta)^2 - r sin^2 theta dot(phi)^2 - (2 Phi(r))/((1 - 2 Phi(r)) r) dot(r)^2 = 0 \
    <==> quad & dot.double(r) - r dot(theta)^2 - r sin^2 theta dot(phi)^2 - Phi(r)/((1 - 2 Phi(r)) r) (dot(t)^2 - dot(r)^2 + r^2 dot(theta)^2 + r^2 sin^2 theta dot(phi)^2) = 0, \
    theta: quad & dif/(dif tau) (partial L)/(partial dot(theta)) - (partial L)/(partial theta) = -2 dif/(dif tau) ((1 - 2 Phi(r)) r^2 dot(theta)) + 2 (1 - 2 Phi(r)) r^2 sin theta cos theta dot(phi)^2 = 0 \
    <==> quad & 4 (partial Phi(r))/(partial r) dot(r) r^2 dot(theta) - 4 (1 - 2 Phi(r)) r dot(r) dot(theta) - 2 (1 - 2 Phi(r)) r^2 dot.double(theta) + 2 (1 - 2 Phi(r)) r^2 sin theta cos theta dot(phi)^2 = 0 \
    <==> quad & dot.double(theta) + (2 Phi(r) dot(r) dot(theta))/((1 - 2 Phi(r)) r) + 2 dot(r)/r dot(theta) - sin theta cos theta dot(phi)^2 = dot.double(theta) + 2 dot(r)/r dot(theta) (1 - Phi(r))/(1 - 2 Phi(r)) - sin theta cos theta dot(phi)^2 = 0, \
    phi: quad & dif/(dif tau) (partial L)/(partial dot(phi)) - (partial L)/(partial phi) = dif/(dif tau) (-2 (1 - 2 Phi(r)) r^2 sin^2 theta dot(phi)) = 4 (partial Phi(r))/(partial r) dot(r) r^2 sin^2 theta dot(phi) - 4 (1 - 2 Phi(r)) r dot(r) sin^2 theta dot(phi) \
    & #h(2em) - 4 (1 - 2 Phi(r)) r^2 sin theta cos theta dot(theta) dot(phi) - 2 (1 - 2 Phi(r)) r^2 sin^2 theta dot.double(phi) = 0 \
    <==> quad & dot.double(phi) + (2 Phi(r))/((1 - 2 Phi(r)) r) dot(r) dot(phi) + 2 dot(r)/r dot(phi) + 2 cot theta dot(theta) dot(phi) = dot.double(phi) + 2 dot(r)/r dot(phi) (1 - Phi(r))/(1 - 2 Phi(r)) + 2 cot theta dot(theta) dot(phi) = 0.
  $
]
In the above simplifications, we used that $(partial Phi(r))/(partial r) = partial/(partial r) (-(G M)/(c^2 r)) = (G M)/(c^2 r^2) = -Phi(r)/r$.

#task(label: "d")[By identifying your equations of motion with the geodesic equation (1), find all non-trivial Christoffel symbols $Gamma^alpha_(mu nu)$.]

#wide[
$
  x^1 = r: & quad Gamma^1_00 = -Gamma^1_11 = -1/r Phi(r)/(1 + 2 Phi(r)), quad Gamma^1_22 = -r (1 + Phi(r)/(1 + 2 Phi(r))), quad Gamma^1_33 = -r sin^2 theta (1 + Phi(r)/(1 + 2 Phi(r))), \
  x^2 = theta: & quad Gamma^2_12 = Gamma^2_21 = 1/r (1 - Phi(r))/(1 - 2 Phi(r)), quad Gamma^2_33 = -sin theta cos theta, \
  x^3 = phi: & quad Gamma^3_13 = Gamma^3_31 = 1/r (1 - Phi(r))/(1 - 2 Phi(r)), quad Gamma^3_23 = Gamma^3_32 = cot theta, quad "all other Christoffel symbols zero."
$
]

= Problem 4: Weak field II: Let's lens like it's 1919 (10 points)

#task[
  We've seen that in a weak-field limit, the metric tensor can be written as
  #tagged(2, $ g_(mu nu) = mat(1 + (2 Phi)/c^2, 0, 0, 0; 0, -(1 - (2 Phi)/c^2), 0, 0; 0, 0, -(1 - (2 Phi)/c^2), 0; 0, 0, 0, -(1 - (2 Phi)/c^2)), $)
  where $Phi$ is the Newtonian gravitational potential. From this, and from Fermat's principle, we're going to derive the correct gravitational lensing deflection angle after having seen the Newtonian case on practice sheet 1.
]

#task(label: "a")[What are the assumptions that go into finding this limit?]

The metric in eq. (2) can be derived in the limit of slowly moving particles ($v << c$) and a weak (gravitational) field by employing the 'infinitesimal' Ansatz
$ g_(mu nu) = eta_(mu nu) + h_(mu nu), quad "where" |h_(mu nu)| << 1. $

#task[Write down the line element $dif s^2 = g_(mu nu) dif x^mu dif x^nu$ in Cartesian coordinates $(c t, x, y, z)$.]

$ dif s^2 = (1 + 2 Phi\/c^2) c^2 dif t^2 - (1 - 2 Phi\/c^2) (dif x^2 + dif y^2 + dif z^2) = (1 + 2 Phi\/c^2) c^2 dif t^2 - (1 - 2 Phi\/c^2) dif arrow(x)^2. $

#task(label: "b")[What special sort of geodesics do light rays follow, i.e. what value does $dif s$ have for light?]

Light rays follow null geodesics, i.e. $dif s = sqrt(dif s^2) = 0$.

#task(label: "c")[
  From part b), you can infer the effective velocity of the light ray in the gravitational field, $c' = (dif arrow(x))/(dif t)$. Approximate it, using that for $a << 1$,
  $ sqrt(1 + a)\/sqrt(1 - a) approx (1 + a). $
  The refractive index, $n = c/c'$, can now be written down. Use $(1 + a)^(-1) approx 1 - a$.
]

$
  0 attach(=, t: !) dif s^2 = [(1 + 2 Phi\/c^2) c^2 - (1 - 2 Phi\/c^2) underbrace((dif arrow(x)^2)/(dif t^2), c'^2)] dif t^2 quad & ==> quad c' = sqrt((1 + 2 Phi\/c^2)/(1 - 2 Phi\/c^2)) c approx (1 + 2 Phi\/c^2) c, \
  n = c/c' = c/((1 + 2 Phi\/c^2) c) approx 1 - 2 Phi\/c^2.
$

#task(label: "d")[
  Fermat's principle states that light takes an optically extremal path, i.e.
  $ delta integral dd(l) thin n(arrow(x)(l)) = 0. $
  We can write $dif l = |(dif arrow(x))/(dif lambda)| dif lambda = |dot(arrow(x))| dif lambda$, where we defined $dot(arrow(x)) := dif arrow(x)\/dif lambda$. Put this into Fermat's principle, which should look like the variation of an action to you now,
  $ delta integral dd(t) L(arrow(x), dot(arrow(x)), t) = 0. $
  What is the 'Lagrangian' $L(arrow(x), dot(arrow(x)), lambda)$ in our case?
]

$ delta integral dd(l) thin n(arrow(x)(l)) = delta integral dd(lambda) |dot(arrow(x))| n(arrow(x)(lambda)) = 0 quad ==> quad L(arrow(x), dot(arrow(x)), lambda) = |dot(arrow(x))| n = |dot(arrow(x))(lambda)| n(arrow(x)(lambda)). $

#task(label: "e")[
  Show that applying the Euler-Lagrange eqs.
  $ dif/(dif lambda) (partial L)/(partial dot(arrow(x))) = (partial L)/(partial arrow(x)) $
  yields something of the form
  #tagged(3, $ dif/(dif lambda) (n arrow(e)_(dot(x))) = (arrow(nabla) n) |dot(arrow(x))|, $)
  where $arrow(nabla) n equiv partial/(partial arrow(x)) n$ and $arrow(e)_(dot(x))$ is the unit vector pointing in $dot(arrow(x))$-direction. We can set $|dot(arrow(x))| = 1$ for simplicity because the scale of $lambda$ is arbitrary.
]

$
  dif/(dif lambda) (partial L)/(partial dot(arrow(x))) & = dif/(dif lambda) underbrace(partial/(partial dot(arrow(x))), arrow(e)_(dot(x)) partial\/partial |dot(arrow(x))|) (|dot(arrow(x))(lambda)| n(arrow(x)(lambda))) = dif/(dif lambda) (arrow(e)_(dot(x)) n(arrow(x)(lambda))), quad (partial L)/(partial arrow(x)) = partial/(partial arrow(x)) (|dot(arrow(x))(lambda)| n(arrow(x)(lambda))) = (arrow(nabla) n) |dot(arrow(x))| \
  & ==> quad dif/(dif lambda) (n arrow(e)_(dot(x))) = (arrow(nabla) n) |dot(arrow(x))|.
$

#task(label: "f")[
  Simplify eq. (3) to the form (Hint: $dif/(dif lambda) n = (partial n)/(partial arrow(x)) (dif arrow(x))/(dif lambda)$. Also use that $|dot(arrow(x))| = 1$, thus $dot(arrow(x)) = arrow(e)_(dot(x))$.)
  $ n dot(arrow(e))_(dot(x)) = arrow(nabla) n - arrow(e)_(dot(x)) (arrow(nabla) n dot arrow(e)_(dot(x))). $
]

$ dif/(dif lambda) (n arrow(e)_(dot(x))) = (dif n)/(dif lambda) arrow(e)_(dot(x)) + n (dif arrow(e)_(dot(x)))/(dif lambda) = ((partial n)/(partial arrow(x)) dot (dif arrow(x))/(dif lambda)) arrow(e)_(dot(x)) + n dot(arrow(e))_(dot(x)) = (arrow(nabla) n dot dot(arrow(x))) arrow(e)_(dot(x)) + n dot(arrow(e))_(dot(x)) = arrow(e)_(dot(x)) (arrow(nabla) n dot arrow(e)_(dot(x))) + n dot(arrow(e))_(dot(x)). $
Subtracting the first product-rule term to the left of eq. (3), we get: $n dot(arrow(e))_(dot(x)) = arrow(nabla) n - arrow(e)_(dot(x)) (arrow(nabla) n dot arrow(e)_(dot(x)))$.

#task(label: "g")[
  Since the right-hand side is subtracting the light-ray direction of $arrow(nabla) n$ from $arrow(nabla) n$, the only remaining part is the one perpendicular to the ray, $arrow(nabla)_perp n$, such that
  $ dot(arrow(e))_(dot(x)) = 1/n arrow(nabla)_perp n = arrow(nabla)_perp ln n. $
  Plug in $n$ from part c) and use $ln(1 - a) approx -a$. What do you get for $dot(arrow(e))_(dot(x))$?
]

$ dot(arrow(e))_(dot(x)) = arrow(nabla)_perp ln n = arrow(nabla)_perp ln(1 - 2 Phi\/c^2) approx arrow(nabla)_perp (-2 Phi\/c^2) = -2/c^2 arrow(nabla)_perp Phi. $

#task(label: "h")[The deflection angle is given by $hat(alpha) = integral dd(lambda) (-dot(arrow(e))_(dot(x)))$. What do you get if you use your knowledge of $dot(arrow(e))_(dot(x))$ from part g)?]

$ hat(alpha) = integral dd(lambda) (-dot(arrow(e))_(dot(x))) = integral dd(lambda) 2/c^2 arrow(nabla)_perp Phi = 2/c^2 integral dd(lambda) arrow(nabla)_perp Phi. $

#task(label: "i")[
  Your resulting integral can be cumbersome, since we would have to continuously integrate over the light path. However, since we assume the deflection angle $hat(alpha)$ to be small, we can use the Born approximation from scattering theory, introducing the impact parameter $xi$, and integrating over the unperturbed path
  $ hat(alpha)(xi) = 2/c^2 integral_(-oo)^oo dd(lambda) arrow(nabla)_perp Phi. $
  For simplicity, we assume that $xi$ lies in the $x$-$y$-plane. Then the distance to a point-like mass at the origin is $r^2 = xi^2 + lambda^2$ (because $lambda$ is evaluated at the unperturbed path). Taking $Phi = -(G M)/r$, we get $arrow(nabla)_perp Phi = (G M)/r^3 xi$ and thus for the deflection angle
  $ hat(alpha)(xi) = (2 G M)/c^2 xi integral_(-oo)^oo dd(lambda) 1/r^3. $
  Evaluate the integral. $hat(alpha)(xi)$ is then the fully relativistic gravitational lensing deflection angle.
]

First we reproduce $arrow(nabla)_perp Phi$:
$ arrow(nabla)_perp Phi = arrow(nabla)_perp (-(G M)/r) = (G M)/r^2 arrow(nabla)_perp r = (G M)/r^2 underbrace(arrow(nabla)_perp, hat(=) dif\/dif xi) sqrt(xi^2 + lambda^2) = (G M)/r^2 (2 xi)/(2 underbrace(sqrt(xi^2 + lambda^2), r)) = (G M)/r^3 xi. $
We now move on to evaluate the integral using substitution,
$ I := integral_(-oo)^oo dd(lambda) 1/r^3 = integral_(-oo)^oo dd(lambda) 1/(xi^2 + lambda^2)^(3\/2). $
We know all occurring values to be positive so that we may substitute
$ lambda = xi tan(u), quad dif lambda = xi/(cos^2 u) dif u, quad u(lambda = oo) = arctan(oo/xi) = pi/2, quad u(lambda = -oo) = arctan((-oo)/xi) = -pi/2, $
giving the integrand $(xi^2 + lambda^2)^(-3\/2) = (xi^2 + xi^2 tan^2 u)^(-3\/2) = 1/xi^3 (1 + tan^2 u)^(-3\/2) = 1/xi^3 cos^3 u$. Therefore,
$ I = integral_(-oo)^oo dd(lambda) 1/(xi^2 + lambda^2)^(3\/2) = integral_(-pi\/2)^(pi\/2) dd(u) xi/(cos^2 u) 1/xi^3 cos^3 u = 1/xi^2 integral_(-pi\/2)^(pi\/2) cos u dif u = 1/xi^2 sin u |_(-pi\/2)^(pi\/2) = 2/xi^2. $
Consequently, the relativistic lensing deflection angle $hat(alpha)(xi)$ is given by
$ hat(alpha)(xi) = (2 G M)/c^2 xi I = (2 G M)/c^2 xi 2/xi^2 = (4 G M)/(c^2 xi). $

= Problem 5: Extra question: Sym-Metric (5 points)

#task[Why does the metric tensor $g_(mu nu)$ necessarily have to be symmetric? What implications would asymmetry have on the equations of motion?]

As soon as one has a concept of distance, one can define an inner product and from this the metric follows and inherits its symmetry. Since $x dot y = y dot x$, we can require
$ x dot y = g_(mu nu) x^mu y^nu attach(=, t: !) g_(nu mu) y^nu x^mu = y dot x quad ==> quad g_(mu nu) = g_(nu mu). $
