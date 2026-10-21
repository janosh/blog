#import "/notes.typ": dd, notes, tagged, task
#import "@preview/cetz:0.5.2": canvas, decorations, draw

#show: notes.with(
  title: [Quantum Field Theory II -- Assignment 1],
  subtitle: [Exercise sheet 1, Advanced QFT, Prof. Jürgen Berges],
  date: [Solutions by Janosh Riebesell, 20.04.2015 to 24.04.2015],
)

// Feynman slash
#let sl(body) = math.cancel(body, length: 90%, angle: 30deg)
#let ub = $overline(u)$
#let vb = $overline(v)$
#let Pb = $overline(Psi)$
#let Tr = math.op("Tr")
#let one = $bb(1)_4$
// improvement tensor L^mu_nu^rho with staggered indices
#let Lt = $L^(mu #h(0.55em) rho)_(#h(0.45em) nu)$
#let Th = $Theta$

// Feynman diagrams
#let fd(body, length: 0.75cm) = box(baseline: 50%, inset: (x: 2pt, y: 3pt), canvas(length: length, {
  import draw: *
  set-style(stroke: 0.7pt)
  body
}))
#let ph(a, b) = decorations.wave(draw.line(a, b), amplitude: 0.12, segment-length: 0.28)
// fermion line with an arrow in the middle
#let fe(a, b) = {
  let m = ((a.at(0) + b.at(0)) / 2, (a.at(1) + b.at(1)) / 2)
  draw.line(a, m, mark: (end: ">", fill: black, scale: 0.6))
  draw.line(m, b)
}
#let lab(pt, body, anchor: "center") = draw.content(pt, text(size: 8pt, body), anchor: anchor)
#let vtx(pt) = draw.circle(pt, radius: 0.05, fill: black, stroke: none)

// Compton scattering: s-channel (crossed: false) and u-channel (crossed: true)
#let compton(crossed: false) = fd({
  let (v1, v2) = ((1.4, 0), (3.0, 0))
  fe((0, 0), v1)
  fe(v1, v2)
  fe(v2, (4.4, 0))
  if crossed {
    ph((0.2, 1.5), v2)
    ph(v1, (4.2, 1.5))
    lab((0.2, 1.75), $epsilon_"in" (k)$)
    lab((4.2, 1.75), $epsilon_"out" (k')$)
    lab((2.2, -0.35), $q = p - k'$)
    lab((1.15, 0.3), $mu$)
    lab((3.25, 0.3), $nu$)
  } else {
    ph((0.2, 1.5), v1)
    ph(v2, (4.2, 1.5))
    lab((0.2, 1.75), $epsilon_"in" (k)$)
    lab((4.2, 1.75), $epsilon_"out" (k')$)
    lab((2.2, 0.35), $q = p + k$)
    lab((1.4, -0.35), $mu$)
    lab((3.0, -0.35), $nu$)
  }
  lab((0.3, -0.35), $u_s (p)$)
  lab((4.1, -0.35), $ub_(s') (p')$)
  vtx(v1)
  vtx(v2)
})

#let annihilation = fd({
  let (v1, v2) = ((1.3, 0), (3.1, 0))
  fe((0, -1.3), v1)
  fe(v1, (0, 1.3))
  ph(v1, v2)
  fe(v2, (4.4, -1.3))
  fe((4.4, 1.3), v2)
  lab((-0.2, -1.45), $e^-$)
  lab((-0.2, 1.45), $e^+$)
  lab((4.6, -1.45), $mu^-$)
  lab((4.6, 1.45), $mu^+$)
  let arr(a, b) = draw.line(a, b, mark: (end: ">", fill: black, scale: 0.5), stroke: 0.45pt)
  arr((0.57, -1.09), (1.09, -0.57))
  arr((0.57, 1.09), (1.09, 0.57))
  arr((3.31, -0.57), (3.83, -1.09))
  arr((3.31, 0.57), (3.83, 1.09))
  lab((1.25, -1.2), $p, s$)
  lab((1.25, 1.2), $q, r$)
  lab((3.15, -1.2), $p', s'$)
  lab((3.15, 1.2), $q', r'$)
  vtx(v1)
  vtx(v2)
})

#let trivial = fd(length: 0.5cm, {
  fe((0, 0.4), (3, 0.4))
  fe((3, -0.4), (0, -0.4))
  lab((-0.35, 0.4), $e^-$)
  lab((-0.35, -0.4), $e^+$)
  lab((3.35, 0.4), $e^-$)
  lab((3.35, -0.4), $e^+$)
  draw.line((1.1, 0.68), (1.9, 0.68), mark: (end: ">", fill: black, scale: 0.5), stroke: 0.45pt)
  draw.line((1.1, -0.68), (1.9, -0.68), mark: (end: ">", fill: black, scale: 0.5), stroke: 0.45pt)
  lab((1.5, 1.0), $p, s$)
  lab((1.5, -0.98), $q, r$)
})

#let tchannel = fd({
  let (v1, v2) = ((2, 0.8), (2, -0.8))
  fe((0, 1.35), v1)
  fe(v1, (4, 1.35))
  ph(v1, v2)
  fe(v2, (0, -1.35))
  fe((4, -1.35), v2)
  lab((-0.3, 1.35), $e^-$)
  lab((4.3, 1.35), $e^-$)
  lab((-0.3, -1.35), $e^+$)
  lab((4.3, -1.35), $e^+$)
  let arr(a, b) = draw.line(a, b, mark: (end: ">", fill: black, scale: 0.5), stroke: 0.45pt)
  arr((0.645, 1.35), (1.445, 1.13))
  arr((2.555, 1.13), (3.355, 1.35))
  arr((0.645, -1.35), (1.445, -1.13))
  arr((2.555, -1.13), (3.355, -1.35))
  lab((1.0, 1.62), $p, s$)
  lab((3.0, 1.62), $p', s'$)
  lab((1.0, -1.62), $q, r$)
  lab((3.0, -1.62), $q', r'$)
  lab((2.3, 0), $q = p - p'$, anchor: "west")
  vtx(v1)
  vtx(v2)
})

#let cmframe = fd(length: 0.8cm, {
  import draw: *
  let arr = (end: "stealth", fill: black, scale: 0.7)
  line((-2, 0), (-0.08, 0), mark: arr)
  line((2, 0), (0.08, 0), mark: arr)
  line((0.08, 0.06), (1.7, 1.2), mark: arr)
  line((-0.08, -0.06), (-1.7, -1.2), mark: arr)
  arc((0.7, 0), start: 0deg, stop: 35.2deg, radius: 0.7)
  lab((0.95, 0.25), $theta$)
  lab((-1.75, 0.3), $e^+$)
  lab((-1.2, -0.3), $q$)
  lab((1.75, 0.3), $e^-$)
  lab((1.2, -0.3), $p$)
  lab((1.95, 1.35), $mu^-$)
  lab((1.55, 0.75), $p'$)
  lab((-1.95, -1.35), $mu^+$)
  lab((-0.75, -0.85), $q'$)
})

= Problem 1.1 (Compton scattering)

#task[
  Consider the Compton scattering process $e^- + gamma -> e^- + gamma$ in QED. Use the Feynman rules to derive the amplitude for the tree-level diagram
  #tagged(1, $ #compton() = i cal(M)_1 = -i e^2 ub_s (p') sl(epsilon)_"out" (k') (sl(p) + sl(k) + m) / ((p + k)^2 - m^2) sl(epsilon)_"in" (k) u_s (p). $)
  Also compute the contribution from
  $ #compton(crossed: true). $
  The total amplitude, at order $e^2$, is the sum of these two diagrams. Show that if $epsilon_"in"$ is replaced by the incoming photon momentum $k$, then the total amplitude vanishes. Check that the same holds true if $epsilon_"out"$ is replaced by $k'$. _Hint:_ You may find $(sl(p) - m) u_s (p) = 0$ useful.
]

$
  i cal(M)_1 & = ub_(s') (p') (-i e gamma^nu) epsilon_nu^"out" (k') (i (sl(q) + m)) / (q^2 - m^2) (-i e gamma^mu) epsilon_mu^"in" (k) u_s (p) \
  & = -i e^2 ub_(s') (p') sl(epsilon)_"out" (k') (sl(p) + sl(k) + m) / ((p + k)^2 - m^2) sl(epsilon)_"in" (k) u_s (p), \
  i cal(M)_2 & = ub_(s') (p') (-i e gamma^nu) epsilon_nu^"in" (k) (i (sl(q) + m)) / (q^2 - m^2) (-i e gamma^mu) epsilon_mu^"out" (k') u_s (p) \
  & = -i e^2 ub_(s') (p') sl(epsilon)_"in" (k) (sl(p) - sl(k)' + m) / ((p - k')^2 - m^2) sl(epsilon)_"out" (k') u_s (p), \
  i cal(M) & = i (cal(M)_1 + cal(M)_2) = -i e^2 ub_(s') (p') (sl(epsilon)_"out" (k') (sl(p) + sl(k) + m) / ((p + k)^2 - m^2) sl(epsilon)_"in" (k) + sl(epsilon)_"in" (k) (sl(p) - sl(k)' + m) / ((p - k')^2 - m^2) sl(epsilon)_"out" (k')) u_s (p) \
  & = -i e^2 epsilon_(mu)^"out" (k') ub_(s') (p') (gamma^mu (sl(p) + sl(k) + m) / ((p + k)^2 - m^2) gamma^nu + gamma^nu (sl(p) - sl(k)' + m) / ((p - k')^2 - m^2) gamma^mu) epsilon_(nu)^"in" (k) u_s (p),
$
where in the last step, we used that $epsilon_"in" (k)$, $epsilon_"out" (k')$ are freely commutable through the remaining terms since they are spacetime 4-vectors and are therefore not contracted with any of the spinor space objects $u_s (p)$, $ub_(s') (p')$ and the $gamma$-matrices.

Using the hint given in the exercise and applying momentum conservation, i.e. $p + k = p' + k'$, we get when setting $epsilon_"in" (k) = k$
$ sl(k) u_s (p) attach(=, t: "hint") (sl(p) + sl(k) - m) u_s (p), quad ub_(s') (p') sl(k) attach(=, t: "m.c.") ub_(s') (p') (sl(p)' + sl(k)' - sl(p)) = -ub_(s') (p') (sl(p) - sl(k)' - m), $
$ (sl(p) + sl(k) + m) (sl(p) + sl(k) - m) = (sl(p) + sl(k))^2 - m^2, quad (sl(p) - sl(k)' + m) (sl(p) - sl(k)' - m) = (sl(p) - sl(k)')^2 - m^2, $
$
  (sl(p) + sl(k))^2 & = gamma^alpha gamma^beta (p + k)_alpha (p + k)_beta = (2 eta^(alpha beta) - gamma^beta gamma^alpha) (p + k)_alpha (p + k)_beta \
  & = 2 (p + k)_alpha (p + k)^alpha - gamma^beta (p + k)_beta gamma^alpha (p + k)_alpha \
  & = 2 (p + k)^2 - (sl(p) + sl(k))^2 quad ==> quad (sl(p) + sl(k))^2 = (p + k)^2, quad "same for" (sl(p) - sl(k)')^2.
$
Inserting everything into $i cal(M)$:
$
  i cal(M) & = -i e^2 epsilon_(mu)^"out" (k') ub_(s') (p') (gamma^mu (sl(p) + sl(k) + m) / ((p + k)^2 - m^2) gamma^nu + gamma^nu (sl(p) - sl(k)' + m) / ((p - k')^2 - m^2) gamma^mu) k_nu u_s (p) \
  & = -i e^2 epsilon_(mu)^"out" (k') ub_(s') (p') (gamma^mu (sl(p) + sl(k) + m) / ((p + k)^2 - m^2) (sl(p) + sl(k) - m) - (sl(p) - sl(k)' - m) (sl(p) - sl(k)' + m) / ((p - k')^2 - m^2) gamma^mu) u_s (p) \
  & = -i e^2 epsilon_(mu)^"out" (k') ub_(s') (p') (gamma^mu ((p + k)^2 - m^2) / ((p + k)^2 - m^2) - ((p - k')^2 - m^2) / ((p - k')^2 - m^2) gamma^mu) u_s (p) \
  & = -i e^2 epsilon_(mu)^"out" (k') ub_(s') (p') (gamma^mu - gamma^mu) u_s (p) = 0.
$

= Problem 1.2 ($e^- + e^+ -> mu^- + mu^+$ scattering amplitude)

#task[
  For this question, use the fact that a muon, $mu^plus.minus$, is a Dirac fermion with mass $m_mu >> m_e$ and satisfies the same Feynman rules as the electron.
]

#task(label: "a")[
  Using the Feynman rules for QED, show that the amplitude for $e^- + e^+ -> mu^- + mu^+$ is given, at lowest order in $e$, by
  #tagged(2, $ #annihilation = i cal(M) = +i e^2 vb_r^e (q) gamma_mu u_s^e (p) 1 / ((p + q)^2 + i epsilon) ub_(s')^m (p') gamma^mu v_(r')^m (q'), $)
  where the superscripts $e$ and $m$ denote whether the spinors satisfy the Dirac equation for electrons or muons. Briefly comment on why this is the only contributing diagram unlike for $e^- + e^+ -> e^- + e^+$ scattering.
]

Overlooking the fact that the event $e^- + e^+ -> e^- + e^+$ can occur simply due to trivial scattering (i.e. the diagram #trivial) because initial and final particle composition are identical, we note that for this very same reason, $e^- + e^+ -> e^- + e^+$ receives contributions from two non-trivial scattering channels. The diagram in eq. (2) works for $e^- + e^+ -> e^- + e^+$ as well as
$ #tchannel $
Such a $t$-channel diagram cannot contribute to $e^- + e^+ -> mu^- + mu^+$ as it is incapable of altering the particle composition.

#task(label: "b")[Prove the following identities:]

#task(label: "i")[$Tr(gamma^mu gamma^nu) = 4 eta^(mu nu)$]

$
  Tr(gamma^mu gamma^nu) & = Tr({gamma^mu, gamma^nu} - gamma^nu gamma^mu) = Tr(2 eta^(mu nu) one) - Tr(gamma^nu gamma^mu) \
  & = 2 eta^(mu nu) Tr(one) - Tr(gamma^mu gamma^nu) = 8 eta^(mu nu) - Tr(gamma^mu gamma^nu) \
  ==> Tr(gamma^mu gamma^nu) & = 4 eta^(mu nu).
$

#task(label: "ii")[$Tr(gamma^mu gamma^nu gamma^sigma) = 0$]

$
  Tr(gamma^mu gamma^nu gamma^sigma) & = Tr(underbrace((gamma^5)^2, one) gamma^mu gamma^nu gamma^sigma) = -Tr(gamma^5 gamma^mu gamma^5 gamma^nu gamma^sigma) = (-1)^3 Tr(gamma^5 gamma^mu gamma^nu gamma^sigma gamma^5) = -Tr(gamma^mu gamma^nu gamma^sigma) \
  ==> Tr(gamma^mu gamma^nu gamma^sigma) & = 0.
$

#task(label: "iii")[$Tr(gamma^mu gamma^nu gamma^sigma gamma^rho) = 4 (eta^(mu nu) eta^(sigma rho) - eta^(mu sigma) eta^(nu rho) + eta^(mu rho) eta^(nu sigma))$]

$
  Tr(gamma^mu gamma^nu gamma^sigma gamma^rho) & = -Tr(gamma^nu gamma^mu gamma^sigma gamma^rho) + 2 eta^(mu nu) Tr(gamma^sigma gamma^rho) = Tr(gamma^nu gamma^sigma gamma^mu gamma^rho) + 8 eta^(mu nu) eta^(sigma rho) \
  & quad - 2 eta^(mu sigma) Tr(gamma^nu gamma^rho) = -Tr(gamma^nu gamma^sigma gamma^rho gamma^mu) + 8 eta^(mu nu) eta^(sigma rho) - 8 eta^(mu sigma) eta^(nu rho) \
  & quad + 2 eta^(mu rho) Tr(gamma^nu gamma^sigma) = -Tr(gamma^mu gamma^nu gamma^sigma gamma^rho) + 8 (eta^(mu nu) eta^(sigma rho) - eta^(mu sigma) eta^(nu rho) + eta^(mu rho) eta^(nu sigma)) \
  ==> Tr(gamma^mu gamma^nu gamma^sigma gamma^rho) & = 4 (eta^(mu nu) eta^(sigma rho) - eta^(mu sigma) eta^(nu rho) + eta^(mu rho) eta^(nu sigma)).
$

#task(label: "iv")[
  $display(sum_(s, s') [vb_(s') (p') gamma^nu u_s (p)]^* [vb_(s') (p') gamma^mu u_s (p)] = 4 [p^nu p'^mu + p^mu p'^nu - (p dot p' + m^2) eta^(mu nu)])$

  _Hint:_ You may find the following relations useful:
  $ sum_s u_s (p) ub_s (p) = gamma p + m, quad sum_s v_s (p) vb_s (p) = gamma p - m. $
]

$
  & sum_(s, s') [vb_(s') (p') gamma^nu u_s (p)]^* [vb_(s') (p') gamma^mu u_s (p)] = sum_(s, s') [underbrace(u_s^dagger (p) gamma^0, ub_s (p)) underbrace(gamma^0 gamma^(nu dagger) gamma^0, gamma^nu) v_(s') (p')] [vb_(s') (p') gamma^mu u_s (p)] \
  & = sum_s ub_s (p) gamma^nu underbrace(sum_(s') v_(s') (p') vb_(s') (p'), gamma p' - m) gamma^mu u_s (p) = sum_s (ub_s (p))_alpha (gamma^nu)_(alpha beta) (gamma p' - m)_(beta gamma) (gamma^mu)_(gamma delta) (u_s (p))_delta \
  & attach(=, t: *) Tr(gamma^nu (gamma^rho p'_rho - m) gamma^mu (gamma^sigma p_sigma + m)) = p'_rho p_sigma Tr(gamma^nu gamma^rho gamma^mu gamma^sigma) - m^2 Tr(gamma^nu gamma^mu) \
  & = p'_rho p_sigma 4 (eta^(nu rho) eta^(mu sigma) - eta^(nu mu) eta^(rho sigma) + eta^(nu sigma) eta^(rho mu)) - m^2 4 eta^(nu mu) \
  & = 4 (p^mu p'^nu - eta^(nu mu) p'_rho p^rho + p^nu p'^mu - m^2 eta^(nu mu)) = 4 [p^mu p'^nu + p^nu p'^mu - (p dot p' + m^2) eta^(mu nu)].
$
#text(size: 9.5pt)[$*$ All spinor indices are summed over, hence the result is a number. Therefore, adding a trace changes nothing.]

#task(label: "c")[
  Let $m, M$ denote the electron and muon masses, respectively. Show that
  #tagged(4, $ sum_(s, r, s', r') |cal(M)|^2 = e^4 / s^2 Tr[(gamma p' + M) gamma^mu (gamma q' - M) gamma^nu] Tr[(gamma p + m) gamma_nu (gamma q - m) gamma_mu], $)
  where $s = (p + q)^2$.
]

$
  |cal(M)|^2 = cal(M)^* cal(M) & = -i e^2 [vb_r^e (q) gamma_mu u_s^e (p)]^* 1 / (p + q)^2 [ub_(s')^m (p') gamma^mu v_(r')^m (q')]^* \
  & quad dot i e^2 [vb_r^e (q) gamma_nu u_s^e (p)] 1 / (p + q)^2 [ub_(s')^m (p') gamma^nu v_(r')^m (q')] \
  & = e^4 / s^2 [u_s^(e dagger) (p) underbrace(gamma^0 gamma^0, one) gamma_mu^dagger gamma^0 v_r^e (q)] [v_(r')^(m dagger) (q') underbrace(gamma^0 gamma^0, one) gamma^(mu dagger) gamma^0 u_(s')^m (p')] \
  & quad [vb_r^e (q) gamma_nu u_s^e (p)] [ub_(s')^m (p') gamma^nu v_(r')^m (q')] \
  & = e^4 / s^2 [ub_s^e (p) gamma_mu v_r^e (q)] [vb_(r')^m (q') gamma^mu u_(s')^m (p')] [vb_r^e (q) gamma_nu u_s^e (p)] [ub_(s')^m (p') gamma^nu v_(r')^m (q')],
$
$
  sum_(s, r, s', r') |cal(M)|^2 & = sum_(s, r, s', r') e^4 / s^2 [vb_r^e (q) gamma_mu u_s^e (p)]^* [ub_(s')^m (p') gamma^mu v_(r')^m (q')]^* [vb_r^e (q) gamma_nu u_s^e (p)] [ub_(s')^m (p') gamma^nu v_(r')^m (q')] \
  & attach(=, t: "b) iv") e^4 / s^2 Tr[(gamma p' + M) gamma^mu (gamma q' - M) gamma^nu] Tr[(gamma p + m) gamma_nu (gamma q - m) gamma_mu],
$
where the brackets are regrouped into electron and muon pairs before applying b) iv).

#task(label: "d")[
  This can be simplified further, assuming that the momentum components are sufficiently large and thus one can neglect the electron and muon masses as a good approximation. In the centre-of-mass frame,
  #grid(
    columns: (auto, 1fr),
    column-gutter: 1em,
    align: horizon,
    cmframe,
    [
      #tagged(5, $ arrow(q) = -arrow(p), quad arrow(q)' = -arrow(p)' $)
      #tagged(6, $ "and" quad q^0 = p^0 = |arrow(p)|, quad q'^0 = p'^0 = |arrow(p)'| $)
    ],
  )
  by setting $m = M = 0$. Show that
  #tagged(7, $ sum_(s, r, s', r') |cal(M)|^2 = (32 e^4) / s^2 [p dot p' thin q dot q' + p dot q' thin q dot p'] = 4 e^4 (1 + cos^2 theta), $)
  where $theta$ is the scattering angle in the centre-of-mass frame.
]

By setting $m = M = 0$, eq. (4) becomes
$
  sum_(s, r, s', r') |cal(M)|^2 & = e^4 / s^2 p'_sigma q'_rho Tr[gamma^sigma gamma^mu gamma^rho gamma^nu] p^alpha q^beta Tr[gamma_alpha gamma_nu gamma_beta gamma_mu] \
  & attach(=, t: "b) iii") e^4 / s^2 p'_sigma q'_rho 4 (eta^(sigma mu) eta^(rho nu) - eta^(sigma rho) eta^(mu nu) + eta^(sigma nu) eta^(mu rho)) p^alpha q^beta 4 (eta_(alpha nu) eta_(beta mu) - eta_(alpha beta) eta_(nu mu) + eta_(alpha mu) eta_(nu beta)) \
  & = (16 e^4) / s^2 (p'^mu q'^nu - p' dot q' eta^(mu nu) + p'^nu q'^mu) (p_nu q_mu - p dot q eta_(nu mu) + p_mu q_nu) \
  & = (16 e^4) / s^2 (p' dot q thin q' dot p - p dot q thin p' dot q' + p' dot p thin q' dot q - p' dot q' thin p dot q + 4 p' dot q' thin p dot q \
    & #h(5em) - p' dot q' thin p dot q + p' dot p thin q' dot q - p' dot q' thin p dot q + p' dot q thin q' dot p) \
  & = (32 e^4) / s^2 (p dot p' thin q dot q' + p dot q' thin p' dot q).
$
Now, in the centre-of-mass frame, we can concretize
$
  s^2 & = (p + q)^4 = (p + q)^2 (p' + q')^2 = [(underbrace(p^0 + q^0, 2 |arrow(p)|))^2 - (underbrace(arrow(p) + arrow(q), 0))^2] [(underbrace(p'^0 + q'^0, 2 |arrow(p)'|))^2 - (underbrace(arrow(p)' + arrow(q)', 0))^2] = 16 |arrow(p)|^2 |arrow(p)'|^2, \
  p dot p' thin q dot q' & = (p^0 p'^0 - arrow(p) dot arrow(p)') (q^0 q'^0 - arrow(q) dot arrow(q)') = (|arrow(p)| |arrow(p)'| - |arrow(p)| |arrow(p)'| cos theta) (|arrow(p)| |arrow(p)'| - |arrow(p)| |arrow(p)'| cos theta) \
  & = |arrow(p)|^2 |arrow(p)'|^2 (1 - 2 cos theta + cos^2 theta), \
  p dot q' thin q dot p' & = (p^0 q'^0 + arrow(p) dot arrow(p)') (q^0 p'^0 + arrow(q) dot arrow(q)') = (|arrow(p)| |arrow(p)'| + |arrow(p)| |arrow(p)'| cos theta) (|arrow(p)| |arrow(p)'| + |arrow(p)| |arrow(p)'| cos theta) \
  & = |arrow(p)|^2 |arrow(p)'|^2 (1 + 2 cos theta + cos^2 theta).
$
Assembling the above, we get
$
  sum_(s, r, s', r') |cal(M)|^2 & = (32 e^4) / s^2 [p dot p' thin q dot q' + p dot q' thin q dot p'] = (32 e^4) / (16 |arrow(p)|^2 |arrow(p)'|^2) [thin |arrow(p)|^2 |arrow(p)'|^2 (1 - 2 cos theta + cos^2 theta) \
    & #h(14em) + |arrow(p)|^2 |arrow(p)'|^2 (1 + 2 cos theta + cos^2 theta)] \
  & = (2 e^4) / (|arrow(p)|^2 |arrow(p)'|^2) 2 |arrow(p)|^2 |arrow(p)'|^2 (1 + cos^2 theta) = 4 e^4 (1 + cos^2 theta).
$

= Problem 1.3 (Symmetries of classical electrodynamics)

#task[
  We consider classical massless electrodynamics
  #tagged(8, $ cal(L)_"ED" = -1/4 F_(mu nu) F^(mu nu) + Pb gamma^mu (i partial_mu + A_mu) Psi, $)
  where the field strength is defined as $F_(mu nu) = partial_mu A_nu - partial_nu A_mu = 2 partial_(\[mu) A_(nu\])$. This theory is invariant under local $U(1)$ gauge transformations, with the fields transforming as
  #tagged(9, $ Psi(x) & --> e^(i alpha(x)) Psi(x), \
    A_mu (x) & --> A_mu (x) + partial_mu alpha(x). $)
]

#task(label: "a")[Find the equations of motion for the gauge and fermion fields.]

We derive the equations of motion by applying the principle of stationary action.

$overline(Psi)$:
$
  0 & attach(=, t: !) (delta S) / (delta Pb(y)) = delta / (delta Pb(y)) integral dd(4, x) (-1/4 F_(mu nu) F^(mu nu) + Pb(x) gamma^mu (i partial_mu + A_mu) Psi(x)) \
  & = integral dd(4, x) underbrace((delta Pb(x)) / (delta Pb(y)), delta^((4)) (x - y)) gamma^mu (i partial_mu + A_mu) Psi(x) = gamma^mu (i partial_mu + A_mu) Psi(y).
$

$Psi$: the e.o.m. for $Psi(y)$ is obtained most easily by complex conjugation of the above,
$ (gamma^mu (i partial_mu + A_mu) Psi(x))^dagger = Psi^dagger (x) (-i partial_mu + A_mu) gamma^(mu dagger) = Psi^dagger (x) (-i partial_mu + A_mu) gamma^0 gamma^mu gamma^0 = 0. $
Multiplication with $gamma^0$ from the right gives $Pb(x) (-i partial_mu + A_mu) gamma^mu = 0$.

$A_mu$:
$ 0 attach(=, t: !) (delta S) / (delta A_rho (y)) = delta / (delta A_rho (y)) integral dd(4, x) (-1/4 F_(mu nu) F^(mu nu) + Pb gamma^mu (i partial_mu + A_mu (x)) Psi). $
Here one needs to be diligent when varying the first term:
$ delta / (delta A_rho (y)) (-1/4 F^2) = -1/2 F^(mu nu) delta / (delta A_rho (y)) (2 partial_(\[mu) A_(nu\])) = -F^(mu nu) partial_(\[mu) delta_(nu\])^rho delta^((4)) (x - y), $
$
  0 attach(=, t: !) (delta S) / (delta A_rho (y)) & = integral dd(4, x) (-F^(mu nu) partial_(\[mu) delta_(nu\])^rho delta^((4)) (x - y) + Pb gamma^mu underbrace((delta A_mu (x)) / (delta A_rho (y)), delta_mu^rho delta^((4)) (x - y)) Psi) \
  & = integral dd(4, x) (1/2 (partial_mu F^(mu rho) - partial_nu F^(rho nu)) + Pb gamma^rho Psi) delta^((4)) (x - y) = partial_mu F^(mu rho) + Pb gamma^rho Psi = 0.
$

#task(label: "b")[
  The energy-momentum tensor, $T^mu_nu$, is the conserved Noether current associated with the spacetime translations
  #tagged(10, $ x^mu --> x'^mu = x^mu - a^nu delta_nu^mu, $)
  with the fields transforming as
  #tagged(11, $ A_mu (x) & --> A'_mu (x') = A_mu (x), \
    Psi(x) & --> Psi'(x') = Psi(x). $)
]

#task(label: "i")[
  Show that, for classical electrodynamics, the energy-momentum tensor is given by
  #tagged(12, $ T^mu_nu = -F^(mu rho) partial_nu A_rho + delta^mu_nu (1/4 F_(rho sigma) F^(rho sigma)) + i Pb gamma^mu partial_nu Psi. $)
  _Hint:_ Noether's theorem states that given a symmetry transformation parametrised by $epsilon^a$ ($a$ runs over the number of independent transformations, e.g. $a in {1}$ for a $U(1)$ symmetry or $a = nu in {0, 1, 2, 3}$ for spacetime translations) inducing the infinitesimal transformations
  #tagged(13, $ x^mu & --> x'^mu = x^mu - epsilon^a cal(X)^mu_a + cal(O)(epsilon^2), \
    chi_i (x) & --> chi'_i (x) = chi_i (x) + epsilon^a Delta_(a i) + cal(O)(epsilon^2), quad [#text(size: 9pt)[note:] chi'_i (x), "not" chi'_i (x')] $)
  where $chi_i$ is any field depending on the transformed quantity, there exists a conserved current
  #tagged(14, $ J^mu_a = (partial cal(L)) / (partial(partial_mu chi_i)) Delta_(a i) - cal(X)^mu_a cal(L). $)
]

First, we remark that Noether's theorem is only valid on-shell, i.e. after imposing the equations of motion. Now, comparing our transformation to the one given in the hint, we see that the latter can be converted into the former via the assignments
$ x^mu --> x'^mu = x^mu - a^nu delta^mu_nu, quad x^mu --> x'^mu = x^mu - epsilon^a cal(X)^mu_a + cal(O)(epsilon^2) quad ==> quad cases(epsilon^a -> a^nu, cal(X)^mu_a -> delta^mu_nu) $
$ A_mu (x) --> A'_mu (x') = A_mu (x) quad ==> quad A'_mu (x) = A_mu (T^(-1) x) = A_mu (x + a) quad (attach(=, t: !) A_mu (x) + a^nu Delta_nu), $
$ A'_mu (x) = A_mu (x) + a^nu underbrace(partial_nu A_mu (x), (Delta^A)_(mu nu)) + cal(O)(a^2), $
where $T$ marks our spacetime transformation and $T^(-1)$ its inverse/back-transformation. Doing the same for $Psi(x)$, we see
$
  Psi(x) --> Psi'(x') = Psi(x) quad ==> quad Psi'(x) & = Psi(T^(-1) x) = Psi(x + a) \
  & = Psi(x) + a^nu underbrace(partial_nu Psi(x), Delta^Psi_nu) + cal(O)(a^2).
$
Therefore, $(Delta^A)^mu_nu = partial_nu A^mu$ and $Delta^Psi_nu = partial_nu Psi$. With this, we may assemble the energy-momentum tensor
$
  T^mu_nu & = sum_("sum over" \ "field d.o.f.") (partial cal(L)) / (partial(partial_mu chi_i)) Delta_(a i) - cal(X)^mu_a cal(L) \
  & --> (partial cal(L)) / (partial(partial_mu A_rho)) (Delta^A)_(rho nu) + (partial cal(L)) / (partial(partial_mu Psi)) Delta^Psi_nu + underbrace((partial cal(L)) / (partial(partial_mu Pb)), 0) Delta^(Pb)_nu - delta^mu_nu cal(L),
$
where
$
  (partial cal(L)) / (partial(partial_mu A_rho)) & = -1/2 F^(alpha beta) partial / (partial(partial_mu A_rho)) (partial_alpha A_beta - partial_beta A_alpha) = -1/2 F^(alpha beta) (delta^mu_alpha delta^rho_beta - delta^mu_beta delta^rho_alpha) \
  & = -1/2 (F^(mu rho) - F^(rho mu)) = -F^(mu rho), \
  (partial cal(L)) / (partial(partial_mu Psi)) & = i Pb gamma^mu,
$
$
  T^mu_nu & = -F^(mu rho) partial_nu A_rho + i Pb gamma^mu partial_nu Psi + 1/4 delta^mu_nu F_(alpha beta) F^(alpha beta) - delta^mu_nu underbrace(Pb gamma^rho (i partial_rho + A_rho) Psi, "0, using e.o.m.") \
  & = #box(stroke: 0.6pt, inset: 4pt, $-F^(mu rho) partial_nu A_rho + 1/4 delta^mu_nu F_(alpha beta) F^(alpha beta) + i Pb gamma^mu partial_nu Psi$).
$

#task(label: "ii")[Show that $T^mu_nu$ is not gauge invariant.]

Under the local $U(1)$ gauge transformation, we have
$ Psi(x) --> e^(i alpha(x)) Psi(x), quad A_mu (x) --> A_mu + partial_mu alpha(x). $
We see immediately that transforming $Psi$ does not change $T^mu_nu$. Under the $A_mu (x)$-transformation, however, we obtain
$
  F_(mu nu) = partial_mu A_nu - partial_nu A_mu --> & partial_mu A_nu + partial_mu partial_nu alpha(x) - partial_nu A_mu - partial_nu partial_mu alpha(x) \
  & = F_(mu nu) + underbrace((partial_mu partial_nu - partial_nu partial_mu), 0) alpha(x),
$
where the derivatives vanish by Schwarz' theorem since $alpha(x)$ is taken to have continuous second partial derivatives at all points in spacetime. So apparently, only the first term of $T^mu_nu$ changes under a local $U(1)$ gauge transformation,
$ T^mu_nu --> T^mu_nu - F^(mu rho) partial_nu partial_rho alpha(x) != T^mu_nu, $
which can therefore not be offset, rendering $T^mu_nu$ gauge variant.

#task(label: "c")[
  We may restore gauge invariance by 'improving' the energy-momentum tensor. A conserved current $J^mu_a$ can always be improved with the help of a (non-conserved) antisymmetric tensor, $L^(mu nu)_a = -L^(nu mu)_a$.
]

#task(label: "i")[
  Show that the improved current
  #tagged(15, $ tilde(J)^mu_a = J^mu_a + partial_nu L^(mu nu)_a $)
  is also conserved and gives rise to the same conserved charge, $tilde(Q)_a$, as that of $J^mu_a$. _Hint:_ Recall that $Q_a = integral dd(3, x) J^0_a$.
]

$tilde(J)^mu_a$ is conserved if its total derivative, $partial_mu tilde(J)^mu_a$, vanishes. This is the case:
$ partial_mu tilde(J)^mu_a = partial_mu (J^mu_a + partial_nu L^(mu nu)_a) = underbrace(partial_mu J^mu_a, 0) + underbrace(partial_mu partial_nu L^(mu nu)_a, 0) = 0, $
where the first term vanishes because $J^mu_a$ is conserved and the second because it is a fully contracted sum antisymmetric under the exchange of indices, i.e.
$ partial_mu partial_nu L^(mu nu)_a = -partial_nu partial_mu L^(nu mu)_a attach(=, t: mu <-> nu) -partial_mu partial_nu L^(mu nu)_a quad ==> quad partial_mu partial_nu L^(mu nu)_a = 0, $
$ tilde(Q)_a = integral dd(3, x) tilde(J)^0_a = underbrace(integral dd(3, x) J^0_a, Q_a) + integral dd(3, x) partial_nu L^(0 nu)_a = Q_a + underbrace(integral dd(3, x) partial_0 L^(00)_a, 0) + underbrace(integral dd(3, x) partial_i L^(0 i)_a, 0). $
Here, $L^(00)_a = 0$ because $L^(mu nu)_a = -L^(nu mu)_a$. The last term above vanishes after applying Gauss' theorem to turn it into a surface integral at infinity, where we take our current to be zero.

#task(label: "ii")[
  Now, focussing on the limit $Psi, Pb -> 0$ for simplicity, use the equations of motion to find the antisymmetric tensor $Lt$ that improves the energy-momentum tensor, restoring gauge invariance, i.e.
  #tagged(16, $ Th^mu_nu |_(Psi = Pb = 0) = (T^mu_nu + partial_rho Lt) |_(Psi = Pb = 0) = -F^(mu rho) F_(nu rho) + 1/4 delta^mu_nu F_(rho sigma) F^(rho sigma). $)
]

In the limit $Psi, Pb -> 0$, our energy-momentum tensor becomes
$ T^mu_nu = -F^(mu rho) partial_nu A_rho + 1/4 delta^mu_nu F_(rho sigma) F^(rho sigma) + i Pb gamma^mu partial_nu Psi quad attach(-->, t: Psi\, Pb -> 0) quad -F^(mu rho) partial_nu A_rho + 1/4 delta^mu_nu F_(rho sigma) F^(rho sigma), $
while the equation of motion for $A_mu (x)$ simplifies to
$ partial_mu F^(mu nu) + Pb gamma^nu Psi = 0 quad --> quad partial_mu F^(mu nu) = 0. $
To find $Lt$, we insert our old energy-momentum tensor $T^mu_nu$ in the $Psi, Pb -> 0$ limit into the improved energy-momentum tensor and solve for $Lt$:
$
  Th^mu_nu = T^mu_nu + partial_rho Lt & = -F^(mu rho) partial_nu A_rho + 1/4 delta^mu_nu F_(rho sigma) F^(rho sigma) + partial_rho Lt \
  & attach(=, t: !) -F^(mu rho) F_(nu rho) + 1/4 delta^mu_nu F_(rho sigma) F^(rho sigma) quad "(see eq. (16))"
$
$
  ==> partial_rho Lt & = -F^(mu rho) F_(nu rho) + F^(mu rho) partial_nu A_rho = F^(mu rho) partial_rho A_nu \
  & = F^(mu rho) partial_rho A_nu + underbrace(partial_rho F^(mu rho), "0, e.o.m.") A_nu = partial_rho underbrace((F^(mu rho) A_nu), Lt).
$

#task(label: "d")[
  Finally, massless electrodynamics has one additional symmetry: spacetime symmetries are enhanced with scale invariance,
  #tagged(17, $ x^mu & --> x'^mu = e^(-beta) x^mu, \
    A_mu (x) & --> A'_mu (x') = e^beta A_mu (x), quad beta in RR, \
    Psi(x) & --> Psi'(x') = e^(3/2 beta) Psi(x) quad [#text(size: 9pt)[more general:] chi_i (x) --> chi'_i (x') = e^(dim(chi_i) beta) chi_i (x)] $)
  in addition to the usual Poincaré invariance.
]

#task(label: "i")[Show that the action $S = integral dd(4, x) cal(L)_"ED"$ is invariant under scale transformations.]

The electrodynamics Lagrangian $cal(L)_"ED"$ as given in eq. (8),
$ cal(L)_"ED" = -1/4 F_(mu nu) F^(mu nu) + Pb gamma^mu (i partial_mu + A_mu) Psi, $
can be seen to transform like $cal(L)_"ED" -> cal(L)'_"ED" = e^(4 beta) cal(L)_"ED"$ under scaling most easily by looking at its last term,
$ Pb gamma^mu A_mu Psi --> Pb' gamma^mu A'_mu Psi' = e^(3/2 beta) Pb gamma^mu e^beta A_mu e^(3/2 beta) Psi = e^(4 beta) Pb gamma^mu A_mu Psi. $
Therefore, the action $S$ as a whole is unaffected by scaling:
$ S --> S' = integral dd(4, x') cal(L)'_"ED" = integral dd(4, x) e^(-4 beta) e^(4 beta) cal(L)_"ED" = integral dd(4, x) cal(L)_"ED" = S. $

#task(label: "ii")[
  Show that the associated current, $S^mu$, can be written as
  #tagged(18, $ S^mu = x^nu T^mu_nu + U^mu, $)
  and give an expression for $U^mu$.
]

$S^mu$ is constructed by calculating the following terms
$ S^mu = underbrace((partial cal(L)) / (partial(partial_mu A_nu)), -F^(mu nu)) Delta^(A)_nu + underbrace((partial cal(L)) / (partial(partial_mu Psi)), i Pb gamma^mu) Delta^Psi + underbrace((partial cal(L)) / (partial(partial_mu Pb)), 0) Delta^(Pb) - x^mu cal(L). $
To obtain $Delta^A_mu$ and $Delta^Psi$, we need to know how the fields transform. By Taylor expanding the transformation rules in eq. (17) to linear order, we get
$
  A'_mu (x) & = e^beta A_mu (T^(-1) x) = e^beta A_mu (e^beta x) = A_mu (x) + beta (A_mu (x) + x^nu partial_nu A_mu (x)) + cal(O)(beta^2), \
  Psi'(x) & = e^(3/2 beta) Psi(T^(-1) x) = e^(3/2 beta) Psi(e^beta x) = Psi(x) + beta (3/2 Psi(x) + x^nu partial_nu Psi(x)) + cal(O)(beta^2).
$
Therefore, $Delta^A_mu (x) = A_mu (x) + x^nu partial_nu A_mu (x) = A_mu (x) + x^nu Delta^"EMT"_(mu nu)$ and $Delta^Psi = 3/2 Psi(x) + x^nu partial_nu Psi(x) = 3/2 Psi(x) + x^nu Delta^"EMT"_nu$ (EMT: the field variations of the energy-momentum tensor from part b).
$
  S^mu & = -F^(mu nu) (A_nu + x^rho Delta^"EMT"_(nu rho)) + i Pb gamma^mu (3/2 Psi + x^nu Delta^"EMT"_nu) - x^mu cal(L) \
  & = -F^(mu nu) A_nu + 3/2 i Pb gamma^mu Psi + x^nu (-F^(mu rho) Delta^"EMT"_(rho nu) + i Pb gamma^mu Delta^"EMT"_nu - delta^mu_nu cal(L)) = U^mu + x^nu T^mu_nu.
$
