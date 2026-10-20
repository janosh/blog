#import "/notes.typ": dd, notes, task
#import "@preview/cetz:0.5.2": canvas, draw

#show: notes.with(
  title: [General Relativity -- Exercise Sheet 9],
  subtitle: [Exercise sheet 9, General Relativity, Prof. Björn Malte Schäfer],
  date: [Solutions by Roland Walz and Janosh Riebesell, 11.06.2015],
)

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

#let vr = $arrow(r)$
#let vv = $arrow(v)$
#let vw = $arrow(omega)$
#let ez = $arrow(e)_z$

= Problem 1 (Coordinate change) [10 points]

#task[
  Given the line element
  $ dif s^2 = A(r) c^2 dif t^2 - B(r) dif r^2 - C(r) r^2 dif Omega^2 $
  (normally written $dif Omega$), define $B(r)$ to be $B(r) = G(r) + C(r)$. Transform the radial coordinate according to
  $ (dif rho)/rho = (dif r)/r sqrt(1 + G(r)/C(r)), $
  and show that the line element can be brought to the form
  $ dif s^2 = X(rho) c^2 dif t^2 - Y(rho) (dif rho^2 + rho^2 dif Omega^2), $
  where $X(rho) = A(r)$, $Y(rho) = r^2/rho^2 C(r)$, thereby uncovering a spatially isotropic form of the metric.
]

$
  dif s^2 & = A(r) c^2 dif t^2 - underbrace(B(r), G(r) + C(r)) dif r^2 - C(r) r^2 dif Omega^2 = A(r) c^2 dif t^2 - C(r) r^2 (underbrace((1 + G(r)/C(r)) (dif r^2)/r^2, dif rho^2 \/ rho^2) + dif Omega^2) \
  & = underbrace(A(r), X(rho)) c^2 dif t^2 - underbrace(C(r) r^2/rho^2, Y(rho)) (dif rho^2 + rho^2 dif Omega^2) = X(rho) c^2 dif t^2 - Y(rho) (dif rho^2 + rho^2 dif Omega^2).
$

= Problem 2 (Black hole evasion) [15 points]

#task[
  A space ship is travelling at $dot(r)_oo = c/sqrt(2)$ (freely falling), when the crew notice that they are going to pass within impact parameter $b = 4 R_s$ of a black hole. (Assume their journey starts at $r = oo$.)
]

The spaceship's trajectory is governed by the equation of motion derived on the last sheet,
$ 1/2 dot(r)^2 + V_"eff" (r) = alpha, quad "with" alpha in RR "constant", $
with the effective potential
$ V_"eff" (r) = -(G M)/r + L^2/(2r^2) - (G M L^2)/(c^2 r^3). $

#task[The spaceship's angular momentum is given by $dot(r)_oo b$. Will the space ship be captured or escape the black hole's pull?]

As shown in problem 2 of the last assignment, $V_"eff" (r)$'s plot is of the form

#align(center, canvas(length: 1cm, {
  import draw: *
  let (w, h) = (6, 3.2)
  let (y0, y1) = (-0.08, 0.2)
  let y-zero = -y0 / (y1 - y0) * h
  set-style(stroke: 0.6pt)
  line((0, 0), (0, h + 0.2), mark: (end: "stealth", fill: black))
  line((0, y-zero), (w + 0.2, y-zero), mark: (end: "stealth", fill: black))
  content((w + 0.35, y-zero), $r$, anchor: "west")
  content((0, h + 0.35), $V_"eff" (r)$, anchor: "south")
  sketch-curve(r => -1 / r + 12.5 / (r * r) - 25 / (r * r * r), 0.01, 40, y0, y1, w, h, stroke: 0.9pt)
}))

So the question can be answered by checking if the spaceship's energy is large enough to traverse the black hole's potential barrier. Since the energy is constant, we can calculate it for all $r$ by looking at $E(r, dot(r)) = dot(r)^2/2 + V_"eff" (r)$ for $r = r_oo = oo$ and $dot(r) = dot(r)_oo = c/sqrt(2)$. Since $V_"eff" (r = r_oo) = 0$, we simply have
$ E(r = r_oo, dot(r) = dot(r)_oo) = c^2/4 = E(r, dot(r)) quad forall r, dot(r). $
Now we simply need to calculate the potential barrier height to decide on the question.
$ 0 attach(=, t: !) dif/(dif r) V_"eff" (r) = (G M)/r^2 - L^2/r^3 + (3 G M L^2)/(c^2 r^4). $
Since we are not interested in $V_"eff" (r = 0)$, we may assume $r$ to be unequal to zero and multiply the above equation by $r^4$ to get
$ r^2 - L^2/(G M) r + (3 L^2)/c^2 = (r - L^2/(2 G M))^2 - L^4/(4 G^2 M^2) + (3 L^2)/c^2 = 0. $
Solving for $r$ and inserting what we know about $L$, i.e. $L = dot(r)_oo b = c/sqrt(2) 4 R_s = sqrt(8) c R_s$, we get the following positions for potential extrema of $V_"eff" (r)$,
$
  r_plus.minus & = L^2/(2 G M) plus.minus sqrt(L^4/(4 G^2 M^2) - (3 L^2)/c^2) = (8 c^2 R_s^2)/(2 G M) plus.minus sqrt((64 c^4 R_s^4)/(4 G^2 M^2) - (24 c^2 R_s^2)/c^2) \
  & = 8 R_s plus.minus sqrt(64 R_s^2 - 24 R_s^2) = (8 plus.minus sqrt(40)) R_s =: gamma_plus.minus R_s.
$
Without checking, we assume the smaller value, $gamma_- R_s$, to be the position of the maximum, i.e. the potential barrier. Then we get
$
  V_"eff" (r = r_-) & = -(G M)/(gamma_- R_s) + L^2/(2 gamma_-^2 R_s^2) (1 - (2 G M)/(c^2 gamma_- R_s)) \
  & = -c^2/(2 gamma_-) + (4 c^2)/gamma_-^2 (1 - 1/gamma_-) approx 0.276 c^2 > c^2/4 = E(r, dot(r)).
$
Therefore, the spaceship rebounds before reaching the top of the potential barrier.

= Problem 3 (Gravitational field of a rotating sphere) [15 points]

#task[
  The linearized field equations can be written as
  $ partial^sigma partial_sigma h_(mu nu) = -(16 pi G)/c^4 (T_(mu nu) - T/2 eta_(mu nu)). $
  The solution for $h_(mu nu)$, known from electrodynamics, is
  $ h_(mu nu) (vr, t) = -(4 G)/c^4 integral dd(3, r') (U_(mu nu) (vr', t - |vr - vr'| \/ c))/(|vr - vr'|), $
  where $U_(mu nu) = T_(mu nu) - T/2 eta_(mu nu)$. The energy-momentum tensor reads
  $ T^(mu nu) = (rho + P/c^2) u^mu u^nu - P eta^(mu nu). $
  Assume the source of the gravitational field to be a sphere with radius $R$ and homogeneous mass density $rho$, rotating with angular frequency $omega$. Assume $P = 0$ and only keep terms linear in $v/c = (omega R)/c$. Calculate the static fields $h_(mu nu) (vr)$.
]

In the static case of a time-independent gravitational field, the time derivatives vanish and the linearized field equations become
$ partial^sigma partial_sigma h_(mu nu) = Delta h_(mu nu) - underbrace(partial_(c t)^2 h_(mu nu), 0) = Delta h_(mu nu) = -(16 pi G)/c^4 (T_(mu nu) - T/2 eta_(mu nu)), $
which is just Poisson's equation, solved by
$ h_(mu nu) (vr) = -(4 G)/c^4 integral dd(3, r') (U_(mu nu) (vr'))/(|vr - vr'|). $
Now we turn our attention towards $U_(mu nu) (vr)$. Applying approximations as indicated by the exercise ($P = 0$, $v^2/c^2 = (omega^2 R^2)/c^2 approx 0$) we can specify
$
  T_(mu nu) & = (rho + P/c^2) u_mu u_nu - P eta_(mu nu) attach(=, t: P = 0) rho u_mu u_nu, quad "with" u_mu = gamma vec(c, vv) attach(=, t: v^2\/c^2 -> 0) vec(c, vv), \
  T & = T_mu^(space mu) = rho u_mu u^mu = rho (c^2 - vv^2) = c^2 rho (1 - underbrace(v^2/c^2, 0)) = c^2 rho, \
  U_(mu nu) & = T_(mu nu) - T/2 eta_(mu nu) = rho u_mu u_nu - c^2/2 rho eta_(mu nu) = rho (u_mu u_nu - c^2/2 eta_(mu nu)).
$
We can calculate each of the ten static fields $h_(mu nu) (vr)$ by looking at every component of $U_(mu nu)$ separately:
$
  U_(00) & = rho (u_0 u_0 - c^2/2 eta_(00)) = rho (c^2 - c^2/2) = c^2/2 rho, \
  U_(11) & = rho (u_1 u_1 - c^2/2 eta_(11)) = rho (v_x^2 + c^2/2) = c^2/2 rho (1 + underbrace((2 v_x^2)/c^2, 0)) = c^2/2 rho = U_(22) = U_(33), \
  U_(01) & = rho (u_0 u_1 - c^2/2 eta_(01)) = c rho v_x, quad U_(02) = c rho v_y, quad U_(03) = c rho v_z, \
  U_(12) & = rho (u_1 u_2 - c^2/2 eta_(12)) = rho v_x v_y, quad U_(13) = rho v_x v_z, quad U_(23) = rho v_y v_z.
$
$U_(mu nu)$'s other six entries are determined by its symmetry under exchange of $mu$ and $nu$ (which $U_(mu nu)$ inherited from $T_(mu nu)$ and $eta_(mu nu)$).
$
  underline(U) = rho c^2 mat(
    1/2, v_x\/c, v_y\/c, v_z\/c;
    v_x\/c, 1/2, v_x v_y\/c^2, v_x v_z\/c^2;
    v_y\/c, v_y v_x\/c^2, 1/2, v_y v_z\/c^2;
    v_z\/c, v_z v_x\/c^2, v_z v_y\/c^2, 1/2;
  ) attach(=, t: v^2\/c^2 = 0) rho c^2 mat(
    1/2, vv^T\/c;
    vv\/c, mat(1/2, , ; , 1/2, ; , , 1/2; delim: #none);
    augment: #(hline: 1, vline: 1)
  ).
$
To bring out the $vr$-dependence of $underline(U) = underline(U)(vr)$, we note that any vector $vr$ that rotates with angular velocity $omega = |vw|$ around an axis with angular speed vector $vw$ satisfies
$ vv = vw times vr. $
By choosing spherical coordinates such that $vr dot vr' = r r' cos theta$ and such that the origin, $vr = 0$, coincides with the sphere's center, and reminding ourselves
$ rho(vr) = cases(rho\, & "if" vr in partial B_R (vr = 0) = {vr in RR^3 | |vr| = R}, 0\, & "otherwise",) $
we obtain the following static gravitational fields
$
  h_(i i) (vr) & = -(4 G)/c^4 integral_(RR^3) dd(3, r') (U_(i i) (vr'))/(|vr - vr'|) = -(2 G)/c^2 integral_(RR^3) dd(3, r') (rho(vr'))/(|vr - vr'|) \
  & = -(2 G)/c^2 integral_0^oo dd(r') integral_0^pi dd(theta) integral_0^(2 pi) dd(phi) (rho delta(r' - R) r'^2 sin theta)/(r^2 + r'^2 - 2 r r' cos theta)^(1\/2) \
  & = -(2 G rho)/c^2 integral_0^pi dd(theta) integral_0^(2 pi) dd(phi) (R^2 sin theta)/(r^2 + R^2 - 2 r R cos theta)^(1\/2), quad u = r^2 + R^2 - 2 r R cos theta, quad dif u = 2 r R sin theta dif theta \
  & = -(4 pi G rho)/c^2 integral_a^b (dif u)/(2 r R) R^2/sqrt(u) = -(4 pi G rho)/c^2 R/r (underbrace(sqrt(r^2 + R^2 + 2 r R), r + R) - underbrace(sqrt(r^2 + R^2 - 2 r R), |r - R|)), quad cases(b = r^2 + R^2 + 2 r R, a := r^2 + R^2 - 2 r R) \
  & = -(4 pi G rho)/c^2 cases(display(R/r (r + R - r + R) = (2 R^2)/r)\, & "for" r >= R, display(R/r (r + R - R + r) = 2 R)\, & "for" r < R, gap: #1em), quad "where" i in {0, 1, 2, 3}.
$
$
  arrow(h)(vr) & = vec(h_(01) (vr), h_(02) (vr), h_(03) (vr)) = -(4 G)/c^4 integral_(RR^3) dd(3, r') (arrow(U)(vr'))/(|vr - vr'|) = -(4 G)/c^3 integral_(RR^3) dd(3, r') (rho(vr') vw times vr')/(|vr - vr'|) \
  & = -(4 G)/c^3 integral_0^oo dd(r') integral_0^pi dd(theta) integral_0^(2 pi) dd(phi) (rho delta(r' - R) r'^2 sin theta)/(r^2 + r'^2 - 2 r r' cos theta)^(1\/2) vw times r' vec(cos phi sin theta, sin phi sin theta, cos theta) \
  & = -(8 pi G rho)/c^3 integral_0^pi dd(theta) (R^2 sin theta)/(r^2 + R^2 - 2 r R cos theta)^(1\/2) vw times vec(0, 0, cos theta), quad u = r^2 + R^2 - 2 r R cos theta, quad dif u = 2 r R sin theta dif theta \
  & = -(8 pi G rho)/c^3 vw times ez integral_a^b dd(u) 1/(4 r^2) (r^2 + R^2 - u)/sqrt(u), quad v = sqrt(u), quad dif v = 1/(2 sqrt(u)) dif u \
  & = -(8 pi G rho)/c^3 vw times ez integral_(sqrt(a))^(sqrt(b)) dd(v) 1/(2 r^2) (r^2 + R^2 - v^2) \
  & = -(4 pi G rho)/(c^3 r^2) vw times ez [(r^2 + R^2)(sqrt(b) - sqrt(a)) - 1/3 (b^(3\/2) - a^(3\/2))] \
  & = -(4 pi G rho)/(c^3 r^2) vw times ez [(r^2 + R^2)(r + R - |r - R|) - 1/3 ((r + R)^3 - |r - R|^3)] \
  & = cases(display(-(4 pi G rho)/(c^3 r^2) vw times ez 4/3 R^3 = -(16 pi G rho R^3)/(3 c^3 r^2) vw times ez)\, & "for" r >= R, display(-(4 pi G rho)/(c^3 r^2) vw times ez 4/3 r^3 = -(16 pi G rho r)/(3 c^3) vw times ez)\, & "for" r < R, gap: #1em) = (arrow(h)(vr))^T.
$
Interestingly, due to $vw times ez$, the off-diagonal elements of $underline(h)(vr)$ vanish along the axis of rotation ($vw times ez$ has no component along $vw$), so as one would expect in the case of a perfect sphere, an observer sitting on the axis of rotation cannot (based on the gravitational field) distinguish between a rotating and a non-rotating field source.

= Problem 4 (Extra: Falling into a black hole) [5 points]

#task[How long would a fall into a black hole take for a freely falling observer? What does his more fortunate friend at infinite distance say?]

As time dilation diverges upon approaching a black hole's event horizon, nothing can ever truly pass that horizon and be undetectable outside the black hole for good. However, there is no limit to slowing down of time, so the gaps between individual photons sent out by the object falling into the black hole can quickly increase to become billions of years. On the other hand, a falling observer, since he is _freely_ falling, would detect nothing out of the ordinary with regard to his proper time.
