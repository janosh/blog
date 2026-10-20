#import "/notes.typ": dd, notes, tagged, task

#show: notes.with(
  title: [Quantum Field Theory II -- Assignment 3],
  subtitle: [Exercise sheet 3, Advanced QFT, Prof. Jürgen Berges],
  date: [Solutions by Janosh Riebesell, 01.05.2015],
)

// path integral measure
#let Dm = $cal(D)$
#let ex(x) = $chevron.l #x chevron.r_0$

= Problem 3.1 (Wick's theorem reloaded)

#task[
  In the lecture, we have defined
  #tagged(1, $ ex(phi(x_1) dots phi(x_n)) := e^(1/2 delta/(delta phi) D_F delta/(delta phi)) phi(x_1) dots phi(x_n) |_(phi = 0). $)
  Use this expression to prove Wick's theorem, i.e. show that
  $ ex(phi(x_1) dots phi(x_(2n))) = D_F (x_1 - x_2) D_F (x_3 - x_4) dots D_F (x_(2n-1) - x_(2n)) + "'all other contractions'". $
  _Hint:_ First show that
  #tagged(2, $ ex(phi(x_1) dots phi(x_(2n))) = 1/(2^n n!) sum_sigma D_F (x_(sigma_1) - x_(sigma_2)) D_F (x_(sigma_3) - x_(sigma_4)) dots D_F (x_(sigma_(2n-1)) - x_(sigma_(2n))), $)
  where the sum is over all permutations $sigma$ of $2n$ elements, and then bring this into the required form.
]

$
  ex(phi(x_1) dots phi(x_(2n))) & := e^(1/2 delta/(delta phi) D_F delta/(delta phi)) phi(x_1) dots phi(x_(2n)) |_(phi = 0) = sum_(k=0)^oo 1/k! (1/2 delta/(delta phi) D_F delta/(delta phi))^k product_(i=1)^(2n) phi(x_i) |_(phi = 0) \
  & = sum_(k=0)^n 1/(2^k k!) (delta/(delta phi) D_F delta/(delta phi))^k product_(i=1)^(2n) phi(x_i) |_(phi = 0) = 1/(2^n n!) (delta/(delta phi) D_F delta/(delta phi))^n product_(i=1)^(2n) phi(x_i),
$
where all terms with $k > n$ vanish since they contain a larger number of functional derivatives $delta/(delta phi)$ than fields $phi$. On the other hand, all terms with $k < n$ contain more fields than functional derivatives so that, regardless of the prefactors containing powers of $D_F$, they too will vanish when setting $phi$ to zero. Only $k = n$ survives, for which we insert the functional inner product given by
$ delta/(delta phi) D_F delta/(delta phi) := integral dd(y_1) dif y_2 delta/(delta phi(y_1)) D_F (y_1 - y_2) delta/(delta phi(y_2)) $
to get
$ ex(phi(x_1) dots phi(x_(2n))) = 1/(2^n n!) product_(j=1)^n integral dd(y_j) dif y_(j+n) delta/(delta phi(y_j)) D_F (y_j - y_(j+n)) delta/(delta phi(y_(j+n))) underbrace(product_(i=1)^(2n) phi(x_i), product_(j=1)^n phi(x_j) phi(x_(j+n))). $
Now we let the $2n$ functional derivatives act on the $2n$ fields. During the process, we are careful to obey the product rule which gives a sum over all permutations of field and derivative coordinates such that
$
  ex(phi(x_1) dots phi(x_(2n))) & = 1/(2^n n!) product_(j=1)^n sum_sigma integral dd(y_j) dif y_(j+n) underbrace((delta phi(x_(sigma_j)))/(delta phi(y_(sigma_j))), delta(x_(sigma_j) - y_(sigma_j))) D_F (y_(sigma_j) - y_(sigma_(j+n))) underbrace((delta phi(x_(sigma_(j+n))))/(delta phi(y_(sigma_(j+n)))), delta(x_(sigma_(j+n)) - y_(sigma_(j+n)))) \
  & = 1/(2^n n!) product_(j=1)^n sum_sigma D_F (x_(sigma_j) - x_(sigma_(j+n))) = 1/(2^n n!) sum_sigma product_(j=1)^n D_F (x_(sigma_j) - x_(sigma_(j+n))).
$
The sum over permutations still contains a lot of redundancy. Not only is every distinct possibility of contracting the fields represented $2^n$ times in this sum because $D_F (x_i - x_j) = D_F (x_j - x_i)$, but also $n!$ times because every possible order in which the Feynman propagators could appear is also accounted for. Since
$
  & D_F (x_1 - x_2) dots D_F (x_(i_1) - x_(j_1)) dots D_F (x_(i_2) - x_(j_2)) dots D_F (x_(2n-1) - x_(2n)) \
  & = D_F (x_1 - x_2) dots D_F (x_(i_2) - x_(j_2)) dots D_F (x_(i_1) - x_(j_1)) dots D_F (x_(2n-1) - x_(2n)),
$
we can get rid of this redundancy by letting it cancel with the prefactor $1/(2^n n!)$:
$
  ex(phi(x_1) dots phi(x_(2n))) & = sum_("distinct" \ "contractions") product_(j=1)^n D_F (x_(sigma_j) - x_(sigma_(j+n))) \
  & = D_F (x_1 - x_2) D_F (x_3 - x_4) dots D_F (x_(2n-1) - x_(2n)) + "'all other contractions'".
$

= Problem 3.2 (Two-point function and functional determinant for a free theory)

#task[
  In this exercise we will evaluate the two-point function
  #tagged(3, $ chevron.l Omega | T phi(x_1) phi(x_2) | Omega chevron.r = lim_(T -> oo) (integral Dm phi thin phi(x_1) phi(x_2) e^(i S[phi]))/(integral Dm phi thin e^(i S[phi])) $)
  for the free real scalar field theory,
  #tagged(4, $ S[phi] = integral dd(4, x) cal(L) = integral dd(4, x) 1/2 (partial_mu phi partial^mu phi - (m^2 - i epsilon) phi^2), $)
  by means of path integral techniques. To evaluate the path integral, we first introduce a UV- and IR-cutoff, i.e. we discretize space and restrict it to a finite volume. Therefore, we get
  $
    Dm phi & = product_i dif phi(x_i), && quad "(prefactors omitted since we calculate ratios in eq. (3))" \
    phi(x_i) & = 1/V sum_n e^(-i k_n x_i) hat(phi)(k_n), && quad "(sum over" n "finite due to UV-cutoff)"
  $
  where $k_n^mu = (2 pi n^mu)/L$ with $n^mu in ZZ$, $|k^mu| < pi/a$ and $V = L^4$. $L$ and $a$ are the order parameters of volume and lattice spacing, respectively.
]

#task(label: "a")[
  Why is the measure, when we go to Fourier space, given by
  #tagged(5, $ Dm phi(x) = J product_(k_n^0 > 0) dif "Re" hat(phi)(k_n) dif "Im" hat(phi)(k_n), $)
  with some constant $J$, and not by (5) with $k_n^0$ unconstrained?
]

Since $phi(x) in RR thick forall x$ is real, we have $hat(phi)(-k_n) = hat(phi)^* (k_n)$. Therefore, $Dm phi(x) = J product_(k_n^0 > 0) dif "Re" hat(phi)(k_n) dif "Im" hat(phi)(k_n)$ already integrates over all d.o.f. Leaving $k_n^0$ unconstrained amounts to treating a complex field.

#task(label: "b")[
  By proceeding as in problem 2.2 d) and e), show that
  #tagged(6, $ integral Dm phi thin e^(i S[phi]) = J product_(k_n^0 > 0) sqrt((-i pi V)/(m^2 - i epsilon - k_n^2)) sqrt((-i pi V)/(m^2 - i epsilon - k_n^2)) = J product_("all" k_n) sqrt((-i pi V)/(m^2 - i epsilon - k_n^2)). $)
  _Hint:_ Use (or show) that for $"Re"(b) > 0$, the Gaussian integral $integral_(-oo)^oo dd(x) e^(-b x^2)$ is well-defined and gives $sqrt(pi/b)$. Argue why this theorem is applicable here.
]

We start by writing the action given in eq. (4) in a discretized form and transforming it to Fourier space
$
  S[phi] & = integral dd(4, x) cal(L) = integral dd(4, x) 1/2 (partial_mu phi partial^mu phi - (m^2 - i epsilon) phi^2) -> sum_i 1/2 (partial/(partial x^i) phi(x_i) partial/(partial x_i) phi(x_i) - (m^2 - i epsilon) phi^2 (x_i)), \
  S[hat(phi)] & = sum_i 1/2 (partial/(partial x^i) 1/V sum_n e^(-i k_n x_i) hat(phi)(k_n) partial/(partial x_i) 1/V sum_m e^(-i k_m x_i) hat(phi)(k_m) - (m^2 - i epsilon) 1/V^2 sum_(n,m) e^(-i(k_n + k_m) x_i) hat(phi)(k_n) hat(phi)(k_m)) \
  & = 1/(2 V^2) sum_(n,m) \((-i k_n)(-i k_m) hat(phi)(k_n) hat(phi)(k_m) underbrace(sum_i e^(-i(k_n + k_m) x_i), V delta_(k_n, -k_m)) - (m^2 - i epsilon) hat(phi)(k_n) hat(phi)(k_m) underbrace(sum_i e^(-i(k_n + k_m) x_i), V delta_(k_n, -k_m))\) \
  & = 1/(2V) sum_n \((-i k_n) i k_n hat(phi)(k_n) underbrace(hat(phi)(-k_n), hat(phi)^dagger (k_n)) - (m^2 - i epsilon) hat(phi)(k_n) underbrace(hat(phi)(-k_n), hat(phi)^dagger (k_n))\) = 1/(2V) sum_n (k_n^2 - (m^2 - i epsilon)) |hat(phi)(k_n)|^2,
$
where $hat(phi)(-k_n) = hat(phi)^dagger (k_n)$ ensures that $phi(x_i) = 1/V sum_n e^(-i k_n dot x) hat(phi)(k_n)$ is self-adjoint, i.e.
$ phi^dagger (x_i) = 1/V sum_n e^(+i k_n dot x) hat(phi)^dagger (k_n) attach(=, t: n -> -n) 1/V sum_(-n) e^(-i k_n x_i) underbrace(hat(phi)^dagger (-k_n), hat(phi)(k_n)) = phi(x_i), quad "with" k_(-n)^mu = (2 pi (-n^mu))/L = -k_n^mu. $
We can now insert the Fourier space action into the path integral, writing $|hat(phi)(k_n)|^2$ as $"Re"^2 hat(phi)(k_n) + "Im"^2 hat(phi)(k_n)$, using that the sum over all $n$ in the exponent pairs up $k_n$ and $k_(-n)$,
$ sum_n (k_n^2 - (m^2 - i epsilon)) = sum_(n > 0) (k_n^2 - (m^2 - i epsilon)) + \(underbrace(k_(-n)^2, k_n^2) - (m^2 - i epsilon)\) = 2 sum_(n > 0) (k_n^2 - (m^2 - i epsilon)), $
and using the Gaussian integral to solve
$
  integral Dm phi thin e^(i S[phi]) & = integral J product_(k_n^0 > 0) dif "Re" hat(phi)(k_n) dif "Im" hat(phi)(k_n) e^(i/(2V) sum_n (k_n^2 - (m^2 - i epsilon)) ("Re"^2 hat(phi)(k_n) + "Im"^2 hat(phi)(k_n))) \
  & = J product_(k_n^0 > 0) integral dif "Re" hat(phi)(k_n) e^(-i/V (m^2 - i epsilon - k_n^2) "Re"^2 hat(phi)(k_n)) integral dif "Im" hat(phi)(k_n) e^(-i/V (m^2 - i epsilon - k_n^2) "Im"^2 hat(phi)(k_n)) \
  & = J product_(k_n^0 > 0) sqrt(pi/(i/V (m^2 - i epsilon - k_n^2))) underbrace(sqrt(pi/(i/V (m^2 - i epsilon - k_n^2))), k_n -> -k_n) = J product_("all" k_n) sqrt((-i pi V)/(m^2 - i epsilon - k_n^2)).
$
We used the Gaussian integral in the second-to-last step with $b = i/V (m^2 - i epsilon - k_n^2)$. As to its applicability, we note that since $epsilon > 0$ is a positive constant we have that
$ "Re"(b) = "Re"(1/V (epsilon + i(m^2 - k_n^2))) = epsilon/V > 0. $

#task(label: "c")[
  Before we continue with the two-point function, we want to relate eq. (6) with the functional determinant. To do so, convince yourself that
  #tagged(7, $ (product_k integral dd(xi_k)) e^(-xi_i B^(i j) xi_j) = product_i sqrt(pi/b^i) = "const"/sqrt(det B) $)
  for some symmetric positive definite $N times N$-matrix (more generally, it suffices that the eigenvalues have a positive real part) and $arrow(xi) in RR^N$. _Hint:_ Do an integral transformation to go to the diagonal space of $B$.
]

Every real symmetric matrix $B$ can be diagonalized in the form
$ B = Q D Q^T, $
where $D$ is diagonal and $Q$ is an orthogonal matrix satisfying $Q^T = Q^(-1)$ and hence
$ 1 = det(bb(1)_N) = det(Q^T Q) = det(Q^T) det(Q) = scripts(det)^2 (Q) quad ==> quad det(Q) = plus.minus 1. $
Following the hint, we now transform the integral
$
  (product_(k=1)^N integral dd(xi_k)) e^(-xi_i B^(i j) xi_j) & = integral dd(N, arrow(xi)) e^(-arrow(xi)^T B arrow(xi)) = integral dd(N, arrow(xi)) e^(-arrow(xi)^T overbrace(Q Q^T, bb(1)_N) B overbrace(Q Q^T, bb(1)_N) arrow(xi)) = integral dd(N, arrow(xi)) e^(-underbrace((Q^T arrow(xi))^T, = arrow(zeta)^T) D underbrace((Q^T arrow(xi)), = arrow(zeta))) \
  & = integral dd(N, arrow(zeta)) underbrace(|det(Q)|, 1) e^(-arrow(zeta)^T D arrow(zeta)) = (product_(k=1)^N integral dd(zeta_k)) e^(-zeta_i D^(i j) zeta_j) = (product_(k=1)^N integral dd(zeta_k)) e^(-b^i zeta_i^2),
$
with $arrow(zeta) = Q^T arrow(xi)$, where all the eigenvalues $b_i$ are real and positive, i.e. $"Re"(b_i) > 0 thick forall i$, so that we may again evaluate the above expression as a Gaussian integral
$ (product_(k=1)^N integral dd(xi_k)) e^(-xi_i B^(i j) xi_j) = product_(k=1)^N integral dd(zeta_k) e^(-b^k zeta_k^2) = product_(k=1)^N sqrt(pi/b^k) = "const"/sqrt(det B), quad "where" "const" = pi^(N/2). $

#task(label: "d")[
  Now rewrite the action in eq. (4) into the form
  $ S[phi] = phi dot D dot phi + "surface terms" $
  with $D$ some differential operator and argue in analogy to c) that
  $ integral Dm phi thin e^(i S[phi]) = "const"/sqrt(det D). $
  Further, give the differential operator $D$. _Hint:_ You can neglect the surface terms in your argument because we are assuming natural boundary conditions.
]

The action $S[phi]$ can be brought into the required form using partial integration
$
  S[phi] & = integral dd(4, x) 1/2 (partial_mu phi(x) partial^mu phi(x) - (m^2 - i epsilon) phi^2 (x)) \
  & = integral dd(4, x) phi(x) 1/2 (-partial_x^2 - (m^2 - i epsilon)) phi(x) + 1/2 e_mu phi(x) partial^mu phi(x) |_"surface" \
  & = i integral dd(4, x) integral dd(4, y) phi(x) i/2 (partial_y^2 + (m^2 - i epsilon)) delta(x - y) phi(y) + 1/2 e_mu phi(x) partial^mu phi(x) |_"surface" \
  & = i phi dot D dot phi + "surface terms", quad "with" D = i/2 (partial_y^2 + m^2 - i epsilon) delta(x - y) = D(x - y), \
  integral Dm phi thin e^(i S[phi]) & attach(=, t: "neglecting" \ "surface terms") (integral product_i dif phi(x_i)) e^(-phi dot D dot phi) attach(=, t: "using eq. (7)") "const"/sqrt(det D).
$

#task(label: "e")[
  After this short interlude, we want to calculate the numerator on the right hand side of eq. (3). Therefore, use the same regularization as for the denominator and go again to Fourier space. Then integrate out the Fourier coefficients. You should find the following expression for the numerator:
  #tagged(8, $ integral Dm phi thin phi(x_1) phi(x_2) e^(i S[phi]) = J/V^2 sum_m e^(-i k_m (x_1 - x_2)) (-i V)/(m^2 - i epsilon - k_m^2) (product_(k_n^0 > 0) (-i pi V)/(m^2 - i epsilon - k_n^2)). $)
  Now take the ratio of eqs. (8) and (6) and explain why it should actually be
  $ integral (dd(4, k))/(2 pi)^4 i/(k^2 - m^2 + i epsilon) e^(-i k (x_1 - x_2)). $
  _Hint:_ To evaluate the path integral, you will need also the higher moments of the Gaussian integral.
]

We now leave the path laid out by the exercise and pursue a shorter and more elegant way of proving eq. (8) by introducing a physically meaningless but useful source $J(x)$. Doing so allows us to reformulate the path integral at hand as
$
  I & := integral Dm phi thin phi(x_1) phi(x_2) e^(i S[phi]) = integral Dm phi thin phi(x_1) phi(x_2) e^(i S[phi] + J dot phi) |_(J = 0) \
  & = integral Dm phi thin delta/(delta J(x_1)) delta/(delta J(x_2)) e^(-phi dot D dot phi + J dot phi) |_(J = 0) = delta/(delta J(x_1)) delta/(delta J(x_2)) integral Dm phi thin e^(-phi dot D dot phi + J dot phi) |_(J = 0).
$
The exponent can now be rewritten by completing the square
$ -phi dot D dot phi + J dot phi = -underbrace((phi - 1/2 D^(-1) J), phi') dot D dot underbrace((phi - 1/2 D^(-1) J), phi') + 1/4 J dot D^(-1) J. $
We can thus transform the integral from $phi -> phi' = phi - 1/2 D^(-1) J$ and $Dm phi -> Dm phi' = Dm phi$ to achieve the same Gaussian integral we calculated in part d) times an exponential of $J(x)$ unaffected by the path integration:
$
  I & = delta/(delta J(x_1)) delta/(delta J(x_2)) e^(1/4 J dot D^(-1) J) underbrace(integral Dm phi' e^(-phi' dot D dot phi'), sqrt(pi^n/(det D))) |_(J = 0) \
  & = sqrt(pi^n/(det D)) delta/(delta J(x_1)) 1/4 (integral dd(4, x) integral dd(4, y) underbrace((delta J(x))/(delta J(x_2)), delta(x - x_2)) D^(-1) (x - y) J(y) + J(x) D^(-1) (x - y) underbrace((delta J(y))/(delta J(x_2)), delta(y - x_2))) e^(1/4 J dot D^(-1) J) |_(J = 0) \
  & = sqrt(pi^n/(det D)) 1/4 ((integral dd(4, y) D^(-1) (x_2 - y) underbrace((delta J(y))/(delta J(x_1)), delta(y - x_1)) + integral dd(4, x) underbrace((delta J(x))/(delta J(x_1)), delta(x - x_1)) D^(-1) (x - x_2)) e^(1/4 J dot D^(-1) J) + #box(baseline: 40%, text(size: 8pt)[second term from \ product rule that \ vanishes when $J -> 0$])) |_(J = 0) \
  & = sqrt(pi^n/(det D)) 1/4 (D^(-1) (x_1 - x_2) + D^(-1) (x_2 - x_1)),
$
where $D^(-1)$ can be shown to be $2 D_F$, $D_F$ the Feynman propagator:
$
  integral dd(4, y) D(x - y) 2 D_F (y - z) & = integral dd(4, y) i/2 (partial_y^2 + (m^2 - i epsilon)) delta(x - y) 2 integral (dd(4, p))/(2 pi)^4 (i e^(-i p (y - z)))/(p^2 - m^2 + i epsilon) \
  & = -integral (dd(4, p))/(2 pi)^4 (partial_x^2 + (m^2 - i epsilon)) e^(-i p (x - z))/(p^2 - m^2 + i epsilon) = integral (dd(4, p))/(2 pi)^4 (p^2 - (m^2 - i epsilon)) e^(-i p (x - z))/(p^2 - m^2 + i epsilon) \
  & = integral (dd(4, p))/(2 pi)^4 e^(-i p (x - z)) = delta^((4)) (x - z).
$
Taking into account that $D_F (x_1 - x_2) = D_F (x_2 - x_1)$, we may simplify $I$:
$ I = sqrt(pi^n/(det D)) 1/4 (2 D_F (x_1 - x_2) + 2 D_F (x_2 - x_1)) = sqrt(pi^n/(det D)) D_F (x_1 - x_2). $
Now taking the ratio of our results of part e) and d), we get the following expression for the two-point function of the free real scalar field:
$ chevron.l Omega | T phi(x_1) phi(x_2) | Omega chevron.r = lim_(T -> oo) (integral Dm phi thin phi(x_1) phi(x_2) e^(i S[phi]))/(integral Dm phi thin e^(i S[phi])) = (sqrt(pi^n/(det D)) D_F (x_1 - x_2))/sqrt(pi^n/(det D)) = D_F (x_1 - x_2). $
_Remark:_ Unfortunately, even though being shorter and more elegant, our way of introducing a source $J$ to arrive at the above result completely evades the point of this exercise, which is to show that the result also holds when restricting and discretizing space.
