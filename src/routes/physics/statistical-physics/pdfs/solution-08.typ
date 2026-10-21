#import "/notes.typ": task, vb, kB, ev, pd
#import "/statistical-physics/sheet.typ": points, sheet
#import "@preview/cetz:0.5.2": canvas
#import "@preview/cetz-plot:0.1.4": plot

#show: sheet.with(8, [December 23rd, 2016])

#let (bp, bq) = ($vb(p)$, $vb(q)$)

// x ln(x) is convex and lies above its tangent x - 1 at x = 1
#let tangent-plot = canvas({
  plot.plot(
    size: (6, 4.5),
    x-label: $x$,
    y-label: none,
    x-tick-step: 0.5,
    y-tick-step: 1,
    axis-style: "school-book",
    legend: "inner-north-west",
    y-min: -1,
    y-max: 2.6,
    {
      plot.add(x => if x == 0 { 0 } else { x * calc.ln(x) }, domain: (0, 2.7), samples: 200, style: (stroke: blue + 0.8pt), label: $x ln(x)$)
      plot.add(x => x - 1, domain: (0, 2.7), style: (stroke: red + 0.8pt), label: $x - 1$)
    },
  )
})

= Canonical partition function #points(4)

#task[Consider a classical ideal gas of monatomic molecules with the proper counting of degrees of freedom. Compute the free energy $F$, the internal energy $U$, the entropy $S$, and the heat capacity $C_V$ from the canonical partition function $Z(T, V, N)$ for large $N$.]

The canonical partition function for a single classical particle confined to a region $Lambda subset RR^3$ with continuous degrees of freedom $bq$ and $bp$ and Hamiltonian $H_1 (bp, bq)$ is
$ Z_1 (T, V) = 1/h^3 integral_(RR^3) integral_Lambda e^(-beta H_1 (bp, bq)) dif^3 q dif^3 p. $ <eq:z1>
The need for a prefactor is obvious based on dimensional grounds. The partition function should be dimensionless, so $h$ must have dimensions of momentum times position, i.e. those of an action. The actual value of $h$ does not affect physical observables such as energy or heat capacity, since these derive from the partition function by first taking the logarithm followed by differentiation, which removes all prefactors. It will, however, affect the entropy $S = kB (ln(Z) + beta U)$. If $h$ is set to Planck's constant, $Z_1$ becomes quantitatively correct for dilute gases at high temperature. \
Since the particles of an ideal gas are non-interacting, the Hamiltonian for a system of $N$ particles is a sum of $N$ one-particle Hamiltonians,
$ H(bp_1, ..., bp_N) = sum_(i=1)^N H_i (bp_i), $
where the contribution from each gas particle is just its kinetic energy,
$ H_i (bp_i) = bp_i^2/(2 m). $ <eq:h1>
We can thus construct the $N$-particle partition function as a product of one-particle functions,
$ Z(T, V, N) = 1/N! Z_1 (T, V)^N. $
The factor $1/N!$ takes into account that even though we treat the gas as a classical system, it is really governed by quantum mechanics. At the quantum level, identical particles are indistinguishable. Thus if we exchange any two, the system is unaltered. We must therefore divide by the total number of permutations among all particles $N!$ to ensure that the partition function only counts distinct states. \
Inserting the one-particle Hamiltonian @eq:h1 into @eq:z1, the position integral gives the volume $V$ of the region $Lambda$ and the momentum integration becomes a Gaussian.
$ Z_1 (T, V) = 1/h^3 integral_(RR^3) integral_Lambda e^(-beta bp^2/(2 m)) dif^3 q dif^3 p = V/h^3 (2 pi m kB T)^(3/2) = V/lambda^3, $
where $lambda = h/sqrt(2 pi m kB T)$ is the thermal de Broglie wavelength. Thus
$ Z(T, V, N) = 1/N! V^N/lambda^(3 N). $
Now that we have $Z$, we take its logarithm to obtain the free energy,
$ F = -kB T ln(Z) = -kB T [N ln(V) - ln(N!) - N ln(lambda^3)] approx N kB T [ln((N lambda^3)/V) - 1], $ <eq:free-energy>
where we used Stirling's approximation $ln(N!) = N ln(N) - N + cal(O)(ln N)$ valid for large $N$. \
The internal energy $U$ is defined in terms of the partition function as
$
  U & = -partial/(partial beta) ln(Z) approx partial/(partial beta) N [ln((N lambda^3)/V) - 1] = 3 N partial/(partial beta) ln(h/sqrt(2 pi m kB T)) \
    & = 3/2 N partial/(partial beta) ln(beta) = 3/2 N kB T.
$ <eq:internal-energy>
Differentiating @eq:internal-energy w.r.t $T$ yields the heat capacity for a monatomic ideal gas in three dimensions,
$ C = (partial U)/(partial T) = 3/2 N kB. $
Finally, we can calculate the entropy by differentiating @eq:free-energy w.r.t. $T$,
$ S = -pd(F, T, V) = -F/T - N kB T partial/(partial T) [ln((N lambda^3)/V) - 1] = -F/T + 3/2 N kB. $ <eq:entropy>
Inserting @eq:internal-energy, this becomes the familiar $F = U - T S$. Alternatively, we can insert @eq:free-energy, in which case @eq:entropy becomes the famous Sackur-Tetrode equation for the entropy of a classical monatomic ideal gas with quantum-corrected counting of states,
$ S = -N kB [ln((N lambda^3)/V) - 1] + 3/2 N kB = N kB [ln(V/(N lambda^3)) + 5/2]. $ <eq:sackur-tetrode>
Note that according to @eq:sackur-tetrode, $S -> -infinity$ as $T -> 0$ in conflict with the third law, signaling that the Sackur-Tetrode equation is valid only for $V/(N lambda^3) >> 1$. This is because for $T -> 0$, we leave the classical regime where gas particles are no longer distributed onto available energy states according to Maxwell-Boltzmann statistics, as we assumed in @eq:z1.

= Gibbs variational principle #points(3)

#task[
  Formulate and prove the Gibbs variational principle for the entropy of the canonical ensemble. Proceed in analogy to the argument for the microcanonical entropy, but impose the constraint that the expectation value of $H$ is fixed to the canonical value,
  $ ev(H) limits(=)^! ev(H)_c, $
  and volume $V$ and particle number $N$ fixed.
]

The microcanonical and canonical ensembles are different probability distributions. The former weighs all accessible states equally, $omega_m (q, p) = 1/Z_m$, the latter depending on their energy $omega_c (q, p) = 1/Z_c e^(-beta H(q, p))$. According to Gibbs's definition of entropy (with $kB = 1$ for simplicity)
$ S(w) = -integral_Gamma w ln(w) dif mu_omega, $
this results in different values for $S$. $dif mu_omega$ denotes the phase space measure associated with the distribution $omega$, e.g.
$ dif mu_m = delta(E - H(q, p)) dif mu_c #h(3em) "and" #h(3em) dif mu_c = (dif^(3 N) q dif^(3 N) p)/(h^(3 N) N!) $ <eq:measures>
for $omega_m$ and $omega_c$, respectively, such that
$ integral_Gamma w_m dif mu_m = 1 = integral_Gamma w_c dif mu_c. $
In the thermodynamic limit $N -> infinity$, however, all physical properties (including entropy) coincide for both distributions (see also exercise 3.b)), excepting phase transitions. It might not come as a surprise therefore that a unified method to treat different ensembles exists known as the _Gibbs variational principle_. It states that all ensembles maximize the entropy subject to certain conditions. The only difference is what constraints we have to impose. The microcanonical ensemble assigns non-zero probability only to states of a given volume $V$, number of particles $N$ and energy $E$. The canonical ensemble, on the other hand, constrains $V$ and $N$ as well but replaces $E$ with the average energy $ev(E)$, i.e. the temperature $T$ to maximize the entropy. \
To prove Gibbs's statement that the canonical distribution $omega_c$ maximizes the entropy $S_c$ at $ev(H) limits(=)^! ev(H)_c$, consider
$
  S_c & = -integral_Gamma omega_c ln(omega_c) dif mu_c = -integral_Gamma omega_c [ln(omega_c e^(beta H)) - beta H] dif mu_c \
      & = -integral_Gamma omega_c ln(Z_c^(-1)) dif mu_c + beta integral_Gamma omega_c H dif mu_c = ln(Z_c) + beta ev(H)_c,
$ <eq:s-canonical>
$
  S_omega & = -integral_Gamma omega ln(omega) dif mu_omega = -integral_Gamma omega [ln(omega e^(beta H)) - beta H] dif mu_omega \
          & = -integral_Gamma omega ln(omega e^(beta H)) dif mu_omega + beta ev(H)_omega,
$ <eq:s-omega>
where $omega$ is any non-negative probability distribution normalized with the same measure as $omega_c$, i.e. $integral_Gamma omega dif mu_c = 1$. Taking the difference of @eq:s-canonical and @eq:s-omega gives
$
  S_c - S_omega & = integral_Gamma omega [ln(Z_c) + ln(omega e^(beta H))] dif mu_c + beta underbrace((ev(H)_c - ev(H)_omega), 0) \
                & = integral_Gamma omega_c omega/omega_c ln(omega \/ omega_c) dif mu_c \
                & >= integral_Gamma omega_c (omega \/ omega_c - 1) dif mu_c = integral_Gamma omega dif mu_c - integral_Gamma omega_c dif mu_c = 0.
$
To get from the second to the third line, we used the inequality $x ln(x) >= x - 1$ which holds because $x ln(x)$ is convex and $x - 1$ is its tangent. Thus $S_c >= S_omega$ at $ev(H) = ev(H)_c$ for any $omega$.
#align(center, tangent-plot)

= Fluctuations and equivalence of ensembles #points(3)

#task[
  + Show that the fluctuation of the total energy
    $ sigma_H^2 = ev((H - ev(H))^2) $
    for the canonical ensemble satisfies $sigma_H^2 = -partial/(partial beta) ev(H)$. Assuming that the energy $E = ev(H)$ is non-zero and that $E$ and its derivative with respect to inverse temperature are extensive, how does $sigma_H/E$ behave for large $N$?
  + Calculate $sigma_H^2$ for the grand canonical ensemble and compare it to the result for the canonical ensemble. Discuss the $N$-dependence of the difference for large $N$.
]

+ By linearity of the expectation value $ev(dot)$, we have
  $ sigma_H^2 = ev((H - ev(H))^2) = ev(H^2 - 2 H ev(H) + ev(H)^2) = ev(H^2) - ev(H)^2. $
  The canonical partition function reads
  $ Z_c = integral_Gamma e^(-beta H) dif mu_c, $
  with $dif mu_c$ as in @eq:measures. Thus
  $ ev(H) = 1/Z_c integral_Gamma H e^(-beta H) dif mu_c = -1/Z_c (partial Z_c)/(partial beta), $
  and
  $ -(partial ev(H))/(partial beta) = partial/(partial beta) (1/Z_c (partial Z_c)/(partial beta)) = 1/Z_c (partial^2 Z_c)/(partial beta^2) - (1/Z_c (partial Z_c)/(partial beta))^2 = ev(H^2) - ev(H)^2 = sigma_H^2. $
  Since $ev(H)$ and $partial/(partial beta) ev(H)$ are extensive, they both scale with $N$. This implies
  $ sigma_H/ev(H) tilde sqrt(N)/N = 1/sqrt(N) limits(-->)^(N -> infinity) 0, $
  i.e. in the thermodynamic limit, the relative energy fluctuations tend to zero and the canonical distribution becomes sharply peaked at the energy $E = ev(H)$, just like the microcanonical one.
+ The grand canonical partition function reads
  $ Z_g = sum_(N=0)^infinity integral_Gamma e^(-beta (H - mu N)) dif mu_c = sum_(N=0)^infinity z^N Z_c, $
  with $z = e^(beta mu)$, and the average energy
  $ ev(H)_g = 1/Z_g sum_(N=0)^infinity integral_Gamma H e^(-beta (H - mu N)) dif mu_c, $
  where $H$ is a function of $N$. Consider
  $
    -(partial ev(H)_g)/(partial beta) & = -partial/(partial beta) [1/Z_g sum_(N=0)^infinity integral_Gamma H e^(-beta (H - mu N)) dif mu_c] \
    & = underbrace(1/Z_g (partial Z_g)/(partial beta), -ev(H - mu N)_g) ev(H)_g - underbrace(1/Z_g partial/(partial beta) [sum_(N=0)^infinity integral_Gamma H e^(-beta (H - mu N)) dif mu_c], -ev(H (H - mu N))_g) \
    & = ev(H^2)_g - mu ev(N H)_g - ev(H)_g^2 + mu ev(N)_g ev(H)_g
  $ <eq:grand-derivative>
  We can solve @eq:grand-derivative for the grand canonical energy fluctuations,
  $ sigma_(H,g)^2 = ev(H^2)_g - ev(H)_g^2 = -(partial ev(H)_g)/(partial beta) + mu (ev(N H)_g - ev(N)_g ev(H)_g). $
  The covariance of $N$ and $H$, may be rewritten as
  $ ev(N H)_g - ev(N)_g ev(H)_g = 1/beta (partial ev(H)_g)/(partial mu) $
  since
  $
    1/beta (partial ev(H)_g)/(partial mu) & = 1/beta (-1/Z_g (partial Z_g)/(partial mu) ev(H)_g + 1/Z_g sum_(N=0)^infinity beta N integral_Gamma H e^(-beta (H - mu N)) dif mu_c) \
    & = 1/beta (-1/Z_g sum_(N=0)^infinity beta N z^N Z_c ev(H)_g + beta ev(N H)_g) = ev(N H)_g - ev(N)_g ev(H)_g.
  $
  This leads to
  $ sigma_(H,g)^2 = -(partial ev(H)_g)/(partial beta) + mu/beta (partial ev(H)_g)/(partial mu). $
  Energy fluctuations in the grand canonical and canonical ensemble differ by
  $ sigma_(H,g)^2 - sigma_(H,c)^2 = mu/beta (partial ev(H)_g)/(partial mu) tilde N, $
  whose relative contribution vanishes in the thermodynamic limit since
  $ 1/E sqrt(sigma_(H,g)^2 - sigma_(H,c)^2) tilde sqrt(N)/N limits(-->)^(N -> infinity) 0. $
