#import "/notes.typ": task, vb, kB, ev
#import "/statistical-physics/sheet.typ": points, sheet
#import "@preview/cetz:0.5.2": canvas, draw

#show: sheet.with(5, [December 2nd, 2016])

#let Ekin = $E_"kin"$
#let (bx, bp, bk, bF) = ($vb(x)$, $vb(p)$, $vb(k)$, $vb(F)$)

// two-particle scattering p, k -> p', k' and its reverse, as needed for detailed balance
#let scattering(in1, in2, out1, out2) = canvas(length: 0.7cm, {
  import draw: *
  set-style(stroke: 0.5pt)
  let arrow = (end: "stealth", fill: black, scale: 0.5)
  line((-1.4, 0.6), (0, 0), mark: arrow)
  line((-1.4, -0.6), (0, 0), mark: arrow)
  line((0, 0), (1.4, 0.6), mark: arrow)
  line((0, 0), (1.4, -0.6), mark: arrow)
  circle((0, 0), radius: 0.22, fill: luma(200))
  content((-1.4, 0.6), text(size: 8pt, in1), anchor: "south-east")
  content((-1.4, -0.6), text(size: 8pt, in2), anchor: "north-east")
  content((1.4, 0.6), text(size: 8pt, out1), anchor: "south-west")
  content((1.4, -0.6), text(size: 8pt, out2), anchor: "north-west")
})

// U(x) = -A e^(-a x) + B e^(-2 a x) for a short-ranged (large a) and a long-ranged potential
#let wall-potential = canvas(length: 1cm, {
  import draw: *
  set-style(stroke: 0.6pt)
  rect((-0.4, 0), (0, 2.9), fill: tiling(size: (4pt, 4pt), std.line(start: (0%, 100%), end: (100%, 0%), stroke: 0.4pt)), stroke: 0.5pt)
  line((0, -0.9), (0, 3.3), mark: (end: "stealth", fill: black, scale: 0.5))
  line((-0.4, 0), (5.2, 0), mark: (end: "stealth", fill: black, scale: 0.5))
  content((0, 3.3), $U(x)$, anchor: "south")
  content((5.2, 0), $x$, anchor: "west", padding: 2pt)
  for (a, paint, B, A) in ((4.5, rgb("#ff8000"), 6, 3), (1.6, blue, 7, 4)) {
    let U(x) = -A * calc.exp(-a * x) + B * calc.exp(-2 * a * x)
    // sample densely near the wall where the repulsion shoots up, and clip at the top of the frame
    let pts = range(0, 301).map(i => 5 * calc.pow(i / 300, 2)).filter(x => U(x) <= 2.8).map(x => (x, U(x)))
    line(..pts, stroke: paint + 0.9pt)
  }
  content((4.2, 0.12), text(fill: rgb("#ff8000"), $1/alpha << ell$), anchor: "south")
  content((4.2, -0.15), text(fill: blue, $1/alpha approx ell$), anchor: "north")
})

= Ideal gas work #points(3)

#task[Within the kinetic model of an ideal gas, show that the work done to the gas when changing the volume is $-p dif V$.]

Kinetic theory traces the macroscopic phenomenon of pressure on a surface back to a constant bombardment by microscopic particles, each of which obeys Newton's laws of motion. Upon impact, a tiny amount of momentum is transferred onto the surface. The resulting average force can be calculated explicitly by considering a simple toy model, a cubic box of length $L$ containing $N$ particles, each of mass $m$. We assume that a particle travelling with velocity $v_x$ in the $x$-direction bounces off a wall perfectly elastically so that it returns with velocity $-v_x$. The resulting momentum transfer is $Delta p_x = 2 m v_x$. Since the particle is trapped in a box, it will again hit the _same_ wall after $Delta t = 2 L \/ v_x$. The force due to this single particle is thus
$ F_p = (Delta p_x)/(Delta t) = (m v_x^2)/L. $
Summing up the contributions from all $N$ particles in the container, the total average force is
$ F = (N m ev(v_x^2))/L. $
$ev(v_x^2)$ is the square of the velocity in $x$-direction averaged over all particles. The $x$-direction is in no way distinguished from $y$ or $z$, meaning $ev(v_x^2) = ev(v^2) \/ 3$. Thus the differential work required to impress one of the container's walls by a distance $dif x$ is
$ delta W = -F dif x = -(N m ev(v^2))/(3 L) dif x = -(2 N ev(Ekin))/(3 L^3) L^2 dif x = -(2 N ev(Ekin))/(3 V) dif V. $
The sign above stems from the fact that if $dif V < 0$, we need to exert a force to squeeze the box, thereby increasing its energy, whereas for $dif V > 0$, the system itself is doing the work, thus decreasing its energy. Inserting $ev(Ekin) = 3/2 kB T$ and the ideal gas law $p V = N kB T$, we get
$ delta W = -(N kB T)/V dif V = -p dif V. $

= Density of states #points(2)

#task[Consider a system of $N$ identical, uncoupled quantum mechanical oscillators. Compute the number of states at a given total energy of the system.]

A quantum harmonic oscillator features the well-known ladder of equidistant energy states
$ E_n = (n + 1/2) planck omega, #h(3em) "with" n in NN_0. $
For $N$ identical oscillators, we can thus immediately write down the ground state energy as $E_min = N/2 planck omega$. Since this energy is attained only by a single state $n_i = 0 thick forall i in {1, ..., N}$, the number of microstates with energy $E_min$ is $Omega(E_min) = 1$.

At the first excited level $E_min + planck omega$, we have one energy quantum to allocate. We could use it to excite any of the $N$ oscillators, so the number of states increases to
$ Omega(E_min + planck omega) = N. $
At $E_min + 2 planck omega$, we have 2 quanta to distribute. Either we give both quanta to one oscillator for which there are again $N$ possibilities, or to two different oscillators, resulting in $N(N - 1)$ possibilities. However, order doesn't matter since first giving a quantum to oscillator $i$ followed by exciting oscillator $j$ results in the same state as doing it the other way round. We therefore have to halve the number of states resulting from the second configuration. In total, this gives
$ Omega(E_min + 2 planck omega) = N + N/2 (N - 1) = N/2 (N + 1). $
The counting problem we are dealing with is simply that of how many ways we can distribute $m$ identical quanta amongst $N$ oscillators? The answer is provided by the binomial coefficient,
$ Omega_m = Omega(E_m) = binom(N + m - 1, m) = (N + m - 1)!/(m! (N - 1)!), $
where $E_m = E_min + m planck omega = (N/2 + m) planck omega$. For $m in {0, 1, 2, 3, 4}$, we thus get the following numbers of states.
#align(center, table(
  columns: 6,
  stroke: none,
  align: left,
  table.hline(stroke: 0.8pt),
  [$m$], [0], [1], [2], [3], [4],
  table.hline(stroke: 0.5pt),
  [$Omega_m$], [1], [$N$], [$N/2 (N + 1)$], [$N/6 (N + 1)(N + 2)$], [$N/24 (N + 1)(N + 2)(N + 3)$],
  table.hline(stroke: 0.8pt),
))
Now that we have the number of states at a given energy, it is a trivial matter to derive the entropy $S_m$ of $N$ oscillators with total energy $E_m$. Using Stirling's approximation for large factorials, $ln(n!) = n ln(n) - n + cal(O)(ln n)$, we get
$
  S_m & = kB ln(Omega_m) = kB (ln[(N + m - 1)!] - ln(m!) - ln[(N - 1)!]) \
      & approx kB ((N + m - 1) ln(N + m - 1) - m ln(m) - (N - 1) ln(N - 1)) \
      & approx kB ((N + m) ln(N + m) - m ln(m) - N ln(N)) \
      & = kB (N ln((N + m)/N) + m ln((N + m)/m)).
$

= Stationary distribution #points(2)

#task[Consider the Boltzmann equation with external force $bF(bx) = -vb(nabla)_x V(bx)$. Find the stationary distribution $f_0 (bx, bp)$.]

The Boltzmann equation describes the dynamical evolution of phase space densities for systems with a large number of constituents such as a gas. It is an integro-differential equation whose significance derives from its ability to describe out-of-equilibrium processes. It reads#footnote[Boltzmann assumed that the influence of the external force $bF$ on the collision rate is negligible to derive @eq:boltzmann.]
$ (partial/(partial t) + bp/m dot vb(nabla)_x + bF dot vb(nabla)_p) f(bx, bp, t) = integral dif^3 k dif^3 p' dif^3 k' |chevron.l bp', bk'|T|bp, bk chevron.r|^2 [f_(p') f_(k') - f_p f_k]. $ <eq:boltzmann>
The above formulation already incorporates the Stosszahlansatz, also known as molecular chaos, which assumes that the collision term results solely from two-body collisions between particles that are uncorrelated prior to the collision.#footnote[Molecular chaos can also intuitively be interpreted as the assumption that the velocities of two particles about to collide are uncorrelated.] This was the key assumption by Boltzmann, as it allows to write the collision term as a momentum-space integral in which the two-particle correlator $F(bx, bp, bk, t)$ factorizes into two one-particle distribution functions $f(bx, bp, t) f(bx, bk, t)$. The term $[f_(p') f_(k') - f_p f_k]$ in @eq:boltzmann is a shorthand notation for $[f(bx, bp', t) f(bx, bk', t) - f(bx, bp, t) f(bx, bk, t)]$. \
For a stationary system, the Boltzmann equation greatly simplifies in two ways. On the one hand, the particle distribution loses its explicit time-dependence, $f(bx, bp, cancel(t))$. On the other hand, stationarity implies that the Boltzmann $H$-function must be time-independent, since its time-dependence derives exclusively from $f(bx, bp, t)$,
$ H(t) = integral dif^3 x integral dif^3 p f(bx, bp, t) ln[f(bx, bp, t)]. $
A stationary $H$ results in a condition known as detailed balance (see lecture notes from November 22), in which the number of particles leaving a certain mode due to a given scattering process is exactly equal to the number of particles entering that mode by the reverse process. Conceptually:
#align(center, box(scattering($p$, $k$, $p'$, $k'$)) + h(1em) + box(baseline: -0.6em, text(size: 14pt)[$=$]) + h(1em) + box(scattering($p'$, $k'$, $p$, $k$)))
Under these circumstances, the loss and gain terms $f_p f_k$ and $f_(p') f_(k')$ in @eq:boltzmann exactly cancel, meaning the r.h.s. of the Boltzmann equation vanishes. We are left with
$
  bp/m dot vb(nabla)_x f_0 (bx, bp) & = -bF(bx) dot vb(nabla)_p f_0 (bx, bp) \
                                    & = vb(nabla)_x V(bx) dot vb(nabla)_p f_0 (bx, bp).
$ <eq:stationary>
This partial differential equation is solved by the ansatz
$ f_0 (bx, bp) = alpha exp(beta/(2 m) (bp - bp_0)^2 + gamma V(bx)) + delta. $ <eq:ansatz>
Reinserting @eq:ansatz into @eq:stationary gives
$ bp/m dot gamma vb(nabla)_x V(bx) = vb(nabla)_x V(bx) dot beta/m (bp - bp_0), $
from which we infer $beta = gamma$ and $bp_0 = 0$. Moreover, normalizability of the phase space density requires $delta = 0$. Thus, $f_0 (bx, bp) = alpha e^(beta (bp^2/(2 m) + V(bx)))$. For
$ alpha = (2 pi m kB T)^(-d/2) (integral dif^d x e^(beta V(bx)))^(-1), #h(3em) beta = -1/(kB T), $
this is precisely the Maxwell-Boltzmann distribution in $d$ dimensions.

= Pressure on a wall #points(3)

#task[
  Compute the pressure of an ideal gas in three dimensions upon a wall at $x = 0$ that attracts molecules at large distance and repels them at smaller distance. Let the force be given by the potential
  $ U(x) = -A e^(-alpha x) + B e^(-2 alpha x), $
  with $A, B > 0$. Consider separately the cases where the range of the force is
  + small compared to the mean free path $ell$, and
  + comparable to it.
]

#align(center, wall-potential)
The energy of a particle in the vicinity of the wall where $U(x) != 0$ is
$ E(x, dot(bx)) = m/2 dot(bx)^2 + U(x). $
Energy must be conserved during collisions with the wall. Since the potential depends only on $x$ (rather than $bx$), the transverse energy $E_t = m/2 (dot(y)^2 + dot(z)^2)$ is separately conserved from the normal contribution
$ E_n = E - E_t = m/2 dot(x)^2 + U(x). $
We can solve the latter for the velocity in $x$-direction,
$ dot(x)(x) = plus.minus sqrt(2/m [E_n - U(x)]). $ <eq:velocity>
The pressure on the wall is determined by the total momentum transfer from all particle collisions. If a single particle encounters the wall at time $t_0$, its change in momentum is
$
  Delta p_x & = p_x (t_0 + tau) - p_x (t_0 - tau) \
            & = m [dot(x)(t_0 + tau) - dot(x)(t_0 - tau)],
$ <eq:momentum-transfer>
where $tau = ell \/ macron(v)_x$ is the characteristic scattering time inversely proportional to the average velocity in $x$-direction $macron(v)_x = sqrt(2 E_n \/ m)$.
+ In the weak scattering case where the range of the force $1 \/ alpha$ is much smaller than the mean free path $ell$, the velocity $dot(x)(t_0 plus.minus tau) approx dot(x)(ell)$ in @eq:momentum-transfer will be evaluated at a distance $ell$ from the wall. This is because $x(t_0) = 0$ and the particle moves towards/away from the wall with $macron(v)_x$ carrying it to a distance of approximately $macron(v)_x tau = ell$ within the scattering time $tau$. At $x approx ell$, the potential becomes negligible. Inserting @eq:velocity into @eq:momentum-transfer for $U(ell) approx 0$ gives
  $ Delta p_(x,a) = 2 sqrt(2 m E_n) $
+ In the strong scattering case, the scattering time $tau = ell \/ macron(v)_x$ is much shorter and the mean free path decreases, becoming of the order of the range of the force $1/alpha approx ell$. To compute the momentum transfer, the velocity will now be evaluated at a shorter distance $ell$ from the wall where the potential still exerts a significant attraction on the particle, $F_x = -partial_x U(ell) < 0$. This increases the momentum transfer onto the wall and thus the pressure,
  $ Delta p_(x,b) = 2 sqrt(2 m [E_n - U(x)]) limits(approx)^(B e^(-alpha x) << A) 2 sqrt(2 m (E_n + A e^(-alpha x))) > 2 sqrt(2 m E_n) = Delta p_(x,a). $
  To get a more quantitative result, rather than this rough approximation, we can separate variables in @eq:velocity to get
  $ (dif x)/(plus.minus sqrt(2/m [E_n - U(x)])) = dif t. $
  The solution to this differential equation is
  $ x(t) = 1/alpha ln[xi cosh[alpha macron(v)_x (t - t_0)] - A/(2 E_n)], #h(3em) "where" xi = (B/E_n + A^2/(4 E_n^2))^(1/2). $ <eq:trajectory>
  Differentiating @eq:trajectory w.r.t. time results in the velocity
  $ dot(x)(t) = (sinh[alpha macron(v)_x (t - t_0)])/(cosh[alpha macron(v)_x (t - t_0)] - A/(2 E_n xi)) macron(v)_x, $
  and the momentum transfer
  $
    Delta p_(x,b) & = m [dot(x)(t_0 + tau) - dot(x)(t_0 - tau)] \
    & = m macron(v)_x [(sinh[alpha macron(v)_x tau])/(cosh[alpha macron(v)_x tau] - A/(2 E_n xi)) - (sinh[-alpha macron(v)_x tau])/(cosh[-alpha macron(v)_x tau] - A/(2 E_n xi))] \
    & = Delta p_(x,a) (sinh[alpha macron(v)_x tau])/(cosh[alpha macron(v)_x tau] - A/(2 E_n xi)),
  $
  where we used $sinh(-x) = -sinh(x)$ and $cosh(-x) = cosh(x)$. Since $alpha macron(v)_x tau = alpha ell approx 1$, we can approximate this as
  $ Delta p_(x,b) = Delta p_(x,a) (1 + A/(E_n xi) e^(-alpha macron(v)_x tau)). $
  Again, this is larger than the momentum transfer we obtained in the weak scattering case, resulting in an increased pressure on the wall.
