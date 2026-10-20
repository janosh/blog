#import "/notes.typ": dd, notes, tagged, task
#import "@preview/cetz:0.5.2": canvas, draw

#show: notes.with(
  title: [General Relativity -- Exercise Sheet 8],
  subtitle: [Exercise sheet 8, General Relativity, Prof. Björn Malte Schäfer],
  date: [Solutions by Roland Walz and Janosh Riebesell, 05.06.2015],
)

// Christoffel symbol with upper index a and lower indices b
#let chr(a, b) = $attach(Gamma, tr: #a, br: #b)$

// sketch of y = f(x) on a canvas: x in (x0, x1) mapped to width w, y in (y0, y1) to height h,
// points outside the y-range are dropped so steep branches get clipped
#let sketch-curve(f, x0, x1, y0, y1, w, h, n: 200, ..style) = {
  let pts = range(n + 1).map(i => x0 + (x1 - x0) * i / n).map(x => (x, f(x)))
  let inside = pts.filter(p => p.at(1) >= y0 and p.at(1) <= y1)
  draw.line(
    ..inside.map(p => ((p.at(0) - x0) / (x1 - x0) * w, (p.at(1) - y0) / (y1 - y0) * h)),
    ..style,
  )
}

= Problem 1 (Spherical symmetry and time derivatives) [15 points]

#task(label: "a")[
  Argue why the free Einstein field equations can be written as
  #tagged(1, $ R_(mu nu) = 0, $)
  where $R_(mu nu)$ are the entries of the Ricci tensor.
]

For a vacuum with vanishing energy density, i.e. cosmological constant $Lambda = 0$, the Einstein field equations become
$ R_(mu nu) = -(8 pi G)/c^4 (T_(mu nu) - T/2 g_(mu nu)). $
In the free case, i.e. a vacuum devoid of any energy-matter distribution, we set the energy-momentum tensor $T_(mu nu)$ (and consequently its trace $T$) to zero, rendering the field equations
$ R_(mu nu) = 0. $

#task(label: "b")[
  Given the metric
  $ "diag"(g) = (B(r, t), -A(r, t), -r^2, -r^2 sin^2 theta), $
  compute the entries $R_(00)$, $R_(11)$ and $R_(10)$ of the Ricci tensor.
]

$ R_(mu nu) := chr(rho, mu rho\, nu) - chr(rho, mu nu\, rho) + chr(sigma, mu rho) chr(rho, sigma nu) - chr(sigma, mu nu) chr(rho, sigma rho). $

$
  R_(00) & = partial_0 chr(rho, 0 rho) - partial_rho chr(rho, 00) + chr(sigma, 0 rho) chr(rho, sigma 0) - chr(sigma, 00) chr(rho, sigma rho) \
  & = cancel(partial_0 chr(0, 00)) + partial_0 chr(1, 01) - cancel(partial_0 chr(0, 00)) - partial_1 chr(1, 00) + cancel(chr(0, 00) chr(0, 00)) + chr(0, 01) chr(1, 00) \
  & quad + cancel(chr(1, 00) chr(0, 10)) + chr(1, 01) chr(1, 10) - cancel(chr(0, 00) chr(0, 00)) - chr(0, 00) chr(1, 01) - cancel(chr(1, 00) chr(0, 10)) \
  & quad - chr(1, 00) chr(1, 11) - chr(1, 00) chr(2, 12) - chr(1, 00) chr(3, 13) \
  & = partial_t dot(A)/(2A) - partial_r B'/(2A) + B'/(2B) B'/(2A) + dot(A)/(2A) dot(A)/(2A) - dot(B)/(2B) dot(A)/(2A) - B'/(2A) A'/(2A) - B'/(2A) med 1/r - B'/(2A) med 1/r \
  & = dot.double(A)/(2A) - dot(A)^2/(2A^2) - B''/(2A) + (A' B')/(2A^2) + B'^2/(4A B) + dot(A)^2/(4A^2) - (dot(A) dot(B))/(4A B) - (A' B')/(4A^2) - B'/(A r) \
  & = (dot.double(A) - B'')/(2A) + (A' B' - dot(A)^2)/(4A^2) + (B'^2 - dot(A) dot(B))/(4A B) - B'/(A r).
$

$
  R_(11) & = partial_1 chr(rho, 1 rho) - partial_rho chr(rho, 11) + chr(sigma, 1 rho) chr(rho, sigma 1) - chr(sigma, 11) chr(rho, sigma rho) \
  & = partial_1 chr(0, 10) + cancel(partial_1 chr(1, 11)) + partial_1 chr(2, 12) + partial_1 chr(3, 13) - partial_0 chr(0, 11) - cancel(partial_1 chr(1, 11)) \
  & quad + chr(0, 10) chr(0, 01) + cancel(chr(0, 11) chr(1, 01)) + chr(1, 10) chr(0, 11) + cancel(chr(1, 11) chr(1, 11)) + chr(2, 12) chr(2, 21) \
  & quad + chr(3, 13) chr(3, 31) - chr(0, 11) chr(0, 00) - cancel(chr(0, 11) chr(1, 01)) - chr(1, 11) chr(0, 10) - cancel(chr(1, 11) chr(1, 11)) \
  & quad - chr(1, 11) chr(2, 12) - chr(1, 11) chr(3, 13) \
  & = partial_r B'/(2B) + partial_r 1/r + partial_r 1/r - partial_t dot(A)/(2B) + B'/(2B) B'/(2B) + dot(A)/(2A) dot(A)/(2B) + 1/r med 1/r + 1/r med 1/r \
  & quad - dot(A)/(2B) dot(B)/(2B) - A'/(2A) B'/(2B) - A'/(2A) med 1/r - A'/(2A) med 1/r \
  & = B''/(2B) - B'^2/(2B^2) - cancel(2/r^2) - dot.double(A)/(2B) + (dot(A) dot(B))/(2B^2) + B'^2/(4B^2) + dot(A)^2/(4A B) + cancel(2/r^2) - (dot(A) dot(B))/(4B^2) - (A' B')/(4A B) - A'/(A r) \
  & = (B'' - dot.double(A))/(2B) + (dot(A) dot(B) - B'^2)/(4B^2) + (dot(A)^2 - A' B')/(4A B) - A'/(A r).
$

$
  R_(10) & = partial_0 chr(rho, 1 rho) - partial_rho chr(rho, 10) + chr(sigma, 1 rho) chr(rho, sigma 0) - chr(sigma, 10) chr(rho, sigma rho) \
  & = cancel(partial_0 chr(0, 10)) + partial_0 chr(1, 11) + partial_0 chr(2, 12) + partial_0 chr(3, 13) - cancel(partial_0 chr(0, 10)) - partial_1 chr(1, 10) \
  & quad + cancel(chr(0, 10) chr(0, 00)) + chr(0, 11) chr(1, 00) + cancel(chr(1, 10) chr(0, 10)) + chr(1, 11) chr(1, 10) \
  & quad - cancel(chr(0, 10) chr(0, 00)) - chr(0, 10) chr(1, 01) - cancel(chr(1, 10) chr(0, 10)) - chr(1, 10) chr(1, 11) - chr(1, 10) chr(2, 12) \
  & quad - chr(1, 10) chr(3, 13) \
  & = cancel(partial_t A'/(2A)) + partial_t 1/r + partial_t 1/r - cancel(partial_r dot(A)/(2A)) + cancel(dot(A)/(2B) B'/(2A)) + cancel(A'/(2A) dot(A)/(2A)) - cancel(B'/(2B) dot(A)/(2A)) - cancel(dot(A)/(2A) A'/(2A)) \
  & quad - dot(A)/(2A) med 1/r - dot(A)/(2A) med 1/r = -dot(A)/(A r).
$

#task(label: "c")[What sort of spatial symmetry is the above metric assuming?]

Symmetries of a metric are characterized by the existence of Killing vectors. Since the above metric has three Killing vectors $(V^((1)), V^((2)), V^((3)))$ fulfilling the same commutation relations
$ [V^((i)), V^((j))] = V^((k)), quad i, j, k in {1, 2, 3}, quad i != j != k != i $
as those of the two-sphere $S^2$, we may conclude that our metric assumes spherical symmetry.

#task(label: "d")[For each individual entry of the Ricci tensor eq. (1) holds. What does that say about $dot(A)$ if you consider $R_(10)$ in this vacuum?]

Assuming $A(r, t) != 0 med forall r, t$, we infer
$ 0 attach(=, t: !) R_(10) = -dot(A)/(A r) quad ==> quad dot(A) = 0, quad A(r, t) = A(r) "outside the origin, i.e." r != 0. $

#task(label: "e")[Calculate $R_(00)/B + R_(11)/A$.]

$
  R_(00)/B + R_(11)/A & = (dot.double(A) - B'')/(2A B) + (A' B' - dot(A)^2)/(4A^2 B) + (B'^2 - dot(A) dot(B))/(4A B^2) - B'/(A B r) \
  & quad + (B'' - dot.double(A))/(2A B) + (dot(A) dot(B) - B'^2)/(4A B^2) + (dot(A)^2 - A' B')/(4A^2 B) - A'/(A^2 r) = -B'/(A B r) - A'/(A^2 r).
$

#task(label: "f")[Using $R_(00)/B + R_(11)/A = 0$ and your previous result, show that $dif/(dif r) log(A B) = 0$, therefore $A B = "const"$ (w.r.t. change in $r$).]

$ 0 attach(=, t: !) R_(00)/B + R_(11)/A = -B'/(A B r) - A'/(A^2 r) quad attach(<==>, t: dot (-A r)) quad 0 = (A' B + A B')/(A B) = dif/(dif r) log(A B). $
Contrary to what the exercise suggests, this does not imply $dot(B) = 0$, since we only found $dot(A) = 0$, but not $A' = 0$, as would be required to conclude $B' = 0$!

= Problem 2 (Piep piep kleiner Satellit) [15 points]

#task[
  A satellite with mass $m > 0$ is orbiting a black hole. The metric is
  $ "diag"(g) = (B(r), -A(r), -r^2, -r^2 sin^2 theta). $
]

#task(label: "a")[Calculate $(dd(2, x)^0)/(dif lambda^2) = (dd(2, t))/(dif lambda^2)$ via the geodesic equation.]

Since $A(r)$ and $B(r)$ are independent of $t$ now, we may use the dot notation to indicate differentiation w.r.t. $lambda$, i.e. $dot(x)^mu = (dif x^mu)/(dif lambda)$. The geodesic equation then reads
$ dot.double(x)^mu + chr(mu, rho sigma) dot(x)^rho dot(x)^sigma = 0. $
Therefore, ignoring Christoffel symbols containing $dot(A)$ and $dot(B)$, we get
$
  (dd(2, t))/(dif lambda^2) = dot.double(x)^0 & = -chr(0, rho sigma) dot(x)^rho dot(x)^sigma = -chr(0, 01) dot(x)^0 dot(x)^1 - chr(0, 10) dot(x)^1 dot(x)^0 = -2 chr(0, 01) dot(x)^0 dot(x)^1 \
  & = -2 B'/(2B) dot(t) dot(r) = -B'/B dot(t) dot(r).
$

#task(label: "b")[
  Rewrite the result as
  $ dif/(dif lambda) (log f + log g) = 0, $
  thus showing that $f g =: F = "const"$. What are $f$ and $g$?
]

$ B (dd(2, t))/(dif lambda^2) + underbrace((dif B)/(dif r) (dif r)/(dif lambda), dif B \/ dif lambda) (dif t)/(dif lambda) = B (dd(2, t))/(dif lambda^2) + (dif B)/(dif lambda) (dif t)/(dif lambda) = dif/(dif lambda) (B (dif t)/(dif lambda)) = 0. $
Thus, we found $B (dif t)/(dif lambda) = B dot(t)$ to be constant w.r.t. $lambda$.

#task(label: "c")[
  Consider the equatorial plane, $theta = pi/2$. Show that the geodesic equation for $phi$ delivers
  $ r^2 (dif phi)/(dif lambda) equiv L, quad L = "const". $
]

$
  dot.double(phi) = dot.double(x)^3 & = -chr(3, rho sigma) dot(x)^rho dot(x)^sigma = -2 chr(3, 13) dot(x)^1 dot(x)^3 - 2 chr(3, 23) dot(x)^2 dot(x)^3 \
  & = -2/r dot(r) dot(phi) - underbrace(2 cot theta dot(theta) dot(phi), 0 "for" theta = pi\/2) \
  ==> quad & r^2 (dd(2, phi))/(dif lambda^2) + underbrace(2 r (dif r)/(dif lambda), dif r^2 \/ dif lambda) (dif phi)/(dif lambda) = dif/(dif lambda) (r^2 (dif phi)/(dif lambda)) = 0.
$
The geodesic equation for $phi$ yields $r^2 (dif phi)/(dif lambda) equiv L$ to be a constant.

#task(label: "d")[
  Show that the last interesting geodesic equation, the one for $r$, delivers
  $ (dd(2, r))/(dif lambda^2) + (F^2 B')/(2A B^2) + A'/(2A) ((dif r)/(dif lambda))^2 - L^2/(A r^3) = 0. $
]

$
  dot.double(x)^1 + chr(1, rho sigma) dot(x)^rho dot(x)^sigma & = dot.double(x)^1 + chr(1, 00) dot(x)^0 dot(x)^0 + chr(1, 11) dot(x)^1 dot(x)^1 + chr(1, 33) dot(x)^3 dot(x)^3 \
  & = dot.double(r) + B'/(2A) dot(t)^2 + A'/(2A) dot(r)^2 - r/A dot(phi)^2 \
  & = (dd(2, r))/(dif lambda^2) + B'/(2A B^2) F^2 + A'/(2A) ((dif r)/(dif lambda))^2 - L^2/(A r^3) = 0.
$

#task(label: "e")[
  Multiplying the above result by $2A (dif r)/(dif lambda)$, show that
  $ A ((dif r)/(dif lambda))^2 + L^2/r^2 - F^2/B = -epsilon = "const". $
]

$
  & 2A (dif r)/(dif lambda) (dd(2, r))/(dif lambda^2) + B' F^2/B^2 (dif r)/(dif lambda) + A' ((dif r)/(dif lambda))^3 - (2L^2)/r^3 (dif r)/(dif lambda) \
  & = 2A (dif r)/(dif lambda) (dd(2, r))/(dif lambda^2) - dif/(dif lambda) F^2/B + (dif A)/(dif lambda) ((dif r)/(dif lambda))^2 + dif/(dif lambda) L^2/r^2 \
  & = dif/(dif lambda) (A ((dif r)/(dif lambda))^2) - dif/(dif lambda) F^2/B + dif/(dif lambda) L^2/r^2 = dif/(dif lambda) underbrace((A ((dif r)/(dif lambda))^2 - F^2/B + L^2/r^2), equiv -epsilon = "const w.r.t." lambda) = 0.
$

#task(label: "f")[
  Using $B(r) = A^(-1)(r) = 1 - (2a)/r$, simplify the last result to
  $ dot(r)^2/2 - (a epsilon)/r + L^2/(2r^2) - (a L^2)/r^3 = (F^2 - epsilon)/2. $
]

We multiply our last result with $B/2$ and add $F^2/2$ to get
$
  & dot(r)^2/2 + B L^2/(2r^2) = dot(r)^2/2 + L^2/(2r^2) - (a L^2)/r^3 = F^2/2 - B epsilon/2 = (F^2 - epsilon)/2 + (a epsilon)/r \
  ==> quad & dot(r)^2/2 - (a epsilon)/r + L^2/(2r^2) - (a L^2)/r^3 = (F^2 - epsilon)/2.
$

#task(label: "g")[
  Since our satellite has mass, we assume $lambda = tau$ and $epsilon = c^2$ (for photons we would have $epsilon = 0$). For simplicity, we impose a spherical orbit. From the lecture, we know $a = G M\/c^2$, and define the effective potential
  $ V_"eff" (r) = -(G M)/r + L^2/(2r^2) - (G M L^2)/(c^2 r^3). $
  Which term is new when compared to Newtonian gravity?
]

The first term of $V_"eff" (r)$ corresponds exactly to the Newtonian gravitational potential $V_G = -(G M)/r$. The second term is a contribution from the satellite's angular momentum, also known from Newtonian gravity. The third term, however, is unfamiliar, meaning it is a proper contribution from general relativity. Obviously, it becomes important at small radial distances $r$.

#task(label: "h")[What does eq. (3) look like for our satellite?]

$
  (dif t)/(dif tau) = F/B & = 1/(1 - (2 G M)/(c^2 r)) (dot(r)^2 - (2 a epsilon)/r + L^2/r^2 - (2 a L^2)/r^3 + epsilon)^(1\/2) \
  & = (1 - (2 G M)/(c^2 r))^(-1) (c^2 (1 - (2 G M)/(c^2 r)) + L^2/r^2 (1 - (2 G M)/(c^2 r)))^(1\/2) = sqrt(c^2 + L^2\/r^2)/sqrt(1 - 2a\/r),
$
setting $epsilon = c^2$ and $dot(r) = 0$ for a circular orbit in the second step.

#task(label: "i")[Now we want to get rid of the $L$-dependency. In order to do this, we impose $dif V_"eff" (r) \/ dif r = 0$. Solve this for $L^2\/(c^2 r^2)$ to arrive at an expression for $dif t\/dif tau$ free of $L$.]

$
  (dif V_"eff")/(dif r) & = (G M)/r^2 - L^2/r^3 + (3 G M L^2)/(c^2 r^4) = (G M)/r^2 + ((3 G M)/r^2 - c^2/r) L^2/(c^2 r^2) attach(=, t: !) 0 \
  ==> quad L^2/(c^2 r^2) & = (-G M)/(3 G M - c^2 r) = 1/((c^2 r)/(G M) - 3).
$
Inserting this relation into our result from part h), we obtain
$
  (dif t)/(dif tau) & = (1 - (2 G M)/(c^2 r))^(-1) (c^2 (1 - (2 G M)/(c^2 r)) (1 + L^2/(c^2 r^2)))^(1\/2) \
  & = (1 - (2 G M)/(c^2 r))^(-1) (c^2 (1 - (2 G M)/(c^2 r)) (1 - (G M)/(3 G M - c^2 r)))^(1\/2) \
  ==> quad dif tau & = (1 - (3 G M)/(r c^2))^(1\/2) dif t.
$

#task(label: "j")[_Extra:_ Plot $V_"eff" (r)$ and $V'_"eff" (r)$. Is there anything surprising?]

Plots of $V_"eff" (r)$ and $V'_"eff" (r)$ for different $L$:

#let veff(l2) = r => -1 / r + l2 / (2 * r * r) - l2 / (r * r * r)
#let dveff(l2) = r => 1 / (r * r) - l2 / (r * r * r) + 3 * l2 / (r * r * r * r)
#let potential-sketch(f1, f2, x0, x1, y0, y1, ylabel, lbl-at, lbl-to) = canvas(length: 1cm, {
  import draw: *
  let (w, h) = (5.5, 3.6)
  let y-zero = -y0 / (y1 - y0) * h
  set-style(stroke: 0.6pt)
  line((0, 0), (0, h + 0.2), mark: (end: "stealth", fill: black))
  line((0, y-zero), (w + 0.2, y-zero), mark: (end: "stealth", fill: black))
  content((w + 0.35, y-zero), $r$, anchor: "west")
  content((0, h + 0.35), ylabel, anchor: "south")
  content((-0.1, y-zero), $0$, anchor: "north-east")
  sketch-curve(f1, x0, x1, y0, y1, w, h, stroke: 0.9pt)
  sketch-curve(f2, x0, x1, y0, y1, w, h, stroke: 0.9pt)
  line(lbl-at, lbl-to, stroke: 0.4pt)
  content(lbl-at, $L_2 > L_1$, anchor: "south-west")
})

#align(center, grid(
  columns: 2,
  column-gutter: 1.5cm,
  potential-sketch(veff(10), veff(25), 0.01, 40, -0.4, 0.25, $V_"eff" (r)$, (2.0, 3.2), (1.0, 2.45)),
  potential-sketch(dveff(10), dveff(25), 0.01, 40, -0.06, 0.06, $V'_"eff" (r)$, (2.0, 2.6), (1.2, 1.45)),
))

These plots are very different from those drawn for Newtonian gravity. For one, the potential goes to $-oo$, rather than $+oo$, as $r -> 0$. Secondly, $V_"eff" (r)$ exhibits maxima (whereas $V_"Newt" (r)$ may only have minima or no extrema at all, depending on $L$), allowing for unstable circular orbits of e.g. a satellite around a black hole.

= Problem 3 (Ricci-scalar don't care) [10 points]

#task[
  Using the four entries $R_(mu mu)$ of the diagonal Ricci tensor, calculate
  $ R = g^(mu nu) R_(mu nu) $
  and plot the result against $r$ in units of $R_s$. What happens at $R_s$?
]

We expect $R = 0$, since we explicitly argued in exercise 1.a) that the Ricci tensor $R_(mu nu)$ is zero in a vacuum system. Still we compute
$
  R & = g^(00) R_(00) + g^(11) R_(11) + g^(22) R_(22) + g^(33) R_(33) \
  & = 1/B [-B''/(2A) + B'/(4A) (A'/A + B'/B) - B'/(A r)] - 1/A [B''/(2B) - B'/(4B) (A'/A + B'/B) - A'/(A r)] \
  & quad - 1/r^2 [1/A - 1 - r/(2A) (A'/A - B'/B)] - 1/(r^2 sin^2 theta) [1/A - 1 - r/(2A) (A'/A - B'/B)] sin^2 theta \
  & = -B''/(2A B) + B'/(4A B) (A'/A + B'/B) - B'/(A B r) - B''/(2A B) + B'/(4A B) (A'/A + B'/B) + A'/(A^2 r) \
  & quad - 2/(A r^2) + 2/r^2 + 1/(A r) underbrace((A'/A - B'/B), 2 A'/A) \
  & = -B''/(A B) + B'/(2A B) underbrace((A'/A + B'/B), 0) - (2B')/(A B r) + overbrace((2A')/(A^2 r)) + 2/r^2 (1 - 1/A),
$
where $A'/A + B'/B = ln(A)' + ln(B)' = ln(A)' + ln(A^(-1))' = ln(A)' - ln(A)' = 0$.

We now use $B(r) = A^(-1)(r) = 1 - (2a)/r$ to simplify
$
  R & = -(1 - (2a)/r)'' - 2/r (1 - (2a)/r)' + 2/r (1 - (2a)/r)' + 2/r^2 (2a)/r \
  & = (4a)/r^3 + (4a)/r^3 = (8a)/r^3 = (8 G M)/(c^2 r^3).
$

#grid(
  columns: (auto, 1fr),
  column-gutter: 1cm,
  align: (left, horizon),
  canvas(length: 1cm, {
    import draw: *
    let (w, h) = (4.5, 3.6)
    set-style(stroke: 0.6pt)
    line((0, -0.2), (0, h + 0.2), mark: (end: "stealth", fill: black))
    line((-0.3, 0), (w + 0.2, 0), mark: (end: "stealth", fill: black))
    content((w + 0.35, 0), $r$, anchor: "west")
    content((0, h + 0.35), $R$, anchor: "south")
    line((-0.08, 1), (0.08, 1))
    content((-0.15, 1), $1$, anchor: "east")
    line((0.9, -0.08), (0.9, 0.08))
    content((0.9, -0.3), $R_s = (2 G M)/c^2$, anchor: "north")
    // R = 8a/r^3 = 1 at r = 2a = R_s (placed at x = 0.9)
    sketch-curve(r => calc.pow(0.9 / r, 3), 0.01, 4.5, 0, 3.6, w, h, stroke: 0.9pt)
  }),
  [No unusual behavior at $r = R_s$.],
)

= Problem 4 (Extra: Black hole detection) [5 points]

#task[Name two ways of detecting a black hole! Since we can't see it directly, how would you go about looking for one in our cosmos?]

Black holes do not emit light directly but influence their surroundings. Detection should be possible via:
- gravitational effects on nearby celestial objects where no apparent source can be found
- gravitational lensing of light traversing close to the black hole
- emission of gamma rays from the accretion disk around the black hole
- gravitational waves
