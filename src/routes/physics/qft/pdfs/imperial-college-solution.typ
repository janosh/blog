#import "/notes.typ": dd, notes, task

#show: notes.with(
  title: [Exam on Quantum Field Theory],
  subtitle: [Written on 11.02.2009 at Imperial College London (two hours)],
  date: [Solutions by Janosh Riebesell, 04.02.2015],
)

// Poisson bracket {A, B}_PB
#let pb(a, b) = ${#a, #b}_"PB"$

= Problem 1 (20 points)

#task[
  Consider the classical real scalar field $phi(x)$ with Lagrangian density
  $ cal(L) = 1/2 partial_mu phi partial^mu phi - V(phi). $
  You are given that the classical Poisson bracket satisfies
  $ pb(phi(t, arrow(x)), pi(t, arrow(y))) = -pb(pi(t, arrow(y)), phi(t, arrow(x))) = delta^((3)) (arrow(x) - arrow(y)), $
  while $pb(phi(t, arrow(x)), phi(t, arrow(y))) = 0$ and $pb(A B, C) = A pb(B, C) + B pb(A, C)$.
]

#task(label: "i")[
  What is the definition of the momentum density $pi(x)$ conjugate to $phi(x)$? What is it equal to in this case? Rewrite $cal(L)$ in terms of $dot(phi)$ and $nabla phi$ and hence show that the Hamiltonian is given by
  $ H = integral dd(3, x) (1/2 pi^2 + 1/2 nabla phi dot nabla phi + V(phi)). $
  What is $V(phi)$ for a free scalar field of mass $m$? What is the minimum value of $H$ in this case?
]

$
  pi(x) & := (partial cal(L))/(partial dot(phi)(x)) = dot(phi)(x), \
  H & = integral dd(3, x) cal(H) := integral dd(3, x) (pi dot(phi) - cal(L)) = integral dd(3, x) (dot(phi)^2 - 1/2 dot(phi)^2 + 1/2 (nabla phi)^2 + V(phi)) \
  & = integral dd(3, x) (1/2 pi^2 + 1/2 (nabla phi)^2 + V(phi)).
$
$V(phi) = 1/2 m^2 phi^2$ and $H >= 0$ because it depends on squares of the field and the field is real, i.e. $phi^2 in RR_+$.

#task(label: "ii")[
  Define $T^(mu nu) = partial^mu phi partial^nu phi - eta^(mu nu) (1/2 partial_lambda phi partial^lambda phi - V(phi))$ and
  $ M^(mu nu rho) = T^(mu nu) x^rho - T^(mu rho) x^nu. $
  Show that $partial_mu T^(mu nu) = 0$ if $phi$ satisfies the equation of motion $partial_mu partial^mu phi + V'(phi) = 0$ and hence that $partial_mu M^(mu nu rho) = 0$.
]

$
  partial_mu T^(mu nu) & = partial_mu partial^mu phi partial^nu phi + underline(partial^mu phi partial_mu partial^nu phi) - 1/2 underline(partial^nu partial_lambda phi partial^lambda phi) - 1/2 underline(partial_lambda phi partial^nu partial^lambda phi) + partial^nu V(phi) \
  & = partial_mu partial^mu phi partial^nu phi + partial/(partial phi) V(phi) partial^nu phi = underbrace((partial_mu partial^mu phi + V'(phi)), 0 "(e.o.m.)") partial^nu phi = 0, \
  partial_mu M^(mu nu rho) & = underbrace(partial_mu T^(mu nu), 0) x^rho + T^(rho nu) - underbrace(partial_mu T^(mu rho), 0) x^nu - T^(nu rho) = T^(rho nu) - T^(rho nu) = 0,
$
where we used that $T^(mu nu)$ is symmetric under exchange of $mu$ and $nu$.

#task(label: "iii")[
  Consider the integrals
  $ Q^mu = integral dd(3, x) T^(0 mu) (t, arrow(x)), quad Q^(mu nu) = integral dd(3, x) M^(0 mu nu) (t, arrow(x)). $
  How do they depend on $t$? What does $Q^mu$ represent physically? What about $Q^(i j)$, where $i, j in {1, 2, 3}$? Write down the components of $Q^mu$ and show explicitly that one is related to $H$.
]

Both quantities, $Q^mu$ and $Q^(mu nu)$, are time-independent. To show this, we compute their time derivatives using the result of part ii):
$
  dot(Q)^mu & = integral dd(3, x) partial_t T^(0 mu) (t, arrow(x)) attach(=, t: "ii)") -integral dd(3, x) partial_i T^(i mu) (t, arrow(x)) = -integral_(partial RR^3) dd(A_i) T^(i mu) (t, arrow(x)) = 0, \
  dot(Q)^(mu nu) & = integral dd(3, x) partial_t M^(0 mu nu) attach(=, t: "ii)") -integral dd(3, x) partial_i M^(i mu nu) (t, arrow(x)) = -integral_(partial RR^3) dd(A_i) M^(i mu nu) (t, arrow(x)) = 0,
$
where we assumed in both cases that the quantities vanish at spatial infinity. $Q^mu$ are the Noether charges, in this case corresponding to the total conserved four-momentum. We see this by computing
$
  integral dd(3, x) T^(00) & = integral dd(3, x) (dot(phi)^2 - cal(L)) = integral dd(3, x) (pi dot(phi) - cal(L)) = integral dd(3, x) cal(H) = H = Q^0, \
  integral dd(3, x) T^(0 i) & = integral dd(3, x) dot(phi) partial^i phi = integral dd(3, x) pi partial^i phi = P^i = Q^i
$
and hence $Q^mu = (H, P^i)$ for $i in {1, 2, 3}$.
$
  Q^(i j) & = integral dd(3, x) M^(0 i j) = integral dd(3, x) (T^(0 i) x^j - T^(0 j) x^i) = integral dd(3, x) (dot(phi) partial^i phi x^j - dot(phi) partial^j phi x^i) \
  & = integral dd(3, x) dot(phi) (partial^i phi x^j - partial^j phi x^i).
$
So we find $Q^(i j)$ to be the total angular momentum of the field $phi$.

#task(label: "iv")[Show that $pb(Q^mu, phi(x)) = -partial_mu phi(x)$ and comment on the result. Comment briefly on what you expect for the Poisson brackets between different components of $Q^mu$ and $Q^(mu nu)$.]

$
  pb(Q^0, phi(x)) & = integral dd(3, x) pb(T^(00), phi) = integral dd(3, x) pb(dot(phi)^2 - 1/2 (partial phi)^2 + V(phi), phi) \
  & = 1/2 integral dd(3, x) pb(pi^2, phi) = integral dd(3, x) pi pb(pi, phi) = -integral dd(3, x) dot(phi) delta^((3)) (arrow(x) - arrow(y)) = -dot(phi), \
  pb(Q^i, phi(x)) & = integral dd(3, x) pb(T^(0 i), phi) = -integral dd(3, x) pb(dot(phi) partial^i phi, phi) = -integral dd(3, x) partial^i phi pb(pi, phi) \
  & = +integral dd(3, x) partial^i phi delta^((3)) (arrow(x) - arrow(y)) = partial^i phi.
$
This reflects the fact that $Q^mu$ are the generators of the translation symmetry group. Similarly $Q^(mu nu)$ are the generators of the Lorentz symmetry group. Collectively, ${Q^mu, Q^(mu nu)}$ form a representation of the Poincaré group under the Poisson bracket.

= Problem 2 (20 points)

#task[
  Consider a free real scalar field $phi(x)$ with conjugate momentum density $pi(x) = dot(phi)(x)$. Define the operator
  $ a_p = integral dd(3, x) e^(-i arrow(p) dot arrow(x))/sqrt(2 E_p) (E_p phi(0, arrow(x)) + i pi(0, arrow(x))), quad "where" E_p = sqrt(arrow(p)^2 + m^2). $
]

#task(label: "i")[
  The equal-time commutation relations (ETCRs) state that
  $ [phi(t, arrow(x)), pi(t, arrow(y))] = i delta^((3)) (arrow(x) - arrow(y)). $
  Are the fields $phi(x)$ and $pi(x)$ in the Schrödinger or Heisenberg picture? Why is this picture more natural in a relativistic theory? What are the ETCRs for $[phi(t, arrow(x)), phi(t, arrow(y))]$ and $[pi(t, arrow(x)), pi(t, arrow(y))]$?
]

The above are Heisenberg picture fields since in the Schrödinger picture, all time dependencies are carried exclusively by the states. Heisenberg picture operators are much more at home in the Minkowski space, also called spacetime, of relativistic physics.

The combinations of fields given above commute, i.e.
$ [phi(t, arrow(x)), phi(t, arrow(y))] = [pi(t, arrow(x)), pi(t, arrow(y))] = 0. $

#task(label: "ii")[
  Give an expression for $a_p^dagger$. Using the ETCRs show that
  $ [a_p, a_q^dagger] = (2 pi)^3 delta^((3)) (arrow(p) - arrow(q)), quad [a_p, a_q] = [a_p^dagger, a_q^dagger] = 0. $
]
