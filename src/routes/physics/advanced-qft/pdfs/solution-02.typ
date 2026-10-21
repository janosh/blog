#import "/notes.typ": dd, notes, tagged, task

#show: notes.with(
  title: [Quantum Field Theory II -- Assignment 2],
  subtitle: [Exercise sheet 2, Advanced QFT, Prof. Jürgen Berges],
  date: [Solutions by Janosh Riebesell, 27.04.2015 to 30.04.2015],
)

// path integral measure
#let Dm = $cal(D)$
#let bra(x) = $lr(chevron.l #x |)$
#let ket(x) = $lr(| #x chevron.r)$
#let Hh = $hat(H)$
#let qh = $hat(q)$
#let ph = $hat(p)$

= Problem 2.1 (Path integral and time-ordering)

#task[
  Show, by using the steps of the derivation of the path integral presented in the lecture, that
  #tagged(1, $ integral_(q(t_I) = q_I)^(q(t_F) = q_F) Dm q(t) Dm p(t) q(t_1) q(t_2) e^(i S[p, q]) = chevron.l q_F, t_F | T q_H (t_1) q_H (t_2) | q_I, t_I chevron.r. $)
  Put special emphasis on showing how the time-ordering appears.
]

$
  integral_(q(t_I) = q_I)^(q(t_F) = q_F) Dm q(t) Dm p(t) q(t_1) q(t_2) e^(i S[p, q]) & := integral_(q(t_I) = q_I)^(q(t_F) = q_F) Dm q(t) Dm p(t) q(t_1) q(t_2) e^(i integral_(t_I)^(t_F) dd(t) L(p, q)) \
  & = integral_(q(t_I) = q_I)^(q(t_F) = q_F) Dm q(t) Dm p(t) q(t_1) q(t_2) e^(i integral_(t_I)^(t_F) dd(t) (p dot(q) - H(p, q))) \
  & = lim_(N -> oo) integral (dif p_0) / (2 pi) product_(k=1)^N (dif p_k dif q_k) / (2 pi) q(t_1) q(t_2) e^(i sum_(k=0)^N [p_k (q_(k+1) - q_k) / (delta t) - H(p_k, overline(q)_k)] delta t),
$
where $q_0 equiv q_I$ and $q_(N+1) equiv q_F$. The derivative of $q$ became $dot(q) -> (q_(k+1) - q_k) / (delta t)$ for $delta t > 0$ discrete.
$ = lim_(N -> oo) integral (dif p_0) / (2 pi) product_(k=1)^N (dif p_k dif q_k) / (2 pi) q(t_1) q(t_2) e^(i sum_(k=0)^N p_k q_(k+1)) e^(-i sum_(k=0)^N p_k q_k) e^(-i sum_(k=0)^N H(p_k, 1/2 (q_k + q_(k+1))) delta t). $
We inserted $overline(q)_k = 1/2 (q_k + q_(k+1))$ when discretizing the time $t$ and now require $H(p, q)$ to decompose such that $H(p, q) = f(p) + V(q)$.
$ = lim_(N -> oo) integral dd(p_0) product_(k=1)^N dif p_k dif q_k q(t_1) q(t_2) product_(k=0)^N chevron.l q_(k+1) | p_k chevron.r chevron.l p_k | q_k chevron.r e^(-i sum_(k=0)^N f(p_k) delta t) e^(-i sum_(k=0)^N V(overline(q)_k) delta t), $
where we used $1 / sqrt(2 pi) e^(i p_k q_(k+1)) = chevron.l q_(k+1) | p_k chevron.r$ and $1 / sqrt(2 pi) e^(-i p_k q_k) = chevron.l p_k | q_k chevron.r$.
$
  & = lim_(N -> oo) integral dd(p_0) product_(k=1)^N dif p_k dif q_k q(t_1) q(t_2) product_(k=0)^N bra(q_(k+1)) e^(-i f(p_k) delta t) ket(p_k) bra(p_k) e^(-i V(q_k) delta t) ket(q_k) \
  & = lim_(N -> oo) integral dd(p_0) product_(k=1)^N dif p_k dif q_k q(t_1) q(t_2) product_(k=0)^N bra(q_(k+1)) e^(-i f(ph) delta t) ket(p_k) bra(p_k) e^(-i V(qh) delta t) ket(q_k) \
  & = lim_(N -> oo) integral product_(k=1)^N dif q_k q(t_1) q(t_2) product_(k=0)^N bra(q_(k+1)) e^(-i f(ph) delta t) e^(-i V(qh) delta t) #h(0.3em) ket(q_k).
$
Here, we insert a one in the form of $e^(1/2 [f(ph), V(qh)] delta t^2 + cal(O)(delta t^3))$ (to the right of $e^(-i V(qh) delta t)$), which vanishes when performing the limit $lim_(N -> oo)$. We can apply the Baker-Campbell-Hausdorff formula backwards to get
$
  integral_(q(t_I) = q_I)^(q(t_F) = q_F) Dm q(t) Dm p(t) q(t_1) q(t_2) e^(i S[p, q]) & = lim_(N -> oo) integral product_(k=1)^N dif q_k q(t_1) q(t_2) product_(k=0)^N bra(q_(k+1)) e^(-i f(ph) delta t) e^(-i V(qh) delta t) e^(1/2 [f(ph), V(qh)] delta t^2 + dots.c) ket(q_k) \
  & = lim_(N -> oo) integral product_(k=1)^N dif q_k q(t_1) q(t_2) product_(k=0)^N bra(q_(k+1)) e^(-i Hh delta t) ket(q_k).
$
Now follows the part where time-ordering is introduced. Since $q(t_1)$ and $q(t_2)$ are still simple functions, they can be commuted freely throughout the integral. The trick is to move them into the right spot within the product of $q$-eigenstates such that they act on the correct eigenstate to form an eigenvalue equation. Writing the two time orderings separately, the path integral equals
$
  t_1 > t_2: quad & lim_(N -> oo) integral product_(k=1)^N dif q_k product_(k=j+1)^N bra(q_(k+1)) e^(-i Hh delta t) ket(q_k) bra(q_(j+1)) e^(-i Hh delta t) underbrace(q(t_1) ket(q_j), qh_S ket(q_j) |_(t_1)) product_(k=i+1)^(j-1) bra(q_(k+1)) e^(-i Hh delta t) ket(q_k) \
  & #h(6em) times bra(q_(i+1)) e^(-i Hh delta t) underbrace(q(t_2) ket(q_i), qh_S ket(q_i) |_(t_2)) product_(k=0)^(i-1) bra(q_(k+1)) e^(-i Hh delta t) ket(q_k), \
  t_2 > t_1: quad & lim_(N -> oo) integral product_(k=1)^N dif q_k product_(k=j+1)^N bra(q_(k+1)) e^(-i Hh delta t) ket(q_k) bra(q_(j+1)) e^(-i Hh delta t) underbrace(q(t_2) ket(q_j), qh_S ket(q_j) |_(t_2)) product_(k=i+1)^(j-1) bra(q_(k+1)) e^(-i Hh delta t) ket(q_k) \
  & #h(6em) times bra(q_(i+1)) e^(-i Hh delta t) underbrace(q(t_1) ket(q_i), qh_S ket(q_i) |_(t_1)) product_(k=0)^(i-1) bra(q_(k+1)) e^(-i Hh delta t) ket(q_k).
$
$
  & = cases(
    bra(q_F) e^(-i Hh (t_F - t_1)) qh_S e^(-i Hh (t_1 - t_2)) qh_S e^(-i Hh (t_2 - t_I)) ket(q_I) quad & "for" t_1 > t_2,
    bra(q_F) e^(-i Hh (t_F - t_2)) qh_S e^(-i Hh (t_2 - t_1)) qh_S e^(-i Hh (t_1 - t_I)) ket(q_I) quad & "for" t_2 > t_1,
  ) \
  & = cases(
    bra(q_F) e^(-i Hh t_F) qh_H (t_1) qh_H (t_2) e^(i Hh t_I) ket(q_I) quad & "for" t_1 > t_2,
    bra(q_F) e^(-i Hh t_F) qh_H (t_2) qh_H (t_1) e^(i Hh t_I) ket(q_I) quad & "for" t_2 > t_1,
  ) \
  & = cases(
    chevron.l q_F\, t_F | qh_H (t_1) qh_H (t_2) | q_I\, t_I chevron.r quad & "for" t_1 > t_2,
    chevron.l q_F\, t_F | qh_H (t_2) qh_H (t_1) | q_I\, t_I chevron.r quad & "for" t_2 > t_1,
  ) quad = chevron.l q_F, t_F | T qh_H (t_1) qh_H (t_2) | q_I, t_I chevron.r.
$
Above, in the line where we performed all the $q$-integrals, $integral dd(q_k) ket(q_k) bra(q_k) = bb(1)$, we used that $delta t = T / (N + 1) = (t_F - t_I) / (N + 1)$, from which it follows that $(N - j) delta t = t_F - t_1$, $((j - 1) - i) delta t = t_1 - t_2$, etc.

We now move on to a shorter and more elegant proof of eq. (1) that is also more intrinsic to the path integral formulation. It works via dissection of the path integral. We operate here under the assumption that $t_F > t_1 > t_2 > t_I$ or $t_F > t_2 > t_1 > t_I$, i.e. that $t_1$ is truly larger/smaller than $t_2$. If $t_1 = t_2$, time-ordering is obsolete and there is nothing to show.
$ integral_(q(t_I) = q_I)^(q(t_F) = q_F) Dm q(t) Dm p(t) q(t_1) q(t_2) e^(i S[p, q]) := lim_(N -> oo) integral (dif p_0) / (2 pi) product_(k=1)^N (dif p_k dif q_k) / (2 pi) q(t_1) q(t_2) e^(i sum_(k=0)^N overbrace((p_k (q_(k+1) - q_k) / (delta t) - H(p_k, overline(q)_k)), = L(p_k, overline(q)_k)) delta t). $
The product $product_(k=1)^N$ we now split up at $j$ such that $t_j = t_I + j delta t$ lies between $t_2$ and $t_1$, e.g. $t_j = 1/2 (t_1 + t_2)$. This ensures that $q(t_2)$ and $q(t_1)$ can each be evaluated solely in one of the two resulting integrals and that they can be evaluated separately from one another. To actually perform the path integral split-up, we may trouble Fubini's theorem and refer to the well-definedness of the path integral in quantum mechanics as demonstrated in section 7.1 of the script. To save on writing, we hence assume $t_1 > t_2$.
$ = lim_(N -> oo) integral (dif p_0) / (2 pi) product_(k=1)^(j-1) (dif p_k dif q_k) / (2 pi) q(t_2) e^(i sum_(k=0)^N L(p_k, overline(q)_k)) integral dd(q_j) integral (dif p_j) / (2 pi) product_(k=j+1)^N (dif p_k dif q_k) / (2 pi) q(t_1) e^(i sum_(k=0)^N L(p_k, overline(q)_k)). $
In the above line, we note that our split-up created two new path integrals and an integral over $q_j$ in between. The expression can therefore be rewritten, again using Fubini's theorem to rearrange integrals, as
$
  & = integral dd(q_j) integral_(q(t_j) = q_j)^(q(t_F) = q_F) Dm q(t) Dm p(t) q(t_1) e^(i S[p, q]) integral_(q(t_I) = q_I)^(q(t_j) = q_j) Dm q(t) Dm p(t) q(t_2) e^(i S[p, q]) \
  & = integral dd(q_j) chevron.l q_F, t_F | qh_H (t_1) | q_j, t_j chevron.r chevron.l q_j, t_j | qh_H (t_2) | q_I, t_I chevron.r \
  & = integral dd(q_j) chevron.l q_F, t_F | qh_H (t_1) e^(i Hh t_j) | q_j chevron.r chevron.l q_j | e^(-i Hh t_j) qh_H (t_2) | q_I, t_I chevron.r = chevron.l q_F, t_F | qh_H (t_1) e^(i Hh t_j) e^(-i Hh t_j) qh_H (t_2) | q_I, t_I chevron.r \
  & = chevron.l q_F, t_F | qh_H (t_1) qh_H (t_2) | q_I, t_I chevron.r = chevron.l q_F, t_F | T qh_H (t_1) qh_H (t_2) | q_I, t_I chevron.r,
$
where in the last step, time-ordering could be added trivially since we set $t_1 > t_2$. However, it is important to note that we could equally well have set $t_2 > t_1$, in which case, following the same procedure as we did just now, $q(t_2)$ would have ended up in the left path integral and $q(t_1)$ in the right one, reversing their order in the final expression. This goes to show that the path integral formulation of quantum field theory takes care of time-ordering automatically.

= Problem 2.2 (Quantum mechanical oscillator and path integral)

#task[
  The transition amplitude between a state $ket(q_a)$ at $t = 0$ and $ket(q_b)$ at $t = T$ can be schematically expressed as
  #tagged(2, $ bra(q_b) e^(-i Hh T) ket(q_a) = integral_(q(0) = q_a)^(q(T) = q_b) Dm q e^(i S[q]), $)
  where the integral $integral Dm q$ is performed over all the possible trajectories connecting the points $q(0) equiv q_a$ and $q(T) equiv q_b$, and $S[q] = integral_0^T dd(t) cal(L)(q, dot(q))$. In the case of free fields, $H = ph^2 / (2 m)$, the transition amplitude is simple to calculate. Show that
  $ bra(q_b) e^(-i ph^2 / (2 m) T) ket(q_a) = sqrt(m / (2 pi i T)) e^(i m / (2 T) (q_b - q_a)^2). $
]

$
  bra(q_b) e^(-i ph^2 / (2 m) T) ket(q_a) & = bra(q_b) e^(-i ph^2 / (2 m) T) underbrace(integral dd(p) ket(p) bra(p), bb(1) "by the completeness relation") ket(q_a) = integral dd(p) bra(q_b) e^(-i ph^2 / (2 m) T) ket(p) chevron.l p | q_a chevron.r \
  & = integral dd(p) bra(q_b) e^(-i p^2 / (2 m) T) ket(p) chevron.l p | q_a chevron.r = integral dd(p) underbrace(chevron.l q_b | p chevron.r, 1 / sqrt(2 pi) e^(i p q_b)) underbrace(chevron.l p | q_a chevron.r, 1 / sqrt(2 pi) e^(-i p q_a)) e^(-i p^2 / (2 m) T) = integral (dif p) / (2 pi) e^(i p (q_b - q_a)) e^(-i p^2 / (2 m) T) \
  & = integral (dif p) / (2 pi) exp[-(i T) / (2 m) (p - m / T (q_b - q_a))^2 + i m / (2 T) (q_b - q_a)^2], quad "Gauss integral:" integral e^(-a (x + b)^2) dif x = sqrt(pi / a) \
  & = 1 / (2 pi) sqrt(pi / ((i T) / (2 m))) e^(i m / (2 T) (q_b - q_a)^2) = sqrt(m / (2 pi i T)) e^(i m / (2 T) (q_b - q_a)^2).
$

#task[
  We are now going to determine in a few steps the transition amplitude of a harmonic oscillator. The system is characterized by the Lagrangian density
  $ cal(L) = m / 2 dot(q)^2 - (m omega^2) / 2 q^2. $
]

#task(label: "a")[
  Recall that the classical trajectory $q_c (t)$ is found by extremising the action,
  $ (delta S[q(t)]) / (delta q(t)) = -m dot.double(q)(t) - m omega^2 q(t) = 0, $
  and imposing the boundary conditions $q(0) = q_a$ and $q(T) = q_b$. An arbitrary trajectory $q(t)$ can then be decomposed as $q(t) = q_c (t) + y(t)$ with the boundary conditions $y(0) = y(T) = 0$.
]

$
  (delta S[q(t)]) / (delta q(t)) & = delta / (delta q(t)) integral_0^T dd(t') cal(L) = delta / (delta q(t)) integral_0^T dd(t') (m / 2 dot(q)^2 (q, t') - m / 2 omega^2 q^2 (t')) = integral_0^T dd(t') (m / 2 (delta dot(q)^2 (q, t')) / (delta q(t)) - m / 2 omega^2 (delta q^2 (t')) / (delta q(t))) \
  & = integral_0^T dd(t') (m dot(q)(q, t') (delta dot(q)(q, t')) / (delta q(t)) - m omega^2 q(t') underbrace((delta q(t')) / (delta q(t)), delta(t - t'))) = integral_0^T dd(t') (m dot(q)(q, t') dif / (dif t') underbrace((delta q(t')) / (delta q(t)), delta(t - t')) - m omega^2 q(t') delta(t - t')) \
  & = underbrace(m dot(q)(q, t') (delta q(t')) / (delta q(t)) |_0^T, 0) + integral_0^T dd(t') (-m dif / (dif t') dot(q)(q, t') - m omega^2 q(t')) delta(t - t') \
  & = -m dot.double(q)(q, t) - m omega^2 q(t) attach(=, t: !) 0 quad ==> quad m dot.double(q) + m omega^2 q = 0.
$
The boundary terms coming from the partial integration vanish, because the boundary points $q(t = 0) = q_a$ and $q(t = T) = q_b$ are held fixed, meaning their variation vanishes, i.e.
$ (delta q(t' = T)) / (delta q(t)) = (delta q(t' = 0)) / (delta q(t)) = 0. $

#task(label: "b")[
  Convince yourself that the following expression for the action is exact
  #tagged(4, $ S[q] = S[q_c] + integral_0^T dd(t) (delta S[q]) / (delta q(t)) |_(q(t) = q_c (t)) y(t) + 1/2 integral_0^T integral_0^T dd(t) dif t' (delta^2 S[q]) / (delta q(t) delta q(t')) |_(q(t) = q_c (t)) y(t) y(t'). $)
  Then show that we can write
  #tagged(5, $ (delta^2 S[q]) / (delta q(t) delta q(t')) = -m dif^2 / (dif t^2) delta(t - t') - m omega^2 delta(t - t') $)
  so that
  #tagged(6, $ S[q] = S[q_c] + m / 2 integral_0^T dd(t) (dot(y)^2 (t) - omega^2 y^2 (t)) =: S[q_c] + S[y]. $)
  Then our initial amplitude reads
  #tagged(7, $ integral Dm q e^(i S[q]) = e^(i S[q_c]) integral Dm y e^(i S[y]). $)
]

To do the convincing, we choose to first show eq. (5). In part a), we already showed that $(delta S[q]) / (delta q(t)) = -m dot.double(q)(t) - m omega^2 q(t)$. Therefore
$
  (delta^2 S[q]) / (delta q(t) delta q(t')) & = delta / (delta q(t)) (delta S[q]) / (delta q(t')) = delta / (delta q(t)) (-m dot.double(q)(t') - m omega^2 q(t')) = -m (delta dot.double(q)(t')) / (delta q(t)) - m omega^2 (delta q(t')) / (delta q(t)) \
  & = -m dif^2 / (dif t^2) (delta q(t')) / (delta q(t)) - m omega^2 (delta q(t')) / (delta q(t)) = -m dif^2 / (dif t^2) delta(t - t') - m omega^2 delta(t - t').
$
Using this result, we can make sure eq. (4) is correct:
$
  S[q] & = integral_0^T dd(t) cal(L)(q(t), dot(q)(t), t) = integral_0^T dd(t) (m / 2 (dot(q)_c (t) + dot(y)(t))^2 - m / 2 omega^2 (q_c (t) + y(t))^2) \
  & = underbrace(integral_0^T dd(t) (m / 2 dot(q)_c^2 (t) - m / 2 omega^2 q_c^2 (t)), S[q_c]) + integral_0^T dd(t) (m dot(q)_c (t) dot(y)(t) - m omega^2 q_c (t) y(t)) + integral_0^T dd(t) (m / 2 dot(y)^2 (t) - m / 2 omega^2 y^2 (t)) \
  & = S[q_c] + underbrace(m dot(q)_c (t) y(t) |_0^T, 0 "since" y(0) = y(T) = 0) + integral_0^T dd(t) underbrace((-m dot.double(q)_c (t) - m omega^2 q_c (t)), (delta S[q]) / (delta q(t))) y(t) \
  & quad + 1/2 integral_0^T dd(t) integral_0^T dd(t') (m dot(y)(t) dot(y)(t') delta(t - t') - m omega^2 y(t) y(t') delta(t - t')) \
  & = S[q_c] + integral_0^T dd(t) (delta S[q]) / (delta q(t)) y(t) + underbrace(1/2 m y(t) integral_0^T dd(t') dot(y)(t') delta(t - t') |_0^T, 0) + 1/2 integral_0^T dd(t) integral_0^T dd(t') (-m y(t) dot(y)(t') dif / (dif t) delta(t - t') - dots.c) \
  & = S[q_c] + integral_0^T dd(t) (delta S[q]) / (delta q(t)) y(t) - underbrace(1/2 m y(t') integral_0^T dd(t) y(t) dif / (dif t) delta(t - t') |_0^T, 0) \
  & quad + 1/2 integral_0^T dd(t) integral_0^T dd(t') (arrow.zigzag m y(t) y(t') dif^2 / (dif t^2) delta(t - t') - m omega^2 y(t) y(t') delta(t - t')) \
  & = S[q_c] + integral_0^T dd(t) (delta S[q]) / (delta q(t)) y(t) + 1/2 integral_0^T dd(t) integral_0^T dd(t') (delta^2 S[q]) / (delta q(t) delta q(t')) y(t) y(t').
$
A simpler and more general way of proving the exactness of eq. (4) is acknowledging that it marks the Taylor expansion of $S[q]$ w.r.t. $y(t)$ at $q_c (t)$, the classical trajectory, where all terms above the quadratic one vanish due to our particular form of Lagrangian, which contains only quadratic terms in $q(t)$ and $dot(q)(t)$, such that
$ (delta^3 S[q]) / (delta q(t) delta q(t') delta q(t'')) = delta / (delta q(t)) (-m dif^2 / (dif t'^2) delta(t' - t'') - m omega^2 delta(t' - t'')) = 0. $
In any case, given eq. (4), it is easy to deduce eq. (6). Since the term linear in $y(t)$ vanishes due to $(delta S[q]) / (delta q(t)) = 0$, we get
$
  S[q] & = S[q_c] + 1/2 integral_0^T dd(t) integral_0^T dd(t') (-m dif^2 / (dif t^2) delta(t - t') - m omega^2 delta(t - t')) y(t) y(t') \
  & = S[q_c] - underbrace(1/2 m integral_0^T dd(t') (dif / (dif t) delta(t - t')) y(t) y(t') |_0^T, 0 "since" y(0) = y(T) = 0) + 1/2 integral_0^T dd(t) integral_0^T dd(t') (m dif / (dif t) delta(t - t') dot(y)(t) y(t') - m omega^2 delta(t - t') y(t) y(t')) \
  & = S[q_c] + 1/2 integral_0^T dd(t) integral_0^T dd(t') (-m delta(t - t') dot.double(y)(t) y(t') - m omega^2 delta(t - t') y(t) y(t')) \
  & = S[q_c] - m / 2 integral_0^T dd(t) (dot.double(y)(t) + omega^2 y(t)) y(t) = S[q_c] - underbrace(m / 2 dot(y)(t) y(t) |_0^T, 0) + underbrace(m / 2 integral_0^T dd(t) (dot(y)^2 (t) - omega^2 y^2 (t)), = S[y]).
$
From this result, we see that $integral Dm q e^(i S[q]) = e^(i S[q_c]) integral Dm y e^(i S[y])$.

#task(label: "c")[
  Show that
  #tagged(8, $ S[q_c] = (m omega) / (2 sin(omega T)) [(q_b^2 + q_a^2) cos(omega T) - 2 q_a q_b]. $)
  _Hint:_ $T$ is not connected to $omega$ by a relation of the sort $T prop 1 / (2 pi omega)$.
]

The classical trajectory, $q_c (t)$, is the one that extremizes the action $S[q]$. As shown in part a), for $(delta S[q]) / (delta q(t)) |_(q(t) = q_c (t)) attach(=, t: !) 0$, it holds that
$ dot.double(q)_c (t) = -omega^2 q_c (t), $
of which the general solution is $q_c (t) = A sin(omega (t - t_0)) + B cos(omega (t - t_0))$. Since the harmonic oscillator is time-translation invariant, we may set $t_0 = 0$ and use the boundary conditions for $q(0)$ and $q(T)$ to determine $A$ and $B$:
$
  q_a & := q(t = 0) = A sin(0) + B cos(0) = B, \
  q_b & := q(t = T) = A sin(omega T) + q_a cos(omega T) quad ==> quad A = (q_b - q_a cos(omega T)) / sin(omega T).
$
For the case of our harmonic oscillator, the classical path $q_c (t)$ is hence given by
$ q_c (t) = (q_b - q_a cos(omega T)) / sin(omega T) sin(omega t) + q_a cos(omega t). $
Inserting the classical path into the Lagrangian and integrating from $0$ to $T$ yields
$
  S[q_c] & = integral_0^T dd(t) cal(L) |_(q(t) = q_c (t)) = integral_0^T dd(t) (m / 2 dot(q)_c^2 (t) - m / 2 omega^2 q_c^2 (t)) \
  & = integral_0^T dd(t) (m / 2 omega^2 (A cos(omega t) - B sin(omega t))^2 - m / 2 omega^2 (A sin(omega t) + B cos(omega t))^2) \
  & = m / 2 omega^2 integral_0^T dd(t) (A^2 cos^2 (omega t) - 2 A B sin(omega t) cos(omega t) + B^2 sin^2 (omega t) - A^2 sin^2 (omega t) \
    & #h(8em) - 2 A B sin(omega t) cos(omega t) - B^2 cos^2 (omega t)) \
  & = m / 2 omega^2 integral_0^T dd(t) (A^2 (cos^2 (omega t) - sin^2 (omega t)) - B^2 (cos^2 (omega t) - sin^2 (omega t)) - 2 A B sin(2 omega t)),
$
where we used that $sin(alpha) cos(beta) plus.minus sin(beta) cos(alpha) = sin(alpha plus.minus beta)$. In the next step, we'll employ $cos(alpha) cos(beta) minus.plus sin(alpha) sin(beta) = cos(alpha plus.minus beta)$ to get
$
  S[q_c] & = m / 2 omega^2 integral_0^T dd(t) ((A^2 - B^2) cos(2 omega t) - 2 A B sin(2 omega t)) \
  & = m / 2 omega^2 ((A^2 - B^2) / (2 omega) sin(2 omega t) |_0^T + (2 A B) / (2 omega) cos(2 omega t) |_0^T) \
  & = m / 4 omega ((A^2 - B^2) sin(2 omega T) + 2 A B underbrace((cos(2 omega T) - 1), -2 sin^2 (omega T))),
$
where
$ A^2 - B^2 = (q_b^2 - 2 q_a q_b cos(omega T) + q_a^2 cos^2 (omega T)) / (sin^2 (omega T)) - q_a^2, quad A B = (q_a q_b - q_a^2 cos(omega T)) / sin(omega T). $
Thus
$
  S[q_c] & = (m omega) / (2 sin(omega T)) ((q_b^2 - 2 q_a q_b cos(omega T) + q_a^2 (cos^2 (omega T) - sin^2 (omega T))) / (2 sin(omega T) sin^(-1) (2 omega T)) - 2 (q_a q_b - q_a^2 cos(omega T)) sin^2 (omega T)) \
  & = (m omega) / (2 sin(omega T)) (1 / (2 sin(omega T)) ((q_b^2 - 2 q_a q_b cos(omega T) + q_a^2 (cos^2 (omega T) - sin^2 (omega T))) sin(2 omega T) \
    & #h(12em) - 4 (q_a q_b - q_a^2 cos(omega T)) sin^3 (omega T))) \
  & = (m omega) / (2 sin(omega T)) ((q_a^2 + q_b^2) cos(omega T) - 2 q_a q_b).
$

#task(label: "d")[
  At this point, it is convenient to introduce functions
  #tagged(9, $ y_n (t) = C_n sin((n pi t) / T), $)
  where $C_n$ are constants to be determined. The $y_n (t)$ are orthonormal on the interval $[0, T]$: $integral_0^T dd(t) y_n (t) y_m (t) = delta_(n m)$. These can be used as a basis to expand any function $y(t)$ satisfying our boundary conditions, i.e.
  #tagged(10, $ y(t) = sum_(n=1)^oo a_n y_n (t), $)
  by means of a set of constants $a_n$. Then show that
  #tagged(11, $ S[y] = m / 2 sum_(n=1)^oo lambda_n a_n^2 $)
  and determine the constant quantities $lambda_n$.
]

The $C_n$ are constrained by the required orthonormality:
$
  integral_0^T dd(t) y_n (t) y_m (t) & = integral_0^T dd(t) C_n sin((n pi t) / T) C_m sin((m pi t) / T) = integral_0^T dd(t) C_n C_m 1/2 (cos((n - m) (pi t) / T) - cos((n + m) (pi t) / T)) \
  & = 1/2 C_n C_m (T / (pi (n - m)) sin((n - m) (pi t) / T) - T / (pi (n + m)) sin((n + m) (pi t) / T)) |_0^T \
  & = T / (2 pi) C_n C_m (sin((n - m) pi) / (n - m) - overbrace(sin((n + m) pi), 0) / (n + m)) = T / (2 pi) C_n C_m sin((n - m) pi) / (n - m) attach(=, t: !) delta_(n m) = cases(1 & "if" n = m, 0 & "else".)
$
Since $lim_(n -> m) sin((n - m) pi) / (n - m) = pi$, $C_n$ needs to fulfill $T / 2 C_n^2 = 1$ or $C_n = sqrt(2 / T)$. Therefore, our expansions of $y(t)$ and $dot.double(y)(t)$ read
$
  y(t) & = sum_(n=1)^oo a_n y_n (t) = sum_(n=1)^oo a_n C_n sin((n pi t) / T) = sum_(n=1)^oo a_n sqrt(2 / T) sin((n pi t) / T), \
  dot.double(y)(t) & = sum_(n=1)^oo a_n dot.double(y)_n (t) = sum_(n=1)^oo -a_n C_n (n^2 pi^2) / T^2 sin((n pi t) / T) = sum_(n=1)^oo -a_n sqrt(2 / T) (n^2 pi^2) / T^2 sin((n pi t) / T) = -sum_(n=1)^oo a_n (n^2 pi^2) / T^2 y_n (t).
$
Inserting this into the action of quantum fluctuations, $S[y]$, we get
$
  S[y] & = m / 2 integral_0^T dd(t) (dot(y)^2 (t) - omega^2 y^2 (t)) = -m / 2 integral_0^T dd(t) (dot.double(y)(t) + omega^2 y(t)) y(t) \
  & = -m / 2 integral_0^T dd(t) sum_(n, m = 1)^oo (-a_n (n^2 pi^2) / T^2 y_n (t) + omega^2 a_n y_n (t)) a_m y_m (t) \
  & = -m / 2 sum_(n, m = 1)^oo (-a_n a_m (n^2 pi^2) / T^2 delta_(n m) + a_n a_m omega^2 delta_(n m)) = m / 2 sum_(n=1)^oo (a_n^2 (n^2 pi^2) / T^2 - a_n^2 omega^2) \
  & = m / 2 sum_(n=1)^oo underbrace(((n^2 pi^2) / T^2 - omega^2), lambda_n) a_n^2.
$

#task(label: "e")[
  The integral measure can be expressed as (accept the following as a postulate, but think about it)
  #tagged(12, $ Dm y = J product_(n=1)^oo dif a_n, $)
  for some constant $J$. Knowing this, show that
  #tagged(13, $ F_omega (T) = integral Dm y e^(i S[y]) = J product_(n=1)^oo sqrt((2 pi i) / (m lambda_n)). $)
]

The above equality can be computed using the Gaussian integral:
$
  F_omega (T) & = integral Dm y e^(i S[y]) = J integral product_(n=1)^oo dif a_n e^(i m / 2 sum_(n=1)^oo lambda_n a_n^2) = J integral product_(n=1)^oo dif a_n e^(i m / 2 lambda_n a_n^2) \
  & = J product_(n=1)^oo integral dd(a_n) e^(-overbrace((-i m / 2 lambda_n), x_n) a_n^2) = J product_(n=1)^oo sqrt(pi / x_n) = J product_(n=1)^oo sqrt(pi / (-i m / 2 lambda_n)) = J product_(n=1)^oo sqrt((2 pi i) / (m lambda_n)).
$

#task(label: "f")[
  We know the exact value of $F_omega (T)$ for the case of free fields, $omega = 0$: Recall indeed that in this case $F_0 (T) = sqrt(m / (2 pi i T))$. On the other hand, one can also calculate $F_0 (T)$ by the same procedure we developed until now: Show that the $lambda_n$ coefficients, when $omega = 0$, read $lambda_n^((0)) = (n^2 pi^2) / T^2$.
]

We looked at free fields ($omega = 0$) just before part a) of this problem and found that
$
  F_0 (T) & = integral Dm y e^(i S[y]) attach(=, t: "eq. (7)") e^(-i S[q_c]) integral Dm q e^(i S[q]) = e^(-i S[q_c]) chevron.l q_b, T | q_a, 0 chevron.r \
  & = e^(-i S[q_c]) bra(q_b) e^(-i Hh T) e^(i Hh 0) ket(q_a) = e^(-i S[q_c]) bra(q_b) e^(-i ph^2 / (2 m) T) ket(q_a) \
  & = e^(-i S[q_c]) sqrt(m / (2 pi i T)) e^(i underbrace(m / (2 T) (q_b - q_a)^2, S[q_c] |_(omega = 0) ", see eq. (8)")) = sqrt(m / (2 pi i T)).
$
Since $lambda_n = (n^2 pi^2) / T^2 - omega^2$, we immediately have $lambda_n^((0)) := lambda_n |_(omega = 0) = (n^2 pi^2) / T^2$.

#task(label: "g")[
  Then we can write
  #tagged(14, $ (F_omega (T)) / (F_0 (T)) = product_(n=1)^oo sqrt(lambda_n^((0)) / lambda_n) = product_(n=1)^oo (1 - (omega^2 T^2) / (pi^2 n^2))^(-1/2). $)
  Deduce from this that
  #tagged(15, $ F_omega (T) = sqrt((m omega) / (2 pi i sin(omega T))) $)
  and finally, collect everything and write up the result for the transition amplitude!
]

We first investigate the infinite product in eq. (14). Interestingly, it vanishes whenever $T = (pi n) / omega$ with $n in NN$. The same applies to $sin(omega T)$ for $T = (pi n) / omega$. However, for $T -> 0$, $product_(n=1)^oo (1 - (omega^2 T^2) / (pi^2 n^2)) -> 1$ while $sin(omega T) -> 0$. So the infinite product might rather resemble $sin(omega T) / (omega T)$, which we stated earlier behaves as $sin(omega T) / (omega T) -> 1$ for $T -> 0$. In fact, $"sinc"(omega T) = sin(omega T) / (omega T)$ is called the cardinal sine and the infinite product is exactly Euler's expansion of it. The identity
$ "sinc"(omega T) = sin(omega T) / (omega T) = product_(n=1)^oo (1 - (omega^2 T^2) / (pi^2 n^2)) $
can be proven rigorously (and lengthily) using the residue theorem (or Liouville's theorem). We refrain from performing either proof and simply apply it to find
$ F_omega (T) = F_0 (T) product_(n=1)^oo (1 - (omega^2 T^2) / (pi^2 n^2))^(-1/2) = F_0 (T) 1 / sqrt("sinc"(omega T)) = sqrt(m / (2 pi i T)) sqrt((omega T) / sin(omega T)) = sqrt((m omega) / (2 pi i sin(omega T))). $
Assembling everything we learned throughout this problem, we are finally able to write down the complete transition amplitude for the quantum harmonic oscillator from state $q_a$ at $t = 0$ to state $q_b$ at $t = T$:
$
  chevron.l q_b, T | q_a, 0 chevron.r & = integral_(q_a)^(q_b) Dm q e^(i S[q]) = e^(i S[q_c]) integral Dm y e^(i S[y]) = e^(i S[q_c]) F_omega (T) \
  & = sqrt((m omega) / (2 pi i sin(omega T))) exp[(i m omega) / (2 sin(omega T)) ((q_a^2 + q_b^2) cos(omega T) - 2 q_a q_b)].
$
