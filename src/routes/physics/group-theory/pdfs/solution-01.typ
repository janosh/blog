#import "/notes.typ": notes, task

#show: notes.with(
  title: [Group Theory -- Problem Sheet 1],
  subtitle: [Exercise sheet 1, Group Theory, Prof. Daniel Roggenkamp],
  date: [Solutions by Janosh Riebesell, 12.05.2015],
)

= Exercise 1 (Definitions)

#task(label: "a")[Define what a group is and show from the axioms that left-identity and -inverses are also right-identity and -inverses, and that identity and inverses are unique.]

Group: algebraic structure $(G, chevron.l dot, dot chevron.r)$ consisting of
- a set of elements $G$ and
- an operation $chevron.l dot, dot chevron.r$ that satisfies the group axioms:

+ Closure: $forall a, b in G: chevron.l a, b chevron.r in G$
+ Associativity: $forall a, b, c in G: chevron.l chevron.l a, b chevron.r, c chevron.r = chevron.l a, chevron.l b, c chevron.r chevron.r$
+ Identity: $exists! e in G thin forall a in G: chevron.l e, a chevron.r = a$
+ Inverse: $exists! a^(-1) in G thin forall a in G: chevron.l a^(-1), a chevron.r = e$

From now on, the group operation between two elements of a group is implicit, i.e. $chevron.l a, b chevron.r -> a b$. We prove that left- and right-identity and inverse are equal and their uniqueness:
$
  a^(-1) a = e & ==> a^(-1) (a a^(-1)) = underbrace((a^(-1) a), e) a^(-1) = e a^(-1) = a^(-1) & ==> a a^(-1) = e quad & "(right inverse)", \
  a a^(-1) = e & ==> a e = a (a^(-1) a) = underbrace((a a^(-1)), e) a = e a & ==> a e = a attach(=, t: !) e a quad & "(right identity)",
$
$
  "assume" exists e, e' in G: e a = a, e' a = a thin forall a in G & ==> e = e e' = e' & ==> e = e' quad & "(identity unique)", \
  "assume" exists a^(-1), a'' in G: a^(-1) a = e, a'' a = e thin forall a in G & ==> a^(-1) a = e = a'' a & ==> a^(-1) = a'' quad & "(inverse unique)".
$

#task(label: "b")[What is a group homomorphism? Show that the map $ZZ -> ZZ_n$, $z |-> [z]$ is a group homomorphism.]

Group homomorphism: given two groups $(G, *)$, $(H, dot)$, $phi: G -> H$ is a group homomorphism if
$ phi(g_1 * g_2) = phi(g_1) dot phi(g_2) quad forall g_1, g_2 in G. $
Here:
$ forall z_1, z_2 in ZZ: quad [z_1 + z_2] = [z_1] + [z_2]. $

#task(label: "c")[What is a subgroup? Show that the rotations form a subgroup $ZZ_n subset D_n$ of the dihedral group $D_n$.]

Given two groups $(G, dot)$, $(H, dot)$, $(G, dot)$ is a subgroup of $(H, dot)$ if $forall g in G$: $g in H$.
$ D_n = {R_0, R_1, ..., R_(n-1), S_0, S_1, ..., S_(n-1)}, $
the group of symmetries of a regular $n$-gon,
$ ZZ_n = D_n without {S_0, S_1, ..., S_(n-1)} subset D_n. $

#task(label: "d")[What are conjugacy classes? Determine all conjugacy classes of $D_4$ and $D_5$. What about general $D_n$?]

Conjugacy class:
$ C_g = [g] = {g' in G | exists tilde(g) in G: tilde(g) g tilde(g)^(-1) = g'}, $
$
  D_4 & = {R_0, R_1, R_2, R_3, S_0, S_1, S_2, S_3}, \
  [R_0] & = {R_0, R_1, R_2, R_3, S_0, S_1, S_2, S_3}.
$

= Exercise 2 (Finite groups)

#task(label: "a")[Let $G$ be a finite group with a prime number of elements. What can you say about $G$?]

By Lagrange's theorem, $G$ can only have the two trivial subgroups ${e}$ and $G$. Since we can always construct orbits $Gamma_g$ for all elements $g in G$, which by the closure axiom are subgroups of $G$, we have $Gamma_e = {e}$ or $Gamma_g = G$. Since $Gamma_g$ is isomorphic to $ZZ_(|G|)$, $Gamma_g tilde.equiv ZZ_(|G|)$, we have that $G$ is isomorphic to $ZZ_(|G|)$, $G tilde.equiv ZZ_(|G|)$.

#task(label: "b")[Write the multiplication table of $ZZ_3$ and the respective embedding $ZZ_3 arrow.r.hook S_3$ into the symmetric group.]

#grid(
  columns: (1fr, 1fr),
  align: horizon + center,
  table(
    columns: 4,
    stroke: (x, y) => (
      left: if x == 1 { 0.6pt },
      bottom: if y == 0 { 0.6pt },
    ),
    inset: 6pt,
    $ZZ_3$, $0$, $1$, $2$,
    $0$, $0$, $1$, $2$,
    $1$, $1$, $2$, $0$,
    $2$, $2$, $0$, $1$,
  ),
  [$ZZ_3 attach(arrow.r.hook, t: pi) S_3$:
    $
      pi_0: 0 & |-> mat(0, 1, 2; 0, 1, 2), \
      pi_1: 1 & |-> mat(0, 1, 2; 1, 2, 0), \
      pi_2: 2 & |-> mat(0, 1, 2; 2, 0, 1)
    $],
)

= Exercise 3 (Symmetric group)

#task(label: "a")[Write the permutation $pi = mat(1, 2, 3, 4, 5, 6; 3, 1, 5, 2, 4, 6)$ as product of non-intersecting cycles.]

$ pi = (1 thin 3 thin 5 thin 4 thin 2)(6) $

#task(label: "b")[What is the order of $S_3$? How many conjugacy classes does $S_3$ have? Determine their sizes, and give a representation of each one.]

$|S_3| = 3! = 6$. $S_3$ has $p(3) = 3$ conjugacy classes, where $p(n)$ is the number of partitions of $n$. Conjugacy class sizes can be calculated using
$ |C_((k_1, ..., k_n))| = n! / (product_i i^(k_i) k_i !), $
where the $k_i$ give the number of permutation cycles of length $i$. Considering the different partitions of $n$, we get
$
  lambda = (3, 0, 0), quad k = (3, 0, 0): quad & C_((3,0,0)) = (3!) / (1^3 3! dot 2^0 0! dot 3^0 0!) = 1, \
  lambda = (2, 1, 0), quad k = (1, 1, 0): quad & C_((1,1,0)) = (3!) / (1^1 1! dot 2^1 1! dot 3^0 0!) = 3, \
  lambda = (1, 1, 1), quad k = (0, 0, 1): quad & C_((0,0,1)) = (3!) / (1^0 0! dot 2^0 0! dot 3^1 1!) = 2.
$
Representatives:
$
  lambda = (3, 0, 0): quad & e = (1)(2)(3), \
  lambda = (2, 1, 0): quad & (1 thin 2)(3), \
  lambda = (1, 1, 1): quad & (1 thin 2 thin 3).
$

#task(label: "c")[Show that $H = {e, (1, 2)} subset S_3$ is a subgroup. Is it normal?]

Closure of $H$:
$
  e e = e in H, quad e (1, 2) = (1, 2) in H, quad (1, 2) e = (1, 2) in H, \
  (1, 2)(1, 2) = e in H.
$
Associativity: is inherited from $S_3$, since $e, (1, 2) in S_3$.

Identity: $e$ #h(0.3em) $checkmark$

Inverse: $e e = e$, $(1, 2)(1, 2) = e$ #h(0.3em) $checkmark$

All four group axioms are met. Therefore $H subset S_3$ is a subgroup. Since $H$ cannot be formed by conjugacy classes of $S_3$, it is not normal in $S_3$.

= Exercise 4 (Commutator subgroup)

#task[
  Let $G$ be a group. The commutator of two elements $g, h in G$ is defined by $[g, h] := g^(-1) h^(-1) g h in G$. The commutator subgroup of $G$ is the group generated by all commutators in $G$:
  $ [G, G] = {[g_1, h_1] dots.c [g_n, h_n] | n in NN, g_i, h_i in G}. $
]

#task(label: "a")[Show that the commutator subgroup is indeed a subgroup $[G, G] subset G$.]

We use the condition that if for all $[g, h], [k, l] in [G, G]$, $[g, h][k, l]^(-1) in [G, G]$, where $g, h, k, l in G$, then $[G, G] subset G$ is a subgroup. We have
$ [k, l]^(-1) = (k^(-1) l^(-1) k l)^(-1) = l^(-1) k^(-1) l k = [l, k] $
and therefore
$ [g, h][k, l]^(-1) = [g, h][l, k] in [G, G] $
by definition of $[G, G]$.

#task(label: "b")[Show that it is a normal subgroup $[G, G] lt.closed G$.]

$ [G, G] lt.closed G "is a normal subgroup" quad <==> quad forall g in G: g [G, G] g^(-1) = [G, G]. $
We prove the above equality by showing that each is a subgroup of the other.

$g [G, G] g^(-1) subset [G, G]$: $forall g in G$, $[k, l] in [G, G]$, we have
$ [k, l]^(-1) g [k, l] g^(-1) = [[k, l], g^(-1)] in [G, G]. $
From this it follows, since $[G, G] subset G$ is a subgroup fulfilling closure w.r.t. the group action, that
$ [k, l][k, l]^(-1) g [k, l] g^(-1) = g [k, l] g^(-1) in [G, G]. $

$g [G, G] g^(-1) supset [G, G]$: $forall [k, l] in [G, G]$ $exists m, n in G$: $g m g^(-1) = k and g n g^(-1) = l$, where we used that conjugation is a homomorphism on $G$
$
  ==> [k, l] & = [g m g^(-1), g n g^(-1)] = (g m g^(-1))^(-1) (g n g^(-1))^(-1) g m g^(-1) g n g^(-1) \
  & = g m^(-1) g^(-1) g n^(-1) g^(-1) g m g^(-1) g n g^(-1) = g m^(-1) n^(-1) m n g^(-1) \
  & = g [m, n] g^(-1) in g [G, G] g^(-1).
$
Therefore, $[G, G] lt.closed G$.

= Exercise 5 (Group actions)

#task[
  An action of a group $G$ on a set $X$ is a group homomorphism $phi: G -> "Bij"(X)$ from $G$ into the group $"Bij"(X)$ of bijections from $X$ to $X$. One often uses the abbreviated notation $g x := phi(g)(x)$. For any $x in X$ its orbit in $G$ is defined by
  $ "Orb"_G (x) = G x = {g x | g in G} subset X. $
  The stabilizer of $x in X$ is defined by
  $ "Stab"_G (x) = {g in G | g x = x} subset G. $
]

#task(label: "a")[Show that the stabilizer is a subgroup of $G$.]

For this, we again resort to the 'one-step' subgroup test, i.e. we show that $"Stab"_G (x) subset G$ is a _subset_ of $G$ and that $"Stab"_G (x) != emptyset$ is not empty (both of which are fulfilled by definition) and that $forall a, b in "Stab"_G (x)$, we have $a b^(-1) in "Stab"_G (x)$, where always $x in X$. For such $a$ and $b$, we can write
$
  b^(-1) x = b^(-1) (b x) & attach(=, t: !) (b^(-1) b) x = x, quad "where we used that" phi "is a homomorphism", \
  ==> (a b^(-1)) x & = a (b^(-1) x) = a x = x \
  ==> a b^(-1) & in "Stab"_G (x) quad "and" quad "Stab"_G (x) subset G.
$

#task(label: "b")[Show that stabilizers of elements $y, y' in X$ which lie in the same $G$-orbit (i.e. $y, y' in "Orb"_G (x)$ for some $x in X$) are conjugate.]

Since $y, y' in "Orb"_G (x)$, $exists a, b in G: a x = y, b x = y'$. $G$ being a group, we can invert to get $a^(-1) y = x = b^(-1) y'$. For any $g in "Stab"_G (y)$, we have
$ g y = y quad <==> quad g (a x) = a x quad <==> quad a^(-1) g (a x) = x. $
Inserting $x = b^(-1) y'$ gives
$ a^(-1) g (a b^(-1) y') = b^(-1) y' quad <==> quad (b a^(-1)) g (a b^(-1)) y' = y', $
from which we deduce that
$ underbrace((b a^(-1)), h) g underbrace((a b^(-1)), h^(-1)) =: h g h^(-1) in "Stab"_G (y'). $
Since this holds for all $g in "Stab"_G (y)$, we found $h thin "Stab"_G (y) thin h^(-1) = "Stab"_G (y')$.

#task(label: "c")[Show that the map $G x -> G \/ "Stab"_G (x)$, which sends $g x |-> g thin "Stab"_G (x)$, is well defined (i.e. $g x = h x ==> g thin "Stab"_G (x) = h thin "Stab"_G (x)$) and is a bijection.]
