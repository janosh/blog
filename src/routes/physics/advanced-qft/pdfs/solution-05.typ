#import "/notes.typ": dd, notes, tagged, task
#import "@preview/cetz:0.5.2": canvas, draw

#show: notes.with(
  title: [Quantum Field Theory II -- Assignment 5],
  subtitle: [Exercise sheet 5, Advanced QFT, Prof. Jürgen Berges],
  date: [Solutions by Janosh Riebesell, 16.05.2015],
)

// One-loop diagram of phi^4 theory: a loop with a vertex at each of the given angles,
// each vertex carrying two external legs.
#let loop-diagram(..angles, r: 0.55, leg: 0.75) = box(baseline: 40%, canvas(length: 1cm, {
  import draw: *
  set-style(stroke: 0.7pt)
  circle((0, 0), radius: r)
  let angles = angles.pos()
  let spread = if angles.len() == 1 { 90deg } else { 42deg }
  for a in angles {
    let v = (r * calc.cos(a), r * calc.sin(a))
    for s in (-spread, spread) {
      line(v, (v.at(0) + leg * calc.cos(a + s), v.at(1) + leg * calc.sin(a + s)))
    }
  }
}))
#let tadpole = loop-diagram(-90deg)
#let two-vertex = loop-diagram(180deg, 0deg)
#let three-vertex = loop-diagram(180deg, 0deg, 90deg)

= Problem 5.1 (Diagrammatic route to the Coleman--Weinberg potential)

#task[
  On assignment sheet 4, we looked at how to compute the Coleman--Weinberg potential to one loop for a $phi.alt^4$ theory using path integral techniques. This week, we compare this result to that computed from only using Feynman diagrams. Recalling that
  #tagged(1, $ S[phi.alt] = integral dd(4, x) (-1/2 phi.alt(x) (partial_x^2 + tilde(m)^2) phi.alt(x) - lambda/4! phi.alt^4 (x)). $)
]

#task(label: "a")[Draw all 1-loop diagrams of $phi.alt^4$ theory (with an arbitrary number of legs), up to order $lambda^3$.]

$ lambda: #tadpole #h(3em) lambda^2: #two-vertex #h(3em) lambda^3: #three-vertex $

#task(label: "b")[
  Show that
  #tagged(2, $ Gamma[phi.alt] approx S[phi.alt] - i ln integral cal(D) phi e^(-1/2 integral dd(x) dif y phi(x) G_0^(-1) (x, y; phi.alt) phi(y)) = S[phi.alt] + i/2 tr ln G_0^(-1) (phi.alt) $)
  with $G_0^(-1) (x, y; phi.alt) = i (partial_x^2 + m^2 + lambda/2 phi.alt^2 (x)) delta(x - y) equiv G_0^(-1) (x, y; phi.alt = 0) + i lambda/2 phi.alt^2 (x) delta(x - y)$.

  _Hint:_ You may recall that $ln(det A) = tr(ln A)$.
]

To obtain the second equality, we only need to show
$ -i ln integral cal(D) phi e^(-1/2 integral dd(x) dif y phi(x) G_0^(-1) (x, y; phi.alt) phi(y)) = i/2 tr ln(G_0^(-1) (phi.alt)). $
We use the result of exercise 3.2 d) to perform the path integral
$ integral cal(D) phi e^(-1/2 integral dd(x) dif y phi(x) G_0^(-1) (x, y; phi.alt) phi(y)) equiv integral cal(D) phi e^(-1/2 phi dot G_0^(-1) (phi.alt) dot phi) = sqrt(((2 pi)^n)/(det G_0^(-1) (phi.alt))), $
where $n = dim(cal(D) phi)$ is the dimensionality of the path integral measure. Reinserting this expression into what we want to show gives
$ -i ln sqrt(((2 pi)^n)/(det G_0^(-1) (phi.alt))) = i/2 ln(det G_0^(-1) (phi.alt)) - i/2 n ln(2 pi) = i/2 tr ln(G_0^(-1) (phi.alt)) - i/2 n ln(2 pi). $
Apparently, we obtain an extra term of $-i/2 n ln(2 pi)$ and thus cannot confirm eq. (2).

#task(label: "c")[
  Writing $ln(G_0^(-1) (phi.alt)) = ln(G_0^(-1) (0)) + ln(G_0 (0) G_0^(-1) (phi.alt))$ with
  #tagged(5, $ (G_0 (0) G_0^(-1) (phi.alt))(x, y) = delta(x - y) + G_0 (x, y; 0) i lambda/2 phi.alt^2 (y), $)
  expand the logarithm and identify your diagrams in part a) with the terms in your expansion.
]

The Taylor expansion to order $n$ of a function $f(x)$ at point $x = a$ is given by
$ T_n f(x)|_(x = a) = sum_(k=0)^n 1/k! (dif^k f(x))/(dif x^k)|_(x = a) (x - a)^k. $
The natural logarithm is expanded easiest by writing the argument as $x = 1 + y$, yielding
$ ln(1 + y) = sum_(n=1)^oo (-1)^(n+1)/n y^n. $
Thus, we find
$
  Gamma[phi.alt] & approx S[phi.alt] + i/2 underbrace(tr ln(G_0^(-1) (0)), (*)) + i/2 tr ln(delta + G_0 (0) i/2 lambda phi.alt^2) \
  & = S[phi.alt] + i/2 sum_(n=1)^oo (-1)^(n+1)/n tr[(G_0 (0) i/2 lambda phi.alt^2)^n] =: S[phi.alt] + I[phi.alt],
$
where $(*)$ needs to vanish, maybe because $= ln det[i (partial^2 + m^2)] = 0$.
Written out explicitly, $I[phi.alt]$ reads (due to the trace)
$
  I[phi.alt] & = i/2 sum_(n=1)^oo (-1)^(n+1)/n integral dd(x_1) dots.c integral dd(x_n) G_0 (x_1, x_2; 0) i/2 lambda phi.alt^2 (x_2) G_0 (x_2, x_3; 0) dots.c i/2 lambda phi.alt^2 (x_n) G_0 (x_n, x_1; 0) \
  & = -lambda/4 integral dd(x_1) G_0 (x_1, x_1; 0) phi.alt^2 (x_1) + (i lambda^2)/16 integral dd(x_1) integral dd(x_2) G_0 (x_1, x_2; 0) phi.alt^2 (x_2) G_0 (x_2, x_1; 0) phi.alt^2 (x_1) \
  & quad + lambda^3/48 integral dd(x_1) integral dd(x_2) integral dd(x_3) G_0 (x_1, x_2; 0) phi.alt^2 (x_2) G_0 (x_2, x_3; 0) phi.alt^2 (x_3) G_0 (x_3, x_1; 0) phi.alt^2 (x_1) + dots.c \
  & hat(=) #tadpole + #two-vertex + #three-vertex + dots.c,
$
where the last equivalence holds only up to symmetry factors.

#task(label: "d")[Verify that this indeed reproduces $V_"eff" = V^"tree" + V^"1-loop"$ of last week's assignment.]

In the referred-to problem 4.2, we were considering a constant background field, i.e. $phi.alt(x_i) = phi.alt_0 in RR thick forall i$. Inserting for the propagator
$ G(x_1, x_2; 0) = integral (dd(4, p_1))/(2 pi)^4 i/(p_1^2 - m^2 + i epsilon) e^(-i p_1 (x_1 - x_2)), $
we get
$
  #tadpole & = -lambda/4 integral dd(x_1) integral (dd(4, p_1))/(2 pi)^4 (i e^(-i p_1 (x_1 - x_1)))/(p_1^2 - m^2 + i epsilon) phi.alt_0^2 = -lambda/4 phi.alt_0^2 "Vol"_(RR^(1,3)) integral (dd(4, p_1))/(2 pi)^4 i/(p_1^2 - m^2 + i epsilon), \
  #two-vertex & = (i lambda^2)/16 integral dd(x_1) dif x_2 integral (dd(4, p_1))/(2 pi)^4 (i e^(-i p_1 (x_1 - x_2)))/(p_1^2 - m^2 + i epsilon) phi.alt_0^2 integral (dd(4, p_2))/(2 pi)^4 (i e^(-i p_2 (x_2 - x_1)))/(p_2^2 - m^2 + i epsilon) phi.alt_0^2 \
  & = (i lambda^2)/16 integral (dd(4, p_1))/(2 pi)^4 integral (dd(4, p_2))/(2 pi)^4 integral dd(x_1) integral dd(x_2) (i phi.alt_0^2)/(p_1^2 - m^2 + i epsilon) (i phi.alt_0^2)/(p_2^2 - m^2 + i epsilon) e^(i (p_2 - p_1) x_1) underbrace(e^(i (p_1 - p_2) x_2), integral -> (2 pi)^4 delta(p_1 - p_2)) \
  & = (i lambda^2)/16 phi.alt_0^4 "Vol"_(RR^(1,3)) integral (dd(4, p_1))/(2 pi)^4 (i/(p_1^2 - m^2 + i epsilon))^2, \
  #three-vertex & = lambda^3/48 phi.alt_0^6 "Vol"_(RR^(1,3)) integral (dd(4, p_1))/(2 pi)^4 (i/(p_1^2 - m^2 + i epsilon))^3.
$
Thus, reintroducing the infinite sum, we obtain
$
  Gamma[phi.alt] & approx S[phi.alt] + i/2 "Vol"_(RR^(1,3)) integral (dd(4, p))/(2 pi)^4 sum_(n=1)^oo (-1)^(n+1)/n (lambda/2 phi.alt_0^2 1/(-p^2 + m^2 - i epsilon))^n \
  & = S[phi.alt] + i/2 "Vol"_(RR^(1,3)) integral (dd(4, p))/(2 pi)^4 ln(underbrace(1 + lambda/2 phi.alt_0^2 1/(m^2 - p^2 - i epsilon), (m^2 - p^2 - i epsilon + lambda/2 phi.alt_0^2)/(m^2 - p^2 - i epsilon))).
$
The above is an intermediate result of problem 4.2 from right before the application of the residue theorem. We may proceed here in the same manner to reobtain our previous result of
$
  V_"eff" (phi.alt_0) & := -1/"Vol"_(RR^(1,3)) Gamma[phi.alt_0] approx V^"tree" (phi.alt_0) + V^"1-loop" (phi.alt_0) \
  & = V^"tree" (phi.alt_0) + 1/2 integral (dd(3, k))/(2 pi)^3 (sqrt(arrow(k)^2 + m^2 + lambda/2 phi.alt_0^2) - sqrt(arrow(k)^2 + m^2)).
$
