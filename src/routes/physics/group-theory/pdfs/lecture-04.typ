#import "/notes.typ": notes
#import "@preview/cetz:0.5.2": canvas, draw

#show: notes.with(
  title: [3\. (Linear) Representations],
  subtitle: [Lecture 4, Group Theory, Prof. Daniel Roggenkamp],
  date: [Lecture notes by Janosh Riebesell, 13.05.2015],
)

// margin remarks of the handwritten notes
#let aside(body) = text(size: 9pt, fill: luma(80), body)

*Def:* A _(linear) representation_ of a group $G$ is a group homomorphism
$ rho: G -> #box(stroke: 0.5pt, inset: 3pt, $"GL"(V) = {"invertible, linear transf. of" V}$), quad V: "vector space (repr. space)". $
#aside[$"GL"(V)$ is the _general linear group_ on $V$: the group of all automorphisms of $V$, i.e. the set of all bijective linear transformations $V -> V$ (isomorphisms from an object to itself) together with functional composition as group operation. Loosely speaking, the "symmetry group of the object".]

*Remark:* If #box(stroke: 0.5pt, inset: 3pt, $dim(V) = n < oo$) (the _dimension of the representation_), then by choosing a basis, one can think of a representation as a collection of invertible $n times n$ matrices $rho(g)$, $g in G$, s.t.
$ rho(e) = bb(1)_n, quad rho(g) rho(g') = rho(g g') quad forall g, g' in G. $

*Examples*

(i) $G = ZZ_n = ZZ\/n ZZ$, representations on $V = CC$:
$ "GL"(V) = CC^times = CC without {0} quad ("complex plane without zero") quad -> dim(V) = n = 1, $
$ rho([a]) = e^((2 pi i a)/n), quad rho([a]) rho([b]) = e^((2 pi i)/n (a + b)) = rho([a + b]). $

(ii) $V = RR^2$:
$ rho([a]) = mat(cos((2 pi)/n a), sin((2 pi)/n a); -sin((2 pi)/n a), cos((2 pi)/n a)). $

#grid(
  columns: (1fr, auto),
  column-gutter: 1.5em,
  align: horizon,
  [
    (iii) $G = D_n$, $V = RR^2$, $dim(V) = n = 2$:
    $
      rho(R_j) & = mat(cos((2 pi j)/n), sin((2 pi j)/n); -sin((2 pi j)/n), cos((2 pi j)/n)), quad rho(R_0) = mat(1, 0; 0, 1), \
      rho(S_0) & = mat(1, 0; 0, -1), quad rho(S_j) = mat(cos((2 pi j)/n), -sin((2 pi j)/n); -sin((2 pi j)/n), -cos((2 pi j)/n)).
    $
  ],
  [
    #canvas(length: 1cm, {
      import draw: *
      set-style(stroke: 0.7pt)
      let r = 0.9
      // vertices at 180°, 60°, 300°; reflection axis S_i labelled at the edge-midpoint end
      let pts = (180deg, 60deg, 300deg).map(a => (r * calc.cos(a), r * calc.sin(a)))
      line(..pts, close: true)
      for (i, a) in (180deg, 60deg, 300deg).enumerate() {
        let (c, s) = (calc.cos(a), calc.sin(a))
        line((1.2 * r * c, 1.2 * r * s), (-1.0 * r * c, -1.0 * r * s), stroke: (dash: "dashed", thickness: 0.5pt))
        content((-1.3 * r * c, -1.3 * r * s), $S_#i$)
      }
      // S_0 flip: curved double-headed arrow just right of the vertical edge
      bezier((0.6, -0.36), (0.6, 0.36), (0.95, 0), mark: (start: ">", end: ">", scale: 0.6))
      arc((0.75, 0.55), start: -20deg, stop: 60deg, radius: 0.5, mark: (end: ">"))
      content((1.25, 1.0), $R_i$)
    })
    $
      R_i R_j & = R_(i+j) \
      R_i S_j & = S_(i+j) \
      S_i R_j & = S_(i-j) \
      S_i S_j & = R_(i-j)
    $
  ],
)
Writing $a$ for the angle $(2 pi a)\/n$:
$
  rho(R_a) rho(R_b) & = mat(cos a, sin a; -sin a, cos a) mat(cos b, sin b; -sin b, cos b) = mat(cos a cos b - sin a sin b, cos a sin b + sin a cos b; -sin a cos b - cos a sin b, -sin a sin b + cos a cos b) \
  & = mat(cos(a + b), sin(a + b); -sin(a + b), cos(a + b)) = rho(R_(a+b)), \
  rho(R_a) rho(S_b) & = mat(cos a, sin a; -sin a, cos a) mat(cos b, -sin b; -sin b, -cos b) = mat(cos a cos b - sin a sin b, -cos a sin b - sin a cos b; -sin a cos b - cos a sin b, sin a sin b - cos a cos b) \
  & = mat(cos(a + b), -sin(a + b); -sin(a + b), -cos(a + b)) = rho(S_(a+b)).
$

- Every group has a _trivial representation_:
  $ dim(V) = 1, quad rho(g) = 1 quad ("maps everything to one"), quad rho(g) rho(g') = rho(g g'). $
  $~>$ This representation does not contain any information about the group.

- Representations containing all information about $G$ (no information has been lost) are called _faithful_:
  $ rho: G arrow.hook "GL"(V), quad "which is injective." $
  This means: $rho(g) = rho(g') -> g = g'$. If it is _not_ true: $exists g != e: rho(g) = "id"_V$ (identity in $V$) $<-$ degenerate representation.

  Recall: $ker(rho) lt.closed G$ $~>$ $rho$ descends to a faithful representation of #box(stroke: 0.5pt, inset: 3pt, $G \/ ker(rho)$).

  e.g. $G = S_n$ \
  (i) has a trivial one-dimensional representation, $rho(g) = 1$, \
  (ii) has a non-trivial one-dim. repr.: the _sign representation_
  $ rho(g) = (-1)^("length"(g)) quad [ "remember:" (-1)^("length"(g)): S_n -> ZZ_2 ], quad ker(rho) = A_n "(alternating group)". $
  $rho$ descends to a faithful representation of $S_n \/ A_n = ZZ_2$.

- *Building representations:* Given representations#footnote[All the representations that we will consider are representations of a $"GL"$ of a vector space.]
  $ rho_1: G -> "GL"(V_1), quad rho_2: G -> "GL"(V_2). $

  (i) _Direct sum_
  $
    rho_1 plus.o rho_2 (g) = rho_1 (g) plus.o rho_2 (g) = mat(rho_1 (g), 0; 0, rho_2 (g), augment: #(hline: 1, vline: 1)), quad V_(rho_1 plus.o rho_2) = V_1 plus.o V_2,
  $
  $ dim(rho_1 plus.o rho_2) = dim(rho_1) + dim(rho_2), quad dim(rho) = "dim. of the representation vector space". $

  (ii) _Tensor product_: $V_(rho_1 times.o rho_2) = V_(rho_1) times.o V_(rho_2)$,
  $ rho_1 times.o rho_2 (g) = rho_1 (g) times.o rho_2 (g), quad dim(rho_1 times.o rho_2) = dim(rho_1) dot dim(rho_2). $

  (iii) _Dual representation_
  $ rho: G -> "GL"(V), quad "dual v.s." V^* := "Hom"(V, KK), $
  $ overline(rho): G -> "GL"(V^*), quad overline(rho)(g) = (rho(g^(-1)))^* quad ("dual map"). $
  #aside[About dual maps: $A: V -> W$, $A^*: W^* -> V^*$, $W^* = "Hom"(W, KK) in.rev w^*$, $A^* (w^*) = w^* compose A: V -> KK$, $in "Hom"(V, KK) = V^*$. Prop. of dual maps: $A: V -> W$, $B: W -> U$, $(B A)^* = A^* B^*$.]

  $overline(rho)$ is a representation:
  $
    overline(rho)(g) overline(rho)(h) & = (rho(g^(-1)))^* (rho(h^(-1)))^* = (rho(h^(-1)) rho(g^(-1)))^* = (rho(h^(-1) g^(-1)))^* = (rho((g h)^(-1)))^* = overline(rho)(g h).
  $

- *Subrepresentations*

  *Def:* An _invariant subspace_ $W$ of a representation $rho: G -> "GL"(V)$ is a subspace $W subset V$ s.t.
  $ rho(g)(W) subset W quad => quad rho(g)|_W "is a subrepresentation." $
  $rho|_W: G -> "GL"(W)$ is a #underline[representation] on its own.

  *Def:* $rho$ is called _irreducible_ if there are #underline[no] invariant subspaces except ${0}$ and $V$. Otherwise (if it's not irreducible) it is called _reducible_. In matrix form (in a particular basis) this means
  $ rho(g) = mat(rho|_W (g), *; 0, *, augment: #(hline: 1, vline: 1)) quad ("reducible representation"). $

- A repr. $rho$ is called _decomposable_ if it is a direct sum $rho = rho_1 plus.o rho_2$. In matrix form (in a particular basis):
  $ rho(g) = mat(rho_1 (g), 0; 0, rho_2 (g), augment: #(hline: 1, vline: 1)). $
  If it is not decomposable, it is called _indecomposable_.

- A repr. is called _fully decomposable_ if it can be decomposed in a direct sum of irreducible repr.:
  $ rho = rho_1 plus.o dots.c plus.o rho_n, quad rho_i: "irreducible representations". $

*Examples*

(i) $rho: ZZ -> "GL"(2)$,
$ rho(n) = mat(1, n; 0, 1), quad rho(n) rho(m) = rho(n + m): quad mat(1, n; 0, 1) mat(1, m; 0, 1) = mat(1, m + n; 0, 1). $
There is an invariant subspace (reducible): $RR^2 = "span"(e_1, e_2)$, $W = "span"(e_1)$ is invariant. But it is #underline[not decomposable], because $rho(n)$ cannot be diagonalised. $rho|_W$ is the trivial representation.

(ii) $G = S_3$, $V = "span"{e_1, e_2, e_3}$, $rho(pi)(e_i) = e_(pi(i))$. In basis:
$ rho((1 2)) = mat(0, 1, 0; 1, 0, 0; 0, 0, 1), quad rho((2 3)) = mat(1, 0, 0; 0, 0, 1; 0, 1, 0). $
Invariant subspace: $W = "span"{e_1 + e_2 + e_3}$, because
$ rho(pi)(e_1 + e_2 + e_3) = e_(pi(1)) + e_(pi(2)) + e_(pi(3)) = e_1 + e_2 + e_3. $
$W^perp = "span"{v_1 = e_1 - e_2, thin v_2 = e_2 - e_3}$:
$
  rho((1 2))|_(W^perp): cases(v_1 |-> -v_1, v_2 |-> v_1 + v_2) quad & "In matrix form:" quad rho((1 2)) = mat(-1, 1; 0, 1), \
  rho((2 3))|_(W^perp): cases(v_1 |-> v_1 + v_2, v_2 |-> -v_2) quad & "In matrix form:" quad rho((2 3)) = mat(1, 0; 1, -1).
$
$-> rho|_(W^perp)$ is irreducible.
$ rho = underbrace(rho|_W, "trivial") plus.o underbrace(rho|_(W^perp), "2dim irred. repr.") $
$~>$ Here we had a repr. that is $->$ reducible, $->$ fully decomposable.

*Examples* for building of representations:
$ rho_r: ZZ_n -> "GL"(CC), quad rho_r ([a]) = e^((2 pi i r a)/n). $
(i) Direct sum:
$ rho_r plus.o rho_s ([a]) = mat(e^((2 pi i r a)/n), 0; 0, e^((2 pi i s a)/n)). $
(ii) Tensor product: $CC times.o CC = CC$ $~>$ we'll get again a 1-dim representation:
$ rho_r times.o rho_s ([a]) = rho_r ([a]) times.o rho_s ([a]) = e^((2 pi i (r + s) a)/n) = rho_(r+s) ([a]). $
(iii) Dual representation: $CC^* = CC$,
$ overline(rho)_r ([a]) = rho_r ([a]^(-1)) = rho_r ([-a]) = e^(-(2 pi i r a)/n) = rho_(-r) ([a]). $
$ overline(rho)_r = rho_(-r), quad rho_r times.o rho_s = rho_(r+s). $

Special representations compatible with some structures:

- *Unitary representation*

  *Def:* A _unitary representation_ $rho$ is a repr. on a Hermitian vector space $(V, chevron.l dot, dot chevron.r)$, $chevron.l a, b chevron.r = overline(chevron.l b\, a chevron.r)$, s.t.
  $ rho: G -> cal(U)(V) = {T in "GL"(V) mid(|) chevron.l T a, T b chevron.r = chevron.l a, b chevron.r med forall a, b in V} subset "GL"(V), $
  where the condition means $(T^*)^t T = T^dagger T = "id"_V$.

  Unitary representations are nice:

  *Fact:* Unitary repr. are fully decomposable.

  _Proof._ Assume $rho: G -> U(V)$, $W subset V$ is an invariant subspace $=>$ $W^perp$ is an invariant subspace as well:
  $ W^perp = {v in V mid(|) chevron.l v, w chevron.r = 0 med forall w in W}. $
  $ forall v in W^perp, w in W: quad 0 = chevron.l v, w chevron.r = chevron.l v, rho(g) w chevron.r = chevron.l rho(g^(-1)) v, w chevron.r $
  $=> W^perp$ is an invariant subspace as well $=> rho = rho|_W plus.o rho|_(W^perp)$. Iteratively,
  $ rho = plus.o.big_i rho_i quad (rho_i: "irreducible representations"). $
  #h(1fr) $square$ \
  $->$ The building blocks of unitary repres. are the irreducible repr.

- *Maps between representations*

  *Def:* An _intertwiner_ between two representations
  $ rho_1: G -> "GL"(V_1), quad rho_2: G -> "GL"(V_2) $
  is a linear map $f: V_1 -> V_2$ s.t.
  $ rho_2 (g) compose f = f compose rho_1 (g) quad forall g in G. $
  #grid(
    columns: (auto, 1fr),
    column-gutter: 2em,
    align: horizon,
    canvas(length: 1cm, {
      import draw: *
      set-style(stroke: 0.6pt, mark: (end: ">", fill: black, scale: 0.6))
      content((0, 1.6), $V_1$, name: "a")
      content((2.4, 1.6), $V_1$, name: "b")
      content((0, 0), $V_2$, name: "c")
      content((2.4, 0), $V_2$, name: "d")
      line((0.35, 1.6), (2.05, 1.6))
      line((0.35, 0), (2.05, 0))
      line((0, 1.3), (0, 0.3))
      line((2.4, 1.3), (2.4, 0.3))
      content((1.2, 1.95), $rho_1 (g)$)
      content((1.2, -0.35), $rho_2 (g)$)
      content((-0.25, 0.8), $f$)
      content((2.65, 0.8), $f$)
      arc((0.92, 0.75), start: 200deg, delta: 220deg, radius: 0.3, mark: (end: ">"))
    }),
    [only #underline[one] $f$ for every $g$],
  )
  If $f$ is invertible $=>$ #underline[equivalence of representations]:
  $ rho_1 (g) = f^(-1) rho_2 (g) f quad ("change of basis transf."), $
  (requires $dim(V_1) = dim(V_2)$).

  *Remark:* $"Im"(f)$ (image of $f$) and $ker(f)$ are invariant subspaces.

  _Proof._
  - $ rho_2 (g) underbrace(f(v), in "Im"(f)) attach(=, b: #stack(spacing: 2pt, [def. of], [intertwiner])) underbrace(f compose rho_1 (g)(v), in "Im"(f)) quad => quad "Im"(f) "is an invariant subspace." $
  - $f(v) = 0$, i.e. $v in ker(f)$:
    $ underbrace(rho_2 (g) f(v), 0) = f compose rho_1 (g) v quad => quad rho_1 (g) v in ker(f) quad -> ker(f) "is an invariant subspace." $
    #h(1fr) $square$

#block(stroke: 0.6pt, inset: 9pt, radius: 2pt, width: 100%)[
  *Schur's Lemma:* If $rho_1$ and $rho_2$ are irreducible repr. of a group $G$ and $f: V_1 -> V_2$ is an intertwiner, then: \
  (i) either $f equiv 0$ or $f$ is an isomorphism, \
  (ii) if $V_1 tilde.equiv V_2$ $=> f = lambda "id"$, $lambda in CC$ (over $CC$).
]

_Proof._ (i) $f: V_1 -> V_2$ is an intertwiner.
$
  ker(f) "is an invariant subspace" & attach(=>, t: "irreducibility of" rho_1) ker(f) = V_1 thick (f equiv 0) quad "or" quad ker(f) = {0} thick (f "injective"), \
  "Im"(f) "is an invariant subspace" & attach(=>, t: "irreducibility of" rho_2) "Im"(f) = {0} thick (f equiv 0) quad "or" quad "Im"(f) = V_2 thick (f "surjective").
$
This shows (i).

(ii) Over $CC$ (we have already set $V = V_1 = V_2$): since $CC$ is algebraically closed, $f$ has at least one eigenvalue $lambda$.
$ f' = (f - lambda "id"_V) "is still an intertwiner," $
but now $ker(f') != {0}$, by irreducibility $ker(f') = V$
$ => f' = (f - lambda "id") equiv 0. $
This shows (ii). #h(1fr) $square$

*Remark:* If two irreducible representations over $CC$ are equivalent as in (ii), then all the intertwiners are multiples of each other:
$ f_1, f_2: V_1 -> V_2, quad f_2 != 0 quad => quad underbrace(f_2^(-1) f_1, lambda "id"): V_1 -> V_1 quad => quad #box(stroke: 0.5pt, inset: 3pt, $f_1 = lambda f_2$), quad lambda in CC. $
Note: this works over $CC$!

_Aside:_ $RR$ is not algebraically closed
- $~>$ not every intertwiner has an eigenvalue,
- $~>$ the arguments above do not work,
- $~>$ not all intertwiners over $RR$ are multiples of each other.

$arrow.r.turn$ This is the bad news. However, $RR$ still has enough structure: the intertwiners form an #underline[associative division algebra]:
- can add them,
- can multiply them,
- if they are not zero, one can divide by them,
- since repr. by matrices, associative.

Division algebras:
- (associative) division algebra over $CC$: $CC$,
- division algebras over $RR$: $RR$, $CC$, $HH$ (quaternions).
