#import "/notes.typ": cheatsheet, notes, vb, eps, kB, tr, ev, bra, ket, pd, one
#import "/statistical-physics/sheet.typ": distributions, cE, cF, cH, cP, cS

#show: notes.with(title: [Statistical Physics -- Exam Sheet], date: [Janosh Riebesell, February 2017])
#show: cheatsheet

#let (bp, bx, bk, bF, ba, bsigma) = ($vb(p)$, $vb(x)$, $vb(k)$, $vb(F)$, $vb(a)$, $vb(sigma)$)

// how the free energies of the three ensembles are related
#let ensemble-diagram = {
  set text(size: 8pt)
  let arr(label) = box(width: 6em, align(center, stack(spacing: 2pt, line(length: 100%, stroke: 0.5pt), text(size: 5.5pt, label))))
  let down = $arrow.b$
  grid(
    columns: 5,
    align: center + horizon,
    column-gutter: 2pt,
    row-gutter: 6pt,
    $Z_m (E)$, arr[Laplace in $E$], $Z_c (beta)$, arr[Laplace in $N$], $Z_g (mu)$,
    down, [], down, [], down,
    $sigma = S_m/N$, arr[Legendre in $eps = E/N$], $f = F/N$, arr[Legendre in $rho = N/V$], $Omega/V$,
  )
}


= Differential forms

- $n$-form $alpha$ *exact* $<=>$ $alpha in "Im"(dif)$ $<=>$ $exists thin n - 1$-form $beta$ s.t. $alpha = dif beta$
  - $beta$ called *potential* for $alpha$; since $dif^2 = 0$, $beta$ not unique
- $n$-form $alpha$ *closed* $<=>$ $alpha in ker(dif)$ $<=>$ $dif alpha = 0$
- since $dif^2 = 0$, every exact form is closed; converse, i.e. if every closed form is exact, depends on topology: on contractible domain (such as $RR^n$), this holds by *Poincaré's lemma*
- some inexact differentials can be made exact by multiplying with *integrating factor* (and can then be integrated to give (path-independent) scalar field; useful in thermodynamics where $T$ is i.f. that exactifies $S$)

= Thermodynamics

- $dif S = delta Q \/ T$ is path-independent total differential and state function (unlike path function $delta Q$)
- ideal gas entropy: $S = S_0 + C_V ln(T/T_0) + n R ln(V/V_0)$
- *efficiency* $eta = -W/Q$ defined as work _performed_ by system (thus minus sign) divided by heat _added_
  - all reversible engines equally efficient
  - ideal heat engine pumping between reservoirs $T_c$, $T_h$: $eta = 1 - T_c/T_h = 1 - (V_min/V_max)^((n R)/C_V)$, where $(n R)/C_V = (C_p - C_V)/C_V = gamma - 1$
  - isochoric heat change in ideal gas: $Q_(i f) = C_V (T_f - T_i)$
  - by second law, reversible process is isentropic, $integral.cont dif S = 0$
- for *paramagnets* with first law $dif U = T dif S + H dif M$ obeying *Curie's law* $M = C/T H$, internal energy depends only on $T$
- *potentials*: internal energy $U = T S - p V$, Helmholtz free energy $F = U - T S = -p V$, $H = U + p V = T S$, Gibbs free energy $G = U + p V - T S$ (add $sum_i mu_i N_i$ everywhere in presence of chemical potentials)
  - differentials i.t.o. natural variables: $dif U = T dif S - p dif V$, $dif F = -S dif T - p dif V$, $dif H = T dif S + V dif p$, $dif G = -S dif T + V dif p$
  - all potentials related via Legendre transformation
  - *principle of minimum energy*: entropy maximizes in equilibrium, all potentials extremize: $U$ minimizes for fixed $S$, $V$, (follows from first and second law); $F$ minimizes at fixed $T$, $V$; $H$ at fixed $p$; $G$ at fixed $T$ and $p$
- *Maxwell relations*: $U -> pd(T, V, S) = -pd(p, S, V)$, $F -> pd(S, V, T) = pd(p, T, V)$, $H -> pd(T, p, S) = pd(V, S, p)$, $G -> pd(S, p, T) = -pd(V, T, p)$
  - related via $pd(x, y, z) = (pd(y, x, z))^(-1)$ and $pd(x, y, z) pd(y, z, x) pd(z, x, y) = -1$
- *intensive quantities*: temperature $T$, pressure $p$, density $rho$, chemical potential $mu$, concentration $c$, magnetic permeability $mu_m$, melting/boiling point, specific heat capacity $c_V$, specific volume $v$; *extensive*: particle number $N$, internal energy $U$, enthalpy $H$, entropy $S$, Gibbs energy $G$, heat capacity $C_V$, Helmholtz energy $F$, mass $m$, volume $V$
- *real gases*: *van der Waals* $p + a/v^2 = (R T)/(v - b)$ or $p + (n^2 a)/V^2 = (n R T)/(V - n b)$, with $n = N/N_upright(A)$, $R = N_upright(A) kB$; *Dieterici* $p = (R T)/(v - b) exp(-a/(v R T))$; *virial expansion* $(p v)/(R T) = 1 + sum_(i=1) B_i/v^i$ for large volume $v$
- *useful identities*: $p = -pd(F, V, T)$, $S = -pd(F, T, V)$, $1/T = (partial S)/(partial U)$, $pd(U, V, T) = T pd(p, T, V) - p$; *Helmholtz eq.*: $pd(U, V, T) = T^2 lr(partial/(partial T) p/T |)_V$; *thermal expansion coeff.* $alpha = 1/V pd(V, T, (p, N))$; (isothermal) *compressibility* $kappa_T = -1/V (partial V)/(partial p) = V^2/N^2 (partial^2 p)/(partial mu^2)$; *$n$-ball*: volume $V_n (R) = (pi^(n\/2) R^n)/Gamma(n/2 + 1)$, area $A_(n-1) (R) = partial_R V_n (R) = (2 pi^(n\/2) R^(n-1))/Gamma(n/2)$
- *equipartition thm.*: in equilibrium, all microstates compatible with macroscopic conditions equiprobable; energy shared equally amongst all d.o.f.s (i.e. equilibrated systems maximize entropy), each quadratic d.o.f. carries energy $(kB T)/2$
- *heat engine*: device that transfers heat from hot to cold reservoir $T_c < T_h$ with aim of converting as much of transferred heat into mechanical work as possible; maximum efficiency attained by _reversible_ engine operating idealized Carnot cycle $eta_upright(C) = 1 - T_c/T_h$; *heat pump*: moves heat in other direction from cold to hot, goal now to use as little mechanical work as possible to do so, i.e. heat engine operating in reverse $=>$ maximum efficiency of reversible heat pump given by reciprocal of $eta_upright(C)$, $eta_"hp" = T_h/(T_h - T_c)$
- *black-body radiation*: caloric e.o.s. $U = u(T) V$, thermal e.o.s. $p = u(T)/3$, Stefan-Boltzmann law $u(T) = sigma T^4$, Gibbs fundamental relation (first law) $dif U = T dif S - p dif V$ yields entropy $S(T, V) = S_0 + 4/3 sigma V T^3$, adiabatic e.o.s. $delta Q = T dif S = 0 => S prop V T^3 = "const."$

= Statistics

- #table(
    columns: 4,
    stroke: none,
    inset: (x: 3pt, y: 2pt),
    align: left + horizon,
    [_ensemble_], [_fixed_], [_distribution_], [_interpretation_],
    [micro], [$V thin N thin E$], [$1/Z_m delta(H - E)$], [isolated system],
    [canonical], [$V thin N thin T$], [$1/Z_c e^(-beta H)$], [system + heat bath],
    [grand], [$V thin T thin mu$], [$1/Z_g e^(-beta (H - mu N))$], [$arrow.t$ + particle reservoir],
  )
- entropies: *Boltzmann* $S_m = k_B ln Z_m$, $S_c = k_B (ln Z_c + beta ev(H)_c)$, $S_g = k_B [ln Z_g + beta ev(H)_g - beta mu ev(N)_g]$ (apply only to equilibrium), *Gibbs* $S_upright(G) = -kB sum_i p_i ln(p_i)$ respectively $S_upright(G) = -kB integral_Gamma omega ln omega dif mu$ on discrete/continuous measure space (valid generally), $S_upright(G)$ constant in time due to Liouville's eq. $(dif omega)/(dif t) = 0$
  - *Liouville thm.* phase space distribution constant along any trajectory in $Gamma$; viewing motion through phase space as incompressible 'fluid flow' of conserved current of system points implies via Noether's thm. invariance under time evolution generated by Noether charge Hamiltonian
- *equivalence of ensembles*: thermodynamics same for large class of systems (incl. ideal gas), $S_m/N limits(<-->)^(N -> infinity) S_c/N$, $S_m/V limits(<-->)^(V -> infinity) S_g/V$; warning: fails in important cases e.g. phase transitions
  #align(center, block(inset: (y: 3pt), ensemble-diagram))
- *Hamilton's eqs.* $dot(q)_i = (partial H)/(partial p_i)$, $dot(p)_i = -(partial H)/(partial q_i)$ where $p_i = (partial L)/(partial dot(q)_i)$
- *Boltzmann eq.* $(partial/(partial t) + bp/m dot vb(nabla)_x + bF dot vb(nabla)_p) f(bx, bp, t) = integral dif^3 k dif^3 p' dif^3 k' |chevron.l bp', bk'|T|bp, bk chevron.r|^2 [f_(p') f_(k') - f_p f_k]$ describes (non-equilibrium) evolution of phase space densities (for large systems, e.g. gases); incorporates *molecular chaos*, which assumes collision term results solely from two-body collisions between particles uncorrelated prior to scattering (breaks time-reversal invariance since they are obviously correlated after collision), m.c. allows writing collision term as $bp$-integral in which two-particle correlator $F(bx, bp, bk, t)$ factorizes into one-particle distributions $f(bx, bp, t) f(bx, bk, t)$
  - for stationary systems, Boltzmann eq. greatly simplifies to $bp/m dot vb(nabla)_x f_0 (bx, bp) = -bF(bx) dot vb(nabla)_p f_0 (bx, bp)$ since 1. distributions $f(bx, bp)$ lose explicit time-dependence 2. $H$-function becomes stationary, resulting in detailed balance, meaning number of particles leaving any mode due to given scattering process equals number entering that mode by reverse process; stationary solution: *Boltzmann distr.* $f_0 (bx, bp) prop exp[-beta (bp^2/(2 m) + V(bx))]$
- *Boltzmann $H$-fct.* $H(t) = integral dif^3 x dif^3 p f(bx, bp, t) ln[f(bx, bp, t)]$
- *Poincaré recurrence thm.* in context of ergodicity (time avr. = phase space avr.), isolated phase-space volume preserving (e.g. Hamiltonian) systems will return arbitrarily close to initial state after finite time
- *Gibbs paradox*: for classical counting of states, entropy not extensive: $S$ increases when gas of identical particles mixed with itself (fixable by adding $1/(h^(3 N) N!)$ to the measure $dif mu_m$); entropy from Boltzmann's $H$ does not have this problem
- *Gibbs variational principle*: microcanonical state has maximal entropy among all states on energy shell $cE$, holds for other ensembles as well
  - useful inequality: $f (ln f - ln g) >= f - g thick forall f, g >= 0$ ($=$ for $f = g$), follows from $x ln x >= x - 1$ for $x >= 0$
- *canonical part. fct.* discrete classical $Z_c = sum_i e^(-beta E_i)$, continuous classical $Z_c = integral_Gamma e^(-beta H) dif mu_c$ with $dif mu_c = (dif^(3 N) q dif^(3 N) p)/(h^(3 N) N!)$; discrete quantum $Z = tr_cH (e^(-beta hat(H)))$
  - internal energy $U = -partial_beta ln(Z_c)$, free energy $F = -1/beta ln(Z_c)$
- *grand part. fct.* $Z_g = sum_(N=0)^infinity integral_Gamma e^(-beta (H - mu N)) dif mu_c = sum_(N=0)^infinity z^N Z_c (N)$, with fugacity $z = e^(beta mu)$ and e.e.v. $ev(H)_g = 1/Z_g sum_(N=0)^infinity integral_Gamma H e^(-beta (H - mu N)) dif mu_c$, expected particle number $ev(N) = 1/beta partial/(partial mu) ln Z_g = -(partial Omega)/(partial mu)$
- *fluctuations*: e.g. energy $sigma_H^2 = ev((H - ev(H))^2) = ev(H^2) - ev(H)^2 = -(partial ev(H))/(partial beta)$, where $ev(H) = 1/Z_c integral_Gamma H e^(-beta H) dif mu_c = -1/Z_c (partial Z_c)/(partial beta)$
- *uncoupled Ising model/ideal paramagnet* ($N$ uncoupled Ising spins in external field $h$): $H(s) = -h m sum_(j=1)^N s_j = -h M(s)$, minus $=>$ energy lowered if spins align with external field; $s = (s_1, ..., s_N) in cS_N = {plus.minus 1}^N$ is any of $2^N$ possible spin configurations; energy shell $cE = {s in cS_N | H(s) = E}$ (non-empty only if $E \/ h m in ZZ inter [-N, N]$), microcan. part. fct. $Z_m = binom(N, N_arrow.b)$, entropy $S = N kB ln(2) - (N kB)/2 [(1 + E/(N m h)) ln(1 + E/(N m h)) + (1 - E/(N m h)) ln(1 - E/(N m h))]$; canonical p.f. $Z_c = sum_(s in cS_N) e^(-beta H(s)) = product_(j=1)^N sum_(s_j) e^(beta h m s_j) = [2 cosh(beta h m)]^N$, free energy $F = -1/beta ln Z_c = -N/beta ln[2 cosh(beta h m)]$, magnetization $M = -(partial F)/(partial h) = N m tanh(beta m h)$, caloric e.o.s. $E = -(partial ln Z_c)/(partial beta) = -N m h tanh(beta m h)$, specific heat $c_h = C_h/N = 1/N pd(U, T, h) = kB (beta^2 h^2 m^2)/(cosh^2 (beta h m))$, magnetic susceptibility $chi = (partial M)/(partial h) = (beta N m^2)/(cosh^2 (beta h m))$, Gibbs fundamental rel. $dif S = 1/T dif E + M/T dif h - mu/T dif N$
- *coupled Ising model* $H(s) = J sum_(chevron.l s_i, s_j chevron.r)^N (1 - s_i s_j) - h sum_(i=1)^N s_i$, can. part. fct. $Z_c = sum_(s in cS_N) e^(-beta H(s))$, *mean-field magnetization* per spin of Ising ferromagnet $m = tanh(2 d beta J m + beta h)$ with crit. temp. $T_c = 2 d J \/ kB$
- *density operator*: $rho^dagger = rho$, $tr(rho) = 1$, $rho >= 0$, observable $A$ expectation value $ev(A) = tr(rho A)$
  - spin-$1/2$: $rho = 1/2 (one_2 + ba dot bsigma)$ with Bloch vector $ba = ev(bsigma) = tr(bsigma rho)$, eigenvalues $lambda_plus.minus = 1/2 (1 plus.minus |ba|)$ where $|ba| <= 1$; pure state, i.e. $rho^2 = rho$ if $|ba| = 1$, mixed else, spin polarization $pi = (p_+ - p_-)/(p_+ + p_-)$
  - *von Neumann entropy* $S_upright(N) = -kB tr_cH [rho ln(rho)]$ with $rho = sum_n p_n ket(n) bra(n)$ sum over complete set of states of Hilbert $cH$, reduces to Boltzmann entropy for microcan. ensemble
  - canonical density op. $rho_c = e^(beta (F - H)) = 1/Z_c e^(-beta H)$, with normalization $Z_c = tr e^(-beta H)$
- (anti-)symmetrized *many-particle states* $cP_plus.minus ket(alpha_1) times.o dots.c times.o ket(alpha_n) = 1/n! sum_(pi in S_n) (plus.minus 1)^pi ket(alpha_(pi(1))) times.o dots.c times.o ket(alpha_(pi(n)))$ furnish Fock space $cF_plus.minus (cH) = plus.o.big_(n=0)^infinity cH_plus.minus^n$ with $cH_plus.minus^n = cP_plus.minus cH^(times.o n)$
- *occupation numbers* $ev(n_k^plus.minus)_g = -1/beta partial/(partial eps_k) ln(Z_g^plus.minus) = 1/(e^(beta (eps_k - mu)) minus.plus 1)$ given by Bose-Einstein/Fermi-Dirac distributions with $Z_g^plus.minus = tr_(cF_plus.minus) (e^(-beta (hat(H) - mu hat(N)))) = product_(j=0)^infinity sum_(n_j^plus.minus = 0)^(infinity "or" 1) e^(-beta n_j (eps_j - mu)) = product_(j=0)^infinity (1 minus.plus e^(-beta (eps_j - mu)))^(minus.plus 1)$
  - Maxwell-Boltzmann distribution $f(bp) = e^(-beta (eps(bp) - mu))$, or normalized and spherically sym. $f(v) = (m/(2 pi kB T))^(3\/2) 4 pi v^2 e^(-(m v^2)/(2 kB T))$
  #align(center, block(inset: (y: 3pt), distributions(size: (6, 2.8))))
- total particle fluctuations $Delta N = ev(N^2) - ev(N)^2 = sum_k ev(n_k^2) - sum_k ev(n_k)^2$ for non-interacting gases
- *grand potential* $Omega = -1/beta ln Z_g$, $Omega = -p V$, ideal Bose/Fermi gas $Omega^plus.minus (T, V, mu) = -1/beta ln(Z_g^plus.minus) = plus.minus 1/beta sum_j ln(1 minus.plus e^(-beta (eps_j - mu)))$ with $p = -(partial Omega)/(partial V)$, $S_g = -(partial Omega)/(partial T)$
- *ideal Fermi gas*: pressure $beta p = (4 pi g_s)/h^3 integral_0^infinity dif p thin p^2 ln(1 + e^(-beta (p^2 \/ 2 m - mu))) = g_s/lambda^3 f_(5\/2)^- (z)$, density $rho = N/V = (4 pi g_s)/h^3 integral_0^infinity (p^2 dif p)/(1 + e^(beta (p^2 \/ 2 m - mu))) = g_s/lambda^3 f_(3\/2)^- (z)$, where $f_nu^plus.minus (z) = 1/Gamma(nu) integral_0^infinity (x^(nu - 1) dif x)/(z^(-1) e^x minus.plus 1)$, $z = e^(beta mu)$ and $lambda = h \/ sqrt(2 pi m kB T)$, low temperature/high density means $rho lambda^3 >> 1 => z >> 1$, e.o.s. $(p V)/(kB T) = ln Z_g^plus.minus = minus.plus g_s sum_k ln(1 minus.plus e^(-beta (eps_k - mu)))$, energy $U = 3/2 p V$
- *ideal Bose gas*: non-interacting (spinless) bosons with disp. rel. $eps_k = planck^2 k^2 \/ 2 m$ contained in $V = L^d$; grand part. fct. $Z_g = sum_(N=0)^infinity sum_({n_k}) e^(-beta sum_k n_k (eps_k - mu)) delta_(sum_k n_k, N) = product_k sum_({n_k}) e^(-beta sum_k n_k (eps_k - mu)) = product_k 1/(1 - e^(-beta (eps_k - mu)))$, grand potential $Omega = -1/beta ln(Z_g) = 1/beta sum_k ln(1 - e^(-beta (eps_k - mu))) limits(-->)^(V -> infinity) V/beta (A_(d-1) (1))/(2 pi)^d integral_0^infinity ln(1 - z e^(-beta eps_k)) k^(d-1) dif k$, now subst. $x = (beta planck^2 k^2)/(2 m)$ followed by partial integration to get $Omega = V/beta (A_(d-1) (1))/(2 pi)^d 1/2 ((2 m)/(planck^2 beta))^(d/2) integral_0^infinity x^(d/2 - 1) ln(1 - z e^(-x)) dif x = -V/beta (A_(d-1) (1))/d ((2 m)/(h^2 beta))^(d/2) integral_0^infinity x^(d/2)/(z^(-1) e^x - 1) dif x = -V/(beta lambda^d) f_(d/2 + 1)^+ (z)$, avr. number of particles $N = (partial ln Z_g)/(partial (beta mu)) = V/lambda^d f_(d/2)^+ (z) =>$ density $n(z) = 1/lambda^d f_(d/2)^+ (z)$; pressure $p V = -Omega$ and $E = -(partial ln Z_g)/(partial beta) = d/2 (ln Z_g)/beta = -d/2 Omega$, i.e. $E = d/2 p V$; critical temperature obtained by solving $n(1) = 1/lambda^d zeta(d/2)$ for $T_c$, for $d > 2$, this yields $T_c = h^2/(2 pi m kB) (n/zeta(d/2))^(2/d)$; heat capacity at $T < T_c$, $z = 1$ is $C(T) = pd(E, T, z = 1) = kB d/2 (d/2 + 1) V/lambda^d zeta(d/2 + 1)$ e.o.s. at high $T$ ($z -> 0$) is $(p V)/(N kB T) = 1 - (N lambda^3)/(4 sqrt(2) V) + ...$ has correction to ideal gas that lowers the pressure and is solely due to quantum statistics (not interactions)
