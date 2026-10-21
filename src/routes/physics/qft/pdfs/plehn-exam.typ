#import "/notes.typ": dd, notes, tagged, task

#show: notes.with(
  title: [Exam on Quantum Field Theory I],
  subtitle: [Devised by Tilman Plehn, written on 11.04.2012],
  date: [Solutions by Janosh Riebesell, 04.02.2015],
)

// Lorentz-invariant measure d^3k / ((2 pi)^3 2 E_k), written with a tilde over the d
#let dk(k) = $tilde(dif) #k thin$

= Problem 1 (12 points) -- Quantization of a complex scalar field

#task[
  A free complex-valued scalar field is described by the Lagrangian density
  #tagged(1, $ cal(L) = partial_mu phi^dagger partial^mu phi - m^2 phi^dagger phi. $)
]

#task(label: "a")[Show that the above Lagrangian is invariant under the global phase transformation $phi -> e^(i alpha) phi$. What do we call these transformations in the language of field theory? What are the physical implications of such invariances?]

$ phi -> e^(i alpha) phi quad ==> quad phi^dagger -> (e^(i alpha) phi)^dagger = phi^dagger e^(-i alpha), $
$ cal(L) -> cal(L)' = partial_mu phi^dagger e^(-i alpha) partial^mu e^(i alpha) phi - m^2 phi^dagger e^(-i alpha) e^(i alpha) phi = partial_mu phi^dagger partial^mu phi - m^2 phi^dagger phi = cal(L). $
Such a global phase transformation is classified as $U(1)$. Underlying the Lagrangian's invariance is a continuous symmetry. According to Noether's theorem such symmetries invoke conserved charges, i.e. physical quantities.

#task(label: "b")[Find the conjugate momenta associated to each component.]

#tagged(2, $ pi(x) = (partial cal(L))/(partial dot(phi)(x)) = dot(phi)^dagger (x), quad pi^dagger (x) = (partial cal(L))/(partial dot(phi)^dagger (x)) = dot(phi)(x). $)

#task(label: "c")[
  Show that the corresponding Hamiltonian $H$ can be cast as
  #tagged(3, $ H & = integral dd(3, x) cal(H)(x) = integral dd(3, x) (pi(x) dot(phi)(x) + pi^dagger (x) dot(phi)^dagger (x) - cal(L)(x)) \
    & = integral dd(3, x) (pi(x) pi^dagger (x) + nabla phi^dagger (x) nabla phi(x) + m^2 phi^dagger (x) phi(x)). $)
]

$
  pi(x) dot(phi)(x) + pi^dagger (x) dot(phi)^dagger (x) - cal(L)(x) & = dot(phi)^dagger dot(phi) + dot(phi) dot(phi)^dagger - dot(phi)^dagger dot(phi) + nabla phi^dagger nabla phi + m^2 phi^dagger phi \
  & = pi^dagger pi + nabla phi^dagger nabla phi + m^2 phi^dagger phi.
$

#task(label: "d")[
  The corresponding quantized fields we can write as
  $ phi(x) = integral dk(k) (a(k) e^(-i k x) + b^dagger (k) e^(i k x)), quad phi^dagger (x) = integral dk(k) (a^dagger (k) e^(i k x) + b(k) e^(-i k x)). $
  With these expressions at hand, verify that the Hamiltonian (3) takes on the diagonal form
  $ H = integral dd(3, x) cal(H)(x) = integral dk(k) E_k (a^dagger (k) a(k) + b^dagger (k) b(k)). $
]

The time and space derivatives of the fields are
$
  dot(phi)(x) & = -i integral dk(k) E_k (a(k) e^(-i k x) - b^dagger (k) e^(i k x)), & quad dot(phi)^dagger (x) & = i integral dk(k) E_k (a^dagger (k) e^(i k x) - b(k) e^(-i k x)), \
  nabla phi(x) & = i integral dk(k) arrow(k) (a(k) e^(-i k x) - b^dagger (k) e^(i k x)), & quad nabla phi^dagger (x) & = -i integral dk(k) arrow(k) (a^dagger (k) e^(i k x) - b(k) e^(-i k x)).
$
Inserting them into the Hamiltonian, the $x$-integration sets $p = plus.minus k$ and leaves a factor $(2 pi)^3 delta^((3)) (dots) = 2 E_k (2 pi)^3 delta^((3)) (dots) \/ (2 E_k)$, i.e. a factor $1 \/ (2 E_k)$ inside $integral dk(k)$. With $E_k^2 = arrow(k)^2 + m^2$, the terms oscillating in time cancel and we get
$
  H & = integral dd(3, x) cal(H)(x) = integral dd(3, x) (dot(phi) dot(phi)^dagger + nabla phi^dagger nabla phi + m^2 phi^dagger phi) \
  & = integral dd(3, x) integral dk(k) E_k (a(k) e^(-i k x) - b^dagger (k) e^(i k x)) integral dk(p) E_p (a^dagger (p) e^(i p x) - b(p) e^(-i p x)) \
  & quad + integral dd(3, x) integral dk(k) arrow(k) (a(k) e^(-i k x) - b^dagger (k) e^(i k x)) integral dk(p) arrow(p) (a^dagger (p) e^(i p x) - b(p) e^(-i p x)) \
  & quad + m^2 integral dd(3, x) integral dk(k) (a(k) e^(-i k x) + b^dagger (k) e^(i k x)) integral dk(p) (a^dagger (p) e^(i p x) + b(p) e^(-i p x)) \
  & = integral dk(k) E_k/2 (a(k) a^dagger (k) - a(k) b(-k) e^(-2 i E_k t) - b^dagger (k) a^dagger (-k) e^(2 i E_k t) + b^dagger (k) b(k)) \
  & quad + integral dk(k) (arrow(k)^2)/(2 E_k) (a(k) a^dagger (k) + a(k) b(-k) e^(-2 i E_k t) + b^dagger (k) a^dagger (-k) e^(2 i E_k t) + b^dagger (k) b(k)) \
  & quad + integral dk(k) m^2/(2 E_k) (a(k) a^dagger (k) + a(k) b(-k) e^(-2 i E_k t) + b^dagger (k) a^dagger (-k) e^(2 i E_k t) + b^dagger (k) b(k)) \
  & = integral dk(k) E_k (a(k) a^dagger (k) + b^dagger (k) b(k)) = integral dk(k) E_k (a^dagger (k) a(k) + (2 pi)^3 2 E_k delta^((3)) (0) + b^dagger (k) b(k)) \
  & = integral dk(k) E_k (a^dagger (k) a(k) + b^dagger (k) b(k)) + 2 (2 pi)^3 integral dk(k) E_k^2 delta^((3)) (0),
$
The last term is the (infinite) zero-point energy, which is dropped by normal ordering.
