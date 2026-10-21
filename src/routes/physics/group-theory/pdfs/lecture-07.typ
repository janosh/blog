#import "/notes.typ": notes
#import "@preview/cetz:0.5.2": canvas, draw

#show: notes.with(
  title: [6\. Lie Groups / Lie Algebras],
  subtitle: [Lecture 7, Group Theory, Prof. Daniel Roggenkamp],
  date: [Lecture notes by Janosh Riebesell, 03.06.2015],
)

// margin remarks of the handwritten notes
#let aside(body) = text(size: 9pt, fill: luma(80), body)
// a small sketch, centered
#let sketch(body) = align(center, canvas(length: 1cm, {
  import draw: *
  set-style(stroke: 0.7pt, mark: (fill: black, scale: 0.7))
  body
}))
#let pt(p, ..args) = draw.circle(p, radius: 0.045, fill: black, stroke: none, ..args)

- Noether's theorem
- symmetries of space-time: Poincaré symmetries
- gauge symmetries: $"SU"(3) times "SU"(2) times "U"(1)$

*Def:* A _Lie group_ is a group which is also a smooth manifold, such that
$ cases(reverse: #true, m\: G times G -> G & "(multiplication)", (dot)^(-1)\: G -> G & "(inverse)") quad "are smooth maps." $

All examples we will consider are _matrix groups_, i.e. subgroups of $"GL"(n)$, as such they are submanifolds of $RR^(n^2) \/ CC^(n^2)$. Often, they are described as level sets
$ {f = 0} subset "GL"(n) $
for some smooth _regular_ function $f: RR^n -> RR^k$ #aside[(regular: the derivative of $f$ has maximum rank everywhere)].

*Examples*

(i) $(RR, +)$ manifold:
$ cases(reverse: #true, m(x, y) = x + y, (x)^(-1) = -x) quad "smooth maps" $

(ii) $"U"(1) = {z in CC | |z|^2 = 1} = {e^(i phi) | phi in RR} tilde.equiv S^1$ (unit circle):
$ cases(reverse: #true, m(z, w) = z w, (z)^(-1) = overline(z)) quad "smooth maps" $

(iii) _(special) unitary group_
$ ("S")"U"(n) = {A in "Mat"(n, n, CC) | A^dagger A = bb(1), (det A = +1)}, quad A^dagger = overline(A)^t $

(iv) _(special) orthogonal group_
$ ("S")"O"(n) = {A in "Mat"(n, n, RR) | A^t A = bb(1), (det A = +1)} $

(v) _indefinite orthogonal groups_
$ "O"(p, q) = {A in "Mat"(n, n, RR) | A^t mat(bb(1)_p, 0; 0, -bb(1)_q; augment: #(hline: 1, vline: 1)) A = mat(bb(1)_p, 0; 0, -bb(1)_q; augment: #(hline: 1, vline: 1))}, quad n = p + q, $
leaves invariant the signature of the $(p, q)$ bilinear form, e.g. Lorentz group $cal(L) = "O"(1, 3)$.

(vi) _symplectic group_
$ "Symp"(2n) = {A in "Mat"(2n, 2n, RR) | A^t mat(0, bb(1)_n; -bb(1)_n, 0; augment: #(hline: 1, vline: 1)) A = mat(0, bb(1)_n; -bb(1)_n, 0; augment: #(hline: 1, vline: 1))} $

(vii) _Poincaré group_: symmetries of $RR^(1,3)$
$ P = "O"(1, 3) times.l RR^(1,3), $
#aside[semi-direct product: $(A, a)(B, b) = (A B, a + A b)$.]

Concepts in group theory carry over to Lie groups (but require smoothness), e.g.

A _homomorphism of Lie groups_ is a smooth group homomorphism $phi.alt: G -> H$.

A _Lie subgroup_ $H subset G$ is a subgroup, s.t. the inclusion map is a smooth immersion.

*Examples*

(i) $(RR, +) -> "U"(1)$, $x |-> e^(i x)$ hom. of Lie groups

(ii) $"U"(1) -> "U"(1)$, $z |-> z^n$, $n in ZZ$, hom. of Lie groups

(iii) $det: "GL"(n) -> (RR^times, dot)$ is a hom. of Lie groups

(iv) $"O"(n) subset "O"(n + m)$, $A |-> mat(A, 0; 0, bb(1)_m; augment: #(hline: 1, vline: 1))$ Lie subgroup

(v) $"U"(1) subset "SU"(2)$, $z |-> mat(z, 0; 0, overline(z))$ Lie subgroup

Combination of group theory with smooth manifolds $arrow.r.hook$ remarkable simplification by _linearization_.

*Reason:* All structures compatible with group multiplications are determined by their properties around $e in G$. The left-multiplication map $L_g: G -> G$, $h |-> g h$ is a bijection of Lie groups.

#grid(
  columns: (1fr, auto),
  align: horizon,
  [$ (dif L_g)_e: T_e G -> T_g G $
    $-->$ you get a vector field $X_v (g)$: _left-invariant_ vector field
    $ #rect(inset: 5pt)[$(dif L_g)_h X_v (h) = X_v (g h)$] $],
  sketch({
    import draw: *
    catmull((-0.2, 0), (1.4, 0.75), (3.2, 0.9), (4.8, 1.3), (5.4, 0.4), (4.3, -0.6), (2.4, -0.8), (0.6, -1.0), close: true, tension: 0.45)
    content((5.55, 1.2), $G$)
    pt((0.8, -0.35))
    content((0.8, -0.65), $e$)
    line((0.8, -0.35), (0.3, 0.15), mark: (end: ">"))
    content((0.75, 0.35), text(size: 9pt, $v in T_e G$))
    pt((2.5, -0.3))
    content((2.5, -0.05), $h$)
    content((2.75, -0.62), text(size: 9pt, $dif L_h v$))
    bezier((0.9, -0.35), (2.4, -0.3), (1.65, -0.05), mark: (end: ">"), stroke: 0.5pt)
    pt((4.5, 0.55))
    content((4.75, 0.35), $g$)
    line((4.5, 0.55), (4.8, 0.95), mark: (end: ">"))
    // L_g: upper curve from e to g, lower curve from h to g
    bezier((0.9, -0.25), (4.4, 0.6), (2.2, 0.55), mark: (end: ">"), stroke: 0.5pt)
    content((2.2, 0.62), text(size: 9pt, $L_g$))
    bezier((2.6, -0.25), (4.4, 0.5), (3.7, -0.05), mark: (end: ">"), stroke: 0.5pt)
  }),
)

Much of the structure of $G$ is captured by these vector fields.
$ #rect(inset: 5pt)[$X_v (g) := (dif L_g)_e v$] $
$dif L_g = (L_g)_*$ is the derivative of the map $L_g$, $L_e = "id"_G$.

*Aside about _vector fields_:* In local coordinates
$ #rect(inset: 5pt)[$X = sum_i X_i partial_i$] quad "vector field on manifold" M, $
$
  f: M -> RR, quad X(f) & = sum_i X_i (partial_i f), \
  X(Y f) & = sum_(i,j) X_i partial_i (Y_j partial_j f) = sum_(i,j) X_i Y_j (partial_i partial_j f) + (X_i partial_i Y_j) partial_j f, \
  [X, Y](f) & = X(Y f) - Y(X f) = sum_(i,j) (X_i partial_i Y_j - Y_i partial_i X_j) partial_j f = Z(f), \
  Z_j & = sum_i (X_i partial_i Y_j - Y_i partial_i X_j),
$
$ [dot, dot]: "vf" times "vf" -> "vf" quad "Lie bracket of vector fields." $

Lie bracket: "calculates how a vector field changes along another one".

#grid(
  columns: (1fr, auto),
  align: horizon,
  [(i) $f: M -> N$
    $ [dif f X, dif f Y] = dif f([X, Y]) $],
  sketch({
    import draw: *
    circle((0, 0), radius: 0.65)
    content((0, 0.9), $M$)
    pt((-0.15, -0.05))
    line((-0.15, -0.05), (0.3, 0.3), mark: (end: ">"))
    content((0.45, 0.42), text(size: 9pt, $X$))
    line((-0.15, -0.05), (0.2, -0.4), mark: (end: ">"))
    content((0.38, -0.45), text(size: 9pt, $Y$))
    bezier((0.7, 0.3), (2.6, 0.3), (1.65, 0.9), mark: (end: ">"))
    content((1.65, 0.95), $f$)
    circle((3.3, 0), radius: 0.65)
    content((3.3, 0.9), $N$)
    pt((3.1, 0.0))
    line((3.1, 0.0), (3.65, 0.1), mark: (end: ">"))
    content((3.6, 0.35), text(size: 9pt, $dif f_X$))
    line((3.1, 0.0), (3.1, -0.5), mark: (end: ">"))
    content((3.5, -0.4), text(size: 9pt, $dif f_Y$))
  }),
)

(ii) _Jacobi identity_
$ [X, [Y, Z]] + [Y, [Z, X]] + [Z, [X, Y]] = 0 $

From (i) it follows that left-invariant vector fields close under the Lie bracket. Left-invariance: $dif L_g X_v = X_v$, so
$ underbrace([dif L_g X_v, dif L_g X_w], = [X_v, X_w]) = dif L_g ([X_v, X_w]) $
$==>$ the Lie bracket of left-inv. vector fields is left-inv.

$-->$ $T_e G$ is equipped with the structure of a Lie algebra:
$ v, w in T_e G: quad [v, w] := X_([v, w]) = [X_v, X_w]. $

*Def:* A _Lie algebra_ is a vector space $V$ together with a skew-symmetric, bilinear map
$ [dot, dot]: V times V -> V $
satisfying the Jacobi identity (skew-symmetric: $[v, w] = -[w, v]$).

= Matrix Groups

$ G subset "GL"(n), quad T_e "GL"(n) = "Mat"(n, n), quad "GL"(n) = {A in "Mat"(n, n) | det A != 0}. $
$T_e G$: smooth paths $h(t) in G$, $h(0) = e$,
$ "Mat"(n, n) in.rev v = dot(h)(0) in T_e G, $
$
  L_g (h) & = g h quad #aside[(matrix multiplication)], \
  dif L_g v & = dif / (dif t)|_(t=0) L_g h(t) = dif / (dif t)|_(t=0) g h(t) = g dif / (dif t)|_(t=0) h(t) = g dot v, \
  X_v (g) & = g dot v.
$
Lie bracket: $X = sum_i X_i partial_i$, $X(f) = sum_i X_i (partial_i f)$, $X(Y f) - Y(X f) = [X, Y](f)$:
$
  X_v f(g) & = partial_g f(g) (g dot v), \
  X_v X_w f(g) & = partial_g (partial_g f(g) (g dot w)) g dot v = partial_g^2 f(g) (g dot w, g dot v) + partial_g f(g) g v w, \
  [X_v, X_w] f(g) & = partial_g f(g) g (v w - w v) = partial_g f(g) g ([v, w]), \
  [X_v, X_w](g) & = g [v, w] = X_([v, w]) quad #aside[(matrix commutator)].
$
$T_e G subset "Mat"(n, n)$ has the structure of a Lie algebra, where
$ [v, w] = v w - w v quad #aside[(matrix multiplication)] $
(the matrix commutator satisfies the Jacobi identity).

*Example:* $G = "O"(n) = {A in "Mat"(n, n, RR) | A^t A = bb(1)_n}$ is the level set
$ G = {f(A) = 0}, quad f(A) = A^t A - bb(1)_n, quad T_e G = ker(dif f_e). $
Take a path $A(t)$ s.t. $A(0) = bb(1)_n$, $dot(A)(0) = a$:
$ dif f_e a = dif / (dif t)|_(t=0) f(A(t)) = dif / (dif t)|_(t=0) (A^t A - bb(1)_n) = a^t + a $
#grid(
  columns: (1fr, auto),
  align: horizon,
  [$ T_e G = {a in "Mat"(n, n) | a^t = -a}, quad dim(G) = n / 2 (n - 1). $],
  [#aside[shape:] $lr(( #box(baseline: 40%, canvas(length: 1cm, {
      import draw: *
      set-style(stroke: 0.6pt)
      line((0.05, 0.85), (0.05, 0.1), (0.8, 0.1), close: true, fill: luma(220))
      content((0.1, 1.0), text(size: 7pt, $0$))
      content((0.5, 0.6), text(size: 7pt, $dots.down$))
      content((0.95, 0.15), text(size: 7pt, $0$))
    })) ))$],
)
Basis of $T_e G$: $E_((i,j))$, $i < j$, the matrix with entry $+1$ in row $i$, column $j$, entry $-1$ in row $j$, column $i$ and zeros elsewhere,
$ E_((i,j)) = mat(0, , , dots.c, ; , dots.down, , 1, ; , , dots.down, , ; dots.v, -1, , dots.down, ; , , , , 0) #aside[$arrow.l$ row $i$ holds the $1$ (column $j$), row $j$ the $-1$ (column $i$)], $
$ [E_((i,j)), E_((r,s))] = delta_(j r) E_((i,s)) + delta_(i s) E_((j,r)) - delta_(i r) E_((j,s)) - delta_(j s) E_((i,r)). $
$n = 3$: with the antisymmetric tensor $epsilon_(a b c)$,
$ E_a = -1/2 epsilon_(a b c) E_((b,c)), quad [E_a, E_b] = epsilon_(a b c) E_c. $
Often, Lie algebras are given in terms of a basis.

*Def:* A _homomorphism of Lie algebras_ is a linear map $phi: V -> W$, s.t.
$ [phi(v), phi(w)] = phi([v, w]). $

*Def:* A _sub-Lie algebra_ $V' subset V$ is a subspace s.t.
$ [v, w] in V' quad forall v, w in V'. $

Information about Lie groups is contained in their Lie algebras.

#let lie-table(..rows) = align(center, table(
  columns: 4,
  stroke: none,
  align: (left, left, center, left),
  inset: (x: 6pt, y: 5pt),
  table.header([], [*Lie group*], [], [*Lie algebra*]),
  table.hline(stroke: 0.5pt),
  ..rows,
))

#lie-table(
  [(i)], [$G$], [$|->$], [$T_e G = frak(g)$],
  [(ii)], [$phi.alt: G -> H$ \ #aside[hom. of Lie groups]], [$|->$], [$phi := dif phi.alt_e: underbrace(T_e G, frak(g)) -> underbrace(T_e H, frak(h))$ \ #aside[hom. of Lie algebras]],
  [(iii)], [$H subset G$ \ #aside[subgroup]], [$|->$], [$T_e H = frak(h) subset frak(g) = T_e G$ \ #aside[subalgebra]],
  [(iv)], [unique simply connected Lie group $tilde(G)$ with $"Lie"(tilde(G)) = frak(g)$ \*], [$arrow.l.bar$], [$frak(g)$],
  [(v)], [$exists!$ connected $H subset G$], [$arrow.l.bar$], [$frak(h) subset frak(g)$],
)
\* but any $G = tilde(G) \/ Gamma$, $Gamma$ a discrete subgroup of $Z(tilde(G))$, also has the same Lie algebra.

*Proof of (ii):*
$
  phi.alt(g h) & = phi.alt(g) phi.alt(h), \
  phi.alt compose L_g & = L_(phi.alt(g)) compose phi.alt, \
  dif phi.alt compose dif L_g & = dif L_(phi.alt(g)) compose dif phi.alt, \
  dif phi.alt X_v (g) & = X_(dif phi.alt_e v) (phi.alt(g)),
$
$
  X_([dif phi.alt_e v, dif phi.alt_e w]) & = [X_(dif phi.alt_e v), X_(dif phi.alt_e w)] = [dif phi.alt X_v (g), dif phi.alt X_w (g)] \
  & = dif phi.alt [X_v, X_w](g) = dif phi.alt X_([v, w]) = X_(dif phi.alt_e [v, w]).
$
From this follows (ii).

*(iii)* This follows from looking at the inclusion.

#grid(
  columns: (1fr, auto),
  align: horizon,
  [*Def:* _Simply connected_ means connected and there are no non-contractible loops, e.g. $S^1$ is _not_ simply connected.],
  sketch({
    import draw: *
    circle((0, 1.0), radius: 0.45)
    content((0.65, 1.4), $S^1$)
    line((-1.4, 0), (1.4, 0), mark: (end: ">"))
    content((1.6, 0.15), $RR$)
    bezier((-0.45, 0), (0.45, 0), (0, 0.18), stroke: 0.5pt)
    bezier((-0.45, 0), (0.45, 0), (0, -0.18), stroke: 0.5pt)
  }),
)

Continuing the table from above:

#lie-table(
  [(vi)], [$exists! phi.alt: G -> H$, \ $dif phi.alt_e = phi$ \ #aside[$G$ simply connected, $H$ connected]], [$arrow.l.bar$], [$phi: frak(g) -> frak(h)$],
  [(vii)], [$G tilde.equiv H$ \ #aside[if both are simply connected]], [$arrow.l.bar$], [$frak(g) tilde.equiv frak(h)$],
)

In particular:
$
  "repr. of" G & |-> "repr. of" frak(g), \
  "repr. of" G & arrow.l.bar "repr. of" frak(g) quad "but only if" G "is simply connected."
$
If $G$ is not simply connected, then not all repr. of $frak(g)$ integrate to repr. of $G$. E.g. $"SO"(3)$:
$ frak(s o)(3) = "Lie"("SO"(3)) tilde.equiv frak(s u)(2) = "Lie"("SU"(2)). $
Repr. of $frak(s u)(2)$ are denoted by spin $j in 1/2 NN$, but only the integral spins give rise to repr. of $"SO"(3)$.
