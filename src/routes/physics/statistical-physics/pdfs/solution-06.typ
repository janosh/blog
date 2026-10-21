#import "/notes.typ": task, vb, kB, ev, eqby
#import "/statistical-physics/sheet.typ": points, sheet
#import "@preview/cetz:0.5.2": canvas
#import "@preview/cetz-plot:0.1.4": plot

#show: sheet.with(6, [December 9th, 2016])

#let (bx, bp, bF) = ($vb(x)$, $vb(p)$, $vb(F)$)
#let Ntot = $N_"tot"$

// x and -x ln(x) on [0, 1], both concave
#let concave-plot = canvas({
  plot.plot(
    size: (6, 4.5),
    x-label: $x$,
    y-label: none,
    x-tick-step: 0.2,
    y-tick-step: 0.2,
    x-min: 0,
    x-max: 1,
    y-min: 0,
    y-max: 1,
    legend: "inner-north-west",
    {
      plot.add(x => x, domain: (0, 1), style: (stroke: blue + 0.8pt), label: $x$)
      plot.add(x => if x == 0 { 0 } else { -x * calc.ln(x) }, domain: (0, 1), samples: 200, style: (stroke: red + 0.8pt), label: $-x ln(x)$)
    },
  )
})

= Ideal gas in a harmonic potential #points(4)

#task[
  An ideal gas is trapped in a three-dimensional harmonic potential
  $ V(bx) = a bx^2 = a (x_1^2 + x_2^2 + x_3^2), #h(3em) a > 0. $
  + What is the equilibrium distribution at temperature $T$?
  + Calculate the density of the gas and its pressure and their dependence on $x$.
  + Calculate the internal energy $U$ (as the expected value of the energy), and the heat capacity.
  + Define the volume of the gas as the expected value of $(4 pi)/3 |bx|^3$. Calculate the volume and the thermal expansion coefficient of the gas.
]

+ As we showed in exercise 3 on sheet 5, the stationary Boltzmann equation
  $ bp/m dot vb(nabla)_x f(bx, bp) = -bF(bx) dot vb(nabla)_p f(bx, bp) $
  admits solutions of the form of the Maxwell-Boltzmann distribution
  $ f(bx, bp) = cal(N) e^(-beta E(bx, bp)), $
  where $beta = 1 \/ kB T$ and $E(bx, bp) = bp^2/(2 m) + a bx^2$ is the system's total energy. Since equilibrium must be stationary (although the converse is not always true), we know that the gas is described by a distribution of this type. The normalization $cal(N)$ is fixed by requiring that the phase space density integrate to the total number of particles $N$ that make up the gas,
  $ integral.double f(bx, bp) dif^3 x dif^3 p = cal(N) integral e^(-a beta bx^2) dif^3 x integral e^(-beta bp^2/(2 m)) dif^3 p = cal(N) (pi/(a beta))^(3/2) ((2 pi m)/beta)^(3/2) limits(=)^! N. $
  We used $a > 0$ above. Thus,
  $ cal(N) = (a^(3/2) beta^3)/((2 m)^(3/2) pi^3) N, $
  and the equilibrium distribution at temperature $T$ reads
  $ f(bx, bp) = (a^(3/2) beta^3 N)/((2 m)^(3/2) pi^3) exp[-beta (bp^2/(2 m) + a bx^2)]. $
+ To find the spatial density $n(bx)$ of the trapped gas, we integrate the phase space density over all momenta,
  $ n(bx) = integral f(bx, bp) dif^3 p = (a^(3/2) beta^3 N)/((2 m)^(3/2) pi^3) (2 pi m \/ beta)^(3/2) e^(-a beta bx^2) = ((a beta)/pi)^(3/2) N e^(-a beta bx^2). $ <eq:density>
  It is instructive to verify that the units work out. Since the exponent $a beta bx^2$ must be dimensionless, $a beta$ has dimensions of inverse area and so $N \/ (a beta)^(3\/2)$ is indeed a number density. Due to the rapidly decaying exponential, the gas is strongly localized. Defining the oscillation amplitude $ell = 1 \/ sqrt(a beta) = sqrt(kB T \/ a)$, we see that for increased temperature, the gas has a wider density profile. This is consistent with the kinetic gas theory interpretation that particles of higher temperature will have higher average energy and are able to climb further up the trap walls. \
  To derive the pressure, we assume local equilibrium, i.e. the ideal gas law should hold locally at every $bx$. Thus
  $ p(bx) = n(bx) kB T = N kB T ((a beta)/pi)^(3/2) e^(-a beta bx^2). $
+ The internal energy is the expectation value
  $
    U & = integral.double E(bx, bp) f(bx, bp) dif^3 x dif^3 p \
      & = (pi/(a beta))^(3/2) cal(N) integral bp^2/(2 m) e^(-beta bp^2/(2 m)) dif^3 p + (2 pi m \/ beta)^(3/2) cal(N) integral a bx^2 e^(-a beta bx^2) dif^3 x \
      & = -(beta/(2 pi m))^(3/2) N partial_beta integral e^(-beta bp^2/(2 m)) dif^3 p - ((a beta)/pi)^(3/2) N partial_beta integral e^(-a beta bx^2) dif^3 x \
      & = -(beta/(2 pi m))^(3/2) N partial_beta (2 pi m \/ beta)^(3/2) - ((a beta)/pi)^(3/2) N partial_beta (pi/(a beta))^(3/2) \
      & = 3/2 N/beta + 3/2 N/beta = 3 N kB T.
  $ <eq:energy>
  The equipartition theorem is able to shed some light on this result. It states that in thermal equilibrium, energy is shared equally amongst all accessible degrees of freedom, which is just another way of saying that an equilibrated system will maximize its entropy. Distributing the available energy evenly amongst all accessible modes maximizes the number of microstates consistent with the observed macrostate. \
  However, the equipartition theorem also makes a quantitative prediction. It states that each quadratic degree of freedom will, on average, possess an energy $1/2 kB T$. In this case, we indeed have $6 N$ quadratic degrees of freedom since the kinetic energy of each of the $N$ particles is $prop bp^2$ while the potential energy is $prop bx^2$. \
  The heat capacity immediately follows from @eq:energy as
  $ C = (partial U)/(partial T) = 3 N kB, $
  which is twice the heat capacity of an ideal gas contained in a potential-free box.
+ The expectation value of $|bx|^3$ is
  $
    ev(|bx|^3) & = integral |bx|^3 n(bx) dif^3 x eqby("eq:density") ((a beta)/pi)^(3/2) N integral |bx|^3 e^(-a beta bx^2) dif^3 x \
    & = (4 pi)/2 ((a beta)/pi)^(3/2) N integral_0^infinity u^2 e^(-a beta u) dif u = (4 pi)/2 ((a beta)/pi)^(3/2) N partial_(a beta)^2 integral_0^infinity e^(-a beta u) dif u \
    & = (4 pi)/2 ((a beta)/pi)^(3/2) N partial_(a beta)^2 1/(a beta) = (4 pi)/2 ((a beta)/pi)^(3/2) N 2/(a beta)^3 = (4 pi N)/(pi a beta)^(3/2).
  $
  where we used the transformation $u = bx^2$, $dif u = 2 |bx| dif x$. Thus the gas fills a sphere of volume
  $ V = (4 pi)/3 ev(|bx|^3) = (16 sqrt(pi))/3 N/(a beta)^(3/2). $
  The thermal expansion coefficient is given by
  $ alpha = 1/V lr((partial V)/(partial T) |)_(a,N) = 3/(2 T). $

= Equilibrium distribution #points(4)

#task[
  Let $N in NN$ be large and $g_i >= 0 thick forall i in {1, ..., N}$ with $sum_(i=1)^N g_i = 1$. We define the probability distribution
  $ p(n_1, ..., n_N) = g_1^(n_1) ... g_N^(n_N) ((n_1 + dots.c + n_N)!)/(n_1! ... n_N!). $ <eq:multinomial>
  Determine the most probable distribution of $n_i$ (assuming that $n_i >> 1$ for all $i$), and compute the deviations $ev(n_i^2) - ev(n_i)^2$ from this distribution asymptotically for large $n_i$. (Here $ev(dot)$ is the expectation value with respect to the probability distribution given by $p$.)
]

First, note that we can rewrite the distribution @eq:multinomial more compactly,
$ p(n_1, ..., n_N) = Ntot ! product_(i=1)^N g_i^(n_i)/n_i!, $ <eq:compact>
where $Ntot = sum_(i=1)^N n_i$. Since $n_i >> 1 thick forall i in {1, ..., N}$, we can take the logarithm of @eq:compact and use Stirling's approximation for large factorials, $ln(n!) = n ln(n) - n + cal(O)(ln n)$ to get
$
  ln(p) & = ln(Ntot !) + sum_(i=1)^N [n_i ln(g_i) - ln(n_i !)] \
        & tilde Ntot ln(Ntot) - Ntot + sum_(i=1)^N n_i ln(g_i) - sum_(i=1)^N [n_i ln(n_i) - n_i] \
        & = Ntot ln(Ntot) + sum_(i=1)^N n_i ln(g_i/n_i).
$ <eq:log-p>
This asymptotic form of $ln(p)$ becomes exact as $n_i -> infinity thick forall i$. Differentiating @eq:log-p w.r.t $n_i$ gives
$
  (partial ln(p))/(partial n_i) & = partial/(partial n_i) [Ntot ln(Ntot)] + partial/(partial n_i) [sum_(j=1)^N n_j ln(g_j/n_j)] \
  & = ln(Ntot) + 1 + ln(g_i/n_i) - 1 \
  & = ln(Ntot g_i/n_i),
$ <eq:d-log-p>
where we used $partial Ntot \/ partial n_i = 1$. To find the extremum distribution, we require that @eq:d-log-p be zero for all $i in {1, ..., N}$.#footnote[Here, we use that the logarithm is strictly monotonic on $(0, infinity)$ since $partial_x ln(x) = 1 \/ x > 0 thick forall x in (0, infinity)$ and so the maximum of $ln(p)$ will also be the maximum of $p$.] This results in
$ ln(Ntot g_i/n_i) limits(=)^! 0 #h(3em) => #h(3em) n_i^"ext" = g_i Ntot quad forall i in {1, ..., N}. $ <eq:extremum>
The multinomial distribution @eq:multinomial implicitly fixes $Ntot$, so the term $Ntot ln(Ntot)$ in @eq:log-p is a constant. The remaining terms are linear in $n_i$ or of the form $-n_i ln(n_i)$, both concave functions as can be seen from the plot below. Since $ln(p)$ decomposes into sums of these components, it too must be concave. Any extremum of a concave function is a maximum, so we can infer that $n_i^"ext" = n_i^max$ in @eq:extremum.
#align(center, concave-plot)
Next we consider deviations from this distribution. First, note that by the multinomial theorem
$ 1 = (sum_(i=1)^N g_i)^Ntot = sum_(n_1, ..., n_N) p(n_1, ..., n_N), $ <eq:sum-one>
meaning the probabilities sum to one as they should for any distribution. Using @eq:sum-one, we calculate the first and second moment of our distribution.
$
  ev(n_i) & = sum_(n_1, ..., n_N) n_i p(n_1, ..., n_N) eqby("eq:multinomial") sum_(n_1, ..., n_N) g_i partial/(partial g_i) p(n_1, ..., n_N) \
  & eqby("eq:sum-one") g_i partial/(partial g_i) (sum_(j=1)^N g_j)^Ntot = g_i Ntot underbrace((sum_(j=1)^N g_j), 1)^(Ntot - 1) \
  & = g_i Ntot = n_i^max,
$ <eq:first-moment>
i.e. the mean coincides exactly with the most probable distribution. Similarly,
$
  ev(n_i^2) & = sum_(n_1, ..., n_N) n_i^2 p(n_1, ..., n_N) = sum_(n_1, ..., n_N) g_i partial/(partial g_i) g_i partial/(partial g_i) p(n_1, ..., n_N) \
  & = g_i partial/(partial g_i) g_i partial/(partial g_i) (sum_(j=1)^N g_j)^Ntot = g_i (Ntot + g_i Ntot (Ntot - 1)) \
  & = n_i^max + g_i n_i^max (Ntot - 1) = (n_i^max)^2 + n_i^max (1 - g_i).
$ <eq:second-moment>
@eq:first-moment and @eq:second-moment yield a deviation
$ Delta n_i = ev(n_i^2) - ev(n_i)^2 = n_i^max (1 - g_i) = Ntot g_i (1 - g_i), $
whose relative size $sqrt(Delta n_i) \/ ev(n_i) = sqrt((1 - g_i) \/ n_i^max)$ vanishes for large $n_i$.

= $n$-Ball #points(2)

#task[Compute the volume of a sphere of radius $R$ in $n$-dimensional space. For $n = 100$, compare the volume of a sphere of radius 1 with one of radius 0.99.]

The volume of an $n$-ball can be calculated without ever parametrizing an infinitesimal volume element in $n$-dimensional spherical coordinates by invoking properties of the Gauss integral and the Gamma function
$ integral_(-infinity)^infinity e^(-x^2) dif x = sqrt(pi), #h(3em) integral_0^infinity x^(n-1) e^(-x) dif x = Gamma(n). $
To this end, note that
$ pi^(n/2) = product_(i=1)^n integral_(-infinity)^infinity e^(-x_i^2) dif x_i = integral_(RR^n) e^(-bx^2) dif^n x. $
Since the integrand depends only on the magnitude of the vector $bx$, this integral factorizes into a purely radial part and an angular integration,
$ pi^(n/2) = (integral_0^infinity |bx|^(n-1) e^(-bx^2) dif |bx|) (integral dif^(n-1) Omega_(n-1)) = 1/2 Gamma(n/2) integral dif^(n-1) Omega_(n-1), $ <eq:factorized>
where we used the transformation $u = |bx|^2$, $dif u = 2 sqrt(u) dif |bx|$ to bring the radial integration into the form of the Gamma function,
$ integral_0^infinity |bx|^(n-1) e^(-bx^2) dif |bx| = integral_0^infinity u^(1/2 (n-1)) e^(-u) (dif u)/(2 sqrt(u)) = 1/2 integral_0^infinity u^(n/2 - 1) e^(-u) dif u = 1/2 Gamma(n/2). $
From @eq:factorized, we gather that the surface area of the $(n - 1)$-dimensional unit sphere is given by
$ A_(n-1) (1) = integral dif^(n-1) Omega_(n-1) = (2 pi^(n/2))/Gamma(n/2). $
Since $Gamma(n) = (n - 1)!$ for $n in NN$, $Gamma(1/2) = sqrt(pi)$, and $Gamma(n + 1) = n Gamma(n)$, this indeed gives the familiar results for the circumference of the unit disk in two and the surface of a unit ball in three dimensions,
$ A_1 (1) = (2 pi)/Gamma(1) = 2 pi, #h(3em) A_2 (1) = (2 pi^(3/2))/Gamma(3/2) = (2 pi^(3/2))/(1/2 Gamma(1/2)) = 4 pi. $
The $n$-ball of radius $R$ is the union of all concentric $(n - 1)$-spheres up to radius $R$. Its volume thus follows from the surface of the unit sphere by a simple polynomial integration,
$ V_n (R) = integral_0^R A_(n-1) (1) r^(n-1) dif r = (2 pi^(n/2))/(n Gamma(n/2)) lr(r^n |)_0^R = pi^(n/2)/Gamma(n/2 + 1) R^n. $ <eq:ball-volume>
In $n = 100$ dimensions, we get a ratio of the volume of the unit sphere to one with radius $R = 0.99$ of
$ V_100 (1)/V_100 (0.99) = 1/0.99^100 approx 2.732. $

*Alternative solution* #h(0.5em) We may also employ the more hands-on approach of parametrizing $RR^n$ using $n$-dimensional spherical coordinates. We can then construct volume and surface elements via Jacobian determinants and integrate these to determine the volume of the whole $n$-ball. Let $r in [0, infinity)$ be the radial coordinate and $phi_1, ..., phi_(n-2) in [0, pi]$ and $phi_(n-1) in [0, 2 pi)$ the angular coordinates. Then
$
  x_1 & = r cos(phi_1) \
  x_2 & = r sin(phi_1) cos(phi_2) \
  x_3 & = r sin(phi_1) sin(phi_2) cos(phi_3) \
      & dots.v \
  x_(n-1) & = r sin(phi_1) ... sin(phi_(n-2)) cos(phi_(n-1)) \
  x_n & = r sin(phi_1) ... sin(phi_(n-2)) sin(phi_(n-1))
$
provides a one-to-one mapping from Cartesian to spherical coordinates for all of $RR^n$ (except for the origin which we define as $r = 0, phi_i = 0 thick forall i in {1, ..., n - 1}$). Also it is easily checked that $sum_(i=1)^n x_i x_i = r^2$, as it should for spherical coordinates. The Jacobian matrix $(partial (x_i))/(partial (r, phi_j))$ associated with the coordinate transformation $(x_i) -> (r, phi_i)$ reads
$
  mat(
    cos(phi_1), -r sin(phi_1), 0, 0, dots.c, 0;
    sin(phi_1) cos(phi_2), r cos(phi_1) cos(phi_2), -r sin(phi_1) sin(phi_2), 0, dots.c, 0;
    dots.v, dots.v, dots.v, , dots.down, dots.v;
    , , , , , 0;
    sin(phi_1) ... sin(phi_(n-2)) cos(phi_(n-1)), dots.c, dots.c, , , -r sin(phi_1) ... sin(phi_(n-2)) sin(phi_(n-1));
    sin(phi_1) ... sin(phi_(n-2)) sin(phi_(n-1)), r cos(phi_1) ... sin(phi_(n-1)), dots.c, , , r sin(phi_1) ... sin(phi_(n-2)) cos(phi_(n-1))
  ).
$
Computing the absolute value of the determinant of this matrix for small values of $n$, one finds
$
  n = 2: wide & abs(det((partial (x, y))/(partial (r, phi)))) = r, \
  n = 3: wide & abs(det((partial (x_1, x_2, x_3))/(partial (r, phi_1, phi_2)))) = r^2 sin(phi_1), \
  n = 4: wide & abs(det((partial (x_1, x_2, x_3, x_4))/(partial (r, phi_1, phi_2, phi_3)))) = r^3 sin^2 (phi_1) sin(phi_2).
$
One can already guess from these findings that the result for arbitrary $n in NN$ is
$ abs((partial (x_i))/(partial (r, phi_i))) = r^(n-1) sin^(n-2) (phi_1) sin^(n-3) (phi_2) ... sin(phi_(n-2)). $
We will not prove this but simply postulate it.#footnote[Unfortunately, induction cannot be used in this case because the Jacobian in $n$ dimensions does not contain the $(n - 1)$-dimensional Jacobian as a submatrix. This renders the proof a bit involved. The general idea is to factor out most of the $r$ and $phi_i$ dependent terms from the matrix and use Gauss elimination to bring the matrix into diagonal form.] Thus, the volume element is
$ dif^n V = r^(n-1) sin^(n-2) (phi_1) ... sin(phi_(n-2)) dif r dif phi_1 ... dif phi_(n-1). $
Hence, the volume of the $n$-ball is
$ V_n (R) = integral_0^R dif r integral_0^pi dif phi_1 ... integral_0^pi dif phi_(n-2) integral_0^(2 pi) dif phi_(n-1) r^(n-1) sin^(n-2) (phi_1) ... sin(phi_(n-2)). $
In order to perform the angular integrals, we need to compute $I_k = integral_0^pi sin^k (phi) dif phi$. Integrating by parts and using $sin^2 (phi) = 1 - cos^2 (phi)$, we find the recursion relation
$ I_k = (k - 1)/k I_(k-2), $ <eq:recursion>
with initial conditions $I_0 = pi$ and $I_1 = 2$. Remembering that the Gamma function satisfies the recursion relation $Gamma(x + 1) = x Gamma(x)$, we infer that a general solution of @eq:recursion is
$ I_k = alpha Gamma((k + 1)/2)/Gamma(k/2 + 1) $
with some constant $alpha in RR$. Using $Gamma(1 \/ 2) = sqrt(pi)$ and $Gamma(1) = 1$, we identify $alpha$ as $sqrt(pi)$. Since the solution to a linear second-order difference equation such as @eq:recursion is unique given two initial conditions, we have found $I_k$. For the volume of the $n$-ball, this implies
$ V_n (R) = 2/n pi^(n\/2) R^n (Gamma((n - 1)/2) Gamma((n - 2)/2) ... Gamma(3/2) Gamma(1))/(Gamma(n/2) Gamma((n - 1)/2) ... Gamma(3/2)) = (pi^(n\/2) R^n)/Gamma(n/2 + 1), $
since all Gamma functions cancel apart from $n/2 Gamma(n/2) = Gamma(n/2 + 1)$ in the denominator and $Gamma(1) = 1$ in the numerator. The result is the same as in @eq:ball-volume. We can recover from this the area of the $(n - 1)$-sphere by differentiation,
$ A_(n-1) (R) = partial/(partial R) V_n (R) = n/R V_n (R) = (2 pi^(n\/2))/Gamma(n/2) R^(n-1). $
