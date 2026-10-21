#import "/notes.typ": task, vb, bra, ket, braket, eqby
#import "/string-theory/sheet.typ": NO, sheet

#show: sheet.with(4, [November 3rd, 2015], [November 11th, 2015])

#let (ba, bp, bfeta) = ($vb(alpha)$, $vb(p)$, $vb(eta)$)
#let vac = $ket(0\, p)$
#let bvac = $bra(0\, p)$

= The quantum Virasoro algebra

#task[
  In this exercise, we will show that in the quantized bosonic string theory the normal ordered Virasoro generators
  $ L_m = 1/2 sum_(n=-infinity)^infinity NO(ba_(m-n) dot ba_n) $ <eq:virasoro-def>
  satisfy the Virasoro algebra with central charge#footnote[A central charge, $T_0$, of a Lie algebra is a generator that commutes with all generators of the Lie algebra, $[T_a, T_0] = 0 thick forall a$, but appears on the right hand side of some commutators, $[T_a, T_b] = c T_0 + ...$, for some $T_a$ and $T_b$, with $c$ being a constant. In the above Virasoro algebra, the role of $T_0$ is played by the term proportional to $delta_(m,-n)$, which should be viewed as an extra generator in addition to the $L_m$.]
  $ [L_m, L_n] = (m - n) L_(m+n) + D/12 m(m^2 - 1) delta_(m,-n). $
  In order to become more familiar with the normal ordering prescription, we will do this by brute force methods, i.e., by simply using the definition of the normal ordered generators $L_m$ and then calculating their commutators. We will proceed in several smaller steps.
  + Explain why the normal ordering in $L_m$ only affects $L_0$ and why the Virasoro generators $L_m$ can be written in the following form,
    $ L_m = 1/2 sum_(n=-infinity)^0 ba_n dot ba_(m-n) + 1/2 sum_(n=1)^infinity ba_(m-n) dot ba_n. $ <eq:split-sum>
  + Using $[X, Y Z] = [X, Y] Z + Y [X, Z]$ and $[alpha_m^mu, alpha_n^nu] = m eta^(mu nu) delta_(m,-n)$, prove that for all $m, n in ZZ$,
    $ [alpha_m^mu, L_n] = m alpha_(m+n)^mu. $
  + Decompose the sum
    $ sum_(n=-infinity)^infinity = sum_(n=-infinity)^0 + sum_(n=1)^infinity $
    as we did in eq. @eq:split-sum to "solve" the normal ordering condition. Use the result of part b) to show that
    $
      [L_m, L_n] = & 1/2 sum_(l=-infinity)^0 [(m - l) ba_l dot ba_(m+n-l) + l ba_(n+l) dot ba_(m-l)] \
                   & + 1/2 sum_(l=1)^infinity [(m - l) ba_(m+n-l) dot ba_l + l ba_(m-l) dot ba_(n+l)].
    $ <eq:task-c>
  + Make the substitution $p = n + l$ in the second and fourth term in eq. @eq:task-c and verify
    $
      [L_m, L_n] = & 1/2 sum_(l=-infinity)^0 (m - l) ba_l dot ba_(m+n-l) + 1/2 sum_(p=-infinity)^n (p - n) ba_p dot ba_(m+n-p) \
                   & + 1/2 sum_(l=1)^infinity (m - l) ba_(m+n-l) dot ba_l + 1/2 sum_(p=n+1)^infinity (p - n) ba_(m+n-p) dot ba_p.
    $ <eq:task-d>
  + From now on, we will restrict ourselves to the case $n > 0$, as the other cases $n < 0$ and $n = 0$ are completely analogous. Show, therefore, that, for $n > 0$, the expression eq. @eq:task-d in part d) is equal to
    $
      [L_m, L_n] = & 1/2 sum_(p=-infinity)^0 (m - n) ba_p dot ba_(m+n-p) + 1/2 sum_(p=1)^n (p - n) ba_p dot ba_(m+n-p) \
                   & + 1/2 sum_(p=n+1)^infinity (m - n) ba_(m+n-p) dot ba_p + 1/2 sum_(p=1)^n (m - p) ba_(m+n-p) dot ba_p.
    $ <eq:task-e>
    Which of these terms are already normal-ordered?
  + Prove
    $ sum_(p=1)^n (p - n) ba_p dot ba_(m+n-p) = sum_(p=1)^n (p - n) ba_(m+n-p) dot ba_p + sum_(p=1)^n (p - n) p D delta_(m,-n), $
    and insert this for the second term in eq. @eq:task-e of part e).
  + Show that your result from part e) is now equivalent to
    $ [L_m, L_n] = 1/2 sum_(l=-infinity)^infinity (m - n) NO(ba_l dot ba_(m+n-l)) + 1/2 D sum_(l=1)^n (l^2 - n l) delta_(m,-n). $
  + Prove, e.g. by induction, the following identities,
    $ sum_(q=1)^n q^2 = n/6 (n + 1)(2 n + 1), $
    $ sum_(q=1)^n q = n/2 (n + 1), $
    and use this to finally derive
    $ [L_m, L_n] = (m - n) L_(m+n) + D/12 m(m^2 - 1) delta_(m,-n). $
    from the expression in part g).
]

+ As stated in eq. @eq:virasoro-def, the quantum Virasoro generators are defined as
  $ L_m = 1/2 sum_(n=-infinity)^infinity NO(ba_(m-n) dot ba_n), $ <eq:virasoro>
  where the normal ordering operator acts as
  $ NO(alpha_m^mu alpha_n^nu) = cases(alpha_m^mu alpha_n^nu quad & "for" m <= n\,, alpha_n^nu alpha_m^mu & "for" n < m\,) $
  and the components of the modes $ba_m$, $m in ZZ$ satisfy the commutation relation
  $ [alpha_m^mu, alpha_n^nu] = m eta^(mu nu) delta_(m,-n), $ <eq:mode-comm>
  i.e. the order of $alpha_m^mu$ and $alpha_n^nu$ only matters if $m = -n$. Looking at eq. @eq:virasoro, we see that this scenario can only arise if $m = 0$. For $m != 0$, $m - n$ can never equal $-n$. Therefore, we only need to worry about normal ordering when treating $L_0$.

  For $m = 0$ and $n > 0$, the dot product in eq. @eq:virasoro is already in normal order. For $m = 0$ and $n <= 0$, the order is reversed. Since we just established that in all other $L_m$, $m != 0$, the order is arbitrary, we can suppress the normal ordering symbol altogether by rewriting
  $
    L_m & = 1/2 sum_(n=-infinity)^0 NO(ba_(m-n) dot ba_n) + 1/2 sum_(n=1)^infinity NO(ba_(m-n) dot ba_n) \
        & = 1/2 sum_(n=-infinity)^0 ba_n dot ba_(m-n) + 1/2 sum_(n=1)^infinity ba_(m-n) dot ba_n.
  $
+ We show by direct calculation that $[alpha_m^mu, L_n] = m alpha_(m+n)^mu thick forall m, n in ZZ$.
  $
    [alpha_m^mu, L_n] & = 1/2 sum_(l=-infinity)^0 [alpha_m^mu, alpha_(l,nu) alpha_(n-l)^nu] + 1/2 sum_(l=1)^infinity [alpha_m^mu, alpha_(n-l)^nu alpha_(l,nu)] \
    & = 1/2 sum_(l=-infinity)^0 ([alpha_m^mu, alpha_(l,nu)] alpha_(n-l)^nu + alpha_(l,nu) [alpha_m^mu, alpha_(n-l)^nu]) + 1/2 sum_(l=1)^infinity ([alpha_m^mu, alpha_(n-l)^nu] alpha_(l,nu) + alpha_(n-l)^nu [alpha_m^mu, alpha_(l,nu)]) \
    & eqby("eq:mode-comm") m/2 sum_(l=-infinity)^0 (eta^mu zws_nu delta_(m,-l) alpha_(n-l)^nu + eta^(mu nu) delta_(m,l-n) alpha_(l,nu)) + m/2 sum_(l=1)^infinity (eta^(mu nu) delta_(m,l-n) alpha_(l,nu) + eta^mu zws_nu delta_(m,-l) alpha_(n-l)^nu).
  $
  We now carry out the above sums over $l$. When doing so, we have to bear in mind, however, that two of the four Kronecker deltas never contribute. Which ones depends on the values of $m$ and $n$. E.g. take $m > n > 0$, then the first $delta_(m,-l)$ contributes at $l = -m$ but $delta_(m,l-n) = 1 <=> m + n = l$ is always zero since $m + n > 0$. In the second we sum over positive $l$, so this behavior is reversed. What we end up with is
  $ [alpha_m^mu, L_n] = m/2 alpha_(m+n)^mu + m/2 alpha_(m+n)^mu = m alpha_(m+n)^mu. $ <eq:alpha-l>
+ Next we demonstrate eq. @eq:task-c $forall m, n in ZZ$. Using $[X Y, Z] = X [Y, Z] + [X, Z] Y$, we can write
  $
    [L_m, L_n] & = 1/2 sum_(l=-infinity)^0 [alpha_(l,mu) alpha_(m-l)^mu, L_n] + 1/2 sum_(l=1)^infinity [alpha_(m-l)^mu alpha_(l,mu), L_n] \
    & = 1/2 sum_(l=-infinity)^0 (alpha_(l,mu) [alpha_(m-l)^mu, L_n] + [alpha_(l,mu), L_n] alpha_(m-l)^mu) \
    & quad + 1/2 sum_(l=1)^infinity (alpha_(m-l)^mu [alpha_(l,mu), L_n] + [alpha_(m-l)^mu, L_n] alpha_(l,mu)) \
    & eqby("eq:alpha-l") 1/2 sum_(l=-infinity)^0 ((m - l) ba_l dot ba_(m+n-l) + l ba_(n+l) dot ba_(m-l)) \
    & quad + 1/2 sum_(l=1)^infinity ((m - l) ba_(m+n-l) dot ba_l + l ba_(m-l) dot ba_(n+l)).
  $ <eq:sol-c>
+ Replacing $p = n + l$ in terms two and four of eq. @eq:sol-c evidently gives
  $
    [L_m, L_n] = & 1/2 sum_(l=-infinity)^0 (m - l) ba_l dot ba_(m+n-l) + 1/2 sum_(p=-infinity)^n (p - n) ba_p dot ba_(m+n-p) \
                 & + 1/2 sum_(l=1)^infinity (m - l) ba_(m+n-l) dot ba_l + 1/2 sum_(p=n+1)^infinity (p - n) ba_(m+n-p) dot ba_p.
  $
+ Restricting to $n > 0$ and relabeling $l -> p$ in the first and third term, we may write $[L_m, L_n]$ as
  $
    [L_m, L_n] = & 1/2 sum_(p=-infinity)^0 (m - p) ba_p dot ba_(m+n-p) + 1/2 sum_(p=-infinity)^n (p - n) ba_p dot ba_(m+n-p) \
                 & + 1/2 sum_(p=1)^infinity (m - p) ba_(m+n-p) dot ba_p + 1/2 sum_(p=n+1)^infinity (p - n) ba_(m+n-p) dot ba_p.
  $
  We can now partially consolidate sums one and two and sums three and four by splitting sum two at $p = 0$ and sum three at $p = n$ (both operations are legal because $n > 0$) to get
  $
    [L_m, L_n] = & 1/2 sum_(p=-infinity)^0 (m - n) ba_p dot ba_(m+n-p) + 1/2 sum_(p=1)^n (p - n) ba_p dot ba_(m+n-p) \
                 & + 1/2 sum_(p=n+1)^infinity (m - n) ba_(m+n-p) dot ba_p + 1/2 sum_(p=1)^n (m - p) ba_(m+n-p) dot ba_p.
  $ <eq:sol-e>
  Assuming further $n > m > 0$, we check for normal ordering in each of the four sums:
  #align(center, table(
    columns: 6,
    stroke: none,
    align: left,
    table.hline(stroke: 0.8pt),
    table.header([sum], [$p$-range], [critical value], [operator product], [mode indices], [normal ordered]),
    table.hline(stroke: 0.5pt),
    [1], [$[-infinity, 0]$], [$p = 0$], [$ba_p dot ba_(m+n-p)$], [$0 < m + n$], [$checkmark$],
    [2], [$[1, n]$], [$p = n$], [$ba_p dot ba_(m+n-p)$], [$n lt.not m$], [$times$],
    [3], [$[n + 1, infinity]$], [$p = n + 1$], [$ba_(m+n-p) dot ba_p$], [$m + 1 < n + 1$], [$checkmark$],
    [4], [$[1, n]$], [$p = 1$], [$ba_(m+n-p) dot ba_p$], [$m + n - 1 lt.not 1$], [$times$],
    table.hline(stroke: 0.8pt),
  ))
+ By an application of the modes' commutation relation, we find
  $
    sum_(p=1)^n (p - n) ba_p dot ba_(m+n-p) & = sum_(p=1)^n (p - n) (ba_(m+n-p) dot ba_p + underbrace([alpha_(p,mu), alpha_(m+n-p)^mu], p eta^mu zws_mu delta_(p,p-m-n) = p D delta_(m,-n))) \
    & = sum_(p=1)^n (p - n) ba_(m+n-p) dot ba_p + sum_(p=1)^n (p - n) p D delta_(m,-n).
  $ <eq:sol-f>
+ By inserting eq. @eq:sol-f for the second term in eq. @eq:sol-e, we get
  $
    [L_m, L_n] = & 1/2 sum_(p=-infinity)^0 (m - n) ba_p dot ba_(m+n-p) + 1/2 sum_(p=1)^n (p - n) ba_(m+n-p) dot ba_p + 1/2 sum_(p=1)^n (p - n) p D delta_(m,-n) \
                 & + 1/2 sum_(p=n+1)^infinity (m - n) ba_(m+n-p) dot ba_p + 1/2 sum_(p=1)^n (m - p) ba_(m+n-p) dot ba_p
  $
  where sums two and five combine to give
  $
    [L_m, L_n] = & 1/2 sum_(p=-infinity)^0 (m - n) ba_p dot ba_(m+n-p) + 1/2 sum_(p=1)^n (m - n) ba_(m+n-p) dot ba_p \
                 & + 1/2 sum_(p=1)^n (p - n) p D delta_(m,-n) + 1/2 sum_(p=n+1)^infinity (m - n) ba_(m+n-p) dot ba_p.
  $
  By further joining sums two and four and reinserting the normal ordering operator, we obtain
  $
    [L_m, L_n] & = 1/2 sum_(p=-infinity)^0 (m - n) ba_p dot ba_(m+n-p) + 1/2 sum_(p=1)^infinity (m - n) ba_(m+n-p) dot ba_p + D/2 sum_(p=1)^n p(p - n) delta_(m,-n) \
               & = 1/2 sum_(p=-infinity)^infinity (m - n) NO(ba_p dot ba_(m+n-p)) + D/2 sum_(p=1)^n p(p - n) delta_(m,-n).
  $ <eq:sol-g>
+ We use induction to prove the following two identities.
  #set enum(numbering: "1.")
  + $display(sum_(q=1)^n q^2 = n/6 (n + 1)(2 n + 1)) quad forall n in NN$: \
    Checking $n = 1$:
    $ sum_(q=1)^1 q^2 = 1 = 1/6 (1 + 1)(2 + 1). quad checkmark $
    Checking $n => n + 1$:
    $
      sum_(q=1)^(n+1) q^2 & = sum_(q=1)^n q^2 + (n + 1)^2 = n/6 (n + 1)(2 n + 1) + (n + 1)^2 \
      & = (n + 1)/6 [n(2 n + 1) + 6(n + 1)] = (n + 1)/6 [2 n^2 + 7 n + 6] \
      & = (n + 1)/6 (2 n + 3)(n + 2) = (n + 1)/6 [2(n + 1) + 1][(n + 1) + 1]. quad checkmark
    $
  + $display(sum_(q=1)^n q = n/2 (n + 1)) quad forall n in NN$: \
    Checking $n = 1$:
    $ sum_(q=1)^1 q = 1 = 1/2 (1 + 1). quad checkmark $
    Checking $n => n + 1$:
    $
      sum_(q=1)^(n+1) q & = sum_(q=1)^n q + n + 1 = n/2 (n + 1) + n + 1 \
                        & = (n + 1)/2 (n + 2) = (n + 1)/2 [(n + 1) + 1]. quad checkmark
    $

  Applying these identities to the sum in the last term in eq. @eq:sol-g, we can simplify,
  $
    sum_(p=1)^n (p^2 - n p) & = n/6 (n + 1)(2 n + 1) - n n/2 (n + 1) = n/6 (n + 1) [2 n + 1 - 3 n] \
                            & = -n/6 (n + 1)(n - 1) = -n/6 (n^2 - 1).
  $
  Inserting this result into eq. @eq:sol-g, we arrive at the commutator of two quantum Virasoro generators,
  $
    [L_m, L_n] & = (m - n) L_(m+n) - D/2 n/6 (n^2 - 1) delta_(m,-n) \
               & = (m - n) L_(m+n) + D/12 m(m^2 - 1) delta_(m,-n).
  $

= The second excited level ghost

#task[
  Compute
  $ braket(phi_2, phi_2) = (2 c_1^2)/25 (D - 1)(26 - D) $
  for
  $ ket(phi_2) = (c_1 ba_(-1)^2 + c_2 bp dot ba_(-2) + c_3 (bp dot ba_(-1))^2) vac. $ <eq:phi2>
  *Hint:* Given $(L_0 - 1) ket(phi_2) = L_1 ket(phi_2) = L_2 ket(phi_2) = 0$ (setting $a = 1$), determine the relation between $c_1$, $c_2$ and $c_3$ defining $ket(phi_2)$. Then compute $braket(phi_2, phi_2)$.
]

Our goal in this exercise is to evaluate the Virasoro constraints#footnote[These constraints originated all the way back from $T_(a b) = 0$, which arose as the e.o.m. of the worldsheet metric $h_(a b)$. Since the Virasoro generators are nothing but the Fourier modes of the energy-momentum tensor, the constraint of having to vanish passes directly on to them.]
$ (L_m - a delta_(m,0)) ket(phi) = 0 #h(3em) forall m >= 0 "and" forall ket(phi) in cal(H)_"phys", $
to deduce that $D <= 26$ is a necessary (but not sufficient) condition for a ghost-free theory. To arrive at this conclusion, it is enough to consider the specific state given in eq. @eq:phi2.#footnote[As opposed to the most general state $ket(phi_2)$ at second excited level which can be written i.t.o. the string field modes as $ket(phi_2) = (zeta_(mu nu) alpha_(-1)^mu alpha_(-1)^nu + eta_mu alpha_(-2)^mu) vac$.] By assuming $ket(phi_2)$ to constitute a physical state and setting the normal ordering constant $a = 1$, we get exactly the constraints mentioned in the hint. To unravel, what implications these constraints hold for the allowed values of $D$ and the $c_i$, $i in {1, 2, 3}$, our strategy will be to commute the Virasoro generators through all of the creation operators in $ket(phi_2)$ and let them act directly on $vac$. \
First, using $X Y = Y X + [X, Y]$ on $L_m ket(phi_2)$, we get
$
  L_m ket(phi_2) & = (c_1 ba_(-1)^2 L_m + c_1 [L_m, ba_(-1)^2] + c_2 bp dot ba_(-2) L_m + c_2 [L_m, bp dot ba_(-2)] \
  & quad + c_3 (bp dot ba_(-1))^2 L_m + c_3 [L_m, (bp dot ba_(-1))^2]) vac \
  & = 1/2 delta_(m,0) ba_0^2 ket(phi_2) + (c_1 [L_m, ba_(-1)^2] + c_2 bp dot [L_m, ba_(-2)] + c_3 [L_m, (bp dot ba_(-1))^2]) vac.
$ <eq:l-phi2>
where in the last step, we used that $L_m$ for $m >= 0$ acts on the vacuum as
$
  L_m vac & = 1/2 sum_(n=-infinity)^infinity NO(ba_(m-n) dot ba_n) vac \
  & = 1/2 sum_(n > ceil(m/2)) ba_(m-n) dot underbrace(ba_n vac, 0) + 1/2 sum_(n=floor(m/2))^ceil(m/2) NO(ba_(m-n) dot ba_n) vac + 1/2 sum_(n < floor(m/2)) ba_n dot underbrace(ba_(m-n) vac, 0) \
  & = cases(
    1/2 ba_0 dot ba_0 vac & "if" m = 0\,,
    1/2 ba_(m - m/2) dot ba_(m/2) vac = 0 & "if" m in 2 NN\,,
    1/2 (ba_(m - ceil(m/2)) dot ba_ceil(m/2) + ba_floor(m/2) dot ba_(m - floor(m/2))) vac = 0 quad & "if" m in 2 NN + 1\,,
  ) \
  & = 1/2 delta_(m,0) ba_0^2 vac
$
Recall that modes $alpha_m^mu$ with $m <= 0$ were chosen as the creation operators whereas $m > 0$ corresponded to annihilators. \
We will now calculate each commutator in the last line of eq. @eq:l-phi2 in turn by reusing the identities
$ [alpha_m^mu, alpha_n^nu] = m eta^(mu nu) delta_(m,-n) #h(3em) "and" #h(3em) [alpha_m^mu, L_n] = m alpha_(m+n)^mu, $ <eq:identities>
which have already proven useful in exercise 1. \
Using $[X, Y Z] = [X, Y] Z + Y [X, Z]$, the first commutator becomes
$
  [L_m, ba_(-1)^2] & = underbrace([L_m, ba_(-1)], -(-1) ba_(-1+m)) dot ba_(-1) + ba_(-1) dot underbrace([L_m, ba_(-1)], -(-1) ba_(-1+m)) = ba_(m-1) dot ba_(-1) + ba_(-1) dot ba_(m-1) \
  & = 2 ba_(m-1) dot ba_(-1) + underbrace([alpha_(-1,mu), alpha_(m-1)^mu], -eta^mu zws_mu delta_(-1,1-m)) = 2 ba_(m-1) dot ba_(-1) - D delta_(m,2).
$ <eq:comm-1>
The second commutator is simpler,
$ [L_m, ba_(-2)] = -(-2) ba_(-2+m) = 2 ba_(m-2), $
whereas the third commutator is again a little work,
$
  [L_m, (bp dot ba_(-1))^2] & = [L_m, bp dot ba_(-1)] bp dot ba_(-1) + bp dot ba_(-1) [L_m, bp dot ba_(-1)] \
  & = bp dot [L_m, ba_(-1)] bp dot ba_(-1) + bp dot ba_(-1) bp dot [L_m, ba_(-1)] \
  & eqby("eq:identities") bp dot ba_(m-1) bp dot ba_(-1) + bp dot ba_(-1) bp dot ba_(m-1) \
  & = 2 bp dot ba_(m-1) bp dot ba_(-1) + underbrace([bp dot ba_(-1), bp dot ba_(m-1)], -p_mu p_nu eta^(mu nu) delta_(-1,1-m)) \
  & = 2 bp dot ba_(m-1) bp dot ba_(-1) - bp^2 delta_(m,2).
$ <eq:comm-3>
Reinserting eqs. @eq:comm-1 to @eq:comm-3 into eq. @eq:l-phi2, we get (still with $m >= 0$),
$
  L_m ket(phi_2) = 1/2 delta_(m,0) ba_0^2 ket(phi_2) + (& 2 c_1 ba_(m-1) dot ba_(-1) - c_1 D delta_(m,2) + 2 c_2 bp dot ba_(m-2) \
  & + 2 c_3 bp dot ba_(m-1) bp dot ba_(-1) - c_3 bp^2 delta_(m,2)) vac.
$ <eq:l-phi2-result>
In particular, considering eq. @eq:l-phi2-result for $m = 0$ yields
$
  L_0 ket(phi_2) & = 1/2 ba_0^2 ket(phi_2) + (2 c_1 ba_(-1) dot ba_(-1) + 2 c_2 bp dot ba_(-2) + 2 c_3 bp dot ba_(-1) bp dot ba_(-1)) vac \
  & = (1/2 ba_0^2 + 2) ket(phi_2).
$
Ergo, the physical state condition $(L_0 - a) ket(phi) limits(=)^! 0$, where $a = 1$, implies
$ (L_0 - 1) ket(phi_2) = (1/2 ba_0^2 + 1) ket(phi_2) limits(=)^! 0 wide => wide ba_0^2 = -2. $
For $m = 1$ eq. @eq:l-phi2-result reads
$ L_1 ket(phi_2) = (2 c_1 ba_0 dot ba_(-1) + 2 c_2 bp dot ba_(-1) + 2 c_3 bp dot ba_0 bp dot ba_(-1)) vac. $
To proceed here, we need to recall an equality derived in exercise 1.e) on assignment 3, namely $ba_0 = sqrt(2 alpha') bp$. We therefore get
$
  L_1 ket(phi_2) & = (2 c_1 ba_0 dot ba_(-1) + (2 c_2)/sqrt(2 alpha') ba_0 dot ba_(-1) + (2 c_3)/(2 alpha') underbrace(ba_0 dot ba_0, -2) ba_0 dot ba_(-1)) vac \
  & = 2 (c_1 + c_2/sqrt(2 alpha') - c_3/alpha') ba_0 dot ba_(-1) vac limits(=)^! 0 wide => wide c_1 + c_2/sqrt(2 alpha') - c_3/alpha' = 0.
$ <eq:l1-constraint>
Lastly, for $m = 2$, eq. @eq:l-phi2-result becomes
$ L_2 ket(phi_2) = (2 c_1 ba_1 dot ba_(-1) - c_1 D + 2 c_2 bp dot ba_0 + 2 c_3 bp dot ba_1 bp dot ba_(-1) - c_3 bp^2) vac. $ <eq:l2>
Here, we can apply the mode's commutation relation to let $ba_1$ act directly on the vacuum $vac$.
$ ba_1 dot ba_(-1) vac = ba_(-1) dot underbrace(ba_1 vac, 0) + underbrace([alpha_(1,mu), alpha_(-1)^mu], eta^mu zws_mu delta_(1,-(-1))) vac = D vac, $ <eq:a1a-1>
$ bp dot ba_1 bp dot ba_(-1) vac = p_mu p_nu alpha_(-1)^mu underbrace(alpha_1^nu vac, 0) + p_mu p_nu underbrace([alpha_1^nu, alpha_(-1)^mu], eta^(mu nu) delta_(1,-(-1))) vac = bp^2 vac. $ <eq:pa1pa-1>
Reinserting eqs. @eq:a1a-1 and @eq:pa1pa-1 into eq. @eq:l2 and using $bp^2 = ba_0^2/(2 alpha') = -1/alpha'$ gives
$
  L_2 ket(phi_2) & = (2 c_1 D - c_1 D + 2 sqrt(2 alpha') c_2 bp^2 + 2 c_3 bp^2 - c_3 bp^2) vac limits(=)^! 0 \
  & => wide D c_1 - 2 sqrt(2 \/ alpha') c_2 - c_3/alpha' = 0.
$ <eq:l2-constraint>
We now have two equations for the three state coefficients $c_i$, $i in {1, 2, 3}$. We can use them to express $c_2$ and $c_3$ i.t.o. $c_1$. By Inserting eq. @eq:l1-constraint into eq. @eq:l2-constraint, we find
$ D c_1 - (4 c_2)/sqrt(2 alpha') - c_1 - c_2/sqrt(2 alpha') = c_1 (D - 1) - (5 c_2)/sqrt(2 alpha') = 0 wide => wide c_2 = sqrt(2 alpha')/5 (D - 1) c_1. $ <eq:c2>
Plugging this back into eq. @eq:l1-constraint gives
$ c_1 + 1/5 (D - 1) c_1 - c_3/alpha' = 1/5 (D + 4) c_1 - c_3/alpha' = 0 wide => wide c_3 = (D + 4)/5 alpha' c_1. $
We are finally in a position to calculate $braket(phi_2, phi_2)$ and see what constraints on $D$ we must impose in order to avoid a negative norm of $ket(phi_2)$. Note that when expanding the ensuing product of modes, we do not need to consider mixed terms in which $ba_(plus.minus 2)$ appears since it freely commutes with $ba_(plus.minus 1)$ and can thus always act directly on the vacuum. This already reduces the total number of resulting terms from nine to five.
$
  braket(phi_2, phi_2) & = bvac (c_1 ba_1^2 + c_2 bp dot ba_2 + c_3 (bp dot ba_1)^2) (c_1 ba_(-1)^2 + c_2 bp dot ba_(-2) + c_3 (bp dot ba_(-1))^2) vac \
  & = c_1^2 bvac ba_1^2 ba_(-1)^2 vac + c_1 c_3 bvac ba_1^2 (bp dot ba_(-1))^2 vac + c_2^2 bvac bp dot ba_2 bp dot ba_(-2) vac \
  & quad + c_3 c_1 bvac (bp dot ba_1)^2 ba_(-1)^2 vac + c_3^2 bvac (bp dot ba_1)^2 (bp dot ba_(-1))^2 vac.
$ <eq:norm>
We'll calculate each of the five contributions in turn.
$
  bvac ba_1^2 ba_(-1)^2 vac & = bvac alpha_(1,mu) (alpha_(-1)^nu alpha_1^mu + eta^(mu nu)) alpha_(-1,nu) vac \
  & = bvac alpha_(1,mu) alpha_(-1)^nu (alpha_(-1,nu) alpha_1^mu + eta^mu zws_nu) vac + bvac ba_1 dot ba_(-1) vac \
  & = bvac alpha_(1,mu) alpha_(-1)^nu alpha_(-1,nu) underbrace(alpha_1^mu vac, 0) + 2 bvac ba_1 dot ba_(-1) vac eqby("eq:a1a-1") 2 D,
$ <eq:term-1>
$
  bvac ba_1^2 (bp dot ba_(-1))^2 vac & = p_nu p_rho bvac alpha_(1,mu) (alpha_(-1)^nu alpha_1^mu + eta^(mu nu)) alpha_(-1)^rho vac \
  & = p_nu p_rho bvac alpha_(1,mu) alpha_(-1)^nu (alpha_(-1)^rho alpha_1^mu + eta^(mu rho)) vac + bvac bp dot ba_1 bp dot ba_(-1) vac \
  & = p_nu p_rho bvac alpha_(1,mu) alpha_(-1)^nu alpha_(-1)^rho underbrace(alpha_1^mu vac, 0) + 2 bvac bp dot ba_1 bp dot ba_(-1) vac eqby("eq:pa1pa-1") 2 bp^2,
$ <eq:term-2>
$ bvac bp dot ba_2 bp dot ba_(-2) vac = p_mu p_nu bvac (alpha_(-2)^nu alpha_2^mu + 2 eta^(mu nu)) vac = 2 bp^2, $
$ bvac (bp dot ba_1)^2 ba_(-1)^2 vac = (bvac ba_1^2 (bp dot ba_(-1))^2 vac)^dagger eqby("eq:term-2") (2 bp^2)^dagger = 2 bp^2, $
$ bvac (bp dot ba_1)^2 (bp dot ba_(-1))^2 vac = 2 bp^4. $ <eq:term-5>
With eqs. @eq:term-1 to @eq:term-5 inserted, eq. @eq:norm reads
$
  braket(phi_2, phi_2) & = 2 D c_1^2 + 2 bp^2 c_1 c_3 + 2 bp^2 c_2^2 + 2 bp^2 c_3 c_1 + 2 bp^4 c_3^2 \
  & eqby("eq:c2") 2 c_1^2 [D + 2 bp^2 (D + 4)/5 alpha' + bp^2 (sqrt(2 alpha')/5 (D - 1))^2 + bp^4 ((D + 4)/5 alpha')^2] \
  & = 2 c_1^2 [D - (2 D + 8)/5 - 2/25 (D - 1)^2 + (D + 4)^2/25] \
  & = (2 c_1^2)/25 [25 D - 10 D - 40 - 2 D^2 + 4 D - 2 + D^2 + 8 D + 16] \
  & = (2 c_1^2)/25 [27 D - 26 - D^2] = (2 c_1^2)/25 (D - 1)(26 - D) quad < 0 quad "if" D > 26.
$
Thus we find that a theory operating in more than 26 dimensions would suffer from negative norm states, so-called ghosts.

= Some classical lightcone gauge identities

#task[
  Show that in target-space lightcone gauge the constraint $T_(a b) = 0$ implies
  $ partial_plus.minus X^- = l/(2 pi alpha' p^+) (partial_plus.minus X_perp)^2. $
  Show that for the open string with NN boundary conditions the $X^-$ oscillators can be solved for in terms of the transverse oscillators as
  $ alpha_n^- = 1/(sqrt(2 alpha') p^+) 1/2 sum_(m=-infinity)^infinity sum_(i=1)^(D-2) alpha_(n-m)^i alpha_m^i. $
  Note that the sum over oscillators includes $alpha_0^i = sqrt(2 alpha') p^i$.
]

In exercise 1.b) on assignment 2, we varied the Polyakov action w.r.t. the worldsheet metric $h^(a b)$ to obtain the classical equation of motion $T_(a b) = 0$. Moving to lightcone gauge, we found that the constraints $T_(+-) = T_(-+) = 0$ were automatically satisfied due to the requirement of tracelessness imposed on the energy momentum tensor $T_(a b)$ as a direct consequence of Weyl invariance.#footnote[The exact argument here was that $0 limits(=)^! T^a zws_a = h_(a b) T^(a b) = h_(+-) T^(+-) + h_(-+) T^(-+) = 2 h_(+-) T^(+-) = 2(-1/2) T^(+-) = -T^(+-)$, where we used that $h_(++) = h_(--) = 0$, and that $h_(a b)$ and $T_(a b)$ are both symmetric tensors.] The components $T_(+-)$, $T_(-+)$ were a priori non-vanishing and given by
$ T_(a b) = -1/alpha' [partial_a X dot partial_b X - 1/2 h_(a b) h^(c d) partial_c X dot partial_d X] wide limits(==>)^(h_(plus.minus plus.minus) = 0) wide T_(plus.minus plus.minus) = -1/alpha' partial_plus.minus X dot partial_plus.minus X. $ <eq:t-lightcone>
However, we cannot gauge away dynamical information such as $T_(a b) = 0$ (only redundancies in our physical description are affected by gauge transformations). So if it was true in the original worldsheet coordinates $(tau, sigma)$, it must remain true in lightcone coordinates $(xi^+, xi^-)$. Thus when working in lightcone gauge, we have to implement as constraints
$ T_(++) = T_(--) = 0. $ <eq:constraints>
Inserting $partial_plus.minus = 1/2 (partial_tau plus.minus partial_sigma)$ into eq. @eq:t-lightcone and enforcing eq. @eq:constraints gives
$ (partial_tau X plus.minus partial_sigma X)^2 = 0. $ <eq:squared>
This expression becomes useful when we recall that the (flat) ambient space metric $eta_(mu nu)$ in lightcone gauge is given by
$
  lr(#block[$eta_(+-) equiv eta_(0,D-1) = -1 = eta_(D-1,0) equiv eta_(-+)$, \ $eta_(i j) = delta_(i j), quad i, j in {1, ..., D - 2}$,] }) quad "i.e." quad bfeta = mat(0, , , , -1; , 1, , , ; , , dots.down, , ; , , , 1, ; -1, , , , 0),
$
so that the Minkowski product of the string field
$ X^2 = eta_(mu nu) X^mu X^nu = -2 X^+ X^- + sum_(i=1)^(D-2) (X^i)^2 equiv -2 X^+ X^- + X_perp^2, $
where $X^plus.minus = 1/sqrt(2) (X^0 plus.minus X^(D-1))$. Applying this scheme to eq. @eq:squared yields
$ -2 (partial_tau X plus.minus partial_sigma X)^+ (partial_tau X plus.minus partial_sigma X)^- + (partial_tau X plus.minus partial_sigma X)_perp^2 = 0. $ <eq:lightcone-constraint>
The next step is where working in lightcone gauge pays off. Lightcone gauge implies that we are already dealing with a flat worldsheet, i.e. $h_(a b) = eta_(a b)$. However, there is still left a residual reparametrization invariance#footnote[In the lecture notes, this is often referred to as residual conformal symmetry.] generated by the conformal Killing vector fields $epsilon.alt_a$ which fulfill $nabla_a epsilon.alt_b + nabla_b epsilon.alt_a = h_(a b) nabla_c epsilon.alt^c$. We can fix this remaining invariance by transforming into a set of coordinates in which we identify the ambient space dimension $X^+$ with the worldsheet's time dimension $tau$:#footnote[This has several advantages unrelated to our line of thought: By fixing the residual reparametrization invariance, all ghosts and unphysical degrees of freedom are eliminated. The disadvantage is that Lorentz covariance becomes non-manifest, i.e. hard to prove.]
$ X^+ = (2 pi alpha')/l p^+ tau + x^+. $ <eq:x-plus>
This transformation leaves us with
$ partial_tau X^+ = (2 pi alpha')/l p^+ #h(3em) "and" #h(3em) partial_sigma X^+ = 0, $
which we can insert into eq. @eq:lightcone-constraint to get
$ -2 (2 pi alpha')/l p^+ underbrace((partial_tau X plus.minus partial_sigma X)^-, 2 partial_plus.minus X^-) + underbrace((partial_tau X plus.minus partial_sigma X)_perp^2, 4 (partial_plus.minus X_perp)^2) = 0 wide => wide partial_plus.minus X^- = l/(2 pi alpha' p^+) (partial_plus.minus X_perp)^2. $ <eq:identity-1>
This is the first identity we were asked to derive.

For the second one, we recall the open string mode expansion for Neumann boundary conditions at both ends as derived in great detail in exercise 1.b) on assignment 3,
$ X^mu (tau, sigma) = x_0^mu + (2 pi alpha')/l p^mu tau + i sqrt(2 alpha') sum_(n != 0) alpha_n^mu/n e^(-(pi i)/l n tau) cos(pi/l n sigma). $
Differentiation w.r.t. $xi^plus.minus$ yields
$
  partial_plus.minus X^mu (tau, sigma) & = 1/2 (partial_tau X^mu plus.minus partial_sigma X^mu) \
  & = (pi alpha')/l p^mu + pi/l sqrt(alpha'/2) sum_(n != 0) alpha_n^mu e^(-(pi i)/l n tau) cos(pi/l n sigma) minus.plus i pi/l sqrt(alpha'/2) sum_(n != 0) alpha_n^mu e^(-(pi i)/l n tau) sin(pi/l n sigma) \
  & = (pi alpha')/l p^mu + pi/l sqrt(alpha'/2) sum_(n != 0) alpha_n^mu e^(-(pi i)/l n tau) e^(minus.plus (pi i)/l n sigma) \
  & = pi/l sqrt(alpha'/2) sum_(n in ZZ) alpha_n^mu e^(-(pi i)/l n xi^plus.minus),
$
where we used $alpha_0^mu = sqrt(2 alpha') p^mu$ in the last step to consolidate the $n = 0$-term back into the sum. This is indeed the original Fourier series we started with in exercise 1.b) when deriving the string field's mode expansion and thus a good check for consistency. \
Inserting this series into relation @eq:identity-1 between $X^mu$'s lightcone and orthogonal components, we get
$
  partial_plus.minus X^- & = pi/l sqrt(alpha'/2) sum_(m in ZZ) alpha_m^- e^(-(pi i)/l m xi^plus.minus) \
  & limits(=)^! l/(2 pi alpha' p^+) pi^2/l^2 alpha'/2 sum_(i=1)^(D-2) sum_(m in ZZ) alpha_m^i e^(-(pi i)/l m xi^plus.minus) sum_(k in ZZ) alpha_k^i e^(-(pi i)/l k xi^plus.minus) = l/(2 pi alpha' p^+) (partial_plus.minus X_perp)^2.
$
By multiplying both sides of the above equation with $e^((pi i)/l n xi^plus.minus)$ and integrating $xi^plus.minus$ from $-l$ to $l$, this simplifies to
$
  & sum_(m in ZZ) alpha_m^- underbrace(integral_(-l)^l dif xi^plus.minus e^((pi i)/l (n - m) xi^plus.minus), 2 l delta_(n,m)) = l/(2 pi alpha' p^+) pi/l sqrt(alpha'/2) sum_(i=1)^(D-2) sum_(k,m in ZZ) alpha_k^i alpha_m^i underbrace(integral_(-l)^l dif xi^plus.minus e^((pi i)/l (n - m - k) xi^plus.minus), 2 l delta_(n-m,k)) \
  & => alpha_n^- = 1/(sqrt(2 alpha') p^+) 1/2 sum_(i=1)^(D-2) sum_(m in ZZ) alpha_(n-m)^i alpha_m^i.
$
Thus for the open string with Neumann boundary conditions, all those lightcone modes $alpha_n^-$ that were not gauged into oblivion by @eq:x-plus can be expressed in terms of the transverse modes $alpha_n^i$, $i in {1, ..., D - 2}$. From this fact, we can infer that the lightcone dimensions don't actually contain any physical degrees of freedom but are pure gauge material.
