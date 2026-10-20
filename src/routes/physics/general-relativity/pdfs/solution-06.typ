#import "/notes.typ": dd, notes, tagged, task

#show: notes.with(
  title: [General Relativity -- Exercise Sheet 6],
  subtitle: [Exercise sheet 6, General Relativity, Prof. Björn Schäfer],
  date: [Solutions by Janosh Riebesell, 13.07.2015],
)

= Problem 1 (Density evolution) [15 points]

#task[
  Starting from the FLRW metric, if we assume the universe to be filled with a perfect fluid, then the Einstein field equations can be reduced to just two equations: the Friedmann equations
  #tagged(1, $ H^2 = (dot(a)/a)^2 = (8 pi G)/3 rho + (Lambda c^2)/3 - (k c^2)/a^2, $)
  #tagged(2, $ dot.double(a)/a = -(4 pi G)/3 (rho + (3 p)/c^2) + (Lambda c^2)/3. $)
  Here, $a$ is the dimensionless scale factor, with today's value of $a_0 = 1$. The scale factor only depends on time and describes the expansion of the universe. The energy density $rho$ of the universe is coupled to it, meaning it is influenced by the expansion, whilst in turn also influencing the expansion. This shows the intrinsic non-linearity of general relativity.
]

#task(label: "a")[What two symmetry assumptions are going into the FLRW metric? Are they sensible?]

FLRW cosmology assumes an isotropic and homogeneous universe. On a small scale this does not apply, considering the differences between the interior of stars and empty space. However, these assumptions are taken to hold only on the largest scale where such local density variations are averaged over, and receive confirmation from galaxy counts, X- and $gamma$-ray background observations, and, above all, the smoothness of the 3K microwave background radiation.

#task(label: "b")[Show that it is possible to absorb the $Lambda$-term into the energy density of the universe $rho$ and the pressure $p$, and rewrite the Friedmann equations just in terms of $k$, $rho$ and $w$, with $w = p/(rho c^2)$.]

$
  H^2 & = (dot(a)/a)^2 = (8 pi G)/3 (rho + (c^2 Lambda)/(8 pi G)) - (k c^2)/a^2 = (8 pi G)/3 rho' - (k c^2)/a^2, \
  dot.double(a)/a & = -(4 pi G)/3 (rho' - (c^2 Lambda)/(8 pi G) + (3 p)/c^2 - (c^2 Lambda)/(4 pi G)) = -(4 pi G)/3 (rho' + 3/c^2 underbrace((p - (c^4 Lambda)/(8 pi G)), p')) \
  & = -(4 pi G)/3 rho' (1 + (3 p')/(c^2 rho')) = -(4 pi G)/3 rho' (1 + 3 w').
$

*c)* Taking the derivative w.r.t. time of the first Friedmann eq., we get
$ (2 dot(a) dot.double(a))/a^2 - (2 dot(a)^3)/a^3 = (8 pi G)/3 dot(rho) + (2 k c^2 dot(a))/a^3 quad <==> quad dot.double(a)/a - dot(a)^2/a^2 = (4 pi G)/3 a/dot(a) dot(rho) + (k c^2)/a^2. $
The left side is the difference of the two Friedmann equations, i.e.
$ (4 pi G)/3 a/dot(a) dot(rho) + (k c^2)/a^2 = -(4 pi G)/3 (rho + 3 p/c^2) + (c^2 Lambda)/3 - (8 pi G)/3 rho - (c^2 Lambda)/3 + (k c^2)/a^2. $
Above, many terms cancel. When the dust settles, we are left with
$ dot(rho) = H (-(rho + 3 p/c^2) - 2 rho) = -3 H (rho + p/c^2). $

#task(label: "d")[
  Show that for $w$ constant, integrating the continuity equation gives a density scale relation
  #tagged(3, $ rho = rho_0 a^(-3(1 + w)). $)
]

$w = p/(rho c^2)$. Thus, $p/c^2 = w rho$, from which we conclude
$ dot(rho) = -3 H rho (1 + w). $
If $w$ is a constant, integrating is trivial:
$ ln(rho/rho_0) = integral_(t_0)^t (dif rho)/rho = -3 (1 + w) integral_(t_0)^t dot(a)/a dif t = -3 (1 + w) integral_(t_0)^t (dif a)/a = -3 (1 + w) ln(a/a_0). $
Since $a_0 = a(t_0)$ is just one, this means
$ rho = rho_0 a^(-3(1 + w)). $

#task(label: "e")[For matter, we have $w = 0$. For photons, we have $w = 1/3$. Is the scale evolution of $rho$ for the given $w$ surprising?]

$ "matter:" quad rho = rho_0/a^3, #h(3em) "radiation:" quad rho = rho_0/a^4. $
These scale evolutions are not surprising. An $a^(-3)$-behavior is simply the decrease in particle density if all three spatial dimensions increase by a factor of $a(t)$ while the total number of particles remains the same.

Radiation, on the other hand, has a faster $a^(-4)$-fall-off since its density also decreases with increasing space, but photons additionally lose energy with $a^(-1)$ as they redshift over time.

= Problem 2 (Density contributions) [15 points]

#task[
  We saw that we can absorb the vacuum energy density $Lambda$ into the density $rho$. In fact, we can split up the density into an arbitrary number of contributions, e.g.
  $
    rho = sum_i rho_i & = rho_"matter" + rho_"photons" + rho_"vacuum" + rho_"neutrinos" + dots \
    & = rho_m + rho_gamma + rho_Lambda + rho_nu + dots
  $
]

#task(label: "a")[Cosmologists define the critical density $rho_"crit"$, which is given by eq. (1) if $k = 0$. Find $rho_"crit"$ i.t.o. $H$ and $G$. Calculate today's critical density if $H_0 = 68 "km"/("s Mpc")$.]

The first Friedmann equation reads
$ H^2 = 8/3 pi G rho - (k c^2)/a^2. $
Thus for $k = 0$,
$ rho'_"crit" = (3 H^2)/(8 pi G) approx 10^(-26) "kg"/"m"^3 quad "for" quad H_0 = 68 "km"/("s Mpc"). $

#task(label: "b")[
  Now we define the relative matter contribution $Omega$,
  $ Omega := rho/rho_"crit" = sum_i Omega_i = Omega_m + Omega_gamma + Omega_Lambda + Omega_nu + dots $
  What does it mean for the universe if $Omega > 1$, $Omega = 1$, $Omega < 1$, and the Friedmann eq. (1) still needs to hold?
]

Using $Omega$, eq. (1) can be rewritten as
$ Omega - 1 = (k c^2)/(a^2 H^2). $
This means $Omega$ determines the sign of $k$. We have the correspondences
$
  Omega > 1 quad & <--> quad k > 0 quad & <--> quad & "Universe closed", \
  Omega = 1 quad & <--> quad k = 0 quad & <--> quad & "Universe flat", \
  Omega < 1 quad & <--> quad k < 0 quad & <--> quad & "Universe open".
$

#task(label: "c")[
  Using the energy density contribution today $Omega_0 = rho_0/rho_"crit"$, show how to rewrite eq. (1) using eq. (3) as
  #tagged(4, $ H^2 (a) = H_0^2 (sum_i Omega_(0,i) a^(-3(1 + w_i))) = H_0^2 E^2 (a). $)
]

Again for $k = 0$ and with the vacuum energy density $Lambda$ absorbed into $rho$, the first Friedmann eq. becomes just
$
  H^2 (a) & = 8/3 pi G rho attach(=, t: "eq. (3)") 8/3 pi G rho_0 a^(-3(1 + w)) = H_0^2 (8 pi G)/(3 H_0^2) rho_0 a^(-3(1 + w)) \
  & = H_0^2 rho_0/rho_(0,"crit") a^(-3(1 + w)) = H_0^2 Omega_0 a^(-3(1 + w)) = H_0^2 E^2 (a).
$

#task(label: "d")[
  Assuming a flat universe made out of $Omega_m$ and $Omega_Lambda$, we have
  $ Omega_m + Omega_Lambda = 1. $
  Rewrite eq. (4) as
  $ dif t = (dif a)/(a H_0) (Omega_(0,Lambda) + (1 - Omega_(0,Lambda))/a^3)^(-1/2) $
  using $w_m = 0$ and $w_Lambda = -1$. Integrate from $a = 0$ to $a = a_0 = 1$ in order to find out the age of the Universe in the following cases:
  - $Omega_(0,Lambda) = 0.7$, $Omega_(0,m) = 0.3$,
  - $Omega_(0,Lambda) = 0$, $Omega_(0,m) = 1$.
  Given that the oldest globular clusters are about 13.6 Gyr old, what does that say about the two toy models?
]

$ H^2 (a) = dot(a)^2/a^2 = 1/a^2 ((dif a)/(dif t))^2 = H_0^2 sum_i Omega_(0,i) a^(-3(1 + w_i)), $
where the sum is given by
$ Omega_(0,m) a^(-3) + Omega_(0,Lambda) = Omega_(0,Lambda) + (1 - Omega_(0,Lambda))/a^3. $
Reinsertion gives
$ dif t = (dif a)/(a H_0) (Omega_(0,Lambda) + (1 - Omega_(0,Lambda))/a^3)^(-1/2). $
Integrating,
$
  t_0 & = integral_0^(t_0) dd(t) = integral_0^(a_0 = 1) (dif a)/(a H_0) (Omega_(0,Lambda) + (1 - Omega_(0,Lambda))/a^3)^(-1/2) \
  & = 1/H_0 integral_0^1 (dif a)/a (0.7 + 0.3/a^3)^(-1/2) = 0.9641 1/H_0 & "for" Omega_(0,Lambda) = 0.7, \
  & = 1/H_0 integral_0^1 (dif a)/a (1/a^3)^(-1/2) = 1/H_0 integral_0^1 dd(a) sqrt(a) = 1/H_0 lr(2/3 a^(3/2) |)_0^1 = 2/(3 H_0) & "for" Omega_(0,Lambda) = 0.
$
For $Omega_(0,Lambda) = 0.7$, we get an age for the universe of 13.1 Gyr. For $Omega_(0,Lambda) = 0$, this number reduces to 9 Gyr. Given what we know about the age of our Universe, $Omega_(0,Lambda) = 0.7$ is a much more realistic choice than $Omega_(0,Lambda) = 0$.

= Problem 3 (Distance measurements) [10 points]

#task[
  We define the (radial) comoving distance to be
  #tagged(5, $ chi(a) = c integral_a^1 (dif a')/(a'^2 H(a')). $)
]

#task(label: "a")[Assume $Omega = Omega_m = 1$. What does $H(a') = H_0 E(a')$ look like now? Solve the integral analytically, and rename $c/H_0 = chi_H$.]

For $Omega = Omega_m = 1$, $H(a)$ takes the form
$ H(a') = H_0 E(a') = H_0 a'^(-3). $
With this, the comoving distance becomes
$ chi(a) = c integral_a^1 (dif a')/(a'^2 H_0 a'^(-3)) = c/H_0 integral_a^1 a' dif a' = chi_H 1/2 (1 - a^2). $

#task(label: "b")[
  The transverse comoving distance $d_k$ is defined as
  $
    d_k = cases(
      chi_H \/ sqrt(Omega_k) sinh(sqrt(Omega_k) chi(a)/chi_H) & "if" k > 0,
      chi(a) & "if" k = 0,
      chi_H \/ sqrt(-Omega_k) sin(sqrt(-Omega_k) chi(a)/chi_H) & "if" k < 0.
    )
  $
  Why is the transverse comoving distance different from the radial comoving distance for $k != 0$?
]

Because it has to account for the fact that spacetime is curved for $k != 0$.

#task(label: "c")[
  The luminosity distance $d_L$ is defined via the flux we measure from an object of luminosity $L$,
  $ F = L/(4 pi d_L^2) = L(chi)/(4 pi chi^2 (a)) = (L a^2)/(4 pi chi^2 (a)), $
  and therefore $d_L = chi(a) \/ a$. Give an argument why $L(chi) = L a^2$!
]

The comoving luminosity $L(chi)$ increases quadratically with scale.

#task(label: "d")[
  The angular diameter distance $d_A$ of a structure that appears under the angle $alpha$ and has spatial extension $l_0$ is defined as
  $ d_A = l(a)/alpha, $
  where $l_0$ is also stretched along with the cosmic expansion, such that the comoving size is $l(a) = l_0 \/ a$, i.e. $alpha = l_0/(a chi(a))$, and thus $d_A = a chi$. Argue why $l(a) = l_0 \/ a$!
]

The spatial extension decreases linearly with scale.

= Problem 4 (Extra: Redshift galore) [5 points]

#task[The cosmological redshift $z$ i.t.o. the scale factor is $z = 1/a - 1$. How can one distinguish between redshift, e.g. in a far-away galaxy, from peculiar motion (rel. Doppler effect) $z_m$ and redshift coming from the cosmic expansion $z_c$?]

If the distance $d$ to the redshifted object, say a galaxy, is known, the cosmological redshift can be calculated using Hubble's law, i.e. $z_c = (H_0 d)/c$.

Otherwise, determining the difference is not generally possible, and complicated for specific cases by the fact that redshift can also have sources entirely different from the above mentioned, e.g. gravitational redshift.
