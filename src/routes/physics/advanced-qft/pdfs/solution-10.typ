#import "/notes.typ": dd, notes, tagged, task
#import "@preview/cetz:0.5.2": canvas, draw

#show: notes.with(
  title: [Quantum Field Theory II -- Assignment 10],
  subtitle: [Exercise sheet 10, Advanced QFT, Prof. Jürgen Berges],
  date: [Solutions by Janosh Riebesell, 29.06.2015 and 02.07.2015],
)

// running coupling lambda-bar
#let lb = $overline(lambda)$

= Problem 10.1 (One-loop $beta$-function in QED)

#task(label: "a")[Compute the one-loop $beta$-function in QED.]

$ beta_e (mu) = mu partial / (partial mu) (-e delta_1 + e delta_2 + e/2 delta_3), quad "where" quad -mu^2 = 4 m^2, "i.e." quad mu prop m. $
$
  delta_1 = -e^2 / (4 pi)^(d\/2) integral_0^1 dd(z) (1 - z) & (Gamma(2 - d/2) / ((1 - z)^2 m^2 + z M^2)^(2 - d\/2) 1/2 (2 - epsilon)^2 \
    & + Gamma(3 - d/2) / ((1 - z)^2 m^2 + z M^2)^(3 - d\/2) (2(1 - 4 z + z^2) - epsilon (1 - z)^2) m^2),
$
$
  (partial delta_1) / (partial mu) & = -e^2 / (4 pi)^(d\/2) integral_0^1 dd(z) (1 - z) [ (-overbrace((2 - d/2) Gamma(2 - d/2), Gamma(3 - d\/2) = Gamma(1 + epsilon\/2) = 1)) / ((1 - z)^2 m^2 + z M^2)^(3 - d\/2) 2 (1 - z)^2 m 1/2 (2 - epsilon)^2 \
    & #h(10em) + partial / (partial mu) Gamma(1) / ((1 - z)^2 + z M^2 \/ m^2) 2 (1 - 4 z + z^2) ] \
  & attach(=, t: epsilon -> 0) -e^2 / (4 pi)^2 integral_0^1 dd(z) (1 - z) [ (-4 (1 - z)^2 m) / ((1 - z)^2 m^2 + z M^2) + (2 (1 - 4 z + z^2)) / ((1 - z)^2 + z M^2 \/ m^2)^2 z (2 M^2) / m^3 ] \
  & attach(=, t: M -> 0) -e^2 / (4 pi)^2 integral_0^1 dd(z) (1 - z) (-4 (1 - z)^2 m) / ((1 - z)^2 m^2) = (4 e^2) / (16 pi^2 m) integral_0^1 dd(z) (1 - z) = e^2 / (8 pi^2 m),
$
where we let $M -> 0$ as it is an IR cutoff for the photon propagator. Further, we took $e(mu) = e$ to be constant at one-loop order.
$
  (partial delta_2) / (partial mu) & attach(=, t: M -> 0) -e^2 / (4 pi)^(d\/2) integral_0^1 dd(z) partial / (partial mu) [ Gamma(2 - d/2) / ((1 - z) m)^(4 - d) ((2 - epsilon) z - epsilon / 2 z / (1 - z) (4 - 2 z - epsilon (1 - z))) ] \
  & = -e^2 / (4 pi)^(d\/2) integral_0^1 dd(z) (-2 overbrace((2 - d/2) Gamma(2 - d/2), 1)) / ((1 - z) m)^(5 - d) ((2 - epsilon) z - epsilon / 2 z / (1 - z) (4 - 2 z - epsilon (1 - z))) (1 - z) \
  & = (2 e^2) / (4 pi)^2 integral_0^1 dd(z) (2 z) / m = e^2 / (8 pi^2 m),
$
$
  delta_3 & = -e^2 / (4 pi)^(d\/2) integral_0^1 dd(z) Gamma(2 - d/2) / (m^2)^(2 - d\/2) (8 z (1 - z)), \
  (partial delta_3) / (partial mu) & = -e^2 / (4 pi)^(d\/2) integral_0^1 dd(z) (-2 overbrace((2 - d/2) Gamma(2 - d/2), 1)) / m^(5 - d) (8 z (1 - z)) = (2 e^2) / ((4 pi)^2 m) integral_0^1 dd(z) 8 z (1 - z) \
  & = e^2 / (pi^2 m) integral_0^1 dd(z) (z - z^2) = e^2 / (6 pi^2 m).
$
Thus, putting everything together, we get
$
  beta_e (mu) & = mu partial / (partial mu) (-e delta_1 + e delta_2 + e/2 delta_3) \
  & = -e e^2 / (8 pi^2) + e e^2 / (8 pi^2) + e/2 e^2 / (6 pi^2) = e^3 / (12 pi^2).
$

#task(label: "b")[
  Integrate the solution to the renormalization group equation $dif / (dif log mu) e(mu) = beta_e (mu)$ to find at one-loop order
  $ alpha(mu) = alpha^* / (1 - 2 / (3 pi) alpha^* log(mu / mu^*)), quad alpha = e^2 / (4 pi), $
  where $alpha^* = alpha(mu^*)$ with $mu^*$ some fixed scale. Plot the behavior of $e(mu)$. At which scale does $e$ cease to be perturbative?
]

$ dif / (dif log(mu)) e(mu) = beta_e (mu) quad ==> quad 1 / (beta_e (mu)) dif e(mu) = dif log(mu). $
With $alpha(mu) = e(mu)^2 / (4 pi)$, i.e. $dif alpha(mu) = e(mu) / (2 pi) dif e(mu)$, the left-hand side integrates to
$
  integral_(mu^*)^mu 1 / (beta_e (mu')) dif e(mu') & = integral_(mu^*)^mu (12 pi^2) / (e^3 (mu')) (2 pi) / (e(mu')) dif alpha(mu') = integral_(mu^*)^mu (3/2 pi) / (alpha^2 (mu')) dif alpha(mu') \
  & = -3/2 pi (1 / alpha(mu) - 1 / alpha(mu^*)),
$
while the right-hand side gives
$ integral_(mu^*)^mu dif log(mu') = log(mu / mu^*) attach(=, t: !) 3/2 pi (1 / alpha(mu^*) - 1 / alpha(mu)) quad ==> quad 1 / alpha(mu) = 1 / alpha(mu^*) - 2 / (3 pi) log(mu / mu^*) $
$ ==> quad alpha(mu) = alpha(mu^*) / (1 - 2 / (3 pi) alpha(mu^*) log(mu / mu^*)). $

#grid(
  columns: (auto, 1fr),
  column-gutter: 1.5em,
  align: horizon,
  canvas(length: 1cm, {
    import draw: *
    let x0 = 4.0 // position of the Landau pole 3 pi / (2 alpha^*)
    let ys = 0.55 // vertical scale
    line((-0.2, 0), (4.8, 0), mark: (end: "stealth", fill: black), stroke: 0.6pt)
    line((0, -0.2), (0, 4.6), mark: (end: "stealth", fill: black), stroke: 0.6pt)
    content((4.9, 0), $log(mu / mu^*)$, anchor: "west")
    content((0.15, 4.6), $alpha(mu) / alpha(mu^*)$, anchor: "north-west")
    line((x0, 0), (x0, 4.4), stroke: (dash: "dashed", paint: luma(130), thickness: 0.5pt))
    content((x0, -0.15), $(3 pi) / (2 alpha^*)$, anchor: "north")
    content((-0.1, ys), $1$, anchor: "east")
    let pts = range(0, 93).map(i => {
      let x = i * x0 * (1 - ys / 4.3) / 92
      (x, ys / (1 - x / x0))
    })
    line(..pts, stroke: 1pt)
  }),
  [
    Perturbativeness is lost at $e approx 1$, i.e.
    $ 1 / (4 pi) approx alpha(mu^*) / (1 - (2 alpha(mu^*)) / (3 pi) log(mu / mu^*)) $
    $ ==> quad mu approx mu^* exp[3/2 pi (1 / alpha(mu^*) - 4 pi)]. $
  ],
)

= Problem 10.2 (Anomalous dimension)

#task(label: "a")[
  Consider a two-point function $G_2 (p; lambda, mu)$ of a massless scalar theory and rewrite it as
  #tagged(4, $ G_2 (p; lambda, mu) = i / p^2 f(-p^2 / mu^2) $)
  with an a priori arbitrary function $f$. Show that the Callan-Symanzik equation
  #tagged(5, $ (mu partial / (partial mu) + beta(lambda) partial / (partial lambda) + 2 gamma(lambda)) G_2 (p; lambda, mu) = 0 $)
  can be cast into the form
  #tagged(6, $ (p partial / (partial p) - beta(lambda) partial / (partial lambda) + 2 - 2 gamma(lambda)) G_2 (p; lambda, mu) = 0, $)
  where $p = sqrt(-p^2)$.
]

To arrive at eq. (6), we need a relation between the derivatives of $G_2 (p; lambda, mu)$ with respect to $mu$ and $p$. We compute
$
  mu partial / (partial mu) G_2 (p; lambda, mu) & = mu i / p^2 (2 p^2) / mu^3 (partial f(-p^2 \/ mu^2)) / (partial(-p^2 \/ mu^2)) = (2 i) / mu^2 f'(-p^2 / mu^2), \
  p partial / (partial p) G_2 (p; lambda, mu) & = p (-2 i) / p^3 f(-p^2 / mu^2) + p i / p^2 (-2 p) / mu^2 f'(-p^2 / mu^2) \
  & = -2 G_2 (p; lambda, mu) - (2 i) / mu^2 f'(-p^2 / mu^2).
$
Thus, we found the relation $mu partial / (partial mu) G_2 (p; lambda, mu) = -p partial / (partial p) G_2 (p; lambda, mu) - 2 G_2 (p; lambda, mu)$. Insertion into eq. (5) yields
$ (p partial / (partial p) - beta(lambda) partial / (partial lambda) + 2 (1 - gamma)) G_2 (p; lambda, mu) = 0. $

#task(label: "b")[
  Integrate this equation to find
  #tagged(7, $ G_2 (p; lambda, mu) = i / p^2 cal(F)(lb(p; lambda)) exp(2 integral_(p' = mu)^p dif[log p' / mu] gamma(lb(p'; lambda))), $)
  where $lb(p; lambda)$ is the running coupling, which is defined such that $p partial / (partial p) lb(p; lambda) = beta(lb(p; lambda))$ with the initial condition $lb(mu; lambda) = lambda$, and $cal(F)(x)$ is some a priori unknown function. _Hint:_ Compare eq. (6) with
  #tagged(8, $ (p dif / (dif p) + 2 (1 - gamma(lambda^*))) G_2 (p; lb(mu^2 / p; lambda^*), mu) |_(lambda^* = lb(p; lambda)) = 0. $)
  Note that $lb(mu^2 \/ p; x)$ is the inverse of $lb(p; x)$, i.e. $lb(mu^2 / p; lb(p; x)) = x$.
]

We can easily verify that eqs. (6) and (8) are completely equivalent by noting that
$
  p dif / (dif p) G_2 (p; lb(mu^2 / p; lambda^*), mu) |_(lambda^* = lb(p; lambda)) & = p partial / (partial p) G_2 (p; lb(mu^2 / p; lambda^*), mu) |_(lambda^* = lb(p; lambda)) \
  & quad + p partial / (partial p) lb(mu^2 / p; lambda^*) partial / (partial lb(mu^2 \/ p; lambda^*)) G_2 (p; lb(mu^2 / p; lambda^*), mu) |_(lambda^* = lb(p; lambda)) \
  & = p partial / (partial p) G_2 (p; lb(mu^2 / p; lb(p; lambda)), mu) \
  & quad + underbrace(p partial / (partial p) lb(mu^2 / p; lb(p; lambda)), beta(lb(mu^2 \/ p; lb(p; lambda)))) partial / (partial lb(mu^2 \/ p; lb(p; lambda))) G_2 (p; lb(mu^2 / p; lb(p; lambda)), mu) \
  & = p partial / (partial p) G_2 (p; lambda, mu) + beta(lambda) partial / (partial lambda) G_2 (p; lambda, mu),
$
where we used the hint that $lb(mu^2 / p; lb(p; lambda)) = lambda$.

Inserting this equality into eq. (8), we immediately reobtain eq. (6). Thus we may integrate eq. (8) and rest assured that our result for $G_2 (p; lambda, mu)$ also fulfills eq. (6). Since it is a first-order differential equation, we may solve it by separation of variables:
$
  integral_mu^p (dif G(p'; lb(mu^2 \/ p'; lambda^*), mu)) / G(p'; lb(mu^2 \/ p'; lambda^*), mu) |_(lambda^* = lb(p; lambda)) = -2 (1 - gamma(lambda^*)) integral_mu^p dif ln(p') |_(lambda^* = lb(p; lambda)),
$
where the left-hand side evaluates to
$ ln(G(p'; lambda, mu)) |_mu^p = ln(G(p; lambda, mu)) - ln(i / mu^2 f(-1)) $
$ ==> quad G(p; lambda, mu) = i / mu^2 f(-1) e^(2 integral_mu^p dif ln(p') gamma(lb(p'; lambda))) e^(-2 integral_mu^p dif ln(p')). $
So $cal(F)(lb(p; lambda)) = f(-1) e^(-2 integral_mu^p dif ln(p'))$.

#task(label: "c")[
  Argue that in the vicinity of a fixed point $lambda^*$ where $beta(lambda^*) = 0$ the two-point function scales as
  #tagged(9, $ G_2 (p; lambda^*, mu) prop (1 / p^2)^(1 - gamma(lambda^*)) $)
  and justify from this the term anomalous dimension for $gamma$.
]

For $beta(lambda^*) = 0$, eq. (6) reads at $lambda = lambda^*$
$ (dif G_2 (p; lambda^*, mu)) / (G_2 (p; lambda^*, mu)) = -2 (1 - gamma(lambda^*)) (dif p) / p. $
Integration gives
$ ln(G_2 (p; lambda^*, mu)) = -2 (1 - gamma(lambda^*)) ln(p) + c = ln(p^(-2 (1 - gamma(lambda^*)))) + c. $
Therefore, after exponentiation we find
$ G_2 (p; lambda^*, mu) = e^c e^(ln(p^(-2 (1 - gamma(lambda^*))))) prop (1 / p^2)^(1 - gamma(lambda^*)), $
i.e. $G_2 (p; lambda^*, mu)$ has non-integer -- anomalous -- dimension of momentum.
