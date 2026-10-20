#import "/notes.typ": notes, task
#import "@preview/cetz:0.5.2": canvas, draw

#show: notes.with(
  title: [General Relativity -- Exercise Sheet 2],
  subtitle: [Exercise sheet 2, General Relativity, Prof. Björn Schäfer],
  date: [Solutions by Janosh Riebesell, 25.04.2015],
)

// block-diagonal 4x4 boost matrix with upper-left 2x2 block (a, b; c, d)
#let blk(a, b, c, d) = $mat(display(mat(delim: #none, #a, #b ; #c, #d)), bb(0)_2; bb(0)_2, bb(1)_2)$
// index set {0,1,2,3} under a component matrix
#let idx(..i) = $#i.pos().join($,$) in {0, 1, 2, 3}$
// dashed underline marking a second group of cancelling terms
#let dashu(body) = underline(stroke: (thickness: 0.5pt, dash: "dashed"), offset: 3pt, body)
// smaller type for very wide matrices
#let wide(body) = {
  set text(size: 9pt)
  body
}
#let tiny(body) = {
  set text(size: 7.5pt)
  body
}

= Problem 1: Lorentz transformations and group theory (10 points)

#task[
  Four-vectors mark events (or points) in spacetime and are denoted with greek indices, $x^mu$, where $mu in {0, 1, 2, 3}$. Scalar products are defined as
  $ x dot y := x_mu y^mu = eta_(mu nu) x^mu y^nu $
  and the norm of a vector $x^mu$ in Minkowski space as
  $ |x|^2 = x dot x = x_mu x^mu = eta_(mu nu) x^mu x^nu. $
  We call the diagonal matrix $eta_(mu nu)$ with $"diag"(eta) = (1, -1, -1, -1)$ the Minkowski metric. Lorentz transformations act upon four-vectors, transforming an event $x$ into a new frame of reference $x'$ via
  $ x'^mu = Lambda^mu_nu x^nu. $
]

#task(label: "a")[By requiring that $|x'|^2 attach(=, t: !) |x|^2$, how does $eta_(mu nu)$ transform?]

$
  |x'|^2 & = x' dot x' = x'_mu x'^mu = eta_(mu nu) x'^mu x'^nu = eta_(mu nu) Lambda^mu_rho x^rho Lambda^nu_sigma x^sigma \
  & = Lambda^mu_rho Lambda^nu_sigma eta_(mu nu) x^rho x^sigma attach(=, t: !) eta_(rho sigma) x^rho x^sigma = x_rho x^rho = x dot x = |x|^2 \
  & ==> quad eta_(rho sigma) = Lambda^mu_rho Lambda^nu_sigma eta_(mu nu).
$

#task(label: "b")[
  Let's see if Lorentz boosts form a group. A group is defined as a set $G$ that has an operation $chevron.l a, b chevron.r$ $forall a, b in G$ with the following conditions:
  + $forall a, b in G: chevron.l a, b chevron.r in G$ (closure)
  + $forall a, b, c in G: chevron.l chevron.l a, b chevron.r, c chevron.r = chevron.l a, chevron.l b, c chevron.r chevron.r$ (associativity)
  + $exists! e in G: chevron.l e, a chevron.r = a$ $forall a in G$ (identity element)
  + $exists! a^(-1) in G: chevron.l a, a^(-1) chevron.r = e$ $forall a in G$ (inverse element)
  Show that the simplest Lorentz boosts, i.e. along only one axis (here $x$)
  $ Lambda(psi) = #blk($cosh psi$, $-sinh psi$, $-sinh psi$, $cosh psi$) $
  with the rapidity $psi = "arctanh"(v/c)$, fulfills the requirements of a group, the operation being matrix multiplication. For simplicity, don't worry about uniqueness of the identity $e$ and the inverse $a^(-1)$.
]

*1. closure*
#wide[
  $
    Lambda(psi_1) Lambda(psi_2) & = #blk($cosh psi_1$, $-sinh psi_1$, $-sinh psi_1$, $cosh psi_1$) #blk($cosh psi_2$, $-sinh psi_2$, $-sinh psi_2$, $cosh psi_2$) \
    & = #blk($cosh psi_1 cosh psi_2 + sinh psi_1 sinh psi_2$, $-cosh psi_1 sinh psi_2 - sinh psi_1 cosh psi_2$, $-sinh psi_1 cosh psi_2 - cosh psi_1 sinh psi_2$, $sinh psi_1 sinh psi_2 + cosh psi_1 cosh psi_2$) \
    & = #blk($cosh(psi_1 + psi_2)$, $-sinh(psi_1 + psi_2)$, $-sinh(psi_1 + psi_2)$, $cosh(psi_1 + psi_2)$) = Lambda(psi_1 + psi_2) in "SO"(1, 3).
  $
]

*2. associativity* \
The associativity of the $"SO"(1, 3)$ Lorentz group follows directly from the associativity of the matrix multiplication, that is for any three matrices, $A, B, C$, be they elements of the Lorentz group or not, it holds that
$ (A B) C = A (B C). $

*3. identity element* \
The identity element is obviously unity, i.e. $Lambda(0)$. This follows from our proof of closure: $Lambda(psi) Lambda(0) = Lambda(psi + 0) = Lambda(psi)$.

*4. inverse element* \
Again, from the proof of closure it follows that the inverse of an element $Lambda(psi)$ of $("SO"(1, 3))$ is given by $Lambda(-psi)$,
$ Lambda(psi) Lambda(-psi) = Lambda(psi - psi) = Lambda(0), quad "with" quad Lambda(0) = #blk($cosh 0$, $-sinh 0$, $-sinh 0$, $cosh 0$) = bb(1)_4. $

#task(label: "c")[A group is called abelian if $chevron.l a, b chevron.r = chevron.l b, a chevron.r$. Is the group of Lorentz boosts abelian? Extra question: Is the group of rotations in $RR^3$ abelian? (Think Euler angles.)]

Yes, the group of Lorentz boosts is abelian, simply because every one-dimensional exponentiation of a generator $G$ forms an abelian group since $e^(a G) e^(b G) = e^((a + b) G) = e^((b + a) G) = e^(b G) e^(a G)$.

One may also argue more specifically by yet again resorting to our proof of closure,
$ Lambda(psi_1) Lambda(psi_2) = Lambda(psi_1 + psi_2) = Lambda(psi_2 + psi_1) = Lambda(psi_2) Lambda(psi_1). $

Extra answer: The group of rotations in $RR^3$ is not abelian. It cannot be created by one-dimensional exponentiation of a generator. A visual proof would be to imagine a cylinder and rotate it twice around different axes; the order of the axes makes a difference.

#align(center, canvas(length: 1cm, {
  import draw: *
  set-style(stroke: 0.6pt)
  // cylinder lying along x, seen from the side
  let lying(x, y) = {
    rect((x, y - 0.25), (x + 1.6, y + 0.25))
    circle((x, y), radius: (0.1, 0.25), fill: white)
    circle((x + 1.6, y), radius: (0.1, 0.25))
  }
  // cylinder standing upright
  let standing(x, y, axis: false) = {
    rect((x - 0.25, y - 0.8), (x + 0.25, y + 0.8))
    circle((x, y + 0.8), radius: (0.25, 0.1), fill: white)
    if axis { line((x, y - 1), (x, y + 1.15), stroke: (dash: "dashed")) }
  }
  let arr(x, y) = line((x, y), (x + 1.1, y), mark: (end: ">"))
  let rot(pt, label) = content(pt, text(8pt)[#sym.arrow.ccw#super[#label]])
  // row 1: rotate about the vertical axis first, then about the viewing axis
  lying(0, 1.5)
  rot((0.8, 2.05), $pi\/2$)
  arr(2.1, 1.5)
  circle((4, 1.5), radius: 0.25)
  content((4, 1.5), text(7pt)[#sym.arrow.ccw])
  content((4, 2.05), text(8pt)[$pi\/2$])
  arr(4.7, 1.5)
  circle((6.6, 1.5), radius: 0.25)
  // row 2: rotate about the viewing axis first, then about the vertical axis
  lying(0, -0.5)
  content((0.8, -0.5), text(7pt)[#sym.arrow.ccw])
  content((0.8, 0.05), text(8pt)[$pi\/2$])
  arr(2.1, -0.5)
  standing(4, -0.5, axis: true)
  rot((4.45, 0.55), $pi\/2$)
  arr(4.7, -0.5)
  standing(6.6, -0.5)
}))

#task(label: "d")[Write down $Lambda$ in the form $Lambda = exp(psi L)$. $L$ is called the generator of the group. What is $L$ for the Lorentz transform along the $x$-axis?]

The $x$-axis boost generator can be derived by calculating an infinitesimal boost.
$
  Lambda(psi) & = #blk($cosh psi$, $-sinh psi$, $-sinh psi$, $cosh psi$) = mat(1, -psi, , ; -psi, 1, , ; , , 1, ; , , , 1) + cal(O)(psi^2) \
  & = mat(1, , , ; , 1, , ; , , 1, ; , , , 1) - psi mat(, 1, , ; 1, , , ; , , , ; , , , ) + cal(O)(psi^2) = bb(1)_4 - psi mat(, 1, , ; 1, , , ; , , , ; , , , ) + cal(O)(psi^2).
$
Comparing this result with an expansion of $Lambda(psi) = exp(psi L)$,
$ Lambda(psi) = 1 + psi L + cal(O)(psi^2), $
we find that the $x$-axis boost generator $L$ is given by the matrix
$ L = -mat(0, 1, 0, 0; 1, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, 0). $

= Problem 2: Journey to Kepler-438b (10 points)

#task[Kepler-438b is the catchy name astronomers chose for one of the most Earth-like exoplanets found to date. Its host star lies in the constellation of Lyra, about $d approx 145 "pc" approx 470 "ly"$ from Earth.]

#task(label: "a")[If we had a spaceship that could do the journey there, at what speed would it need to travel in order to arrive in 470 years, as the crew experience it (i.e. in their proper time)? How about 47 years?]

$
  v_470 & = s/tau_470 = (1/gamma d)/tau_470 = sqrt(1 - v_470^2/c^2) underbrace(d/tau_470, c) = sqrt(c^2 - v_470^2) & quad ==> quad v_470 & = c/sqrt(2) approx 0.7071 c, \
  v_47 & = s/tau_47 = (1/gamma d)/tau_47 = sqrt(1 - v_47^2/c^2) underbrace(d/tau_47, 10 c) = 10 sqrt(c^2 - v_47^2) & quad ==> quad v_47 & = c/sqrt(1 + 1/100) approx 0.9950 c.
$

#task(label: "b")[Imagine the ship was travelling at $v = 0.9 c$. What speed $w$ would the ship travel at if the captain ordered the ship to increase its velocity by $u = 0.1 c$?]

$ w = (u + v)/(1 + (u v)/c^2) = c/(1 + (0.09 c^2)/c^2) approx 0.9174 c. $

#task(label: "c")[If the ship was of length $L$ in its comoving frame, what length $L'$ would a resting observer measure?]

The resting observer would perceive the moving spaceship as contracted, i.e. $L' < L$. More precisely, depending on the spaceship's velocity $v$, it would shrink in length by a factor of $1/gamma$:
$ L' = 1/gamma L = sqrt(1 - v^2/c^2) L. $

#task(label: "d")[The crew's communication with home was decided to be on a specific electromagnetic frequency $f$. What frequency $f'$ do they need to tune into in order to receive signals from a (resting) sender on Earth?]

Source and receiver are moving away from each other with (positive) velocity $v$. Occupying the source's reference frame, we know that every time a wavefront arrives at the receiver, the subsequent wavefront is at a distance equal to the wavelength $lambda = c/f$. To reach the receiver, however, it needs to travel a distance of $lambda + v t = c t$. Solving for $t$, we get
$ t = lambda/(c - v) = c/((c - v) f) = 1/((1 - beta) f). $
Due to time dilation, the receiver will measure the time $t$ between two wavefronts as $t' = t/gamma$. Simplifying this expression, we get
$ f' = 1/t' = gamma/t = ((1 - beta) f)/sqrt(1 - v^2/c^2) = (1 - beta)/sqrt((1 - beta)(1 + beta)) f = sqrt((1 - beta)/(1 + beta)) f. $

= Problem 3: Boosting the Field Tensor (10 points)

#task[
  The electromagnetic field tensor $F^(mu nu)$ can be written as
  $ F^(mu nu) = mat(0, -E_1\/c, -E_2\/c, -E_3\/c; E_1\/c, 0, -B_3, B_2; E_2\/c, B_3, 0, -B_1; E_3\/c, -B_2, B_1, 0), $
  with the electromagnetic field components $E_i$ and $B_i$, $i in {1, 2, 3}$.
]

#task(label: "a")[Calculate $F_(mu nu)$.]

#wide[
  $
    {F_(mu nu)}_(#idx($mu$, $nu$)) & = {eta_(mu rho)}_(#idx($mu$, $rho$)) underbrace({eta_(nu sigma)}_(#idx($nu$, $sigma$)) {F^(rho sigma)}_(#idx($rho$, $sigma$)), ) \
    & = mat(1, , , ; , -1, , ; , , -1, ; , , , -1)_(mu rho) underbrace(mat(1, , , ; , -1, , ; , , -1, ; , , , -1)_(nu sigma) mat(0, -E_1\/c, -E_2\/c, -E_3\/c; E_1\/c, 0, -B_3, B_2; E_2\/c, B_3, 0, -B_1; E_3\/c, -B_2, B_1, 0)_(rho sigma), ) \
    & = mat(1, , , ; , -1, , ; , , -1, ; , , , -1)_(mu rho) mat(0, E_1\/c, E_2\/c, E_3\/c; E_1\/c, 0, B_3, -B_2; E_2\/c, -B_3, 0, B_1; E_3\/c, B_2, -B_1, 0)_(rho nu) = mat(0, E_1\/c, E_2\/c, E_3\/c; -E_1\/c, 0, -B_3, B_2; -E_2\/c, B_3, 0, -B_1; -E_3\/c, -B_2, B_1, 0)_(mu nu).
  $
]

#task(label: "b")[Boost $F^(mu nu)$ with the Lorentz transform $Lambda_mu^nu$ from exercise 1 to get $F'^(rho sigma) = Lambda^rho_mu Lambda^sigma_nu F^(mu nu)$.]

#wide[
  $
    {F'^(rho sigma)}_(#idx($rho$, $sigma$)) & = {Lambda^rho_mu (psi_2)}_(#idx($rho$, $mu$)) {Lambda^sigma_nu (psi_1)}_(#idx($sigma$, $nu$)) {F^(mu nu)}_(#idx($mu$, $nu$)) \
    & = mat(cosh psi_2, -sinh psi_2, 0, 0; -sinh psi_2, cosh psi_2, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1)_(rho mu) mat(cosh psi_1, -sinh psi_1, 0, 0; -sinh psi_1, cosh psi_1, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1)_(sigma nu) mat(0, -E_1\/c, -E_2\/c, -E_3\/c; E_1\/c, 0, -B_3, B_2; E_2\/c, B_3, 0, -B_1; E_3\/c, -B_2, B_1, 0)_(mu nu) \
    & = mat(cosh psi_2, -sinh psi_2, 0, 0; -sinh psi_2, cosh psi_2, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1)_(rho mu) mat(
      E_1\/c sinh psi_1, -E_1\/c cosh psi_1, -E_2\/c, -E_3\/c;
      E_1\/c cosh psi_1, -E_1\/c sinh psi_1, -B_3, B_2;
      E_2\/c cosh psi_1 - B_3 sinh psi_1, -E_2\/c sinh psi_1 + B_3 cosh psi_1, 0, -B_1;
      E_3\/c cosh psi_1 + B_2 sinh psi_1, -E_3\/c sinh psi_1 - B_2 cosh psi_1, B_1, 0
    )_(mu sigma)
  $
]
#tiny[
  $
    = mat(
      E_1\/c sinh psi_1 cosh psi_2 - E_1\/c cosh psi_1 sinh psi_2, -E_1\/c cosh psi_1 cosh psi_2 + E_1\/c sinh psi_1 sinh psi_2, -E_2\/c cosh psi_2 + B_3 sinh psi_2, -E_3\/c cosh psi_2 - B_2 sinh psi_2;
      -E_1\/c sinh psi_1 sinh psi_2 + E_1\/c cosh psi_1 cosh psi_2, E_1\/c cosh psi_1 sinh psi_2 - E_1\/c sinh psi_1 cosh psi_2, E_2\/c sinh psi_2 - B_3 cosh psi_2, E_3\/c sinh psi_2 + B_2 cosh psi_2;
      E_2\/c cosh psi_1 - B_3 sinh psi_1, -E_2\/c sinh psi_1 + B_3 cosh psi_1, 0, -B_1;
      E_3\/c cosh psi_1 + B_2 sinh psi_1, -E_3\/c sinh psi_1 - B_2 cosh psi_1, B_1, 0
    )_(rho sigma)
  $
]
#tiny[
  $
    & = mat(
      E_1\/c sinh(psi_1 - psi_2), -E_1\/c cosh(psi_1 - psi_2), -E_2\/c cosh psi_2 + B_3 sinh psi_2, -E_3\/c cosh psi_2 - B_2 sinh psi_2;
      E_1\/c cosh(psi_1 - psi_2), -E_1\/c sinh(psi_1 - psi_2), E_2\/c sinh psi_2 - B_3 cosh psi_2, E_3\/c sinh psi_2 + B_2 cosh psi_2;
      E_2\/c cosh psi_1 - B_3 sinh psi_1, -E_2\/c sinh psi_1 + B_3 cosh psi_1, 0, -B_1;
      E_3\/c cosh psi_1 + B_2 sinh psi_1, -E_3\/c sinh psi_1 - B_2 cosh psi_1, B_1, 0
    )_(rho sigma) \
    & attach(=, t: psi_1 = psi_2 = psi) mat(
      0, -E_1\/c, -E_2\/c cosh psi + B_3 sinh psi, -E_3\/c cosh psi - B_2 sinh psi;
      E_1\/c, 0, E_2\/c sinh psi - B_3 cosh psi, E_3\/c sinh psi + B_2 cosh psi;
      E_2\/c cosh psi - B_3 sinh psi, -E_2\/c sinh psi + B_3 cosh psi, 0, -B_1;
      E_3\/c cosh psi + B_2 sinh psi, -E_3\/c sinh psi - B_2 cosh psi, B_1, 0
    )_(rho sigma).
  $
]

#task(label: "c")[What are the new electric and magnetic fields $E'_i$ and $B'_i$, $i in {1, 2, 3}$?]

By inspecting the field tensor, we find that
$
  E'_1 & = E_1, & quad E'_2 & = E_2 cosh psi - c B_3 sinh psi, & quad E'_3 & = E_3 cosh psi + c B_2 sinh psi, \
  B'_1 & = B_1, & quad B'_2 & = B_2 cosh psi + E_3/c sinh psi, & quad B'_3 & = B_3 cosh psi - E_2/c sinh psi.
$

#task(label: "d")[Calculate $F_(mu nu) F^(mu nu)$ and $F'_(rho sigma) F'^(rho sigma)$. By how much do they differ?]

#wide[
  $
    {F_(mu nu)}_(#idx($mu$, $nu$)) {F^(mu nu)}_(#idx($mu$, $nu$)) & = mat(0, E_1\/c, E_2\/c, E_3\/c; -E_1\/c, 0, -B_3, B_2; -E_2\/c, B_3, 0, -B_1; -E_3\/c, -B_2, B_1, 0)_(mu nu) mat(0, -E_1\/c, -E_2\/c, -E_3\/c; E_1\/c, 0, -B_3, B_2; E_2\/c, B_3, 0, -B_1; E_3\/c, -B_2, B_1, 0)_(mu nu) \
    & = mat(
      -E_1^2\/c^2 - E_2^2\/c^2 - E_3^2\/c^2, B_3 E_2\/c - B_2 E_3\/c, -B_3 E_1\/c + B_1 E_3\/c, B_2 E_1\/c - B_1 E_2\/c;
      -B_3 E_2\/c + B_2 E_3\/c, -E_1^2\/c^2 + B_3^2 + B_2^2, -E_1 E_2\/c^2 - B_1 B_2, -E_1 E_3\/c^2 - B_1 B_3;
      B_3 E_1\/c - B_1 E_3\/c, -E_1 E_2\/c^2 - B_1 B_2, -E_2^2\/c^2 + B_3^2 + B_1^2, -E_2 E_3\/c^2 - B_2 B_3;
      -B_2 E_1\/c + B_1 E_2\/c, -E_1 E_3\/c^2 - B_1 B_3, -E_2 E_3\/c^2 - B_2 B_3, -E_3^2\/c^2 + B_2^2 + B_1^2
    )_(mu rho) \
    & = -E_1^2/c^2 - E_2^2/c^2 - E_3^2/c^2 - E_1^2/c^2 + B_3^2 + B_2^2 - E_2^2/c^2 + B_3^2 + B_1^2 - E_3^2/c^2 + B_2^2 + B_1^2 \
    & = 2 (B_1^2 + B_2^2 + B_3^2 - 1/c^2 (E_1^2 + E_2^2 + E_3^2)) = 2 (arrow(B)^2 - arrow(E)^2/c^2).
  $
]

For the boosted tensor, the diagonal entries $D_rho$ of the product are
#wide[
  $
    D_0 & = -E_1^2/c^2 - (E_2/c cosh psi + B_3 sinh psi)^2 - (E_3/c cosh psi - B_2 sinh psi)^2, \
    D_1 & = -E_1^2/c^2 + (E_2/c sinh psi - B_3 cosh psi)^2 + (E_3/c sinh psi + B_2 cosh psi)^2, \
    D_2 & = -(E_2/c cosh psi - B_3 sinh psi)^2 + (E_2/c sinh psi + B_3 cosh psi)^2 + B_1^2, \
    D_3 & = -(E_3/c cosh psi + B_2 sinh psi)^2 + (E_3/c sinh psi - B_2 cosh psi)^2 + B_1^2,
  $
]
so that
#wide[
  $
    & {F'_(rho sigma)}_(#idx($rho$, $sigma$)) {F'^(rho sigma)}_(#idx($rho$, $sigma$)) = mat(D_0, bullet, bullet, bullet; bullet, D_1, bullet, bullet; bullet, bullet, D_2, bullet; bullet, bullet, bullet, D_3)_(rho rho) \
    & = -E_1^2/c^2 - E_2^2/c^2 cosh^2 psi - underline(2 E_2/c B_3 cosh psi sinh psi) - B_3^2 sinh^2 psi - E_3^2/c^2 cosh^2 psi + #dashu($2 E_3/c B_2 cosh psi sinh psi$) \
    & quad - B_2^2 sinh^2 psi - E_1^2/c^2 + E_2^2/c^2 sinh^2 psi - underline(2 E_2/c B_3 sinh psi cosh psi) + B_3^2 cosh^2 psi + E_3^2/c^2 sinh^2 psi \
    & quad + #dashu($2 E_3/c B_2 sinh psi cosh psi$) + B_2^2 cosh^2 psi - E_2^2/c^2 cosh^2 psi + underline(2 E_2/c B_3 cosh psi sinh psi) \
    & quad - B_3^2 sinh^2 psi + E_2^2/c^2 sinh^2 psi + underline(2 E_2/c B_3 sinh psi cosh psi) + B_3^2 cosh^2 psi + B_1^2 \
    & quad - E_3^2/c^2 cosh^2 psi - #dashu($2 E_3/c B_2 cosh psi sinh psi$) - B_2^2 sinh^2 psi + E_3^2/c^2 sinh^2 psi - #dashu($2 E_3/c B_2 cosh psi sinh psi$) \
    & quad + B_2^2 cosh^2 psi + B_1^2 \
    & = -2 E_1^2/c^2 - 2 (E_2^2/c^2 underbrace((cosh^2 psi - sinh^2 psi), 1)) - 2 (E_3^2/c^2 underbrace((cosh^2 psi - sinh^2 psi), 1)) + 2 B_1^2 \
    & quad + 2 B_2^2 underbrace((cosh^2 psi - sinh^2 psi), 1) + 2 B_3^2 underbrace((cosh^2 psi - sinh^2 psi), 1) = 2 (B_1^2 + B_2^2 + B_3^2 - 1/c^2 (E_1^2 + E_2^2 + E_3^2)) \
    & = 2 (arrow(B)^2 - arrow(E)^2/c^2) = {F_(mu nu)}_(#idx($mu$, $nu$)) {F^(mu nu)}_(#idx($mu$, $nu$)).
  $
]
As was to be expected since $F_(mu nu) F^(mu nu)$ and $F'_(rho sigma) F'^(rho sigma)$ are Lorentz scalars, they do not differ.

= Problem 4: Electronics in moving frames (10 points)

#task[Consider a quadratic capacitor (side length $a$) with capacity $C = epsilon_0 epsilon_r a^2/d$. It is now moving along one of its plate axes with $v > 0$.]

#task(label: "a")[Does the capacity change? By what amount?]

Assuming that the relative permittivity $epsilon_r$ is not affected by a change of reference frame (not realistic), the only thing about the system that changes under transformation to a moving frame are the dimensions of the capacitor in the direction of movement, i.e. in this case $d$. The plate separation undergoes a length contraction by $d' = d/gamma$ when switching to the moving frame, thereby increasing the capacity $C$ by a factor of $gamma$:
$ C' = epsilon_0 epsilon_r a^2/d' = epsilon_0 epsilon_r a^2/(d\/gamma) = gamma epsilon_0 epsilon_r a^2/d = gamma C. $

#task(label: "b")[Does the electric field $E = U/d$ change? By what amount?]

The magnitude of an electric field inside a capacitor is given by the surface charge density $sigma$ divided by the permittivity of the electromagnetic medium inside the capacitor, i.e.
$ E = sigma/epsilon = sigma/(epsilon_0 epsilon_r) = Q/(epsilon_0 epsilon_r A) $
and is therefore independent of $d$ or any other system property that might change when occupying a reference moving perpendicular to the capacitor's plates. $E$ does not change.

#task(label: "c")[Write down the Lorentz force $arrow(F) = q(arrow(E) + arrow(v) times arrow(B))$ of a resting particle between the plates at $d/2$ with charge $q$ with respect to both the resting capacitor and the moving one. How could you reconcile the two forces?]

$ arrow(F) = q(arrow(E) + underbrace(arrow(v), 0) times underbrace(arrow(B), 0)) = q arrow(E), quad arrow(F)' = q(arrow(E)' + arrow(v)' times arrow(B)') = q(arrow(E) + arrow(v)' times arrow(B)'). $
Actually, there is nothing to reconcile. Using Ampère's law one can show that the magnetic field inside the capacitor as seen from a frame of reference moving parallel to the electric field vanishes, i.e. $arrow(B)' = 0$. This is because the magnetic fields of the plate carrying charge $Q$ and of that carrying charge $-Q$ cancel.

= Problem 5: Extra question: Synchronicity (5 points)

#task[
  Consider two antennae $A_1$ and $A_2$ that are a distance $L$ apart. Each receives a signal from an observer who's right in the middle. They respond by sending a signal back to the observer. For him, both antennae responded at the same time.

  The sequence of events is also seen from a spaceship flying past at a velocity $v$ from $A_1$ to $A_2$. The crew note that the antennae respond at differing times. Who is right?
]

Both the observer and the crew make a statement that is true in their frame of reference. In other words, they are both right. Temporal simultaneity has no absolute (Lorentz-invariant) physical meaning. In fact, as long as two events are at spacelike distance, i.e. $Delta s^2 < 0$, there always exists a frame of reference in which the two events occur simultaneously.
