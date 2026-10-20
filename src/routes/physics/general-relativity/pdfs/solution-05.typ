#import "/notes.typ": notes, task

#show: notes.with(
  title: [General Relativity -- Exercise Sheet 5],
  subtitle: [Exercise sheet 5, General Relativity, Prof. Björn Schäfer],
  date: [Solutions by Janosh Riebesell, 12.05.2015],
)

// tensor with stacked upper index a and lower indices b, e.g. Christoffel symbols and the Riemann tensor
#let chr(a, b) = $attach(Gamma, tr: #a, br: #b)$
#let riem(a, b) = $attach(R, tr: #a, br: #b)$
#let tmix(a, b) = $attach(T, tr: #a, br: #b)$
// curved swap arrow under exchanged indices, as in the handwritten notes
#let swap(x) = $limits(#x)_(arrow.l.r)$

= Problem 1 (Curvature of a sphere) [15 points]

#task[
  Last week, we calculated the Christoffel symbols
  $ chr(1, 22) = -sin theta cos theta, quad chr(2, 12) = chr(2, 21) = cot theta, $
  on a two-sphere in $RR^3$ with fixed radius $r in RR_+$ constant. The metric was given by $"diag"({g_(mu nu)}) = (1, r^2, r^2 sin^2 theta)$.
]

#task(label: "a")[Calculate all non-vanishing entries of the Riemann tensor $riem(lambda, nu alpha beta)$.]

Ignoring time, the spatial components of the Riemann curvature tensor in terms of the Christoffel symbols are given by
$ riem(i, j k m) := partial_k chr(i, j m) - partial_m chr(i, j k) + chr(i, n k) chr(n, j m) - chr(i, n m) chr(n, j k), $
where $i, j, k, m, n in {x^1 = theta, x^2 = phi.alt}$. As mentioned in the lecture, the Riemann tensor has the symmetries
$ R_(i j k m) = -R_(swap(j i) k m) = -R_(i j swap(m k)), quad R_(i j k m) = R_(swap(k m i j)), quad R_(i j k m) + R_(i k m j) + R_(i m j k) = 0, $
so that it only has $d = n^2/12 (n^2 - 1) = 4^2/12 (4^2 - 1) = 20$ independent components. Using all symmetries and the restriction to a 2-sphere, the Riemann tensor can be written more compactly as $riem(i, j k m) = 1/r^2 (delta^i_k g_(j m) - delta^i_m g_(j k))$. This form makes it plain that $riem(i, j k m) != 0$ only if $i = k$ or $i = m$, so that we may expect four non-zero entries. We compute them using the lecture's definition:
$
  riem(1, 212) & = partial_1 chr(1, 22) - partial_2 underbrace(chr(1, 21), 0) + chr(1, n 1) chr(n, 22) - chr(1, n 2) chr(n, 21) \
  & = partial_1 chr(1, 22) + chr(1, 21) underbrace(chr(2, 22), 0) - chr(1, 22) chr(2, 21) \
  & = partial_theta (-sin theta cos theta) - (-sin theta cos theta) cot theta \
  & = -cos^2 theta + sin^2 theta + cos^2 theta = sin^2 theta = -riem(1, 221).
$
The other possibly non-zero independent entry of the Riemann tensor can be found by looking at $i = 2 hat(=) phi.alt$, instead of 1:
$
  riem(2, 121) & = partial_2 underbrace(chr(2, 11), 0) - partial_1 chr(2, 12) + chr(2, n 2) underbrace(chr(n, 11), 0 thin forall n) - chr(2, n 1) chr(n, 12) \
  & = -partial_1 chr(2, 12) - chr(2, 21) chr(2, 12) = -partial_theta cot theta - cot^2 theta \
  & = -(-sin theta)/(sin theta) - (-cos^2 theta)/(sin^2 theta) - cot^2 theta = 1 = -riem(2, 112).
$

#task(label: "b")[Calculate the Ricci tensor $R_(mu nu)$.]

The Ricci tensor follows immediately from the Riemann tensor by contracting the first and third indices, i.e.
$ R_(j m) = riem(i, j i m). $
Since there is nothing to sum over here, contraction is trivial:
$ R_11 = riem(2, 121) = 1, quad R_22 = riem(1, 212) = sin^2 theta. $
All other entries vanish, so that
$ {R_(j m)} = mat(1, 0; 0, sin^2 theta) = 1/r^2 {g_(j m)}. $

#task(label: "c")[Calculate the Ricci scalar $R$.]

The Ricci scalar in turn follows directly from the Ricci tensor by contraction with the metric $g^(j m)$:
$ R = g^(j m) R_(j m) = g^(j m) 1/r^2 g_(j m) = 1/r^2 delta^m_m = 2/r^2. $

= Problem 2 (Energy-momentum tensor) [10 points]

#task[
  Given the Lagrangian
  $ L = 1/2 g^(mu nu) partial_mu phi.alt partial_nu phi.alt - V(phi.alt), $
  which describes a scalar field $phi.alt(x)$ obeying the Klein-Gordon equation, we're going to find the corresponding energy-momentum tensor.
]

#task(label: "a")[
  Calculate $T^(mu nu)$ with
  $ T^(mu nu) = -2 (delta L)/(delta g_(mu nu)) - L g^(mu nu). quad ("Hint:" delta g^(mu nu) = -g^(mu alpha) g^(nu beta) delta g_(alpha beta)) $
]

The functional derivative in $T^(mu nu)$ is given by
$
  (delta L)/(delta g_(mu nu)) & = delta/(delta g_(mu nu)) (1/2 g^(alpha beta) partial_alpha phi.alt partial_beta phi.alt - V(phi.alt)) = 1/2 partial_alpha phi.alt partial_beta phi.alt (delta g^(alpha beta))/(delta g_(mu nu)) \
  & attach(=, t: "Hint") -1/2 partial_alpha phi.alt partial_beta phi.alt g^(rho alpha) g^(sigma beta) overbrace((delta g_(rho sigma))/(delta g_(mu nu)), delta_rho^mu delta_sigma^nu) = -1/2 partial_alpha phi.alt partial_beta phi.alt g^(mu alpha) g^(nu beta) = -1/2 partial^mu phi.alt partial^nu phi.alt.
$
This yields the following energy-momentum tensor:
$ T^(mu nu) = partial^mu phi.alt partial^nu phi.alt - g^(mu nu) L. $

#task(label: "b")[
  Assume $"diag"({g_(mu nu)}) = (c^2, -a^2 (t), -a^2 (t), -a^2 (t))$ and that $phi.alt$ is spatially constant ($partial_i phi.alt = 0$). Identify the density $rho$ and the pressure $p$ of the field $phi.alt$ using
  $ "diag"({tmix(mu, nu)}) = (rho, -p, -p, -p). $
  What assumptions are made with this diagonal form of $tmix(mu, nu)$?
]

We consider the quantity $tmix(mu, nu)$ with one index up and one down to remove the distorting effects of the metric (modulo overall signs). We arrive at $tmix(mu, nu)$ by contracting one index with the metric, i.e. $tmix(mu, nu) = g_(nu alpha) T^(mu alpha)$. From this, the energy density $rho$ and the pressure $p$ of our scalar field $phi.alt$ can simply be read off:
$
  rho & = tmix(0, 0) = g_(0 alpha) T^(0 alpha) = g_00 T^00, quad "since the metric is diagonal" \
  & = c^2 (partial^0 phi.alt partial^0 phi.alt - underbrace(g^00, 1 \/ c^2) L) = c^(-2) (partial_t phi.alt)^2 - 1/2 g^(mu nu) partial_mu phi.alt partial_nu phi.alt + V(phi.alt) \
  & = c^(-2) (partial_t phi.alt)^2 - 1/2 partial_mu phi.alt partial^mu phi.alt + V(phi.alt) = c^(-2) (partial_t phi.alt)^2 - 1/2 g_(mu nu) partial^mu phi.alt partial^nu phi.alt + V(phi.alt) \
  & = c^(-2) (partial_t phi.alt)^2 - 1/2 g_00 partial^0 phi.alt partial^0 phi.alt + V(phi.alt), quad "since" partial^i phi.alt = 0 \
  & = c^(-2) (partial_t phi.alt)^2 - 1/2 c^(-2) (partial_t phi.alt)^2 + V(phi.alt) = c^(-2)/2 dot(phi.alt)^2 + V(phi.alt), \
  p & = -tmix(1, 1) = -tmix(2, 2) = -tmix(3, 3) = -g_(1 alpha) T^(1 alpha) = -g_11 T^11, quad "again using the diagonal metric" \
  & = -(-a^2 (t)) (underbrace(partial^1 phi.alt partial^1 phi.alt, 0) - underbrace(g^11, -1 \/ a^2 (t)) L) = L = 1/2 g^(mu nu) partial_mu phi.alt partial_nu phi.alt - V(phi.alt) \
  & = 1/2 g_(mu nu) partial^mu phi.alt partial^nu phi.alt - V(phi.alt) = 1/2 g_00 partial^0 phi.alt partial^0 phi.alt - V(phi.alt), quad "since" partial^i phi.alt = 0 \
  & = c^(-2)/2 (partial_t phi.alt)^2 - V(phi.alt) = c^(-2)/2 dot(phi.alt)^2 - V(phi.alt).
$
The diagonal form of $tmix(mu, nu)$ is known as Weyl's postulate, which assumes a cosmos adequately described by a hydrodynamical model of an ideal fluid. In this model the cosmological principle, i.e. the notion that matter distribution in the Universe is isotropic and homogeneous on sufficiently large scales, justifies the diagonal form of $tmix(mu, nu)$, which, as a result, lacks shear forces from the pressure component $p^i$ in $j$-direction ($tmix(i, j)$, $i != j$), energy flow per unit area in $i$-direction ($tmix(0, i)$), and momentum densities in $i$-direction ($tmix(i, 0)$).

= Problem 3 (An interesting line element II) [15 points]

#task[
  On the last sheet, we calculated the Christoffel symbols $chr(alpha, mu nu)$ of a line element $dif s$ with
  $ dif s^2 = c^2 dif t^2 - a^2 (t) [(dif r^2)/(1 - k r^2) + r^2 (dif theta^2 + sin^2 theta dif phi.alt^2)]. $
]

#task(label: "a")[
  Assume $k = 0$ ($hat(=)$ flat space) and calculate the diagonal entries of the Ricci tensor $R_(mu mu)$. Remember,
  $ R_(mu nu) = partial_alpha chr(alpha, mu nu) - partial_nu chr(alpha, mu alpha) + chr(beta, mu nu) chr(alpha, beta alpha) - chr(beta, mu alpha) chr(alpha, beta nu). $
]

For $k = 0$, the above line element yields a total of 18 non-vanishing Christoffel symbols $chr(alpha, mu nu)$. They are
$
  chr(0, 11) & = a dot(a), #h(2.5em) & chr(0, 22) & = a dot(a) r^2, #h(2.5em) & chr(0, 33) & = a dot(a) r^2 sin^2 theta, \
  chr(1, 10) = chr(1, 01) & = dot(a)/a, #h(2.5em) & chr(1, 22) & = -r, #h(2.5em) & chr(1, 33) & = -r sin^2 theta, \
  chr(2, 20) = chr(2, 02) & = dot(a)/a, #h(2.5em) & chr(2, 21) = chr(2, 12) & = 1/r, #h(2.5em) & chr(2, 33) & = -sin theta cos theta, \
  chr(3, 30) = chr(3, 03) & = dot(a)/a, #h(2.5em) & chr(3, 31) = chr(3, 13) & = 1/r, #h(2.5em) & chr(3, 32) = chr(3, 23) & = cot theta.
$
They yield the following diagonal elements of the Ricci tensor $R_(mu nu)$:
$
  R_00 & = partial_alpha underbrace(chr(alpha, 00), 0 thin forall alpha) - partial_0 chr(alpha, 0 alpha) + underbrace(chr(beta, 00), 0 thin forall beta) chr(alpha, beta alpha) - chr(beta, 0 alpha) chr(alpha, beta 0) \
  & = -partial_0 chr(i, 0 i) - chr(j, 0 i) chr(i, j 0) = -3 (partial_t dot(a)/a + dot(a)^2/a^2) = -3 (dot.double(a)/a - dot(a)^2/a^2 + dot(a)^2/a^2) = -3 dot.double(a)/a,
$
$
  R_11 & = partial_alpha chr(alpha, 11) - partial_1 chr(alpha, 1 alpha) + chr(beta, 11) chr(alpha, beta alpha) - chr(beta, 1 alpha) chr(alpha, beta 1) \
  & = partial_0 chr(0, 11) - partial_1 chr(1, 10) - partial_1 chr(2, 12) - partial_1 chr(3, 13) + chr(0, 11) underbrace(chr(alpha, 0 alpha), 3 chr(1, 01)) - chr(0, 11) chr(1, 01) - chr(1, 10) chr(0, 11) \
  & quad - chr(2, 12) chr(2, 21) - chr(3, 13) chr(3, 31) \
  & = partial_t a dot(a) - partial_r dot(a)/a - partial_r 1/r - partial_r 1/r + 3 a dot(a) dot(a)/a - 2 a dot(a) dot(a)/a - 1/r 1/r - 1/r 1/r \
  & = dot(a)^2 + a dot.double(a) + 2/r^2 + dot(a)^2 - 2/r^2 = a dot.double(a) + 2 dot(a)^2,
$
$
  R_22 & = partial_alpha chr(alpha, 22) - partial_2 chr(alpha, 2 alpha) + chr(beta, 22) chr(alpha, beta alpha) - chr(beta, 2 alpha) chr(alpha, beta 2) \
  & = partial_0 chr(0, 22) + partial_1 chr(1, 22) - partial_2 chr(3, 23) + chr(0, 22) underbrace(chr(alpha, 0 alpha), 3 chr(1, 01)) + chr(1, 22) underbrace(chr(alpha, 1 alpha), 2 chr(2, 12)) - chr(0, 22) chr(2, 02) \
  & quad - chr(1, 22) chr(2, 12) - chr(2, 20) chr(0, 22) - chr(2, 21) chr(1, 22) - chr(3, 23) chr(3, 32) \
  & = partial_t a dot(a) r^2 + partial_r (-r) - partial_theta cot theta + 3 a dot(a) r^2 dot(a)/a + 2 (-r) 1/r - a dot(a) r^2 dot(a)/a \
  & quad - (-r) 1/r - dot(a)/a a dot(a) r^2 - 1/r (-r) - cot^2 theta \
  & = dot(a)^2 r^2 + a dot.double(a) r^2 - 1 + 1 + cot^2 theta + 3 dot(a)^2 r^2 - 2 - dot(a)^2 r^2 + 1 - dot(a)^2 r^2 + 1 - cot^2 theta \
  & = a dot.double(a) r^2 + 2 dot(a)^2 r^2 = (a dot.double(a) + 2 dot(a)^2) r^2,
$
$
  R_33 & = partial_alpha chr(alpha, 33) - partial_3 underbrace(chr(alpha, 3 alpha), 0 thin forall alpha) + chr(beta, 33) chr(alpha, beta alpha) - chr(beta, 3 alpha) chr(alpha, beta 3) \
  & = partial_0 chr(0, 33) + partial_1 chr(1, 33) + partial_2 chr(2, 33) + chr(0, 33) underbrace(chr(alpha, 0 alpha), 3 chr(1, 01)) + chr(1, 33) underbrace(chr(alpha, 1 alpha), 2 chr(2, 12)) + chr(2, 33) underbrace(chr(alpha, 2 alpha), chr(3, 23)) - chr(0, 33) chr(3, 30) \
  & quad - chr(1, 33) chr(3, 31) - chr(2, 33) chr(3, 32) - chr(3, 30) chr(0, 33) - chr(3, 31) chr(1, 33) - chr(3, 32) chr(2, 33) \
  & = partial_t a dot(a) r^2 sin^2 theta + partial_r (-r sin^2 theta) + partial_theta (-sin theta cos theta) + 3 a dot(a) r^2 sin^2 theta dot(a)/a \
  & quad + 2 (-r sin^2 theta) 1/r + (-sin theta cos theta) cot theta - a dot(a) r^2 sin^2 theta dot(a)/a - (-r sin^2 theta) 1/r \
  & quad - (-sin theta cos theta) cot theta - dot(a)/a a dot(a) r^2 sin^2 theta - 1/r (-r sin^2 theta) - cot theta (-sin theta cos theta) \
  & = dot(a)^2 r^2 sin^2 theta + a dot.double(a) r^2 sin^2 theta - sin^2 theta - cos^2 theta + sin^2 theta + 3 dot(a)^2 r^2 sin^2 theta - 2 sin^2 theta \
  & quad - cos^2 theta - dot(a)^2 r^2 sin^2 theta + sin^2 theta + cos^2 theta - dot(a)^2 r^2 sin^2 theta + sin^2 theta + cos^2 theta \
  & = 2 dot(a)^2 r^2 sin^2 theta + a dot.double(a) r^2 sin^2 theta = (a dot.double(a) + 2 dot(a)^2) r^2 sin^2 theta.
$

#task(label: "b")[Calculate the Ricci scalar $R = g^(mu nu) R_(mu nu)$.]

$
  R & = g^(mu nu) R_(mu nu) = g^(mu mu) R_(mu mu), quad "since" g^(mu nu) "is diagonal" \
  & = g^00 R_00 + g^11 R_11 + g^22 R_22 + g^33 R_33,
$
where
$
  g^00 R_00 & = R_00 = -3 dot.double(a)/a, \
  g^11 R_11 & = -1/a^2 (a dot.double(a) + 2 dot(a)^2) = -dot.double(a)/a - 2 dot(a)^2/a^2, \
  g^22 R_22 & = -1/(a^2 r^2) (a dot.double(a) + 2 dot(a)^2) r^2 = -dot.double(a)/a - 2 dot(a)^2/a^2, \
  g^33 R_33 & = -1/(a^2 r^2 sin^2 theta) (a dot.double(a) + 2 dot(a)^2) r^2 sin^2 theta = -dot.double(a)/a - 2 dot(a)^2/a^2,
$
$ ==> quad R = -3 dot.double(a)/a + 3 (-dot.double(a)/a - 2 dot(a)^2/a^2) = -6 (dot.double(a)/a + dot(a)^2/a^2). $

#task(label: "c")[
  Assuming once more that $"diag"({tmix(mu, nu)}) = (rho, -p, -p, -p)$, write down the 00 Einstein field equation,
  $ G_00 + g_00 Lambda = (8 pi G)/c^4 T_00. $
]

The Einstein tensor $G_(mu nu)$ is defined as
$ G_(mu nu) := R_(mu nu) - 1/2 g_(mu nu) R, $
so that the Einstein field equations can be expanded into
$ R_(mu nu) - 1/2 g_(mu nu) R + g_(mu nu) Lambda = (8 pi G)/c^4 T_(mu nu). $
Inserting our results from parts a) and b), the 00 equation reads
$
  -3 dot.double(a)/a - 1/2 [-6 (dot.double(a)/a + dot(a)^2/a^2)] + c^2 Lambda = 3 dot(a)^2/a^2 + c^2 Lambda = (8 pi G)/c^4 c^2 rho \
  <==> quad dot(a)^2/a^2 = (8 pi G)/(3 c^2) rho - c^2/3 Lambda.
$

= Problem 4 (Extra question: Spatial curvature of the universe) [5 points]

#task[How would you go about designing an experiment that tests the flatness of the Universe as a whole? Can you distinguish between a flat and a non-flat cosmos?]

Knowing the shape of the universe requires the consideration of two aspects:
+ its local geometry, which concerns the curvature of the observable Universe, and
+ its global geometry, i.e. the topology of the Universe as a whole.

To answer the second question: only if the observable Universe encompasses the entire Universe might we be able to determine its global structure by observation.

As for a test resolving the question of the Universe's flatness, Charles Alcock realized decades ago that with astronomy's common method of obtaining distant objects' separation from us by measuring the redshift of light reaching us from these objects, it would be possible to infer the Universe's geometry by observing any known-to-be spherical distribution of objects. By analyzing any apparent distortion of that sphere and adapting the parameters that convert redshift to position so that the thus corrected distribution again becomes spherical, it would be possible to determine the geometry governing our Universe.
