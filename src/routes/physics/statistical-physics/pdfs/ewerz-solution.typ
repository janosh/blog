#import "/notes.typ": notes, task, vb, eps, kB, ev, ket
#import "/statistical-physics/sheet.typ": points, cS
#import "@preview/cetz:0.5.2": canvas, draw
#import "@preview/cetz-plot:0.1.4": plot

#show: notes.with(
  title: [Statistical Mechanics],
  subtitle: [Second Exam],
  date: [Janosh Riebesell #sym.dot.c Lecturer: Carlo Ewerz #sym.dot.c January 27th, 2010],
)
#set heading(numbering: "1")
#set math.equation(numbering: "(1)")

#let (bk, be) = ($vb(k)$, $vb(e)$)
#let dots2 = $bullet thin bullet$

// k-space lattice of allowed wavevectors and the disk of radius k containing N(k) states
#let k-space = canvas(length: 0.85cm, {
  import draw: *
  set-style(stroke: 0.6pt)
  circle((0, 0), radius: 2, stroke: blue + 0.8pt, fill: blue.transparentize(88%))
  line((-3.5, 0), (3.5, 0), mark: (end: "stealth", fill: black, scale: 0.5))
  line((0, -2.8), (0, 2.6), mark: (end: "stealth", fill: black, scale: 0.5))
  content((3.5, 0), $k_x$, anchor: "south-east", padding: 3pt)
  content((0, 2.6), $k_y$, anchor: "north-west", padding: 3pt)
  for i in range(-3, 4) {
    for j in range(-3, 4) { circle((i, j * 0.75), radius: 0.05, fill: black) }
  }
  content((-1.6, 1.85), text(fill: blue, $N(k)$))
  line((2.1, -2.25), (2.9, -2.25), mark: (start: "stealth", end: "stealth", fill: black, scale: 0.4), stroke: 0.4pt)
  content((2.5, -2.3), text(size: 8pt, $(2 pi)/L_x$), anchor: "north")
  line((3.2, -1.5), (3.2, -2.25), mark: (start: "stealth", end: "stealth", fill: black, scale: 0.4), stroke: 0.4pt)
  content((3.25, -1.9), text(size: 8pt, $(2 pi)/L_y$), anchor: "west")
})

// Fermi-Dirac distribution at two temperatures and T = 0 (step function)
#let fermi-dirac = canvas({
  import draw: *
  plot.plot(
    size: (6.5, 5),
    x-label: $eps \/ mu$,
    y-label: $n(eps)$,
    x-tick-step: 0.5,
    y-tick-step: 0.5,
    axis-style: "school-book",
    legend: "inner-east",
    x-min: 0,
    x-max: 2.3,
    y-min: 0,
    y-max: 1.15,
    {
      plot.add(x => 1 / (calc.exp((x - 1) * 5) + 1), domain: (0, 2.3), samples: 200, style: (stroke: red + 0.8pt), label: $kB T = mu \/ 5$)
      plot.add(x => 1 / (calc.exp((x - 1) * 25) + 1), domain: (0, 2.3), samples: 300, style: (stroke: rgb("#ff8000") + 0.8pt), label: $kB T = mu \/ 25$)
      plot.add(((0, 1), (1, 1), (1, 0), (2.3, 0)), style: (stroke: blue + 0.8pt), label: $T = 0$)
      plot.add-vline(0.75, 1.25, style: (stroke: (dash: "dashed", thickness: 0.5pt)))
      plot.annotate({
        line((0.75, 1.07), (1.25, 1.07), mark: (start: "stealth", end: "stealth", fill: black, scale: 0.25), stroke: 0.5pt)
        content((1, 1.07), text(size: 8pt, $prop 1 \/ beta$), anchor: "south", padding: 2pt)
      })
    },
  )
})

*General remarks*
- Please use a separate sheet for every exercise.
- Write your name and your group on every sheet.
- You are not allowed to use calculators, paper (except blank sheets) or formula cards.

= Short questions #points(10)

#task[
  #set enum(numbering: "a)")
  + What is the mean occupation number $ev(n_nu)$ for a bosonic and for a fermionic system with energy levels $E_nu$? (3 points)
  + Consider a system consisting of two identical non-interacting particles. Each particle can have exactly three distinct energies $eps_1 = -eps$, $eps_2 = 0$, and $eps_3 = +eps$. The system is in thermal contact with a heat bath of temperature $T$. Determine the canonical partition sum of the system for the case where both particles are distinguishable. (2 points)
  + Shortly explain what characterizes Bose-Einstein condensation. (2 points)
  + Specify the thermodynamic quantities to which the energy fluctuations (in the canonical ensemble) and the particle number fluctuations (in the grand canonical ensemble) are related. (3 points)
]

#set enum(numbering: "a)")
+ The expected number of bosons/fermions in a state $ket(nu)$ with energy $E_nu$ is determined by Bose-Einstein/Fermi-Dirac statistics,
  $ ev(n_nu^plus.minus) = -1/beta partial/(partial E_nu) ln(Z_g^plus.minus) = g_nu/(e^(beta (E_nu - mu)) minus.plus 1), $
  where $g_nu$ counts the degeneracy of $E_nu$ and $beta = 1/(kB T)$.
+ Since the particles are non-interacting, the partition function factorizes. For a single particle,
  $ Z_c^1 = sum_(i=1)^3 e^(-beta eps_i) = e^(beta eps) + 1 + e^(-beta eps). $
  For both,
  $ Z_c = (Z_c^1)^2 = e^(2 beta eps) + 2 e^(beta eps) + 3 + 2 e^(-beta eps) + e^(-2 beta eps). $
  The degeneracies in front of each Boltzmann factor coincide with the number of times an energy level appears in the table below. They sum up to the total number of states $1 + 2 + 3 + 2 + 1 = 9$.
  #align(center, table(
    columns: 10,
    stroke: (x, y) => (
      left: if x > 0 { 0.5pt },
      bottom: if y == 0 { 0.5pt } else if y == 3 { 0.8pt },
      top: if y == 0 { 0.8pt },
    ),
    inset: (x: 6pt, y: 2pt),
    align: center,
    [$E$], [$-2 eps$], [$-eps$], [$0$], [$-eps$], [$0$], [$eps$], [$0$], [$eps$], [$2 eps$],
    [$eps$], [], [], [$bullet$], [], [], [$bullet$], [$bullet$], [$bullet$], [#dots2],
    [$0$], [], [$bullet$], [], [$bullet$], [#dots2], [$bullet$], [], [$bullet$], [],
    [$-eps$], [#dots2], [$bullet$], [$bullet$], [$bullet$], [], [], [$bullet$], [], [],
  ))
  If instead the particles were indistinguishable, states differing only by an exchange of the two particles would be counted once (and for fermions the doubly occupied levels dropped). $Z_c = 1/2! (Z_c^1)^2$ is only the classical approximation thereof.
+ Bose-Einstein condensation is the phenomenon of macroscopic accumulation of bosons in the ground state wave function below a critical temperature $T < T_c$. $T_c$ is close to absolute zero and determined by the particle density $n(z = 1)$ at zero chemical potential ($z = e^(beta mu)$).
+ The expected energy in the canonical ensemble is
  $ ev(E) = 1/Z_c sum_i E_i e^(-beta E_i) = -(partial ln Z_c)/(partial beta). $
  Its derivative w.r.t. temperature gives
  $
    C_V = (partial ev(E))/(partial T) & = 1/Z_c sum_i E_i E_i/(kB T^2) e^(-beta E_i) - 1/Z_c (partial Z_c)/(partial T) ev(E) \
                                      & = 1/(kB T^2) (ev(E^2) - ev(E)^2) = 1/(kB T^2) sigma_E^2.
  $
  Thus in the canonical ensemble, heat capacity and energy fluctuations are directly related. \
  In the grand canonical ensemble, the expected particle number is
  $ ev(N) = 1/Z_g sum_(N=0)^infinity N z^N Z_c = 1/Z_g 1/beta partial/(partial mu) sum_(N=0)^infinity z^N Z_c = 1/beta partial/(partial mu) ln Z_g. $
  The number fluctuations can be written
  $
    1/beta^2 (partial^2)/(partial mu^2) ln Z_g = 1/beta partial/(partial mu) ev(N) & = 1/Z_g sum_(N=0)^infinity N^2 z^N Z_c - (1/Z_g sum_(N=0)^infinity N z^N Z_c)^2 \
    & = ev(N^2) - ev(N)^2 = sigma_N^2.
  $
  Thus
  $ sigma_N^2 = -1/beta (partial^2 Omega)/(partial mu^2) = V/beta (partial^2 p)/(partial mu^2), $ <eq:number-fluctuations>
  where we identified the grand potential $Omega = -1/beta ln Z_g$, inserted $Omega = -p V$ and used that the grand canonical ensemble keeps the volume fixed. The (isothermal) compressibility is defined
  $ kappa_T = -1/V (partial V)/(partial p) = V^2/N^2 (partial^2 p)/(partial mu^2), $
  i.t.o. which @eq:number-fluctuations reads
  $ sigma_N^2 = N^2/(beta V) kappa_T. $
  Thus the grand canonical ensemble relates compressibility and number fluctuations.

= One-dimensional Ising Model #points(10)

#task[
  Consider $N$ spins in a chain which can be modeled using the one-dimensional Ising model
  $ H = -J sum_(n=1)^(N-1) s_n s_(n+1), $
  Where a spin has the values $s_n = plus.minus 1$.
  #set enum(numbering: "a)")
  + Calculate the partition function. (5 points)
  + Calculate the heat capacity per spin. (5 points)
]

+ The partition function is the sum over all $2^N$ possible states $s = {s_1, ..., s_N} in cS_N = {plus.minus 1}^N$ weighted by their energy $H(s)$ according to Boltzmann's factor $e^(-beta H(s))$,
  $
    Z_c & = sum_(s in cS_N) e^(-beta H(s)) = sum_(s_1 in {plus.minus 1}) ... sum_(s_N in {plus.minus 1}) e^(beta J sum_(n=1)^(N-1) s_n s_(n+1)) = product_(n=1)^(N-1) sum_(s_n in {plus.minus 1}) e^(beta J s_n s_(n+1)) sum_(s_N in {plus.minus 1}) \
        & = 2 product_(j=1)^(N-1) (e^(beta J) + e^(-beta J)) = 2 [2 cosh(beta J)]^(N-1),
  $
  where we used that $sum_(s_n in {plus.minus 1}) e^(beta J s_n s_(n+1)) = 2 cosh(beta J)$ regardless of the sign of $s_(n+1)$.
+ The Ising chain's energy is
  $ U = -(partial ln Z_c)/(partial beta) = -(N - 1) sinh(beta J)/cosh(beta J) J = -(N - 1) J tanh(beta J). $
  which results in the per-spin heat capacity
  $ c = C/N = 1/N (partial U)/(partial T) = 1/N (partial U)/(partial beta) (partial beta)/(partial T) = ((N - 1) J)/(N kB T^2) (J - (sinh^2 (beta J))/(cosh^2 (beta J)) J) approx kB (beta^2 J^2)/(cosh^2 (beta J)), $
  where we used $sinh^2 (x) = cosh^2 (x) - 1$ and $N >> 1$.

= Ideal quantum gases #points(10)

#task[
  Note: a) and b) can be solved independently.
  #set enum(numbering: "a)")
  + A system of $N$ non-interacting, spin-$1/2$ fermions are confined to move in two dimensions. They are confined within a rectangular area with dimensions $L_x$ and $L_y$. The wave vectors allowed by periodic boundary conditions are $bk = (2 pi)/L_x n_x be_x + (2 pi)/L_y n_y be_y$, where $n_x$ and $n_y$ can take on all positive and negative integer values. The energy for a single fermion is given by $eps = (planck^2 bk^2)/(2 m)$.
    #set enum(numbering: "i)")
    + Determine $N(k)$, the number of single-particle states with wavevector magnitude smaller than $k$. (1 point)
    + Determine $D(eps)$, the density of single-particle states as a function of their energy $eps$. (2 points)
    + Find an expression for the total energy $E$ of the system of fermions at $T = 0$. (2 points)
  + Now, we consider a system of $N$ non-interacting bosons that have no spin degrees of freedom. They are distributed among 3 single-particle states: $Upsilon_1$ and $Upsilon_2$ with energy $eps = 0$ and $Upsilon_3$ with energy $eps = Delta$.
    #set enum(numbering: "i)")
    + Write down a closed form expression for the partition function $Z(T)$ for the system of bosons. The following formulae may be useful: $sum_(n=0)^N x^n = (1 - x^(N+1))/(1 - x)$ and $sum_(n=0)^N (N - n + 1) x^n = ((N + 1) - (N + 2) x + x^(N+2))/(1 - x)^2$. (1 point)
    + Determine the internal energy $E$ in the limit of large $N$ at low temperatures $kB T << N Delta$. (3 points)
    + Shortly explain why $E$ is not an extensive variable in this model at low temperature. (1 point) \
      Note: iii) can be solved independently from ii).
]

+ Ideal Fermi gas
  #set enum(numbering: "i)")
  + The $k$-space region of wavevectors up to a given magnitude is a disk of area $pi k^2$. The $k$-space area occupied by a single particle state is $1/2 (2 pi)/L_x (2 pi)/L_y = (2 pi^2)/A$, where the factor of $1/2$ is due to the spin degeneracy $g_s = 2 s + 1 = 2$. The number of states with wavevector magnitude smaller than $k$ is thus
    $ N(k) = (pi k^2)/(2 pi^2 \/ A) = (A k^2)/(2 pi). $ <eq:n-of-k>
    #align(center, k-space)
  + The (single-particle) density of states is
    $ D(eps) = partial/(partial eps) N(k) = partial/(partial eps) A/(2 pi) (2 m)/planck^2 eps = (A m)/(pi planck^2), $
    independent of $eps$.
  + We can calculate the system's total Energy $E$ by integrating $eps$ times the density of states $D(eps)$ times the number $n(eps)$ of particles with energy $eps$ over all energies,
    $ E = integral_0^infinity eps D(eps) n(eps) dif eps, $ <eq:energy-integral>
    where $n(eps)$ is given by the Fermi-Dirac distribution#footnote[Note that we already took care of the spin degeneracy $g_s = 2$ in the density of states $D(eps)$, so we don't need to include another factor of $g_s$ in $n(eps)$.]
    $ n(eps) = 1/(e^(beta (eps - mu)) + 1), $
    plotted below for different temperatures.
    #align(center, fermi-dirac)
    At $T = 0$, $n(eps)$ becomes a step function dropping from one to zero at the chemical potential $mu$. Thus the integral @eq:energy-integral simplifies to
    $ E = integral_0^mu eps D(eps) dif eps = 1/2 (A m)/(pi planck^2) mu^2 = (N mu)/2 = (pi planck^2)/(2 A m) N^2, $ <eq:fermi-energy>
    where we inserted the Fermi energy $eps_upright(F)$ for $mu(T = 0)$ obtained from @eq:n-of-k rewritten as
    $ N(eps) = (A m)/(pi planck^2) eps_upright(F) wide => wide eps_upright(F) = (pi planck^2 N)/(A m), $
    At $T = 0$ all energy levels from $eps = 0$ up to the chemical potential $mu$ are fully occupied. Thus the second-to-last expression in @eq:fermi-energy reflects that the total energy is just the average single-particle energy $mu/2$ times the number of particles.
+ Ideal Bose gas
  #set enum(numbering: "i)")
  + Since the bosons are indistinguishable, a state of the system is fully specified by the occupation numbers $(n_1, n_2, n_3)$ with $n_1 + n_2 + n_3 = N$. For $n_3 = n$ bosons in the excited state $Upsilon_3$, the remaining $N - n$ can be distributed among $Upsilon_1$ and $Upsilon_2$ in $N - n + 1$ ways. With $x = e^(-beta Delta)$, the partition function is thus
    $ Z(T) = sum_(n=0)^N (N - n + 1) e^(-beta n Delta) = ((N + 1) - (N + 2) x + x^(N+2))/(1 - x)^2. $
    Note that the classical $1/N! (2 + e^(-beta Delta))^N$ would be wrong here, since it doesn't count multiply occupied states correctly.
  + At low temperatures $kB T << N Delta$, $x^(N+2) = e^(-(N+2) beta Delta)$ is negligible and
    $ ln Z approx ln((N + 1) - (N + 2) x) - 2 ln(1 - x). $
    Using $(partial x)/(partial beta) = -Delta x$, the internal energy is
    $ E = -(partial ln Z)/(partial beta) = Delta x (2/(1 - x) - (N + 2)/((N + 1) - (N + 2) x)) attach(approx, t: N >> 1) (Delta x)/(1 - x) = Delta/(e^(beta Delta) - 1). $ <eq:bose-energy>
    For $T -> 0$, $E -> 0$: all bosons occupy the two zero-energy states.
  + @eq:bose-energy does not depend on $N$. The two degenerate zero-energy states act as a particle reservoir that pins the chemical potential at $mu approx 0$, so the excited state $Upsilon_3$ is occupied by $ev(n_3) = 1/(e^(beta Delta) - 1)$ bosons on average, as for a single bosonic mode, regardless of how many particles the system contains. Doubling the system therefore does not double $E$.
