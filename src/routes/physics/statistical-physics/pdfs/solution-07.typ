#import "/notes.typ": task, kB, pd
#import "/statistical-physics/sheet.typ": points, sheet, cE
#import "@preview/cetz:0.5.2": canvas, draw
#import "@preview/cetz-plot:0.1.4": plot

#show: sheet.with(7, [December 16th, 2016])

#let Ndown = $N_arrow.b$

// Projection P of the energy shell onto position space: an ellipse with semi-axes sqrt(2E/m)
// and sqrt(2E/k). With the Lissajous figure, also the rectangle R the motion is confined to.
#let position-space(lissajous: false) = canvas(length: 1cm, {
  import draw: *
  set-style(stroke: 0.6pt)
  let (a, b) = (3.6, 2.2)
  line((-4, 0), (4.2, 0), mark: (end: "stealth", fill: black, scale: 0.5))
  line((0, -2.6), (0, 2.8), mark: (end: "stealth", fill: black, scale: 0.5))
  content((4.2, 0), $q_1$, anchor: "west", padding: 2pt)
  content((0, 2.8), $q_2$, anchor: "south", padding: 2pt)
  circle((0, 0), radius: (a, b), stroke: blue + 0.8pt, fill: blue.transparentize(93%))
  line((0, b), (0.5, 2.6), stroke: luma(130) + 0.4pt)
  content((0.5, 2.6), text(size: 7pt, $sqrt(2 E \/ k)$), anchor: "south-west")
  line((a, 0), (3.9, 0.5), stroke: luma(130) + 0.4pt)
  content((3.9, 0.5), text(size: 7pt, $sqrt(2 E \/ m)$), anchor: "south-west")
  content((2.8, 0.45), text(fill: blue, $P$))
  if lissajous {
    let orange = rgb("#ff8000")
    // corners of the rectangle touch the ellipse
    let (x0, y0) = (a * 0.7, b * calc.sqrt(1 - 0.49))
    rect((-x0, -y0), (x0, y0), stroke: orange + 0.8pt, fill: orange.transparentize(88%))
    // q_1 = x0 cos(t), q_2 = y0 cos(2t + delta) closes after one period
    let pts = range(0, 401).map(i => {
      let t = 2 * calc.pi * i / 400
      (x0 * calc.cos(t), y0 * calc.cos(2 * t + 0.25))
    })
    line(..pts, stroke: red + 0.8pt)
    content((-1.05, y0 - 0.35), text(fill: orange, $R "for" omega in.not QQ$))
    content((2.15, -1.05), text(fill: red, align(center)[$R$ for \ $omega = 2 in QQ$]))
  }
})

#let tanh-plot = canvas({
  plot.plot(
    size: (6, 4.2),
    x-label: $x$,
    y-label: $tanh(x)$,
    x-tick-step: 1,
    y-tick-step: 0.5,
    axis-style: "school-book",
    y-min: -1.2,
    y-max: 1.2,
    {
      plot.add(x => calc.tanh(x), domain: (-2, 2), samples: 100, style: (stroke: blue + 0.8pt))
      plot.add(x => x, domain: (-1, 1), style: (stroke: (paint: blue, dash: "dashed", thickness: 0.5pt)))
    },
  )
})

= Dynamics of a Hamiltonian system #points(4)

#task[
  Consider the motion of a particle in two dimensions in a harmonic potential. In terms of the coordinate vector $q = (q_1, q_2)$, and in suitably chosen length and time units, the Newtonian equations of motion are
  $ dot.double(q)_1 = -q_1, #h(3em) dot.double(q)_2 = -omega^2 q_2, $ <eq:newton>
  where $omega > 0$.
  + Formulate the potential and the Hamiltonian $H(p, q)$ for which @eq:newton arise as the Hamiltonian equations of motion. Interpret $omega$.
  + Determine the energy shell $cE$ in phase space for an energy $E > 0$, and its geometric shape. Determine also the projection $P$ of the energy shell onto position space; how can one describe $P$ geometrically? Is the region $R$, in which the motion in coordinate space really takes place, all of $P$ or a proper subset of $P$? How can one describe $R$ geometrically?
  + Describe the motion in $P$ for $omega = 3 \/ 2$ and $omega = sqrt(2)$ qualitatively.
  + Are there constants of motion besides the Hamiltonian? Is the system ergodic for any of the two values of $omega$ given in c)?
]

+ Hamilton's equations read
  $ dot(q)_i = (partial H)/(partial p_i), #h(3em) dot(p)_i = -(partial H)/(partial q_i), #h(3em) i in {1, 2}. $ <eq:hamilton>
  For $omega^2 = k \/ m$, where $m$ denotes the mass of the particle and $k$ determines the slope of the potential in $q_2$-direction (it may be thought of as a spring constant), we write the potential as
  $ V(q) = m/2 q_1^2 + k/2 q_2^2. $
  Then the Hamiltonian takes the form
  $ H(p, q) = p_1^2/(2 m) + p_2^2/(2 m) + m/2 q_1^2 + k/2 q_2^2. $ <eq:hamiltonian>
  Inserting @eq:hamiltonian into Hamilton's equations yields
  $ dot(q)_1 = p_1/m, #h(3em) dot(q)_2 = p_2/m, #h(3em) dot(p)_1 = -m q_1, #h(3em) dot(p)_2 = -k q_2. $
  By differentiating the first two equations w.r.t. time and inserting the second two, we recover the Newtonian equations of motion @eq:newton. \
  $omega$ is the angular frequency of the oscillatory motion of the particle in $q_2$-direction.
+ The energy shell $cE$ at energy $E$ is the subset of phase space $Gamma$ defined by
  $ cE = {x = (p, q) in Gamma mid(|) H(p, q) = E}. $
  Inserting @eq:hamiltonian, we get
  $ p_1^2/(2 m) + p_2^2/(2 m) + m/2 q_1^2 + k/2 q_2^2 = E, $
  which defines the three-dimensional surface of a four-dimensional ellipsoid with semi-principal axes of length $sqrt(2 m E)$, $sqrt(2 m E)$, $sqrt(2 E \/ m)$, and $sqrt(2 E \/ k)$ in dimensions $p_1$, $p_2$, $q_1$, and $q_2$, respectively. \
  Projected onto two-dimensional position space, the shadow of this ellipsoid gives the area enclosed by an ellipse with semi-principal axes $sqrt(2 E \/ m)$, and $sqrt(2 E \/ k)$.
  #align(center, position-space())
  Solving Newton's equations of motion @eq:newton with initial conditions $q_i (0) = q_(i,0)$ and $p_i (0) = p_(i,0)$, we find
  $
    q_1 (t) & = q_(1,0) cos(t) + p_(1,0)/m sin(t), \
    q_2 (t) & = q_(2,0) cos(omega t) + p_(2,0)/(m omega) sin(omega t), #h(3em) "with" p_i = m dot(q)_i.
  $ <eq:solution>
  Since the motion in $q_1$- and $q_2$-direction decouples, $R subset P$ can at most be a rectangle inscribed into the region $P$. The lengths of the sides of this rectangle are determined by the energies $E_1$ and $E_2$ available in dimensions $q_1$ and $q_2$, which are conserved over time and determined by the initial conditions. \
  However, there is still an interesting distinction to make on whether or not $R$ is dense (after an infinite time) within the rectangle it can at most inscribe in $P$. This depends on two factors:
  #set enum(numbering: "1.")
  + The initial conditions we impose. Consider for instance $q_(1,0) = 1$, $p_(1,0) = 0$, $q_(2,0) = 0$, $p_(2,0) = 0$. In this case, $q_2 (t) = 0$ for all times and $q_1$ oscillates according to $q_1 (t) = cos(t)$. The trajectory never leaves the $q_1$-axis and hence the region $R$ in which the motion actually takes place is just $R = {(q_1, 0) | q_1 in [-1, 1]}$.
  + The ratio between the frequencies $omega_1 = 1$ and $omega_2 = omega$. If one ignores such pathological cases as in 1., then two possibilities remain. For $omega_2 \/ omega_1 = omega in QQ$, i.e. when $omega$ is rational, there is a finite time $t_c$ after which the trajectory closes. This may be seen as follows. Let $omega = m/n > 0$ with $m, n in NN$. Then for $t_c = 2 pi n$, we have $q_1 (t) = q_1 (t + t_c)$ and $q_2 (t) = q_2 (t + t_c)$ due to the $2 pi$-periodicity of sine and cosine. An orbit that closes after a finite time can never become dense in the $P$-inscribed rectangle.

    On the other hand, if $omega in.not QQ$ is irrational, the orbit never closes. After an infinite time, the orbit will then trace out the full rectangle of accessible states.
  #align(center, position-space(lissajous: true))
+ As explained in b), for $omega = 3 \/ 2$, the orbit will close after a time $t_c = 4 pi$ (Lissajous curve), while for $omega = sqrt(2)$ the trajectory never closes, instead becoming dense in $R subset P$ for $t -> infinity$ (provided we don't consider pathological initial conditions).
+ Since there are no coupling terms in the Hamiltonian, we may write $H(p_1, p_2, q_1, q_2) = H_1 (p_1, q_1) + H_2 (p_2, q_2)$, i.e. the particle describes two uncoupled harmonic oscillators, one in each dimension. Energy is conserved under Hamiltonian time-evolution and $H_1$ and $H_2$ both satisfy Hamilton's equations @eq:hamilton. Thus, they are conserved individually. Their values depend on the initial conditions,
  $ H_1 = p_(1,0)^2/(2 m) + m/2 q_(1,0)^2, #h(3em) H_2 = p_(2,0)^2/(2 m) + k/2 q_(2,0)^2, #h(3em) forall t. $
  The fact that $H_1$ and $H_2$ are conserved individually explains why motion is restricted to the rectangle $q_(i,min) <= q_i <= q_(i,max)$, $i in {1, 2}$ whose corners touch the edge of $P$. \
  Furthermore, if $omega = 1$, the potential becomes isotropic, i.e. it attains rotational symmetry under $S O(2)$ acting on $(q_1, q_2)$. By Noether's theorem, we expect an additional conserved quantity, namely the angular momentum $L$. In two dimensions, $L$ is the scalar quantity
  $ L = q_1 p_2 - q_2 p_1. $
  Using @eq:solution, this is easily shown to be conserved,
  $
    L & = (q_(1,0) cos(t) + p_(1,0)/m sin(t)) (-m q_(2,0) sin(t) + p_(2,0) cos(t)) \
      & quad - (q_(2,0) cos(t) + p_(2,0)/m sin(t)) (-m q_(1,0) sin(t) + p_(1,0) cos(t)) \
      & = (q_(1,0) p_(2,0) - q_(2,0) p_(1,0)).
  $
  Ergodicity requires time and ensemble averages of any observable to be equal. Since $R subset P$ for all values of $omega$ both rational and irrational, it is obvious that the system is not ergodic. Averaging over time corresponds to averaging over the restricted set $R subset P$, which cannot be equal to the average over the ensemble of initial conditions sampling all of $P$.

= Time evolution of the Gibbs entropy #points(3)

#task[
  Assume that an ensemble of initial conditions at constant energy $E$ is given by a distribution $x = (q, p) |-> w_0 (x)$ on phase space $Gamma$, and that $w_t$ is the distribution obtained from it by Hamiltonian time evolution. Determine how the entropy
  $ sigma(w_t) = -kB integral_Gamma w_t (x) ln w_t (x) dif mu_m (x) $
  changes with time. (Here $dif mu_m (x) = delta(E - H(x)) dif^(6 N) x$ is the unnormalized microcanonical measure.#footnote[We can fix the units, i.e. make $dif mu_m (x)$ dimensionless, correct the counting of states for systems of identical particles, and thus avoid the Gibbs paradox by including the factor $1/(h^(3 N) N!)$.])
]

Hamiltonian time evolution is described by the flow $Phi_t: Gamma -> Gamma$ mapping an initial condition $x$ to its position $Phi_t (x)$ at time $t$. Liouville's theorem states that the phase-space density is constant along trajectories,
$ (dif w_t)/(dif t) = (partial w_t)/(partial t) + {w_t, H} = 0 quad <=> quad w_t (x) = w_0 (Phi_(-t) (x)), $
i.e. the phase-space probability density flows like an incompressible fluid. Equivalently, $Phi_t$ preserves the Liouville measure $dif^(6 N) x$. Since $H$ is conserved along trajectories, $H(Phi_t (y)) = H(y)$, the flow also preserves the microcanonical measure $dif mu_m$. Substituting $x = Phi_t (y)$ thus gives
$ sigma(w_t) = -kB integral_Gamma w_0 (Phi_(-t) (x)) ln w_0 (Phi_(-t) (x)) dif mu_m (x) = -kB integral_Gamma w_0 (y) ln w_0 (y) dif mu_m (y) = sigma(w_0). $
Thus, the Gibbs entropy is constant under Hamiltonian time evolution,
$ (dif sigma)/(dif t) = 0. $

= Ideal paramagnet #points(3)

#task[Using the results derived in the lectures and the Gibbs fundamental relation, calculate the thermodynamic equation of state for the ideal paramagnet of independent spins, and solve it approximately in the limits $h m << kB T$ and $h m >> kB T$, where $h$ denotes the external field and $m$ the magnetic moment of a single spin.]

The energy of an ideal paramagnet consisting of $N$ uncoupled Ising spins in the configuration $s = (s_1, ..., s_N) in cal(S)_N = {plus.minus 1}^N$, each of magnetic moment $m > 0$ and subject to the external field $h$ is $H(s) = -h m sum_(j=1)^N s_j$. A given energy shell corresponds to a fixed number $Ndown$ of down spins $s_j = -1$, and the microcanonical partition function is the number of such configurations,
$ Z_m = binom(N, Ndown) = N!/(Ndown! (N - Ndown)!). $
Since the spins are uncoupled, all possible configurations that conform to a given macrostate are equally likely to occur, justifying the use of the microcanonical ensemble. \
The entropy $S = kB ln(Z_m)$ is maximized in the microcanonical ensemble. $Ndown = N/2$ maximizes the binomial coefficient, so we insert $Ndown = (N - k)/2$, where $k << N$ parametrizes fluctuations, and use Stirling's approximation for large factorials to write $S$ as
$
  S(E, h) & = kB (ln(N!) - ln(Ndown !) - ln[(N - Ndown)!]) \
  & approx kB (N ln(N) - cancel(N) - (N - k)/2 ln((N - k)/2) + cancel((N - k)/2) - (N + k)/2 ln((N + k)/2) + cancel((N + k)/2)) \
  & = kB (N ln(2 N) - cancel(N ln(2)) - (N - k)/2 ln(N - k) + cancel((N - k)/2 ln(2)) - (N + k)/2 ln(N + k) + cancel((N + k)/2 ln(2))) \
  & = N kB ln(2) - (N kB)/2 [(1 - k/N) ln(1 - k/N) + (1 + k/N) ln(1 + k/N)] \
  & = N kB ln(2) - (N kB)/2 [(1 + E/(N m h)) ln(1 + E/(N m h)) + (1 - E/(N m h)) ln(1 - E/(N m h))],
$
where $E = -k m h$ is the energy of the configuration. \
The Gibbs fundamental relation for a magnetic system exhibiting total magnetization $M$ and subject to the magnetic field $h$ reads
$ dif S(E, h) = 1/T dif E + M/T dif h. $
Therefore,
$
  1/T & = pd(S, E, h) = -kB/(m h) "arctanh"(E/(N m h)) \
  M/T & = pd(S, h, E) = (kB E)/(m h^2) "arctanh"(E/(N m h))
$ <eq:fundamental>
Solving the first of eqs. @eq:fundamental for $E$ gives
$ E = -N m h tanh((m h)/(kB T)). $
Inserting this into the second yields the magnetization
$ M(h, T) = N m tanh((m h)/(kB T)). $
The plot below shows that $tanh(x) -> plus.minus 1$ for $x -> plus.minus infinity$ while $tanh(x) approx x$ for $|x| << 1$.
#align(center, tanh-plot)
The asymptotic behavior of the magnetization at low and high temperatures is thus
$ M approx cases((N m^2 h)/(kB T) quad & "for" m h << kB T\, wide "(Curie's law)", N m & "for" m h >> kB T.) $
An intuitive interpretation of this result is that for low temperatures, all spins align to give a large magnetization, whereas for high temperatures, thermal fluctuations disturb spin alignment, resulting in a low magnetization that tends to zero as $m h \/ kB T -> 0$.
