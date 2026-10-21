#import "/notes.typ": notes
#import "@preview/cetz:0.5.2": canvas, decorations, draw

#show: notes.with(
  title: [5\. Representations of $S_n$],
  subtitle: [Lecture 6, Group Theory, Prof. Daniel Roggenkamp],
  date: [Lecture notes by Janosh Riebesell, 27.05.2015],
)

// Young diagram/tableau: each row is either a box count or an array of box entries (none = empty box)
#let young(rows, s: 0.38, size: 8.5pt) = box(baseline: 50%, canvas(length: 1cm, {
  import draw: *
  set-style(stroke: 0.6pt)
  for (r, row) in rows.enumerate() {
    let cells = if type(row) == int { range(row).map(_ => none) } else { row }
    for (c, val) in cells.enumerate() {
      rect((c * s, -r * s), ((c + 1) * s, -(r + 1) * s))
      if val != none { content(((c + 0.5) * s, -(r + 0.5) * s), text(size: size, [#val])) }
    }
  }
}))

- Show up in the quantum description of many-particle systems.
- Play an important role in the representation theory of $"SU"(n)$.

$|S_n| = n! < oo$ $->$ all complex repr. are fully decomposable.
$ "need to study irred. repres." quad attach(<-->, t: 1:1) quad "conjugacy classes" $

*Recall*

- Conjugacy classes:
  $ S_n in.rev pi = (i_1^1, dots, i_(r_1)^1) dot (i_1^2, dots, i_(r_2)^2) dots.c (i_1^m dots i_(r_m)^m), $
  $ k_i := \# "cycles of length" i, quad sum_i i k_i = n, $
  $(k_1, dots, k_n)$ $<-$ cycle structure, $arrow.r.turn$ determines the conjugacy class.
- Another parametrization by partitions:
  $ lambda_i := \# "cycles of length" >= i, quad lambda_i = sum_(j >= i) k_j, quad k_i = lambda_i - lambda_(i+1), quad lambda_1 >= lambda_2 >= dots, quad sum lambda_i = n. $
  Pictorial representation of partitions by means of _Young diagrams_:
  #align(center, grid(
    columns: 6,
    column-gutter: 1.2em,
    align: horizon,
    canvas(length: 1cm, {
      import draw: *
      set-style(stroke: 0.6pt)
      let s = 0.5
      for (c, h) in (4, 2, 1).enumerate() {
        for r in range(h) { rect((c * s, -r * s), ((c + 1) * s, -(r + 1) * s)) }
      }
      // column heights lambda_i as square brackets: lambda_1 on the left, lambda_3 and lambda_2 right of the top row
      let t = 0.1
      line((-0.15 + t, 0), (-0.15, 0), (-0.15, -4 * s), (-0.15 + t, -4 * s))
      content((-0.42, -2 * s), $lambda_1$)
      line((3 * s + 0.15 - t, 0), (3 * s + 0.15, 0), (3 * s + 0.15, -s), (3 * s + 0.15 - t, -s))
      content((3 * s + 0.45, -0.5 * s), $lambda_3$)
      line((3 * s + 0.9 - t, 0), (3 * s + 0.9, 0), (3 * s + 0.9, -2 * s), (3 * s + 0.9 - t, -2 * s))
      content((3 * s + 1.2, -s), $lambda_2$)
      // brace under the diagram
      decorations.flat-brace((3 * s, -4 * s - 0.2), (0, -4 * s - 0.2), amplitude: 0.15)
      content((1.5 * s, -4 * s - 0.75), align(center, text(size: 9pt)[$n$ boxes in columns \ of height $lambda_i$]))
    }),
    [],
    $ (k_1, k_2, dots) \ (2, 1, 1, 0, dots) $,
    $tilde$,
    $ (lambda_1, lambda_2, dots) \ (4, 2, 1, 0, dots) $,
    [$tilde$ #h(0.5em) #young((3, 2, 1, 1))],
  ))

- #underline[Regular representation] on the group algebra $CC[G]$:
  $ V_"reg" = CC[G] = {sum_(g in G) alpha_g dot g mid(|) alpha_g in CC}, $
  with the group algebra structure
  $
    lambda (sum alpha_g dot g) & = sum (lambda alpha_g) dot g, \
    sum alpha_g dot g + sum beta_g dot g & = sum (alpha_g + beta_g) g, \
    (sum_(g in G) alpha_g g) dot (sum_(h in G) beta_h h) & = sum_(g, h in G) (alpha_g dot beta_h)(g dot h) = sum_(g in G) (sum_(h in G) alpha_(g h^(-1)) beta_h) g,
  $
  and the representation
  $ rho_"reg" (g) (sum_h alpha_h h) = sum alpha_h (g h) attach(=, t: h -> g^(-1) h) sum alpha_(g^(-1) h) h, $
  $ rho_"reg" = rho_1^(plus.o d_1) plus.o rho_2^(plus.o d_2) plus.o dots.c plus.o rho_k^(plus.o d_k), quad d_i = dim(rho_i) $
  $->$ 'irreducibles' in $V_"reg"$ are ideals in the group algebra.

*Aim:* Construct irr. reprs. of $S_n$ as subrepr. of $rho_"reg"$!

① Start with a Young diagram:
$ #young((3, 2, 1, 1)) quad |-> quad #young(((1, 5, 7), (2, 6), (3,), (4,))) = T quad ("Young tableau") $
diagram $|->$ tableau, by filling in the numbers $1, dots, n$ in such a way that numbers increase from left to right and top to bottom.

② Groups of row and column transformations of $T$:
$
  R(T) & = {sigma in S_n mid(|) sigma "leaves rows"(T) "invariant"}, \
  C(T) & = {sigma in S_n mid(|) sigma "leaves columns"(T) "invariant"}, \
  R(T) inter C(T) & = {e}.
$
_Example:_
$
  T = #young(((1, 4), (2,), (3,))) quad R(T) & = {e, (1 4)}, \
  C(T) & = {e, (1 2), (2 3), (1 3), (1 2 3), (1 3 2)}.
$

③
$
  a_T := sum_(sigma in R(T)) sigma in CC[S_n] quad ("symmetrizes the row transf."), \
  b_T := sum_(sigma in C(T)) "sgn"(sigma) sigma in CC[S_n] quad ("antisymm. the column transf.").
$
Young symmetrizer: $c_T := a_T dot b_T$.

_Example:_
$
  "i)" & quad T = #young(((1, 2, 3),)) & quad c_T & = a_T = sum_(sigma in S_3) sigma = 3! thin pi_0 quad ("projector on trivial repr."), \
  "ii)" & quad T = #young(((1,), (2,), (3,))) & quad c_T & = b_T = sum_(sigma in S_3) "sgn"(sigma) dot sigma = 3! thin pi_1 quad ("projector on sign repr."), \
  "iii)" & quad T = #young(((1, 3), (2,))) & quad c_T & = underbrace((e + (1 3)), a_T) dot (e - (1 2)) = e + (1 3) - (1 2) - (1 2 3) = 3 pi_2.
$

④ With $A := CC[S_n]$,
$ V_T := CC[S_n] dot c_T = {a dot c_T mid(|) a in A} quad "is a subrepres. of" V_"reg". $

*Examples*

i) $ T = #young(((1, 2, 3),)), quad C(T) = {e}, quad R(T) = {e, (1 2), (2 3), (1 3), (1 2 3), (1 3 2)} equiv S_3. $
$ CC[S_3] dot c_T = CC[S_3] dot sum_(sigma in S_3) sigma = CC dot c_T quad ("1-dim") $
$ [pi sum_(sigma in S_3) sigma = sum_(sigma in S_3) (pi sigma) = sum_(sigma in S_3) sigma] $
$ rho_"reg" (pi) c_T = rho_"reg" (pi) sum_(sigma in S_3) sigma = sum_(sigma in S_3) (pi sigma) = sum_(sigma in S_3) sigma = c_T $
$->$ trivial repr.!

ii) $ T = #young(((1,), (2,), (3,))), quad R(T) = {e}, quad C(T) = S_3. $
$ V_T = CC[S_3] c_T = CC[S_3] sum_(sigma in S_3) "sign"(sigma) dot sigma = CC c_T, $
$
  rho_"reg" (pi) c_T & = pi sum_(sigma in S_3) "sign"(sigma) sigma = sum_(sigma in S_3) "sign"(sigma) dot (pi sigma) = "sign"(pi) dot sum_(sigma in S_3) "sign"(pi sigma)(pi sigma) \
  & = "sign"(pi) dot sum_(sigma in S_3) "sign"(sigma) dot sigma = "sign"(pi) dot c_T
$
$arrow.r.turn rho_"reg"|_(V_T)$ is the sign repres.

iii) $ T = #young(((1, 3), (2,))), quad c_T = e + (1 3) - (1 2) - (1 2 3). $
$V_T = CC[S_3] dot c_T$ is 2-dimensional, spanned by $c_T$ and $(1 2) c_T$, and $(1 3) c_T = c_T$.
$rho_"reg"|_(V_T)$ is the irreducible 2d repres.

*Fact:*
(i) $rho_"reg"|_(V_T)$ is an irreducible subrepresentation of $rho_"reg"$, \
(ii) $V_T tilde.equiv V_(T')$ iff $lambda(T) = lambda(T')$ \
#h(1em) $->$ the irreducible repres. only depends on the underlying Young diagram, \
#h(1em) $->$ there are as many copies of an irreducible representation corresponding to $(lambda_1, dots, lambda_n)$ as there are Young tableaux built on this Young diagram.

*Recall:*
$ rho_"reg" = rho_1^(plus.o dim(rho_1)) plus.o dots.c plus.o rho_k^(plus.o dim(rho_k)) $
$->$ the irreducible represent. corresponding to a Young diagram has as dimension the number of ways you can make a Young tableau out of it.

Young diagram:
$ #young((2, 1, 1, 1)) quad |-> quad "irreducible repres. of" S_n. $
Young tableau:
$ #young(((1, 5), (2,), (3,), (4,))) quad |-> quad "subrepresentation of type" #young((2, 1, 1, 1), s: 0.22) "in" rho_"reg". $

- *Hook rule:* formula for the dimensions of irreducible representations of $S_n$.
  #grid(
    columns: (auto, 1fr),
    column-gutter: 2em,
    align: horizon,
    canvas(length: 1cm, {
      import draw: *
      set-style(stroke: 0.6pt)
      let s = 0.55
      let rows = ((6, 3, none), (4, 1), (2,), (1,))
      for (r, row) in rows.enumerate() {
        for (c, val) in row.enumerate() {
          rect((c * s, -r * s), ((c + 1) * s, -(r + 1) * s))
          if val != none { content(((c + 0.5) * s, -(r + 0.5) * s), $#val$) }
        }
      }
      // hook through the top-left box: its arm runs right, its leg runs down
      let hook = (stroke: (paint: luma(120), thickness: 0.9pt))
      line((3 * s - 0.08, -0.82 * s), (0.82 * s, -0.82 * s), (0.82 * s, -4 * s + 0.08), ..hook)
    }),
    [
      Labels irreducible repres.

      _Hook numbers:_ draw a hook through a box and count the number of boxes met by the hook, $h_i$.

      #box(stroke: 0.6pt, inset: 6pt, $ dim(rho_(#young((3, 2, 1, 1), s: 0.12))) = (n!)/(product h_i) $) #h(1em) Hook rule
    ],
  )

*Examples*

#grid(
  columns: (auto, 1fr),
  column-gutter: 1.5em,
  row-gutter: 0.7em,
  align: horizon,
  [i) $underbrace(#young((($n$, $n-1$, $n-2$, $dots$, $1$),), s: 0.66, size: 6.5pt), n "boxes")$ \ #h(1.2em) $S_n$],
  $ dim(rho_(#young((4,), s: 0.12))) = 1, quad d = (n!)/(n(n-1) dots.c 1) = 1 quad ("trivial repres.") $,
  [ii) #young((($n$,), ($n-1$,), ($dots.v$,), ($1$,)), s: 0.66, size: 6.5pt)],
  $ dim(rho_(#young((1, 1, 1), s: 0.12))) = 1, quad d = (n!)/(n(n-1) dots.c) = 1 quad ("sign repres.") $,
  [iii) $n - 1 cases(#young((($n$, $1$), ($n-2$,), ($dots.v$,), ($1$,)), s: 0.66, size: 6.5pt))$],
  $ d = (n!)/(n(n-2) dots.c 1) = (n - 1) $,
)
Same for #young((4, 1), s: 0.25) $dots.c$ .

- *Frobenius formula* (for characters of $S_n$)
  - Denote irreduc. repres. by partitions $(lambda_1, dots, lambda_n)$.
  - Denote conjugacy classes by the cycle structure $(k_1, dots, k_n)$.

  Define polynomials:
  $
    P_((k_1 dots k_n)) (x_1 dots x_n) = product_(i < j) (x_i - x_j) (x_1 + dots + x_n)^(k_1) dot (x_1^2 + dots + x_n^2)^(k_2) dot (x_1^3 + dots + x_n^3)^(k_3) dots.c (x_1^n + dots + x_n^n)^(k_n).
  $
  Then
  $
    chi_lambda (C_k) = [P_((k_1 dots k_n)) (x_1 dots x_n)]_(x_1^(l_1) dots x_n^(l_n)), quad lambda = (lambda_1, dots, lambda_n), quad k = (k_1, dots, k_n),
  $
  i.e. the coefficient of $x_1^(l_1) dots x_n^(l_n)$ in $P$, with $l_i = lambda_i + n - i$. Here $lambda_i$ are the row lengths of the Young diagram labelling the irreducible representation (a single row being the trivial representation).

*Example:* $G = S_3$, class $(dot dot)(dot)$:
$ P_((1, 1, 0)) (x_1, x_2, x_3) = (x_1 - x_2)(x_1 - x_3)(x_2 - x_3)(x_1 + x_2 + x_3)(x_1^2 + x_2^2 + x_3^2), $
#align(center, table(
  columns: 5,
  stroke: none,
  align: left + horizon,
  inset: (x: 8pt, y: 5pt),
  young((3,), s: 0.2), $lambda = (3, 0, 0)$, $l = (5, 1, 0)$, [$~>$ coeff. of $x_1^5 x_2$ in $P$], $chi_lambda (C_k) = 1$,
  young((1, 1, 1), s: 0.2), $lambda = (1, 1, 1)$, $l = (3, 2, 1)$, [$~>$ coeff. of $x_1^3 x_2^2 x_3$], $chi_lambda (C_k) = -1$,
  young((2, 1), s: 0.2), $lambda = (2, 1, 0)$, $l = (4, 2, 0)$, [$~>$ coeff. of $x_1^4 x_2^2$], $chi_lambda (C_k) = 0$,
))
$~>$ $C_2$-column of the character table of $D_3 tilde.equiv S_3$.
