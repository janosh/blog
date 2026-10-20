#import "/notes.typ": dd, notes, task
#import "@preview/cetz:0.5.2": canvas, draw

#show: notes.with(
  title: [Quantum Field Theory II -- Assignment 7],
  subtitle: [Exercise sheet 7, Advanced QFT, Prof. Jürgen Berges],
  date: [Solutions by Janosh Riebesell, 21.06.2015],
)

#let O = $cal(O)$

// Feynman diagrams of phi^4 theory, drawn inline in equations
#let fd(body, s: 0.75) = box(baseline: 50%, inset: (y: 2pt), canvas(length: s * 1cm, {
  import draw: *
  set-style(stroke: 0.7pt)
  body
}))
#let lbl(pt, body) = draw.content(pt, text(size: 7pt, body))
// fully resummed (hatched) blob
#let hblob(pt, r: 0.22) = draw.circle(pt, radius: r, fill: luma(160))
// counterterm vertex (circled cross) and counterterm insertion (cross)
#let otimes(pt, r: 0.16) = {
  draw.circle(pt, radius: r, fill: white)
  let d = r * 0.707
  draw.line((pt.at(0) - d, pt.at(1) - d), (pt.at(0) + d, pt.at(1) + d))
  draw.line((pt.at(0) - d, pt.at(1) + d), (pt.at(0) + d, pt.at(1) - d))
}
#let xmark(pt, d: 0.12) = {
  draw.line((pt.at(0) - d, pt.at(1) - d), (pt.at(0) + d, pt.at(1) + d), stroke: 1pt)
  draw.line((pt.at(0) - d, pt.at(1) + d), (pt.at(0) + d, pt.at(1) - d), stroke: 1pt)
}
#let xlegs(c: (0, 0), d: 0.6) = {
  draw.line((c.at(0) - d, c.at(1) - d), (c.at(0) + d, c.at(1) + d))
  draw.line((c.at(0) - d, c.at(1) + d), (c.at(0) + d, c.at(1) - d))
}

#let fprop = fd(draw.line((-0.8, 0), (0.8, 0)))
#let ct-prop = fd({ draw.line((-0.8, 0), (0.8, 0)); xmark((0, 0)) })
#let full-prop = fd({ draw.line((-0.8, 0), (0.8, 0)); hblob((0, 0)) })
#let vertex = fd(xlegs())
#let ct-vertex = fd({ xlegs(); otimes((0, 0)) })
#let full-vertex = fd({ xlegs(); hblob((0, 0)) })
#let tadpole = fd({
  draw.line((-0.9, 0), (0.9, 0))
  draw.circle((0, 0.35), radius: 0.35)
})
// small arrowhead along a line segment from a to b
#let arr(a, b) = draw.line(a, b, mark: (end: ">", fill: black, scale: 0.5))
// one-loop s-, t- and u-channel bubbles, external legs labeled as in the full 4-point blob
// (p3 top left, p4 top right, p1 bottom left, p2 bottom right)
#let bubble(ch) = fd({
  draw.circle((0, 0), radius: 0.4)
  if ch == "s" {
    draw.line((0, 0.4), (-0.95, 0.8))
    draw.line((0, 0.4), (0.95, 0.8))
    draw.line((0, -0.4), (-0.95, -0.8))
    draw.line((0, -0.4), (0.95, -0.8))
  } else {
    draw.line((-0.4, 0), (-0.95, -0.8))
    draw.line((0.4, 0), (0.95, -0.8))
    if ch == "t" {
      draw.line((-0.4, 0), (-0.95, 0.8))
      draw.line((0.4, 0), (0.95, 0.8))
    } else {
      // u-channel: upper legs cross above the loop
      draw.bezier((-0.4, 0), (0.95, 0.8), (-0.48, 0.65), (0.3, 0.8))
      draw.bezier((0.4, 0), (-0.95, 0.8), (0.48, 0.65), (-0.3, 0.8))
    }
  }
  lbl((-1.15, 0.95), $p_3$)
  lbl((1.15, 0.95), $p_4$)
  lbl((-1.15, -0.95), $p_1$)
  lbl((1.15, -0.95), $p_2$)
})
// superficially divergent n-point blobs
#let npoint(legs) = fd({
  for p in legs { draw.line((0, 0), p) }
  hblob((0, 0))
})

= Problem 7.1 (One-loop structure of $phi^4$-theory)

#task[Calculate up to one-loop order, including the counterterms, the contribution to the renormalization of]

#task(label: "a")[the propagator, i.e. $i M^2 (p^2)$ of the boson propagator in momentum space.]

The $lambda phi^4$-theory Lagrangian reads
$
  cal(L)_(phi^4) & = 1/2 (partial phi_0)^2 - 1/2 m_0^2 phi_0^2 - lambda_0/4! phi_0^4 \
  & = 1/2 (partial phi)^2 - 1/2 m^2 phi^2 - lambda/4! phi^4 + 1/2 delta_Z (partial phi)^2 - 1/2 delta_m phi^2 - delta_lambda/4! phi^4,
$
where we expressed it in the first line in terms of the bare field $phi_0$, and the bare mass and coupling, $m_0$ and $lambda_0$. In the second line, we split each term in two such that the first contains only finite so-called renormalized quantities with values as they would be measured in experiment, and the second part absorbs all the divergence in so-called counterterms. Specifically, we here defined
$ phi = Z^(-1/2) phi_0, quad delta_Z = Z - 1, quad delta_m = m_0^2 Z - m^2, quad delta_lambda = lambda_0 Z^2 - lambda. $
From the split-up Lagrangian, we read off the following Feynman rules
$
  #fprop & = i/(p^2 - m^2 + i epsilon), quad && #ct-prop = i(p^2 delta_Z - delta_m), \
  #vertex & = -i lambda, quad && #ct-vertex = -i delta_lambda.
$
Before taking care of the fully resummed propagator, #full-prop, we briefly investigate the divergence structure of $lambda phi^4$-theory by calculating the superficial degree of divergence $D$. For this, we note that every loop contributes a four-momentum integral while every propagator carries two powers of momentum in the denominator. Thus,
$ D = 4L - 2P, quad L: "number of loops", quad P: "number of propagators". $
But every internal propagator also gives an integral over its undetermined momentum while every vertex gives a delta distribution, all but one of which fix one internal momentum killing a momentum in the process. The first vertex's delta, however, merely imposes overall momentum conservation, thus not impacting the internal momenta. The above relationships are summarized in Euler's formula,
$ L = P - (V - 1) = P - V + 1, quad V: "number of vertices". $
Together with $4V = 2P + E$, we obtain a s.d.o.d. for $lambda phi^4$-theory of
$ D = 4(P - V + 1) - 2P = 2P - 4V + 4 = 2P - 2P - E + 4 = 4 - E, $
where $E$ is the number of external lines on a diagram. Thus, there are only a finite number of divergent diagrams but they appear at every order in perturbation theory. For this reason, $lambda phi^4$-theory is called renormalizable (which can also be seen by noting $[lambda] = 0$). The superficially divergent diagrams are
$
  "i)" #npoint(()) quad D = 4, quad "ii)" #npoint(((0.8, 0),)) quad D = 3, quad "iii)" #npoint(((-0.8, 0), (0.8, 0))) quad D = 2, \
  "iv)" #npoint(((-0.7, 0.55), (-0.7, -0.55), (0.8, 0))) quad D = 1, quad "v)" #npoint(((-0.6, 0.6), (0.6, 0.6), (-0.6, -0.6), (0.6, -0.6))) quad D = 0.
$
Since the Lagrangian $cal(L)_(phi^4)$ is invariant under the parity transf. $hat(P)(phi(t, arrow(x))) = -phi(t, -arrow(x))$, all diagrams with an odd number of external lines vanish. Thus, amplitudes ii) and iv) are not actually divergent but rather zero.

We are finally at the point, where we understand, why we are tasked with renormalizing the propagator and the vertex. The vacuum diagram can be trivially absorbed into the vacuum energy density $V_0$, an additional degree of freedom of any Lagrangian, which we did not write down explicitly, since the absolute energy scale is meaningless in a theory without gravity. Thus, propagator and vertex are the only two fundamental divergencies in $lambda phi^4$-theory. All others are due to diagrams containing these two as subdiagrams.

Moving on to renormalize the propagator up to one-loop, we note
$ #full-prop = i/(p^2 - m^2 - M^2 (p^2)) = #fprop + #tadpole + #ct-prop + O(lambda^2), $
where we wrote the fully resummed propagator using the renormalized mass $m$ and the renormalized field $phi$, explaining why no factor of $Z$ appears in the numerator. Here, $-i M^2 (p^2)$ is the amplitude of all 1PI amputated diagrams, which up to one-loop order are
$ -i M^2 (p^2) = #tadpole + #ct-prop + O(lambda^2). $
We define the renormalized parameters in our Lagrangian, $m$ and $lambda$, by imposing the following renormalization conditions (as many as we found superficially divergent amplitudes),
$ #full-prop attach(=, t: !) i/(p^2 - m^2) quad "at" p^2 = m^2, quad #full-vertex attach(=, t: !) -i lambda quad "at" s = 4m^2, t = u = 0, $
which, in case of the first condition, implies for $M^2 (p^2)$
$ M^2 (p^2)|_(p^2 = m^2) = 0, quad dif/(dif p^2) M^2 (p^2)|_(p^2 = m^2) = 0, $
to fix both the position of the pole at $p^2 = m^2$ and its residue of 1.

What remains is to actually calculate the divergent contributions in the expansion of #full-prop (using dim. regularization with $d = 4 - epsilon$)
$ #tadpole = -(i lambda)/2 integral (dd(d, p))/(2 pi)^d i/(p^2 - m^2 + i epsilon) attach(=, t: p^0 = i p_E^0) -(i lambda)/2 integral (dd(d, p_E))/(2 pi)^d 1/(p_E^2 + m^2) = -(i lambda)/(2 (2 pi)^d) integral dd(Omega_d) integral_0^oo dd(p_E) p_E^(d-1)/(p_E^2 + m^2), $
where the area of the $d$-dimensional unit sphere is given by
$
  sqrt(pi)^d & = (integral_(-oo)^oo dd(x) e^(-x^2))^d = integral dd(d, x) e^(-sum_(i=1)^d x_i^2) = integral dd(Omega_d) integral_0^oo dd(x) x^(d-1) e^(-x^2), quad "subst." t = x^2 \
  & = integral dd(Omega_d) 1/2 integral_0^oo dd(t) t^(d/2 - 1) e^(-t) =: integral dd(Omega_d) 1/2 Gamma(d/2) quad ==> quad integral dd(Omega_d) = (2 pi^(d/2))/Gamma(d/2).
$
Hence
$
  #tadpole & = -(i lambda)/((4 pi)^(d/2) Gamma(d/2)) integral_0^oo dd(p_E) p_E^(d-1)/(p_E^2 + m^2), quad "subst." x = m^2/(p_E^2 + m^2) \
  & = -(i lambda)/((4 pi)^(d/2) Gamma(d/2)) integral_1^0 p_E^(d-1)/(p_E^2 + m^2) (p_E^2 + m^2)^2/(-2 m^2 p_E) dif x = -(i lambda)/(2 (4 pi)^(d/2) Gamma(d/2)) integral_0^1 underbrace(p_E^(d-2), (m sqrt(-1 + 1/x))^(d-2)) 1/x dif x \
  & = -(i m^(d-2) lambda)/(2 (4 pi)^(d/2) Gamma(d/2)) integral_0^1 x^(-d/2) (1 - x)^(d/2 - 1) dif x = -(i m^(d-2) lambda)/(2 (4 pi)^(d/2) Gamma(d/2)) (Gamma(1 - d/2) Gamma(d/2))/Gamma(1 - d/2 + d/2) \
  & = -(i m^(d-2) lambda)/(2 (4 pi)^(d/2)) Gamma(1 - d/2).
$
To finally bring out the divergence, we expand $Gamma(1 - d/2) = Gamma(-1 + epsilon/2)$ around $epsilon = 0$
$ Gamma(-1 + epsilon/2) = 1/(-1 + epsilon/2) Gamma(epsilon/2) = -1/(1 - epsilon/2) (2/epsilon - gamma + underbrace(O(epsilon), "vanishing as" epsilon -> 0)) = -(2/epsilon - gamma + 1 + O(epsilon)). $
Thus, resetting $d = 4$ and letting $1/epsilon$ diverge, we find
$
  #tadpole & = (i m^2 lambda)/(16 pi^2) (1/epsilon - gamma/2 + 1/2) quad "and" \
  -i M^2 (p^2)|_"1-loop" & = #tadpole + #ct-prop = (i m^2 lambda)/(16 pi^2) (1/epsilon - gamma/2 + 1/2) + i(p^2 delta_Z^((1)) - delta_m^((1))).
$
We can use the above expression to implement our renormalization conditions and find explicit terms for $delta_Z^((1))$ and $delta_m^((1))$:
$
  dif/(dif p^2) M^2 (p^2)|_(p^2 = m^2)^"1-loop" & = -delta_Z^((1)) attach(=, t: !) 0 quad && ==> quad delta_Z^((1)) = 0, \
  M^2 (p^2)|_(p^2 = m^2)^"1-loop" & = -(m^2 lambda)/(16 pi^2) (1/epsilon - gamma/2 + 1/2) + delta_m^((1)) attach(=, t: !) 0 quad && ==> quad delta_m^((1)) = (m^2 lambda)/(16 pi^2) (1/epsilon - gamma/2 + 1/2).
$
Notice that at 1-loop $M^2 (p^2) = 0 thick forall p$. Non-trivial corrections to the propagator only start to appear at the 2-loop order.

#task(label: "b")[the vertex, i.e. the two-particle scattering amplitude $i cal(M)(p_1 p_2 -> p_3 p_4)$.]

$
  i cal(M)(p_1 p_2 -> p_3 p_4) & = #fd(s: 0.85, {
    draw.line((-0.75, -0.75), (0, 0), mark: (end: ">", fill: black, scale: 0.6))
    draw.line((0.75, -0.75), (0, 0), mark: (end: ">", fill: black, scale: 0.6))
    draw.line((0, 0), (-0.75, 0.75), mark: (end: ">", fill: black, scale: 0.6))
    draw.line((0, 0), (0.75, 0.75), mark: (end: ">", fill: black, scale: 0.6))
    hblob((0, 0), r: 0.25)
    lbl((-0.95, -0.9), $p_1$)
    lbl((0.95, -0.9), $p_2$)
    lbl((-0.95, 0.9), $p_3$)
    lbl((0.95, 0.9), $p_4$)
  }) = #vertex + (#bubble("s") + #bubble("t") + #bubble("u")) + #ct-vertex + dots.c \
  & = -i lambda + (-i lambda)^2 (i V(s) + i V(t) + i V(u)) - i delta_lambda + O(lambda^3)
$
up to one-loop order, where $s$, $t$ and $u$ are the Mandelstam variables. This time, we proceed to calculating all relevant contributions immediately. The first and last diagram require no computation as they were each awarded their own Feynman rules, setting their value to $-i lambda$ and $-i delta_lambda$, respectively. The other three diagrams appearing at this level in renormalized perturbation theory are, in this order, $s$-, $t$-, and $u$-channel scalar-scalar scattering. Their contributions are identical,
$
  #fd({
    draw.circle((0, 0), radius: 0.4)
    draw.line((0, 0.4), (-0.95, 0.8))
    draw.line((0, 0.4), (0.95, 0.8))
    draw.line((0, -0.4), (-0.95, -0.8))
    draw.line((0, -0.4), (0.95, -0.8))
    arr((-0.4, 0.06), (-0.4, -0.06))
    arr((0.4, -0.06), (0.4, 0.06))
    arr((0, -1.1), (0, -0.75))
    draw.content((-0.5, 0), anchor: "east", text(size: 7pt, $k$))
    draw.content((0.5, 0), anchor: "west", text(size: 7pt, $p + k$))
    lbl((0.18, -0.95), $p$)
  }) = 1/2 (-i lambda)^2 integral (dd(d, k))/(2 pi)^d i/(k^2 - m^2 + i epsilon) i/((p + k)^2 - m^2 + i epsilon) =: (-i lambda)^2 i V(p^2),
$
except that $p^2$ is in turn $s = p^2 = (p_1 + p_2)^2$, $t = p^2 = (p_1 - p_3)^2$, $u = p^2 = (p_1 - p_4)^2$. So we need to calculate $V(p^2)$. This computation follows the standard procedure of introducing a Feynman parameter, shifting the integration variable, Wick rotating to Euclidean space and finally performing the momentum integral.
$ V(p^2) = i/2 integral_0^1 dd(x) integral (dd(d, k))/(2 pi)^d 1/[x((p + k)^2 - m^2 + i epsilon) + (1 - x)(k^2 - m^2 + i epsilon)]^2. $
We can simplify the denominator and complete the square in $k$,
$
  & x p^2 + 2 x p k + x(k^2 - m^2 + i epsilon) + k^2 - m^2 + i epsilon - x(k^2 - m^2 + i epsilon) \
  & = k^2 + 2 x p k + x^2 p^2 - x^2 p^2 + x p^2 - m^2 + i epsilon \
  & = (k + x p)^2 + x p^2 (1 - x) - m^2 + i epsilon =: l^2 - Delta,
$
so that with $dif l = dif k$ and unchanged boundaries, we get
$
  V(p^2) & = i/2 integral_0^1 dd(x) integral (dd(d, l))/(2 pi)^d 1/(l^2 - Delta)^2 attach(=, t: l_E^0 = -i l^0) -1/2 integral_0^1 dd(x) integral (dd(d, l_E))/(2 pi)^d 1/(l_E^2 + Delta)^2 \
  & = -1/(2 (2 pi)^d) integral_0^1 dd(x) integral dd(Omega_d) integral_0^oo dd(l_E) l_E^(d-1)/(l_E^2 + Delta)^2, quad "substitution:" y = Delta/(l_E^2 + Delta), quad dif y = (-2 Delta l_E)/(l_E^2 + Delta)^2 dif l_E \
  & = -1/(2 (2 pi)^d) integral_0^1 dd(x) (2 pi^(d/2))/Gamma(d/2) integral_0^1 l_E^(d-1)/(l_E^2 + Delta)^2 (l_E^2 + Delta)^2/(2 Delta l_E) dif y = -1/(2 (4 pi)^(d/2) Gamma(d/2)) integral_0^1 dd(x) integral_0^1 dd(y) underbrace(l_E^(d-2), (Delta(1/y - 1))^(d/2 - 1))/Delta \
  & = -1/(2 (4 pi)^(d/2) Gamma(d/2)) integral_0^1 dd(x) Delta^(d/2 - 2) underbrace(integral_0^1 dd(y) y^(1 - d/2) (1 - y)^(d/2 - 1), Gamma(2 - d/2) Gamma(d/2) \/ Gamma(2 - d/2 + d/2)) \
  & = -Gamma(2 - d/2)/(2 (4 pi)^(d/2)) integral_0^1 (dif x)/(m^2 - x(1 - x) p^2)^(2 - d/2) attach(=, t: d = 4 - epsilon) -Gamma(epsilon/2)/(2 (4 pi)^(2 - epsilon/2)) integral_0^1 (m^2 - x(1 - x) p^2)^(-epsilon/2) dif x.
$
Here we use $Gamma(epsilon/2) = 2/epsilon - gamma + O(epsilon)$ and
$ x^(-epsilon/2) = e^(-epsilon/2 ln(x)) = 1 - epsilon/2 ln(x) + O(epsilon^2) $
to obtain
$ V(p^2) = -1/(32 pi^2) integral_0^1 dd(x) (2/epsilon - gamma + ln(4 pi) - ln(m^2 - x(1 - x) p^2) + O(epsilon)). $
At this point, we need to decide on a renormalization condition that yields a finite $i cal(M)(p_1 p_2 -> p_3 p_4)$, as $V(p^2)$ is clearly divergent when $d -> 4$, $epsilon -> 0$. We go with setting $lambda$ equal to the magnitude of the scattering amplitude at zero momentum, i.e.
$ (#full-vertex)_"amputated" = -i lambda quad "at" p_1 = p_2 = p_3 = p_4 = 0 quad ==> quad s = 4 m^2, t = u = 0. $
Inserting what we learned about the contributions to the scattering at 1-loop, this condition amounts to
$ i cal(M)|_"1-loop" = -i lambda + (-i lambda)^2 (i V(s = 4 m^2) + i V(t = 0) + i V(u = 0)) - i delta_lambda attach(=, t: !) -i lambda, $
at $s = 4 m^2$, $t = u = 0$. Therefore
$
  delta_lambda & = (-i lambda)^2 (V(4 m^2) + 2 V(0)) \
  & = lambda^2/(32 pi^2) integral_0^1 dd(x) (6/epsilon - 3 gamma + 3 ln(4 pi) - ln(m^2 - x(1 - x) 4 m^2) - 2 ln(m^2)).
$
If we reinsert this expression into our divergent amplitude $i cal(M)(p_1 p_2 -> p_3 p_4)$, it precisely picks up this divergence rendering our amplitude finite for all momenta, at least at the 1-loop order:
$
  i cal(M)(p_1 p_2 -> p_3 p_4)|_"1-loop" & = -i lambda + (-i lambda)^2 (i V(s) + i V(t) + i V(u)) - i delta_lambda \
  & = -i lambda - (i lambda^2)/(32 pi^2) integral_0^1 dd(x) (ln((m^2 - x(1 - x) s)/(m^2 - x(1 - x) 4 m^2)) \
  & quad + ln((m^2 - x(1 - x) t)/m^2) + ln((m^2 - x(1 - x) u)/m^2)).
$

= Problem 7.2 (Field strength renormalization in $phi^4$-theory)

#let sunset = fd({
  draw.line((-1, 0), (1, 0))
  draw.circle((0, 0), radius: 0.45)
})
#let ct-tadpole = fd({
  draw.line((-0.9, 0), (0.9, 0))
  draw.circle((0, 0.4), radius: 0.3)
  otimes((0, 0.06), r: 0.13)
})

#task[
  The two-loop contribution to the propagator in $phi^4$-theory involves the three diagrams
  $ #sunset + #ct-prop + #ct-tadpole. $
  Compute the first of these diagrams in the limit of zero mass for the scalar field using dimensional regularization. Show that near $d = 4$, this diagram takes the form
  $ #sunset = -i p^2 lambda^2/(12 (4 pi)^4) (-1/epsilon + ln(p^2) + O(epsilon)) =: S, $
  where $epsilon = 4 - d$. The coefficient in this equation involves a Feynman parameter integral that can be evaluated by setting $d = 4$. Verify that the third diagram in the above sum vanishes at $d = 4$ (and $m -> 0$ as before). Thus the first diagram should contain only a pole only at $epsilon = 0$, which can be cancelled by a field strength renormalization counterterm $delta_Z$.
]

$
  S & = #fd(s: 0.9, {
    draw.line((-1.1, 0), (1.1, 0))
    draw.circle((0, 0), radius: 0.5)
    arr((-0.9, 0), (-0.7, 0))
    arr((0.7, 0), (0.9, 0))
    arr((-0.06, 0.5), (0.06, 0.5))
    arr((-0.06, 0), (0.06, 0))
    arr((-0.06, -0.5), (0.06, -0.5))
    lbl((-1.1, 0.2), $p$)
    lbl((1.1, 0.2), $p$)
    lbl((0, 0.7), $k_1$)
    lbl((0.25, 0.15), $k_2$)
    lbl((0, -0.72), $p - k_1 - k_2$)
  }) = 1/3! (-i lambda)^2 integral (dd(d, k))/(2 pi)^d integral (dd(d, q))/(2 pi)^d i/(k^2 - m^2 + i epsilon) i/(q^2 - m^2 + i epsilon) i/((p - k - q)^2 - m^2 + i epsilon) \
  & = (i lambda^2)/6 integral (dd(d, k_E))/(2 pi)^d i/(k_E^2 + m^2) underbrace(integral (dd(d, q_E))/(2 pi)^d i/(q_E^2 + m^2) i/((p - k_E - q_E)^2 + m^2), 2 i V((p - k_E)^2)", for" V(p^2) "as defined in problem 7.1 b)") \
  & = (i lambda^2)/6 integral (dd(d, k_E))/(2 pi)^d i/(k_E^2 + m^2) 2 i (-Gamma(2 - d/2)/(2 (4 pi)^(d/2)) integral_0^1 (dif x)/[m^2 - x(1 - x)(p_E - k_E)^2]^(2 - d/2)) \
  & = (i lambda^2 Gamma(2 - d/2))/(6 (4 pi)^(d/2)) integral_0^1 dd(x) integral (dd(d, k_E))/(2 pi)^d 1/(k_E^2 + m^2) 1/[m^2 - x(1 - x)(p_E - k_E)^2]^(2 - d/2) \
  & = (i lambda^2 Gamma(2 - d/2))/(6 (4 pi)^(d/2)) integral_0^1 dd(x) integral (dd(d, k_E))/(2 pi)^d Gamma(1 + 2 - d/2)/Gamma(2 - d/2) integral_0^1 dd(y) integral_0^1 dd(z) (delta(y + z - 1) y^0 z^(1 - d/2))/[y(k_E^2 + m^2) + z(m^2 - x(1 - x)(p_E - k_E)^2)]^(3 - d/2) \
  & = (i lambda^2 Gamma(3 - d/2))/(6 (4 pi)^(d/2)) integral_0^1 dd(x) integral_0^1 dd(y) integral (dd(d, k_E))/(2 pi)^d ([x(1 - x)]^(d/2 - 2) (1 - y)^(1 - d/2))/[(k_E - y p_E)^2 + y(1 - y) p_E^2 + (1 - y + y/(x(1 - x))) m^2]^(3 - d/2) \
  & = (i lambda^2)/(6 (4 pi)^d) integral_0^1 dd(x) integral_0^1 dd(y) (Gamma(3 - d) [x(1 - x)]^(d/2 - 2) (1 - y)^(d/2 - 2))/[y(1 - y) p_E^2 + (1 - y + y/(x(1 - x))) m^2]^(3 - d).
$
At this stage, we set $m = 0$ and take the limit $d = 4 - epsilon -> 4$.
$
  S & = (i lambda^2)/(12 (4 pi)^4) Gamma(-1 + epsilon) (p_E^2)^(1 - epsilon) + dots = -(i lambda^2)/(12 (4 pi)^4) p_E^2 [1/epsilon - log(p_E^2) + dots] \
  & = (i lambda^2)/(12 (4 pi)^4) p^2 [1/epsilon - log(p^2) + dots].
$
Under these same circumstances ($d = 4 - epsilon -> 4$, $m = 0$), we find for the third diagram
$
  P & = #fd(s: 0.9, {
    draw.line((-1, 0), (1, 0))
    draw.line((-0.75, 0), (-0.5, 0), mark: (end: ">", fill: black, scale: 0.5))
    draw.line((0.5, 0), (0.75, 0), mark: (end: ">", fill: black, scale: 0.5))
    draw.circle((0, 0.4), radius: 0.3)
    otimes((0, 0.06), r: 0.13)
    lbl((-0.6, -0.22), $p$)
    lbl((0.6, -0.22), $p$)
    lbl((0, 0.88), $k$)
  }) = -i/2 delta_lambda integral (dd(d, k))/(2 pi)^d i/(k^2 - m^2 + i epsilon) = -i/2 delta_lambda integral (dd(d, k_E))/(2 pi)^d 1/(k_E^2 + m^2) \
  & = -i/2 delta_lambda 1/(4 pi)^(d/2) Gamma(1 - d/2)/(m^2)^(1 - d/2) prop m = 0 quad "for" d = 4.
$
Further, in the case of $m = 0$, the second diagram becomes just
$ #ct-prop = i(p^2 delta_Z - delta_m) attach(-->, t: m = 0) i p^2 delta_Z. $
Thus the first diagram $S$ contains a pole only at $epsilon = 0$, which we cancel by a field strength renormalization counterterm of
$ delta_Z = -lambda^2/(12 (4 pi)^4) [1/epsilon - log(m^2)], $
such that $dif/(dif p^2) M^2 (p^2)|_(p^2 = m^2) attach(=, t: !) 0$.
