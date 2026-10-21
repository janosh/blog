#import "/notes.typ": notes, task
#import "@preview/cetz:0.5.2": canvas, draw

#show: notes.with(
  title: [Group Theory -- Problem Sheet 3],
  subtitle: [Exercise sheet 3, Group Theory, Prof. Daniel Roggenkamp],
  date: [Solutions by Janosh Riebesell, 14.06.2015],
)

// Young diagram of the hook partition (n - k, 1, ..., 1)
#let hook-diagram = box(baseline: 50%, canvas(length: 0.5cm, {
  import draw: *
  set-style(stroke: 0.6pt)
  for x in (0, 1, 3) { rect((x, 0), (x + 1, -1)) }
  content((2.5, -0.5), $dots.c$)
  for y in (-1, -3) { rect((0, y), (1, y - 1)) }
  content((0.5, -2.5), $dots.v$)
  // braces
  line((0, 0.25), (0, 0.4), (4, 0.4), (4, 0.25))
  content((2, 0.95), text(size: 8pt)[$n - k$ boxes])
  line((4.25, -1), (4.4, -1), (4.4, -4), (4.25, -4))
  content((5.7, -2.5), text(size: 8pt)[$k$ boxes])
}))

= Exercise 1 (Representations of $S_n$)

#task(label: "a")[
  Use the hook rule to determine the dimension of the irreducible representation associated to the partition
  $ lambda = (n - k, underbrace(#$1, ..., 1$, k "times"), 0, ..., 0). $
]

The hook length of a box in a Young tableau is the number of boxes beneath or to the right of the box in the diagram, counting the box itself.

Let $rho^lambda$ be the irreducible repr. of $S_n$ associated with the partition $lambda$, then the hook rule states the dimension of $rho^lambda$ to be $n!$ over the hook lengths in the Young diagram of shape $lambda$, i.e. in this instance
$ dim(rho^lambda) = (n!) / (n dot (n - k - 1)! dot k!) = binom(n - 1, k), quad "Young diagram:" #h(0.5em) #hook-diagram $
since the corner box has hook length $n$, the remaining boxes of the first row have hook lengths $n - k - 1, ..., 1$ and the remaining boxes of the first column $k, ..., 1$.

#task(label: "b")[Construct the character table of $S_4$ by using the Frobenius formula.]

According to the Frobenius formula, the characters of the irreducible repr. of $S_n$ associated with the partition $lambda = (lambda_1, ..., lambda_k)$ of $n$ are given by
$ chi_lambda (C_i) = [Delta(x) product_(j=1) P_j (x)^(i_j)]_((l_1, ..., l_k)), $
where $P_j$ is the power sum $P_j (x) = x_1^j + dots.c + x_k^j$, $k$ being the number of rows in the Young tableau of $lambda$, and $Delta(x)$ is the discriminant
$ Delta(x) = product_(1 <= i < j <= k) (x_i - x_j) = det mat(1, x_k, dots.c, x_k^(k-1); dots.v, dots.v, dots.down, dots.v; 1, x_1, dots.c, x_1^(k-1)) $
of the set of $k$ independent variables ${x_1, ..., x_k}$. Furthermore, $i = (i_1, ..., i_n)$ is an $n$-tuple of non-negative integers s.t. $sum_r r i_r = n$ so that $C_i$ may denote the conjugacy class consisting of elements with cycle type $(i_1, ..., i_n)$, and $[f(x)]_((l_1, ..., l_k))$ is the coefficient of $x_1^(l_1) dots.c x_k^(l_k)$ in the power series $f(x) = f(x_1, ..., x_k)$, where $l = (l_1, ..., l_k)$ is a $k$-tuple of non-negative integers.

Applying the Frobenius formula yields the following character table:
#align(center, block(breakable: false, table(
  columns: 6,
  align: center,
  stroke: (x, y) => (
    left: if x == 1 { 0.6pt },
    bottom: if y == 0 { 0.6pt },
  ),
  inset: (x: 8pt, y: 5pt),
  $S_4$, $C_1 = [(1)]$, $C_2 = [(1 2)]$, $C_3 = [(1 2 3)]$, $C_4 = [(1 2 3 4)]$, $C_5 = [(1 2)(3 4)]$,
  $chi_"triv"$, $1$, $1$, $1$, $1$, $1$,
  $chi_"sgn"$, $1$, $-1$, $1$, $-1$, $1$,
  $chi$, $3$, $1$, $0$, $-1$, $-1$,
  $chi_"sgn" times.o chi$, $3$, $-1$, $0$, $1$, $-1$,
  $chi_"other"$, $2$, $0$, $-1$, $0$, $2$,
)))

= Exercise 2 (Lie groups and Lie algebras)

#task(label: "f")[How are the notions of homomorphisms of Lie groups and Lie algebras related?]

Let $phi.alt: G -> H$ be a Lie group homomorphism. With $phi.alt_*$ we denote its derivative at the identity of $G$. If we pick $frak(g)$, $frak(h)$, the Lie algebras of $G$ and $H$, as the tangent spaces at their respective identities, then $phi.alt_*$ is a map between these two Lie algebras,
$ phi.alt_*: frak(g) -> frak(h), $
which fulfills all the requirements of a Lie algebra homomorphism, i.e. it is a linear map that preserves the Lie bracket.

#task(label: "a")[What is a Lie group?]

A Lie group is a group $G$ which is also a differentiable (also called smooth) manifold s.t. the group operations are compatible with the smooth group structure, i.e. s.t.
$ cases(reverse: #true, m\: G times G -> G & "(multiplication)", (dot)^(-1)\: G -> G & "(inversion)") quad "are smooth maps." $

#task(label: "b")[What is a Lie algebra?]

A Lie algebra is a vector space $V$ with a non-associative, bilinear, skew-symmetric map $[dot, dot]: V times V -> V$ (called the Lie bracket) which satisfies the Jacobi identity.

#task(label: "c")[What are left-invariant vector fields? Describe them for matrix groups.]

A vector field $X_v$ on a Lie group $G$ is left-invariant if
$ (dif L_g)(X_v (h)) = X_v (L_g (h)) = X_v (g h) quad forall g, h in G, $
where $dif L_g$ is the derivative of the smooth map $L_g$, and $L_g$ denotes the group action of the Lie group $G$ defined by left multiplication, i.e. $L_g: G -> G$, $L_g (h) = g h$ $forall g, h in G$ ($L_e = "id"_G$).

#task(label: "d")[How does one obtain the structure of a Lie algebra on a tangent space of a Lie group at the identity?]

By finding the vector space of all left-invariant vector fields.

Reasoning: Since the vector space of all left-invariant vector fields is isomorphic (as a vector space) to $T_e G$, the tangent space of a Lie group $G$ at the identity $e$, and it in turn is equipped with the structure of a Lie algebra, defined by
$ [v, w] = X_([v, w]) = [X_v, X_w] quad forall v, w in T_e G, $
this yields the desired information.

#task(label: "e")[Show that the Lie bracket on the tangent space of the identity of matrix groups satisfies the Jacobi identity.]

Every matrix (Lie) group is a subgroup of the general linear group $"GL"(n, KK)$,
$ "GL"(n, KK) = {A in "Mat"(n, n, KK) | det(A) != 0}, $
i.e. the group of all invertible $n times n$ matrices over $KK$. Since the (standard) Lie bracket for Lie algebras of the matrix groups is simply the matrix commutator given by $[A, B] = A B - B A$ for $A, B in "Mat"(n, n, KK)$, we calculate (cancelling terms marked in matching colors)
#let c1(x) = text(fill: rgb("#1f5fa8"), x)
#let c2(x) = text(fill: rgb("#b22222"), x)
#let c3(x) = text(fill: rgb("#2e7d32"), x)
#let c4(x) = text(fill: rgb("#c75b00"), x)
#let c5(x) = text(fill: rgb("#7b3fa0"), x)
$
  [A, [B, C]] + [B, [C, A]] + [C, [A, B]] & = A B C - c1(B C A) - c2(A C B) + c3(C B A) \
  & quad + c1(B C A) - c4(C A B) - c5(B A C) + c2(A C B) \
  & quad + c4(C A B) - A B C - c3(C B A) + c5(B A C) = 0,
$
which holds for all $A, B, C in "Mat"(n, n, KK)$ and therefore for all possible elements of matrix groups.

= Exercise 3 ($"SU"(2)$)

#task[
  Show that $"SU"(2) = {A in "Mat"(2, 2, CC) | A^dagger A = bb(1)_2, det A = 1}$ can be parametrized in the following way
  $ "SU"(2) = {mat(a, -overline(b); b, overline(a)) | a, b in CC, |a|^2 + |b|^2 = 1}. $
  (Hence, $"SU"(2)$ is homeomorphic to the three sphere $S^3$, and in particular simply connected.)
]

We write an element $A in "SU"(2)$ as $A = mat(a, c; b, d)$ with $a, b, c, d in CC$. Then
$ A^dagger A = mat(overline(a), overline(b); overline(c), overline(d)) mat(a, c; b, d) = mat(|a|^2 + |b|^2, overline(a) c + overline(b) d; a overline(c) + b overline(d), |c|^2 + |d|^2) = mat(1, 0; 0, 1). $
The above property of $A$ as an element of $"SU"(2)$ yields the following three constraints on $a, b, c, d in CC$:
$ "i)" |a|^2 + |b|^2 = 1, quad "ii)" |c|^2 + |d|^2 = 1, quad "iii)" a overline(c) + b overline(d) = 0. $
The condition $det(A) = 1$ further supplies
$ "iv)" a d - b c = 1. $
From iii), $a = -(b overline(d)) / overline(c)$ follows. Inserting into i), we obtain
$ (|b|^2 |d|^2) / (|c|^2) + |b|^2 = 1 quad ==> quad (|c|^2) / (|b|^2) = |c|^2 + |d|^2 = 1, $
i.e. $|b| = |c|$. Similarly, we find $|a| = |d|$ by subtracting i) and ii):
$ |a|^2 + underbrace(|b|^2 - |c|^2, 0) - |d|^2 = |a|^2 - |d|^2 = 0. $

_Remark:_ We assumed above that $b != 0$. If $b = 0$, it becomes very simple. By iv), we know $a d = 1$ and by iii), $a overline(c) = 0$. The latter implies $c = 0$, since $a != 0$, and $A$ becomes diagonal with $a = overline(d)$ because $a d = 1$.

Now, returning to the case $b != 0$, we discover that our findings are captured by the ansatz
$ a = e^(i alpha) cos theta, quad b = e^(i beta) sin theta, quad c = -e^(i gamma) sin theta, quad d = e^(i delta) cos theta, $
where $alpha, beta, gamma, delta, theta in RR$. Applying iv) to this ansatz,
$ a d - b c = e^(i (alpha + delta)) cos^2 theta + e^(i (beta + gamma)) sin^2 theta = 1 quad <==> quad alpha = -delta, quad beta = -gamma, $
we finally arrive at
$ a = e^(i alpha) cos theta = e^(-i delta) cos theta = overline(d), quad b = e^(i beta) sin theta = e^(-i gamma) sin theta = -overline(c). $
Thus, $"SU"(2)$ may be parametrized by
$ "SU"(2) = {mat(a, c; b, d) = mat(a, -overline(b); b, overline(a)) | a, b in CC, |a|^2 + |b|^2 = 1}. $

= Exercise 4 ($"SU"(2)$ versus $"SO"(3)$)

#task(label: "a")[Determine the Lie algebras of $"SU"(2)$ and $"SO"(3)$ and show that they are isomorphic.]

The $"SU"(2)$ Lie algebra is
$
  frak(s u)(2) & = {A in "Mat"(2, 2, CC) | tr(A) = 0, A^dagger = -A} \
  & = {mat(i a, -overline(z); z, -i a) | a in RR, z in CC},
$
which amounts to the vector space of all traceless, antihermitian $2 times 2$ matrices over $CC$. It is $n^2 - 1 = 3$-dimensional and generated by the following matrices
$ u_1 = mat(0, i; i, 0), quad u_2 = mat(0, -1; 1, 0), quad u_3 = mat(i, 0; 0, -i). $
The Lie algebra of $"SO"(3)$,
$ frak(s o)(3) = {A in "Mat"(3, 3, RR) | A^T = -A} = {mat(0, -omega_z, omega_y; omega_z, 0, -omega_x; -omega_y, omega_x, 0) | omega_x, omega_y, omega_z in RR}, $
is the vector space of all antisymmetric $3 times 3$ matrices over $RR$. $frak(s o)(3)$ is $n/2 (n - 1) = 3$-dimensional with a generating basis formed by the following three matrices
$ o_1 = mat(0, 0, 0; 0, 0, -1; 0, 1, 0), quad o_2 = mat(0, 0, 1; 0, 0, 0; -1, 0, 0), quad o_3 = mat(0, -1, 0; 1, 0, 0; 0, 0, 0). $
Both assertions concerning the structure of the Lie algebras $frak(s u)(2)$ and $frak(s o)(3)$ can be seen by selecting and differentiating smooth curves from their corresponding Lie groups:

- Let $U(t) in "SU"(2)$ be a smooth curve with $U(0) = bb(1)_2$. Then $U(t)$ satisfies
  $ U^dagger (t) U(t) = bb(1)_2, quad det(U(t)) = 1. $
  Differentiation yields
  $ (dif U^dagger (t)) / (dif t) U(t) + U^dagger (t) (dif U(t)) / (dif t) = 0, quad tr(U^(-1) (t) (dif U(t)) / (dif t)) = 0, $
  which, for $t = 0$ and writing $(dif U(t)) / (dif t)|_(t=0)$ as $u in frak(s u)(2)$, demonstrates the above claims:
  $ u^dagger + u = 0, quad tr(u) = 0. $

- Let $O(t) in "SO"(3)$ be a smooth curve with $O(0) = bb(1)_3$. Then $O(t)$ satisfies the defining relation of $"O"(3)$-elements $O^T (t) O(t) = bb(1)_3$. Thus
  $ (dif O^T (t)) / (dif t) O(t) + O^T (t) (dif O(t)) / (dif t) = 0 $
  and so for $t = 0$ and $o := (dif O(t)) / (dif t)|_(t=0)$: $o^T + o = 0$.

Now on to the isomorphy between $frak(s u)(2)$ and $frak(s o)(3)$. We can show this relation using the group homomorphism $Phi: "SU"(2) -> "SO"(3)$ to construct an isomorphism $phi: frak(s u)(2) -> frak(s o)(3)$.

We start by expressing $Phi$ using abstract index notation. Let $f(arrow(x))$ be a function of position $arrow(x)$, $underline(U) in "SU"(2)$ and $underline(R) = Phi(underline(U)) in "SO"(3)$ the corresponding rotation matrix. Then
$
  f(underline(R) arrow(x)) & = f(Phi(underline(U)) arrow(x)) = underline(U) f(arrow(x)) underline(U)^dagger, \
  underline(R)^i_j x^j underline(sigma)_i & = underline(U) x^j underline(sigma)_j underline(U)^dagger.
$
Differentiating at $t = 0$ and setting $(dif underline(R)) / (dif t)|_(t=0) = underline(X) in frak(s o)(3)$, $underline(U)(0) = bb(1)_2$ and $(dif underline(U)) / (dif t)|_(t=0) = underline(A) = a^i underline(s)_i in frak(s u)(2)$ with $underline(s)_i = -i/2 underline(sigma)_i$, we obtain
$
  underline(X)^i_j x^j underline(sigma)_i & = underline(A) x^j underline(sigma)_j + x^j underline(sigma)_j underline(A)^dagger, \
  x^j underline(X)^i_j underline(sigma)_i & = x^j (underline(A) underline(sigma)_j - underline(sigma)_j underline(A)) = x^j [underline(A), underline(sigma)_j] = x^j [a^i underline(s)_i, underline(sigma)_j] \
  & = -i/2 x^j a^i [underline(sigma)_i, underline(sigma)_j] = -i/2 x^j a^i (2 i epsilon_(i j)^k underline(sigma)_k) \
  & = x^j a^i epsilon_(i j)^k underline(sigma)_k = x^j (a^k epsilon_(k j)^i) underline(sigma)_i \
  & =: x^j phi(underline(A))^i_j underline(sigma)_i.
$
So the isomorphism between $frak(s u)(2)$ and $frak(s o)(3)$ is given by
$ phi(underline(A))^i_j = -epsilon^i_(j k) a^k: frak(s u)(2) -> frak(s o)(3), $
which maps the basis $underline(s)_k$ of $frak(s u)(2)$ onto the basis $o_k$ of $frak(s o)(3)$ given above.
With this knowledge, we can say that because Lie algebras are locally identical to their corresponding Lie groups, $"SU"(2)$ and $"SO"(3)$ are locally isomorphic.
