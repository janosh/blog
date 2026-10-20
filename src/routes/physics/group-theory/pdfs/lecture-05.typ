#import "/notes.typ": notes
#import "@preview/cetz:0.5.2": canvas, draw

#show: notes.with(
  title: [4\. Representations of Finite Groups],
  subtitle: [Lecture 5, Group Theory, Prof. Daniel Roggenkamp],
  date: [Lecture notes by Janosh Riebesell, 20.05.2015 and 27.05.2015],
)

// Young diagram/tableau: each row is either a box count or an array of box entries
#let young(rows, s: 0.3) = box(baseline: 50%, canvas(length: 1cm, {
  import draw: *
  set-style(stroke: 0.6pt)
  for (r, row) in rows.enumerate() {
    let cells = if type(row) == int { range(row).map(_ => none) } else { row }
    for (c, val) in cells.enumerate() {
      rect((c * s, -r * s), ((c + 1) * s, -(r + 1) * s))
      if val != none { content(((c + 0.5) * s, -(r + 0.5) * s), text(size: 8pt, $#val$)) }
    }
  }
}))

// character table with a double rule after the label column and the header row
#let char-table(header-rows: 1, ..args) = table(
  stroke: (x, y) => (
    left: if x == 1 { (thickness: 0.6pt) },
    top: if y == header-rows { (thickness: 0.6pt) },
  ),
  inset: (x: 8pt, y: 5pt),
  align: center + horizon,
  ..args,
)

$|G| < oo$, complex representations.

*Fact:* Any representation of $G$ is fully decomposable.

_Proof._ $W subset V$ (repr.) is an invariant subspace. Choose a projector $pi_0: V -> V$ onto $W$, i.e. $"Im"(pi_0) = W$. Define
$ pi := 1/(|G|) sum_(g in G) rho(g) pi_0 rho(g^(-1)): V -> V. $
i) $pi$ is still a projector on $W$, \
ii) $pi$ is an intertwiner.

From this it follows
$
  V attach(=, t: pi "is a projector") underbrace("Im"(pi), W) plus.o underbrace(ker(pi), #stack(spacing: 3pt, [is invariant subspace,], [because $pi$ is intertwiner]))
$

i)
$
  pi^2 & = 1/(|G|^2) sum_(g, k in G) rho(g) pi_0 rho(g^(-1)) rho(k) pi_0 rho(k^(-1)) = 1/(|G|) sum_(k in G) rho(k) pi_0 rho(k^(-1)) = pi, \
  pi|_W & = "id"_W.
$
ii)
$
  pi compose rho(h) & = 1/(|G|) sum_(g in G) rho(g) pi_0 overbrace(rho(g^(-1)) rho(h), rho(g^(-1) h)) quad (g |-> h g) \
  & = 1/(|G|) sum_(g in G) underbrace(rho(h g), rho(h) rho(g)) pi_0 rho(g^(-1)) = rho(h) pi.
$
#h(1fr) $square$

Any representation $rho$ of a finite group decomposes into a sum of irreducible representations:
$ rho = rho_1^(plus.o n_1) plus.o dots.c plus.o rho_k^(plus.o n_k), quad n_i in NN_0. $

*Remark:* Proof by averaging over the group $->$ can be repeated for non-finite but compact groups, where instead of summing, one can integrate.

= Decomposition

Start with a representation $rho: G -> "GL"(V)$,
$ pi := 1/(|G|) sum_(g in G) rho(g): V -> V. $
- It is a projector on the #underline[invariant subspace]
  $ V^G := {v in V mid(|) rho(g) v = v med forall g in G}. $

(i)
$ pi^2 = 1/(|G|^2) sum_(g, h in G) underbrace(rho(g) rho(h), rho(g h)) quad (g |-> g h^(-1)) quad = 1/(|G|) sum_(g in G) rho(g) = pi. $
(ii) $v in V^G$: $pi v = v$ $=> pi|_(V^G) = "id"_(V^G)$ $=> V^G subset "Im"(pi)$.
$ rho(g) pi w = rho(g) 1/(|G|) sum_(h in G) rho(h) w = pi w $
$=> "Im"(pi) subset V^G$ $=> V^G = "Im"(pi)$ \
$-> pi$ projects on $V^G = "Im"(pi)$.

We want to know the dimension of $V^G$:
$
  dim(V^G) = "Tr"_V (pi) = 1/(|G|) sum_(g in G) underbrace("Tr"_V (rho(g)), chi_rho (g) = chi_V (g)) = 1/(|G|) sum_(g in G) chi_rho (g),
$
where $chi_rho (g) = chi_V (g)$ is the _character_ of the representation $rho$, $V$.

Apply this:
$ "Hom"(V_1, V_2) tilde.equiv V_1^* times.o V_2 quad "carries repr." overline(rho)_1 times.o rho_2, $
$ overline(rho)_1 times.o rho_2 (g): f |-> rho_2 (g) compose f compose rho_1 (g^(-1)), $
$ "Hom"(V_1, V_2)^G = {f in "Hom"(V_1, V_2) mid(|) rho_2 (g) compose f compose rho_1 (g^(-1)) = f} = "space of intertwiners". $

If $rho_1$ and $rho_2$ are irreducible, by Schur's lemma
$ dim("Hom"(V_1, V_2)^G) = cases(1\, & rho_1 tilde.equiv rho_2, 0 & "otherwise".) $
Then:
$
  cases(1\, & rho_1 tilde.equiv rho_2, 0 & "otherwise") & = 1/(|G|) sum_(g in G) chi_(overline(rho)_1 times.o rho_2) (g) = 1/(|G|) sum_(g in G) "Tr"_(V_1^* times.o V_2) (overline(rho)_1 (g) times.o rho_2 (g)) quad (overline(rho)_1 (g) = rho_1 (g^(-1)) "on" V_1) \
  & = 1/(|G|) sum_(g in G) "Tr"_(V_1^*) (overline(rho)_1 (g)) dot underbrace("Tr"_(V_2) (rho_2 (g)), chi_2 (g)) = 1/(|G|) sum_(g in G) chi_1 (g^(-1)) chi_2 (g).
$
$ 1/(|G|) sum_(g in G) chi_i (g^(-1)) dot chi_j (g) = delta_(i j) quad ("for" i, j "running over irreducible representations"). $

$ V = V_1^(plus.o n_1) plus.o dots.c plus.o V_k^(plus.o n_k), quad "Hom"(V_i, V) = plus.o.big_a "Hom"(V_i, V_a)^(plus.o n_a), $
#align(center, box(stroke: 0.6pt, inset: 6pt, $ n_i = "Tr"_("Hom"(V_i, V)) (pi_i) = 1/(|G|) sum_(g in G) chi_(rho_i) (g^(-1)) chi_rho (g) $))

From characters one can obtain the decomposition of $V$.

Can do more: identify the respective subrepresentation.

Next step: how to localize a subspace $V_i$ in $V$.

*Projector on $V_1^(plus.o n_1)$*
$ pi_(rho_1) := overbrace(dim(V_1), d_1)/(|G|) sum_(g in G) chi_(rho_1) (g^(-1)) rho(g): V -> V. $

i) $pi_(rho_1)$ is an intertwiner:
$
  pi_(rho_1) compose rho(h) & = d_1/(|G|) sum_(g in G) chi_(rho_1) (g^(-1)) rho(g h) = d_1/(|G|) sum_(g in G) underbrace(chi_(rho_1) (h g^(-1) h^(-1)), chi_(rho_1) (g^(-1))) rho(h g) = rho(h) pi_(rho_1),
$
by cyclicity of the trace:
$ chi_(rho_1) (h g^(-1) h^(-1)) = "Tr"(rho_1 (h g^(-1) h^(-1))) = "Tr"(rho_1 (h) rho_1 (g^(-1)) rho_1 (h^(-1))) = "Tr"(rho_1 (h^(-1)) rho_1 (h) rho_1 (g^(-1))) = "Tr"(rho_1 (g^(-1))). $

ii) $pi_rho$ is a projector:
$
  pi_rho^2 & = d_1^2/(|G|^2) sum_(g, h in G) chi_(rho_1) (g^(-1)) chi_(rho_1) (h^(-1)) rho(g h) quad (g |-> g h^(-1)) \
  & = d_1^2/(|G|^2) sum_(g, h) chi_(rho_1) (h g^(-1)) chi_(rho_1) (h^(-1)) rho(g) = d_1/(|G|) sum_(g in G) chi_(rho_1) (g^(-1)) rho(g) = pi_(rho_1),
$
where we used Ex. 3c) from problem sheet 2:
$ sum_h chi_(rho_i) (h g^(-1)) chi_(rho_j) (h^(-1)) = chi_(rho_i) (g^(-1)) (|G|)/d_i delta_(i j). $

iii) $pi_(rho_1)$ projects onto $V_1^(plus.o n_1) subset V$. Look at the representation
$ "Im"(pi_(rho_1)) = V_1^(plus.o n'_1) plus.o dots.c plus.o V_k^(plus.o n'_k). $
Want to show that $n'_1 = n_1$:
$ n'_i = 1/(|G|) sum_(g in G) chi_(rho_i) (g^(-1)) chi_("Im"(pi_(rho_1))) (g), $
$
  chi_("Im"(pi_(rho_1))) (g) & = "Tr"_("Im"(pi_(rho_1))) rho(g) = "Tr"_V (pi_(rho_1) rho(g)) = d_1/(|G|) sum_(h in G) chi_(rho_1) (h^(-1)) underbrace("Tr"_V (rho(h) rho(g)), "Tr"_V (rho(h g)) = chi_V (h g)) = d_1/(|G|) sum_(h in G) chi_(rho_1) (h^(-1)) chi_V (h g),
$
$
  n'_i & = d_1/(|G|^2) sum_(g, h) chi_(rho_i) (g^(-1)) chi_(rho_1) (h^(-1)) chi_V (h g) quad (g |-> h^(-1) g) \
  & = d_1/(|G|^2) sum_(g, h) chi_(rho_i) (g^(-1) h) chi_(rho_1) (h^(-1)) chi_V (g) attach(=, t: "Ex. 3") delta_(i, 1) underbrace(1/(|G|) sum_(g in G) chi_(rho_i) (g^(-1)) chi_V (g), n_i) = delta_(i, 1) n_i
$
$-> pi_(rho_1)$ projects onto $V_1^(plus.o n_1) subset V$.

= Characters of irreducible representations

$ chi_rho (g) = "Tr"(rho(g)). $
*Properties*
$
  "i)" & quad chi_(rho_1 plus.o rho_2) (g) = chi_(rho_1) (g) + chi_(rho_2) (g), \
  "ii)" & quad chi_(rho_1 times.o rho_2) (g) = chi_(rho_1) (g) dot chi_(rho_2) (g), \
  "iii)" & quad chi_rho (e) = dim(rho) quad ("dimension of the representation space"), \
  "iv)" & quad chi_rho (g^(-1)) = overline(chi_rho (g)), \
  "v)" & quad chi_rho (h^(-1) g h) = chi_rho (g) quad "by cyclicity of the trace:" chi_rho "only depends on the conjugacy class of" g!
$
$-> chi_rho$ is a #underline[class function].

Space of class functions:
$ CC^"class" (G) := {f: G -> CC mid(|) f(h^(-1) g h) = f(g)} $
is a vector space, with
$ dim(CC^"class" (G)) = \# "conjugacy classes in" G. $
On this space define a Hermitian form
$ (alpha, beta) := 1/(|G|) sum_(g in G) overline(alpha(g)) beta(g). $
$ chi_i := chi_(rho_i) in CC^"class" (G) quad (rho_i "irreducible"), quad (chi_i, chi_j) = delta_(i, j) quad "orthonormal set" $
$-> \# "irred. repres." <= \# "conjugacy classes"$.

Want to show: $chi_i$ are an ON basis of $CC^"class" (G)$
- $chi_i$ are linearly independent
- $->$ characterize representations completely.

_Proof._ We have already seen that the $chi_i$ are an ON set in $CC^"class" (G)$. It is a basis if $(alpha, chi_j) = 0 med forall j => alpha = 0$.

Assume $(alpha, chi_i) = 0 med forall i$.
$ phi_alpha^(rho_i) := sum_g overline(alpha(g)) rho_i (g): V_i -> V_i. $
This is an intertwiner:
$
  phi_alpha^(rho_i) rho_i (h) & = sum_g overline(alpha(g)) rho_i (g h) quad (g |-> h g h^(-1)) \
  & = sum_g overline(alpha(h g h^(-1))) rho_i (h g) = rho_i (h) sum_g underbrace(overline(alpha(h g h^(-1))), overline(alpha(g))) rho_i (g) = rho_i (h) phi_alpha^(rho_i) quad -> "intertwiner".
$
$V_i$ irreducible, by Schur's lemma: $phi_alpha^(rho_i) = lambda_i "id"_(V_i)$,
$
  lambda_i = ("Tr"(phi_alpha^(rho_i)))/(dim(V_i)) = 1/d_i sum_g overline(alpha(g)) chi_(rho_i) (g) = (|G|)/d_i (alpha, chi_(rho_i)) = 0 quad => quad #box(stroke: 0.5pt, inset: 3pt, $phi_alpha^(rho_i) equiv 0$) quad forall i
$
$
  => sum_g overline(alpha(g)) rho_i (g) & = 0 quad forall i \
  => sum_g overline(alpha(g)) rho(g) & = 0 quad forall "repres." rho.
$
Find a representation $rho$ such that all $rho(g_i)$ are linearly independent $=> overline(alpha(g)) = 0 med forall g$.

A representation for which this holds is the so-called #underline[regular representation]:
$ V = CC[G] = {sum_i alpha_i g_i mid(|) alpha_i in CC} quad ("group algebra of" G), $
$ rho(g)(sum alpha_i g_i) = sum alpha_i (g g_i), $
$ sum alpha_i rho(g_i) g = sum alpha_i (g_i g) = 0 quad "only if" alpha_i = 0 med forall i $
$-> rho(g_i)$ are linearly independent. #h(1fr) $square$

$-> chi_i$ is an orthonormal basis of $CC^"class" (G)$, $dim CC^"class" (G) = \# "conj. classes of" G$
#align(center, box(stroke: 0.6pt, inset: 6pt)[$->$ as many irreducible representations as there are conjugacy classes])
$->$ Characters determine repr.

*Character table*

#grid(
  columns: (auto, 1fr),
  column-gutter: 2em,
  align: horizon,
  char-table(
    columns: 5,
    $G$, $C_1$, $C_2$, $dots.c$, $C_k$,
    $rho_1$, $chi_1 (C_1) = d_1$, $chi_1 (C_2)$, [], [],
    $dots.v$, [], [], [], [],
    $rho_k$, $chi_k (C_1) = d_k$, $dots.c$, [], $chi_k (C_k)$,
  ),
  [
    $C_1$: conjugacy class of the identity, \
    $k = \#$ conj. classes of $G$,
    #align(center, box(stroke: 0.5pt, inset: 4pt, $chi_(i a) := chi_i (C_a)$))
  ],
)
$
  delta_(i j) = 1/(|G|) sum_g overline(chi_i (g)) chi_j (g) = sum_a overline(chi_i (C_a)) chi_j (C_a) (|C_a|)/(|G|) quad ("orthogonality of rows").
$
With
$ D_(a b) := (|C_a|)/(|G|) delta_(a b): quad X D overline(X)^T = bb(1)_k quad => quad (overline(X)^T) X = D^(-1) $
#align(center, box(stroke: 0.6pt, inset: 6pt, $ => sum_i overline(chi_i (C_a)) dot chi_i (C_b) = delta_(a b) (|G|)/(|C_a|) quad ("orthogonality of columns"). $))
This constrains the character table.

Another constraint from the regular representation:
$ rho^"reg" (g)(sum alpha_i g_i) = sum alpha_i (g g_i), $
$
  chi_"reg" (g) = "Tr"_(CC[G]) (rho^"reg" (g)) = \#{i mid(|) g dot g_i = g_i} = cases(|G|\, & g = e, 0 & "otherwise",)
$
where the trace is taken in the basis $g_i$, $rho(g) g_i = (g dot g_i)$.
$ rho^"reg" = rho_1^(plus.o n_1) plus.o dots.c plus.o rho_k^(plus.o n_k), $
$ n_i = (chi_(rho_i), chi_"reg") = 1/(|G|) sum_(g in G) chi_(rho_i) (g^(-1)) chi_(rho^"reg") (g) = 1/(|G|) dim(rho_i) dot |G| = dim(rho_i) $
$ => rho^"reg" = rho_1^(plus.o d_1) plus.o dots.c plus.o rho_k^(plus.o d_k), quad d_i = dim(rho_i), $
$ dim(rho^"reg") = dim(CC[G]) = |G| = sum_i d_i^2 quad => quad #box(stroke: 0.5pt, inset: 4pt, $|G| = sum d_i^2$) $

*Example:* $D_3 tilde.equiv S_3$, $|D_3| = 6$. Conjugacy classes:
#align(center, table(
  columns: 3,
  stroke: none,
  align: left + horizon,
  inset: (x: 10pt, y: 6pt),
  $(dot)(dot)(dot)$, young((1, 1, 1)), $C_0 = C(R_0) = {R_0} = {e}$,
  $(dot dot)(dot)$, young((2, 1)), $C_1 = C(S_0) = {S_0, S_1, S_2}$,
  $(dot dot dot)$, young((3,)), $C_2 = C(R_1) = {R_1, R_2}$,
))
$->$ 3 irreducible representations.

#align(center, char-table(
  columns: 4,
  header-rows: 2,
  $D_3 \/ S_3$, $C_0$, $C_1$, $C_2$,
  [$|C_a|$], $1$, $3$, $2$,
  $rho^"triv"$, $1$, $1$, $1$,
  $rho^"sgn"$, $1$, $-1$, $1$,
  [$rho_2$ (#sym.ast)], $2$, $alpha = 0$, $beta = -1$,
  [$rho^P$ (#sym.ast#sym.ast)], $3$, $1$, $0$,
))

(#sym.ast) $|G| = sum d_i^2$: $quad 6 = 1 + 1 + d_2^2 -> d_2 = 2$.

Obtain $alpha$ and $beta$ using orthogonality:
$
  0 & = (chi_"triv", chi_2) = 1/6 (2 dot 1 + 3 dot alpha + 2 dot beta), \
  0 & = (chi_"sgn", chi_2) = 1/6 (2 - 3 dot alpha + 2 beta) quad => quad alpha = 0, quad beta = -1.
$
Look at
$ rho(S_0) = mat(1, 0; 0, -1), quad rho(R_i) = mat(cos((2 pi)/3 i), -sin((2 pi i)/3); sin((2 pi)/3 i), cos((2 pi i)/3)), $
$ chi_rho (C_0) = 2, quad chi_rho (C_1) = 0, quad chi_rho (C_2) = 2 cos((2 pi)/3) = -1. $
$rho tilde.equiv rho_2$ because the characters agree.

(#sym.ast#sym.ast) #underline[Permutation representation]:
$ rho^P (e) = bb(1)_3, quad rho^P (R_1) = mat(0, 0, 1; 1, 0, 0; 0, 1, 0), quad rho^P (S_0) = mat(1, 0, 0; 0, 0, 1; 0, 1, 0), $
$ chi_P (C_0) = 3, quad chi_P (C_1) = 1, quad chi_P (C_2) = 0, $
$ rho^P = rho_"triv"^(plus.o n_1) plus.o rho_"sign"^(plus.o n_2) plus.o rho_2^(plus.o n_3), $
$
  n_1 & = (chi_"triv", chi_3) = 1/6 (3 dot 1 + 3 dot 1) = 1, \
  n_2 & = (chi_"sign", chi_3) = 1/6 (3 dot 1 - 3 dot 1) = 0, \
  n_3 & = (chi_2, chi_3) = 1/6 (3 dot 2) = 1,
$
where $chi_3 = chi_P$:
#align(center, box(stroke: 0.5pt, inset: 4pt, $rho^P tilde.equiv rho_"triv" plus.o rho_2$))

#underline[Projectors]:
$
  pi_"triv" & = 1/6 sum_g overline(chi_"triv" (g)) rho^P (g) = 1/3 mat(1, 1, 1; 1, 1, 1; 1, 1, 1) quad "projector on" CC(e_1 + e_2 + e_3), \
  pi_2 & = overbrace(2, "dimensionality")/6 (2 mat(1, 0, 0; 0, 1, 0; 0, 0, 1) - mat(0, 1, 1; 1, 0, 1; 1, 1, 0)) = 1/3 mat(2, -1, -1; -1, 2, -1; -1, -1, 2)
$
$->$ projector on the space $"span"{e_1 - e_2, e_2 - e_3}$.

#line(length: 100%, stroke: 0.4pt)

#align(right, text(fill: luma(90))[27.05.2015])

Summary from last lecture:
- Complex representations of finite groups are fully decomposable:
  $ rho = plus.o.big_i underbrace(rho_i^(plus.o n_i), "irreducible repres.") = underbrace(rho_1 plus.o dots.c plus.o rho_1, n_1) plus.o underbrace(rho_2 plus.o dots.c plus.o rho_2, n_2) plus.o dots.c $
- As many irred. reprs. as there are conjugacy classes in $G$.
- Repres. determined by #underline[characters]: $chi_rho (g) = "Tr"_(V_rho) (rho(g))$, $(chi_i = chi_(rho_i))$, characters of irr. reps. are an ON basis of class functions.
- $ n_i = (chi_i, chi_rho) = 1/(|G|) sum_(g in G) underbrace(chi_i (g^(-1)), overline(chi_i (g))) chi_rho (g). $
- Projector
  $ pi_i = d_i/(|G|) sum_(g in G) chi_i (g^(-1)) rho(g): V -> V "projects onto" V_i^(plus.o n_i) subset V, quad d_i equiv dim(rho_i). $
- Character table:
  #align(center, char-table(
    columns: 5,
    $G$, [$C_1 = [e]$ \ $|C_1| = 1$], [$C_2$ \ $|C_2|$], $dots.c$, [$C_k$ \ $|C_k|$],
    $rho_1$, $d_1 = chi_1 (C_1)$, [], $dots.c$, $chi_1 (C_k)$,
    $dots.v$, $dots.v$, [], [], [],
    $rho_k$, $d_k = chi_k (C_1)$, [], $dots.c$, $chi_k (C_k)$,
  ))
  $
    sum_a (|C_a|)/(|G|) overline(chi_i (C_a)) chi_j (C_a) & = delta_(i, j), \
    sum_i (|C_a|)/(|G|) overline(chi_i (C_a)) chi_i (C_b) & = delta_(a b), \
    sum_i d_i^2 & = |G|.
  $

#grid(
  columns: (1fr, auto),
  align: horizon,
  [
    *Example:* $D_3 = {R_0, R_1, R_2, S_0, S_1, S_2}$, $R_0 = e$.
    $
      C_1 & = C(R_0) = {R_0}, \
      C_2 & = C(S_0) = {S_0, S_1, S_2}, \
      C_3 & = C(R_1) = {R_1, R_2}.
    $
  ],
  canvas(length: 1cm, {
    import draw: *
    set-style(stroke: 0.7pt)
    let r = 0.75
    let angles = (90deg, 210deg, 330deg)
    line(..angles.map(a => (r * calc.cos(a), r * calc.sin(a))), close: true)
    for a in angles {
      let (c, s) = (calc.cos(a), calc.sin(a))
      line((1.3 * r * c, 1.3 * r * s), (-0.85 * r * c, -0.85 * r * s), stroke: (dash: "dashed", thickness: 0.5pt))
    }
  }),
)

#grid(
  columns: (auto, 1fr),
  column-gutter: 2em,
  [
    #char-table(
      columns: 4,
      $D_3$, [$C_1$ \ $1$], [$C_2$ \ $3$], [$C_3$ \ $2$],
      $rho_0$, $1$, $1$, $1$,
      $rho_1$, $1$, $-1$, $1$,
      $rho_2$, $2$, $0$, $-1$,
      table.hline(stroke: 0.6pt),
      $rho_3$, [$3$ \ #text(size: 8pt, $"Tr" rho_3 (R_0)$)], [$1$ \ #text(size: 8pt, $"Tr" rho_3 (S_0)$)], [$0$ \ #text(size: 8pt, $"Tr" rho_3 (R_1)$)],
    )
  ],
  [
    $rho_0$: trivial repr., $V = CC$, $rho_0 (g) = 1$, $chi_0 (C_1) = 1$.

    $rho_1$: sign repr., $V = CC$,
    $ rho_1: cases(R_i |-> 1, S_i |-> -1) quad chi_1 (C_1) = 1, quad chi_1 (C_3) = 1, quad chi_1 (C_2) = -1. $
  ],
)
$rho_2$: 2d rep.
$
  rho_2 (R_0) = mat(1, 0; 0, 1), quad rho_2 (R_1) = mat(cos((2 pi)/3), sin((2 pi)/3); -sin((2 pi)/3), cos((2 pi)/3)), quad rho_2 (R_2) = dots.c, \
  rho_2 (S_0) = mat(1, 0; 0, -1), quad rho_2 (S_1) = dots.c
$

#underline[Permutation representation]: $V = "span"{e_1, e_2, e_3}$,
$
  R_0: cases(e_1 |-> e_1, e_2 |-> e_2, e_3 |-> e_3) quad R_1: cases(e_1 |-> e_2, e_2 |-> e_3, e_3 |-> e_1) quad R_2: cases(e_1 |-> e_3, e_2 |-> e_1, e_3 |-> e_2) quad S_0: cases(e_1 |-> e_1, e_2 |-> e_3, e_3 |-> e_2) quad dots.c
$
$
  rho_3 (R_0) & = mat(1, 0, 0; 0, 1, 0; 0, 0, 1), quad & rho_3 (S_0) & = mat(1, 0, 0; 0, 0, 1; 0, 1, 0), \
  rho_3 (R_2) & = mat(0, 1, 0; 0, 0, 1; 1, 0, 0), quad & rho_3 (S_1) & = mat(0, 0, 1; 0, 1, 0; 1, 0, 0), \
  rho_3 (R_1) & = mat(0, 0, 1; 1, 0, 0; 0, 1, 0), quad & rho_3 (S_2) & = mat(0, 1, 0; 1, 0, 0; 0, 0, 1).
$
$ rho_3 = rho_0^(plus.o n_0) plus.o rho_1^(plus.o n_1) plus.o rho_2^(plus.o n_2), $
$
  n_0 & = (chi_0, chi_3) = 1/6 (3 dot 1 dot 1 + 1 dot 1 dot 3) = 1, \
  n_1 & = (chi_1, chi_3) = 1/6 (3 - 3) = 0, \
  n_2 & = (chi_2, chi_3) = 1/6 dot 6 = 1,
$
#align(center, box(stroke: 0.5pt, inset: 4pt, $rho_3 tilde.equiv rho_0 plus.o rho_2$))

#underline[Projector]:
$
  pi_0 & = 1/6 sum_(g in G) overline(chi_0 (g)) rho_3 (g) = 1/3 mat(1, 1, 1; 1, 1, 1; 1, 1, 1) quad ~> "projection on" "span"{e_1 + e_2 + e_3}, \
  pi_2 & = 2/6 sum_(g in G) overline(chi_2 (g)) rho_3 (g) = 1/3 (2 mat(1, 0, 0; 0, 1, 0; 0, 0, 1) - mat(0, 1, 1; 1, 0, 1; 1, 1, 0)) = 1/3 mat(2, -1, -1; -1, 2, -1; -1, -1, 2) \
  & ~> "projection on" V_2 = "span"{e_1 - e_2, e_2 - e_3},
$
with $V_0 subset V_3 = "span"(e_1, e_2, e_3)$, $V_0 = CC(e_1 + e_2 + e_3)$.

$ rho_4 = rho_2 times.o rho_2 = rho_0^(plus.o n_0) plus.o rho_1^(plus.o n_1) plus.o rho_2^(plus.o n_2), quad chi_4 (g) = (chi_2 (g))^2, $
$
  cases(
    reverse: #true,
    n_0 = (chi_0, chi_4) = 1/6 (4 + 2) = 1,
    n_1 = (chi_1, chi_4) = 1/6 (4 + 2) = 1,
    n_2 = (chi_2, chi_4) = 1/6 (8 - 2) = 1,
  ) quad => quad rho_4 tilde.equiv rho_0 plus.o rho_1 plus.o rho_2.
$
