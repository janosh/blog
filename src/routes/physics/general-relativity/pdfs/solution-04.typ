#import "/notes.typ": dd, notes, tagged, task

#show: notes.with(
  title: [General Relativity -- Exercise Sheet 4],
  subtitle: [Exercise sheet 4, General Relativity, Prof. Björn Schäfer],
  date: [Solutions by Janosh Riebesell, 05.05.2015],
)

// Christoffel symbol with upper index a and lower indices b
#let chr(a, b) = $attach(Gamma, tr: #a, br: #b)$

= Problem 1 (Straight back to the sphere) [10 points]

#task[
  Last time, you derived the metric for a sphere in $RR^3$,
  $ "diag"{g_(i j)} = (1, r^2, r^2 sin^2 theta), $
  and limited yourself to the surface. This time, we will not do so and leave $r$ free.
]

#task(label: "a")[Calculate the Christoffel symbols $chr(i, j k)$ of this metric.]

Surpassing the instructions of exercise 2.b) on sheet 3, we already calculated all 27 space Christoffel symbols, all the while leaving $x^1 = r$ unconstrained. We found a total of nine symbols different from zero. These were
$
  chr(1, 22) & = -r, quad chr(1, 33) = -r sin^2 theta, quad chr(2, 12) = chr(2, 21) = 1/r, \
  chr(2, 33) & = -sin theta cos theta, quad chr(3, 13) = chr(3, 31) = 1/r, quad chr(3, 23) = chr(3, 32) = cot theta.
$

#task(label: "b")[
  The geodesic equations read
  $ dot.double(x)^i + chr(i, j k) dot(x)^j dot(x)^k = 0. $
  Do they describe straight lines? Should this depend on the coordinate system we're using?
]

Writing the geodesic equations explicitly, we get
$
  dot.double(r) + (-r) dot(theta) dot(theta) + (-r sin^2 theta) dot(phi.alt) dot(phi.alt) & = dot.double(r) - r dot(theta)^2 - r sin^2 theta dot(phi.alt)^2 = 0, \
  dot.double(theta) + 1/r dot(r) dot(theta) + 1/r dot(theta) dot(r) + (-sin theta cos theta) dot(phi.alt) dot(phi.alt) & = dot.double(theta) + 2/r dot(r) dot(theta) - sin theta cos theta dot(phi.alt)^2 = 0, \
  dot.double(phi.alt) + 1/r dot(r) dot(phi.alt) + 1/r dot(phi.alt) dot(r) + cot theta dot(theta) dot(phi.alt) + cot theta dot(phi.alt) dot(theta) & = dot.double(phi.alt) + 2/r dot(r) dot(phi.alt) + 2 cot theta dot(theta) dot(phi.alt) = 0.
$
Solving for the second-order time-derivatives, the geodesic equations result in
$
  dot.double(r) = r dot(theta)^2 + r sin^2 theta dot(phi.alt)^2, quad
  dot.double(theta) = -2/r dot(r) dot(theta) + sin theta cos theta dot(phi.alt)^2, quad
  dot.double(phi.alt) = -2/r dot(r) dot(phi.alt) - 2 cot theta dot(theta) dot(phi.alt).
$
Since we started out deriving the metric $"diag"{g_(i j)} = (1, r^2, r^2 sin^2 theta)$ from flat Minkowskian space, a property that remains unaffected by a transformation to spherical coordinates, the equations of motion above, obtained from the geodesic equation, describe motion in flat space. They should therefore, when solved, yield straight lines.

At least for radial motion, i.e. along the $r$-dimension, it is easy to see that this is true. Radial motion implies $theta = c_1$, $phi.alt = c_2$, with $c_1, c_2$ constant, so that the right-hand side of all geodesic eqns. and the left-hand side of the second and third vanish and we are left with $dot.double(r) = 0$, solved by a straight line $r(t) = v dot t + d$.

The outcome/behavior of no physical process should depend on the coordinate system chosen to describe it.

= Problem 2 (Transforming the metric) [10 points]

#task[
  If we transform the metric by a scalar factor $e^(2 phi)$, with $phi = phi(x^mu)$ a function of all coordinates, the metric becomes
  #tagged(1, $ g --> g' = e^(2 phi) g. $)
]

#task(label: "a")[
  By plugging in the definition into the Christoffel symbols $chr(alpha, mu nu)$, show that they will transform as
  #tagged(2, $ chr(alpha, mu nu) --> Gamma'^alpha_(mu nu) = chr(alpha, mu nu) + delta^alpha_mu partial_nu phi + delta^alpha_nu partial_mu phi - g^(alpha beta) g_(mu nu) partial_beta phi. $)
]

The Christoffel symbols $chr(alpha, mu nu)$ can be expressed in terms of derivatives of the metric as
$ chr(alpha, mu nu) = 1/2 g^(alpha beta) ((partial g_(beta mu))/(partial x^nu) + (partial g_(beta nu))/(partial x^mu) - (partial g_(mu nu))/(partial x^beta)). $
Keeping in mind that $g'_(alpha beta) g'^(beta gamma) = delta_alpha^gamma$, i.e. $g'^(beta gamma) = e^(-2 phi) g^(beta gamma)$, we insert the transformed metric to arrive at eqn. (2):
$
  Gamma'^alpha_(mu nu) & = 1/2 g'^(alpha beta) ((partial g'_(beta mu))/(partial x^nu) + (partial g'_(beta nu))/(partial x^mu) - (partial g'_(mu nu))/(partial x^beta)) \
  & = 1/2 g^(alpha beta) e^(-2 phi) (partial/(partial x^nu) (g_(beta mu) e^(2 phi)) + partial/(partial x^mu) (g_(beta nu) e^(2 phi)) - partial/(partial x^beta) (g_(mu nu) e^(2 phi))) \
  & = 1/2 g^(alpha beta) ((partial g_(beta mu))/(partial x^nu) + (partial g_(beta nu))/(partial x^mu) - (partial g_(mu nu))/(partial x^beta)) \
  & quad + 1/2 g^(alpha beta) e^(-2 phi) (g_(beta mu) 2 e^(2 phi) (partial phi)/(partial x^nu) + g_(beta nu) 2 e^(2 phi) (partial phi)/(partial x^mu) - g_(mu nu) 2 e^(2 phi) (partial phi)/(partial x^beta)) \
  & = chr(alpha, mu nu) + g^(alpha beta) (g_(beta mu) partial_nu phi + g_(beta nu) partial_mu phi - g_(mu nu) partial_beta phi) \
  & = chr(alpha, mu nu) + delta^alpha_mu partial_nu phi + delta^alpha_nu partial_mu phi - g^(alpha beta) g_(mu nu) partial_beta phi.
$

#task(label: "b")[
  Null geodesics ($dif s = 0$) have a tangent vector that is light-like,
  $ dot(x)^mu dot(x)_mu = 0. $
  Show that null geodesics are invariant under the transformation in a), i.e. that null geodesics of the metric $g$ will remain null geodesics of the metric $g'$, if the curve parameter $lambda$ is transformed as
  #tagged(3, $ dif lambda --> dif lambda' = e^(2 phi) dif lambda. $)
]

$
  dot.double(x)'^alpha + Gamma'^alpha_(mu nu) dot(x)'^mu dot(x)'^nu
  & := dif/(dif lambda') (dif x^alpha)/(dif lambda') + Gamma'^alpha_(mu nu) (dif x^mu)/(dif lambda') (dif x^nu)/(dif lambda') = e^(-2 phi) dif/(dif lambda) (e^(-2 phi) dif/(dif lambda) x^alpha) \
  & quad + e^(-4 phi) (chr(alpha, mu nu) + delta^alpha_mu partial_nu phi + delta^alpha_nu partial_mu phi - g^(alpha beta) g_(mu nu) partial_beta phi) dot(x)^mu dot(x)^nu \
  & = e^(-4 phi) (-2 (dif phi)/(dif lambda) dot(x)^alpha) + e^(-4 phi) dot.double(x)^alpha + e^(-4 phi) (chr(alpha, mu nu) dot(x)^mu dot(x)^nu + partial_nu phi dot(x)^nu dot(x)^alpha + partial_mu phi dot(x)^mu dot(x)^alpha - partial^alpha phi underbrace(dot(x)_mu dot(x)^mu, 0)) \
  & = e^(-4 phi) (dot.double(x)^alpha + chr(alpha, mu nu) dot(x)^mu dot(x)^nu - 2 (partial phi)/(partial x^mu) (dif x^mu)/(dif lambda) dot(x)^alpha + 2 partial_mu phi dot(x)^mu dot(x)^alpha) = e^(-4 phi) (dot.double(x)^alpha + chr(alpha, mu nu) dot(x)^mu dot(x)^nu).
$
Therefore, we can say that
$ "null geodesics" quad <==> quad dot.double(x)^alpha + chr(alpha, mu nu) dot(x)^mu dot(x)^nu = 0 quad <==> quad dot.double(x)'^alpha + Gamma'^alpha_(mu nu) dot(x)'^mu dot(x)'^nu = 0. $

= Problem 3 (An interesting line element) [20 points]

#task[
  Consider the following line element,
  $ dif s^2 = c^2 dif t^2 - a^2 (t) [(dif r^2)/(1 - k r^2) + r^2 (dif theta^2 + sin^2 theta dif phi.alt^2)]. $
]

#task(label: "a")[Calculate the non-vanishing Christoffel symbols.]

$
  {g_(mu nu) (t)} = mat(
    1, , , ;
    , -a^2 (t) \/ (1 - k r^2), , ;
    , , -a^2 (t) r^2, ;
    , , , -a^2 (t) r^2 sin^2 theta
  ), quad
  x = vec(c t, r, theta, phi.alt), \
  {g^(mu nu) (t)} = mat(
    1, , , ;
    , -(1 - k r^2) \/ a^2 (t), , ;
    , , -1 \/ (a^2 (t) r^2), ;
    , , , -1 \/ (a^2 (t) r^2 sin^2 theta)
  ), \
  chr(alpha, mu nu) = 1/2 g^(alpha beta) ((partial g_(nu beta))/(partial x^mu) + (partial g_(mu beta))/(partial x^nu) - (partial g_(mu nu))/(partial x^beta)).
$
Since $g_(mu nu)$ is diagonal, we may perform a case analysis of the above definition of the Christoffel symbols to reduce the number of required calculations to find them all:
$
  "if" alpha != mu != nu: quad & chr(alpha, mu nu) = 1/2 underbrace(g^(alpha beta), != 0 "only if" alpha = beta) (underbrace((partial g_(nu beta))/(partial x^mu), != 0 "only if" nu = beta) + underbrace((partial g_(mu beta))/(partial x^nu), != 0 "only if" mu = beta) - underbrace((partial g_(mu nu))/(partial x^beta), "always" 0 "since" mu != nu)) = 0, \
  "if" alpha != mu = nu: quad & chr(alpha, mu mu) = 1/2 g^(alpha alpha) (2 underbrace((partial g_(mu alpha))/(partial x^mu), 0) - (partial g_(mu mu))/(partial x^alpha)) = -1/2 g^(alpha alpha) (partial g_(mu mu))/(partial x^alpha), \
  "if" alpha = mu != nu: quad & chr(alpha, alpha nu) = 1/2 g^(alpha alpha) (underbrace((partial g_(nu alpha))/(partial x^alpha), 0) + (partial g_(alpha alpha))/(partial x^nu) - underbrace((partial g_(alpha nu))/(partial x^alpha), 0)) = 1/2 g^(alpha alpha) (partial g_(alpha alpha))/(partial x^nu), \
  "if" alpha = mu = nu: quad & chr(alpha, alpha alpha) = 1/2 g^(alpha alpha) (2 (partial g_(alpha alpha))/(partial x^alpha) - (partial g_(alpha alpha))/(partial x^alpha)) = 1/2 g^(alpha alpha) (partial g_(alpha alpha))/(partial x^alpha).
$
From the first case, we now know that we only need to consider Christoffel symbols with at least one recurring index, thereby removing $4!/(4 - 3)! = 24$ entries from our to-do list previously containing $4^3 = 64$ items. The symmetry in $mu nu$ helps further.
$
  chr(0, 00) & = 1/2 g^(00) (partial g_(00))/(partial x^0) = 1/2 dot 1 dot (partial 1)/(c partial t) = 0, quad
  chr(1, 11) = 1/2 g^(11) (partial g_(11))/(partial x^1) = 1/2 (1 - k r^2)/(a^2 (t)) partial/(partial r) (a^2 (t))/(1 - k r^2) = (k r)/(1 - k r^2), \
  chr(2, 22) & = 1/2 g^(22) underbrace((partial g_(22))/(partial x^2), 0) = 0, quad
  chr(3, 33) = 1/2 g^(33) underbrace((partial g_(33))/(partial x^3), 0) = 0, \
  chr(0, 01) & = chr(0, 10) = chr(0, 20) = chr(0, 02) = chr(0, 30) = chr(0, 03) = 0, quad "because" g^(00) = 1 "constant", \
  chr(1, 10) & = chr(1, 01) = 1/2 g^(11) (partial g_(11))/(partial x^0) = 1/2 (1 - k r^2)/(a^2 (t)) partial/(c partial t) (a^2 (t))/(1 - k r^2) = (dot(a)(t))/(c a(t)), \
  chr(1, 12) & = chr(1, 21) = chr(1, 13) = chr(1, 31) = 0, quad "because" g_(11) = -(a^2 (t))/(1 - k r^2) "does not depend on" theta, phi.alt, \
  chr(2, 02) & = chr(2, 20) = 1/2 1/(a^2 (t) r^2) partial/(c partial t) a^2 (t) r^2 = (dot(a)(t))/(c a(t)), \
  chr(2, 12) & = chr(2, 21) = 1/2 1/(a^2 (t) r^2) partial/(partial r) a^2 (t) r^2 = 1/r, quad
  chr(2, 32) = chr(2, 23) = 0, quad "because" partial/(partial phi.alt) a^2 (t) r^2 = 0, \
  chr(3, 30) & = chr(3, 03) = (dot(a)(t))/(c a(t)), quad
  chr(3, 31) = chr(3, 13) = 1/r, quad
  chr(3, 32) = chr(3, 23) = 1/2 1/(a^2 (t) r^2 sin^2 theta) partial/(partial theta) a^2 (t) r^2 sin^2 theta = cot theta, \
  chr(0, 11) & = -1/2 g^(00) (partial g_(11))/(partial x^0) = 1/2 partial/(c partial t) (a^2 (t))/(1 - k r^2) = (a(t) dot(a)(t))/(c (1 - k r^2)), quad
  chr(0, 22) = 1/2 partial/(c partial t) a^2 (t) r^2 = r^2/c a(t) dot(a)(t), \
  chr(0, 33) & = r^2/c a(t) dot(a)(t) sin^2 theta, \
  chr(1, 00) & = -1/2 g^(11) (partial g_(00))/(partial x^1) = 0, quad
  chr(1, 22) = -1/2 (1 - k r^2)/(a^2 (t)) partial/(partial r) a^2 (t) r^2 = -r (1 - k r^2), quad
  chr(1, 33) = -r (1 - k r^2) sin^2 theta, \
  chr(2, 00) & = 0, quad chr(2, 11) = 0, quad
  chr(2, 33) = -1/2 1/(a^2 (t) r^2) partial/(partial theta) a^2 (t) r^2 sin^2 theta = -sin theta cos theta, \
  chr(3, 00) & = 0, quad chr(3, 11) = 0, quad chr(3, 22) = 0, quad "because the metric does not depend on" phi.alt.
$

#task(label: "b")[Write down what geodesic a particle follows that only moves radially, i.e. in $x^1$-direction?]

For such a particle, we have $theta$ and $phi.alt$ constant. Only two geodesic eqs. remain:
$
  x''^0 + chr(0, mu nu) dot(x)^mu dot(x)^nu & = c t'' + (a(t) dot(a)(t))/(c (1 - k r^2)) r'^2 = 0, \
  x''^1 + chr(1, mu nu) dot(x)^mu dot(x)^nu & = r'' + (k r)/(1 - k r^2) r'^2 + 2 (dot(a)(t))/(a(t)) r' t' = 0,
$
where a prime marks the derivative w.r.t. $tau$.

#task(label: "c")[
  What is the radial distance to a light source ($dif s = 0$),
  $ r = integral_(t_e)^(t_"obs") dd(r'), $
  in terms of $dif t$, if $k = 0$ (we will see what this means in the future). Given $(dif r)/(dif t_e) = 0$, show that $(dif t_"obs")/(dif t_e) = a(t_"obs")/a(t_e)$. With $dif t = 1/f$, find a relation between wavelength $lambda = c/f$ and $a(t_"obs")\/a(t_e)$. Rewrite it in terms of the parameter $z$ with $z = (lambda_"obs" - lambda_e)/lambda_e$.

  Cosmologists call $z$ redshift and $a(t)$ expansion factor. What redshift do you find for signals sent out when the Universe was only half as large as today?
]

For $k = 0$, the line element reads
$ dif s^2 = c^2 dif t^2 - a^2 (t) [dif r^2 + r^2 (dif theta^2 + sin^2 theta dif phi.alt^2)]. $
Since we are only interested in the radial distance to the light source, we keep $theta$ and $phi.alt$ constant, i.e. $dif theta = dif phi.alt = 0$. Since $dif s^2 = 0$ for light, we get
$ 0 attach(=, t: !) dif s^2 = c^2 dif t^2 - a^2 (t) dif r^2 quad ==> quad dif r = (c dif t)/a(t) $
$
  ==> quad r = integral_(t_e)^(t_"obs") dd(r') = c integral_(t_e)^(t_"obs") (dif t)/a(t), quad
  0 attach(=, t: !) (dif r)/(dif t_e) = c dif/(dif t_e) integral_(t_e)^(t_"obs") (dif t)/a(t) attach(=, t: "chain rule") c 1/a(t_"obs") (dif t_"obs")/(dif t_e) - c 1/a(t_e) (dif t_e)/(dif t_e).
$
Therefore, $(dif t_"obs")/(dif t_e) = a(t_"obs")/a(t_e)$. Inserting $dif t = 1/f = 1/(c\/lambda) = lambda/c$ gives
$ lambda_"obs"/lambda_e = a(t_"obs")/a(t_e) quad "and hence" quad z = (lambda_"obs" - lambda_e)/lambda_e = (a(t_"obs") - a(t_e))/a(t_e). $
For $a(t_"obs") = 2 a(t_e)$, i.e. a signal sent out at a time when the universe was half of its size at the time of observation, we get a redshift of $z = 1$.

= Problem 4 (Extra question: Equivalence)

#task[If there were no space exploration and you didn't have means to travel far, how could you distinguish Earth being a sphere with 'regular' gravity from Earth as a flat disk accelerated upwards with $g$ by a giant turtle?]

Ignoring the fact that a sufficiently large turtle capable of accelerating the entire world might be able to produce what we have come to call Earth's gravity with her own mass, we could distinguish between the above cases by observing other objects in our solar system for extended periods of time. If they don't fall away or come rushing at us, we can't be continuously accelerating in one direction relative to them.
