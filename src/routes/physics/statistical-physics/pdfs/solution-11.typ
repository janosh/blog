#import "/notes.typ": task, vb, eps, kB, tr, ev, ket, eqby
#import "/statistical-physics/sheet.typ": points, sheet, cF, cH, cP, hH, hN, ni
#import "@preview/cetz:0.5.2": canvas
#import "@preview/cetz-plot:0.1.4": plot

#show: sheet.with(11, [January 27th, 2017])

#let bk = $vb(k)$

// occupation number fluctuations of a single bosonic (left) and fermionic (right) mode as a
// function of temperature at fixed eps_k - mu = 1 (k_B = 1)
#let fluctuation-plots = grid(
  columns: 2,
  column-gutter: 1.5em,
  canvas(plot.plot(
    size: (5.2, 4),
    x-label: $T$,
    y-label: $Delta n_k^+$,
    x-tick-step: 1,
    y-tick-step: 5,
    axis-style: "school-book",
    y-min: 0,
    y-max: 17.5,
    plot.add(t => 1 / calc.pow(2 * calc.sinh(1 / (2 * t)), 2), domain: (0.05, 4.15), samples: 200, style: (stroke: blue + 0.8pt)),
  )),
  canvas(plot.plot(
    size: (5.2, 4),
    x-label: $T$,
    y-label: $Delta n_k^-$,
    x-tick-step: 1,
    y-tick-step: 0.05,
    axis-style: "school-book",
    y-min: 0,
    y-max: 0.27,
    plot.add(t => 1 / (2 * calc.cosh(1 / t) + 2), domain: (0.05, 4.3), samples: 200, style: (stroke: blue + 0.8pt)),
  )),
)

#let log-divergence = canvas(plot.plot(
  size: (5.5, 4),
  x-label: $z$,
  y-label: none,
  x-tick-step: 0.2,
  y-tick-step: 1,
  axis-style: "school-book",
  legend: "inner-north-west",
  y-min: 0,
  y-max: 5.6,
  x-min: 0,
  x-max: 1.05,
  plot.add(z => -calc.ln(1 - z), domain: (0, 0.9963), samples: 300, style: (stroke: blue + 0.8pt), label: $-ln(1 - z)$),
))

= Symmetric states #points(1)

#task[
  The (anti-)symmetrized many-particle states are defined as
  $ ket(alpha_1\, ...\, alpha_n)_plus.minus = cP_plus.minus ket(alpha_1) times.o dots.c times.o ket(alpha_n) = 1/n! sum_(pi in S_n) (plus.minus 1)^pi ket(alpha_(pi(1))) times.o dots.c times.o ket(alpha_(pi(n))) $
  Show that
  $ ket(alpha_1\, alpha_2\, alpha_3)_- = -ket(alpha_2\, alpha_1\, alpha_3)_- $ <eq:anti>
  $ ket(alpha_1\, alpha_2\, alpha_3)_+ = +ket(alpha_2\, alpha_1\, alpha_3)_+. $ <eq:sym>
]

Written out explicitly, the states @eq:anti and @eq:sym are
$
  ket(alpha_1\, alpha_2\, alpha_3)_plus.minus = 1/3! ( & ket(alpha_1) times.o ket(alpha_2) times.o ket(alpha_3) plus.minus ket(alpha_1) times.o ket(alpha_3) times.o ket(alpha_2) plus.minus ket(alpha_2) times.o ket(alpha_1) times.o ket(alpha_3) \
  & + ket(alpha_2) times.o ket(alpha_3) times.o ket(alpha_1) + ket(alpha_3) times.o ket(alpha_1) times.o ket(alpha_2) plus.minus ket(alpha_3) times.o ket(alpha_2) times.o ket(alpha_1)).
$
Exchanging $ket(alpha_1)$ and $ket(alpha_2)$, we get
$
  ket(alpha_2\, alpha_1\, alpha_3)_plus.minus & = 1/3! ( ket(alpha_2) times.o ket(alpha_1) times.o ket(alpha_3) plus.minus ket(alpha_2) times.o ket(alpha_3) times.o ket(alpha_1) plus.minus ket(alpha_1) times.o ket(alpha_2) times.o ket(alpha_3) \
  & #h(3em) + ket(alpha_1) times.o ket(alpha_3) times.o ket(alpha_2) + ket(alpha_3) times.o ket(alpha_2) times.o ket(alpha_1) plus.minus ket(alpha_3) times.o ket(alpha_1) times.o ket(alpha_2)) \
  & = plus.minus 1/3! ( ket(alpha_1) times.o ket(alpha_2) times.o ket(alpha_3) plus.minus ket(alpha_1) times.o ket(alpha_3) times.o ket(alpha_2) plus.minus ket(alpha_2) times.o ket(alpha_1) times.o ket(alpha_3) \
  & #h(3em) + ket(alpha_2) times.o ket(alpha_3) times.o ket(alpha_1) + ket(alpha_3) times.o ket(alpha_1) times.o ket(alpha_2) plus.minus ket(alpha_3) times.o ket(alpha_2) times.o ket(alpha_1)) \
  & = plus.minus ket(alpha_1\, alpha_2\, alpha_3)_plus.minus.
$

= Number fluctuations #points(2)

#task[
  Consider the occupation probability
  $ ev(n_k)_g = -1/beta partial/(partial eps_k) ln(Z_g) $ <eq:occupation>
  of a single mode $k$ both in an ideal Bose and Fermi gas in the grand canonical ensemble. Compute the fluctuations of the occupation probability, $ev(n_k^2) - ev(n_k)^2$, and express it in terms of $ev(n_k)$. Show that the fluctuations of the total particle number $Delta N = ev(N^2) - ev(N)^2$ scale linearly with volume.
]

Ideal quantum gases are systems containing a large number of non-interacting particles. Each individual particle occupies a state that is in no way altered from that of a solitary particle. The total energy is simply the sum of individual particle energies. Quantum gases thus form tensor products of states out of a single-particle Hilbert space $cH$, making them perfectly suited for a description i.t.o. elements of a Fock space $cF_plus.minus$. In order to compute the statistics of such systems, we first need the grand partition function $Z_g^plus.minus$. \
Computing it requires a basis for $cF_plus.minus$. The occupation number basis consists of states of the form
$
  ni(plus.minus) = ket(n_0\, n_1\, n_2\, ...)_plus.minus & = cP_plus.minus times.o.big_(i=0)^infinity ket(psi_i)^(times.o n_i) \
  & = cP_plus.minus ket(psi_0)^(times.o n_0) times.o ket(psi_1)^(times.o n_1) times.o ....
$ <eq:occupation-basis>
It draws upon a single-particle basis ${ket(psi_n)}_(n in NN_0)$ of $cH$ to denote with $n_i$ the number of particles in state $ket(psi_i)$ with $i in NN_0$ where $i$ labels all basis elements of $cH$.#footnote[We are working exclusively with separable Hilbert spaces here. This guarantees that even if the number of basis vectors becomes infinite, they remain countable since any separable Hilbert space $cH$ contains a countable subset with countable basis whose span is dense in $cH$.] \
States of the form @eq:occupation-basis offer the huge advantage that they are eigenstates of both the number operator $hN$ and the Hamiltonian $hH$ on $cF_plus.minus$:
$ hN ket(n_0\, n_1\, ...\, n_k)_plus.minus = sum_(i=0)^infinity n_i ket(n_0\, n_1\, ...\, n_k)_plus.minus, $ <eq:n-eigen>
$ hH ket(n_0\, n_1\, ...\, n_k)_plus.minus = sum_(i=0)^infinity n_i eps_i ket(n_0\, n_1\, ...\, n_k)_plus.minus. $ <eq:h-eigen>
$eps_i$ here denotes the energy of the single-particle state $ket(psi_i)$. \
Equipped with a basis, we can calculate the grand partition function on $cF_plus.minus$ as the trace over the grand canonical weighting factor,
$ Z_g^plus.minus = tr_(cF_plus.minus) (e^(-beta (hH - mu hN))) = sum_(N=0)^infinity sum_({n_i}_i^plus.minus) lr(chevron.l {n_i}_i^plus.minus |e^(-beta (hH - mu hN))| {n_i}_i^plus.minus chevron.r) delta_(N, sum n_i). $
This is a rather complicated sum running over all possible combinations of occupation numbers $n_i$ of all single-particle states $ket(psi_i) in cH$. The Kronecker symbol ensures that in each term of the sum over $N$ only configurations with the correct number of total particles appear. If we had instead chosen to work in the canonical ensemble, we would still have this restriction but the sum over $N$ (and the fugacity $z^hN = e^(beta mu hN)$), would be absent from the partition function, making the evaluation of $Z_c$ extremely difficult. The sum over all possible number of particles turns out to be a crucial advantage of the grand canonical ensemble when it comes to quantum gases. \
We make full use of it by dropping both the sum over $N$ and the Kronecker symbol. This lets the $n_i$ roam freely, so to speak. We still sum over all possibilities of distributing an arbitrary number of particles (up to infinitely many) onto the single-particle states in $cH$, thus still taking into account every possible value for the total particle number $N$. By furthermore using @eq:n-eigen and @eq:h-eigen, $Z_g^plus.minus$ factorizes into
$
  Z_g^plus.minus & = sum_({n_i}_i^plus.minus) e^(-beta sum_(j=0)^infinity n_j (eps_j - mu)) underbrace(chevron.l {n_i}_i^plus.minus | {n_i}_i^plus.minus chevron.r, = 1) \
  & = sum_(n_0^plus.minus = 0)^(infinity "or" 1) sum_(n_1^plus.minus = 0)^(infinity "or" 1) sum_(n_2^plus.minus = 0)^(infinity "or" 1) dots.c product_(j=0)^infinity e^(-beta n_j (eps_j - mu)) = product_(j=0)^infinity sum_(n_j^plus.minus = 0)^(infinity "or" 1) e^(-beta n_j (eps_j - mu)).
$
For fermions, the sum over $n_j^-$ contains only two terms,
$ Z_g^- = product_(j=0)^infinity (1 + e^(-beta (eps_j - mu))), $ <eq:z-fermi>
while for bosons, we may use the geometric series to get
$ Z_g^+ = product_(j=0)^infinity 1/(1 - e^(-beta (eps_j - mu))). $ <eq:z-bose>
There is an important point to consider here. The geometric series will only converge if $eps_j - mu > 0 thick forall j$, i.e. if all single-particle energies are larger than the chemical potential. Since the single-particle spectrum is bounded from below, we may choose the ground state energy $eps_0 = 0$. Then the bosonic grand partition function can only be computed in this way for systems with $mu < 0$ to ensure $eps_j - mu > 0 thick forall j$. For fermions, due to their capped occupation number, $mu$ remains unrestricted. \
Now that we have an explicit expression for $Z_g^plus.minus$, we can use it to calculate occupation numbers for all single-particle states by differentiating w.r.t. that state's energy as in @eq:occupation. To see this, note that
$
  ev(n_k)_plus.minus & = 1/Z_g^plus.minus tr_(cF_plus.minus) (n_k e^(-beta (hH - mu hN))) = 1/Z_g^plus.minus product_(j=0)^infinity sum_(n_j) n_k e^(-beta n_j (eps_j - mu)) \
  & = 1/Z_g^plus.minus product_(j=0)^infinity sum_(n_j) (-1/beta partial/(partial eps_k)) e^(-beta n_j (eps_j - mu)) = -1/beta 1/Z_g^plus.minus partial/(partial eps_k) Z_g^plus.minus = -1/beta partial/(partial eps_k) ln(Z_g^plus.minus).
$
Inserting @eq:z-fermi and @eq:z-bose gives
$
  ev(n_k)_plus.minus & = plus.minus 1/beta partial/(partial eps_k) sum_(j=0)^infinity ln(1 minus.plus e^(-beta (eps_j - mu))) = plus.minus 1/beta 1/(1 minus.plus e^(-beta (eps_k - mu))) partial/(partial eps_k) (minus.plus e^(-beta (eps_k - mu))) \
  & = e^(-beta (eps_k - mu))/(1 minus.plus e^(-beta (eps_k - mu))) = 1/(e^(beta (eps_k - mu)) minus.plus 1).
$
These are the familiar Bose-Einstein and Fermi-Dirac distributions, respectively. \
To obtain fluctuations of the occupation number, we need $ev(n_k^2)$. Just like $ev(n_k)$, we can compute it by differentiation,
$ ev(n_k^2)_plus.minus = 1/beta^2 1/Z_g^plus.minus (partial^2)/(partial eps_k^2) Z_g^plus.minus = (e^(beta (eps_k - mu)) + 1)/(e^(beta (eps_k - mu)) minus.plus 1)^2 = (e^(beta (eps_k - mu)) + 1) ev(n_k)_plus.minus^2. $
This results in the bosonic respectively fermionic fluctuations
$
  Delta n_k^plus.minus & = ev(n_k^2)_plus.minus - ev(n_k)_plus.minus^2 = (e^(beta (eps_k - mu)) + 1) ev(n_k)_plus.minus^2 - ev(n_k)_plus.minus^2 \
  & = e^(beta (eps_k - mu)) ev(n_k)_plus.minus^2 = ev(n_k)_plus.minus (1 plus.minus ev(n_k)_plus.minus),
$ <eq:fluctuations>
where we used $e^(beta (eps_k - mu)) = 1 \/ ev(n_k)_plus.minus plus.minus 1$. For $eps_k - mu >> kB T$, $Delta n_k^plus.minus approx e^(-beta (eps_k - mu))$, so fluctuations are strongly suppressed for states of energy much bigger than the chemical potential. For fermions, where $ev(n_k)_-$ is limited to at most one particle, @eq:fluctuations shows that even for high temperatures, thermal fluctuations remain small, $Delta n_k^- <= 1 \/ 4$, whereas for bosons they grow without bound with increasing temperature. We can plot $Delta n_k^plus.minus$ as functions of $T$ for constant $eps_k - mu > 0$ to confirm this.
#align(center, fluctuation-plots)
Note that $Delta n_k^-$ is bounded by $1 \/ 4$ as $T -> infinity$. We can understand why if we write it as a function of $beta$, $eps_k$, and $mu$ explicitly,
$ Delta n_k^- = 1/(2 cosh[beta (eps_k - mu)] + 2), $
which approaches $1 \/ 4$ as $beta -> 0$ because $cosh(0) = 1$. Writing out $Delta n_k^+$ gives
$ Delta n_k^+ = 1/[2 sinh(beta/2 (eps_k - mu))]^2. $
To find the dependence of fluctuations of the total particle number $N = sum_k n_k$ on the volume $V$, we can use that in non-interacting gases, occupation numbers of different modes are uncorrelated, i.e. $ev(n_k n_l) = ev(n_k) ev(n_l)$ for $k != l$. We can therefore decompose the expectation values of $N$ and $N^2$ into sums of expectation values of $n_k$ and $n_k^2$,
$
  Delta N = ev(N^2) - ev(N)^2 & = ev((sum_k n_k)^2) - ev(sum_k n_k)^2 \
  & = ev(sum_k n_k sum_j n_j) - sum_k ev(n_k) sum_j ev(n_j) \
  & = sum_k ev(n_k^2) + sum_(k != j) ev(n_k n_j) - sum_(k != j) ev(n_k) ev(n_j) - sum_k ev(n_k)^2 \
  & = sum_k ev(n_k^2) - sum_k ev(n_k)^2 = sum_k Delta n_k,
$
which is proportional to $V$ because $Delta n_k$ is $V$-independent and the number of modes scales linearly with volume.

= Relativistic Fermi gas #points(4)

#task[
  Consider an ideal Fermi gas in three dimensions with ultra-relativistic dispersion relation $eps(bk) = planck c |bk|$ in a very large volume.
  + Compute the grand canonical potential $Omega$, the average energy and the average number of particles as functions of $T$, $V$, and $mu$.
  + Show that $U = 3 p V$.
  + Determine the Fermi energy and the pressure of the gas at $T = 0$ as functions of density.
]

+ From the fermionic partition function of the ideal quantum gas derived in exercise 2, it is easy to find the grand canonical potential. Let the particles under consideration have spin $s$ and be confined to a box of volume $V = L^3$, then
  $
    Omega^- (T, V, mu) & = -1/beta ln(Z_g^-) eqby("eq:z-fermi") -1/beta sum_j ln(1 + e^(-beta (eps_j - mu))) \
                       & = -g_s/beta sum_(bk in (2 pi)/L ZZ^3) ln(1 + z e^(-beta planck c |bk|)),
  $ <eq:grand-potential-sum>
  where $g_s = 2 s + 1$ is the spin degeneracy and $z = e^(beta mu)$ denotes the fugacity. We used that the sum over single-particle states $ket(psi_j) in cH$ becomes a sum over all possible values for the spin $sigma$ and three-momentum $bk$,
  $ sum_j = sum_(sigma=-s)^s sum_(bk in (2 pi)/L ZZ^3). $
  Considering the problem asymptotically for large volumes, the discrete (Riemann) sum @eq:grand-potential-sum translates into the following integral (we get a measure by multiplying and dividing the term $(2 pi)^3/L^3$ which limits to an infinitesimal volume element of momentum space for $L -> infinity$),
  $
    Omega^- (T, V, mu) & = -g_s/beta V/(2 pi)^3 integral_(RR^3) ln(1 + z e^(-beta planck c |bk|)) dif^3 k \
    & = -g_s/beta V/(2 pi)^3 4 pi integral_0^infinity k^2 ln(1 + z e^(-beta planck c k)) dif k \
    & = -g_s/beta V/(2 pi^2) (-integral_0^infinity k^3/3 ((-z beta planck c) e^(-beta planck c k))/(1 + z e^(-beta planck c k))) dif k \
    & = -g_s/beta V/(6 pi^2) 1/(beta planck c)^3 integral_0^infinity x^3/(z^(-1) e^x + 1) dif x \
    & equiv -g_s/(pi^2 beta) V/(beta planck c)^3 f_4^- (z),
  $ <eq:grand-potential>
  where we transformed to spherical coordinates in the second step, partially integrated with vanishing boundaries in the third, substituted $x = beta planck c k$, $dif x = beta planck c dif k$ in the fourth, and defined the integral function
  $ f_nu^plus.minus (z) = 1/Gamma(nu) integral_0^infinity x^(nu - 1)/(z^(-1) e^x minus.plus 1) dif x, $
  in the last line. \
  The average energy is given by the Hamiltonian's grand canonical expectation value,
  $
    U(T, V, mu) & = ev(hH)_g = 1/Z_g^- tr_cH (hH e^(-beta (hH - mu hN))) \
    & = sum_(sigma=-s)^s sum_bk (planck c |bk|)/(z^(-1) e^(beta planck c |bk|) + 1) limits(-->)^(V -> infinity) g_s V/(2 pi)^3 4 pi integral_0^infinity (planck c k)/(z^(-1) e^(beta planck c k) + 1) k^2 dif k \
    & = g_s/(2 pi^2 beta) V/(beta planck c)^3 integral_0^infinity x^3/(z^(-1) e^x + 1) dif x = (3 g_s)/(pi^2 beta) V/(beta planck c)^3 f_4^- (z)
  $ <eq:energy>
  Finally, the average particle number derives from the number operator's expectation value,
  $
    N(T, V, mu) & = ev(hN)_g = 1/Z_g^- tr_cH (hN e^(-beta (hH - mu hN))) \
    & = sum_(sigma=-s)^s sum_bk ev(n_bk) limits(-->)^(V -> infinity) g_s V/(2 pi)^3 4 pi integral_0^infinity (k^2 dif k)/(z^(-1) e^(beta planck c k) + 1) = g_s/pi^2 V/(beta planck c)^3 f_3 (z).
  $ <eq:particle-number>
  where we used $ev(n_k)_g = (partial Omega^-)/(partial eps(k)) = 1/(z^(-1) e^(beta eps(k)) + 1)$.
+ The pressure is given by the derivative of the grand potential @eq:grand-potential w.r.t. volume,
  $ p = -(partial Omega^-)/(partial V) = g_s/(pi^2 beta) f_4^- (z)/(beta planck c)^3. $ <eq:pressure>
  Comparing @eq:energy and @eq:pressure, we see that
  $ U = 3 p V. $
+ To determine the energy and pressure of a relativistic Fermi gas in the $T -> 0$ limit, we employ an asymptotic expansion of $f_nu^- (z)$ for $ln(z) = beta mu >> 1$,
  $ f_nu^- (e^(beta mu)) = (beta mu)^nu/Gamma(nu + 1) (1 + 2 sum_(j=1)^n (2 j)! binom(nu, 2 j) (1 - 2^(1 - 2 j)) zeta(2 j) (beta mu)^(-2 j) + cal(O)[(beta mu)^(-2 n - 1)]), $
  where $zeta(s) = sum_(n=1)^infinity 1/n^s$, $s in CC$ is the Riemann zeta function. We only need to consider the leading order behaviour,
  $ f_4^- (e^(beta mu)) = (beta mu)^4/4! + cal(O)[(beta mu)^2]. $
  to find that $beta -> infinity$ with $mu$ fixed results in the ground state energy and pressure
  $ E_upright(F) = U(0, V, mu) = g_s/(8 pi^2) (V mu^4)/(planck c)^3, $ <eq:fermi-energy>
  $ p_upright(F) = p(0, V, mu) = g_s/(24 pi^2) mu^4/(planck c)^3. $ <eq:fermi-pressure>
  The reason they are non-zero is the Pauli principle. It prevents identical fermions from occupying the same state more than once. Macroscopic condensation into the ground state as in bosonic systems near absolute zero is therefore impossible. Instead, a Fermi system at $T = 0$ fills up all available energy states from the bottom up, a configuration known as full degeneracy. Adding particles or compressing the system forces the particles into higher-energy states. The necessary energy must be introduced into the system by a compression force performing work against the resisting pressure @eq:fermi-pressure. \
  To express @eq:fermi-energy and @eq:fermi-pressure in terms of the Fermi density, we may again apply the asymptotic expansion of $f_nu^- (e^(beta mu))$, this time to @eq:particle-number to find
  $ rho_upright(F) = 1/V N(0, V, mu) = g_s/(6 pi^2) mu^3/(planck c)^3. $
  Solving for $mu$ gives the Fermi energy $eps_upright(F) = mu(T = 0) = planck c (6 pi^2 rho_upright(F) \/ g_s)^(1\/3) prop rho_upright(F)^(1\/3)$, in terms of which
  $
    E_upright(F) & = 3/4 rho_upright(F) V mu, \
    p_upright(F) & = 1/4 rho_upright(F) mu.
  $
  Note that the Fermi pressure depends exclusively on the density of the fermions, while the ground state energy, being an extensive quantity, also scales linearly with volume.

= Two-dimensional Bose gas #points(3)

#task[
  Consider a two-dimensional ideal Bose gas in a box of side length $L$ with periodic boundary conditions and dispersion relation $eps(bk) = bk^2 \/ 2 m$.
  + Calculate the grand canonical partition function $Z_g^+$ and obtain the limit
    $ lim_(A -> infinity) 1/A ln[Z_g^+ (z, A, T)] $ <eq:limit>
    where $A = L^2$ is the area available to the system, and $z = e^(beta mu)$ denotes the fugacity.
  + Explicitly find the average number of particles per unit area as a function of $z$ and $T$.
  + Show that no macroscopic occupation of the $bk = vb(0)$ mode is necessary at any density. What are the consequences for Bose-Einstein condensation?
]

+ The partition function for the ideal Bose gas of spin-$s$ particles confined to a two-dimensional box of side length $L$ reads
  $ Z_g^+ = product_(bk in (2 pi)/L ZZ^2) product_(sigma=-s)^s 1/(1 - e^(-beta [eps(bk) - mu])) = product_(bk in (2 pi)/L ZZ^2) (1 - e^(-beta (bk^2 \/ 2 m - mu)))^(-g_s), $
  where we used that the dispersion relation $eps(bk) = bk^2 \/ 2 m$ is independent of $sigma$, so the product over spin states just gives the degeneracy $g_s = 2 s + 1$. To write $Z_g^+$ as a momentum integral, we take the logarithm and perform the continuum limit in the resulting sum,
  $
    ln(Z_g^+) & = -g_s L^2/(2 pi)^2 sum_(bk != 0) (2 pi)^2/L^2 ln(1 - z e^(-beta/(2 m) bk^2)) - g_s ln(1 - z) \
    & limits(-->)^(L -> infinity) -g_s A/(2 pi)^2 2 pi integral_0^infinity k ln(1 - z e^(-beta/(2 m) k^2)) dif k - g_s ln(1 - z) \
    & limits(=)^"part. int." g_s A/(2 pi) integral_0^infinity k^2/2 (beta/m k z e^(-beta/(2 m) k^2))/(1 - z e^(-beta/(2 m) k^2)) dif k - g_s ln(1 - z) \
    & = g_s A/(2 pi) beta/(2 m) integral_0^infinity k^3/(z^(-1) e^(beta/(2 m) k^2) - 1) dif k - g_s ln(1 - z) \
    & = g_s A/(2 pi) beta/(2 m) (2 m^2)/beta^2 integral_0^infinity x/(z^(-1) e^x - 1) dif x - g_s ln(1 - z) \
    & = g_s A/(2 pi) m/beta f_2^+ (z) - g_s ln(1 - z).
  $
  The limit @eq:limit gives the pressure
  $ beta p = -lim_(A -> infinity) beta/A Omega = lim_(A -> infinity) 1/A ln(Z_g^+) = g_s/(2 pi) m/beta f_2^+ (z). $
+ The average number of particles per unit area, i.e. the areal density, is given by
  $
    1/A N(T, A, mu) & = 1/A ev(hN)_g = 1/A 1/Z_g^+ tr(hN e^(-beta (hH - mu hN))) \
    & = 1/A sum_(sigma=-s)^s (A/(2 pi)^2 sum_(bk != 0) (2 pi)^2/L^2 ev(n_bk) + ev(n_vb(0))) \
    & = g_s/(2 pi)^2 2 pi integral_0^infinity k/(z^(-1) e^(beta eps(k)) - 1) dif k + g_s/A z/(1 - z) \
    & = g_s/(2 pi) m/beta integral_0^infinity (dif x)/(z^(-1) e^x - 1) + g_s/A z/(1 - z) \
    & = g_s/(2 pi) m/beta f_1^+ (z) + g_s/A z/(1 - z).
  $ <eq:areal-density>
+ For the three-dimensional ideal Bose gas discussed in the lecture, we had calculated the number of particles per unit volume to be
  $ N/V = g_s/lambda^3 f_(3\/2)^+ (z) + g_s/V z/(1 - z), $
  where $lambda = h \/ sqrt(2 pi m kB T)$ denotes the thermal de Broglie wavelength. We had argued that since $lambda^(-3) prop T^(3/2)$ and the integral function $f_(3\/2)^+ (z)$ is bounded from above by $f_(3\/2)^+ (1) = zeta(3 \/ 2) approx 2.61$ for $z in [0, 1]$#footnote[Recall that we had used $mu < 0$ and thus $z = e^(beta mu) < 1$ to apply the geometric series in the calculation of the bosonic partition function. Otherwise the sum over occupation numbers wouldn't even have been convergent.], the occupation numbers of all states but the zero mode tend to zero as $T -> 0$, which requires $z -> 1$ so that the zero mode occupation diverges. Otherwise, it would not be able to account for the macroscopic density $rho_upright(F)$ at $T = 0$ all on its own. This is Bose-Einstein condensation. \
  In two dimensions, the situation is different. While $f_1^+ (z) = -ln(1 - z)$ is still monotonic for $z in [0, 1]$, it is no longer bounded. Instead, it diverges as $z -> 1$.
  #align(center, log-divergence)
  Hence, we can no longer argue that as $T -> 0$, the term $g_s/(2 pi) m/beta f_1^+ (z)$ in @eq:areal-density must vanish because $beta^(-1) prop T$ will be countered by $f_1^+ (z) -> infinity$ if $z = 1$, i.e. if $mu = 0$. So if the thermal mode occupation doesn't vanish at absolute zero, nothing forces the zero mode occupation to become macroscopic, meaning no Bose-Einstein condensation will take place. Indeed, neglecting the zero mode term (which vanishes as $A -> infinity$ for $z < 1$), @eq:areal-density can be solved for the fugacity at any areal density $rho$ and temperature,
  $ z = 1 - exp(-(2 pi beta rho)/(g_s m)) < 1, $
  so all particles are accommodated in the $bk != vb(0)$ modes.
