#import "/notes.typ": notes
#import "@preview/cetz:0.5.2": canvas, draw

#show: notes.with(
  title: [1\. Abstract Groups],
  subtitle: [Lecture 2, Group Theory, Prof. Daniel Roggenkamp],
  date: [Lecture notes by Janosh Riebesell, 15.04.2015],
)

#set enum(numbering: "(i)")

// margin remarks of the handwritten notes
#let aside(body) = text(size: 9pt, fill: luma(80), body)

// equilateral triangle, optionally with its three reflection axes
#let tri-fig(axes: false, size: 0.9) = box(baseline: 40%, canvas(length: 1cm, {
  import draw: *
  set-style(stroke: 0.7pt)
  let pts = range(3).map(k => {
    let a = 90deg + k * 120deg
    (size * calc.cos(a), size * calc.sin(a))
  })
  line(..pts, close: true)
  if axes {
    for p in pts {
      line((1.45 * p.at(0), 1.45 * p.at(1)), (-0.95 * p.at(0), -0.95 * p.at(1)), stroke: (paint: luma(120), thickness: 0.5pt))
    }
  }
}))

// a subgroup H drawn as a blob inside the group G
#let subgroup-sketch = box(canvas(length: 1cm, {
  import draw: *
  set-style(stroke: 0.6pt)
  circle((0, 0), radius: (1.1, 0.75))
  circle((-0.35, -0.15), radius: (0.42, 0.28))
  content((-0.35, -0.15), text(size: 8pt)[$H$])
  content((0.6, 0.35), text(size: 9pt)[$G$])
}))

*Definition:* A _group_ $G$:
$ G times G & -> G \
(g_1, g_2) & |-> g_1 g_2 $
s.t.
+ _Associativity:_ $(g_1 g_2) g_3 = g_1 (g_2 g_3)$
+ _Identity:_ $exists e in G: e dot g = g quad forall g in G$
+ _Inverse:_ $forall g in G space exists g^(-1): g^(-1) g = e$

In case $forall g, h in G: g h = h g$, then $G$ is _Abelian_ (commutative).

*Remark:*

(i) _right-inverses:_
$
  g^(-1) g = e, quad (g^(-1) g) g^(-1) = e g^(-1) = g^(-1) = g^(-1) (g g^(-1)) quad => quad #box(stroke: 0.5pt, inset: 3pt, $g g^(-1) = e$)
$

(ii) _right-identity:_
$ g dot e = g (g^(-1) g) = (g g^(-1)) g = e g = g $

(iii) _uniqueness of $e$:_ Assume $exists e': e' g = g space forall g$
$ e' dot e = e = e' $

(iv) _uniqueness of inverse:_ Assume that for $g in G space exists h: h g = e$
$ h = h dot e = h (g g^(-1)) = (h g) g^(-1) = e g^(-1) = g^(-1) $

*Examples:*
+ $(ZZ, +)$ Abelian group
+ Cyclic groups $ZZ_n = ZZ\/n ZZ$
+ Symmetric group $S_n$ (permutations of $n$ objects)
+ Dihedral group $D_3$ (symmetries of a regular triangle $triangle.stroked.t$)

*Example:* Dihedral group $D_3$:

- $D_3$ #h(0.5em) #tri-fig() #h(1em) Elements (6):
  $ |D_3| = 6, quad D_3 = {e_0 = R_0, R_1 = R((2 pi)/3), R_2 = R((4 pi)/3), underbrace(S_0\, S_1\, S_2, "Reflections")} quad #tri-fig(axes: true, size: 0.55) $

  #grid(
    columns: (auto, 1fr),
    column-gutter: 1em,
    align: horizon,
    box(stroke: 0.5pt, inset: 6pt, $ R_i R_j & = R_(i + j mod 3) \
    S_i^2 & = R_0 \
    R_i S_j & = S_(i + j mod 3) $),
    aside[these properties define the group],
  )

  Using these relations: #aside[(these are consequences)]
  $
    S_i R_j & = S_(i - j), \
    S_i S_j & = R_(i - j) quad #aside[(check)]
  $
- $D_n$: symmetries of a regular $n$-gon
  $ D_n = {R_0, R_1, ..., R_(n-1), S_0, ..., S_(n-1)} #h(4em) (*) $

So far, all examples are discrete. But now: continuous ones.

*Lie groups:*
5. translation group $(RR^n, +)$, Abelian.
+ General linear group
  $ "GL"(n) := {A in "Mat"(n, n; RR) | det(A) != 0} $
+ (special) orthogonal group
  $ "(S)O"(n) := {A in "Mat"(n, n; RR) | A^t A = bb(1)_n} quad (det(A) = 1) $
+ Euclidean group (symmetries of an affine space)
  $ E(n) := {(a, A) in RR^n times O(n)}, quad (a, A)(a', A') = (a + A a', A A') $
+ (special) unitary group
  $ "(S)U"(n) := {A in "Mat"(n, n; CC) | overline(A)^t A = bb(1)_n} quad (det(A) = 1) $

*Def:* A _group homomorphism_ is a map
$ phi: G -> H quad "s.t." quad phi(g_1 g_2) = phi(g_1) phi(g_2). $
- If $phi$ is invertible: _group isomorphism_.
- $"Hom"(G, H)$: set of homomorphisms.

*Rem:*

(i) $phi(e_G) = e_H$
$ [phi(g) = phi(g dot e_G) = phi(g) dot phi(e_G) quad => quad phi(e_G) = e_H] $

(ii) $phi(g^(-1)) = (phi(g))^(-1)$
$ [phi(g^(-1)) phi(g) = phi(g^(-1) g) = phi(e_G) = e_H quad => quad phi(g^(-1)) = (phi(g))^(-1)] $

*Examples:*
+ $ZZ_n -> D_n, quad [a] |-> R_(a mod n), quad R_i dot R_j = R_(i + j)$
+ $ZZ_n -> "U"(1) = {a in CC | overline(a) a = 1}, quad [a] |-> e^((2 pi i a)/n)$
+ $phi: O(2) -> O(3), quad A |-> mat(augment: #(hline: 1, vline: 1), A, 0; 0, 1)$
+ $"U"(n) -> "U"(1), quad A |-> det(A)$

#grid(
  columns: (1fr, auto),
  column-gutter: 1em,
  align: horizon,
  [
    *Def:* A _subgroup_ $H subset G$ is a subset which is itself a group w.r.t. multiplication in $G$.
  ],
  subgroup-sketch,
)

*Rem:*
+ $H$ has to contain $e_G = e_H attach(in, t: !) H$
+ $H subset G$ (subgroup) $<=> forall h_1, h_2 in H: h_1 h_2^(-1) in H$
+ Trivial subgroups: ${e} subset G$, $G subset G$
+ $G$ Abelian $=> H subset G$ also Abelian.

*Examples:*
+ $ZZ_n subset D_n$, $ZZ_n = {R_0, R_1, ..., R_(n-1)}$
+ $ZZ_n subset ZZ_(n m)$, $ZZ_n tilde.equiv {[0], [m], [2m], ..., [(n-1)m]}$
+ $"U"(1) subset "U"(n)$, $"U"(1) tilde.equiv {e^(i phi) bb(1)_n | phi in RR}$
+ $"SO"(n) subset O(n)$, $"SU"(n) subset "U"(n)$
+ $O(n-1) subset O(n)$, $mat(augment: #(hline: 1, vline: 1), A, ""; "", 1) in O(n)$
+ $forall g in G: H = Gamma_g = {g^i | i in ZZ}$ (Abelian)
+ center $Z(G) := {h in G | h g = g h space forall g in G}$
  $
    Z(O(n)) & = {plus.minus bb(1)_n} tilde.equiv ZZ_2, \
    Z(D_"even") & = {R_0, R_(n\/2)} tilde.equiv ZZ_2.
  $

#grid(
  columns: (1fr, auto),
  column-gutter: 1em,
  align: horizon,
  [*Def:* $H subset G$: _left-coset_ $g dot H = {g dot h | h in H} subset G$],
  subgroup-sketch,
)

*Rem:*
+ $g H$ is the rest class of the equivalence relation
  $ a tilde b :<=> a^(-1) b in H $
  [reflexive, symmetric, transitive]
+ $g_1 H$ and $g_2 H$ are either disjoint or identical:
  $
    g in g_1 H inter g_2 H quad => quad g_1 h_1 = g = g_2 h_2, quad g_1 = g_2 h_2 h_1^(-1) in g_2 H
  $
+ $g dot H$ is a subgroup $<=> g in H$
+ $(g H) |-> (g H)^(-1) = H g^(-1)$: left-coset $<->$ right coset

*Examples:*
+ $G = (ZZ, +)$, $H = m ZZ$, cosets $m ZZ, m ZZ + 1, m ZZ + 2, ..., m ZZ + (m - 1)$
+ $G = D_3$, $H = ZZ_3$: $R_0 ZZ_3 = {R_0, R_1, R_2}$, $S_0 ZZ_3 = S_1 ZZ_3 = S_2 ZZ_3$

*Def:* $g_1, g_2 in G$ are _conjugate_, $g_1 tilde g_2$ $:<=>$ $exists g in G: g_1 = g g_2 g^(-1)$.

This is an equivalence relation: rest classes
$ C_g = [g] = {tilde(g) g tilde(g)^(-1) | tilde(g) in G} quad "conjugacy classes" $

*Example:* $D_n$:
$ C_(R_i) = {R_i, R_(-i)}, quad C_(S_i) = {S_(i + 2j) | j in ZZ} $

*Def:* A subgroup $H subset G$ is _normal_, $H lt.closed G$, if it is self-conjugate, i.e.
$ g H g^(-1) = H quad forall g in G. $

*Remark:*
+ $H lt.closed G$: $g H = H g$ (left = right cosets)
+ $H$ is a union of conjugacy classes
+ $N subset H subset G$, $N lt.closed G => N lt.closed H$, \
  but in general $N lt.closed H lt.closed G arrow.r.double.not N lt.closed G$ #h(1em) WARNING!

*Examples:*
+ center $Z(G)$
+ $phi: G -> G'$ homomorphism:
  $ H := ker(phi) = {g in G | phi(g) = e_(G')} lt.closed G $
  - subgroup: $phi(g) = e = phi(h)$ $forall g, h in H$
    $ => phi(g) dot underbrace(phi(h^(-1)), e) = phi(g h^(-1)) => g h^(-1) in H $
  - normal:
    $ phi(g h g^(-1)) = phi(g) underbrace(phi(h), e) phi(g^(-1)) = phi(g) phi(g^(-1)) = phi(g g^(-1)) = e => g h g^(-1) in H space forall g in G $
  e.g. $det: "U"(n) -> "U"(1)$ homomorphism,
  $ ker(det) = {A in "U"(n) | det(A) = 1} = "SU"(n) => "SU"(n) lt.closed "U"(n) $
+ images of normal subgroups are normal in the image of the group:
  $ H lt.closed G => phi(H) lt.closed phi(G) subset G', quad phi: G -> G' $

*Quotient group:* If $H lt.closed G$, then $G\/H = {g H | g in G}$ forms a group:
$ g H g' H = g g' underbrace((g'^(-1) H g'), H) H = g g' H dot H = g g' H, $
a well-defined multiplication map:
+ associative
+ identity: $H$
+ inverse: $(g H)^(-1) = g^(-1) H$

*Def:* _Simple groups_ $G$ don't have non-trivial normal subgroups (building blocks).

*Fact:* $phi: G -> G'$, $H := ker(phi) lt.closed G$
$
  G\/H = G\/ker(phi) & -> G' \
  g ker(phi) & |-> phi(g)
$
$ f: G\/H attach(->, t: tilde.equiv) phi(G) quad "isomorphism" $
e.g. $phi = det: "U"(n) -> "U"(1)$, $ker(phi) = "SU"(n)$:
$ "U"(n)\/"SU"(n) tilde.equiv "U"(1) $

*Product of groups:*

_Direct product_ $G_1 times G_2$: for $(g_1, g_2), (g'_1, g'_2) in G_1 times G_2$,
$ (g_1, g_2) dot (g'_1, g'_2) = (g_1 g'_1, g_2 g'_2) quad -> "satisfies group axioms". $
$
  pi_2: G_1 times G_2 & -> G_2 quad #aside[(this is a group homomorphism)] \
  (g_1, g_2) & |-> g_2
$
$ ker(pi_2) = G_1 lt.closed G_1 times G_2 quad #aside[(also true for $G_2$: $G_2 lt.closed G_1 times G_2$)] $

*Fact:* $G = N_1 times N_2 <=>$
+ $N_1, N_2 lt.closed G$
+ $N_1 inter N_2 = {e}$
+ $G = N_1 N_2$

*Def:* _semi-direct product_: $N, H$ groups, $theta: H -> "Aut"(N) = "Iso"(N)$,
$ N times.r_theta H = N times H "as a set", quad (n, h), quad n in N, h in H, $
$ (n, h) dot (n', h') = (n dot theta(h)(n'), h h'). $
If $theta$ = identity, then this is the direct product.
$ e = (e_N, e_H), quad (n, h)^(-1) = (theta(h)^(-1) (n^(-1)), h^(-1)). $
Check associativity:
$
  ((n, h)(n', h'))(n'', h'') & = (n theta(h)(n'), h h')(n'', h'') = \(n theta(h)(n') underbrace(theta(h h'), theta(h) compose theta(h')) (n''), h h' h''\) \
  & attach(=, t: theta "is hom.") (n theta(h)(n' theta(h')(n'')), h h' h'') = (n, h)((n', h')(n'', h'')).
$

*Examples:*
+ $E(n) = RR^n times.r_theta O(n)$,
  $ theta: O(n) & -> "Iso"(RR^n) \
  A & |-> (a in RR^n |-> A dot a) $
+ $G = D_n$, $N = ZZ_n lt.closed D_n$, $H = {R_0, S_0} = ZZ_2$:
  $
    phi: ZZ_n times.r ZZ_2 & -> D_n \
    (R_i, R_0 = e) & |-> R_i R_0 = R_i \
    (R_i, S_0) & |-> R_i S_0 = S_i
  $
  $
    phi(R_i, a) phi(R_j, b) & = R_i a R_j b = R_i underbrace(a R_j a^(-1), R'_j) a b = phi(R_i theta(a)(R_j), a b), \
    R'_j & = a R_j a^(-1) = theta(a)(R_j),
  $
  $
    theta: ZZ_2 & -> "Iso"(ZZ_n) \
    a & |-> (R_i |-> a R_i a^(-1))
  $

#line(length: 100%, stroke: 0.4pt + luma(160))

*22.04.2015*

Next lecture: 13.05.2015. Problem set!!!

_Summary of last lecture:_ Defined basic concepts of groups:
- groups
- subgroups
- homomorphisms
- conjugation
- normal groups, quotient groups
- cosets
- (semi-direct) products
