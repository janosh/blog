#import "/notes.typ": notes, tagged
#import "@preview/cetz:0.5.2": canvas, draw

#show: notes.with(
  title: [Exponential Map and the Lorentz Group],
  subtitle: [Lecture 8, Group Theory, Prof. Daniel Roggenkamp],
  date: [Lecture notes by Janosh Riebesell, 10.06.2015],
)

// margin remarks of the handwritten notes
#let aside(body) = text(size: 9pt, fill: luma(80), body)
// a small sketch, centered
#let sketch(body) = align(center, canvas(length: 1cm, {
  import draw: *
  set-style(stroke: 0.7pt, mark: (fill: black, scale: 0.7))
  body
}))
#let pt(p) = draw.circle(p, radius: 0.045, fill: black, stroke: none)
// block matrix with one horizontal and one vertical separator after the first row/column
#let bmat(..rows) = math.mat(augment: (hline: 1, vline: 1), ..rows)

#let lie-table(..rows) = align(center, table(
  columns: 4,
  stroke: none,
  align: (left, left, center, left),
  inset: (x: 6pt, y: 5pt),
  table.header([], [*Lie group*], [], [*Lie algebra*]),
  table.hline(stroke: 0.5pt),
  ..rows,
))

= Summary of last week's lecture

#lie-table(
  [(i)], [$G$], [$|->$], [$frak(g) tilde.equiv T_e G$],
  [(ii)], [$phi.alt: G -> H$], [$|->$], [$phi = dif phi.alt_e: frak(g) -> frak(h)$],
  [(iii)], [$H subset G$], [$|->$], [$frak(h) subset frak(g)$],
  [(iv)], [$exists!$ simply connected Lie group $tilde(G)$ \ other: $G = tilde(G) \/ Gamma$, $Gamma subset Z(tilde(G))$], [$arrow.l.bar$], [$frak(g)$],
  [(v)], [unique connected $H subset G$], [$arrow.l.bar$], [$frak(h) subset frak(g)$],
  [(vi)], [$exists! phi.alt: G -> H$, $G$ simply connected, $H$ connected], [$arrow.l.bar$], [$phi: frak(g) -> frak(h)$],
)

= Representations

$
  phi.alt: G -> "GL"(V) & quad |-> quad phi = (dif phi.alt)_e: frak(g) -> frak(g l)(V), \
  exists! phi.alt: tilde(G) -> "GL"(V) & quad arrow.l.bar quad phi: frak(g) -> frak(g l)(V),
$
where $tilde(G)$ is the simply connected Lie group with Lie algebra $frak(g)$. For $G = tilde(G) \/ Gamma$: $ker(phi.alt) supset Gamma$.

= Exponential map

$G$: Lie group, $"Lie"(G) = frak(g)$. For every $v in frak(g)$ we can define the subalgebra $frak(h) = "span"(v) subset frak(g)$. Using (v) from the above table $-->$ 1-parameter subgroup $H subset G$ (unique connected):
$
  phi.alt_v: (RR, +) -> G quad & bar.v quad phi_v: frak(h) -> frak(g), quad v |-> v, \
  phi.alt_v (s) phi.alt_v (t) & = phi.alt_v (s + t), \
  (dif phi.alt_v)_e & = v.
$

#grid(
  columns: (1fr, auto),
  align: horizon,
  [(i) $phi.alt_v (t): RR -> G$ (integral curve of $X_v$),
    $ dot(gamma)(t) = X_v (gamma(t)), $
    $gamma = g dot phi.alt_v (t)$ integral curve of $X_v$ through $g in G$:],
  sketch({
    import draw: *
    circle((0, 0), radius: 1.0)
    content((0.95, 0.95), $G$)
    // integral curve gamma through g (arc with a maximum), tangent vectors along it
    bezier((-0.6, -0.45), (0.65, -0.35), (0.0, 0.05), stroke: 0.5pt)
    pt((-0.24, -0.23))
    line((-0.24, -0.23), (0.24, 0.21), mark: (end: ">"))
    line((0.12, -0.17), (0.55, -0.12), mark: (end: ">"))
    content((0.66, 0.06), text(size: 9pt, $X_v$))
    content((0.03, -0.64), text(size: 8pt, $gamma = g phi.alt_v (t)$))
  }),
)
$
  dot(gamma)(t) & = dif / (dif s)|_(s=0) gamma(t + s) = dif / (dif s)|_(s=0) g phi.alt_v (t) phi.alt_v (s) \
  & = dif (L_(g phi.alt_v (t)))_e underbrace(dif / (dif s)|_(s=0) phi.alt_v (s), v) = dif (L_(g phi.alt_v (t)))_e v = X_v (gamma(t)).
$

(ii) $phi.alt_v (t) = phi.alt_(v t) (1)$ (both integral curves of the same vector field).

#grid(
  columns: (1fr, auto),
  align: horizon,
  [*Define:* $exp: frak(g) -> G$, $v |-> phi.alt_v (1)$.
    #set enum(numbering: "(i)")
    + $exp(t v) exp(s v) = exp((s + t) v)$
    + $underbrace(dif (exp)_0, "id"_frak(g)): frak(g) -> frak(g)$, $v |-> v$
    + $phi.alt: G -> H ==> phi.alt(exp(v)) = exp(dif phi.alt_e v)$],
  sketch({
    import draw: *
    circle((0, 0), radius: 1.0)
    pt((-0.5, 0.0))
    content((-0.72, 0.05), $e$)
    line((-0.5, 0.0), (-0.05, 0.45), mark: (end: ">"))
    content((0.1, 0.6), text(size: 9pt, $v$))
    bezier((-0.45, 0.02), (0.4, -0.05), (0.0, 0.35), mark: (end: ">"), stroke: 0.5pt)
    pt((0.4, -0.05))
    content((0.3, -0.4), text(size: 9pt, $exp(v)$))
  }),
)

*Matrix groups*
$ exp = "Exp": "Mat"(n, n) -> "GL"(n), quad v |-> sum_(i >= 0) v^i / i! quad #aside[(matrix multiplication)] $

*Baker--Campbell--Hausdorff formula*
$ exp(v) exp(w) = exp(v + w + 1/2 [v, w] + 1/12 ([v, [v, w]] + [w, [w, v]]) + dots.c) $

= The Lorentz group

Minkowski space: $(RR^(1,3), eta = "diag"(1, -1, -1, -1))$,
$ cal(L) = "O"(1, 3) = {Lambda in "Mat"(4, 4) | Lambda^t eta Lambda = eta}, $
$ Lambda = bmat(lambda_(00), lambda_2^t; lambda_1, hat(Lambda)), quad lambda_(00) in RR; quad lambda_1, lambda_2 in RR^3; quad hat(Lambda) in "Mat"(3, 3), $
#tagged($*$, $ Lambda^t eta Lambda = bmat(lambda_(00)^2 - lambda_1^t lambda_1, lambda_(00) lambda_2^t - lambda_1^t hat(Lambda); lambda_2 lambda_(00) - hat(Lambda)^t lambda_1, -hat(Lambda)^t hat(Lambda) + lambda_2 lambda_2^t) = bmat(1, 0; 0, -bb(1)_3). $)

== Polar decomposition of $"O"(1, 3)$

Note that $eta^t = eta$, $eta^2 = bb(1)_4$ $==>$ $eta in "O"(1, 3)$, $Lambda^t = eta Lambda^(-1) eta in "O"(1, 3)$
$
  ==> Lambda^t Lambda in "O"(1, 3), "symmetric", > 0, \
  cal(L) := sqrt(Lambda^t Lambda), quad cal(L)^t = cal(L), quad cal(L) > 0, quad cal(L) in "O"(1, 3), \
  R := Lambda cal(L)^(-1) in "O"(1, 3), \
  R^t R = (cal(L)^(-1))^t Lambda^t Lambda cal(L)^(-1) = bb(1)_4 ==> R in "O"(1, 3) inter "O"(4) \
  ==> R in "O"(1) times "O"(3), quad R = mat(epsilon, 0, 0, 0; 0, , , ; 0, , Q, ; 0, , , ; augment: #(hline: 1, vline: 1)), quad epsilon in "O"(1) = {plus.minus 1}, quad Q in "O"(3),
$
$ Lambda = bmat(epsilon, 0; 0, Q) cal(L), quad cal(L) = bmat(lambda_(00), lambda_2^t; lambda_1, hat(Lambda)), quad hat(Lambda)^t = hat(Lambda). $
$ (*) ==> lambda_(00) = sqrt(1 + lambda^t lambda), quad hat(Lambda) = sqrt(bb(1) + lambda lambda^t), $
$ Lambda = underbrace(bmat(epsilon, 0; 0, Q), epsilon": time reversal, " Q": space transf.") dot underbrace(bmat(sqrt(1 + lambda^t lambda), lambda^t; lambda, sqrt(bb(1) + lambda lambda^t)), "boosts"), $
$ "O"(1, 3) attach(tilde.equiv, t: "homeo") "O"(1) times "O"(3) times RR^3 $
$-->$ 4 components distinguished by
$
  det(Lambda) & = epsilon det(Q) = plus.minus 1 quad && (+1: "proper, preserve orientation"), \
  "sign"(lambda_(00)) & = epsilon = plus.minus 1 quad && (+1: "orthochronous, time-direction preserved").
$
The connected component of $e in "O"(1, 3)$ is called $"O"(1, 3)_0 lt.closed "O"(1, 3)$,
$ "O"(1, 3) \/ "O"(1, 3)_0 = ZZ_2 times ZZ_2 = {bb(1), P, T, P T}, quad P = bmat(1, 0; 0, -bb(1)_3) "parity reversal", quad T = bmat(-1, 0; 0, bb(1)_3) "time reversal", quad P T = -bb(1)_4. $

== Lie algebra $frak(o)(1, 3)$

$"O"(1, 3)$ is a level set: $f(Lambda) = Lambda^t eta Lambda - eta$,
$
  dif f_e v & = v^t eta + eta v, \
  T_e "O"(1, 3) = frak(o)(1, 3) = ker(dif f_e) & = {v | v^t = -eta v eta}, \
  v = bmat(v_0, c^t; d, hat(v)) & = bmat(-v_0, +d^t; +c, -hat(v)^t) \
  ==> v_0 = 0, quad c = d, quad hat(v)^t & = -hat(v), quad v = bmat(0, c^t; c, hat(v)).
$
Basis:
$
  omega_1 = bmat(0, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, -1; 0, 0, 1, 0), quad omega_2 = bmat(0, 0, 0, 0; 0, 0, 0, 1; 0, 0, 0, 0; 0, -1, 0, 0), quad omega_3 = bmat(0, 0, 0, 0; 0, 0, -1, 0; 0, 1, 0, 0; 0, 0, 0, 0), \
  K_1 = bmat(0, 1, 0, 0; 1, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, 0), quad K_2 = bmat(0, 0, 1, 0; 0, 0, 0, 0; 1, 0, 0, 0; 0, 0, 0, 0), quad K_3 = bmat(0, 0, 0, 1; 0, 0, 0, 0; 0, 0, 0, 0; 1, 0, 0, 0),
$
$ frak(o)(1, 3) = "span"{omega_i, K_i} quad <-- quad "6-dimensional real Lie algebra", $
$
  #rect(inset: 8pt)[$
    [omega_i, omega_j] & = sum_k epsilon_(i j k) omega_k, \
    [K_i, K_j] & = -sum_k epsilon_(i j k) omega_k, \
    [omega_i, K_j] & = sum_k epsilon_(i j k) K_k
  $]
$

$ "SL"_2 (CC) = {A in "Mat"(2, 2, CC) | det(A) = 1}, $
$
  frak(s l)_2 (CC) & = {a in "Mat"(2, 2, CC) | tr(a) = 0} \
  & = "span"_CC {j_1 = -i/2 sigma_1 = 1/2 mat(0, -i; -i, 0), j_2 = -i/2 sigma_2 = 1/2 mat(0, -1; 1, 0), j_3 = -i/2 sigma_3 = 1/2 mat(-i, 0; 0, i)},
$
where $sigma_i$ are the Pauli matrices, and
$ [j_a, j_b] = sum_c epsilon_(a b c) j_c $
$-->$ complex 3-dimensional Lie algebra.

Choose a real structure:
$ frak(s l)_2 (CC) = "span"_RR {j_1, j_2, j_3} times.o_RR CC, $
$ phi: (frak(s l)_2 (CC))_RR -> frak(o)(1, 3), quad j_a |-> omega_a, quad i j_a |-> K_a $
is an isomorphism of real Lie algebras. $"SL"(2, CC)$ is in fact simply connected!

$==>$ $phi$ integrates to a unique
$ phi.alt: "SL"(2, CC) -> "O"(1, 3)_0, quad dif phi.alt_e = phi, $
which is possibly a covering.

Identify
$ RR^(1,3) attach(-->, t: tilde.equiv) i frak(u)(2) #aside[(hermitian $2 times 2$ matrices)], quad x |-> sigma(x) = sum_i x_i sigma_i = mat(x_0 + x_3, x_1 - i x_2; x_1 + i x_2, x_0 - x_3), $
$ x^t eta x = det(sigma(x)). $
Now $"SL"(2, CC)$ acts on $i frak(u)(2)$:
$ sigma(x) |-> A sigma(x) A^dagger, quad A in "SL"(2, CC). $
But this action preserves $eta$:
$ det(A sigma(x) A^dagger) = det(sigma(x)) quad "since" det(A) = 1 $
$ ==> A sigma(x) A^dagger = sigma(Psi(A) dot x), quad "where" Psi: "SL"(2, CC) -> "O"(1, 3). $
Check: $dif Psi_e = phi ==> Psi = phi.alt$.

$A(t)$ path in $"SL"(2, CC)$: $A(0) = bb(1)$, $dot(A)(0) = a$,
$ dif / (dif t)|_(t=0) A(t) sigma(x) A^dagger (t) = a sigma(x) + sigma(x) a^dagger = sigma((dif Psi_e a) x), $
$
  a = j_i = -i/2 sigma_i & ==> dif / (dif t)|_(t=0) A(t) sigma(x) A^dagger (t) = -i/2 [sigma_i, sigma(x)] = sum sigma_c (omega_i x)_c = sigma(omega_i x), \
  a = i j_i = 1/2 sigma_i & ==> dif / (dif t)|_(t=0) A(t) sigma(x) A^dagger (t) = sigma(K_i x),
$
$
  & ==> phi = dif Psi_e: j_i |-> omega_i, quad i j_i |-> K_i \
  & ==> Psi = phi.alt, \
  & ker(phi.alt) = {A in "SL"(2, CC) | A sigma A^dagger = sigma thin forall sigma} = {plus.minus bb(1)_2}.
$

*Remark:* complexification
$ frak(o)(1, 3)_CC = frak(o)(1, 3) times.o_RR CC quad --> quad "6-dimensional, complex Lie algebra", $
basis: $J_i^plus.minus := 1/2 (omega_i plus.minus i K_i)$, a complex basis of $frak(o)(1, 3)_CC$:
$ [J_i^+, J_j^-] = 0 quad forall i, j, quad [J_i^plus.minus, J_j^plus.minus] = sum_k epsilon_(i j k) J_k^plus.minus, $
$ frak(o)(1, 3)_CC attach(-->, t: tilde.equiv) frak(s l)_2 (CC) plus.o frak(s l)_2 (CC), quad J_i^+ |-> (j_i, 0), quad J_i^- |-> (0, j_i), $
an isomorphism of complex Lie algebras:
$ #rect(inset: 6pt)[$frak(o)(1, 3)_CC tilde.equiv frak(s l)_2 (CC) plus.o frak(s l)_2 (CC)$] $
