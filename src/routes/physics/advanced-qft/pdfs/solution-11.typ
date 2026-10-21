#import "/notes.typ": dd, notes, tagged, task
#import "@preview/cetz:0.5.2": canvas, decorations, draw

#show: notes.with(
  title: [Quantum Field Theory II -- Assignment 11],
  subtitle: [Exercise sheet 11, Advanced QFT, Prof. Jürgen Berges],
  date: [Solutions by Janosh Riebesell, 04.07.2015],
)

// Feynman slash
#let sl(body) = math.cancel(body, length: 90%, angle: 30deg)
#let ex(body) = $chevron.l body chevron.r$

// Feynman diagrams
#let diag(body, baseline: 50%, length: 1cm) = box(baseline: baseline, inset: (y: 2pt), canvas(length: length, {
  import draw: *
  set-style(stroke: 0.7pt)
  body
}))
// fermion line with an arrow at its midpoint
#let fline(a, b) = {
  let m = ((a.at(0) + b.at(0)) / 2, (a.at(1) + b.at(1)) / 2)
  draw.line(a, m, mark: (end: ">", fill: black, scale: 0.5))
  draw.line(m, b)
}
// gauge boson (wavy) line
#let gline(a, b) = decorations.wave(draw.line(a, b), amplitude: 0.07, segment-length: 0.16)
// momentum arrow drawn parallel to a line, offset to its left (o > 0) or right (o < 0)
#let mom(a, b, label, o: 0.18, anchor: auto) = {
  let (dx, dy) = (b.at(0) - a.at(0), b.at(1) - a.at(1))
  let n = calc.sqrt(dx * dx + dy * dy)
  let (nx, ny) = (-dy / n * o, dx / n * o)
  let s = (a.at(0) + 0.3 * dx + nx, a.at(1) + 0.3 * dy + ny)
  let e = (a.at(0) + 0.7 * dx + nx, a.at(1) + 0.7 * dy + ny)
  draw.line(s, e, mark: (end: ">", fill: black, scale: 0.4), stroke: 0.5pt)
  let c = (a.at(0) + 0.5 * dx + 2 * nx, a.at(1) + 0.5 * dy + 2 * ny)
  draw.content(c, text(size: 7pt, label))
}
#let lbl(pt, body, anchor: "center") = draw.content(pt, text(size: 7pt, body), anchor: anchor)

= Problem 11.1 (Critical exponents)

#task[
  Consider massive $phi^4$-theory with mass $m$ and quartic coupling $lambda$ in $d$ dimensions. One defines the dimensionless quantity $g_m = m \/ mu$ in terms of the renormalization scale $mu$. Following the general logic for the RG flow of dimensionful operators as discussed in the lecture, it satisfies the renormalization group equation
  #tagged(2, $ mu dif/(dif mu) g_m = beta_m, quad beta_m = (-2 + gamma_(phi^2)) g_m, $)
  where $gamma_(phi^2) = lambda/(16 pi^2)$ at one-loop order.
]

#task(label: "a")[
  Show that near a renormalization group fixed point $lambda^*$, $g_m$ takes the form
  #tagged(3, $ g_m (lambda(mu)) = g_m (lambda^*) (mu/mu^*)^(-1/nu), $)
  where you should give the general form of $nu$.
]

Near a renormalization group fixed point, we have a decreased scale dependence in the RG flow parameter, in this case $g_m$. Consequently, inserting for $gamma_(phi^2)$ the result at one-loop order is a good approximation and so near a fixed point $lambda^* = lambda(mu^*)$,
$ beta_m = (-2 + lambda^* /(16 pi^2)) g_m. $
Plugging $beta_m (lambda^*)$ into eq. (2) gives a first order differential equation
$ mu dif/(dif mu) g_m (lambda(mu)) = (-2 + lambda^* /(16 pi^2)) g_m, $
which we can solve by separating the variables and integrating:
$ integral_(mu^*)^mu (dif g_m (lambda(mu')))/(g_m (lambda(mu'))) = integral_(mu^*)^mu (dif mu')/mu' (-2 + lambda^* /(16 pi^2)) quad ==> quad ln((g_m (lambda(mu)))/(g_m (lambda^*))) = (-2 + lambda^* /(16 pi^2)) ln(mu/mu^*). $
We exponentiate and solve for $g(lambda(mu))$,
$ g(lambda(mu)) = g(lambda^*) (mu/mu^*)^(-2 + lambda^* /(16 pi^2)), $
from which we read off
$ nu = 1/(2 - lambda^* /(16 pi^2)). $

#task(label: "b")[Give the mass dimension of the coupling $lambda$ in $d$ dimensions and define the appropriate dimensionless coupling $g_lambda$. Give its renormalization group equation and its $beta$-function. Use this to determine the location of a non-trivial IR fixed point $lambda^*$ if $d < 4$. What happens to this fixed point if $d = 4$ and if $d > 4$?]

The $lambda phi^4$-theory Lagrangian reads
$ cal(L) = 1/2 partial_mu phi partial^mu phi - 1/2 m^2 phi^2 - lambda/4! phi^4. $
Since $0 = [S] = [dd(d, x)] + [cal(L)] = -d + [cal(L)]$, the Lagrangian has mass dimension $d$ and consequently the fields have
$ d = 2 [partial_mu] + 2 [phi] = 2 + 2 [phi] quad ==> quad [phi] = (d - 2)/2. $
Thus the coupling's dimension depends on the dimension like
$ d = [lambda] + 4 [phi] = [lambda] + 2 (d - 2) quad ==> quad [lambda] = d - 2 (d - 2) = 4 - d. $
To achieve a dimensionless $g_lambda$, we define it as
$ g_lambda = lambda/mu^(4 - d). $
Its renormalization group equation can be written as
$ mu dif/(dif mu) g_lambda = beta_lambda, $
which produces the following beta function,
$
  beta_lambda & = mu dif/(dif mu) (lambda(mu))/mu^(4 - d) = mu (d - 4) (lambda(mu))/mu^(5 - d) + mu/mu^(4 - d) (dif lambda(mu))/(dif mu) \
  & = (d - 4) g_lambda + mu/lambda g_lambda (dif lambda(mu))/(dif mu) = \(d - 4 + underbrace(mu dif/(dif mu) ln(lambda), gamma_lambda)\) g_lambda,
$
where $gamma_lambda = (3 g_lambda)/(16 pi^2)$ (according to the lecture notes, eq. (8.104)).

If $d < 4$, $beta_lambda$ starts negative for small values of $lambda$ but hits zero at
$ d - 4 + (3 g_lambda^*)/(16 pi^2) = 0 quad ==> quad g_lambda^* = (16 pi^2)/3 (4 - d) $
and since $g_lambda -> g_lambda^*$ as $mu -> 0$, this is a non-trivial IR fixed point, known as the Wilson-Fisher fixed point.

In $d = 4$, $beta_lambda = (3 g_lambda^2)/(16 pi^2) = (3 lambda^2)/(16 pi^2)$, which is zero only for $lambda^* = 0$. Thus, at $d = 4$ the fixed point has become trivial.

In $d > 4$, $g_lambda^*$ must be negative for $beta_lambda$ to be zero. However, from $[lambda] = 4 - d < 0$, we know that $lambda phi^4$-theory in $d > 4$ is non-renormalizable in any case.

#task(label: "c")[
  Argue that in a free scalar theory, the correlation length $xi$ is given by $xi = 1/m$. _Hint:_ Show that $ex(phi(x) phi(0)) approx e^(-|arrow(x)| \/ xi)$. More generally, one defines the correlation length via
  $ xi = mu^* /p_0 quad "with" quad g_m (p_0) = 1. $
  Deduce that near a fixed point $lambda^*$ the correlation length is given by $xi = (g_m (mu^*))^(-nu)$. Evaluate $nu$ explicitly for the above fixed point in $d < 4$ dimensions.
]

The calculation required to show this was already performed in QFT I in the context of Yukawa theory in order to obtain its potential $V(r) = -g^2/(4 pi) 1/r e^(-m_phi r)$. That in mind, we allow ourselves to be brief here. Firstly, we note that $ex(phi(x) phi(y))$ is just the free propagator $D(x - y)$:
$
  ex(phi(x) phi(0)) = D(x) & = integral (dd(3, p))/(2 pi)^3 e^(-i p x)/(2 E_p) = e^(-i E_p t)/(2 (2 pi)^3) integral dd(3, p) e^(i arrow(p) dot arrow(x))/sqrt(|arrow(p)|^2 + m^2) \
  & = e^(-i E_p t)/(8 pi^2) integral_0^oo dd(p) |arrow(p)|^2 (e^(i |arrow(p)| |arrow(x)|) - e^(-i |arrow(p)| |arrow(x)|))/(i |arrow(p)| |arrow(x)|) 1/sqrt(|arrow(p)|^2 + m^2) \
  & = e^(-i E_p t)/(8 pi^2 i |arrow(x)|) integral_(-oo)^oo dd(p) (|arrow(p)| e^(i |arrow(p)| |arrow(x)|))/sqrt(|arrow(p)|^2 + m^2).
$
This can be evaluated as a complex contour integral by deforming the integration into the upper complex plane, where it wraps around the branch cut starting at $|arrow(p)| = +i m$. In the end, setting w.l.o.g. $t = 0$, we get for large $|arrow(x)|$
$ ex(phi(x) phi(0)) prop e^(-m |arrow(x)|) = e^(-|arrow(x)| \/ xi), quad "if" xi = 1/m. $
We go on to show that $xi = g_m^(-nu) (mu^*)$ by using eq. (3), i.e.
$ g_m (lambda(mu)) = g_m (lambda^*) (mu/mu^*)^(-1/nu) quad ==> quad mu^* /mu = ((g_m (mu^*))/(g_m (lambda(mu))))^(-nu) $
to rewrite
$ xi = mu^* /p_0 = ((g_m (mu^*))/(g_m (p_0)))^(-nu) = g_m^(-nu) (mu^*), quad "since" g_m (p_0) = 1. $
At the Wilson-Fisher fixed point of part b), $gamma_(phi^2) = g_lambda^* \/ (16 pi^2) = (4 - d)/3$, so that by part a)
$ nu = 1/(2 - gamma_(phi^2)) = 1/(2 - (4 - d)/3) = 3/(d + 2), $
e.g. $nu = 3/5$ in $d = 3$ dimensions.

#task(label: "d")[According to Landau theory, a ferromagnet can be described by a 3-dim. Euclidean field theory of the form $cal(L) = 1/2 (nabla M)^2 + b (T - T_c) M^2 + c M^4$. Argue that near $T_c$ the correlation length $xi$ diverges.]

$ phi <--> M, quad m^2/2 <--> b (T - T_c), quad lambda/4! <--> c quad --> quad xi = 1/m prop (T - T_c)^(-1/2) attach(-->, t: T -> T_c) oo. $

= Problem 11.2 (Fermion-anti-fermion annihilation in Yang-Mills theory at tree-level)

#task[
  We consider annihilation of one fermion with momentum $p_2$ and one anti-fermion with momentum $p_1$ (and both of mass $m$) into two gauge bosons with polarization (vectors) $epsilon_mu^a (k_1)$ and $epsilon_nu^b (k_2)$ at tree-level in Yang-Mills theory. Proceed as in fig. 1. Let
  #tagged(6, $ i M = i M^(mu nu) epsilon_mu^(*a) (k_1) epsilon_nu^(*b) (k_2) $)
  denote the amplitude, where we have explicitly factored out the dependence on the outgoing gauge boson polarizations. In the sequel, we will suppress the colour index in the polarization vectors.
]

#task(label: "a")[
  Use the Feynman rules as stated in the lecture to compute the sum of the first two diagrams. Show that if the second outgoing gauge boson is in polarization state $epsilon_mu (k_2) = (k_2)_mu$, this expression becomes
  #tagged(7, $ i M^(mu nu) epsilon_mu^* (k_1) (k_2)_nu = (-i g)^2 overline(v)(p_1) (-i gamma^mu [t_r^a, t_r^b]) u(p_2) epsilon_mu^* (k_1). $)
  _Hint:_ Use that $(gamma dot p_2 - m) u(p_2) = 0 = overline(v)(p_1) (-gamma dot p_1 - m)$.
]

To construct a theory of Yang-Mills vector fields interacting with fermions, we add the gauge field Lagrangian
$ cal(L)_"GF" = -1/4 (F_(mu nu)^a)^2, quad "where" a in {1, 2, ..., dim(G)}, $
to the Dirac Lagrangian, in which we replace ordinary derivatives by covariant ones,
$ cal(L)_D = overline(psi) (i gamma dot D - m) psi, $
to arrive at the Yang-Mills Lagrangian (which looks strikingly similar to the one of QED),
$ cal(L)_"YM" = -1/4 (F_(mu nu)^a)^2 + overline(psi) (i sl(D) - m) psi. $
The important difference to QED is that since the Yang-Mills vector field $A_mu^a$ is non-abelian, the field strength tensor carries an extra term
$ F_(mu nu)^a = partial_mu A_nu^a - partial_nu A_mu^a + g f^(a b c) A_mu^b A_nu^c, $
where $f^(a b c)$ are the structure constants of $G$. They are independent of the particular representation $r$ chosen for $G$. The covariant derivative, however, is defined in terms of the representation matrices $t_r^a$, $a in {1, 2, ..., dim(G)}$:
$ D_mu = partial_mu - i g A_mu^a t_r^a. $
To give a comprehensive list of Feynman rules for Yang-Mills theory, we first derive the propagators and then expand the Lagrangian to investigate the interaction terms. The fermion propagator is given by
$ ex(psi_(alpha i) (x) overline(psi)_(beta j) (y)) = integral (dd(4, p))/(2 pi)^4 (i/(sl(p) - m))_(alpha beta) delta_(i j) e^(-i p (x - y)), $
with $alpha, beta$ Dirac indices, and $i, j in {1, 2, ..., dim(r)}$ indices of the representation $r$. The propagator of the vector fields is
$ ex(A_mu^a (x) A_nu^b (y)) = integral (dd(4, k))/(2 pi)^4 ((-i g_(mu nu))/k^2) delta^(a b) e^(-i k (x - y)), $
where again $a, b in {1, 2, ..., dim(G)}$. To derive Feynman rules for the vertices, we look for terms beyond quadratic order in the fields:
$
  cal(L)_"YM" & = -1/4 F_(mu nu)^a F^(a mu nu) + overline(psi) (i sl(partial) + g sl(A)^a t_r^a - m) psi \
  & = -1/4 (partial_mu A_nu^a - partial_nu A_mu^a)(partial^mu A^(a nu) - partial^nu A^(a mu)) - 1/2 (partial_mu A_nu^a - partial_nu A_mu^a) g f^(a b c) A^(b mu) A^(c nu) \
  & quad - 1/4 g^2 (f^(a b c) A_mu^b A_nu^c)(f^(a d e) A^(d mu) A^(e nu)) + overline(psi) (i sl(partial) - m) psi + g overline(psi) sl(A)^a t_r^a psi \
  & = -1/4 (F_("abel", mu nu)^a)^2 + overline(psi) (i sl(partial) - m) psi - g f^(a b c) (partial_mu A_nu^a) A^(b mu) A^(c nu) \
  & quad - 1/4 g^2 (f^(e a b) A_mu^a A_nu^b)(f^(e c d) A^(c mu) A^(d nu)) + g overline(psi) sl(A)^a t_r^a psi \
  & = cal(L)_"QED" + g A_mu^a overline(psi) gamma^mu t_r^a psi - g f^(a b c) (partial_mu A_nu^a) A^(b mu) A^(c nu) \
  & quad - 1/4 g^2 (f^(e a b) A_mu^a A_nu^b)(f^(e c d) A^(c mu) A^(d nu)).
$
The first non-linear term, $g A_mu^a overline(psi) gamma^mu t_r^a psi$, gives the fermion-gauge boson vertex. Multiplying with $i$ and dropping the fields, we get the Feynman rule of this diagrammatic component
$ i g gamma^mu t_r^a, $
which is a matrix acting on both the Dirac and gauge indices of the fermions.

The second non-linear term, $-g f^(a b c) (partial_mu A_nu^a) A^(b mu) A^(c nu)$, gives a three gauge boson vertex. In momentum space with all three momenta pointing inwards, this contributes a factor of
$ -i g f^(a b c) (-i k^nu) g^(mu rho), $
with $3!$ possible contractions of alternating sign due to the antisymmetry of $f^(a b c)$.

Finally, the last non-linear term leads to a four gauge boson vertex whose Feynman rule with the same convention of all momenta pointing inward reads
$ -1/4 g^2 f^(e a b) f^(e c d) g^(mu rho) g^(nu sigma), $
with $4!$ possible contractions of which sets of four are equal. Assembling all of the above and doing the possible contractions for the gauge boson vertex, we get the following complete list of Feynman rules for Yang-Mills theory in momentum space.

#let rule(body, rhs) = (diag(body), math.equation(math.display(rhs.body)))
#align(center, grid(
  columns: (auto, auto),
  column-gutter: 6pt,
  row-gutter: 12pt,
  align: (right + horizon, left + horizon),
  ..rule({
    fline((0, 0), (1.6, 0))
    mom((0, 0), (1.6, 0), $p$)
    lbl((0, 0), $alpha, i$, anchor: "east")
    lbl((1.6, 0), $beta, j$, anchor: "west")
  }, $= (i/(sl(p) - m))_(alpha beta) delta_(i j)$),
  ..rule({
    fline((-0.6, -0.45), (0, 0))
    fline((0, 0), (0.6, -0.45))
    gline((0, 0), (0, 0.7))
    lbl((0, 0.7), $a, mu$, anchor: "south")
  }, $= i g gamma^mu t_r^a$),
  ..rule({
    gline((0, 0), (1.6, 0))
    mom((0, 0), (1.6, 0), $k$, o: 0.22)
    lbl((0, 0), $a, mu$, anchor: "east")
    lbl((1.6, 0), $b, nu$, anchor: "west")
  }, $= (-i g_(mu nu))/k^2 delta^(a b)$),
  ..rule({
    gline((0, 0.8), (0, 0))
    gline((-0.75, -0.45), (0, 0))
    gline((0.75, -0.45), (0, 0))
    mom((0, 0.8), (0, 0), $k_1$, o: 0.2)
    mom((-0.75, -0.45), (0, 0), $k_2$, o: 0.22)
    mom((0.75, -0.45), (0, 0), $k_3$, o: 0.22)
    lbl((0, 0.8), $a, mu$, anchor: "south")
    lbl((-0.75, -0.45), $b, nu$, anchor: "east")
    lbl((0.75, -0.45), $c, rho$, anchor: "west")
  }, $= g f^(a b c) [g^(mu nu) (k_1 - k_2)^rho + g^(nu rho) (k_2 - k_3)^mu + g^(rho mu) (k_3 - k_1)^nu]$),
  ..rule({
    for (x, y, l) in ((-0.6, 0.6, $a, mu$), (0.6, 0.6, $b, nu$), (-0.6, -0.6, $c, rho$), (0.6, -0.6, $d, sigma$)) {
      gline((x, y), (0, 0))
      lbl((x, y), l, anchor: if x < 0 { "east" } else { "west" })
    }
  }, $= & -i g^2 [f^(a b e) f^(c d e) (g^(mu rho) g^(nu sigma) - g^(mu sigma) g^(nu rho)) + f^(a c e) f^(b d e) (g^(mu nu) g^(rho sigma) - g^(mu sigma) g^(nu rho)) \
    & + f^(a d e) f^(b c e) (g^(mu nu) g^(rho sigma) - g^(mu rho) g^(nu sigma))]$),
))

With these rules, we are finally equipped to compute some actual diagrams. The ones given in fig. 1 for fermion-anti-fermion annihilation at tree-level are

// fermion legs of the annihilation diagrams: anti-fermion p1 on the left, fermion p2 on the right
#let legs(l, r) = {
  fline(l, (-1.3, -1.1))
  fline((1.3, -1.1), r)
  mom((-1.3, -1.1), l, $p_1$, o: -0.2)
  mom((1.3, -1.1), r, $p_2$, o: 0.2)
}
#figure(
  grid(
    columns: 3,
    column-gutter: 1.2cm,
    align: bottom,
    diag({
      let (l, r) = ((-0.6, 0), (0.6, 0))
      legs(l, r)
      fline(r, l)
      mom(r, l, $q$, o: 0.2)
      gline(l, (-1.2, 1.1))
      gline(r, (1.2, 1.1))
      mom(l, (-1.2, 1.1), $k_1$, o: -0.2)
      mom(r, (1.2, 1.1), $k_2$, o: 0.2)
      lbl((-1.2, 1.1), $a, mu$, anchor: "south")
      lbl((1.2, 1.1), $b, nu$, anchor: "south")
    }),
    diag({
      let (l, r) = ((-0.6, 0), (0.6, 0))
      legs(l, r)
      fline(r, l)
      mom(r, l, $q'$, o: 0.2)
      gline(l, (1.3, 1.4))
      gline(r, (-1.3, 1.4))
      mom((-0.45, 0.75), (-1.3, 1.4), $k_1$, o: 0.2)
      mom((0.45, 0.75), (1.3, 1.4), $k_2$, o: -0.2)
      lbl((-1.3, 1.4), $a, mu$, anchor: "south")
      lbl((1.3, 1.4), $b, nu$, anchor: "south")
    }),
    diag({
      let (v, w) = ((0, -0.4), (0, 0.45))
      fline(v, (-1.1, -1.1))
      fline((1.1, -1.1), v)
      mom((-1.1, -1.1), v, $p_1$, o: -0.2)
      mom((1.1, -1.1), v, $p_2$, o: 0.2)
      gline(v, w)
      mom(v, w, $k_3$, o: -0.2)
      lbl((-0.12, 0.02), $c, rho$, anchor: "east")
      gline(w, (-1.1, 1.1))
      gline(w, (1.1, 1.1))
      mom(w, (-1.1, 1.1), $k_1$, o: 0.2)
      mom(w, (1.1, 1.1), $k_2$, o: 0.2)
      lbl((-1.1, 1.1), $a, mu$, anchor: "south")
      lbl((1.1, 1.1), $b, nu$, anchor: "south")
    }),
    [1], [2], [3],
  ),
  caption: [Diagrams contributing to fermion-anti-fermion annihilation into two gauge bosons.],
  supplement: [Fig.],
)

Using our above Feynman rules, we obtain the following expression for the sum of the first two diagrams ($t$- and $u$-channel), where the internal fermion carries momentum $q = p_2 - k_2 = k_1 - p_1$ and $q' = p_2 - k_1 = k_2 - p_1$, respectively (Dirac and colour indices contracted implicitly):
$
  i M_(1,2) & = (i g)^2 overline(v)(p_1) [gamma^mu t_r^a i/(sl(p)_2 - sl(k)_2 - m) gamma^nu t_r^b + gamma^nu t_r^b i/(sl(p)_2 - sl(k)_1 - m) gamma^mu t_r^a] u(p_2) epsilon_mu^(*a) (k_1) epsilon_nu^(*b) (k_2) \
  & = i M_(1,2)^(mu nu a b) epsilon_mu^(*a) (k_1) epsilon_nu^(*b) (k_2).
$
We now investigate $i M_(1,2)$ for the case that one of the gauge boson polarization vectors is given by $epsilon_nu^(*b) (k_2) = (k_2)_nu$:
$ i M_(1,2) = (i g)^2 overline(v)(p_1) [gamma^mu t_r^a i/(sl(p)_2 - sl(k)_2 - m) sl(k)_2 t_r^b + sl(k)_2 t_r^b i/(sl(p)_2 - sl(k)_1 - m) gamma^mu t_r^a] u(p_2) epsilon_mu^(*a) (k_1). $
Using now, as hinted, $(sl(p)_2 - m) u(p_2) = 0 = overline(v)(p_1) (sl(p)_1 + m)$, we can write $sl(k)_2 u(p_2) = -(sl(p)_2 - sl(k)_2 - m) u(p_2)$ and, since $k_2 - p_1 = p_2 - k_1$, $overline(v)(p_1) sl(k)_2 = overline(v)(p_1) (sl(p)_2 - sl(k)_1 - m)$. This exactly cancels the denominators,
$
  i M_(1,2) & = (i g)^2 overline(v)(p_1) [gamma^mu t_r^a (-i) t_r^b + t_r^b (i) gamma^mu t_r^a] u(p_2) epsilon_mu^(*a) (k_1) \
  & = -i (i g)^2 overline(v)(p_1) gamma^mu [t_r^a, t_r^b] u(p_2) epsilon_mu^(*a) (k_1).
$

#task(label: "b")[
  Use the Feynman rules to compute the third diagram and verify that again for the second outgoing gauge boson in polarization state $epsilon_mu^* (k_2) = (k_2)_mu$, the result is
  #tagged(8, $ i M^(mu nu) epsilon_mu^* (k_1) (k_2)_nu = g^2 overline(v)(p_1) gamma^mu u(p_2) epsilon_mu^* (k_1) f^(a b c) T^c $)
  provided we make the further assumption that the other gauge boson is transversely polarized, i.e. $epsilon_mu^* (k_1) (k_1)^mu = 0$. Show that the sum of all three diagrams cancels for the second outgoing gauge boson in polarization state $epsilon_mu^* (k_2) = (k_2)_mu$ and for $epsilon_mu^* (k_1) k_1^mu = 0$.
]

The third diagram's amplitude is
$
  i M_3 & = overline(v)_alpha^i (p_1) i g gamma^sigma t_r^d u_alpha^i (p_2) (-i g_(rho sigma))/k_3^2 delta^(c d) g f^(a b c) [g^(mu nu) (k_2 - k_1)^rho + g^(nu rho) (k_3 - k_2)^mu \
    & #h(12em) + g^(rho mu) (k_1 - k_3)^nu] epsilon_mu^(*a) (k_1) epsilon_nu^(*b) (k_2) \
  & = i g overline(v)(p_1) gamma_rho t_r^c u(p_2) (-i)/k_3^2 g f^(a b c) [g^(mu nu) (k_2 - k_1)^rho + g^(nu rho) (k_3 - k_2)^mu + g^(rho mu) (k_1 - k_3)^nu] epsilon_mu^(*a) (k_1) epsilon_nu^(*b) (k_2).
$
If we now insert $epsilon_nu^(*b) (k_2) = (k_2)_nu$, the term in brackets simplifies as follows
$
  & [g^(mu nu) (k_2 - k_1)^rho + g^(nu rho) (k_3 - k_2)^mu + g^(rho mu) (k_1 - k_3)^nu] (k_2)_nu \
  & = k_2^mu (k_2 - k_1)^rho + k_2^rho (k_3 - k_2)^mu + g^(rho mu) (k_1 - k_3) dot k_2 \
  & = (k_1 + k_3)^mu (2 k_1 + k_3)^rho - (k_1 + k_3)^rho (k_1 + 2 k_3)^mu - g^(rho mu) (k_1 - k_3) dot (k_1 + k_3) \
  & = 2 k_1^mu k_1^rho + k_1^mu k_3^rho + 2 k_1^rho k_3^mu + k_3^mu k_3^rho - k_1^rho k_1^mu - 2 k_1^rho k_3^mu - k_1^mu k_3^rho - 2 k_3^mu k_3^rho \
  & quad - g^(rho mu) k_1^2 + g^(rho mu) k_3^2 = g^(rho mu) k_3^2 - k_3^mu k_3^rho - g^(rho mu) k_1^2 + k_1^mu k_1^rho.
$
Further providing that the gauge boson of momentum $k_1$ is transversely polarized, i.e. $epsilon_mu^(*a) (k_1) k_1^mu = 0$, and using that as an external particle, it should be on-shell, i.e. $k_1^2 = 0$, the long bracket shrinks to just
$ (g^(mu rho) k_3^2 - k_3^mu k_3^rho - g^(mu rho) k_1^2 + k_1^mu k_1^rho) epsilon_mu^(*a) (k_1) = (g^(mu rho) k_3^2 - k_3^mu k_3^rho) epsilon_mu^(*a) (k_1). $
Reinsertion into the scattering amplitude $i M_3$ yields
$
  i M_3 & = i g overline(v)(p_1) gamma_rho t_r^c u(p_2) (-i)/k_3^2 g f^(a b c) (g^(mu rho) k_3^2 - k_3^mu k_3^rho) epsilon_mu^(*a) (k_1) \
  & = g overline(v)(p_1) gamma^mu f^(a b c) t_r^c u(p_2) epsilon_mu^(*a) (k_1),
$
where the second term vanishes because
$ overline(v)(p_1) gamma_rho u(p_2) k_3^mu k_3^rho = overline(v)(p_1) underbrace(sl(k)_3, -sl(p)_1 - sl(p)_2 + m - m) u(p_2) k_3^mu = [underbrace(overline(v)(p_1) (-sl(p)_1 - m), 0) - underbrace((sl(p)_2 - m) u(p_2), 0)] k_3^mu. $
Our result for $i M_3$ exactly cancels the contribution from $i M_(1,2)$, meaning that, at tree level, the fermion-anti-fermion annihilation scattering amplitude into one longitudinally and one transversely polarized gauge boson is zero.

#task(label: "c")[
  Now consider only the last diagram, which is absent in an abelian gauge theory. Evaluate it for the situation where $epsilon(k_1) = epsilon^+ (k_1)$ and $epsilon(k_2) = epsilon^- (k_2)$ and show that it takes the non-vanishing form
  #tagged(9, $ -i g overline(v)(p_1) gamma_rho t_r^c u(p_2) (-i)/k_3^2 g f^(a b c) k_1^rho (|arrow(k)_1|)/(|arrow(k)_2|). $)
  Here, the forward/backward light-like polarization vectors are defined as
  #tagged(10, $ epsilon^plus.minus (k) = (k^0, plus.minus arrow(k)). $)
  This demonstrates that in contrast to QED, in non-abelian Yang-Mills theory non-physical null states are produced in scattering. Why is this not a problem?
]

There is likely a mistake in this exercise. To arrive at eq. (9), the polarization vectors need to be defined as
$ epsilon^plus.minus (k) = 1/(sqrt(2) |arrow(k)|) (k^0, plus.minus arrow(k)). $
Taking our intermediate result for $i M_3$ from part b),
$ i M_3 = i g overline(v)(p_1) gamma_rho t_r^c u(p_2) (-i)/k_3^2 g f^(a b c) \(g^(mu rho) k_3^2 - underbrace(k_3^mu k_3^rho, "0, see b)") - g^(mu rho) underbrace(k_1^2, "0, on-shell") + k_1^mu k_1^rho\) (epsilon_mu^+ (k_1))/(sqrt(2) |arrow(k)_1|), $
where we already inserted $epsilon_mu^(*a) (k_1) = epsilon^+ (k_1)$ and $epsilon_nu^(*b) (k_2) = epsilon^- (k_2)$, but with our normalization, we find that the last term no longer vanishes. It now yields
$
  & i g overline(v)(p_1) gamma_rho t_r^c u(p_2) (-i)/k_3^2 g f^(a b c) k_1^rho/(sqrt(2) |arrow(k)_1|) 1/(sqrt(2) |arrow(k)_2|) underbrace(k_1^mu (k_1)_mu, (k_1^0)^2 + |arrow(k)_1|^2 = 2 |arrow(k)_1|^2) \
  & = i g overline(v)(p_1) gamma_rho t_r^c u(p_2) (-i)/k_3^2 g f^(a b c) k_1^rho (|arrow(k)_1|)/(|arrow(k)_2|).
$
This is not a problem because ghost loops exactly cancel the unphysical polarizations at every order in perturbation.
