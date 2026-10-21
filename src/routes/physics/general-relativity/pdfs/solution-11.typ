#import "/notes.typ": notes, task
#import "@preview/cetz:0.5.2": canvas, draw

#show: notes.with(
  title: [General Relativity -- Exercise Sheet 11],
  subtitle: [Exercise sheet 11, General Relativity, Prof. Björn Malte Schäfer],
  date: [Solutions by Roland Walz and Janosh Riebesell, 24.06.2015],
)

// Christoffel symbol with upper index a and lower indices b
#let chr(a, b) = $attach(Gamma, tr: #a, br: #b)$
#let vr = $arrow(r)$
#let vv = $arrow(v)$
#let vw = $arrow(omega)$
#let vh = $arrow(h)$
#let nab = $arrow(nabla)$
#let Om = $arrow(Omega)$
#let tR = $tilde(R)$

= Problem 1 ($h_(0 i)$ again!) [15 points]

#task[
  The gravitational field $h_(mu nu) (vr)$ of a constantly rotating ball of radius $R$ and mass $M$ contains at leading order (in $v/c$) not only a quasi-Newtonian term
  $ h_(mu mu) (r) = -(2 phi(r))/c^2, quad "where" phi(r) = (G M)/r, $
  but also a term related to the angular velocity $omega$,
  $ h_(0 i) (r) = -(4 G M R^2)/(5 c^3 r^3) epsilon_(i j k) omega^j x^k. $
  We will investigate how this perturbation affects geodesics when approximating $dif t = dif tau$ and $u = (c, vv)$.
]

#task(label: "a")[
  Reason why the Christoffel symbols $chr(alpha, mu nu)$ can be written as
  $ chr(alpha, mu nu) = eta^(alpha sigma)/2 (partial_mu h_(nu sigma) + partial_nu h_(mu sigma) - partial_sigma h_(mu nu)) $
  in the weak-field limit, in which terms of order $cal(O)(h^2)$ are discarded.
]

The definition of the Christoffel symbols reads
$ chr(alpha, mu nu) := g^(alpha sigma)/2 (partial_mu g_(nu sigma) + partial_nu g_(mu sigma) - partial_sigma g_(mu nu)). $
We take $g_(mu nu)$ to be the Minkowskian metric perturbed by an expansion in $h_(mu nu) (vr)$,
$ g_(mu nu) (vr) = eta_(mu nu) + h_(mu nu) (vr), $
where $h_(mu nu)$ is small. Since the Minkowskian part of $g_(mu nu) (vr)$ is spatially invariant, it drops when taking spatial derivatives, i.e. $partial_sigma g_(mu nu) (vr) = partial_sigma h_(mu nu) (vr)$. If we then multiply these derivatives with $g^(mu nu) (vr)$, only the Minkowskian part survives since all combinations of $h^(mu nu) (vr) partial_sigma h_(rho nu) (vr)$ are of order $cal(O)(h^2)$ and hence don't contribute in our approximation. Thus,
$ chr(alpha, mu nu) = eta^(alpha sigma)/2 (partial_mu h_(nu sigma) (vr) + partial_nu h_(mu sigma) (vr) - partial_sigma h_(mu nu) (vr)). $

#task(label: "b")[
  Write down the geodesic equation $dot(u)^alpha + chr(alpha, mu nu) u^mu u^nu = 0$ for the metric discussed. Show that it becomes
  $ a^i + c^2 chr(i, 00) + 2 c chr(i, 0 j) v^j = 0, $
  if we once again discard all terms of order $v^2\/c^2$.
]

Restricting ourselves to the acceleration's spatial components $a^i = dot(u)^i$, we get
$
  a^i + chr(i, mu nu) u^mu u^nu & = a^i + chr(i, 00) underbrace(u^0 u^0, c^2) + chr(i, 0 j) u^0 v^j + underbrace(chr(i, j 0), chr(i, 0 j)) u^j u^0 + chr(i, j k) underbrace(u^j u^k, cal(O)(v^2\/c^2)) \
  & = a^i + c^2 chr(i, 00) + 2 c chr(i, 0 j) v^j = 0.
$

#task(label: "c")[
  Show that the first term is the expected Newtonian gravity, i.e. $-partial_i phi(vr) = F_(N, i) (vr)$. Show that the second term is $-c (nab times vh times vv)^i$, where $vh = (h_(01), h_(02), h_(03))^T$. Setting $nab times vh =: Om$, is it surprising that
  $ arrow(F) = m arrow(a) = m(-nab phi + 2 Om times vv) $
  is called gravitomagnetic force?
]

$
  c^2 chr(i, 00) & = c^2/2 eta^(i sigma) (partial_0 h_(0 sigma) (vr) + partial_0 h_(0 sigma) (vr) - partial_sigma h_(00) (vr)) = c^2/2 eta^(i i) (2 underbrace(partial_t h_(0 i) (vr), 0) - partial_i h_(00) (vr)) \
  & = c^2/2 partial_i (-(2 phi(vr))/c^2) = -partial_i phi(vr) =: F_(N, i) (vr), \
  2 c chr(i, 0 j) v^j & = 2 c eta^(i sigma)/2 (underbrace(partial_0 h_(j sigma) (vr), 0) + partial_j h_(0 sigma) (vr) - partial_sigma h_(0 j) (vr)) v^j \
  & = c eta^(i i) (partial_j h_(0 i) (vr) - partial_i h_(0 j) (vr)) v^j = -c ([nab times vh(vr)] times vv)^i.
$
Multiplying the geodesic equation derived in part b) with a test mass $m$, we obtain the aforementioned equation of motion,
$ arrow(F)(vr) = m arrow(a)(t) = m (nab phi(vr) + underbrace(c [nab times vh(vr)], := Om(vr)) times vv) = -m (-nab phi(vr) + vv times Om(vr)). $
Except for an overall sign, which can always be absorbed by redefining the fields, this is very reminiscent of the electromagnetic Lorentz force
$ arrow(F)_L (vr) = e (-nab phi(vr) + vv times arrow(B)(vr)), $
justifying the name of gravitomagnetic force (except maybe for the fact that there is nothing magnetic about it).

#task(label: "d")[Compare both contributions for the effect the sun and its rotation have on the innermost planet, Mercury, under the assumption that Mercury's orbital plane is perpendicular to the sun's rotational axis.]

$ |-nab phi(vr)| = |-nab (G M)/r| = |(G M)/r^2 arrow(e)_r| = (G M)/r^2. $
With $vh(vr) = -(4 G M R^2)/(5 c^3 r^3) vw times vr$, where $vr$ points at Mercury's current position, we get for the second contribution

#grid(
  columns: (1fr, auto),
  column-gutter: 1em,
  align: horizon,
  $ nab times (vw times vr/r^3) = nab times 1/r^3 vec(omega_2 r_3 - omega_3 r_2, omega_3 r_1 - omega_1 r_3, omega_1 r_2 - omega_2 r_1), quad 1/r^3 = (r_1^2 + r_2^2 + r_3^2)^(-3\/2) $,
  canvas(length: 1cm, {
    import draw: *
    set-style(stroke: 0.6pt)
    let tip = (end: "stealth", fill: black, scale: 0.7)
    circle((0, 0), radius: (1.5, 0.75))
    circle((0, 0), radius: 0.06, fill: black)
    content((-0.1, 0), text(size: 8pt)[sun], anchor: "east")
    line((0, 0), (0, 1.5), mark: tip)
    content((0.05, 1.5), $vw$, anchor: "west")
    arc((0.2, 1.15), start: 0deg, stop: 300deg, radius: 0.2, mark: (end: "stealth", fill: black, scale: 0.5))
    let m = (1.06, -0.53)
    line((0, 0), m, stroke: (dash: "dashed"))
    content((0.5, -0.27), $vr$, anchor: "south-west")
    circle(m, radius: 0.06, fill: black)
    line(m, (1.6, 0.05), mark: tip)
    content((1.6, 0.05), $vv$, anchor: "west")
    content((1.06, -0.62), text(size: 8pt)[Mercury], anchor: "north-west")
  }),
)
$
  & = vec(
    partial_2 (omega_1 r_2 - omega_2 r_1) \/ r^3 - partial_3 (omega_3 r_1 - omega_1 r_3) \/ r^3,
    partial_3 (omega_2 r_3 - omega_3 r_2) \/ r^3 - partial_1 (omega_1 r_2 - omega_2 r_1) \/ r^3,
    partial_1 (omega_3 r_1 - omega_1 r_3) \/ r^3 - partial_2 (omega_2 r_3 - omega_3 r_2) \/ r^3,
  ) \
  & = vec(
    omega_1 \/ r^3 - 3 r_2 (omega_1 r_2 - omega_2 r_1) \/ r^5 + omega_1 \/ r^3 + 3 r_3 (omega_3 r_1 - omega_1 r_3) \/ r^5,
    omega_2 \/ r^3 - 3 r_3 (omega_2 r_3 - omega_3 r_2) \/ r^5 + omega_2 \/ r^3 + 3 r_1 (omega_1 r_2 - omega_2 r_1) \/ r^5,
    omega_3 \/ r^3 - 3 r_1 (omega_3 r_1 - omega_1 r_3) \/ r^5 + omega_3 \/ r^3 + 3 r_2 (omega_2 r_3 - omega_3 r_2) \/ r^5,
  ) \
  & = 2/r^3 vw - 3/r^5 vr times (vw times vr) = 2/r^3 vw - 3/r^5 (vw underbrace((vr dot vr), r^2) - vr underbrace((vr dot vw), 0)) = -1/r^3 vw,
$
$
  |-c [nab times vh(vr)] times vv| & = |(4 G M R^2)/(5 c^2) [underbrace(nab times (vw times vr/r^3), -vw\/r^3)] times vv| = |-(4 G M R^2)/(5 c^2 r^3) vw times vv| \
  & = |-(4 G M R^2)/(5 c^2 r^3) |vw| |vv| arrow(e)_r| = (4 G M R^2)/(5 c^2 r^3) omega v,
$
where $omega$ is the angular velocity of the sun and $v$ is the orbital speed of Mercury. We denote all parameters describing the sun with an index $dot.o$, all those of Mercury with an index $M$. Using $omega = 2 pi f = (2 pi)/T$ and $v = omega r = (2 pi r)/T$, we get the following comparison
$
  (|-nab phi(vr)|)/(|-c [nab times vh(vr)] times vv|) & = ((G M_dot.o)\/r_M^2)/((4 G M_dot.o R_dot.o^2)/(5 c^2 r_M^3) omega_dot.o v_M) = (5 c^2 r_M)/(4 R_dot.o^2 omega_dot.o v_M) = (5 c^2 r_M)/(4 R_dot.o^2 (2 pi)/T_dot.o (2 pi r_M)/T_M) = (5 c^2 T_dot.o T_M)/(16 pi^2 R_dot.o^2) \
  & approx 9.538 dot 10^10,
$
when inserting $T_dot.o = 25 "d"$, $T_M = 88 "d"$, $R_dot.o = 7 dot 10^8 "m"$.

= Problem 2 (Particles reacting to gravitational waves) [15 points]

#task[
  Consider a gravitational wave in the 1-2 plane and the transverse-traceless gauge amplitude tensor
  $ underline(A) = mat(0, 0, 0, 0; 0, a, b, 0; 0, b, -a, 0; 0, 0, 0, 0). $
]

#task(label: "a")[What does the time-dependent part of the metric $g_(mu nu) (arrow(x), t) = eta_(mu nu) + h_(mu nu) (arrow(x), t)$ describing a gravitational wave look like? How many components of $x$ does $h$ depend upon?]

Since $A_(mu nu)$ is traceless, $overline(h)_(mu nu) = h_(mu nu) = A_(mu nu) exp(plus.minus i k_sigma x^sigma)$. Therefore, the time dependence of the metric goes like $g_(mu nu) (arrow(x), t) prop e^(plus.minus i k_0 x^0) = e^(plus.minus i omega t)$. We may always transform our coordinates such that $k = (omega, 0, 0, k_3)$. Thus, $g_(mu nu)$ depends only on two $x$-components.

#task(label: "b")[Considering the geodesic equation from the above exercise, what can we say about the spatial acceleration of a particle $a^i$ at $tau = 0$ if we require that the particles were resting at $tau = 0$? What are the conclusions about $x^i (tau)$?]

If $v^i (tau = 0) = 0$, then $2 c chr(i, 0 j) v^j = 0$. Looking at $A_(mu nu)$, we see that $c^2 chr(i, 00)$ too is zero. Therefore, $a^i = 0$ and hence $v^i = 0 med forall tau$. Consequently, $x^i (tau) = "const"$, meaning particles don't change their position.

#task(label: "c")[
  We split up the line element according to
  $ dif s^2 = c^2 dif t^2 - dif l^2 - (dif x^3)^2, $
  then $dif l^2 = (delta_(i j) - h_(i j) (t)) dif x^i dif x^j$, where $i, j in {1, 2}$. Write $h$ in terms of the Pauli matrices $sigma$.
]

$
  h_(mu nu) (arrow(x), t) & = A_(mu nu) e^(plus.minus i (omega t - k_z z)), \
  dif s^2 & = g_(mu nu) dif x^mu dif x^nu = (eta_(mu nu) + h_(mu nu)) dif x^mu dif x^nu = c^2 dif t^2 - (delta_(i j) - h_(i j)) dif x^i dif x^j - (dif x^3)^2, \
  underline(h) & = mat(a, b; b, -a) e^(plus.minus i (omega t - k_z z)) = (b sigma_1 + a sigma_3) e^(plus.minus i (omega t - k_z z)).
$
The required Pauli matrices for the above expression of $h$ are both real and traceless.

#task(label: "d")[
  We imagine a circle of particles $P$ in the 1-2 plane with radius $R$, enabling the description of particle positions by an angle $phi$. The physical distance from the centre $tR$ in physical coordinates $x_P$:
  $ tR^2 = (delta_(i j) - h_(i j) (t)) x_P^i x_P^j. $
  Define those physical coordinates on the plane and then calculate $tR^2$ for i) the '+'- and ii) the '$times$'-modes, i.e. $a = h$, $b = 0$ and $a = 0$, $b = h$, where $h$ is the scalar amplitude.
]

We set $arrow(x)_P = vec(x_P^1, x_P^2) = R vec(cos phi, sin phi)$, with $R in RR$ constant. In the 1-2 plane $z = 0$ and so $e^(plus.minus i (omega t - k_z z)) = e^(plus.minus i omega t)$. To obtain a physical, i.e. real, distance $tR$ from the centre of the circle, we superposition $h_(i j) = A_(i j) (e^(i omega t) + e^(-i omega t)) = 2 A_(i j) cos(omega t)$.
$
  "i)" quad tR^2 & = delta_(i j) x_P^i x_P^j - h_(i j) (t) x_P^i x_P^j = R^2 cos^2 phi + R^2 sin^2 phi - 2 h cos(omega t) R^2 cos^2 phi + 2 h cos(omega t) R^2 sin^2 phi \
  & = R^2 (1 - 2 h cos(omega t) cos(2 phi)), \
  "ii)" quad tR^2 & = delta_(i j) x_P^i x_P^j - h_(i j) (t) x_P^i x_P^j = R^2 - 2 h cos(omega t) R^2 cos phi sin phi - 2 h cos(omega t) R^2 cos phi sin phi \
  & = R^2 (1 - 4 h cos(omega t) cos phi sin phi) = R^2 (1 - 2 h cos(omega t) sin(2 phi)).
$

= Problem 3 (Gravitational wave induced ellipticity) [10 points]

#task[
  The '+'-mode derived in exercise 2 reads
  $ tR^2 = R^2 (1 - 2 h cos(2 phi) cos(omega t)). $
  We consider weak fields for which $h << 1$.
]

#task(label: "a")[What needs to be fulfilled for maximum displacement?]

$ cos(2 phi) cos(omega t) = plus.minus 1 quad <==> quad phi = (m pi)/2, quad t = (n pi)/omega, quad m, n in ZZ. $
Then $tR = R sqrt(1 plus.minus 2 h) approx R (1 plus.minus h)$.

#task(label: "b")[
  Write $tR^2$ in the form of an ellipse, i.e.
  $ x^2/epsilon_1^2 + y^2/epsilon_2^2 = 1. $
  What are the $epsilon_i$ in terms of $h$?
]

$
  tR^2 & = R^2 (1 - 2 h cos(2 phi) cos(omega t)) = R^2 (1 - 2 h (cos^2 phi - sin^2 phi) cos(omega t)) \
  & = R^2 - 2 h (x^2 - y^2) cos(omega t) = x^2 + y^2 \
  & ==> (1 + 2 h cos(omega t)) x^2/R^2 + (1 - 2 h cos(omega t)) y^2/R^2 = 1.
$
Therefore,
$ epsilon_1^2 = R^2/(1 + 2 h cos(omega t)) quad "and" quad epsilon_2^2 = R^2/(1 - 2 h cos(omega t)). $

#task(label: "c")[$epsilon_1$ and $epsilon_2$ are the semiminor and semimajor axes of an ellipse. Calculate the eccentricity $epsilon$ induced by a gravitational '+'-polarised wave with scalar amplitude $h$.]

$ epsilon = sqrt(1 - epsilon_1^2/epsilon_2^2) = (1 - (1 - 2 h cos(omega t))/(1 + 2 h cos(omega t)))^(1\/2). $

= Problem 4 (Extra: Wave equations) [5 points]

One of the decisive differences between gravity and the electromagnetic force is that the former knows only one charge while the latter has two.

Interchanging two opposite charges, as in an oscillating electric dipole, changes the electric field distribution. That's why electric dipoles radiate off energy in the form of waves.

Gravitational mass on the other hand comes in only one sign. Interchanging two masses therefore does not result in a change of the gravitational field distribution. Thus, at least a varying quadrupole is necessary to perturb the fields and emit gravitational waves.

This gives the graviton spin 2, while the photon only has spin 1. Examples for spin 0 waves with just one polarisation state are the Higgs boson or even acoustical sound.
