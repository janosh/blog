#import "/notes.typ": note, task, ev, bra, ket, eqby
#import "/string-theory/sheet.typ": NO, cR, zb, wb, oint, sheet
#import "/string-theory/contours.typ": contour-deformation

#show: sheet.with(8, [December 1st, 2015], [December 9th, 2015])

#let Xc = $X_c$
#let eikX(z) = $e^(i k X_c (#z))$
// Wick's theorem step, written as a slanted arrow onto the equals sign in the original
#let wt = $limits(=)^"W.T."$

= The free boson on the sphere, normal ordering, and all that

#task[
  Consider the action for the free boson
  $ S[X] = 1/(2 pi alpha') integral dif z dif zb partial_z X(z, zb) partial_zb X(z, zb), $ <eq:action>
  with energy momentum tensor
  $ T(z) = -1/alpha' NO[partial Xc (z) partial Xc (z)], $ <eq:t>
  in terms of the (anti-)chiral fields $X(z, zb) = Xc (z) + X_a (zb)$.
  + Recall from the lecture the definition of the normal ordering prescription $NO$ employed above. Give the general relation between normal ordered and radially ordered operators.
  + Give the correlator $ev(Xc (z) Xc (w))$ for the field $Xc (z)$. Compare this with the correlator of two primary fields in a general CFT. Deduce the correlator $ev(partial_z Xc (z) partial_w Xc (w))$ from $ev(Xc (z) Xc (w))$.
  + Review the derivation of the OPE of $T(z) partial Xc (w)$ for the primary field $partial Xc (w)$ via Wick's theorem as given in the lecture. Following that same logic, compute the OPE
    $ cR[T(z) T(w)] = 1/alpha'^2 NO[partial Xc (z) partial Xc (z)] NO[partial Xc (w) partial Xc (w)], $
    by writing down all cross-contractions between fields not in the same normal ordered expression and bring the result into the standard form
    $ T(z) T(w) = (c\/2)/(z - w)^4 + (2 T(w))/(z - w)^2 + (partial_w T(w))/(z - w) + "(finite terms)". $
    Take a minute to enjoy the ease of this derivation of the normal ordering constant $c$ as compared to a brute-force computation in terms of the modes.
  + Now consider the normal ordered field $NO(eikX(z))$. By expanding the exponential $NO(eikX(z)) = sum_(n=0)^infinity (i k)^n/n! NO[Xc^n (z)]$ and using Wick's theorem, derive the OPE
    $ cR[partial Xc (z) NO(eikX(w))] = -(i alpha' k)/2 NO(eikX(w))/(z - w) + "(finite terms)". $
    Use this to compute also the OPE
    $ cR[T(z) NO(eikX(w))] = (alpha' k^2)/4 NO(eikX(w))/(z - w)^2 + (partial NO(eikX(w)))/(z - w). $
    What does this tell us about the nature of $NO(eikX(z))$?
]

+ *Normal ordering* is the prescription of moving all creation operators to the left, so that the annihilation operators act first. Actually choosing which modes represent creators and which annihilators usually goes hand in hand with the choice of vacuum a particular $ket(Omega)$, where the goal always is to match the two in such a way that the vacuum expectation value of any normal-ordered product of operators is zero,
  $ bra(Omega) NO[product_(i=1)^n hat(cal(O))_i] ket(Omega) = 0. $ <eq:vev-zero>
  In string theory, we identify modes $alpha_m^mu$ with $m > 0$ as annihilation and those with $m <= 0$ as creation operators. Normal ordering can then be implemented via the map $NO$,
  $ NO(alpha_m^mu alpha_n^nu) = cases(alpha_m^mu alpha_n^nu quad & "for" m <= n\,, alpha_n^nu alpha_m^mu & "for" n < m.) $
  Another thing that should not go unmentioned in any discussion of normal ordering is *Wick's theorem*. It is used extensively in (perturbative) quantum field theories to reduce arbitrary products of creators and annihilators to sums of products of pairs of these operators. In string theory, it relates normal- with time-/radially-ordered products of fields, where time-ordering applies to the cylinder and radial-ordering arises on the complex plane respectively the Riemann sphere. For a product of just two radially-ordered fields $phi_1 (z)$, $phi_2 (w)$, Wick's theorem states
  $ cR[phi_1 (z) phi_2 (w)] = NO[phi_1 (z) phi_2 (w)] + bra(Omega) phi_1 (z) phi_2 (w) ket(Omega). $ <eq:wick-two>
  This relation can be inductively used to relate time-ordered and normal-ordered products of more than two fields by summing over all possible contractions, i.e. by successively taking all pairs of fields and replacing them by their two-point correlator. E.g. for three fields $phi_1 (z)$, $phi_2 (w)$, and $phi_3 (z_3)$, Wick's theorem would read
  $
    cR[phi_1 (z) phi_2 (w) phi_3 (z_3)] & = NO[phi_1 (z) phi_2 (w) phi_3 (z_3) + phi_1 (z) bra(Omega) phi_2 (w) phi_3 (z_3) ket(Omega) \
    & #h(4em) + phi_2 (w) bra(Omega) phi_1 (z) phi_3 (z_3) ket(Omega) + phi_3 (z_3) bra(Omega) phi_1 (z) phi_2 (w) ket(Omega)] \
    & = NO[phi_1 (z) phi_2 (w) phi_3 (z_3)] + sum_(i=1)^3 phi_i (z_i) bra(Omega) phi_j (z_j) phi_k (z_k) ket(Omega),
  $ <eq:wick-three>
  where $z_1 = z$, $z_2 = w$, and $j < k$ are the two indices other than $i$.
  #note[
    The normal-ordered product of two operators is precisely the non-singular part in an OPE. That is to say if $phi_1 (z)$, $phi_2 (w)$ denote two fields, then their radially-ordered product expansion decomposes into the two terms
    $ cR[phi_1 (z) phi_2 (w)] = underbrace(sum_(n=1)^infinity a_n/(z - w)^n, "singular piece") + NO[phi_1 (z) phi_2 (w)], $
    which in turn, comparing with eq. @eq:wick-two, identifies the singular piece with the vacuum expectation value.
  ]
+ Rather than just give the correlator $ev(Xc (z) Xc (w))$, we will try to derive it here starting from the free boson action @eq:action. First, note that since
  $
    0 limits(=)^! (delta S[X])/(delta X(z, zb)) & = 1/(pi alpha') integral dif z' dif zb' partial_(z') X(z', zb') (partial_(zb') delta X(z', zb'))/(delta X(z, zb)) \
    & = -1/(pi alpha') integral dif z' dif zb' partial_(zb') partial_(z') X(z', zb') delta(z - z') delta(zb - zb') = -1/(pi alpha') partial_zb partial_z X(z, zb),
  $ <eq:eom>
  the string field's e.o.m. on the plane is given by $partial_z partial_zb X(z, zb) = 0$ which $X(z, zb) = Xc (z) + X_a (zb)$ is indeed the general solution of, and entirely equivalent to the e.o.m.s $(partial_tau^2 - partial_sigma^2) X(tau, sigma) = 0$ and $partial_+ partial_- X(xi^+, xi^-) = 0$ we found for regular worldsheet coordinates and in lightcone gauge, respectively.#footnote[We did not pick up any boundary terms from the partial integration in eq. @eq:eom because the timelike ones vanish due to the variation being held fixed at initial and final times, i.e. $delta X(z, zb)|_(tau_i, tau_f) = 0$, and the spacelike boundary terms either cancel each other for the closed string with periodic boundaries or vanish separately for the open string with Dirichlet or Neumann boundary conditions.] Using the e.o.m., we can obtain the two-point function directly from the path integral,
  $
    0 & = 1/Z integral cal(D) X(z', zb') delta/(delta X(z, zb)) (X(z', zb') e^(-S[X(z', zb')])) \
    & = 1/Z integral cal(D) X(z', zb') ((delta X(z', zb'))/(delta X(z, zb)) e^(-S[X(z', zb')]) - X(z', zb') e^(-S[X(z', zb')]) (delta S[X(z', zb')])/(delta X(z, zb))) \
    & eqby("eq:eom") 1/Z integral cal(D) X(z', zb') e^(-S[X(z', zb')]) (delta(z - z') delta(zb - zb') + 1/(pi alpha') X(z', zb') partial_zb partial_z X(z, zb)) \
    & = lr(chevron.l delta(z - z') delta(zb - zb') + 1/(pi alpha') X(z', zb') partial_zb partial_z X(z, zb) chevron.r),
  $
  where the very first equality $0 = ...$ comes from the fact that the path integral over a manifold $M$ of a functional derivative $(delta F[phi(x)])/(delta phi(x))$ gives just the function $F[phi(x)]$ evaluated at the boundary $partial M$, i.e.
  $ integral_M cal(D) phi(x) (delta F[phi(x)])/(delta phi(x)) = F[phi(x)]|_(partial M), $
  which we take to be zero in the case of the localized string field. Thus, we found
  $ partial_zb partial_z ev(X(z, zb) X(w, wb)) = -pi alpha' delta(z - w) delta(zb - wb). $ <eq:laplacian>
  To make this more explicit, we revert to Stokes theorem on the complex plane,
  $ integral_U (partial_zb F - partial_z G) dif z dif zb = -i integral.cont_(partial U) (F dif z + G dif zb), $
  where $F = F(z, zb)$, $G = G(z, zb)$ are continuously differentiable functions on an open region $U$ of $CC$. For the special case of $G = 0$, $F = 1/z$, and $U = B_r (0)$ a ball of radius $r$ at the origin, we get
  $ integral_(B_r (0)) partial_zb 1/z dif z dif zb = -i underbrace(integral.cont_(partial B_r (0)) 1/z dif z, 2 pi i) = 2 pi = 2 pi underbrace(integral delta(z) delta(zb) dif z dif zb, 1), $
  from which we infer
  $ 2 pi delta(z) delta(zb) = partial_zb 1/z. $
  By reinserting this handy little formula and using $partial_zb 1/z = partial_zb zb/(z zb) = partial_zb partial_z ln(|z|^2)$, eq. @eq:laplacian becomes
  $ partial_zb partial_z ev(X(z, zb) X(w, wb)) = -alpha'/2 partial_zb partial_z ln(|z - w|^2), $
  which we can integrate twice to obtain
  $ ev(X(z, zb) X(w, wb)) = -alpha'/2 ln(|z - w|^2). $
  This is the familiar result that the Green's function in two dimensions is logarithmic.
  #note[This logarithmic correlation exempts the string field $X(z, zb)$ from having a definite scaling dimension, meaning it is not a primary nor even a quasi-primary field of the free bosonic CFT. However, as we will see, both its derivative and exponential are primary fields.]
  Since $ev(X(z, zb) X(w, wb)) = ev(Xc (z) Xc (w)) + ev(Xc (z) X_a (wb)) + ev(X_a (zb) Xc (w)) + ev(X_a (zb) X_a (wb))$ and $ln(|z - w|^2)$ can be split up into $ln[(z - w)(zb - wb)] = ln(z - w) + ln(zb - wb)$, we simply match terms based on their functional arguments to identify the chiral and antichiral two-point correlators as
  $ ev(Xc (z) Xc (w)) = -alpha'/2 ln(z - w), #h(3em) ev(X_a (zb) X_a (wb)) = -alpha'/2 ln(zb - wb). $ <eq:two-point>
  From this in turn, $ev(partial_z Xc (z) partial_w Xc (w))$ follows by differentiation,
  $
    ev(partial_z Xc (z) partial_w Xc (w)) & = partial_z partial_w ev(Xc (z) Xc (w)) eqby("eq:two-point") -alpha'/2 partial_w partial_z ln(z - w) \
    & = alpha'/2 partial_z 1/(z - w) = -alpha'/2 1/(z - w)^2
  $ <eq:dxdx>
  #note[This indeed fits the form of the two-point function of two quasi-primaries, $ev(phi_i (z_i) phi_j (z_j)) = (d_(i j) delta_(h_i, h_j))/(z_i - z_j)^(2 h_i)$, which is a sufficient condition for $partial_z Xc (z)$ to be a quasi-primary field of weight $h = 1$.]
+ Applying Wick's theorem to $cR[T(z) partial_w Xc (w)]$ gives
  $
    cR[T(z) partial_w Xc (w)] & eqby("eq:t") -1/alpha' cR[NO[partial_z Xc (z) partial_z Xc (z)] partial_w Xc (w)] \
    & eqby("eq:wick-three") -1/alpha' [underbrace(NO[partial_z Xc (z) partial_z Xc (z) partial_w Xc (w)], "non-singular piece") + 2 partial_z Xc (z) underbrace(ev(partial_z Xc (z) partial_w Xc (w)), -alpha'/2 1/(z - w)^2) \
    & #h(5em) + partial_w Xc (w) underbrace(ev(NO[partial_z Xc (z) partial_z Xc (z)]), "0, by eq." #ref(<eq:vev-zero>))].
  $ <eq:t-dx>
  Expanding the prefactor $partial_z Xc (z)$ of the singular term around $z = w$ to first order,
  $ partial_z Xc (z)|_w = partial_w Xc (w) + partial_w^2 Xc (w) (z - w) + cal(O)[(z - w)^2], $ <eq:taylor-dx>
  and reinserting it into @eq:t-dx gives
  $ #box(stroke: 0.5pt, inset: 6pt, $display(cR[T(z) partial_w Xc (w)] = (partial_w Xc (w))/(z - w)^2 + (partial_w^2 Xc (w))/(z - w) + "(terms non-singular at" z = w").")$) $
  This matches the OPE of a primary field $phi(z)$ of weight $h$ with the energy-momentum tensor,
  $ cR[T(z) phi(w)] = (h phi(w))/(z - w)^2 + (partial_w phi(w))/(z - w) + "(terms non-singular at" z = w"),", $ <eq:primary-ope>
  identifying $partial_w Xc (w)$ as a primary with $h = 1$. \
  To compute the OPE of $cR[T(z) T(w)]$, we again employ Wick's theorem,
  $
    cR[T(z) T(w)] & eqby("eq:t") 1/alpha'^2 cR[NO[partial_z Xc (z) partial_z Xc (z)] NO[partial_w Xc (w) partial_w Xc (w)]] \
    & eqby("eq:wick-three") 1/alpha'^2 NO[partial_z Xc (z) partial_z Xc (z) partial_w Xc (w) partial_w Xc (w) \
    & #h(5em) + 4 partial_z Xc (z) partial_w Xc (w) ev(partial_z Xc (z) partial_w Xc (w)) \
    & #h(5em) + 2 ev(partial_z Xc (z) partial_w Xc (w))^2],
  $ <eq:tt-wick>
  where we ignored all contractions inside normal-ordered operator products, i.e.
  $
    & 2 NO[partial_z Xc (z) partial_z Xc (z)] ev(NO[partial_z Xc (z) partial_z Xc (z)]), \
    "and" quad & ev(NO[partial_z Xc (z) partial_z Xc (z)]) ev(NO[partial_w Xc (w) partial_w Xc (w)]),
  $
  by argument of eq. @eq:vev-zero. Inserting eqs. @eq:dxdx and @eq:taylor-dx into eq. @eq:tt-wick yields
  $
    cR[T(z) T(w)] = 1/alpha'^2 [ & NO[partial_z Xc (z) partial_z Xc (z) partial_w Xc (w) partial_w Xc (w)] \
    & - 2 alpha' NO[partial_z Xc (z) partial_w Xc (w)]/(z - w)^2 + alpha'^2/2 1/(z - w)^4].
  $
  Inserting the following Taylor expansion for the numerator of the second term,
  $
    & NO[partial_z Xc (z) partial_w Xc (w)] \
    & quad = underbrace(NO[partial_w Xc (w) partial_w Xc (w)], -alpha' T(w)) + NO[[partial_w^2 Xc (w)] partial_w Xc (w)] (z - w) + cal(O)[(z - w)^2] \
    & quad = -alpha' T(w) + 1/2 underbrace(partial_w NO[partial_w Xc (w) partial_w Xc (w)], -alpha' partial_w T(w)) (z - w) + cal(O)[(z - w)^2].
  $
  we finally get the OPE of the energy-momentum tensor with itself,
  $ #box(stroke: 0.5pt, inset: 6pt, $display(cR[T(z) T(w)] = (overbrace(1/2, arrow.l c))/(z - w)^4 + (2 T(w))/(z - w)^2 + (partial_w T(w))/(z - w) + "(terms non-singular at" z = w"),")$) $
  which confirms that the central extension $c$ of the Virasoro algebra is given by 1. $c != 0$ signals a quantum anomaly of the CFT's classical conformal symmetry.
+ Next, we compute the OPE of $cR[partial_z Xc (z) NO(eikX(w))]$, where $NO(eikX(w))$ can be expanded into $sum_(n=0)^infinity (i k)^n/n! NO[Xc^n (w)]$.
  $
    & cR[partial_z Xc (z) NO(eikX(w))] \
    & quad = sum_(n=0)^infinity (i k)^n/n! underbrace(cR[partial_z Xc (z) NO[Xc^n (w)]], NO[partial_z Xc (z) Xc^n (w) + n Xc^(n-1) (w) ev(partial_z Xc (z) Xc (w))]", by Wick's thm.") \
    & quad wt sum_(n=0)^infinity (i k)^n/n! NO[partial_z Xc (z) Xc^n (w)] + sum_(n=1)^infinity (i k)^n/(n - 1)! NO[Xc^(n-1) (w)] partial_z ev(Xc (z) Xc (w)).
  $
  The first term is simply the operator product we started with but now in normal-ordered form, $NO[partial_z Xc (z) NO(eikX(w))]$. For the correlator in the second term, we adjust the sum to start at $n = 0$ and insert our result $ev(Xc (z) Xc (w)) = -alpha'/2 ln(z - w)$ from eq. @eq:two-point to obtain
  $
    cR[partial_z Xc (z) NO(eikX(w))] & = underbrace(NO[partial_z Xc (z) NO(eikX(w))], "non-singular at" z = w) - i k alpha'/2 sum_(n=1)^infinity ((i k)^(n-1) n)/n! NO[Xc^(n-1) (w)]/(z - w) \
    & = -i k alpha'/2 NO[eikX(w)]/(z - w) + "(terms non-singular at" z = w")".
  $ <eq:dx-exp>
  We can use eq. @eq:dx-exp to further calculate $cR[T(z) NO(eikX(w))]$.
  $
    cR[T(z) NO(eikX(w))] & = -1/alpha' sum_(n=0)^infinity (i k)^n/n! cR[NO[partial_z Xc (z) partial_z Xc (z)] NO[Xc^n (w)]] \
    & wt -1/alpha' [sum_(n=0)^infinity (i k)^n/n! NO[partial_z Xc (z) partial_z Xc (z) Xc^n (w)] wide arrow.l "non-singular" \
    & #h(4em) + ev(partial_z Xc (z) Xc (w)) sum_(n=1)^infinity (i k)^n/n! 2 n NO[partial_z Xc (z) Xc^(n-1) (w)] \
    & #h(4em) + ev(partial_z Xc (z) Xc (w))^2 sum_(n=2)^infinity (i k)^n/n! n(n - 1) NO[Xc^(n-2) (w)]]
  $
  At this point, we again use $ev(partial_z Xc (z) Xc (w)) = -alpha'/2 1/(z - w)$ and adjust the sums to start at $n = 0$ to obtain
  $
    & cR[T(z) NO(eikX(w))] \
    & quad = -1/alpha' alpha'^2/4 (i k)^2/(z - w)^2 sum_(n=0)^infinity (i k)^n/n! NO[Xc^n (w)] + 1/alpha' alpha'/2 (2 i k)/(z - w) sum_(n=0)^infinity (i k)^n/n! NO[partial_z Xc (z) Xc^n (w)] \
    & quad quad + "(terms non-singular at" z = w")" \
    & quad = (alpha' k^2)/4 NO(eikX(w))/(z - w)^2 + (i k NO[overbrace(partial_z Xc (z), partial_w Xc (w) + cal(O)[z - w]) eikX(w)])/(z - w) + "(terms non-singular at" z = w")" \
    & quad = (alpha' k^2)/4 NO(eikX(w))/(z - w)^2 + (partial_w NO[eikX(w)])/(z - w) + "(terms non-singular at" z = w")".
  $
  This matches the operator product expansion of a primary field with $T(z)$ as given in eq. @eq:primary-ope and tells us that $NO(eikX(w))$ is a primary with weight $h = (alpha' k^2)/4$.

= Unitary CFTs

#task[
  The OPE of the energy-momentum tensor $T(z)$ with a primary field $phi(w)$ of dimension $h$ is
  $ T(z) phi(w) = (h phi(w))/(z - w)^2 + (partial_w phi(w))/(z - w) + "(non-singular terms)". $ <eq:t-phi>
  + Let $phi(w)$ be a primary field. Use eq. @eq:t-phi to show the following action of the Virasoro generators $L_m$, defined by $T(z) = sum_(m in ZZ) z^(-m-2) L_m$,
    $ L_(-1) phi(w) = partial_w phi(w), #h(3em) L_0 phi(w = 0) = h phi(w = 0). $ <eq:l-phi>
  + Use the Virasoro algebra to compute the norm $bra(phi) L_m L_(-m) ket(phi)$ for the state $ket(phi) = phi(0) ket(0)$ and $m in NN_0$. Deduce that if the CFT is to be unitary, the central term $c$ of the Virasoro algebra must satisfy $c >= 0$ and $h >= 0$ for all primary fields.
  + Use eq. @eq:l-phi to show that in a unitary CFT, a primary field of dimension $h = 0$ must be a constant field.

    *Note:* Locality and the equal time commutation relations for a constant field imply that it must be a simple number in $CC$. Therefore in a unitary CFT, the only primary with $h = 0$ is the identity operator with associated highest weight state the $P S L(2, CC)$-invariant vacuum $ket(0)$.
]

+ $T(z)$ is a chiral tensor of weight $(h, macron(h)) = (2, 0)$. Its Laurent series on the complex plane thus reads
  $ T(z) = sum_(m in ZZ) z^(-m-2) L_m, $
  in terms of the Virasoro generators
  $ L_m = oint(0) (dif z)/(2 pi i) z^(m+1) T(z). $
  Inserting this integral representation of $L_m$ into eq. @eq:l-phi's first equality and using eq. @eq:t-phi gives
  $ L_(-1) phi(w) = oint(w) (dif z)/(2 pi i) T(z) phi(w) eqby("eq:t-phi") oint(w) (dif z)/(2 pi i) [(h phi(w))/(z - w)^2 + (partial_w phi(w))/(z - w)] = partial_w phi(w). $ <eq:l-1>
  Equation @eq:l-phi's second equality may be demonstrated in the same way,
  $ L_0 phi(0) = oint(0) (dif z)/(2 pi i) z T(z) phi(0) eqby("eq:t-phi") oint(0) (dif z)/(2 pi i) [h/z phi(0) + partial_w phi(0)] = h phi(0). $
+ The Virasoro algebra is defined by the commutator
  $ [L_m, L_n] = (m - n) L_(m+n) + c/12 m(m^2 - 1) delta_(m,-n), #h(3em) forall m, n in ZZ. $ <eq:virasoro>
  We can use it to calculate the primary-state expectation value $bra(phi) L_m L_(-m) ket(phi)$ by writing
  $ bra(phi) L_m L_(-m) ket(phi) = bra(phi) [L_m, L_(-m)] ket(phi). $
  To establish the truth of this will require most of the work in this exercise.
  #set enum(numbering: "1.")
  + First, note that since $phi(w)$ was introduced as a primary field of weight $h$, it too enjoys a Laurent series
    $ phi(w) = sum_(n in ZZ) phi_n w^(-n-h). $
    We postulate that its action on the vacuum $phi(w) ket(0)$ should be non-singular at all times, but in particular at initial time $tau_i = -infinity$ which corresponds to $w_i = e^((2 pi)/l (tau_i - i sigma_i)) = 0$ on the complex plane.#footnote[See exercise 1.c) on assignment 7 for details concerning the conformal map from the cylinder to the plane.] For $phi(w) ket(0)$ not to blow up at $w = 0$ requires
    $ phi(0) ket(0) = sum_(n in ZZ) lim_(w -> 0) 1/w^(n+h) phi_n ket(0) < infinity #h(3em) <==> #h(3em) phi_n ket(0) = 0 quad forall n + h > 0. $ <eq:regularity>
    Now, enforcing condition @eq:regularity while acting with $phi(0)$ on the vacuum gives
    $
      ket(phi) = phi(0) ket(0) & = sum_(n in ZZ) lim_(w -> 0) 1/w^(n+h) phi_n ket(0) eqby("eq:regularity") sum_(n <= -h) lim_(w -> 0) 1/w^(n+h) phi_n ket(0) \
      & = sum_(n < -h) underbrace(lim_(w -> 0) 1/w^(n+h), 0) phi_n ket(0) + 1/w^(-h+h) phi_(-h) ket(0) = phi_(-h) ket(0).
    $
    This is conformal field theory's famous operator-state correspondence.
  + Having worked this hard to find $ket(phi) = phi_(-h) ket(0)$, we want to use this equation to work out the effect of $L_m$ on $ket(phi)$. We need one more tool for this, however, and that is $[L_m, phi_n]$. Using the integral representation of the Laurent series coefficients,
    $ phi_n = oint(0) (dif w)/(2 pi i) w^(n+h-1) phi(w), $ <eq:phi-n>
    we calculate
    $
      [L_m, phi_n] & = oint(0) (dif z)/(2 pi i) z^(m+1) T(z) oint(0) (dif w)/(2 pi i) w^(n+h-1) phi(w) - oint(0) (dif w)/(2 pi i) w^(n+h-1) phi(w) oint(0) (dif z)/(2 pi i) z^(m+1) T(z) \
      & = oint(0) (dif w)/(2 pi i) oint(w) (dif z)/(2 pi i) z^(m+1) w^(n+h-1) cR[T(z) phi(w)],
    $
    where we reemployed the contour deformation trick first used in exercise 2 on assignment 7.
    #align(center, contour-deformation)
    By inserting the radially ordered OPE @eq:t-phi, we get
    $
      [L_m, phi_n] & = oint(0) (dif w)/(2 pi i) oint(w) (dif z)/(2 pi i) z^(m+1) w^(n+h-1) [(h phi(w))/(z - w)^2 + (partial_w phi(w))/(z - w)] \
      & = oint(0) (dif w)/(2 pi i) [(m + 1) w^m w^(n+h-1) h phi(w) + w^(m+1) w^(n+h-1) partial_w phi(w)],
    $ <eq:l-phi-n>
    where we used Cauchy's integral formula to execute the $z$-integration,
    $ oint(w) (dif z)/(2 pi i) f(z)/(z - w)^n = 1/(n - 1)! f^((n-1)) (w). $
    After partially integrating the last term in eq. @eq:l-phi-n,#footnote[Where we pick up no boundary terms due to integrating along the closed contour $C_0$.] we can reverse-apply eq. @eq:phi-n to obtain
    $
      [L_m, phi_n] & = oint(0) (dif w)/(2 pi i) [h (m + 1) w^(m+n+h-1) phi(w) - (underbrace(partial_w w^(m+n+h), (m + n + h) w^(m+n+h-1))) phi(w)] \
      & = [h (m + 1) - (m + n + h)] oint(0) (dif w)/(2 pi i) [w^(m+n+h-1) phi(w)] \
      & = [(h - 1) m - n] phi_(m+n).
    $
  + Finally, all is in place to tackle $L_m ket(phi)$.
    $ L_m ket(phi) = L_m phi_(-h) ket(0) = phi_(-h) L_m ket(0) + [L_m, phi_(-h)] ket(0) = phi_(-h) L_m ket(0) + [(h - 1) m + h] phi_(m-h) ket(0). $ <eq:l-m-phi>
    By the same reasoning as employed in eq. @eq:regularity, regularity of $T(z) = sum_(m in ZZ) z^(-m-2) L_m$ at initial time $z = 0$ requires $L_m ket(0) = 0 thick forall m > -2$. Since $m$ was given as $m in NN_0$ by the exercise, this takes care of the $phi_(-h) L_m ket(0)$ term in eq. @eq:l-m-phi. The second term is zero if $phi_(m-h) ket(0) = 0$, which by eq. @eq:regularity is the case for all $m + h - h = m > 0$. Thus we have
    $ L_m ket(phi) = 0 #h(3em) forall m > 0. $ <eq:annihilates>
    The case $m = 0$ was already treated in part a) where we found $L_0 ket(phi) = h ket(phi)$. Unfortunately, we do not learn much from
    $ bra(phi) L_0 L_0 ket(phi) = h^2 chevron.l phi|phi chevron.r. $

  But for all $m > 0$, thanks to eq. @eq:annihilates, we can now confirm our initial statement $bra(phi) L_m L_(-m) ket(phi) = bra(phi) [L_m, L_(-m)] ket(phi)$. Inserting the Virasoro commutator @eq:virasoro, we hence get
  $ bra(phi) L_m L_(-m) ket(phi) eqby("eq:virasoro") bra(phi) 2 m L_0 + c/12 m(m^2 - 1) ket(phi) = 2 m h chevron.l phi|phi chevron.r + c/12 m(m^2 - 1) chevron.l phi|phi chevron.r. $ <eq:norm>
  For $m = 1$, eq. @eq:norm becomes
  $ bra(phi) L_1 L_(-1) ket(phi) = 2 h chevron.l phi|phi chevron.r, $ <eq:norm-1>
  which demonstrates that $h >= 0$ is a necessary condition for the absence of negative norm states. For $m -> infinity$, we get exactly the same constraint for the Virasoro algebra's central charge, $c >= 0$.
+ Lastly, we show that in a unitary CFT, a primary field $ket(phi^0)$ of dimension $h = 0$ must be constant. Utilizing again the operator-state correspondence, this follows immediately from considering the norm of the state $lim_(w -> 0) partial_w phi^0 (w) ket(0)$,
  $
    & lim_(w -> 0) ||partial_w phi^0 (w) ket(0)||^2 eqby("eq:l-1") lim_(w -> 0) ||L_(-1) phi^0 (w) ket(0)||^2 = ||L_(-1) ket(phi^0)||^2 = bra(phi^0) L_1 L_(-1) ket(phi^0) eqby("eq:norm-1") 2 h chevron.l phi^0|phi^0 chevron.r = 0, \
    & => quad partial_w phi^0 (w) = 0, "i.e." phi^0 (w) = phi^0 "is constant".
  $

= Bonus question: Verma modules and descendant fields

#task[
  The Verma module $V_(h_j)$ associated with the primary field $phi_j$ of dimension $h_j$ was defined in the lecture as the span of states $ket(phi_j^({k_i})) = ket(phi_j^(k_1, ..., k_n)) = L_(-k_1) ... L_(-k_n) ket(phi_j)$. These states are created from the $P S L(2, CC)$-invariant vacuum by insertion of the descendant field $phi_j^({k i}) (z)$ at $z = 0$, i.e.
  $ ket(phi_j^({k i})) = phi_j^({k i}) (0) ket(0). $ <eq:descendant-state>
  + What is the $L_0$ eigenvalue of $L_(-k_1) ... L_(-k_n) ket(phi_j)$?
  + Show that the descendant field $phi_j^k (w)$ corresponding to the state $ket(phi_j^k) = L_(-k) ket(phi_j)$ is given by
    $ phi_j^k (w) = oint(w) (dif z)/(2 pi i) (z - w)^(1-k) T(z) phi_j (w). $
    *Hint:* First perform a Taylor expansion for $T(z)$ about $z = w$ and then expand $T(z)$ into Virasoro modes.
]

+ The $L_0$ eigenvalue of a basis state $ket(phi_j^({k_i})) = L_(-k_1) ... L_(-k_n) ket(phi_j)$ of the Verma module $V_(h_j)$ can be computed with the help of the Virasoro algebra
  $ [L_m, L_n] = (m - n) L_(m+n) + c/12 m(m^2 - 1) delta_(m,-n), #h(3em) forall m, n in ZZ. $
  From it, we gather that all $L_(-k)$ with $k > 0$ act as creation operators on eigenstates $L_0 ket(phi) = h ket(phi)$ of $L_0$,
  $ L_0 L_(-k) ket(phi) = L_(-k) L_0 ket(phi) + [L_0, L_(-k)] ket(phi) = h L_(-k) ket(phi) + (0 + k) L_(-k) ket(phi) = (h + k) L_(-k) ket(phi). $
  By definition of the Verma module, the indices $k_i$ of the Virasoro generators are ordered, i.e. $k_i >= k_(i-1) > 0 thick forall i in {2, 3, ..., n}$, and in particular, all larger than zero. For the state $ket(phi_j^({k_i}))$, we thus have
  $ L_0 ket(phi_j^({k_i})) = L_0 product_(i=1)^n L_(-k_i) ket(phi_j) = (h_j + sum_(i=1)^n k_i) product_(i=1)^n L_(-k_i) ket(phi_j) = (h_j + sum_(i=1)^n k_i) ket(phi_j^({k_i})). $
+ Descendant fields are a new class of central objects in conformal field theory. They are not primary but rather secondary operators and enter the theory as coefficients via the operator product expansion of primary fields with the energy-momentum tensor, i.e.
  $ T(z) phi_j (w) = sum_(k=0)^infinity (z - w)^(k-2) phi_j^k (w) = (phi_j^0 (w))/(z - w)^2 + (phi_j^1 (w))/(z - w) + ... $
  #note[Comparing this expansion with the OPE eq. @eq:t-phi we wrote down earlier, we can immediately identify $phi_j^0 (w) = h_j phi_j (w)$ and $phi_j^1 (w) = partial_w phi_j (w)$.]
  We can pick out the $phi_j^k (w)$ term in the sum, by multiplying it with $(z - w)^(1-k)$ and integrating around the singularity at $z = w$:
  $
    oint(w) (dif z)/(2 pi i) (z - w)^(1-k) T(z) phi_j (w) & = oint(w) (dif z)/(2 pi i) (z - w)^(1-k) sum_(m=0)^infinity (z - w)^(m-2) phi_j^m (w) \
    & = sum_(m=0)^infinity oint(w) (dif z)/(2 pi i) (phi_j^m (w))/(z - w)^(k-m+1) = phi_j^k (w)
  $ <eq:descendant-field>
  #note[
    Recalling
    $ L_m = oint(0) (dif z)/(2 pi i) z^(m+1) T(z), $ <eq:l-m>
    we can also very easily confirm that the descendant states are created from the primary ones by the action of the Virasoro generators,
    $ ket(phi_j^k) eqby("eq:descendant-state") phi_j^k (0) ket(0) eqby("eq:descendant-field") oint(0) (dif z)/(2 pi i) z^(1-k) T(z) phi_j (0) ket(0) eqby("eq:l-m") L_(-k) phi_j (0) ket(0) = L_(-k) ket(phi_j) $
  ]
