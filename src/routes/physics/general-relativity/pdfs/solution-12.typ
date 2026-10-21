#import "/notes.typ": notes, task

#show: notes.with(
  title: [General Relativity -- Exercise Sheet 12],
  subtitle: [Exercise sheet 12, General Relativity, Prof. Björn Malte Schäfer],
  date: [Solutions by Roland Walz and Janosh Riebesell, 03.07.2015],
)

#let Lie = $cal(L)$
#let Z = $bold(Z)$

= Problem 1 (Lie derivative) [15 points]

#task[
  The Lie derivative $(Lie_a v)^mu$ was established via a coordinate transform of $overline(v)^mu (overline(x))$ to $v^mu (x)$ for the r.h.s. and an expansion of $overline(v)^mu$ around $overline(x)$ for the l.h.s.
]

#task(label: "a")[Derive the Lie derivative of a $(1, 1)$-tensor $Z^mu_(space nu)$ in the same fashion.]

In general, the Lie derivative of an arbitrary tensor $T in cal(T)^r_s$ of rank $(r, s)$ with respect to a vector field $a$ on a manifold $M$ is defined as
$ Lie_a T = lim_(t -> 0) (gamma_t^* T - T)/t, $
where $gamma_t$ is the flow of $a$. Evidently, the Lie derivative of a rank $(r, s)$-tensor is itself again a rank $(r, s)$-tensor.

To find an expression for the components of a Lie derivative of a $(1, 1)$-tensor $Z$, we apply the Lie derivative to the tensor product $Z times.o dif x^mu times.o partial_nu$, in which the set ${partial_mu}$ forms a coordinate basis of the vector field $a$ and the set ${dif x^mu}$ is its dual basis.
$
  Lie_a (Z times.o dif x^mu times.o partial_nu) & attach(=, t: "Leibniz rule") (Lie_a Z) times.o dif x^mu times.o partial_nu + Z times.o (Lie_a dif x^mu) times.o partial_nu \
  & quad + Z times.o dif x^mu times.o (Lie_a partial_nu).
$
A full contraction of the above yields
$ underbrace(Lie_a Z^mu_(space nu), a^rho partial_rho Z^mu_(space nu)) = (Lie_a Z)^mu_(space nu) + underbrace(Z(partial_rho a^mu dif x^rho, partial_nu), (partial_rho a^mu) Z^rho_(space nu)) - underbrace(Z(dif x^mu, partial_nu a^rho partial_rho), (partial_nu a^rho) Z^mu_(space rho)). $
Solving for the components of the Lie derivative of $Z$, i.e. $(Lie_a Z)^mu_(space nu)$, we arrive at
$ (Lie_a Z)^mu_(space nu) = a^rho partial_rho Z^mu_(space nu) - (partial_rho a^mu) Z^rho_(space nu) + (partial_nu a^rho) Z^mu_(space rho). $

#task(label: "b")[Compare the result of part a) to the one given in the script for the $(0, 2)$-tensor $g_(mu nu)$. What is the difference?]

The Lie derivative of the $(0, 2)$-metric tensor $g_(mu nu)$, as taken from the script, reads
$
  (Lie_a g)_(mu nu) & = a^rho partial_rho g_(mu nu) + (partial_nu a^rho) g_(mu rho) + (partial_mu a^rho) g_(rho nu) \
  & = a^rho partial_rho g_(mu nu) - a^rho Gamma^sigma_(rho mu) g_(sigma nu) - a^rho Gamma^sigma_(rho nu) g_(mu sigma) + a^rho Gamma^sigma_(rho mu) g_(sigma nu) \
  & quad + a^rho Gamma^sigma_(rho nu) g_(mu sigma) + (partial_nu a^sigma) g_(mu sigma) + (partial_mu a^sigma) g_(sigma nu) \
  & = a^rho underbrace(nabla_rho g_(mu nu), 0) + (nabla_nu a^sigma) g_(mu sigma) + (nabla_mu a^sigma) g_(sigma nu) \
  & = (nabla_nu a^sigma) g_(mu sigma) + (nabla_mu a^sigma) g_(sigma nu) \
  & = nabla_nu a_mu + nabla_mu a_nu, quad (= 0 "if" a_mu "is a Killing vector field")
$
where $nabla_rho g_(mu nu) = 0$ because we are free to choose an affine connection and vanishing torsion such that a parallel transport operation preserving lengths and angles is ensured. This condition, which we may not impose for an arbitrary rank $(1, 1)$-tensor such as $Z$, is the reason why we were able to derive the much simpler expression for the Lie derivative of the metric given above.

= Problem 2 (Killing vectors) [15 points]

#task[
  The Lie derivative of the metric $g_(mu nu)$ is given by
  $ (Lie_a g)_(mu nu) = g_(mu lambda) nabla_nu a^lambda + g_(lambda nu) nabla_mu a^lambda = nabla_nu a_mu + nabla_mu a_nu, $
  where $nabla_mu$ are covariant derivatives. For a Killing vector $xi$, we have $(Lie_xi g)_(mu nu) = 0$.
]

#task(label: "a")[For the 2-sphere, $dif s^2 = dif theta^2 + sin^2 theta dif phi^2$. Show that the Killing vector field is related to the angular momentum.]

From the line element $dif s^2 = g_(mu nu) dif x^mu dif x^nu$, where $mu, nu in {1, 2}$ with $x^1 = theta$, $x^2 = phi$, we extract the following metric
$ g_(11) = 1 = g^(11), quad g_(22) = sin^2 theta = 1/g^(22), quad g_(12) = g^(12) = g_(21) = g^(21) = 0. $
Using $Gamma^rho_(mu nu) = 1/2 g^(rho sigma) (partial_mu g_(sigma nu) + partial_nu g_(sigma mu) - partial_sigma g_(mu nu))$, we find that only three of the eight Christoffel symbols of the 2-sphere are non-vanishing:
$
  Gamma^1_(22) & = -sin theta cos theta, quad && (Gamma^1_(11) = Gamma^1_(12) = Gamma^1_(21) = 0), \
  Gamma^2_(12) = Gamma^2_(21) & = cot theta, quad && (Gamma^2_(11) = Gamma^2_(22) = 0).
$
Killing's equations $(Lie_xi g)_(mu nu) = 0$ then provide the following determining conditions for a Killing vector $xi$:
$
  "i)" quad 0 & = (Lie_xi g)_(11) = nabla_1 xi_1 + nabla_1 xi_1 = 2 \(partial_1 xi_1 - underbrace(Gamma^rho_(11), 0 space forall rho) xi_rho\) = 2 partial_theta xi_theta, \
  "ii)" quad 0 & = (Lie_xi g)_(22) = nabla_2 xi_2 + nabla_2 xi_2 = 2 (partial_2 xi_2 - Gamma^rho_(22) xi_rho) = 2 (partial_phi xi_phi + sin theta cos theta xi_theta), \
  "iii)" quad 0 & = (Lie_xi g)_(12) = (Lie_xi g)_(21) = nabla_1 xi_2 + nabla_2 xi_1 = partial_1 xi_2 - Gamma^rho_(12) xi_rho + partial_2 xi_1 - Gamma^rho_(21) xi_rho \
  & = partial_theta xi_phi + partial_phi xi_theta - 2 cot theta xi_phi.
$
From condition i), we gather that $xi_theta (theta, phi) = xi_theta (phi)$. Thus, if we can construct a differential equation for $xi_theta (phi)$, it should be easy to give a solution. We differentiate iii) w.r.t. $phi$ to get
$ partial_theta partial_phi xi_phi + partial_phi^2 xi_theta - 2 cot theta partial_phi xi_phi = 0. $
Inserting ii), i.e. $partial_phi xi_phi = -sin theta cos theta xi_theta$, we obtain
$
  0 & = partial_theta (-sin theta cos theta xi_theta) + partial_phi^2 xi_theta - 2 cot theta (-sin theta cos theta xi_theta) \
  & = -cos^2 theta xi_theta + sin^2 theta xi_theta + partial_phi^2 xi_theta + 2 cos^2 theta xi_theta \
  & = partial_phi^2 xi_theta + xi_theta,
$
which is exactly the differential equation describing the harmonic oscillator. Its most general solution is
$ xi_theta (phi) = c_1 sin phi + c_2 cos phi, quad "with" c_1, c_2 "constant". $
$xi_phi (theta, phi)$ is still undetermined, so we insert $xi_theta (phi)$ into ii),
$ partial_phi xi_phi = -sin theta cos theta (c_1 sin phi + c_2 cos phi), $
and integrate to obtain
$ xi_phi (theta, phi) = sin theta cos theta (c_1 cos phi - c_2 sin phi) + f(theta), $
where $f(theta)$ is an, as yet, unknown function solving the homogeneous differential equation $partial_phi xi_phi = 0$. It can, however, be determined by inserting $xi_theta (phi)$ and $xi_phi (theta, phi)$ into iii):
$
  0 & = partial_theta xi_phi + partial_phi xi_theta - 2 cot theta xi_phi = partial_theta (sin theta cos theta (c_1 cos phi - c_2 sin phi) + f(theta)) \
  & quad + partial_phi (c_1 sin phi + c_2 cos phi) - 2 cot theta (sin theta cos theta (c_1 cos phi - c_2 sin phi) + f(theta)) \
  & = (cos^2 theta - sin^2 theta)(c_1 cos phi - c_2 sin phi) + (partial f(theta))/(partial theta) + c_1 cos phi - c_2 sin phi \
  & quad - 2 cos^2 theta (c_1 cos phi - c_2 sin phi) - 2 cot theta f(theta) = (partial f(theta))/(partial theta) - 2 cot theta f(theta) = 0.
$
Division by $sin^2 theta$ and reverse application of the product rule gives
$ 1/(sin^2 theta) (partial f(theta))/(partial theta) - underbrace(2 (cos theta)/(sin^3 theta), -partial_theta 1/(sin^2 theta)) f(theta) = partial_theta ((f(theta))/(sin^2 theta)) = 0. $
Thus, $f(theta)$ must be of the form $f(theta) = c_3 sin^2 theta$ with $c_3$ constant. Therefore, the general form for the Killing vectors of the 2-sphere is
$
  xi_theta & = c_1 sin phi + c_2 cos phi, \
  xi_phi & = sin theta cos theta (c_1 cos phi - c_2 sin phi) + c_3 sin^2 theta,
$
with three independent constants $c_1, c_2, c_3$ yielding three linearly independent Killing vectors. Expanding these covariant components in the dual basis of the cotangent space of $S^2$, we may write them as
$ xi = xi_theta dif theta + xi_phi dif phi. $ Then we find for a particular choice of $c_1$, $c_2$ and $c_3$ that
$
  xi_1 & = sin phi dif theta + sin theta cos theta cos phi dif phi, quad && "for" c_1 = 1, c_2 = c_3 = 0, \
  xi_2 & = -cos phi dif theta + sin theta cos theta sin phi dif phi, quad && "for" c_2 = -1, c_1 = c_3 = 0, \
  xi_3 & = -sin^2 theta dif phi, quad && "for" c_3 = -1, c_1 = c_2 = 0.
$
This is already a nice result. However, to see the relation to the contravariant angular momentum vector, we need to compute the contravariant form of the Killing vectors via contraction with the metric. We find
$
  xi^1 & = g^(11) sin phi partial_theta + g^(22) sin theta cos theta cos phi partial_phi = sin phi partial_theta + cot theta cos phi partial_phi, \
  xi^2 & = -g^(11) cos phi partial_theta + g^(22) sin theta cos theta sin phi partial_phi = -cos phi partial_theta + cot theta sin phi partial_phi, \
  xi^3 & = -g^(22) sin^2 theta partial_phi = -partial_phi.
$
Since in spherical coordinates, the components of the angular momentum operator are given by
$
  L_x & = i ħ (sin phi partial_theta + cot theta cos phi partial_phi), \
  L_y & = i ħ (-cos phi partial_theta + cot theta sin phi partial_phi), \
  L_z & = -i ħ partial_phi,
$
we found that for our particular choice of $c_1$, $c_2$, $c_3$, the three contravariant Killing vectors are, up to a factor of $i ħ$, identical to the components of angular momentum.

#task(label: "b")[Show that for a Killing vector $xi$ and the stress-energy tensor $T^(mu nu)$, we can define a current $J^mu = xi_nu T^(mu nu)$ which has a vanishing covariant derivative, i.e. $nabla_mu J^mu = 0$.]

$
  nabla_mu J^mu & = nabla_mu (xi_nu T^(mu nu)) = underbrace((nabla_mu xi_nu), -nabla_nu xi_mu) T^(mu nu) + xi_nu underbrace(nabla_mu T^(mu nu), 0) \
  & = -(nabla_nu xi_mu) T^(nu mu) - xi_mu nabla_nu T^(nu mu) = -nabla_nu (xi_mu T^(nu mu)) = -nabla_nu J^nu quad ==> quad nabla_mu J^mu = 0.
$
= Problem 4 (Extra: Torsion and cosmology) [5 points]

#task(label: "a")[What would happen to Killing vectors if $Gamma^alpha_(mu nu) != Gamma^alpha_(nu mu)$?]

We would no longer have $nabla_mu xi_nu + nabla_nu xi_mu = 0$. The Lie derivative of the metric w.r.t. a Killing vector field would not vanish.

#task(label: "b")[Is there a timelike Killing vector in FLRW cosmologies?]

A metric can only admit a timelike Killing vector $partial/(partial t)$ if it is stationary, i.e. if there exist coordinates in which the metric is independent of time. (This would mean observers travelling along integral curves of $dif/(dif t)$ do not notice any change in the universe.) Since the metric of FLRW cosmologies is given by
$ "diag"(g) = (1, -a^2 (t), -a^2 (t), -a^2 (t)) $
in Cartesian coordinates, these do not, except for the special case of $a(t) = a$ constant, contain timelike Killing vector fields.
