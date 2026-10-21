#import "/notes.typ": notes, task
#import "@preview/cetz:0.5.2": canvas, draw

#show: notes.with(
  title: [Group Theory -- Problem Sheet 2],
  subtitle: [Exercise sheet 2, Group Theory, Prof. Daniel Roggenkamp],
  date: [Solutions by Janosh Riebesell, 02.06.2015],
)

// Relation sign with a small annotation above it, e.g. over(=, [linearity]).
#let over(rel, body) = $attach(#rel, t: #text(size: 7.5pt, body))$

= Exercise 1 (Representations)

#task[Recall the following notions from the lecture:]

#task(label: "a")[What is a representation?]

A (linear) _representation_ of a group $G$ on a vector space $V$ over a field $K$ is a _group homomorphism_ from $G$ to $"GL"(V)$, i.e. a map
$ rho: G --> "GL"(V) = "Aut"(V) = {"all invertible, linear transf." V -> V} $
such that $rho(g_1) rho(g_2) = rho(g_1 g_2) quad forall g_1, g_2 in G$.

$V$ is called the representation space and $dim(V)$ the dimension of the representation.

#task(label: "b")[What is a homomorphism (intertwiner) between two representations?]

A _group homomorphism_ between two groups is a map that preserves the group operation, i.e. given two groups $(G, dot)$ and $(H, *)$, a group homomorphism $phi$ with
$ phi: G -> H $
fulfills $phi(g_1 dot g_2) = phi(g_1) * phi(g_2) quad forall g_1, g_2 in G$.

Let $V_1$ and $V_2$ be the representation spaces of two (linear) representations of the group $G$,
$ rho_1: G -> "GL"(V_1), quad rho_2: G -> "GL"(V_2). $
Then, a linear map $f: V_1 -> V_2$ is called an _intertwiner_ of the representations $rho_1$ and $rho_2$ if it commutes under the group action of $G$, i.e. if $f compose rho_1 (g) = rho_2 (g) compose f quad forall g in G$.

An intertwiner's property can be visualized by the following diagram.

#grid(
  columns: (auto, 1fr),
  column-gutter: 1.5em,
  align: horizon,
  canvas(length: 1cm, {
    import draw: *
    set-style(stroke: 0.6pt)
    let arr = (end: "straight", scale: 0.6)
    content((0, 1.6), $V_1$)
    content((2.2, 1.6), $V_1$)
    content((0, 0), $V_2$)
    content((2.2, 0), $V_2$)
    line((0.35, 1.6), (1.85, 1.6), mark: arr)
    line((0.35, 0), (1.85, 0), mark: arr)
    line((0, 1.3), (0, 0.3), mark: arr)
    line((2.2, 1.3), (2.2, 0.3), mark: arr)
    content((1.1, 1.85), $rho_1 (g)$)
    content((1.1, -0.25), $rho_2 (g)$)
    content((-0.25, 0.8), $f$)
    content((2.45, 0.8), $f$)
  }),
  [Notably, an intertwiner must fulfill this diagram for every $g in G$. If $f$ is invertible (only possible if $dim(V_1) = dim(V_2)$), we have $rho_1 (g) = f^(-1) compose rho_2 (g) compose f$ and the representations $rho_1$ and $rho_2$ are said to be equivalent.],
)

#task(label: "c")[What is a subrepresentation?]

A subspace $W subset V$ of the representation space $V$ of a representation $rho$ is called a _subrepresentation_ if it is invariant under the group action of the represented group $G$, where invariant means that $g w in W quad forall g in G "and" forall w in W$.

The restriction of $rho$ to $W$, $rho(W)|_W$, is also referred to as subrepresentation, if $W subset V$ is an invariant subspace: $rho|_W: G -> "GL"(W)$ is then a representation on its own.

#task(label: "d")[What are reducible and irreducible representations?]

A representation $rho: G -> "GL"(V)$ is said to be _irreducible_ if it has only the trivial subrepresentations ${0}$ and $V$. If there is a non-trivial subrepresentation, $rho$ is reducible.

#task(label: "e")[Recall Schur's lemma.]

If $rho_1$ and $rho_2$ are two finite-dimensional irreducible representations of a group $G$ and $f: V_1 -> V_2$ is an intertwiner between their representation spaces, then either $f equiv 0$ or $f$ is invertible, i.e. an isomorphism.

In the special case of $V_1 tilde.equiv V_2$, it further yields $f = lambda "id"_V$ (with $lambda in CC$, if $V_1$ and $V_2$ are vector spaces over $CC$).

#task(label: "f")[Argue that complex representations of finite groups are fully decomposable.]

A representation $rho: G -> "GL"(V)$ of a group $G$ is called _fully decomposable_ if it can be decomposed into a direct sum of irreducible representations, $rho = rho_1 plus.o dots.c plus.o rho_n$, where $rho_i$, $i in {1, dots, n}$ each irreducible. The above claim follows from this argument:

Let $rho: G -> "GL"(V)$ be a reducible complex representation (if it were irreducible, it would be fully decomposable by definition). Averaging any Hermitian inner product over the finite group, $chevron.l v, w chevron.r_G := sum_(g in G) chevron.l rho(g) v, rho(g) w chevron.r$, gives an inner product with respect to which $rho$ is unitary, $rho: G -> U(V)$.
$ ==> exists W subset V "invariant subspace". $
We can define $W^perp = {v in V | chevron.l v, w chevron.r = 0 quad forall w in W}$. Then, since
$ forall g in G, forall w in W, forall v in W^perp: quad 0 = chevron.l v, w chevron.r over(=, W "invariant subspace") chevron.l v, rho(g) w chevron.r over(=, rho "unitary repr.") chevron.l rho(g^(-1)) v, w chevron.r, $
we know that $W^perp$ is an invariant subspace as well. We infer that
$ rho = rho|_W plus.o rho|_(W^perp), $
where $rho|_W$ is still unitary, therefore we may split again.
The above scheme can be applied repeatedly until the subrepresentations become irreducible. Finally
$ rho = plus.o.big_i rho_i, quad "with" rho_i "irreducible" forall i. $
One may say that irreducible representations are the building blocks of unitary representations.

= Exercise 2 (Representations of abelian groups)

#task(label: "a")[Show that all irreducible representations of a finite group $G$ are one-dimensional if and only if $G$ is abelian. (_Hint:_ What is the sum of the squares of the dimensions of the irreducible representations?)]

To be shown:
$ dim(rho_i) = 1 quad forall rho_i: G -> "GL"(V_i) "irreducible", i in {1, dots, n} quad <==> quad G "abelian". $

"$==>$": Assume all irreducible representations have $d_i = dim(rho_i) = 1$. Then we have
$ |G| attach(=, t: !) sum_(i = 1)^n d_i^2 = sum_(i = 1)^n 1 = n, quad "with" n: "number of irred. repr." $
We also have that the number of irreducible representations equals the number of conjugacy classes of $G$, i.e.
$ n attach(=, t: !) "number of conjugacy classes of" G. $
Therefore, 'number of conjugacy classes' $= n = |G|$, i.e. every element of $G$ forms its own conjugacy class.
$ ==> h g h^(-1) = g quad forall g, h in G quad ==> quad h g = g h quad forall g, h in G quad <==> quad G "is abelian". $

"$<==$": Assume $G$ is abelian $<==> g h = h g quad forall g, h in G$. Then, since every representation is a homomorphism, we have
$ rho(g_1) rho(g_2) over(=, rho "homomorphism") rho(g_1 g_2) over(=, G "abelian") rho(g_2 g_1) = rho(g_2) rho(g_1). $
Applying the special case of Schur's lemma, which states that if $f: V -> V$ commutes with $rho(g) quad forall g in G$, i.e.
$ f compose rho(g) = rho(g) compose f quad forall g in G quad ==> quad f = lambda "id"_V quad "for some" lambda in CC, $
we obtain
$ rho(g) = lambda_g "id"_V = mat(lambda_g, , 0; , dots.down, ; 0, , lambda_g) = plus.o.big_i rho_i, quad "with" rho_i "irreducible repr. of" dim(rho_i) = 1. $

#task(label: "b")[What are the irreducible representations of the cyclic group $ZZ_n$?]

Since $ZZ_n$ is abelian, we know from part a) that every irreducible subrepresentation of $ZZ_n$ is one-dimensional and that there are exactly $|ZZ_n| = n$ of them.

Let $"id"_CC^(1 \/ n)$ denote the $n$-th root of unity in $CC$, then the map
$ rho: ZZ_n --> CC^*, quad rho(g^j) = "id"_CC^(j \/ n) quad forall g^j in ZZ_n $
is a group homomorphism. Since $"id"_CC^(k \/ n)$, $k in {1, dots, n}$ are the first through $n$-th roots of unity in $CC$, the $n$ irreducible subrepresentations of $ZZ_n$ with dimension one are
$ rho_k: G --> CC^*, quad rho_k (g^j) = "id"_CC^(j k \/ n) = e^(2 pi i j k \/ n), quad "with" k in {1, dots, n}. $

= Exercise 3 (Orthogonality relation)

#task[Let $(rho_1, V_1)$ and $(rho_2, V_2)$ be two irreducible (finite-dimensional complex) representations of a finite group $G$. Choose bases of $V_1$ and $V_2$ and let $(rho_1 (g))_(i j)$ and $(rho_2 (g))_(a b)$ be the representation matrices with respect to these bases. Then use Schur's lemma to show:]

#task(label: "a")[
  If $rho_1$ and $rho_2$ are inequivalent, then
  $ sum_(g in G) (rho_1 (g^(-1)))_(i j) (rho_2 (g))_(a b) = 0 $
  for all $i, j, a, b$.
]

To show this, we consider the matrix
$ M_X = sum_(g in G) underbrace(rho_1 (g)^(-1), rho_1 (g^(-1))) X rho_2 (g), $
where $X$ is an arbitrary matrix with $d_1$ rows and $d_2$ columns, $d_1$ and $d_2$ being the dimensionalities of the representations $rho_1$ and $rho_2$, s.t. $M_X$ is a $d_1 times d_2$-matrix. Now multiplying $M_X$ from the left and right with arbitrary matrices in the representations $rho_1$ and $rho_2$ respectively,
$
  rho_1^(-1) (h) M_X rho_2 (h) & = sum_(g in G) underbrace(rho_1^(-1) (h), rho_1 (h^(-1))) underbrace(rho_1^(-1) (g), rho_1 (g^(-1))) X rho_2 (g) rho_2 (h) quad "for some" h in G \
  & = sum_(g in G) rho_1 \(underbrace(h^(-1) g^(-1), (g h)^(-1))\) X rho_2 (g h) & quad g |-> g h^(-1) \
  & = sum_(g in G) rho_1 (g^(-1)) X rho_2 (g) = M_X,
$
we find that $M_X$ is an intertwiner between the representations $rho_1$ and $rho_2$, i.e. $rho_1 (g) M_X = M_X rho_2 (g)$. Since $rho_1$ and $rho_2$ are taken to be inequivalent, i.e.
$ exists.not M_X: quad rho_1 (g) = M_X rho_2 (g) M_X^(-1) quad (M_X "not invertible"), $
we know by Schur's lemma that $M_X = 0$. Therefore, writing element-wise, we have
$ 0 = (M_X)_(i b) = sum_(g in G) (rho_1 (g^(-1)))_(i k) X_(k l) (rho_2 (g))_(l b). $
Since the matrix $X$ was arbitrary, we may choose any form. We pick one $X$ for every tuple of $j, a$ given by
$ (X_(k l))_(j a) = delta_(k j) delta_(l a) $
to conclude that
$ sum_(g in G) (rho_1 (g^(-1)))_(i k) delta_(k j) delta_(l a) (rho_2 (g))_(l b) = sum_(g in G) (rho_1 (g^(-1)))_(i j) (rho_2 (g))_(a b) attach(=, t: !) 0 $
for all $i, j, a, b$.

#task(label: "b")[
  If on the other hand $rho_1 = rho_2$, then
  $ 1/(|G|) sum_(g in G) (rho(g^(-1)))_(i j) (rho(g))_(a b) = 1/dim(V) delta_(i b) delta_(j a). $
]

In the case of $rho_1 = rho_2 =: rho$, $rho$ is still an irreducible representation of $G$ and $M_X$ with
$ M_X = sum_(g in G) rho(g)^(-1) X rho(g) $
is still an intertwiner, so that we may apply Schur's lemma for the special case of $V_1 = V_2 =: V$ to conclude
$ M_X = lambda "id"_V quad "for some" lambda in CC "for every" g in G. $
Taking the trace of $M_X$, we obtain
$
  "Tr"(M_X) & = "Tr"_V (sum_(g in G) rho(g^(-1)) X rho(g)) over(=, "linearity of trace") sum_(g in G) "Tr"_V (rho(g^(-1)) X rho(g)) \
  & over(=, "cyclicity of trace") sum_(g in G) "Tr"_V (underbrace(rho(g) rho(g^(-1)), rho(g g^(-1)) = rho(e) = "id"_V) X) = sum_(g in G) "Tr"_V (underbrace("id"_V X, X)) = |G| "Tr"_V (X), \
  "Tr"(M_X) & = "Tr"(lambda "id"_V) = lambda "Tr"("id"_V) = lambda dim(V) quad ==> quad lambda = (|G|)/dim(V) "Tr"_V (X).
$
Choosing again $(X_(j a))_(k l) = delta_(k j) delta_(a l)$, we obtain
$
  (M_X)_(i b) & = sum_(g in G) (rho(g^(-1)))_(i k) delta_(k j) delta_(a l) (rho(g))_(l b) = sum_(g in G) (rho(g^(-1)))_(i j) (rho(g))_(a b) \
  & = lambda delta_(i b) = (|G|)/dim(V) "Tr"_V (X) delta_(i b) = (|G|)/dim(V) underbrace("Tr"_V (delta_(k j) delta_(a l)), delta_(k j) delta_(a k) = delta_(j a)) delta_(i b) = (|G|)/dim(V) delta_(i b) delta_(j a) \
  ==> & 1/(|G|) sum_(g in G) (rho(g^(-1)))_(i j) (rho(g))_(a b) = 1/dim(V) delta_(i b) delta_(j a).
$

#task(label: "c")[
  Deduce that
  $ 1/(|G|) sum_(g in G) chi_(rho_1) (g^(-1) h) chi_(rho_2) (g) = cases(display((chi_(rho_1) (h))/dim(rho_1)) & "if" rho_1 tilde.equiv rho_2, 0 & "otherwise".) $
]

We express the characters $chi_(rho_1) (g^(-1) h) := "Tr"_(V_1) (rho_1 (g^(-1) h))$ and $chi_(rho_2) (g) := "Tr"_(V_2) (rho_2 (g))$ as
$ chi_(rho_1) (g^(-1) h) = sum_(i, j) (rho_1 (g^(-1)))_(i j) (rho_1 (h))_(j i) quad "and" quad chi_(rho_2) (g) = sum_k (rho_2 (g))_(k k) $
to obtain
$
  & 1/(|G|) sum_(g in G) chi_(rho_1) (g^(-1) h) chi_(rho_2) (g) = 1/(|G|) accent(sum_(g in G) sum_(i, j, k), arrow.l.r) (rho_1 (g^(-1)))_(i j) accent((rho_1 (h))_(j i) (rho_2 (g))_(k k), arrow.l.r) \
  & = 1/(|G|) sum_(i, j, k) sum_(g in G) (rho_1 (g^(-1)))_(i j) (rho_2 (g))_(k k) (rho_1 (h))_(j i) \
  & = cases(
    display(1/dim(V) sum_(i, j, k) delta_(i k) delta_(j k) (rho(h))_(j i) = 1/dim(V) sum_k (rho(h))_(k k) = (chi_rho (h))/dim(V)) & "if" rho_1 = rho_2 =: rho "using b)",
    display(1/(|G|) sum_(i, j, k) 0 dot (rho(h))_(j i) = 0) & "otherwise using a)".
  )
$

= Exercise 4 (Symmetric and antisymmetric products)

#task[Let $(rho, V)$ be a finite-dimensional representation. Consider the tensor product representation $rho times.o rho$ on $V times.o V$. Define $sigma: V times.o V -> V times.o V$ by $sigma(v_1 times.o v_2) = v_2 times.o v_1 quad forall v_1, v_2 in V$.]

#task(label: "a")[Show that the tensor product decomposes into the sum $V times.o V = S^2 V plus.o Lambda^2 V$ of spaces of symmetric and antisymmetric tensors $S^2 V = {v in V times.o V | sigma(v) = v}$ and $Lambda^2 V = {v in V times.o V | sigma(v) = -v}$, and that these are invariant subspaces in $V times.o V$. (_Hint:_ Consider the projectors $1/2 (1 plus.minus sigma): V times.o V -> V times.o V$.)]

Following the hint, we examine $pi_plus.minus := 1/2 ("id"_(V times.o V) plus.minus sigma): V times.o V -> V times.o V$,
$ pi_plus.minus^2 = 1/4 ("id"_(V times.o V) plus.minus sigma)^2 = 1/4 (underbrace("id"_(V times.o V)^2, "id"_(V times.o V)) plus.minus 2 underbrace("id"_(V times.o V) sigma, sigma) + underbrace(sigma^2, "id"_(V times.o V))) = 1/4 (2 "id"_(V times.o V) plus.minus 2 sigma) = pi_plus.minus. $
As hinted, we find $pi_plus.minus$ to be projectors. In addition,
$ pi_+ + pi_- = 1/2 ("id"_(V times.o V) + sigma) + 1/2 ("id"_(V times.o V) - sigma) = "id"_(V times.o V). $
Therefore, the tensor product $V times.o V$ can be decomposed as
$ V times.o V = "Im"(pi_+) plus.o "Im"(pi_-). $
It remains to be shown that $"Im"(pi_+) = S^2 V$ and $"Im"(pi_-) = Lambda^2 V$.
$
  S^2 V subset "Im"(pi_+): & quad forall v in S^2 V: sigma(v) = v \
  & ==> forall v in S^2 V: pi_+ (v) = 1/2 ("id"_(V times.o V) (v) + sigma(v)) = 1/2 (v + v) = v \
  & ==> S^2 V subset "Im"(pi_+), "since" pi_+ "is projector", \
  "Im"(pi_+) subset S^2 V: & quad forall v in "Im"(pi_+): pi_+ (v) = v, "since" pi_+ "is projector" \
  & ==> pi_+ (v) = 1/2 ("id"_(V times.o V) (v) + sigma(v)) = 1/2 (v + sigma(v)) attach(=, t: !) v <==> sigma(v) = v \
  & ==> "Im"(pi_+) subset S^2 V \
  ==> & "Im"(pi_+) = S^2 V.
$
This goes through analogously for $"Im"(pi_-) = Lambda^2 V$.
$ ==> V times.o V = S^2 V plus.o Lambda^2 V. $
To further show that $S^2 V$ and $Lambda^2 V$ are invariant subspaces in $V times.o V$, we remember a remark from the lecture, which states that image and kernel of every intertwiner form invariant subspaces. Since $sigma$ is an intertwiner because it fulfills $rho times.o rho(g) compose sigma = sigma compose rho times.o rho(g)$, so is $pi_plus.minus$ w.r.t. $rho times.o rho$. Therefore, $S^2 V$ and $Lambda^2 V$ are invariant subspaces.

#task(label: "b")[Show that the characters of the corresponding subrepresentations can be expressed as $chi_(S^2 V) (g) = 1/2 [(chi_V (g))^2 + chi_V (g^2)]$, $chi_(Lambda^2 V) (g) = 1/2 [(chi_V (g))^2 - chi_V (g^2)]$. (A character is defined as the trace over a representation, $chi_V (g) = "tr"_V (rho(g))$.)]

A subrepresentation is formed by restricting a representation $rho$ to a subspace $W$ of its representation space $V$, $rho|_W$. Since $pi_plus.minus$ are projectors onto their respective subspaces, we may write the subrepresentations $rho times.o rho|_(S^2 V)$ and $rho times.o rho|_(Lambda^2 V)$ as
$ rho times.o rho|_(S^2 V) = rho times.o rho thin pi_+, quad rho times.o rho|_(Lambda^2 V) = rho times.o rho thin pi_-. $
Making use of $pi_plus.minus$ also being intertwiners, we may express the characters by
$
  chi_(S^2 V) (g) & = "tr"_(V times.o V) (pi_+ thin rho times.o rho(g)) = 1/2 ["tr"_(V times.o V) ("id"_(V times.o V) thin rho times.o rho(g)) + "tr"_(V times.o V) (sigma thin rho times.o rho(g))], \
  chi_(Lambda^2 V) (g) & = "tr"_(V times.o V) (pi_- thin rho times.o rho(g)) = 1/2 ["tr"_(V times.o V) ("id"_(V times.o V) thin rho times.o rho(g)) - "tr"_(V times.o V) (sigma thin rho times.o rho(g))].
$
We can simplify both summands:
$ "tr"_(V times.o V) ("id"_(V times.o V) thin rho times.o rho(g)) = "tr"_V (rho(g)) "tr"_V (rho(g)) = ["tr"_V (rho(g))]^2 = chi_V^2 (g). $
To calculate the second, we need to choose a basis, say $e_i$, for $V$. Then
$
  "tr"_(V times.o V) (sigma thin rho times.o rho(g)) & = "tr"_(V times.o V) (sigma thin rho(g) times.o rho(g) (e_i times.o e_j)) \
  & = "tr"_(V times.o V) (rho(g) times.o rho(g) (e_j times.o e_i)) = "tr"_(V times.o V) (rho_(a j) (g) rho_(b i) (g) e^b times.o e^a) \
  & = "tr"_V (rho(g) dot rho(g)) = "tr"_V (rho(g^2)).
$
Reinserting the simplifications into $chi_(S^2 V) (g)$ and $chi_(Lambda^2 V) (g)$, we arrive at the desired result:
$
  chi_(S^2 V) (g) & = 1/2 [chi_V^2 (g) + chi_V (g^2)], \
  chi_(Lambda^2 V) (g) & = 1/2 [chi_V^2 (g) - chi_V (g^2)].
$

= Exercise 5 (Representations of $D_5$)

#task[
  Consider the dihedral group
  $ D_5 = {e = R_0, R_1, R_2, R_3, R_4, S_0, S_1, S_2, S_3, S_4} $
  of symmetries of the regular pentagon in the plane. Its character table is given by
  #align(center, table(
    columns: 5,
    stroke: none,
    align: center,
    table.hline(y: 1, stroke: 0.6pt),
    table.vline(x: 1, stroke: 0.6pt),
    $D_5$, $C_0 = {e}$, $C_1 = {R_1, R_4}$, $C_2 = {R_2, R_3}$, $C_3 = {S_0, dots, S_4}$,
    $chi_0$, $1$, $1$, $1$, $1$,
    $chi_1$, $1$, $1$, $1$, $-1$,
    $chi_2$, $2$, $alpha$, $beta$, $0$,
    $chi_3$, $2$, $beta$, $alpha$, $0$,
  ))
]

#task(label: "a")[Use orthogonality of characters to show that $alpha = 1/2 (-1 + sqrt(5))$ and $beta = 1/2 (-1 - sqrt(5))$.]

The orthogonality relation of two characters is given by
$ sum_a overline(chi_i (C_a)) chi_j (C_a) (|C_a|)/(|G|) = delta_(i j), quad "where" overline(chi(g)) = chi(g^(-1)). $
The orthogonality of rows works just as well here, but we apply the orthogonality relation for columns given by
$ sum_i overline(chi_i (C_a)) chi_i (C_b) = (|G|)/(|C_a|) delta_(a b). $
Multiplying the first and second (or third), and the second and third columns, we obtain the constraints
$
  1 dot 1 + 1 dot 1 + 2 alpha + 2 beta & = 2 + 2 alpha + 2 beta = 0 & quad <==> quad & 1 + alpha + beta = 0, \
  1 dot 1 + 1 dot 1 + alpha beta + beta alpha & = 2 + 2 alpha beta = 0 & quad <==> quad & 1 + alpha beta = 0, \
  ==> beta & = -(1 + alpha), & quad & 1 + alpha beta = 1 - alpha (1 + alpha) = 1 - alpha - alpha^2 = 0 \
  <==> (alpha + 1/2)^2 & = 5/4 & quad ==> quad & alpha = -1/2 plus.minus sqrt(5/4) = 1/2 (-1 plus.minus sqrt(5)) \
  & & quad ==> quad & beta = -(1 + 1/2 (-1 plus.minus sqrt(5))) = 1/2 (-1 minus.plus sqrt(5)).
$

#task(label: "b")[Consider the following representations: $rho_2 times.o rho_2$, $Lambda^2 rho_2$, $S^2 rho_2$. Determine their characters and decompose them into irreducible representations.]

Characters are multiplicative with respect to tensor product, i.e.
$ chi_(rho_2 times.o rho_2) (g) = chi_(rho_2) (g) dot chi_(rho_2) (g). $
Applying our result from exercise 4.b), i.e.
$ chi_(S^2 V) (g) = 1/2 (chi_V^2 (g) + chi_V (g^2)), quad chi_(Lambda^2 V) (g) = 1/2 (chi_V^2 (g) - chi_V (g^2)), $
we may write a new character table for $chi_(rho_2 times.o rho_2)$, $chi_(S^2 rho_2)$, $chi_(Lambda^2 rho_2)$:
#align(center, table(
  columns: 5,
  stroke: none,
  align: center,
  table.hline(y: 1, stroke: 0.6pt),
  table.vline(x: 1, stroke: 0.6pt),
  $D_5$, $C_0$, $C_1$, $C_2$, $C_3$,
  $chi_(rho_2 times.o rho_2)$, $4$, $alpha^2 = 1 - alpha$, $beta^2 = 1 - beta$, $0$,
  $chi_(S^2 rho_2)$, $3$, $-alpha$, $-beta$, $1$,
  $chi_(Lambda^2 rho_2)$, $1$, $1$, $1$, $-1$,
))
Using $alpha + beta = -1$, i.e. $1 - alpha = 2 + beta$ and $1 - beta = 2 + alpha$, we find $chi_(rho_2 times.o rho_2) = chi_0 + chi_1 + chi_3$. Therefore, $rho_2 times.o rho_2 tilde.equiv rho_0 plus.o rho_1 plus.o rho_3 = S^2 rho_2 plus.o Lambda^2 rho_2$, where
$
  chi_(S^2 rho_2) & = chi_0 + chi_3 & quad ==> quad S^2 rho_2 & tilde.equiv rho_0 plus.o rho_3, \
  chi_(Lambda^2 rho_2) & = chi_1 & quad ==> quad Lambda^2 rho_2 & tilde.equiv rho_1.
$
