#import "/notes.typ": note, task, vb, eps, ev, eqby
#import "/string-theory/sheet.typ": cR, zb, oint, u1, u2, arrow-mark, lbl, sheet
#import "/string-theory/contours.typ": contour-deformation
#import "@preview/cetz:0.5.2": canvas, draw

#show: sheet.with(7, [November 24th, 2015], [December 2nd, 2015])

#let (bA, bC, bD, bE, bF) = ($vb(A)$, $vb(C)$, $vb(D)$, $vb(E)$, $vb(F)$)
#let hb = $macron(h)$
#let SL = $S L(2, CC)$

#let dashed = (dash: "dashed", thickness: 0.5pt)

// The map from the cylinder to the plane takes constant-time slices tau_1 < tau_2 to concentric
// circles of growing radius.
#let cylinder-to-plane = canvas(length: 0.8cm, {
  import draw: *
  set-style(stroke: 0.6pt)
  let (x0, x1, ry, rx) = (0, 4, 1.4, 0.45)
  circle((x0, 0), radius: (rx, ry))
  arc((x1, ry), start: 90deg, stop: -90deg, radius: (rx, ry))
  line((x0, ry), (x1, ry))
  line((x0, -ry), (x1, -ry))
  for (x, name) in ((1.4, $tau_1$), (2.5, $tau_2$)) {
    arc((x, ry), start: 90deg, stop: -90deg, radius: (rx, ry), stroke: dashed)
    lbl((x - 0.2, 0), name, anchor: "east")
  }
  arc((-0.75, 1.3), start: 130deg, stop: 230deg, radius: (0.5, 1.7), mark: arrow-mark)
  lbl((-1.4, 0), $sigma$)
  line((0.8, -2), (3.2, -2), mark: arrow-mark)
  lbl((2, -2.5), $tau$)
  line((5, 0), (6.2, 0), mark: arrow-mark, stroke: 0.9pt)
  let c = (9, 0)
  circle(c, radius: 0.06, fill: black)
  circle(c, radius: 0.9, stroke: dashed)
  circle(c, radius: 1.9, stroke: dashed)
  lbl((9.6, 0.9), $tau_1$)
  lbl((10.4, 1.8), $tau_2$)
  arc((7.3, 0), start: 180deg, stop: 270deg, radius: 1.7, mark: arrow-mark)
  lbl((7.1, -0.9), $sigma$)
})

= Primary fields and radial quantization

#task[
  A primary field $phi(z, zb)$ is a tensor field under conformal transformations $z -> z'$, $zb -> zb'$ in the sense that
  $ phi(z, zb) -> phi'(z', zb') = ((partial z')/(partial z))^(-h) ((partial zb')/(partial zb))^(-hb) phi(z, zb), $ <eq:primary>
  where $z$, $zb$ denote arbitrary holomorphic functions.
  + How does a primary field with conformal weights $h$, $hb$ transform under dilations $z -> e^lambda z$ and rotations $z -> e^(i theta) z$ with $lambda, theta in RR$? Give a physical interpretation for $h + hb$ and $h - hb$.
  + Consider the infinitesimal conformal transformation
    $ z'(z) = z + zeta(z), #h(3em) zb'(zb) = zb + macron(zeta)(zb). $
    Show that the infinitesimal transformation of a primary field is given by
    $ delta_(zeta, macron(zeta)) phi(z, zb) = [h partial_z zeta + hb partial_zb macron(zeta) + zeta partial_z + macron(zeta) partial_zb] phi(z, zb). $
  + On the cylinder with coordinates $(tau, sigma)$ we defined
    $ xi^plus.minus = tau plus.minus sigma = -i(tau' plus.minus i sigma), #h(3em) tau = -i tau', $
    and $tau'$ is the time in Euclidean signature (after Wick rotation). After relabelling $tau' -> tau$ we have
    $ xi^+ = -i macron(omega), #h(3em) xi^- = -i omega, #h(3em) omega = tau - i sigma. $
    Argue that the conformal map from the cylinder to the Riemann sphere, defined by
    $ omega -> z(omega) = e^((2 pi)/l omega), $
    maps left-/right-moving fields to holomorphic/antiholomorphic fields and that for a primary field $Phi = Phi_L (xi^-) + Phi_R (xi^+)$ a mode expansion
    $ Phi_L (xi^-) = ((2 pi)/l)^h sum_n phi_n e^(i (2 pi)/l n xi^-), #h(3em) Phi_R (xi^+) = ((2 pi)/l)^hb sum_n macron(phi)_n e^(i (2 pi)/l n xi^+), $
    translates into $Phi(z, zb) = Phi(z) + macron(Phi)(zb)$,
    $ Phi(z) = sum_n phi_n z^(-n-h), #h(3em) macron(Phi)(zb) = sum_n macron(phi)_n zb^(-n-hb). $
  + Argue that a time-ordered product of fields on the cylinder maps to a radially ordered product
    $ cR[Phi_1 (z_1) Phi_2 (z_2)] = cases(Phi_1 (z_1) Phi_2 (z_2) quad & "for" |z_1| > |z_2|\,, Phi_2 (z_2) Phi_1 (z_1) & "for" |z_2| > |z_1|.) $
]

+ Under dilations (rescalings) $z -> z' = e^lambda z$, $lambda in RR$, a primary field $phi(z, zb)$ with conformal weights $h$, $hb$ transforms as
  $ phi(z, zb) -> phi'(z', zb') = ((partial z')/(partial z))^(-h) ((partial zb')/(partial zb))^(-hb) phi(z, zb) = e^(-h lambda) e^(-hb lambda) phi(z, zb) = e^(-(h + hb) lambda) phi(z, zb). $ <eq:dilation>
  Under rotations $z -> z' = e^(i theta) z$, $theta in RR$, $phi(z, zb)$ becomes
  $ phi(z, zb) -> phi'(z', zb') = e^(-i h theta) e^(i hb theta) phi(z, zb) = e^(-i (h - hb) theta) phi(z, zb). $ <eq:rotation>
  From eqs. @eq:dilation and @eq:rotation, we infer that the sum of conformal weights $h + hb = Delta$ gives the *scaling dimension* of a primary field $phi(z, zb)$, whereas the difference $h - hb = s$ is the field's (conformal) *spin*.
+ Equation @eq:primary can equivalently be written as
  $ phi(z, zb) -> phi'(z, zb) = ((partial z')/(partial z))^(-h) ((partial zb')/(partial zb))^(-hb) phi(z', zb'). $ <eq:primary-inverse>
  For the conformal transformations $z'(z) = z + zeta(z)$, $zb'(zb) = zb + macron(zeta)(zb)$, we can expand each term in eq. @eq:primary-inverse to first order in the infinitesimal (anti-)chiral fields $zeta(z)$, $macron(zeta)(zb)$ to get
  $
    ((partial z')/(partial z))^(-h) & = (1 + (partial zeta(z))/(partial z))^(-h) = 1 + h partial_z zeta(z) + cal(O)(zeta^2), \
    ((partial zb')/(partial zb))^(-hb) & = (1 + (partial macron(zeta)(zb))/(partial zb))^(-hb) = 1 + hb partial_zb macron(zeta)(zb) + cal(O)(macron(zeta)^2), \
    phi(z', zb') & = phi(z, zb) + zeta(z) partial_z phi(z, zb) + macron(zeta)(zb) partial_zb phi(z, zb) + cal(O)(zeta^2, macron(zeta)^2).
  $
  Dropping all terms beyond linear order gives the infinitesimal transformation
  $
    delta_(zeta, macron(zeta)) phi(z, zb) & equiv phi'(z, zb) - phi(z, zb) \
    & = (1 + h partial_z zeta(z)) (1 + hb partial_zb macron(zeta)(zb)) (1 + zeta(z) partial_z + macron(zeta)(zb) partial_zb) phi(z, zb) - phi(z, zb) \
    & = [1 + h partial_z zeta(z) + hb partial_zb macron(zeta)(zb) + zeta(z) partial_z + macron(zeta)(zb) partial_zb] phi(z, zb) - phi(z, zb) \
    & = [h partial_z zeta(z) + hb partial_zb macron(zeta)(zb) + zeta(z) partial_z + macron(zeta)(zb) partial_zb] phi(z, zb).
  $
+ A Wick rotation on the cylinder with coordinates $(tau, sigma) in RR^2$ sends
  $ xi^plus.minus = tau plus.minus sigma limits(-->)^"W.R." -i(tau plus.minus i sigma) equiv cases(-i macron(omega) = xi^+\,, -i omega = xi^-\,) $
  where now $tau in i RR$ and $omega$, $macron(omega)$ are coordinates on the cylinder. \
  After Wick rotating, the conformal map
  $ i xi^- = omega -> z(omega) = e^((2 pi)/l omega), #h(3em) i xi^+ = macron(omega) -> zb(macron(omega)) = e^((2 pi)/l macron(omega)). $ <eq:conformal-map>
  from the cylinder to the Riemann sphere respectively the complex plane transforms left-movers into holomorphic fields $Phi_L (xi^-) -> Phi(z(omega))$ and right-movers into antiholomorphic ones $Phi_R (xi^+) -> Phi(zb(macron(omega)))$.

  This can be illustrated for the case of a primary field $Phi(xi^+, xi^-) = Phi_L (xi^-) + Phi_R (xi^+)$ with conformal weights $(h, hb)$, where the left- and right-moving components are given by
  $ Phi_L (xi^-) = ((2 pi)/l)^h sum_n phi_n e^(i (2 pi)/l n xi^-), #h(3em) Phi_R (xi^+) = ((2 pi)/l)^hb sum_n macron(phi)_n e^(i (2 pi)/l n xi^+). $
  Under @eq:conformal-map, these transform into
  $
    Phi_L (xi^-) -> Phi_L (z) & = ((partial z)/(partial omega))^(-h) Phi_L (xi^-) = ((2 pi)/l e^((2 pi)/l omega))^(-h) ((2 pi)/l)^h sum_n phi_n e^((2 pi)/l n omega) \
    & = sum_n phi_n (e^((2 pi)/l omega))^(n-h) = sum_n phi_n z^(n-h) = sum_n phi_(-n) z^(-n-h), \
    Phi_R (xi^+) -> Phi_R (zb) & = ((partial zb)/(partial macron(omega)))^(-hb) Phi_R (xi^+) = ((2 pi)/l e^((2 pi)/l macron(omega)))^(-hb) ((2 pi)/l)^hb sum_n macron(phi)_n e^((2 pi)/l n macron(omega)) \
    & = sum_n macron(phi)_n (e^((2 pi)/l macron(omega)))^(n-hb) = sum_n macron(phi)_n zb^(n-hb) = sum_n macron(phi)_(-n) zb^(-n-hb).
  $
  Since $i (2 pi)/l n xi^- = (2 pi)/l n omega$, this reproduces the stated expansion up to relabelling the modes $phi_n -> phi_(-n)$ (equivalently, it matches exactly if the cylinder modes are defined with $e^(-i (2 pi)/l n xi^minus.plus)$ instead).
+ To see that time ordering on the cylinder corresponds to radial ordering on the complex plane, we choose any two points $omega_1 = tau_1 - i sigma_1$, $omega_2 = tau_2 - i sigma_2$ such that $tau_1 <= tau_2$, i.e. in a time-ordered operator product containing $tau_1$ and $tau_2$, the operator evaluated at $tau_1$ would act first. For the corresponding points $z_1$, $z_2$ on the plane, we have the relation
  $
    tau_1 <= tau_2 wide <==> wide |z_1| & = |e^((2 pi)/l omega_1)| = |e^((2 pi)/l (tau_1 - i sigma_1))| = e^((2 pi)/l tau_1) \
    & <= e^((2 pi)/l tau_2) = |e^((2 pi)/l (tau_2 - i sigma_2))| = |z_2|.
  $
  Thus in a radially ordered product, an operator evaluated on the plane at $z_1$ would also act first.

  The following graphic visualizes how different times on the cylinder correspond to circles of different radii on the plane.
  #align(center, cylinder-to-plane)

= The OPE of the energy momentum tensor

#task[
  In the complex plane, the Virasoro generators $L_n$, $n in ZZ$ are given by
  $ L_n = oint(0) (dif z)/(2 pi i) z^(n+1) T(z). $
  + Show that
    $ [L_m, L_n] = oint(0) (dif w)/(2 pi i) oint(w) (dif z)/(2 pi i) z^(m+1) w^(n+1) cR[T(z) T(w)], $ <eq:commutator-contour>
    where $C_0$ denotes a contour about $z = 0$ and $C_w$ is a contour about $z = w$. As usual the product $cR[T(z) T(w)]$ is meant to be the radially ordered product.

    *Hint:* Write the commutator as a difference of two double contour integrals and use a contour deformation of the $dif z$ integration for fixed $w$.
  + Use eq. @eq:commutator-contour and the (radially ordered) operator product
    $ cR[T(z) T(w)] = (c\/2)/(z - w)^4 + (2 T(w))/(z - w)^2 + (partial_w T(w))/(z - w) + underbrace(cal(O)[(z - w)^0], "finite terms"), $ <eq:tt-ope>
    as well as Cauchy's integral formula,
    $ oint(w) (dif z')/(2 pi i) f(z')/(z' - z)^n = 1/(n - 1)! f^((n-1)) (z), $ <eq:cauchy>
    to rederive the quantum Virasoro algebra
    $ [L_m, L_n] = (m - n) L_(m+n) + c/12 m(m^2 - 1) delta_(m,-n). $
  + The Schwarzian derivative is defined as
    $ S(zb, z) = (partial^3 zb)/(partial^3 z) ((partial zb)/(partial z))^(-1) - 3/2 ((partial^2 zb)/(partial^2 z))^2 ((partial zb)/(partial z))^(-2). $
    Show that the transformation
    $ T(z) -> tilde(T)(zb) = ((partial zb)/(partial z))^(-2) [T(z) - c/12 S(zb, z)], $ <eq:schwarzian-trafo>
    gives at the infinitesimal level for $zb = z + eps(z)$,
    $ delta T(z) = eps(z) partial T(z) + 2 [partial_z eps(z)] T(z) + c/12 partial_z^3 eps(z). $
  + Apply this to the map from the cylinder to the plane, given by
    $ tau - i sigma equiv omega -> z(omega) = e^((2 pi)/l omega), $
    to show that
    $ T_"cyl" (omega) = ((2 pi)/l)^2 (z^2 T_"pln" (z) - c/24). $
    Which are the various physical interpretations for $c$?
]

+ Expanding the commutator of Virasoro generators gives
  $
    [L_m, L_n] & = oint(0) (dif z)/(2 pi i) z^(m+1) T(z) oint(0) (dif w)/(2 pi i) w^(n+1) T(w) - oint(0) (dif w)/(2 pi i) w^(n+1) T(w) oint(0) (dif z)/(2 pi i) z^(m+1) T(z) \
    & = oint(0) (dif w)/(2 pi i) (oint(0) (dif z)/(2 pi i) z^(m+1) w^(n+1) T(z) T(w) - oint(0) (dif z)/(2 pi i) z^(m+1) w^(n+1) T(w) T(z)).
  $ <eq:commutator-expanded>
  We use the following contour deformation for the two integrals in parenthesis so that _after_ the deformation, we have $|w| <= |z| thick forall z$ in the first integral and $|w| >= |z| thick forall z$ in the second.
  #align(center, contour-deformation)
  Then eq. @eq:commutator-expanded simplifies to
  $ [L_m, L_n] = oint(0) (dif w)/(2 pi i) oint(w) (dif z)/(2 pi i) z^(m+1) w^(n+1) cR[T(z) T(w)]. $ <eq:commutator-result>
+ To rederive#footnote[See exercise 1 on assignment 4 for the first (painstakingly long) derivation.] the quantum Virasoro algebra, we insert eq. @eq:tt-ope into eq. @eq:commutator-result to get
  $ [L_m, L_n] = oint(0) (dif w)/(2 pi i) oint(w) (dif z)/(2 pi i) z^(m+1) w^(n+1) [(c\/2)/(z - w)^4 + (2 T(w))/(z - w)^2 + (partial_w T(w))/(z - w)] $ <eq:inserted>
  We can perform the $z$-integration using Cauchy's integral formula
  $ oint(w) (dif z')/(2 pi i) f(z')/(z' - z)^n = 1/(n - 1)! f^((n-1)) (z). $
  The three terms in brackets thus become
  $
    oint(w) (dif z)/(2 pi i) (c/2 z^(m+1) w^(n+1))/(z - w)^4 & = c/(2 dot 3!) (m + 1) m (m - 1) w^(m-2) w^(n+1) = c/12 m(m^2 - 1) w^(m+n-1), \
    oint(w) (dif z)/(2 pi i) (2 T(w) z^(m+1) w^(n+1))/(z - w)^2 & = 2 T(w) (m + 1) w^m w^(n+1), \
    oint(w) (dif z)/(2 pi i) (partial_w T(w) z^(m+1) w^(n+1))/(z - w) & = partial_w T(w) w^(m+1) w^(n+1).
  $ <eq:three-terms>
  We reinsert eq. @eq:three-terms into eq. @eq:inserted and get
  $
    [L_m, L_n] & = oint(0) (dif w)/(2 pi i) [c/12 m(m^2 - 1) w^(m+n-1) + 2 T(w) (m + 1) w^m w^(n+1) + partial_w T(w) w^(m+1) w^(n+1)] \
    & = c/12 m(m^2 - 1) delta_(m,-n) + oint(0) (dif w)/(2 pi i) [underbrace(T(w) (m + 1) w^m w^(n+1), (m + 1) L_(m+n)) + partial_w [T(w) w^(m+1)] w^(n+1)]
  $
  Integration by parts in the last term where the boundary terms cancel since we integrate over the closed contour $C_0$ gives
  $
    oint(0) (dif w)/(2 pi i) partial_w [T(w) w^(m+1)] w^(n+1) & = -oint(0) (dif w)/(2 pi i) T(w) w^(m+1) partial_w w^(n+1) \
    & = -(n + 1) oint(0) (dif w)/(2 pi i) T(w) w^(m+1) w^n = -(n + 1) L_(m+n).
  $
  Thus we arrive at the renowned Virasoro algebra
  $
    [L_m, L_n] & = c/12 m(m^2 - 1) delta_(m,-n) + (m + 1) L_(m+n) - (n + 1) L_(m+n) \
               & = (m - n) L_(m+n) + c/12 m(m^2 - 1) delta_(m,-n).
  $
  #note[We have not _really_ rederived the Virasoro algebra here. Instead the operator product expansion @eq:tt-ope was really constructed in such a way as to reproduce this known commutator of two Virasoro generators.]
+ The change of chiral fields (in a two-dimensional quantum field theory) under infinitesimal conformal transformations can be calculated using the conformal Ward-Takahashi identity. For transformations of the form $zb = z + eps(z)$ it reads
  $ delta_eps cal(O)(z) = oint(z) (dif z')/(2 pi i) eps(z') cR[T(z') cal(O)(z)]. $
  Since we are interested in the transformational behavior of the energy-momentum tensor, we can again use the operator product expansion
  $ cR[T(z') T(z)] = (c\/2)/(z' - z)^4 + (2 T(z))/(z' - z)^2 + (partial_z T(z))/(z' - z) + underbrace(cal(O)[(z' - z)^0], "finite terms"), $
  as well as Cauchy's integral formula @eq:cauchy to compute
  $
    delta_eps T(z) & = oint(z) (dif z')/(2 pi i) eps(z') cR[T(z') T(z)] = oint(z) (dif z')/(2 pi i) eps(z') [(partial_z T(z))/(z' - z) + (2 T(z))/(z' - z)^2 + (c\/2)/(z' - z)^4] \
    & = eps(z) partial_z T(z) + 2 [partial_z eps(z)] T(z) + c/12 partial_z^3 eps(z),
  $ <eq:delta-t>
  which is indeed the transformation we were asked to derive. Equation @eq:delta-t confirms that $T(z)$ transforms as a tensor of weight $(2, 0)$ but only for special transformations that satisfy $partial_z^3 eps(z) = 0$ or for general transformations if $c = 0$.
  #note[Instead of doing all the expansions by hand in section 1, part b), we could equally well have used the Ward-Takahashi identity there as well to calculate the change of primary fields under conformal transformations.]
+ The Schwarzian derivative of the map $omega -> z(omega) = e^((2 pi)/l omega)$ from the cylinder to the plane reads
  $
    S(z, omega) & = (partial^3 z)/(partial^3 omega) ((partial z)/(partial omega))^(-1) - 3/2 ((partial^2 z)/(partial^2 omega))^2 ((partial z)/(partial omega))^(-2) \
    & = ((2 pi)/l)^3 z ((2 pi)/l)^(-1) z^(-1) - 3/2 ((2 pi)/l)^4 z^2 ((2 pi)/l)^(-2) z^(-2) = -1/2 ((2 pi)/l)^2
  $
  Solving eq. @eq:schwarzian-trafo for the energy-momentum tensor on the cylinder yields
  $ T_"pln" (z) = ((partial z)/(partial omega))^(-2) [T_"cyl" (omega) - c/12 S(z, omega)] wide => wide T_"cyl" (omega) = ((partial z)/(partial omega))^2 T_"pln" (z) + c/12 S(z, omega). $
  We plug in our result for the Schwarzian derivative and get
  $ T_"cyl" (omega) = ((2 pi)/l)^2 z^2 T_"pln" (z) - 1/2 ((2 pi)/l)^2 c/12 = ((2 pi)/l)^2 (z^2 T_"pln" (z) - c/24). $ <eq:t-cyl>
  We interpret the central term $c$ of the quantum Virasoro algebra as the Casimir energy.
  #note[
    Operating on the plane means dealing with flat infinitely extended spacetime. Intuitively, the lowest possible energy, i.e. the zero-point energy $ev(H_0)$, on this space should vanish (see lecture notes, p. 81). Since Hamiltonian and energy-momentum tensor are directly related, $H prop integral dif sigma T(tau, sigma)$, this particularly implies that the one-point function on the plane must also vanish, i.e. $ev(T_"pln" (z)) = 0$. Using this information in eq. @eq:t-cyl, we get the very interesting result
    $ ev(T_"cyl" (omega)) = -c/24 ((2 pi)/l)^2. $ <eq:casimir>
    Not only does eq. @eq:casimir demonstrate, that the one-point function on the cylinder is non-vanishing, it also seems to introduce a length scale into our theory, thereby breaking the conformal symmetry it enjoyed thus far. This is due to the underlying geometry containing a length scale: the circumference $l$ of the cylinder.
  ]

= Bonus question: Fractional linear transformations

#task[
  The purpose of this exercise is to show that conformal transformations on the Riemann sphere (i.e. on $CC union {infinity}$) map any 3 points to any other 3 points. The conformal group on the Riemann-sphere is given by $SL$ of $2 times 2$-matrices with unit determinant acting on the Riemann-sphere by so-called fractional linear transformations
  $ z -> z' = (a z + b)/(c z + d), $ <eq:mobius>
  where
  $ bA = mat(a, b; c, d) in SL. $ <eq:a-matrix>
  + Show that two successive fractional linear transformations,
    $ z -> z' = (a z + b)/(c z + d), #h(3em) z' -> z'' = (e z' + f)/(g z' + h), $
    are equivalent to one fractional linear transformation
    $ z -> z'' = (j z + k)/(l z + m), $
    where the matrix
    $ mat(j, k; l, m) in SL $
    is the product of the two $SL$ matrices that correspond to the single transformations $z -> z'$ and $z' -> z''$.
  + Show that the fractional linear action of the inverse matrix of @eq:a-matrix on $z'$ leads back to $z$, and hence corresponds to the inverse transformation $z' -> z$.
  + Consider the map
    $ z -> z' = ((b - c)(z - a))/((b - a)(z - c)). $ <eq:three-point-map>
    Show that this defines, up to an overall rescaling, an $SL$ transformation provided $a$, $b$, $c$ are pairwise distinct. Use this to show that $SL$ maps any 3 distinct points on $S^2$ to any other 3 distinct points.
  + Show that the cross-ratio
    $ chevron.l z_1, z_2, z_3, z_4 chevron.r equiv ((z_1 - z_2)(z_3 - z_4))/((z_1 - z_4)(z_3 - z_2)) $ <eq:cross-ratio>
    is $SL$ invariant. Use this to show that
    $ chevron.l z, a, b, c chevron.r = z', $
    where $z'$ is the one given in part c).
]

+ The conformal group on the Riemann sphere $S^2 = CC union {infinity}$ is the group of special linear transformations of degree 2,
  $ SL = {bA in "Mat"(2 times 2, CC) | det(bA) = 1}, $
  with ordinary matrix multiplication and matrix inversion as group operations. $SL$ can be parametrized by fractional-linear transformations (also known as Möbius transformations)
  $ z -> z' = (a z + b)/(c z + d), #h(3em) bA = mat(a, b; c, d) in SL. $
  Performing two successive fractional linear transformations, $z -> z' = (a z + b)/(c z + d)$ followed by $z' -> z'' = (e z' + f)/(g z' + h)$, we get
  $ z'' = (e (a z + b)/(c z + d) + f)/(g (a z + b)/(c z + d) + h) = (a e z + b e + c f z + d f)/(a g z + b g + c h z + d h) = ((a e + c f) z + (b e + d f))/((a g + c h) z + (b g + d h)) equiv (j z + k)/(l z + m). $
  Thus, the overall transformation is given by
  $ bC = mat(j, k; l, m) = mat(a e + c f, b e + d f; a g + c h, b g + d h). $
  Since
  $
    det(bC) & = (a e + c f)(b g + d h) - (a g + c h)(b e + d f) \
    & = u1(a b e g) + a e d h + c f b g + u2(c f d h) - u1(a g b e) - a g d f - c h b e - u2(c h d f) \
    & = a e d h + c f b g - a g d f - c h b e = a d (underbrace(e h - g f, 1)) + b c (underbrace(f g - e h, -1)) = a d - b c = 1, quad checkmark
  $
  $bC$ is also in $SL$. Hence, any two successive $SL$-transformations give a third. This is not surprising as we had already asserted $SL$ to be a group.
+ The inverse of $bA$ from eq. @eq:a-matrix is given by
  $ bA^(-1) = mat(d, -b; -c, a). $
  Applying the fractional linear transformation corresponding to $bA^(-1)$ to $z'$ returns $z$,
  $ (d z' - b)/(-c z' + a) = (d (a z + b)/(c z + d) - b)/(-c (a z + b)/(c z + d) + a) = (d a z + u1(d b) - b c z - u1(b d))/(u2(-a c z) - c b + u2(a c z) + a d) = ((a d - b c) z)/(a d - c b) = z. quad checkmark $
  The inverse of transformation @eq:mobius is indeed represented by $bA^(-1)$.
+ Reshaped into the standard form of a fractional linear transformation, eq. @eq:three-point-map reads
  $ z -> z' = ((b - c) z - a(b - c))/((b - a) z - c(b - a)). $
  The corresponding $SL$-matrix
  $ bD = mat(b - c, (c - b) a; b - a, (a - b) c) $
  has determinant
  $ det(bD) = (b - c)(a - b) c - (b - a)(c - b) a = (a - b)(b - c)(c - a). $
  As long as $a != b and a != c and b != c$, $bD$ has non-vanishing determinant and can be made $SL$ with a simple scale factor of $bD' = bD \/ sqrt(det(bD))$.

  As for showing that $SL$ maps any 3 distinct points on $S^2$ to any other 3 distinct points, we note that the transformation @eq:three-point-map maps
  $ z' = ((b - c)(z - a))/((b - a)(z - c)) = cases(0 quad & "for" z = a\,, 1 & "for" z = b\,, infinity & "for" z = c\,) $
  where ${0, 1, infinity}$ all lie on $S^2$ and we already showed that $a$, $b$, and $c$ are arbitrary but distinct points on $S^2$. Thus, all that remains to be shown is that there exists an $SL$-transformation that maps ${0, 1, infinity}$ to any three distinct points ${z_1, z_2, z_3}$ on $S^2$. Fortunately, we already know that a transformation of the form @eq:three-point-map, i.e.
  $ z -> z' = ((z_2 - z_3)(z - z_1))/((z_2 - z_1)(z - z_3)), #h(3em) "with" mat(z_2 - z_3, (z_3 - z_2) z_1; z_2 - z_1, (z_1 - z_2) z_3) equiv bE $
  maps ${z_1, z_2, z_3}$ to ${0, 1, infinity}$ and can be made $SL$ by scaling
  $ SL quad in.rev quad bE' = 1/sqrt(det(bE)) bE = 1/sqrt((z_1 - z_2)(z_2 - z_3)(z_3 - z_1)) bE. $
  Thus the combined transformation $bF equiv bE'^(-1) bD'$ maps any three points ${a, b, c}$ to any other three points ${z_1, z_2, z_3}$ on $S^2$, where the points in each set are pairwise distinct.
+ A simple calculation shows that the cross-ratio defined in eq. @eq:cross-ratio is invariant under $SL$-transformations,
  $
    chevron.l z_1, z_2, z_3, z_4 chevron.r -> chevron.l z'_1, z'_2, z'_3, z'_4 chevron.r & = ((z'_1 - z'_2)(z'_3 - z'_4))/((z'_1 - z'_4)(z'_3 - z'_2)) eqby("eq:three-point-map") (((z_1 - a)/(z_1 - c) - (z_2 - a)/(z_2 - c)) ((z_3 - a)/(z_3 - c) - (z_4 - a)/(z_4 - c)))/(((z_1 - a)/(z_1 - c) - (z_4 - a)/(z_4 - c)) ((z_3 - a)/(z_3 - c) - (z_2 - a)/(z_2 - c))) \
    & = (((z_1 - z_2)(z_3 - z_4)(a - c)^2)/((z_1 - c)(z_2 - c)(z_3 - c)(z_4 - c)))/(((z_1 - z_4)(z_3 - z_2)(a - c)^2)/((z_1 - c)(z_2 - c)(z_3 - c)(z_4 - c))) = ((z_1 - z_2)(z_3 - z_4))/((z_1 - z_4)(z_3 - z_2)) = chevron.l z_1, z_2, z_3, z_4 chevron.r.
  $
  Completely unrelated and simply by definition, we have
  $ chevron.l z, a, b, c chevron.r eqby("eq:cross-ratio") ((z - a)(b - c))/((z - c)(b - a)) eqby("eq:three-point-map") z'. $
