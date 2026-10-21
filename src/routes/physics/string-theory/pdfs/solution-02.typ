#import "/notes.typ": note, task, vb, eqby
#import "/string-theory/sheet.typ": SP, chr, riem, u2, sheet

#show: sheet.with(2, [October 19th, 2015], [October 28th, 2015])

#let (bM, bh, bG, bP, bS) = ($vb(M)$, $vb(h)$, $vb(G)$, $vb(P)$, $vb(S)$)
#let Tr = math.op("Tr")
#let adj = math.op("adj")

= The Polyakov action

#task[
  The Polyakov action is given by
  $ SP = -1/(4 pi alpha') integral_Sigma dif tau dif sigma sqrt(-h) h^(a b) partial_a X^mu partial_b X^nu eta_(mu nu), $ <eq:polyakov>
  where $h_(a b)$ is the world-sheet metric, $h^(a b)$ is its inverse and $-h equiv -det(bh)$. The quantity $G_(a b) equiv partial_a X^mu partial_b X^nu eta_(mu nu)$ is called the pull-back of the target space metric $eta_(a b)$ on to the world-sheet.
  + For an arbitrary square matrix $bM$, useful variation identities are
    $
      delta (det bM) & = det(bM) Tr(bM^(-1) delta bM), \
                     & = -det(bM) Tr(bM delta bM^(-1)),
    $ <eq:det-variation>
    $ delta bM^(-1) = -bM^(-1) delta bM bM^(-1). $ <eq:inv-variation>
    Show this, where for simplicity you may assume that $bM$ is diagonalizable.
  + Use part a) to show that the energy momentum tensor, defined by
    $ T_(a b) equiv (4 pi)/sqrt(-h) (delta SP)/(delta h^(a b)), $ <eq:em-tensor>
    is given by
    $ T_(a b) = -1/alpha' (partial_a X^mu partial_b X^nu eta_(mu nu) - 1/2 h_(a b) h^(c d) partial_c X^mu partial_d X^nu eta_(mu nu)). $
  + The equation of motion for the world sheet metric $h_(a b)$ implies $T_(a b) = 0$. Use this to show the equivalence of the Polyakov action and the Nambu-Goto action.
  + Neglecting boundary terms, show that the equation of motion for $X^mu$ is given by
    $ h^(a b) nabla_a (partial_b X^mu) = 0. $
    *Note:* Take this opportunity to recall that for a vector $S^a$ one has
    $ nabla_a (sqrt(-det(h)) S^a) = partial_a (sqrt(-det(h)) S^a), $
    and that $nabla_a (det h) = 0$.
  + Use part d) to show the conservation of energy and momentum,
    $ nabla^a T_(a b) = 0. $
  + Use the conformal invariance of the action to show that the energy momentum tensor is traceless. Do not use the equation of motion for $X^mu$.
  + Now suppose we add to the Polyakov action @eq:polyakov the 2-dimensional cosmological constant term
    $ S_"cc" = lambda_"cc" integral_Sigma dif tau dif sigma sqrt(-h). $ <eq:cc>
    Show that consistency of the equations of motion for the metric $h_(a b)$ requires $lambda_"cc" = 0$.
]

+ Note that requiring $bM$ to be square and diagonalizable is not sufficient for the identities @eq:det-variation and @eq:inv-variation to be true in general, since $bM$ may have a zero eigenvalue on the diagonal, in which case $det(bM) = 0$ and $bM$ is not invertible. A trivial example for this is the zero matrix $vb(0)$ which is obviously square and diagonal but for which identities @eq:det-variation and @eq:inv-variation are undefined. We proceed here by assuming that $bM^(-1)$ exists.

  The determinant $det(bM)$ is a function of all elements of $bM$, i.e. if $bM$ is $n times n$,
  $ det(bM) = det(bM)(M_11, M_12, ..., M_(n n)). $
  Therefore, by the chain rule, we have
  $ delta det(bM) = (partial det(bM))/(partial M_11) delta M_11 + ... (partial det(bM))/(partial M_(n n)) delta M_(n n) = sum_(i,j=1)^n (partial det(bM))/(partial M_(i j)) delta M_(i j). $ <eq:chain-rule>
  The cofactor expansion (a.k.a. Laplace's formula) for the determinant can be taken by summing over the matrix entries $M_(i j)$ and their corresponding cofactors $C_(i j)$ of any _one_ row $i$ or column $j$, i.e.
  $ det(bM) = sum_(j=1)^n M_(i j) C_(i j), $
  where $C_(i j) = adj(bM)_(j i)$. Inserting this into $(partial det(bM))/(partial M_(i j))$ from the r.h.s of eq. @eq:chain-rule and executing the product rule, we get
  $ (partial det(bM))/(partial M_(i j)) = partial/(partial M_(i j)) (sum_(k=1)^n M_(i k) C_(i k)) = sum_(k=1)^n (partial M_(i k))/(partial M_(i j)) C_(i k) + sum_(k=1)^n M_(i k) (partial C_(i k))/(partial M_(i j)). $
  This expression drastically simplifies if we take into account that the cofactor $C_(i k)$ of $M_(i k)$ depends only on elements of $bM$ not in the same row or column as $M_(i k)$, i.e. $(partial C_(i k))/(partial M_(i j)) = 0 thick forall j, k$. Therefore
  $ (partial det(bM))/(partial M_(i j)) = sum_(k=1)^n underbrace((partial M_(i k))/(partial M_(i j)), delta_(j,k)) C_(i k) = C_(i j) = adj(bM)_(j i). $
  Reinsertion of this result into eq. @eq:chain-rule yields
  $ delta det(bM) = sum_(i,j=1)^n adj(bM)_(j i) delta M_(i j) = Tr[adj(bM) delta bM]. $
  Since $bM$ is assumed to be invertible, we may write the adjoint as $adj(bM) = det(bM) bM^(-1)$ and use linearity of the trace to arrive at
  $ delta det(bM) = Tr[det(bM) bM^(-1) delta bM] = -det(bM) Tr[bM delta bM^(-1)], $
  where in the last step, we used eq. @eq:inv-variation and cyclicity of the trace. Equation @eq:inv-variation follows directly from the product rule:
  $ 0 = delta (bM^(-1) bM) = delta bM^(-1) bM + bM^(-1) delta bM wide => wide delta bM^(-1) = -bM^(-1) delta bM bM^(-1). $
+ By direct calculation, we get
  $
    T_(a b) (tau, sigma) & = (4 pi)/sqrt(-h) (delta SP)/(delta h^(a b) (tau, sigma)) \
    & = (4 pi)/sqrt(-h) delta/(delta h^(a b)) (-1/(4 pi alpha') integral_Sigma dif tau' dif sigma' sqrt(-h) h^(c d) (tau', sigma') partial_c X^mu (tau', sigma') partial_d X^nu (tau', sigma') eta_(mu nu)) \
    & = -1/(alpha' sqrt(-h)) integral_Sigma dif tau' dif sigma' delta/(delta h^(a b)) (sqrt(-h) h^(c d)) partial_c X^mu partial_d X^nu eta_(mu nu) \
    & = -1/(alpha' sqrt(-h)) integral_Sigma dif tau' dif sigma' (sqrt(-h) (delta h^(c d) (tau', sigma'))/(delta h^(a b) (tau, sigma)) - 1/2 1/sqrt(-h) (delta h)/(delta h^(a b)) h^(c d)) partial_c X^mu partial_d X^nu eta_(mu nu) \
    & limits(=)^"a)" -1/(alpha' sqrt(-h)) integral_Sigma dif tau' dif sigma' [sqrt(-h) delta_a^(#h(0.1em) c) delta_b^(#h(0.1em) d) delta(tau - tau') delta(sigma - sigma') \
    & #h(9em) - 1/2 h^(c d)/sqrt(-h) (-h h_(e f) underbrace((delta h^(e f) (tau', sigma'))/(delta h^(a b) (tau, sigma)), delta_a^(#h(0.1em) e) delta_b^(#h(0.1em) f) delta(tau - tau') delta(sigma - sigma')))] partial_c X^mu partial_d X^nu eta_(mu nu) \
    & = -1/(alpha' sqrt(-h)) [sqrt(-h) partial_a X^mu partial_b X^nu eta_(mu nu) - 1/2 h^(c d)/sqrt(-h) (-h h_(a b)) partial_c X^mu partial_d X^nu eta_(mu nu)] \
    & = -1/alpha' [partial_a X^mu partial_b X^nu eta_(mu nu) - 1/2 h_(a b) h^(c d) partial_c X^mu partial_d X^nu eta_(mu nu)],
  $ <eq:em-result>
  where we used identity @eq:det-variation from part a) in the form of
  $ delta h = delta (det bh) = -det(bh) Tr(bh delta bh^(-1)) = -h h_(e f) delta h^(e f), $
  and refrained from writing out $tau$ and $sigma$ dependencies in many places in order to save space.
+ The Nambu-Goto action is given by
  $ S_"NG" = -T integral_Sigma dif tau dif sigma sqrt(-det(bG)), $ <eq:nambu-goto>
  where the $T = 1/(2 pi alpha')$ is the string tension, and the components of the $2 times 2$-matrix $bG$ can be calculated via
  $ G_(a b) = partial_a X^mu partial_b X^nu eta_(mu nu), #h(3em) a, b in {tau, sigma}. $
  $bG$ is called the induced metric or the pullback of the ambient space metric $eta_(mu nu)$ onto the string worldsheet $Sigma$, i.e. it describes the embedding of a string in spacetime. Expressed in terms of $T$ and $bG$, the Polyakov action reads
  $ SP = -1/(4 pi alpha') integral_Sigma dif tau dif sigma sqrt(-h) h^(a b) partial_a X^mu partial_b X^nu eta_(mu nu) = -T/2 integral_Sigma dif tau dif sigma sqrt(-h) underbrace(h^(a b) G_(a b), bh bG). $
  By its very definition as given in eq. @eq:em-tensor, the energy-momentum tensor $T_(a b)$ is required to vanish by the equation of motion for $h_(a b)$ resulting from an application of Hamilton's principle. Going back to our result from part b), we see that $T_(a b) = 0$ together with eq. @eq:em-result implies
  $
    T_(a b) & = -1/alpha' (underbrace(partial_a X^mu partial_b X^nu eta_(mu nu), G_(a b)) - 1/2 h_(a b) h^(c d) underbrace(partial_c X^mu partial_d X^nu eta_(mu nu), G_(c d))) = 0 \
    & => wide G_(a b) = 1/2 h_(a b) h^(c d) G_(c d) = 1/2 h_(a b) bh bG.
  $ <eq:g-proportional>
  Taking the determinant of eq. @eq:g-proportional, we get
  $ det(bG) = (1/2 bh bG)^2 det(bh), $
  where the square around $1/2 bh bG$ appears because the worldsheet is two-dimensional. Inserting this result into the Nambu-Goto action @eq:nambu-goto, we indeed arrive at the Polyakov action:
  $ S_"NG" = -T integral_Sigma dif tau dif sigma sqrt(-(1/2 bh bG)^2 det(bh)) = -T/2 integral_Sigma dif tau dif sigma sqrt(-h) bh bG = SP. $
+ We calculate the string field's equation of motion by variation of the action:
  $
    (delta SP)/(delta X_mu) & = delta/(delta X_mu) (-T/2 integral_Sigma dif tau' dif sigma' sqrt(-h) h^(a b) partial_a X_nu partial_b X^nu) \
    & = -T integral_Sigma dif tau' dif sigma' sqrt(-h) h^(a b) partial_b X^nu (delta (partial_a X_nu))/(delta X_mu) \
    & = T integral_Sigma dif tau' dif sigma' partial_a (sqrt(-h) h^(a b) partial_b X^nu) underbrace((delta X_nu)/(delta X_mu), delta^mu_(#h(0.1em) nu) delta(tau - tau') delta(sigma - sigma')) - underbrace(lr(T sqrt(-h) h^(a b) partial_a X^nu (delta X_nu)/(delta X_mu) |)_(partial Sigma), "boundary term assumed to vanish") \
    & = T partial_a (sqrt(-h) h^(a b) partial_b X^mu) limits(=)^! 0.
  $ <eq:x-eom>
  From exercise 2.a) on assignment 1, we know that for any tensor $S_(a b)$, the determinant's square root $sqrt(det(bS))$ is a _scalar_ density of weight $w = 1$. Therefore, the quantity $sqrt(-h) h^(a b) partial_b X^mu$ is a _tensor_ density of weight 1. We would like to compute its covariant derivative.

  The covariant derivative $nabla_a T^(b_1 ... b_r) zws_(c_1 ... c_s)$ of an arbitrary rank-$(r, s)$ tensor $T^(b_1 ... b_r) zws_(c_1 ... c_s)$ is given by its partial derivative $partial_a T^(b_1 ... b_r) zws_(c_1 ... c_s)$ plus an upstairs contraction with the connection for every contravariant index, $chr(b_1, a d) T^(d ... b_r) zws_(c_1 ... c_s)$, and minus a downstairs contraction for every covariant index, $chr(d, a c_1) T^(b_1 ... b_r) zws_(d ... c_s)$. The covariant derivative of a _tensor density_ of weight $w$ is defined in exactly the same way, except that we also subtract a term scaled with $w$ where the connection is contracted with itself, i.e. $w chr(d, a d) T^(b_1 ... b_r) zws_(c_1 ... c_s)$.

  Applying this prescription to $sqrt(-h) h^(a b) partial_b X^mu$, we get
  $ nabla_a (sqrt(-h) h^(a b) partial_b X^mu) = partial_a (sqrt(-h) h^(a b) partial_b X^mu) + chr(a, a c) sqrt(-h) h^(c b) partial_b X^mu - 1 dot chr(c, c a) sqrt(-h) h^(a b) partial_b X^mu. $ <eq:density-derivative>
  All the indices appearing in eq. @eq:density-derivative are summed over, so we may rename as we like. Exchanging $a$ and $c$ in the last term, we see that it exactly cancels the second. We are left with $nabla_a (sqrt(-h) h^(a b) partial_b X^mu) = partial_a (sqrt(-h) h^(a b) partial_b X^mu)$. Using this result on our e.o.m. @eq:x-eom, we obtain
  $ 0 = nabla_a (sqrt(-h) h^(a b) partial_b X^mu) = sqrt(-h) h^(a b) nabla_a (partial_b X^mu), $
  since the metric connection satisfies $nabla_a h_(b c) = 0$ (by the chain rule, the same holds for $sqrt(-h)$ and any other function of $h_(a b)$). Dividing by the uninteresting prefactor $sqrt(-h)$ which does not affect dynamics, we arrive at
  $ h^(a b) nabla_a (partial_b X^mu) = 0. $
+ Conservation of energy and momentum again follows from direct computation,
  $
    nabla^a T_(a b) & = -1/alpha' nabla^a (partial_a X_mu partial_b X^mu - 1/2 h_(a b) partial_c X_mu partial^c X^mu) \
    & = -1/alpha' [underbrace((nabla^a partial_a X_mu), "=0, by part d)") partial_b X^mu + partial_a X_mu (nabla^a partial_b X^mu) \
    & #h(5em) - 1/2 h_(a b) (underbrace((nabla^a partial_c X_mu) partial^c X^mu + partial_c X_mu (nabla^a partial^c X^mu), 2 partial_c X_mu (nabla^a partial^c X^mu)))] \
    & = -1/alpha' [partial_a X_mu (nabla^a partial_b X^mu) - underbrace(partial_c X_mu (nabla_b partial^c X^mu), c -> a)] \
    & = -1/alpha' partial_a X_mu [nabla^a partial_b X^mu - nabla_b partial^a X^mu] = 0,
  $
  where in the last step, the two terms in brackets cancel because
  $
    nabla^a partial_b X^mu & = h^(a c) nabla_c partial_b X^mu = h^(a c) (partial_c partial_b X^mu - chr(d, c b) partial_d X^mu) \
    & = h^(a c) (partial_b partial_c X^mu - chr(d, b c) partial_d X^mu) = h^(a c) nabla_b partial_c X^mu = nabla_b partial^a X^mu.
  $
+ Before proceeding with the exercise, it is important in this context to understand the difference between a conformal and a Weyl transformation, especially since in the lecture these two completely different concepts have been treated as one and the same.
  #note[
    #set enum(numbering: "1.")
    + A conformal transformation is a spacetime transformation which leaves the metric invariant up to (generally spacetime-dependent) scaling. The important property here is that angles are preserved.
    + A Weyl transformation actively scales the metric.

    Formally, the difference can be expressed by considering two manifolds $M$ and $N$ with inner products, i.e. metrics, $vb(g)$ and $bh$, and coordinates $x^i$ and $y^i$, respectively. A map $f : M -> N$ from one manifold to another is called conformal if there exists a function $Omega in C^infinity (M)$ so that the pullback $f^* bh$ fulfills
    $ f^* bh = Omega vb(g), $ <eq:conformal-map>
    which in coordinate notation reads
    $ (partial y^i)/(partial x^r) (partial y^j)/(partial x^s) h_(i j) (y) = Omega(x) g_(r s) (x). $
    In case of conformal transformations, we have $M = N$ and thus equal metrics $vb(g) = bh$ so that eq. @eq:conformal-map becomes
    $ f^* vb(g) = Omega vb(g), $
    or written in terms of the coordinates,
    $ (partial y^i)/(partial x^r) (partial y^j)/(partial x^s) g_(i j) (y) = Omega(x) g_(r s) (x), $
    which is just a coordinate transformation $x -> y$. \
    In case of Weyl transformations, we are simply scaling the metric, so here we also have $M = N$. However, since we are not changing coordinates this time around, the map $f$ will simply be given by $f = "id"_M$, yielding
    $ h(x) = Omega(x) g(x), $
    or in coordinates,
    $ h_(i j) (x) = Omega(x) g_(i j) (x). $
  ]
  After this short interlude, we note that even though the exercise mentions conformal invariance, we think it actually means what we have just distinguished to be Weyl invariance. From section 2.2.3 of the lecture notes, we know that the Polyakov action @eq:polyakov features a local Weyl invariance. The metric on the other hand explicitly changes under a Weyl transformation#footnote[In fact, the change in the metric is the root cause for all changes that may occur under a Weyl transformation in other quantities if they depend on the metric]. The same holds for its inverse and its determinant. They transform as
  $ h_(a b) -> e^(2 Lambda(tau, sigma)) h_(a b), wide h^(a b) -> e^(-2 Lambda(tau, sigma)) h^(a b), wide det(bh) -> e^(2 d Lambda(tau, sigma)) det(bh), $
  respectively, where $d$ is the dimensionality of the space in which the determinant is taken, i.e. $d = 2$ on the worldsheet.

  Going back to eq. @eq:em-tensor, we see that under Weyl transformations, the energy-momentum tensor remains invariant,
  $ T_(a b) -> T'_(a b) = (4 pi)/sqrt(-h') (delta S'_"P")/(delta h'^(a b)) = (4 pi)/sqrt(-e^(4 Lambda) h) (delta SP)/(e^(-2 Lambda) delta h^(a b)) = (4 pi)/sqrt(-h) (delta SP)/(delta h^(a b)) = T_(a b). $
  Next, we check the trace $T^a zws_a$,
  $ T^a zws_a = h^(a b) T_(a b) -> T'^a zws_a = h'^(a b) T'_(a b) = e^(-2 Lambda) h^(a b) T_(a b) = e^(-2 Lambda) T^a zws_a. $
  This alone does not constrain the trace yet. Instead, we use that the action itself is Weyl invariant. Under an infinitesimal Weyl transformation $delta h^(a b) = -2 Lambda h^(a b)$, the action changes by
  $ 0 = delta SP = integral_Sigma dif tau dif sigma (delta SP)/(delta h^(a b)) delta h^(a b) = -1/(2 pi) integral_Sigma dif tau dif sigma sqrt(-h) Lambda(tau, sigma) h^(a b) T_(a b). $
  Since this has to hold for arbitrary $Lambda(tau, sigma)$, the energy-momentum tensor must be traceless, $T^a zws_a = 0$.
+ Adding the cosmological constant term @eq:cc to the Polyakov action @eq:polyakov, we get
  $ S_("P+cc") = SP + S_"cc" = -1/(4 pi alpha') integral_Sigma dif tau dif sigma sqrt(-h) h^(a b) partial_a X^mu partial_b X^nu eta_(mu nu) + lambda_"cc" integral_Sigma dif tau dif sigma sqrt(-h). $
  The metric's equation of motion for this action is
  $
    (delta S_("P+cc"))/(delta h^(a b)) & = (delta SP)/(delta h^(a b)) + (delta S_"cc")/(delta h^(a b)) = sqrt(-h)/(4 pi) T_(a b) + lambda_"cc" integral_Sigma dif tau' dif sigma' (-1/2 1/sqrt(-h) (delta h)/(delta h^(a b))) \
    & eqby("eq:det-variation") sqrt(-h)/(4 pi) T_(a b) - lambda_"cc"/2 integral_Sigma dif tau' dif sigma' ((-h)/sqrt(-h) h_(e f) underbrace((delta h^(e f) (tau', sigma'))/(delta h^(a b) (tau, sigma)), delta_a^(#h(0.1em) e) delta_b^(#h(0.1em) f) delta(tau - tau') delta(sigma - sigma'))) \
    & = sqrt(-h)/(4 pi) T_(a b) - lambda_"cc"/2 sqrt(-h) h_(a b) limits(=)^! 0,
  $ <eq:cc-eom>
  where we again used the variational identity @eq:det-variation to calculate the term $(delta h)/(delta h^(a b))$ and obtain the second line. In the above, $T_(a b)$ is the energy-momentum tensor of the unmodified Polyakov action $SP$. Equation @eq:cc-eom implies
  $ T_(a b) = 2 pi lambda_"cc" h_(a b). $
  Taking the trace of this expression and using our result from part f), we get
  $ 0 = T^a zws_a = 2 pi lambda_"cc" underbrace(h^a zws_a, 2) = 4 pi lambda_"cc" wide => wide lambda_"cc" limits(=)^! 0. $

= Gravity in two dimensions is trivial

#task[
  + Using the symmetries of its indices, convince yourself that in two dimensions, the Riemann tensor has only one independent degree of freedom.
  + Verify that the ansatz
    $ R_(a b c d) = lambda (h_(a c) h_(b d) - h_(a d) h_(b c)) $ <eq:ansatz>
    with $h_(a b)$ the two-dimensional metric is consistent with the symmetries of the Riemann tensor. Show that $lambda = 1/2 cal(R)$ in terms of the Ricci scalar $cal(R)$.
  + Compute the Einstein tensor defined in terms of the Ricci tensor $R_(a b)$ as
    $ G_(a b) = R_(a b) - 1/2 h_(a b) cal(R) $ <eq:einstein>
    for a two-dimensional metric. Discuss the result.
  + Show that in two dimensions under the Weyl rescaling $h_(a b) -> e^(2 omega(tau, sigma)) h_(a b)$ the product $sqrt(-det(h)) cal(R)$ transforms as
    $ sqrt(-det(h)) cal(R) -> sqrt(-det(h')) cal(R)' = sqrt(-det(h)) [cal(R) - 2 nabla^2 omega]. $ <eq:ricci-weyl>
  + Argue from the above result that the 2-dimensional Einstein-Hilbert term is indeed conformally invariant for a closed string worldsheet.

    *Note:* By contrast, for an open string worldsheet $Sigma$ with boundary $partial Sigma$ only the combination
    $ chi = 1/(4 pi) integral_Sigma dif^2 xi sqrt(-h) cal(R) + 1/(2 pi) integral dif s cal(K) $ <eq:euler-char>
    is conformally invariant. Here the extrinsic curvature $cal(K)$ is defined as
    $ cal(K) = plus.minus t^a n_b nabla_a t^b, $
    with $t^a$ a unit vector tangent to the boundary and $n^a$ an outward unit vector orthogonal to $t^a$. The upper/lower sign refer to timelike/spacelike boundaries. Indeed this object is the *Euler characteristic of a worldsheet with boundary*.
  + Use the result from part d) to show that _locally_ every metric of signature $(-1, 1)$ can be brought into the form $"diag"(eta) = (-1, 1)$ by Weyl rescalings and diffeomorphism invariance.
]

+ The components of the Riemann tensor can be conveniently calculated with the formula
  $ riem(a, b c d) = partial_c chr(a, b d) - partial_d chr(a, b c) + chr(e, b d) chr(a, c e) - chr(e, b c) chr(a, d e). $
  As discussed in exercise 1 on assignment 1, in $d$ dimensions the Riemann tensor has $n = d^4$ components which makes for a total of $n = 16$ if $d = 2$. To see how many of those components are actually independent degrees of freedom we need to consider the Riemann tensor's plentiful symmetries.
  #note[
    Not all of them are present in the above mixture of co- and contravariant indices, however. For a tensor, say the energy momentum tensor $T_(a b)$, to be e.g. symmetric under the exchange of two indices, $T_(a b) = T_(b a)$, both indices obviously need to be of the same variance. $T_a^(#h(0.1em) b) = T_b^(#h(0.1em) a)$ is strictly impossible since a tensor covariant in $a$ can never be equal to one contravariant in $a$. They have completely different transformation properties. \
    So in order to make all symmetries manifest, we lower the first index by contraction with the metric $h_(a b)$:
    $ R_(a b c d) = h_(a e) riem(e, b c d) = h_(a e) (partial_c chr(e, b d) - partial_d chr(e, b c) + chr(f, b d) chr(e, c f) - chr(f, b c) chr(e, d f)). $
    The Riemann tensor is a field, i.e. it depends on the point in space we are looking at. To simplify the derivation of its symmetry properties, we go about inspecting it from a locally inertial frame (LIF). An LIF has the special property that at its origin all metric derivatives vanish. It is common knowledge that, for a smooth metric, we can define a coordinate system at any given point so that locally the metric expressed in this coordinate system is the flat spacetime metric $eta_(a b)$. What is less well known is that this operation does not exhaust the transformational degrees of freedom of the metric. It can be shown with some work that the remaining freedom suffices to impose all derivatives of the metric to vanish at a particular point in space. \
    From the definition
    $ chr(a, b c) = 1/2 h^(a d) (partial_c h_(b d) + partial_b h_(c d) - partial_d h_(b c)), $
    it is clear that vanishing metric derivatives result in all of the Christoffel symbols being zero as well. However, _second_ derivatives of the metric need not vanish at the origin of an LIF. Hence, derivatives of the Christoffel symbols are also unequal to zero in general. Bearing that in mind, the Riemann tensor at the origin of an LIF takes the form
    $ R_(a b c d) = h_(a e) (partial_c chr(e, b d) - partial_d chr(e, b c)). $ <eq:riemann-lif>
    Explicit calculation of the derivative of the Christoffel symbol yields
    $ partial_a chr(b, c d) = 1/2 underbrace(partial_a h^(b e), 0) (partial_d h_(c e) + partial_c h_(d e) - partial_e h_(c d)) + 1/2 h^(b e) (partial_a partial_d h_(c e) + partial_a partial_c h_(d e) - partial_a partial_e h_(c d)). $
    By contraction with the metric $h_(b f)$ and using $h_(b f) h^(b e) = delta^e_(#h(0.1em) f)$, we get
    $
      h_(f b) partial_a chr(b, c d) & = 1/2 h_(b f) h^(b e) (partial_a partial_d h_(c e) + partial_a partial_c h_(d e) - partial_a partial_e h_(c d)) \
      & = 1/2 (partial_a partial_d h_(c f) + partial_a partial_c h_(d f) - partial_a partial_f h_(c d)).
    $
    Adjusting index naming, we can insert this expression for both terms on the r.h.s. of eq. @eq:riemann-lif to obtain
    $ R_(a b c d) = 1/2 [partial_c partial_d h_(b a) + partial_c partial_b h_(d a) - partial_c partial_a h_(b d) - (partial_d partial_c h_(b a) + partial_d partial_b h_(c a) - partial_d partial_a h_(b c))]. $
    Since partial derivatives commute, the first and fourth term cancel, and we are left with
    $
      R_(a b c d) & = 1/2 [partial_c partial_b h_(d a) - partial_c partial_a h_(b d) - partial_d partial_b h_(c a) + partial_d partial_a h_(b c)] \
                  & = 1/2 [partial_a partial_d h_(b c) - partial_b partial_d h_(a c) + partial_b partial_c h_(a d) - partial_a partial_c h_(b d)],
    $ <eq:riemann-symmetric>
    where in the second step all we did was some housekeeping. Remember that this equation is valid only at the origin of an LIF. You might then rightfully ask what good it is. The answer to that is simple: The origin of a LIF defines one particular point in spacetime. Since all symmetries were expressed i.t.o. tensor equations, they must be true at that point, regardless of which coordinate system we're using. Further, one can show that we could define an LIF with its origin at any point in spacetime, provided that point is locally flat (i.e. there is no singularity at that point). So the symmetries are in fact true for all non-singular points in spacetime#footnote[It might be confusing that we say that the symmetries in eq. @eq:riemann-symmetric are universally valid at all points in all coordinate systems just because they are tensor equations, while at the same time maintain that eq. @eq:riemann-symmetric is valid only at the origin of an LIF. The difference is that eq. @eq:riemann-symmetric is written explicitly in terms of a particular metric $h_(a b)$ which is defined precisely so that all its first derivatives are zero at the origin of the LIF. If we wanted an equation for $R_(a b c d)$ at some other point in spacetime, we could write it in the same form, but we'd need to find a different metric $h_(a b)'$ whose first derivatives are zero at this other point. If we wanted to use the original metric, then since this other point is not at the origin of the original LIF, the Christoffel symbols would not be zero at this point, and the expression for $R_(a b c d)$ would be much more complicated.].
  ]
  Taking a closer look at the index structure in eq. @eq:riemann-symmetric, we see that the Riemann tensor is antisymmetric both under exchange of the first and last two indices, i.e.
  $ R_(a b c d) = -R_(b a c d), #h(3em) R_(a b c d) = -R_(a b d c). $
  That means of the original $d^2 = 4$ degrees of freedom that the first and last two indices contain separately, antisymmetry leaves us with only $d/2 (d - 1) = 1$ independent degree of freedom. Consequently, the Riemann tensor as a whole also only has $1 dot 1 = 1$ degree of freedom if $d = 2$.
+ The Riemann tensor, irrespective of the dimensionality of space, has four symmetries, two of which we just exploited, i.e. antisymmetry under exchange of the first and last two indices. The other two are symmetry under exchange of both pairs as a whole and the Bianchi identity. We will check each of these in turn for the ansatz @eq:ansatz:
  #set enum(numbering: "1.")
  + $R_(a b c d) = -R_(b a c d)$?
    $ R_(a b c d) = lambda (h_(a c) h_(b d) - h_(a d) h_(b c)) = -lambda (h_(b c) h_(a d) - h_(b d) h_(a c)) = -R_(b a c d). quad checkmark $
  + $R_(a b c d) = -R_(a b d c)$?
    $ R_(a b c d) = lambda (h_(a c) h_(b d) - h_(a d) h_(b c)) = -lambda (h_(a d) h_(b c) - h_(a c) h_(b d)) = -R_(a b d c). quad checkmark $
  + $R_(a b c d) = R_(c d a b)$? This follows directly from symmetry of the metric:
    $ R_(a b c d) = lambda (h_(a c) h_(b d) - h_(a d) h_(b c)) = lambda (h_(c a) h_(d b) - h_(d a) h_(c b)) = R_(c d a b). quad checkmark $
  + Bianchi identity: $R_(a [b c d]) = 0$?
    $
      R_(a [b c d]) & = R_(a b c d) + R_(a c d b) + R_(a d b c) \
      & = lambda (h_(a c) h_(b d) - underline(h_(a d) h_(b c)) + u2(h_(a b) h_(d c)) - h_(a c) h_(d b) + underline(h_(a d) h_(c b)) - u2(h_(a b) h_(c d))) = 0. quad checkmark
    $

  Contraction of all indices yields
  $ cal(R) = R^(a b) zws_(a b) = lambda (underbrace(h^a zws_a, 2) underbrace(h^b zws_b, 2) - underbrace(h^a zws_b h^b zws_a, h^a zws_a)) = lambda (4 - 2) = 2 lambda wide => wide lambda = 1/2 cal(R). $
+ The components of the Ricci tensor can be computed from those of the Riemann tensor by contracting the first and third index,
  $ R_(a b) = riem(c, a c b) = lambda (h^c zws_c h_(a b) - h^c zws_b h_(a c)) = lambda (2 h_(a b) - h_(a b)) = lambda h_(a b). $
  Insertion into eq. @eq:einstein gives a vanishing Einstein tensor,
  $ G_(a b) = R_(a b) - 1/2 h_(a b) cal(R) = lambda h_(a b) - 1/2 h_(a b) 2 lambda = 0. $
  This is the reason why gravity in two dimensions is said to be trivial: The Einstein field equations $G_(a b) = 8 pi G T_(a b)$ reduce to $T_(a b) = 0$.
+ Deriving the transformation law @eq:ricci-weyl is tedious work. One has to go through the usual procedure in general relativity to investigate the effect of a change to the metric on the curvature:
  #set enum(numbering: "1.")
  + Identify the new metric.
  + Calculate the corresponding Christoffel symbols.
  + Derive the new Riemann tensor.
  + Finally, contract fully to get the transformed Ricci scalar.

  Step 1 is a given as the new metric $h_(a b)' (tau, sigma) = e^(2 omega(tau, sigma)) h_(a b) (tau, sigma)$ was already written in the exercise. Step 2 requires actual work:
  $
    Gamma'^a zws_(b c) & = 1/2 h'^(a d) (partial_c h_(b d)' + partial_b h_(c d)' - partial_d h_(b c)') = 1/2 e^(-2 omega) h^(a d) (partial_c (e^(2 omega) h_(b d)) + partial_b (e^(2 omega) h_(c d)) - partial_d (e^(2 omega) h_(b c))) \
    & = 1/2 e^(-2 omega) h^(a d) e^(2 omega) (partial_c h_(b d) + partial_b h_(c d) - partial_d h_(b c) + h_(b d) partial_c 2 omega + h_(c d) partial_b 2 omega - h_(b c) partial_d 2 omega) \
    & = 1/2 h^(a d) (partial_c h_(b d) + partial_b h_(c d) - partial_d h_(b c)) + h^(a d) (h_(b d) partial_c omega + h_(c d) partial_b omega - h_(b c) partial_d omega) \
    & = chr(a, b c) + (delta_b^(#h(0.1em) a) partial_c + delta_c^(#h(0.1em) a) partial_b - h_(b c) partial^a) omega equiv chr(a, b c) + C^a zws_(b c),
  $
  where for the purpose of preserving readability in the sequel, we defined the object
  $ C^a zws_(b c) = (delta_b^(#h(0.1em) a) partial_c + delta_c^(#h(0.1em) a) partial_b - h_(b c) partial^a) omega. $
  Step 3, obtaining the new Riemann tensor, requires the bulk of the calculations,
  $
    R'^a zws_(b c d) & = partial_c Gamma'^a zws_(b d) - partial_d Gamma'^a zws_(b c) + Gamma'^e zws_(b d) Gamma'^a zws_(c e) - Gamma'^e zws_(b c) Gamma'^a zws_(d e) \
    & = partial_c (chr(a, b d) + C^a zws_(b d)) - partial_d (chr(a, b c) + C^a zws_(b c)) \
    & quad + (chr(e, b d) + C^e zws_(b d)) (chr(a, c e) + C^a zws_(c e)) - (chr(e, b c) + C^e zws_(b c)) (chr(a, d e) + C^a zws_(d e)) \
    & = riem(a, b c d) + partial_c C^a zws_(b d) - partial_d C^a zws_(b c) \
    & quad + chr(e, b d) C^a zws_(c e) + chr(a, c e) C^e zws_(b d) + C^e zws_(b d) C^a zws_(c e) - chr(e, b c) C^a zws_(d e) - chr(a, d e) C^e zws_(b c) - C^e zws_(b c) C^a zws_(d e) \
    & equiv riem(a, b c d) + U^a zws_(b c d),
  $ <eq:riemann-weyl>
  or rather it would, if we didn't cheat by again defining a new object $U^a zws_(b c d)$ to contain the entire change of the Riemann tensor under Weyl transformations. With eq. @eq:riemann-weyl, we can move on to step 4 and derive the Weyl transformed Ricci scalar by contracting all indices, i.e.
  $ cal(R)' = R'^(a b) zws_(a b) = h'^(b c) R'^a zws_(c a b) = e^(-2 omega) h^(b c) (riem(a, c a b) + U^a zws_(c a b)) = e^(-2 omega) (cal(R) + h^(b c) U^a zws_(c a b)). $ <eq:ricci-scalar-weyl>
  Equation @eq:ricci-scalar-weyl shows that the Ricci scalar is not only rescaled but also receives an offset under Weyl transformations. All that remains is to calculate this offset which is where the little cheat we took above will cost us since we need to simplify
  $
    h^(b c) U^a zws_(c a b) = h^(b c) ( & partial_a C^a zws_(c b) - partial_b C^a zws_(c a) + chr(e, c b) C^a zws_(a e) + chr(a, a e) C^e zws_(c b) \
    & + C^e zws_(c b) C^a zws_(a e) - chr(e, c a) C^a zws_(b e) - chr(a, b e) C^e zws_(c a) - C^e zws_(c a) C^a zws_(b e)).
  $ <eq:offset>
  Again in the interest of avoiding long blocks of calculation, we handle each of the above terms separately. Our work will be greatly accelerated by noting that $C^a zws_(b c)$ is symmetric under exchange of the two lower indices#footnote[As it has to be in order for the Weyl transformed Christoffel symbols to uphold this symmetry.] and contraction of the upper index with either yields
  $ C^a zws_(a b) = C^a zws_(b a) = (delta_a^(#h(0.1em) a) partial_b + delta_b^(#h(0.1em) a) partial_a - h_(a b) partial^a) omega = (2 partial_b + partial_b - partial_b) omega = 2 partial_b omega. $ <eq:c-trace>
  Another useful identity is $C^a zws_(b c)$ contracted with the metric $h^(b c)$ as this simply gives zero,
  $ h^(b c) C^a zws_(b c) = h^(b c) (delta_b^(#h(0.1em) a) partial_c + delta_c^(#h(0.1em) a) partial_b - h_(b c) partial^a) omega = (partial^a + partial^a - 2 partial^a) omega = 0. $ <eq:c-contracted>
  With these shortcuts, we proceed:
  $
    h^(b c) partial_a C^a zws_(c b) & = h^(b c) partial_a (delta_b^(#h(0.1em) a) partial_c + delta_c^(#h(0.1em) a) partial_b - h_(b c) h^(a d) partial_d) omega = 2 h^(b c) partial_b partial_c omega - h^(b c) partial_a (h_(b c) h^(a d) partial_d omega) = 2 h^(b c) chr(e, b c) partial_e omega, \
    h^(b c) partial_b C^a zws_(c a) & eqby("eq:c-trace") 2 h^(b c) partial_b partial_c omega, \
    h^(b c) chr(e, c b) C^a zws_(a e) & eqby("eq:c-trace") 2 h^(b c) chr(e, c b) partial_e omega, \
    h^(b c) chr(a, a e) C^e zws_(c b) & eqby("eq:c-contracted") 0, \
    h^(b c) C^e zws_(c b) C^a zws_(a e) & eqby("eq:c-contracted") 0, \
    h^(b c) chr(e, c a) C^a zws_(b e) & = h^(b c) chr(e, c a) (delta_b^(#h(0.1em) a) partial_e + delta_e^(#h(0.1em) a) partial_b - h_(b e) partial^a) omega = (h^(a c) chr(e, c a) partial_e + h^(b c) chr(a, c a) partial_b - delta_e^(#h(0.1em) c) chr(e, c a) partial^a) omega \
    & = (h^(a c) chr(e, c a) partial_e + underbrace(chr(a, c a) partial^c - chr(c, c a) partial^a, 0)) omega = h^(a c) chr(e, c a) partial_e omega, \
    h^(b c) chr(a, b e) C^e zws_(c a) & = h^(a c) chr(e, c a) partial_e omega, \
    h^(b c) C^e zws_(c a) C^a zws_(b e) & = h^(b c) (delta_c^(#h(0.1em) e) partial_a + delta_a^(#h(0.1em) e) partial_c - h_(c a) partial^e) omega (delta_b^(#h(0.1em) a) partial_e + delta_e^(#h(0.1em) a) partial_b - h_(b e) partial^a) omega \
    & = h^(b c) (partial_b omega partial_c omega + partial_b omega partial_c omega - h_(b c) partial_a omega partial^a omega + partial_b omega partial_c omega + 2 partial_b omega partial_c omega - partial_c omega partial_b omega \
    & #h(3em) - h_(c b) partial^e omega partial_e omega - partial_c omega partial_b omega + partial_b omega partial_c omega) \
    & = 4 partial_b omega partial^b omega - 2 partial_a omega partial^a omega - 2 partial^e omega partial_e omega = 0.
  $ <eq:offset-terms>
  In the first line, the second derivatives cancel, but the derivatives of the metric hidden in $h_(b c) partial^a = h_(b c) h^(a d) partial_d$ survive. With $h^(b c) partial_a h_(b c) = 2 chr(e, e a)$ and $partial_a h^(a d) = -chr(a, a b) h^(b d) - chr(d, a b) h^(a b)$, they combine into the given result.
  Reinserting eq. @eq:offset-terms back into eq. @eq:offset, we get an offset of
  $
    h^(b c) U^a zws_(c a b) & = 2 h^(b c) chr(e, b c) partial_e omega - 2 h^(b c) partial_b partial_c omega + 2 h^(b c) chr(e, c b) partial_e omega - 2 h^(a c) chr(e, c a) partial_e omega \
    & = -2 h^(b c) (partial_b partial_c omega - chr(e, c b) partial_e omega) = -2 h^(b c) nabla_b partial_c omega = -2 h^(b c) nabla_b nabla_c omega = -2 nabla^2 omega,
  $
  where in the last step $partial_c omega = nabla_c omega$ because $omega$ is just a scalar function for which partial and covariant derivative are identical.

  Plugging our hard-earned result into eq. @eq:ricci-scalar-weyl, we get exactly the transformation behavior as given in the exercise, i.e.
  $
    sqrt(-det(h)) cal(R) -> sqrt(-det(h')) cal(R)' & = e^(2 omega) sqrt(-det(h)) e^(-2 omega) [cal(R) - 2 nabla^2 omega] \
    & = sqrt(-det(h)) [cal(R) - 2 nabla^2 omega].
  $
+ The Einstein-Hilbert term reads
  $ S_"EH" [bh] = lambda_"EH"/(4 pi) integral_Sigma dif tau dif sigma sqrt(-det(bh)) cal(R). $
  Hence under Weyl transformations, the action changes as
  $ S_"EH" [bh] -> S_"EH" [bh]' = lambda_"EH"/(4 pi) integral_Sigma dif tau dif sigma sqrt(-det(bh)) [cal(R) - 2 nabla^2 omega] = S_"EH" [bh] + Delta S_"EH" [bh]. $
  Since the Ricci scalar changes only by a total derivative, it is easy to show that $Delta S_"EH" [bh]$ vanishes for a closed string:
  $
    Delta S_"EH" [bh] & = -lambda_"EH"/(2 pi) integral_Sigma dif tau dif sigma sqrt(-det(bh)) nabla^2 omega = -lambda_"EH"/(2 pi) integral_Sigma dif *_2 dif omega \
    & = -lambda_"EH"/(2 pi) integral_(partial Sigma) *_2 dif omega = 0,
  $
  where $*_2$ is the Hodge star operator known from differential geometry, and we used that the worldsheet of a closed string has no boundary, i.e. $partial Sigma = 0$.
  #note[For an open string, $Delta S_"EH" [bh]$ also vanishes but only after incorporating the extrinsic curvature term as mentioned around eq. @eq:euler-char into the full action.]
+ By solving
  $ cal(R)' (tau, sigma) = cal(R)(tau, sigma) - 2 nabla^2 omega(tau, sigma) = 0, $
  for $omega(tau, sigma)$, we can find a special $omega_0 (tau, sigma)$ for every point $(tau, sigma)$ on the worldsheet, so that locally, $cal(R)(tau, sigma)$ and $-2 nabla^2 omega(tau, sigma)$ exactly cancel and we have $cal(R)' (tau, sigma) = 0$.

  In part a), we demonstrated that the Riemann tensor in two dimensions only has one degree of freedom. In part b), we showed that this degree of freedom is directly proportional to the Ricci scalar. Bearing that in mind, it is clear that $cal(R)' (tau, sigma) = 0$ implies
  $ R'^a zws_(b c d) (tau, sigma) = 0 wide "at the point" (tau, sigma) thick forall a, b, c, d in {tau, sigma}. $
  In words: For a two-dimensional space, we can always use a spacetime dependent rescaling $omega(tau, sigma)$ of distances to locally remove any curvature and obtain flat space.

  Using the remaining diffeomorphism invariance, i.e. invariance of the action under coordinate transformations, we can reshape the metric. Note that diffeomorphisms do not enable us to change the metric's signature. The eigenvalues of a matrix are a fundamental property that are shared among all representations of a matrix connected via coordinate transformations. However, if we already start from a Lorentzian metric $bh$ with signature $(-1, 1)$, we can always find a coordinate transformation $bP$,
  $ x^a -> x'^a = P^a zws_b x^b, #h(3em) x in {tau, sigma}. $
  whose rows, or equivalently columns, are given by the eigenvectors of the metric $bh$. This matrix $bP$ then fulfills the famous identity
  $ bh = bP bh_D bP^(-1), $
  where $bh_D$ is the metric in diagonal shape, i.e.
  $ bh_D prop mat(-1, 0; 0, 1). $
