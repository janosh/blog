#import "/notes.typ": dd, notes, task
#import "@preview/cetz:0.5.2": canvas, decorations, draw

#show: notes.with(
  title: [Model Questions for the Exam],
  subtitle: [Quantum Field Theory I, by Martin Bies],
  date: [Solutions by Janosh Riebesell],
)

// Feynman diagram helpers: fermion lines carry an arrow at their midpoint, photons are wavy,
// scalars dashed. Coordinates are plain (x, y) tuples in units of `length`.
#let feyn(body, length: 0.95cm) = box(baseline: 50%, canvas(length: length, {
  import draw: *
  set-style(stroke: 0.7pt)
  body
}))
#let lerp(a, b, t) = (a.at(0) + t * (b.at(0) - a.at(0)), a.at(1) + t * (b.at(1) - a.at(1)))
#let fermion(a, b, at: 0.58) = {
  draw.line(a, lerp(a, b, at), mark: (end: "stealth", fill: black, scale: 0.55))
  draw.line(lerp(a, b, at - 0.08), b)
}
#let photon(a, b) = decorations.wave(draw.line(a, b), amplitude: 0.08, segment-length: 0.17)
#let scalar(a, b) = draw.line(a, b, stroke: (dash: "dashed", thickness: 0.7pt))
#let vtx(pt) = draw.circle(pt, radius: 0.05, fill: black, stroke: none)
#let lbl(pt, body, anchor: "center") = draw.content(pt, text(size: 8pt, body), anchor: anchor)

= Exercise 1

#task[Let us consider QED.]

#task(label: "a")[Draw all diagrams that contribute to $e^- + e^- -> e^- + e^-$ up to order 2. Give interpretations of all diagrams.]

#let electron-pair(top: true, bottom: true) = {
  if top { fermion((0, 1.2), (3, 1.2)) }
  if bottom { fermion((0, 0), (3, 0)) }
  lbl((-0.1, 1.2), $e^-$, anchor: "east")
  lbl((3.1, 1.2), $e^-$, anchor: "west")
  lbl((-0.1, 0), $e^-$, anchor: "east")
  lbl((3.1, 0), $e^-$, anchor: "west")
}

#let D1 = feyn({
  electron-pair()
  lbl((1.5, 1.35), $p, s$, anchor: "south")
  lbl((1.5, 0.15), $k, r$, anchor: "south")
})
#let D2 = feyn({
  electron-pair(top: false, bottom: false)
  fermion((0, 1.2), (1.5, 1.2))
  fermion((1.5, 1.2), (3, 1.2))
  fermion((0, 0), (1.5, 0))
  fermion((1.5, 0), (3, 0))
  photon((1.5, 1.2), (1.5, 0))
  lbl((0.75, 1.35), $p, s$, anchor: "south")
  lbl((2.25, 1.35), $p', s'$, anchor: "south")
  lbl((0.75, 0.15), $k, r$, anchor: "south")
  lbl((2.25, 0.15), $k', r'$, anchor: "south")
  lbl((1.5, 1.35), $mu$, anchor: "south")
  lbl((1.5, -0.15), $nu$, anchor: "north")
  lbl((1.35, 0.6), $gamma$, anchor: "east")
  lbl((1.65, 0.6), $q = p - p'$, anchor: "west")
})
#let D3 = feyn({
  electron-pair(top: false)
  fermion((0, 1.2), (0.75, 1.2))
  fermion((0.75, 1.2), (2.25, 1.2))
  fermion((2.25, 1.2), (3, 1.2))
  decorations.wave(draw.arc((2.25, 1.2), start: 0deg, stop: 180deg, radius: 0.6), amplitude: 0.07, segment-length: 0.16)
  lbl((1.5, 1.9), $gamma$, anchor: "south")
})
#let D4 = feyn({
  electron-pair()
  draw.circle((1.5, 0.6), radius: (0.65, 0.38))
  draw.line((1.5, 0.98), (1.58, 0.98), mark: (end: "stealth", fill: black, scale: 0.5))
  draw.line((1.5, 0.22), (1.42, 0.22), mark: (end: "stealth", fill: black, scale: 0.5))
  photon((0.85, 0.6), (2.15, 0.6))
  lbl((2.14, 0.88), $e^-$, anchor: "west")
  lbl((2.14, 0.32), $e^-$, anchor: "west")
  lbl((1.5, 0.42), $gamma$)
})
#let D5 = feyn({
  fermion((0, 1.2), (0.8, 1.2))
  fermion((0, 0), (0.8, 0))
  fermion((0.8, 1.2), (3, 0), at: 0.85)
  fermion((0.8, 0), (3, 1.2), at: 0.85)
  photon((0.8, 1.2), (0.8, 0))
  lbl((-0.1, 1.2), $e^-$, anchor: "east")
  lbl((-0.1, 0), $e^-$, anchor: "east")
  lbl((3.1, 1.2), $e^-$, anchor: "west")
  lbl((3.1, 0), $e^-$, anchor: "west")
  lbl((0.35, 1.35), $p, s$, anchor: "south")
  lbl((0.35, -0.15), $k, r$, anchor: "north")
  lbl((2.6, 1.25), $p', s'$, anchor: "south")
  lbl((2.45, 0.42), $k', r'$, anchor: "south-west")
  lbl((0.55, 0.6), $q = p - k'$, anchor: "east")
})

#let labeled(d, name) = box(align(center, stack(spacing: 6pt, d, name)))

#grid(
  columns: (auto, 1fr, 1fr),
  align: horizon + center,
  column-gutter: 8pt,
  row-gutter: 16pt,
  $e^0$, labeled(D1, $D_1$), [$e^1$: no diagrams possible with just one vertex for this process],
  $e^2$, labeled(D2, $D_2$), labeled(D3, $D_3$),
  [], labeled(D4, $D_4$), labeled(D5, $D_5$),
)

/ $D_1$: no scattering or trivial scattering
/ $D_2$: real scattering (fully connected, amputated diagram, hence needs to be computed explicitly, is not taken care of implicitly)
/ $D_3$: charge renormalization
/ $D_4$: vacuum renormalization
/ $D_5$: real scattering (another fully connected, amputated diagram)

#task(label: "b")[Without justification, state if the following is true: Be $D$ a Feynman diagram in QED, then $S(D) = 1$.]

This statement is true. All symmetry factors in QED are one.

#task(label: "c")[Identify the fully connected diagrams in part a). Use the momentum space Feynman rules and your answer to part b) to write down their algebraic expressions.]

The full scattering amplitude of a diagram to order $n$ is given by
$ i cal(M)_f = sum_(k = 0)^n sum_i 1/S(D_i) D_i, $
where $i$ sums over all fully connected, amputated diagrams at order $k$. In the case of $e^- + e^- -> e^- + e^-$ we have
$
  i cal(M)_(e^- e^- -> e^- e^-) & = 1/S(D_2) D_2 + 1/S(D_5) D_5 attach(=, t: "b)") D_2 + D_5 \
  & = macron(u)_(s') (p') (-i e gamma^mu) u_s (p) (-i eta_(mu nu))/(p - p')^2 macron(u)_(r') (k') (-i e gamma^nu) u_r (k) \
  & quad - macron(u)_(r') (k') (-i e gamma^mu) u_s (p) (-i eta_(mu nu))/(p - k')^2 macron(u)_(s') (p') (-i e gamma^nu) u_r (k) \
  & = i/2 e^2 (macron(u)_(s') (p') gamma^mu u_s (p) 1/(m^2 - p p') macron(u)_(r') (k') gamma_mu u_r (k) - macron(u)_(r') (k') gamma^mu u_s (p) 1/(m^2 - p k') macron(u)_(s') (p') gamma_mu u_r (k)).
$

#task(label: "d")[What is the amplitude of the process $e^- + e^- -> gamma$ to all orders in perturbation theory? Justify your answer.]

The scattering amplitude $i cal(M)_(e^- e^- -> gamma)$ is zero to every order in a perturbative expansion because it is not permitted by basic physical laws. It violates both momentum and charge conservation.

#task(label: "e")[Now consider the process $e^- + e^+ -> e^- + e^+$. Draw the fully connected diagrams at order two. Then write down the corresponding algebraic expression.]

#let t-channel = feyn({
  fermion((0, 1.2), (1.5, 1.2))
  fermion((1.5, 1.2), (3, 1.2))
  fermion((1.5, 0), (0, 0))
  fermion((3, 0), (1.5, 0))
  photon((1.5, 1.2), (1.5, 0))
  lbl((-0.1, 1.2), $e^-$, anchor: "east")
  lbl((3.1, 1.2), $e^-$, anchor: "west")
  lbl((-0.1, 0), $e^+$, anchor: "east")
  lbl((3.1, 0), $e^+$, anchor: "west")
  lbl((0.75, 1.35), $p, s$, anchor: "south")
  lbl((2.25, 1.35), $p', s'$, anchor: "south")
  draw.line((0.45, -0.25), (1.05, -0.25), mark: (end: "stealth", fill: black, scale: 0.45), stroke: 0.5pt)
  draw.line((1.95, -0.25), (2.55, -0.25), mark: (end: "stealth", fill: black, scale: 0.45), stroke: 0.5pt)
  lbl((0.75, -0.35), $k, r$, anchor: "north")
  lbl((2.25, -0.35), $k', r'$, anchor: "north")
  lbl((1.5, 1.35), $mu$, anchor: "south")
  lbl((1.5, -0.12), $nu$, anchor: "north")
  lbl((1.35, 0.6), $gamma$, anchor: "east")
  lbl((1.65, 0.6), $q = p - p'$, anchor: "west")
})
#let s-channel = feyn({
  fermion((0, 1.2), (0.8, 0.6))
  fermion((0.8, 0.6), (0, 0))
  photon((0.8, 0.6), (2.8, 0.6))
  fermion((2.8, 0.6), (3.6, 1.2))
  fermion((3.6, 0), (2.8, 0.6))
  lbl((-0.1, 1.2), $e^-$, anchor: "east")
  lbl((-0.1, 0), $e^+$, anchor: "east")
  lbl((3.7, 1.2), $e^-$, anchor: "west")
  lbl((3.7, 0), $e^+$, anchor: "west")
  lbl((0.45, 1.05), $p, s$, anchor: "south-west")
  // positron momentum arrows below the legs, as on the t-channel diagram
  draw.line((0.31, 0.01), (0.71, 0.31), mark: (end: "stealth", fill: black, scale: 0.45), stroke: 0.5pt)
  draw.line((2.89, 0.31), (3.29, 0.01), mark: (end: "stealth", fill: black, scale: 0.45), stroke: 0.5pt)
  lbl((0.5, -0.05), $k, r$, anchor: "north")
  lbl((3.15, 1.05), $p', s'$, anchor: "south-east")
  lbl((3.1, -0.05), $k', r'$, anchor: "north")
  lbl((0.88, 0.7), $nu$, anchor: "south-west")
  lbl((2.72, 0.7), $mu$, anchor: "south-east")
  lbl((1.8, 0.75), $gamma$, anchor: "south")
  lbl((1.8, 0.45), $q = p + k$, anchor: "north")
})

$
  i cal(M)_(e^- e^+ -> e^- e^+) & = #t-channel quad - quad #s-channel \
  & = macron(u)_(s') (p') (-i e gamma^mu) u_s (p) (-i eta_(mu nu))/(p - p')^2 macron(v)_r (k) (-i e gamma^nu) v_(r') (k') \
  & quad - macron(u)_(s') (p') (-i e gamma^mu) v_(r') (k') (-i eta_(mu nu))/(p + k)^2 macron(v)_r (k) (-i e gamma^nu) u_s (p) \
  & = i/2 e^2 (macron(u)_(s') (p') gamma^mu u_s (p) 1/(m^2 - p p') macron(v)_r (k) gamma_mu v_(r') (k') - macron(u)_(s') (p') gamma^mu v_(r') (k') 1/(m^2 + p k) macron(v)_r (k) gamma_mu u_s (p)).
$

#task(label: "f")[Add the contributions to $e^- + e^+ -> e^- + e^+$ from part e) to form $i cal(M)$. Are there relative minus signs? Justify your answer. Repeat this task for the results obtained in part c).]

There is a relative minus sign in both cases. In c), we get it because two lines cross, hence exchanging the two fermions gives back the other diagram times a minus sign for the electron exchange. The reasoning in e) is similar except that we also need to employ a rotation of the diagram or a relabelling of time and space axes to convert one diagram into the other.

= Exercise 2

#task[
  Consider the Lagrangian
  $ cal(L) = 1/2 partial_mu phi partial^mu phi - 1/2 m^2 phi^2 + macron(Psi) (i gamma^mu partial_mu - m) Psi - g phi macron(Psi) Psi - lambda/4! phi^4 + i e gamma^mu macron(Psi) A_mu Psi. $
]

#task(label: "a")[
  Justify that the following holds for the mass dimensions:
  $ ["mass"] = ["energy"] = ["length"^(-1)] = ["time"^(-1)]. $
  _Hint:_ Recall what units you are working in.
]

We employ natural units, where we set $planck = c = 1$. Under these circumstances, Einstein's famous equation $E = m c^2$ becomes $E = m$ and hence $[E] = [m]$. From $planck = 1$, we know that $0 = [planck] = [S]$ and can deduce $0 = [S] = [dif t thin L]$. Since $L = T - V$, it has to have mass dimension $[L] = [E] = 1$ and therefore $[dif t] = [t] = -1$. From $0 = [c] = [nu dot lambda] = [1/t] + [d] = 1 + [d]$, we conclude $[d] = -1$.

#task(label: "b")[What is the mass dimension of the action $S = integral dd(4, x) cal(L)$? What are the mass dimensions of the fields in the Lagrangian? (Assume $[e] = 0$.)]

As remarked in a), $[S] = 0$. Hence $0 = [S] = [dd(4, x) cal(L)] = -4 + [cal(L)]$, $[cal(L)] = 4$. This results in
$
  4 & = [cal(L)] = [m^2 phi^2] = 2 + 2 [phi] & quad ==> quad [phi] & = 1, \
  4 & = [cal(L)] = [m macron(Psi) Psi] = 1 + 2 [Psi] & quad ==> quad [Psi] & = 3/2, \
  4 & = [cal(L)] = [macron(Psi) A_mu Psi] = 2 dot 3/2 + [A_mu] & quad ==> quad [A_mu] & = 1.
$

#task(label: "c")[What representations of $"Spin"(1,3)$ do the fields $phi, Psi$ belong to / transform in? Does $A_mu$ also transform in a representation of $"Spin"(1,3)$? What is the general relation between representations of $"Spin"(1,3)$ and particles in QFT? _Bonus:_ What representation of $U(1)$ does $A_mu$ transform in?]

The fermionic fields $Psi$ and $Psi^dagger$ transform in the Dirac spinor representation of $"Spin"(1,3)$.

We know that as a representation of the Lorentz algebra $frak(s o)(1,3)$
- the scalar fields $phi$ and $phi^dagger$ transform in what is called the trivial, scalar or fundamental representation
  $ R_f (Lambda) = bb(1) quad forall Lambda, $
- the vector field $A^mu$ transforms in the vector representation defined as
  $ [R_v (Lambda)]^mu_(med nu) = Lambda^mu_(med nu) quad forall Lambda. $

We can now use that there exists a group homomorphism $pi$ between the Lorentz algebra $frak(s o)(1,3)$ and $"Spin"(1,3)$. Thus, $phi$ and $A_mu$ as representations of $"Spin"(1,3)$ transform under the representation obtained by composing their $frak(s o)(1,3)$ representations with the group homomorphism $pi$, i.e.
$
  pi R_f (Lambda) & : "Spin"(1,3) --> frak(s o)(1,3) --> V = RR, \
  pi [R_v (Lambda)]^mu_(med nu) & : "Spin"(1,3) --> frak(s o)(1,3) --> V = RR^(1,3),
$
where $V$ denotes each representation's representation space.

New representations of $"Spin"(1,3)$ are often found to describe new particles in quantum field theory.

$A_mu$ transforms in the adjoint representation of $U(1)$.

#task(label: "d")[Draw pictures of all interaction vertices in the quantum field theory based on $cal(L)$. Explain your symbols, arrows etc.]

#let yukawa = feyn({
  fermion((0, 1.2), (0.8, 0.6))
  fermion((0.8, 0.6), (0, 0))
  scalar((0.8, 0.6), (2.2, 0.6))
  vtx((0.8, 0.6))
  lbl((-0.1, 1.2), $Psi$, anchor: "east")
  lbl((-0.1, 0), $macron(Psi)$, anchor: "east")
  lbl((2.3, 0.6), $phi$, anchor: "west")
  lbl((0.9, 0.7), $g$, anchor: "south-west")
})
#let quartic = feyn({
  for p in ((0, 1.2), (1.6, 1.2), (0, 0), (1.6, 0)) { scalar(p, (0.8, 0.6)) }
  vtx((0.8, 0.6))
  lbl((-0.1, 1.2), $phi$, anchor: "east")
  lbl((-0.1, 0), $phi$, anchor: "east")
  lbl((1.7, 1.2), $phi$, anchor: "west")
  lbl((1.7, 0), $phi$, anchor: "west")
  lbl((0.8, 0.45), $lambda$, anchor: "north")
})
#let qed-vertex = feyn({
  fermion((0, 1.2), (0.8, 0.6))
  fermion((0.8, 0.6), (0, 0))
  photon((0.8, 0.6), (2.2, 0.6))
  vtx((0.8, 0.6))
  lbl((-0.1, 1.2), $Psi$, anchor: "east")
  lbl((-0.1, 0), $macron(Psi)$, anchor: "east")
  lbl((2.3, 0.6), $gamma$, anchor: "west")
  lbl((0.9, 0.7), $e$, anchor: "south-west")
})

#align(center, grid(columns: 3, column-gutter: 3em, yukawa, quartic, qed-vertex))

Continuous lines indicate fermions, dashed lines scalar particles and curvy lines vector bosons, i.e. photons. Arrows depict negative charge / fermion number flow.

#task(label: "e")[Be $D$ a Feynman diagram in the quantum field theory based on $cal(L)$. Is the following true: $S(D) = 1$? Prove it or give a counterexample.]

#let tadpole = feyn({
  scalar((0, 0), (2, 0))
  draw.circle((1, 0.35), radius: 0.35, stroke: (dash: "dashed", thickness: 0.7pt))
  vtx((1, 0))
})

Counterexample: #tadpole has $S(D) = 2$.

#task(label: "f")[Draw a vacuum bubble that involves all fields $phi$, $Psi$, $macron(Psi)$ and $A_mu$.]

#align(center, feyn({
  fermion((1.2, 1.2), (0, 1.2))
  fermion((0, 1.2), (0, 0))
  fermion((0, 0), (1.2, 0))
  fermion((1.2, 0), (1.2, 1.2))
  draw.arc((0, 1.2), start: 90deg, stop: 270deg, radius: 0.6, stroke: (dash: "dashed", thickness: 0.7pt))
  decorations.wave(draw.arc((1.2, 0), start: -90deg, stop: 90deg, radius: 0.6), amplitude: 0.07, segment-length: 0.16)
  for p in ((0, 0), (0, 1.2), (1.2, 0), (1.2, 1.2)) { vtx(p) }
}))
