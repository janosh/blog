#import "/notes.typ": notes, task, vb, eps, kB, tr, unit, ev, pd
#import "/statistical-physics/sheet.typ": points, cS

#show: notes.with(
  title: [Theoretical Statistical Physics],
  subtitle: [Final Exam],
  date: [Janosh Riebesell #sym.dot.c Lecturer: Manfred Salmhofer #sym.dot.c February 10th, 2017],
)
#set heading(numbering: "1")
#set math.equation(numbering: "(1)")

#let bp = $vb(p)$
#let cN = $cal(N)$

Write your solutions comprehensibly so that the reasoning on which your calculations are based can be understood. Note down intermediate steps in your calculations. Please start the solution to every problem on a separate page.

= Reversible heat pump #points(4)

#task[An electric heater (i.e. a device that transforms work completely into heat) keeps a room at a temperature of 20~°C. The ambient temperature is 10~°C. By how much can one reduce the heating costs, if one uses a reversible heat pump instead?]

A heat engine is a device that transfers heat from a hot reservoir at temperature $T_h$ to a cold one at $T_c < T_h$ with the aim of converting as much of the transferred heat into mechanical work as possible. The efficiency $eta$ of any reversible heat engine is equal to that of the idealized Carnot cycle $eta_upright(C) = 1 - T_c/T_h$. \
A heat pump, on the other hand, moves heat in the other direction from a cold reservoir to a hot one, the goal now being to use as little mechanical work as possible to do so. Since this is precisely a heat engine operating in reverse, its idealized efficiency is given by the reciprocal of $eta_upright(C)$. A reversible heat pump would thus reduce the heating costs relative to those of the electric heater with efficiency $eta_"eh" = 1$ by a factor of
$ eta_"hp"/eta_"eh" = T_h/(T_h - T_c) approx (293 unit("K"))/(10 unit("K")) = 29.3. $

= Black-body radiation #points(6)

#task[
  Black-body radiation has the caloric equation of state $U = u(T) V$ and thermal equation of state $p = 1/3 u(T)$.
  #set enum(numbering: "a)")
  + Derive from this information the Stefan-Boltzmann law
    $ u(T) = sigma T^4, $
    with $sigma$ a constant. Hint: You may use the Maxwell relation $pd(U, V, T) = T pd(p, T, V) - p$.
  + Use the Gibbs fundamental relation to calculate the entropy. Fix the integration constant by demanding that $S(T) -> 0$ as $T -> 0$.
  + Derive the equation for adiabatic changes of state.
]

#set enum(numbering: "a)")
+ Inserting $U = u(T) V$ and $p = 1/3 u(T)$ into the suggested Maxwell relation yields
  $ u = T/3 (dif u)/(dif T) - 1/3 u. $
  Separation of variables gives
  $ (dif u)/u = 4 (dif T)/T, $
  which integrates to
  $ ln u = ln T^4 + a, $
  with $a in RR$ constant. Exponentiation results in the Stefan-Boltzmann law for the temperature dependence of black-body radiation,
  $ u = e^a T^4 equiv sigma T^4. $
+ The Gibbs fundamental relation, arguably the most important relation in all of thermodynamics, describes the set of equilibrium points of a system via its internal energy $U$ as a function of _all_ extensive parameters. For a non-magnetic single-component system, it reads $U = U(S, V, N)$, or in differential form at constant particle number ($dif N = 0$),
  $ dif U = T dif S - p dif V. $ <eq:gibbs>
  By the caloric equation of state,
  $ dif U = V pd(u, T, V) dif T + u dif V = 4 sigma V T^3 dif T + sigma T^4 dif V. $ <eq:du>
  Solving @eq:gibbs for $dif S$ and inserting @eq:du yields
  $ dif S = 1/T dif U + p/T dif V = 4 sigma V T^2 dif T + 4/3 sigma T^3 dif V. $ <eq:ds>
  Integrating @eq:ds w.r.t. $T$ at constant $V$ (or vice versa), we find the entropy of black-body radiation
  $ S(T, V) = S_0 + 4/3 sigma V T^3. $
  Demanding $S(T) -> 0$ as $T -> 0$ requires $S_0 = 0$. Thus $S = 4/3 U/T = (4 p V)/T$.
+ During an adiabatic process $delta Q = T dif S = 0$, i.e. the entropy remains constant. Thus
  $ V T^3 = "const." $

= Maxwell distribution #points(6)

#task[
  Consider a classical gas of particles in three dimensions. The energy of a particle with momentum $bp$ is given by $eps(bp) = c |bp|$, where $c > 0$ is a fixed velocity.
  #set enum(numbering: "a)")
  + Write down the (correctly normalized) Maxwell distribution for this situation.
  + Calculate the expectation value of the energy $ev(E)$, and the variance $ev((E - ev(E))^2)$.
]

+ The unnormalized Maxwell distribution is
  $ f(bp) = e^(-beta eps(bp)). $
  Integrating $f(bp)$ over $bp in RR^3$, we get
  $ integral_(RR^3) f(bp) dif^3 p = 4 pi integral_0^infinity p^2 e^(-beta c p) dif p = 4 pi partial_(beta c)^2 integral_0^infinity e^(-beta c p) dif p = 4 pi partial_(beta c)^2 1/(beta c) = (8 pi)/(beta c)^3. $
  Thus $f(bp) = cN e^(-beta eps(bp))$ with $cN = (beta c)^3/(8 pi)$ is normalized.
+ The expected energy is
  $
    ev(E) & = integral_(RR^3) eps(bp) f(bp) dif^3 p = -4 pi c cN partial_(beta c)^3 integral_0^infinity e^(-beta c p) dif p \
          & = -4 pi c cN partial_(beta c)^3 1/(beta c) = 24 pi c cN 1/(beta c)^4 = 3/beta = 3 kB T.
  $
  The expected squared energy is
  $
    ev(E^2) & = integral_(RR^3) eps(bp)^2 f(bp) dif^3 p = 4 pi c^2 cN partial_(beta c)^4 integral_0^infinity e^(-beta c p) dif p \
            & = 96 pi c^2 cN 1/(beta c)^5 = 12/beta^2 = 12 k_upright(B)^2 T^2,
  $
  which results in the variance
  $ sigma_E^2 = ev((E - ev(E))^2) = ev(E^2) - ev(E)^2 = 3 k_upright(B)^2 T^2. $

= Ideal paramagnet #points(8)

#task[
  Consider an ideal paramagnet defined as a system of $N$ independent Ising spins with magnetic moment $m$ in an external field $h$.
  #set enum(numbering: "a)")
  + Write down the Hamiltonian $H$ of the system.
  + Give the definition of the canonical partition function and compute it for this $H$.
  + Compute the free energy, the magnetization, and the energy.
  + Calculate the specific heat and the magnetic susceptibility.
]

+ The Hamiltonian of $N$ uncoupled Ising spins of magnetic moment $m$ in a field $h$ is
  $ H(s) = -h m sum_(j=1)^N s_j, $
  where $s = (s_1, ..., s_N) in cS_N = {plus.minus 1}^N$ denotes one of the $2^N$ possible spin configurations.
+ The canonical partition function is sum of all spin configurations weighted by their energy according to Boltzmann's factor,
  $
    Z_c & = sum_(s in cS_N) e^(-beta H(s)) = sum_(s_1 in {plus.minus 1}) ... sum_(s_N in {plus.minus 1}) e^(beta h m sum_(j=1)^N s_j) = product_(j=1)^N sum_(s_j in {plus.minus 1}) e^(beta h m s_j) \
        & = product_(j=1)^N (e^(beta h m) + e^(-beta h m)) = [2 cosh(beta h m)]^N.
  $
+ The free energy is
  $ F = -1/beta ln Z_c = -N/beta ln[2 cosh(beta h m)]. $
  The magnetization is the free energy's first derivative w.r.t. the field $h$,
  $ M = -(partial F)/(partial h) = N/beta sinh(beta h m)/cosh(beta h m) beta m = N m tanh(beta h m). $
  The internal energy is
  $ U = -(partial ln Z_c)/(partial beta) = -N h m tanh(beta h m). $
+ The specific heat capacity is
  $
    c_h = C_h/N = 1/N pd(U, T, h) = 1/N (partial U)/(partial beta) (partial beta)/(partial T) & = -h m (h m - h m (sinh^2 (beta h m))/(cosh^2 (beta h m))) (-1/(kB T^2)) \
    & = kB (beta^2 h^2 m^2)/(cosh^2 (beta h m)),
  $
  where we used $sinh^2 (x) = cosh^2 (x) - 1$. The magnetic susceptibility is the change in magnetization w.r.t. a change in the field $h$,
  $ chi = (partial M)/(partial h) = (beta N m^2)/(cosh^2 (beta h m)). $

= 3-level system #points(8)

#task[
  The Hamiltonian for a three-level quantum system is given by
  $ H = mat(-eps, 0, 0; 0, 0, eta; 0, eta, 0), $
  with energies $eps > 0$ and $eta > 0$. Calculate the canonical density operator, the canonical partition function, and the free energy. Calculate the expectation value of the energy, and the expectation value of the observable
  $ A = mat(0, 1, 0; 1, 0, 1; 0, 1, 0). $
  If $eta > eps$, what is the low-temperature behavior of these expectation values?
]

Solving the characteristic polynomial,
$ det mat(-eps - lambda, 0, 0; 0, -lambda, eta; 0, eta, -lambda) = -lambda^2 (lambda + eps) + eta^2 (lambda + eps) = -(lambda^2 - eta^2)(lambda + eps) limits(=)^! 0, $
we find that $H$ has eigenvalues $lambda_1 = -eps$, $lambda_2 = -eta$, $lambda_3 = eta$. To simplify calculations, we will work with the diagonal form
$ H_d = mat(-eps, 0, 0; 0, -eta, 0; 0, 0, eta). $
The canonical density operator is defined
$ rho_c = e^(beta (F - H)) = e^(ln Z_c^(-1)) e^(-beta H) = 1/Z_c e^(-beta H), $
where we used $F = -1/beta ln Z_c$ and the operator exponential $e^(-beta H)$ is defined by its power series. However, for the special case of a diagonal matrix we can simply exponentiate individual entries, yielding
$ rho_c = 1/Z_c e^(-beta H_d) = 1/Z_c mat(e^(beta eps), 0, 0; 0, e^(beta eta), 0; 0, 0, e^(-beta eta)) $
where the partition function $Z_c$ normalizes the density operator,
$ Z_c = tr(e^(-beta H_d)) = e^(beta eps) + e^(-beta eta) + e^(beta eta). $
The free energy reads
$ F = -1/beta ln Z_c = -1/beta ln(e^(beta eps) + e^(-beta eta) + e^(beta eta)). $
The expected energy is
$
  ev(H) = tr(rho_c H_d) & = 1/Z_c tr mat(-eps e^(beta eps), 0, 0; 0, -eta e^(beta eta), 0; 0, 0, eta e^(-beta eta)) \
  & = -1/Z_c (eps e^(beta eps) + eta (e^(-beta eta) - e^(beta eta))) = -1/Z_c (eps e^(beta eps) + 2 eta sinh(beta eta)).
$
To compute $A$'s expectation value as $ev(A) = tr(rho_c A)$, we need to transform it into the eigenbasis of $H$ in which we expressed $rho_c$. To that end, we calculate $A_d = P^(-1) A P$, where $P^(-1) = P^upright(T) = P$ is the orthonormal matrix of normalized eigenvectors of $H$ given by
$ P = mat(1, 0, 0; 0, -1/sqrt(2), 1/sqrt(2); 0, 1/sqrt(2), 1/sqrt(2)), $
so that
$ A_d = mat(0, -1/sqrt(2), 1/sqrt(2); -1/sqrt(2), -1, 0; 1/sqrt(2), 0, 1). $
The expected value of the observable $A$ is thus
$ ev(A) = tr(rho_c A) = -1/Z_c (e^(beta eta) - e^(-beta eta)) = -2/Z_c sinh(beta eta). $
The low-temperature behavior of $ev(H)$ and $ev(A)$ for $eta > eps$ is
$
  ev(H) & = -(eps e^(beta eps) + eta (e^(beta eta) - e^(-beta eta)))/(e^(beta eps) + e^(-beta eta) + e^(beta eta)) limits(-->)^(beta -> infinity) -eta, \
  ev(A) & = (e^(-beta eta) - e^(beta eta))/(e^(beta eps) + e^(-beta eta) + e^(beta eta)) limits(-->)^(beta -> infinity) -1.
$
As expected, the low-temperature energy is determined by the lowest energy state $-eta$.
