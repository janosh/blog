#import "/notes.typ": dd, notes, tagged, task

#show: notes.with(
  title: [General Relativity -- Exercise Sheet 7],
  subtitle: [Exercise sheet 7, General Relativity, Prof. Björn Schäfer],
  date: [Solutions by Janosh Riebesell, 19.07.2015],
)

= Problem 1 (Equation-of-state parameter meets scalar field) [15 points]

#task[
  The continuity equation for the energy density of the cosmos reads
  #tagged(1, $ dot(rho) + 3 dot(a)/a rho (1 + w) = 0, $)
  with the eq.-of-state parameter $w = p/(c^2 rho)$. For $w$ constant, it leads to an eq. describing the time evolution of the density of the form
  $ rho = rho_0 a^(-3(1 + w)). $
  For $Lambda$, we had $w_Lambda = -1$, which means $rho_Lambda$ constant. It has been suggested that $w_Lambda = w_Lambda (a)$.
]

#task(label: "a")[
  Show that
  $ rho = rho_0 exp(-3 integral_1^a dif(ln a') [1 + w(a')]) $
  solves eq. (1) for a scale-factor-dependent $w(a)$.
]

$ dot(rho) = rho_0 exp(-3 integral_1^a dif(ln a') [1 + w(a')]) dif/(dif t) (-3 integral_1^a dif(ln a') [1 + w(a')]), $
where $dif(ln a') = (dif a')/a' = 1/a' (dif a')/(dif t) dif t = dot(a)'/a' dif t$. Thus
$
  dot(rho) & = rho (-3 integral_1^a dd(t) dif/(dif t) dot(a)'/a' [1 + w(a')]) = -3 rho (dot(a)/a [1 + w(a)] - [1 + underbrace(w(1), -1)]) \
  & = -3 dot(a)/a rho [1 + w(a)],
$
where $w(1) = w(a(t_0)) = -1$ as stated above. Therefore,
$ dot(rho) + 3 dot(a)/a rho (1 + w(a)) = [-3 dot(a)/a (1 + w(a)) + 3 dot(a)/a (1 + w(a))] rho = 0. $

#task(label: "b")[
  We have calculated that for a scalar field $phi.alt$ with a Lagrangian $L = -1/2 partial_mu phi.alt partial^mu phi.alt - V(phi.alt)$, the pressure and energy density can, under the assumption of homogeneity and isotropy of the field, be written
  #tagged(2, $ p = 1/2 dot(phi.alt)^2 - V(phi.alt), quad rho c^2 = 1/2 dot(phi.alt)^2 + V(phi.alt). $)
]

Therefore, the eq.-of-state parameter $w$ becomes
$ w = (dot(phi.alt)^2 - 2 V(phi.alt))/(dot(phi.alt)^2 + 2 V(phi.alt)), $
which, for a vanishing kinetic term $dot(phi.alt) = 0$, mimics that of a cosmological constant, $w = -1$.

#task[By plugging the densities and pressures of a scalar field into eq. (1), can you arrive at an e.o.m. for $phi.alt$?]

$ dot(rho) c^2 = dot(phi.alt) dot.double(phi.alt) + (partial V(phi.alt))/(partial phi.alt) dot(phi.alt) = (dot.double(phi.alt) + V'(phi.alt)) dot(phi.alt). $
Insertion into eq. (1) multiplied by $c^2$ yields
$
  dot(rho) c^2 + 3 dot(a)/a rho c^2 (1 + w) & = (dot.double(phi.alt) + V'(phi.alt)) dot(phi.alt) + 3 dot(a)/a (1/2 dot(phi.alt)^2 + V(phi.alt)) (1 + (1/2 dot(phi.alt)^2 - V(phi.alt))/(1/2 dot(phi.alt)^2 + V(phi.alt))) \
  & = (dot.double(phi.alt) + V'(phi.alt)) dot(phi.alt) + 3 dot(a)/a dot(phi.alt)^2 = 0 \
  ==> quad 0 & = dot.double(phi.alt) + 3 dot(a)/a dot(phi.alt) + V'(phi.alt).
$
Since our investigation is concerned with a cosmos we assume to be isotropic and, in particular, homogeneous, we have $phi.alt = phi.alt(cancel(arrow(x)), t)$ and thus $nabla phi.alt(t) = 0$.

Except for the term $3 dot(a)/a dot(phi.alt)$, our result therefore markedly resembles the Klein-Gordon eq.
$ square phi.alt + (partial V(phi.alt))/(partial phi.alt) = 0 $
of a scalar field in some potential $V(phi.alt)$.

= Problem 2 (Field equations) [15 points]

#task[
  Show that the Einstein field equations,
  #tagged(3, $ R_(mu nu) - R/2 g_(mu nu) + Lambda g_(mu nu) = -(8 pi G)/c^4 T_(mu nu), $)
  could equally well be written as
  #tagged(4, $ R_(mu nu) = -(8 pi G)/c^4 [T_(mu nu) - T/2 g_(mu nu)] + Lambda g_(mu nu). $)
]

By contracting all indices, eq. (3) becomes (we use $attach(g, tr: mu, br: mu) = g^(mu nu) g_(mu nu) = attach(delta, tr: mu, br: mu) = 4$)
$ R - R/2 4 + 4 Lambda = -R + 4 Lambda = -(8 pi G)/c^4 T, $
where $R = attach(R, tr: mu, br: mu) = g^(mu nu) R_(mu nu)$ and $T = attach(T, tr: mu, br: mu) = g^(mu nu) T_(mu nu)$. We multiply our intermediate result with $-1/2 g_(mu nu)$ and add it to the field eqs. (3) to get
$ R_(mu nu) - R/2 g_(mu nu) + Lambda g_(mu nu) + R/2 g_(mu nu) - 2 Lambda g_(mu nu) = -(8 pi G)/c^4 (T_(mu nu) - T/2 g_(mu nu)), $
which is equivalent to
$ R_(mu nu) = -(8 pi G)/c^4 (T_(mu nu) - T/2 g_(mu nu)) + Lambda g_(mu nu). $

= Problem 3 (A Hubble diagram for the 21st century) [10 points]

#task(label: "a")[We cannot distinguish between cosmic and Doppler redshift. How do we know that most receding objects follow the cosmic flow and are not actively moving away?]

Good question.

= Problem 4 (Extra: CPT symmetry) [5 points]

#task[Are the Einstein field equations CPT-invariant? I.e. do physical processes stay the same if one were to transform $x^mu -> -x^mu$ and $q -> -q$?]

Yes, both sides of
$ R_(mu nu) = -(8 pi G)/c^4 (T_(mu nu) - T/2 g_(mu nu)) + g_(mu nu) Lambda $
are CPT-even. This implies that an antimatter energy-momentum tensor generates a gravitational field, i.e. spacetime curvature, in the same way as one for matter does.
