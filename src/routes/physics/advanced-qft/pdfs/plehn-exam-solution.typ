#import "/notes.typ": dd, notes, task
#import "@preview/cetz:0.5.2": canvas, decorations, draw

#show: notes.with(
  title: [Quantum Field Theory II -- Final Exam],
  subtitle: [Devised by Tilman Plehn, Advanced QFT],
  date: [Solutions by Janosh Riebesell, 09.07.2015 and 17.07.2015],
)

// Feynman slash notation
#let fsl(x) = math.cancel(x, angle: 25deg, length: 110%)

// inline Feynman diagrams
#let fd(body) = box(baseline: 35%, inset: (x: 1pt), canvas(length: 0.5cm, {
  import draw: *
  set-style(stroke: 0.65pt)
  body
}))
#let ph(a, b) = decorations.wave(draw.line(a, b), amplitude: 0.13, segment-length: 0.3)
// fermion line with an arrow in the middle
#let fe(a, b) = {
  let m = ((a.at(0) + b.at(0)) / 2, (a.at(1) + b.at(1)) / 2)
  draw.line(a, m, mark: (end: ">", fill: black, scale: 0.6))
  draw.line(m, b)
}
#let blob(pt, r: 0.32) = draw.circle(pt, radius: r, fill: tiling(
  size: (3pt, 3pt),
  line(start: (0%, 100%), end: (100%, 0%), stroke: 0.4pt),
))
// counterterm insertions: a cross on the line, or a circled cross at a vertex
#let cross(pt, d: 0.17) = {
  draw.line((pt.at(0) - d, pt.at(1) - d), (pt.at(0) + d, pt.at(1) + d), stroke: 0.9pt)
  draw.line((pt.at(0) - d, pt.at(1) + d), (pt.at(0) + d, pt.at(1) - d), stroke: 0.9pt)
}
#let otimes(pt, r: 0.26) = {
  draw.circle(pt, radius: r, fill: white)
  cross(pt, d: r * 0.7)
}
#let mom(a, b, label, dy: 0.38) = {
  draw.line(a, b, mark: (end: ">", fill: black, scale: 0.5), stroke: 0.45pt)
  draw.content(((a.at(0) + b.at(0)) / 2, a.at(1) + dy), text(size: 7pt, label))
}
#let lab(pt, body) = draw.content(pt, text(size: 7pt, body))

// fermion self-energy (rainbow) diagram with photon momentum k = p - q
#let rainbow = fd({
  fe((0, 0), (0.9, 0))
  fe((0.9, 0), (2.5, 0))
  fe((2.5, 0), (3.4, 0))
  decorations.wave(draw.arc((2.5, 0), start: 0deg, stop: 180deg, radius: 0.8), amplitude: 0.12, segment-length: 0.3)
  mom((0.15, -0.35), (0.75, -0.35), $p$, dy: -0.35)
  mom((1.4, -0.35), (2, -0.35), $q$, dy: -0.35)
  mom((2.65, -0.35), (3.25, -0.35), $p$, dy: -0.35)
  lab((1.7, 1.25), $k = p - q$)
})
// photon self-energy (fermion loop) diagram
#let bubble(left: $mu$, right: $nu$) = fd({
  ph((0, 0), (1.3, 0))
  ph((2.9, 0), (4.2, 0))
  draw.circle((2.1, 0), radius: 0.8)
  draw.line((2.05, 0.8), (2.15, 0.8), mark: (end: ">", fill: black, scale: 0.6))
  draw.line((2.15, -0.8), (2.05, -0.8), mark: (end: ">", fill: black, scale: 0.6))
  mom((0.35, 0.4), (0.95, 0.4), $p$)
  mom((3.25, 0.4), (3.85, 0.4), $p$)
  lab((2.1, 0.45), $p + k$)
  lab((2.1, -1.1), $k$)
  lab((-0.3, 0), left)
  lab((4.5, 0), right)
})

= Problem 1: One-loop calculations in QED

#task(label: "1")[
  QED with massless fermion field $Psi(x)$ and massless gauge field $A_mu (x)$:
  $ cal(L) = -1/4 F_(0, mu nu) F_0^(mu nu) + i overline(Psi)_0 fsl(D)_0 Psi_0, quad D_0^mu = partial^mu + i e_0 A_0^mu. $
]

We use the Feynman rules to derive the one-loop corrections to the fermion propagator $i cal(M)[f(p) -> f(p)]$ of a fermion $f$ with mom. $p$. To apply renormalized perturbation theory, we split the bare Lagrangian into renormalized quantities, e.g. $Psi = Z_Psi^(-1\/2) Psi_0$ and $A^mu = Z_A^(-1\/2) A_0^mu$, and counterterms as follows
$ cal(L) = -1/4 F_(mu nu) F^(mu nu) + i overline(Psi) fsl(partial) Psi - e A_mu overline(Psi) gamma^mu Psi - 1/4 delta_A F_(mu nu) F^(mu nu) + i delta_Psi overline(Psi) fsl(partial) Psi - delta_e A_mu overline(Psi) gamma^mu Psi, $
where $delta_A = Z_A - 1$, $delta_Psi = Z_Psi - 1$ and $delta_e = e_0 Z_A^(1\/2) Z_Psi - e$. Integrating by parts, the photonic counterterm yields
$
  delta_gamma & = integral dd(4, x) (-1/4 delta_A F_(mu nu) F^(mu nu)) = -1/4 delta_A integral dd(4, x) (partial_mu A_nu partial^mu A^nu - partial_mu A_nu partial^nu A^mu - partial_nu A_mu partial^mu A^nu + partial_nu A_mu partial^nu A^mu) \
  & = -1/2 delta_A integral dd(4, x) (partial_mu A_nu partial^mu A^nu - partial_mu A_nu partial^nu A^mu) \
  & = -1/2 delta_A integral dd(4, x) (-A^nu partial_mu partial^mu A_nu + A_nu partial_mu partial^nu A^mu) \
  & = -1/2 delta_A integral dd(4, x) A_nu (-partial^2 g^(mu nu) + partial^mu partial^nu) A_mu.
$
So our complete set of Feynman rules yields
#grid(
  columns: 3,
  column-gutter: 1.2em,
  row-gutter: 1em,
  align: horizon,
  [#fd({ ph((0, 0), (2.4, 0)); mom((0.8, 0.4), (1.6, 0.4), $k$); lab((-0.3, 0), $mu$); lab((2.7, 0), $nu$) }) $= (-i g_(mu nu))/k^2$],
  [#fd({ fe((0, 0), (2.4, 0)); mom((0.8, 0.4), (1.6, 0.4), $p$) }) $= i/fsl(p)$],
  [#fd({ fe((-1.2, -0.8), (0, 0)); fe((0, 0), (-1.2, 0.8)); ph((0, 0), (1.4, 0)); lab((1.7, 0.1), $mu$) }) $= -i e gamma^mu$],
  [#fd({ ph((0, 0), (2.4, 0)); cross((1.2, 0)); mom((0.8, 0.45), (1.6, 0.45), $k$); lab((-0.3, 0), $mu$); lab((2.7, 0), $nu$) }) $= -i (k^2 g_(mu nu) - k_mu k_nu) delta_A$],
  [#fd({ fe((0, 0), (1.2, 0)); fe((1.2, 0), (2.4, 0)); cross((1.2, 0)); mom((0.8, 0.45), (1.6, 0.45), $p$) }) $= i (fsl(p) delta_Psi - delta_m)$#footnote[The $delta_m$ term needs to be added even in massless theories.]],
  [#fd({ fe((-1.2, -0.8), (0, 0)); fe((0, 0), (-1.2, 0.8)); ph((0, 0), (1.4, 0)); otimes((0, 0)); lab((1.7, 0.1), $mu$) }) $= -i delta_e gamma^mu$],
)

At one loop, the fermion propagator receives the following contributions
$
  #fd({ fe((0, 0), (1, 0)); fe((1, 0), (2, 0)); blob((1, 0)); mom((0.1, 0.4), (0.6, 0.4), $p$); mom((1.4, 0.4), (1.9, 0.4), $p$) }) |_"1-loop" = #fd({ fe((0, 0), (2, 0)); mom((0.7, 0.4), (1.3, 0.4), $p$) }) + #rainbow + #fd({ fe((0, 0), (1.2, 0)); fe((1.2, 0), (2.4, 0)); cross((1.2, 0)); mom((0.2, 0.4), (0.8, 0.4), $p$); mom((1.6, 0.4), (2.2, 0.4), $p$) }),
$
of which only the latter two are corrections. We compute
$
  #fd({ fe((0, 0), (1.2, 0)); fe((1.2, 0), (2.4, 0)); cross((1.2, 0)); mom((0.2, 0.4), (0.8, 0.4), $p$); mom((1.6, 0.4), (2.2, 0.4), $p$) }) & = i (fsl(p) delta_Psi - delta_m), \
  underbrace(#rainbow, -i cal(M)[f(p) -> f(p)]) & = overline(u)(p) (-i e gamma^nu) integral (dd(d, q))/(2 pi)^d (i fsl(q))/q^2 (-i g_(mu nu))/k^2 (-i e gamma^mu) u(p) \
  & = -e^2 overline(u)(p) integral (dd(d, q))/(2 pi)^d (gamma_mu fsl(q) gamma^mu)/(q^2 (p - q)^2) u(p), quad gamma_mu fsl(q) gamma^mu = gamma_mu (-gamma^mu fsl(q) + 2 q^mu) = -2 fsl(q) \
  & = -e^2 overline(u)(p) Gamma(1 + 1)/(Gamma(1) Gamma(1)) integral_0^1 dd(x) integral (dd(d, q))/(2 pi)^d (-2 fsl(q))/(underbrace(x (p - q)^2 + (1 - x) q^2, x p^2 - 2 x p q + x q^2 + q^2 - x q^2))^2 u(p) \
  & = 2 e^2 overline(u)(p) integral_0^1 dd(x) integral (dd(d, q))/(2 pi)^d fsl(q)/(\(\(underbrace(q - x p, l)\)^2 + x (1 - x) p^2\)^2) u(p) \
  & = 8 pi alpha_"em" overline(u)(p) integral_0^1 dd(x) integral (dd(d, l))/(2 pi)^d (attach(fsl(l), t: 0 "(odd)") + x fsl(p))/(l^2 + x (1 - x) p^2)^2 u(p) \
  & = 8 pi alpha_"em" overline(u)(p) fsl(p) F(p^2) u(p), quad (fsl(p) u(p) = 0)
$
where we calculate $F(p^2)$ using the subst. $z = Delta/(l_E^2 - Delta)$, $l_E = Delta^(1\/2) (1/z - 1)^(1\/2)$:
$
  F(p^2) & = i integral_0^1 dd(x) integral (dd(d, l_E))/(2 pi)^d x/[l_E^2 - underbrace(x (1 - x) p^2, Delta)]^2 = i integral_0^1 dd(x) x integral (dif Omega_d)/(2 pi)^d integral_0^oo dd(l_E) l_E^(d-1)/(l_E^2 - Delta)^2 \
  & = i integral_0^1 dd(x) x (2 pi^(d\/2))/((2 pi)^d Gamma(d/2)) integral_1^0 dd(z) (l_E^2 - Delta)^2/(-2 Delta l_E) l_E^(d-1)/(l_E^2 - Delta)^2 \
  & = 1/((4 pi)^(d\/2) Gamma(d/2)) integral_0^1 dd(x) x integral_0^1 dd(z) Delta^(d/2 - 2) z^(1 - d/2) (1 - z)^(d/2 - 1) \
  & = 1/((4 pi)^(d\/2) Gamma(d/2)) (Gamma(2 - d/2) Gamma(d/2))/Gamma(2 - d/2 + d/2) integral_0^1 dd(x) x Delta^(d/2 - 2) = Gamma(epsilon/2)/(4 pi)^(d\/2) integral_0^1 dd(x) x (x (1 - x) p^2)^(d/2 - 2).
$
To bring out the divergence, we expand the integrand,
$
  integral_0^1 dd(x) x (x (1 - x) p^2)^(-epsilon\/2) & = integral_0^1 dd(x) x (1 + epsilon/2 ln(x (1 - x) p^2) + cal(O)(epsilon^2)) \
  & = 1/2 + epsilon/2 integral_0^1 dd(x) x ln(x (1 - x) p^2) + cal(O)(epsilon^2).
$
We can also expand the prefactors $Gamma(epsilon/2) = 2/epsilon - gamma + cal(O)(epsilon)$ and
$ 1/(4 pi)^(d\/2) = 1/(4 pi)^(2 - epsilon\/2) = (4 pi)^(epsilon\/2)/(16 pi^2) = 1/(16 pi^2) (1 + epsilon/2 ln(4 pi) + cal(O)(epsilon^2)). $
Assembling everything, we get
$
  F(p^2) & = i/(16 pi^2) (1 + epsilon/2 ln(4 pi) + cal(O)(epsilon^2)) (2/epsilon - gamma + cal(O)(epsilon)) (1/2 + epsilon/2 integral_0^1 dd(x) x ln(x (1 - x) p^2) + cal(O)(epsilon^2)) \
  & = i/(32 pi^2) (2/epsilon - gamma + ln(4 pi) + integral_0^1 dd(x) x ln(x (1 - x) p^2)) + cal(O)(epsilon).
$
If we choose our renormalization conditions as
$ Sigma(fsl(p))|_(fsl(p) = mu) = 0 quad "and" quad dif/(dif fsl(p)) Sigma(fsl(p))|_(fsl(p) = mu) = 0, $
we obtain a counterterm $delta_Psi$ of
$
  dif/(dif fsl(p)) Sigma(fsl(p))|_(fsl(p) = mu) & = i delta_Psi + dif/(dif fsl(p)) [2 e^2 i/(32 pi^2) (2/epsilon - gamma + ln(4 pi) + integral_0^1 dd(x) x ln(x (1 - x) p^2))]|_(fsl(p) = mu) \
  & = i delta_Psi + (i e^2)/(16 pi^2) integral_0^1 dd(x) (2 x (1 - x) fsl(p))/(x (1 - x) p^2)|_(fsl(p) = mu) = i delta_Psi + (i e^2)/(8 pi^2 mu) = 0 quad ==> quad delta_Psi = -e^2/(8 pi^2 mu)
$
and for $delta_m$
$
  Sigma(fsl(p))|_(fsl(p) = mu) & = i (fsl(p) delta_Psi - delta_m) + (i e^2)/(16 pi^2) (2/epsilon - gamma + ln(4 pi) + integral_0^1 dd(x) x ln(x (1 - x) p^2))|_(fsl(p) = mu) \
  & = -(i e^2)/(8 pi^2) - i delta_m + (i e^2)/(16 pi^2) (2/epsilon - gamma + ln(4 pi) + integral_0^1 dd(x) x ln(x (1 - x) mu^2)) = 0 \
  ==> delta_m & = e^2/(16 pi^2) (2/epsilon - gamma + ln(4 pi) + integral_0^1 dd(x) x ln(x (1 - x) mu^2) - 2).
$

*2.* We calculate the one-loop corrections to the photon propagator, again using the Feynman rules of renormalized perturbation theory.
$
  -i cal(M)[gamma(p) -> gamma(p)]|_"1-loop" & = #fd({ ph((0, 0), (1.2, 0)); ph((1.2, 0), (2.4, 0)); blob((1.2, 0)); mom((0.2, 0.4), (0.7, 0.4), $p$); mom((1.7, 0.4), (2.2, 0.4), $p$); lab((-0.3, 0), $mu$); lab((2.7, 0), $nu$) }) |_"1-loop" = #fd({ ph((0, 0), (2.4, 0)); mom((0.8, 0.4), (1.6, 0.4), $p$); lab((-0.3, 0), $mu$); lab((2.7, 0), $nu$) }) + #bubble() \
  & quad + #fd({ ph((0, 0), (2.4, 0)); cross((1.2, 0)); mom((0.2, 0.4), (0.8, 0.4), $p$); mom((1.6, 0.4), (2.2, 0.4), $p$); lab((-0.3, 0), $mu$); lab((2.7, 0), $nu$) })
$
The first correction gives
$
  #bubble(left: $nu$, right: $mu$) & = epsilon_mu^* (p) (-i e (gamma^mu)^A_B) integral (dd(d, k))/(2 pi)^d (i (fsl(p) + fsl(k))^B_C)/(p + k)^2 (i (fsl(k))^C_D)/k^2 (-i e (gamma^nu)^D_A) epsilon_nu (p) \
  & = -e^2 epsilon_mu^* (p) integral (dd(d, k))/(2 pi)^d tr(gamma^mu (fsl(p) + fsl(k)) gamma^nu fsl(k))/(k^2 (p + k)^2) epsilon_nu (p)
$
$
  tr(gamma^mu (fsl(p) + fsl(k)) gamma^nu fsl(k)) & = p_rho k_sigma tr(gamma^mu gamma^rho gamma^nu gamma^sigma) + tr(gamma^mu fsl(k) k_rho (2 eta^(rho nu) - gamma^rho gamma^nu)) \
  & = p_rho k_sigma 4 (eta^(mu rho) eta^(nu sigma) - eta^(mu nu) eta^(rho sigma) + eta^(mu sigma) eta^(rho nu)) + 2 tr(gamma^mu fsl(k) k^nu) - k^2 tr(gamma^mu gamma^nu) \
  & = 4 (p^mu k^nu - p^sigma k_sigma eta^(mu nu) + p^nu k^mu) + 2 k_rho k^nu tr(gamma^mu gamma^rho) - k^2 4 eta^(mu nu) \
  & = 4 (p^mu k^nu - p dot k eta^(mu nu) + p^nu k^mu) + 8 k^mu k^nu - 4 k^2 eta^(mu nu)
$
Using a Feynman parametrization to simplify the denominator,
$ i cal(M)[gamma(p) -> gamma(p)] = -e^2 epsilon_mu^* (p) integral (dd(d, k))/(2 pi)^d integral_0^1 dd(x) tr(gamma^mu (fsl(p) + fsl(k)) gamma^nu fsl(k))/[x (p + k)^2 + (1 - x) k^2]^2 epsilon_nu (p), $
$
  x (p + k)^2 + (1 - x) k^2 & = x p^2 + 2 x p k + x k^2 + k^2 - x k^2 \
  & = (k + x p)^2 + x (1 - x) p^2 =: l^2 + x (1 - x) p^2 = l^2 - Delta,
$
where $l = k + x p$, $dif l = dif k$.
$
  i cal(M) & = -e^2 epsilon_mu^* (p) tr(gamma^mu gamma^rho gamma^nu gamma^sigma) integral_0^1 dd(x) integral (dd(d, l))/(2 pi)^d overbrace((l_rho + (1 - x) p_rho)(l_sigma - x p_sigma), l_rho l_sigma - x (1 - x) p_rho p_sigma", other terms odd")/(l^2 - Delta)^2 epsilon_nu (p) \
  & = -e^2 epsilon_mu^* (p) tr(gamma^mu gamma^rho gamma^nu gamma^sigma) integral_0^1 dd(x) [(-i Gamma(1 - d/2))/(4 pi)^(d\/2) eta_(rho sigma)/2 Delta^(d/2 - 1) - x (1 - x) p_rho p_sigma (i Gamma(2 - d/2))/(4 pi)^(d\/2) Delta^(d/2 - 2)] epsilon_nu (p),
$
where we used A.44 and A.46 from Peskin & Schroeder to perform the $l$-integration. We simplify
$
  i cal(M) & = (i e^2 epsilon_mu^*)/(4 pi)^(d\/2) Gamma(2 - d/2) tr(gamma^mu gamma^rho gamma^nu gamma^sigma) integral_0^1 dd(x) (eta_(rho sigma)/(2 - d) (-x (1 - x) p^2)^(d/2 - 1) + x (1 - x) p_rho p_sigma (-x (1 - x) p^2)^(d/2 - 2)) epsilon_nu (p) \
  & = (i e^2)/(4 pi)^(d\/2) epsilon_mu^* (p) Gamma(epsilon/2) tr(gamma^mu gamma^rho gamma^nu gamma^sigma) ((-p^2 eta_(rho sigma))/(2 - d) + p_rho p_sigma) (-p^2)^(d/2 - 2) integral_0^1 dd(x) [x (1 - x)]^(d/2 - 1) epsilon_nu (p) \
  & = (i e^2)/(4 pi)^(d\/2) epsilon_mu^* (p) Gamma(epsilon/2) tr(gamma^mu gamma^rho gamma^nu gamma^sigma) (-p^2)^(-epsilon\/2) ((-p^2)/(2 - d) eta_(rho sigma) + p_rho p_sigma) (Gamma(d/2) Gamma(d/2))/Gamma(d) epsilon_nu (p) \
  & = (i e^2)/(4 pi)^(d\/2) epsilon_mu^* (p) (Gamma(epsilon/2) Gamma(d/2)^2)/Gamma(d) (-p^2)^(-epsilon\/2) 4 (eta^(mu rho) eta^(nu sigma) - eta^(mu nu) eta^(rho sigma) + eta^(mu sigma) eta^(rho nu)) ((-p^2)/(2 - d) eta_(rho sigma) + p_rho p_sigma) epsilon_nu (p) \
  & = (4 i e^2)/(4 pi)^(d\/2) epsilon_mu^* (p) (Gamma(epsilon/2) Gamma(d/2)^2)/Gamma(d) (-p^2)^(-epsilon\/2) ((-p^2)/(2 - d) (eta^(mu nu) - eta^(mu nu) underbrace(eta^rho_rho, d) + eta^(mu nu)) + (p^mu p^nu - eta^(mu nu) p^2 + p^mu p^nu)) epsilon_nu (p) \
  & = (4 i e^2)/(4 pi)^(d\/2) epsilon_mu^* (p) (Gamma(epsilon/2) Gamma(d/2)^2)/Gamma(d) (-p^2)^(-epsilon\/2) ((-2 eta^(mu nu) p^2)/(2 - d) + (d eta^(mu nu) p^2)/(2 - d) + 2 p^mu p^nu - eta^(mu nu) p^2) epsilon_nu (p) \
  & = (4 i e^2)/(4 pi)^(d\/2) epsilon_mu^* (p) (Gamma(epsilon/2) Gamma(d/2)^2)/Gamma(d) (-p^2)^(-epsilon\/2) (-2 eta^(mu nu) p^2 + 2 p^mu p^nu) epsilon_nu (p) \
  & = (8 i e^2)/(4 pi)^(d\/2) epsilon_mu^* (p) (Gamma(epsilon/2) Gamma(d/2)^2)/Gamma(d) (-p^2)^(1 - epsilon\/2) (eta^(mu nu) - (p^mu p^nu)/p^2) epsilon_nu (p) \
  & = epsilon_mu^* (p) alpha (8 i)/(4 pi)^(d\/2 - 1) (Gamma(epsilon/2) Gamma(d/2)^2)/Gamma(d) (-p^2)^(1 - epsilon\/2) (eta^(mu nu) - (p^mu p^nu)/p^2) epsilon_nu (p) \
  & = epsilon_mu^* (p) Pi^(mu nu) (p^2) epsilon_nu (p).
$
We need $Pi^(mu nu) (p^2) prop (eta^(mu nu) - (p^mu p^nu)/p^2)$ to fulfill the Ward identity. Physically, this is just current conservation which arises as a consequence of the gauge symmetry of QED. With $Pi^(mu nu) (p^2) prop (eta^(mu nu) - (p^mu p^nu)/p^2)$, we get
$ p_mu Pi^(mu nu) (p^2) prop p_mu (eta^(mu nu) - (p^mu p^nu)/p^2) = p^nu - (p^2 p^nu)/p^2 = 0. $
