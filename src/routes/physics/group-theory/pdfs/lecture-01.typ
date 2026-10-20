#import "/notes.typ": notes

#show: notes.with(
  title: [Group Theory],
  subtitle: [Lecture 1, Group Theory, Prof. Daniel Roggenkamp],
  date: [Lecture notes by Janosh Riebesell, 15.04.2015],
)

// margin remarks of the handwritten notes
#let aside(body) = text(size: 9pt, fill: luma(80), body)

#align(right, aside[No exam, no tutorial. \ Problem sets (ca. every two weeks or so ...)])

= Introduction

#box(stroke: 0.6pt, inset: (x: 4pt, y: 3pt))[*Symmetry*]

#grid(
  columns: (1fr, 1fr),
  column-gutter: 2em,
  [
    - guiding principle to devise models of physical systems.
    - special/general relativity postulated from symmetry considerations
    - particle spectrum of SM is governed by gauge group: $"SU"(3) times "SU"(2) times "U"(1)$
  ],
  [
    - symmetries can be used to solve theories.

    Noether theorem: continuous symmetries
    $ arrow.b.t $
    #align(center)[integrals of motion \ conserved charges]

    example: spectrum of H-atom is fixed by representation theory
  ],
)

#v(0.5em)
#align(center)[
  Mathematical tool to study symmetries: \
  #box(stroke: 0.6pt, inset: (x: 6pt, y: 4pt))[Group + Representations]
]

#v(0.5em)
#underline[*Aim*]: introduction to group theory/representation theory

*Topics covered:*
- Abstract groups
- Representation theory
- Finite groups ($S_n$)
- Lie groups/-algebras ($"SU"(n)$, Poincaré group)
- Projective representations (central extension) \
  $->$ QM setup (explain occurrence of $"SU"(2)$)
- (Clifford algebra)

*Literature:*
- Fulton, Harris. _Representation Theory._
- Hamermesh. _Group Theory and its Application._
- Ma. _Group Theory for Physicists._
- Tung. _Group Theory in Physics._
- Burns. _Introduction to Group Theory._
- Fuchs, Schweigert. _Symmetries, Lie Algebras._
- Knapp. _Lie Groups Beyond an Introduction._
