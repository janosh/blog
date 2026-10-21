#import "/notes.typ": task, vb, kB, tr, one, ev, bra, ket, braket, eqby
#import "/statistical-physics/sheet.typ": points, sheet, cH
#import "@preview/cetz:0.5.2": canvas, draw
#import "@preview/cetz-plot:0.1.4": plot

#show: sheet.with(10, [January 20th, 2017])

#let (ba, bs, bsigma, bfb) = ($vb(a)$, $vb(s)$, $vb(sigma)$, $vb(b)$)
#let Zm = $Z_m^Delta$

// Bloch sphere with the Bloch vector a, its polar angle theta and azimuth phi
#let bloch-sphere = canvas(length: 1.25cm, {
  import draw: *
  set-style(stroke: 0.6pt)
  let r = 1.9
  let dashed = (dash: "dashed", thickness: 0.5pt)
  circle((0, 0), radius: r)
  arc((r, 0), start: 0deg, stop: 180deg, radius: (r, 0.55), stroke: dashed)
  arc((-r, 0), start: 180deg, stop: 360deg, radius: (r, 0.55), stroke: dashed)
  let arrow = (end: "stealth", fill: black, scale: 0.5)
  line((0, 0), (0, r), mark: arrow)
  line((0, 0), (r, 0), mark: arrow)
  line((0, 0), (-0.75, -1.0), mark: arrow)
  content((0, r), $x_3$, anchor: "south", padding: 2pt)
  content((r, 0), $x_2$, anchor: "west", padding: 2pt)
  content((-0.75, -1.0), $x_1$, anchor: "north", padding: 2pt)
  let a = (0.7, 1.0)
  line((0, 0), a, stroke: 0.7pt)
  circle(a, radius: 0.04, fill: black)
  content(a, $ba$, anchor: "south", padding: 3pt)
  line(a, (0.7, -0.4), stroke: (paint: luma(120), dash: "dashed", thickness: 0.5pt))
  line((0, 0), (0.7, -0.4), stroke: (paint: luma(120), dash: "dashed", thickness: 0.5pt))
  arc((0, 0.45), start: 90deg, stop: 55deg, radius: 0.45, stroke: luma(120) + 0.4pt)
  content((0.12, 0.62), text(size: 8pt, fill: luma(100), $theta$))
  arc((-0.17, -0.22), start: 230deg, stop: 330deg, radius: 0.28, stroke: luma(120) + 0.4pt, mark: (end: "stealth", fill: luma(120), scale: 0.4))
  content((-0.05, -0.15), text(size: 8pt, fill: luma(100), $phi$))
})

// expected energy of the degenerate oscillator as a function of beta (hbar omega = 1) and of
// omega (k_B T = 1)
#let energy-plots = grid(
  columns: 2,
  column-gutter: 1.5em,
  canvas(plot.plot(
    size: (5.5, 4),
    x-label: $beta$,
    y-label: $ev(E) \/ planck omega$,
    x-tick-step: 2,
    y-tick-step: 0.5,
    axis-style: "school-book",
    y-min: 0,
    y-max: 2.2,
    plot.add(b => 0.5 * (1 + 4 / (calc.exp(b) - 1)), domain: (0.85, 11), samples: 200, style: (stroke: blue + 0.8pt)),
  )),
  canvas(plot.plot(
    size: (5.5, 4),
    x-label: $omega$,
    y-label: $ev(E) \/ kB T$,
    x-tick-step: 2,
    y-tick-step: 1,
    axis-style: "school-book",
    y-min: 0,
    y-max: 5.5,
    plot.add(w => if w == 0 { 2 } else { w / 2 * (1 + 4 / (calc.exp(w) - 1)) }, domain: (0, 11), samples: 200, style: (stroke: blue + 0.8pt)),
  )),
)

= Trace of linear operators #points(3)

#task[
  The trace of an operator $A$ on a Hilbert space $cH$ is defined as
  $ tr(A) = sum_n braket(e_n, A, e_n) $ <eq:trace>
  where $(e_n)_(n in NN)$ is an orthonormal basis of $cH$.
  + Show that the trace is independent of the orthonormal basis.
  + Show that for all operators $A$ and $B$ on $cH$
    $ tr(A B) = tr(B A). $
    What is the analogous formula for $tr(A B C)$?
  + Show that $tr(U A U^dagger) = tr(A)$ if $U$ is unitary.
  + Find the general form of the density operator for spin-$1/2$ systems. \
    Hint: Spin-$1/2$ means that $cH tilde.eq CC^2$, so a density operator $rho$ is a $2 times 2$-matrix. Express this operator using Pauli matrices. Use the conditions on a density operator to constrain the form of $rho$.
]

+ Let $(b_n)_(n in NN)$ be another orthonormal basis of $cH$ distinct from $(e_n)_(n in NN)$, then $(b_n)_(n in NN)$ forms a complete set of states, i.e.
  $ sum_n ket(b_n) bra(b_n) = one_cH. $
  Inserting two such sets into @eq:trace left and right of $A$ gives
  $
    sum_n braket(e_n, A, e_n) & = sum_n sum_(i,j) chevron.l e_n|b_i chevron.r braket(b_i, A, b_j) chevron.l b_j|e_n chevron.r = sum_(i,j) braket(b_i, A, b_j) underbrace(sum_n chevron.l b_j|e_n chevron.r chevron.l e_n|b_i chevron.r, chevron.l b_j|b_i chevron.r = delta_(i j)) \
    & = sum_i braket(b_i, A, b_i).
  $
+ By definition,
  $ tr(A B) = sum_n braket(e_n, A B, e_n) = sum_(m,n) braket(e_n, A, e_m) braket(e_m, B, e_n) = sum_(m,n) braket(e_m, B, e_n) braket(e_n, A, e_m) = tr(B A). $ <eq:cyclic-two>
  In the case of three operators, @eq:cyclic-two implies cyclicity of the trace, i.e.
  $ tr(A B C) = tr(C A B) = tr(B C A). $ <eq:cyclic>
+ $U$ unitary means $U^dagger = U^(-1)$. Thus, using @eq:cyclic,
  $ tr(U A U^dagger) = tr(U^dagger U A) = tr(A). $
+ The $2 times 2$-unit matrix and the Pauli matrices are linearly independent, so they form a basis of the four-dimensional space of complex $2 times 2$-matrices. We can thus write the density operator
  $
    rho & = sum_(i=0)^3 a_i sigma_i = a_0 mat(1, 0; 0, 1) + a_1 mat(0, 1; 1, 0) + a_2 mat(0, -i; i, 0) + a_3 mat(1, 0; 0, -1) \
        & = mat(a_0 + a_3, a_1 - i a_2; a_1 + i a_2, a_0 - a_3),
  $ <eq:rho-pauli>
  Any density operator must satisfy
  #set enum(numbering: "i)")
  + $rho^dagger = rho$,
  + $tr(rho) = 1$,
  + $rho >= 0$.

  i) allows us to restrict the coefficients $a_i$ to the real numbers. ii) requires $a_0 = 1/2$, so @eq:rho-pauli becomes#footnote[In @eq:rho-bloch, we rescaled the $a_i -> a_i/2$ for $i in {1, 2, 3}$.]
  $ rho = 1/2 (one_2 + ba dot bsigma), $ <eq:rho-bloch>
  where $ba in RR^3$ is known as the Bloch vector. For a given density matrix, it can be calculated as the expectation value of the Pauli matrices,
  $ ev(sigma_i) = tr(sigma_i rho) = 1/2 underbrace(tr(sigma_i), 0) + 1/2 sum_(j=1)^3 a_j underbrace(tr(sigma_i sigma_j), 2 delta_(i j)) = a_i, #h(3em) "i.e." ba = ev(bsigma). $ <eq:bloch-ev>
  Since $ba dot bsigma$ has eigenvalues $plus.minus |ba|$ (its square is $|ba|^2 one_2$ and it is traceless), $rho$ as in @eq:rho-bloch has eigenvalues
  $ lambda_plus.minus = 1/2 (1 plus.minus |ba|). $
  iii) requires that $lambda_plus.minus >= 0$, so $ba$ must satisfy $|ba| <= 1$. Thus all spin-$1/2$ density matrices lie on or within the so-called _Bloch sphere_ of radius $|ba| = 1$ and are fully determined by the Bloch vector $ba$.
  #align(center, bloch-sphere)
  For $rho$ to describe a pure state, we must have $rho^2 = rho$. Squaring @eq:rho-bloch and using $(ba dot bsigma)^2 = ba^2 one_2$ gives
  $ rho^2 = 1/4 (one_2^2 + 2 one_2 ba dot bsigma + ba^2 one_2), $
  which is equal to $rho$ only if $|ba| = 1$, so all pure states lie directly on the Bloch sphere. We can infer that the length of the Bloch vector indicates the mixedness, or in a language more suitable to this problem, the polarization of an ensemble. For $|ba| = 1$, $rho$ describes a pure state that is completely polarized, whereas for $ba = 0$, the state is mixed and unpolarized.

= Statistical mixture of spin states #points(3)

#task[
  In a neutron beam, the spin of half of the particles is polarized in positive $x$-direction, and that of the other half in $y$-direction.
  + Find the density operator $rho$ corresponding to this situation.
  + Calculate the expectation value of the spin operator in the state given by $rho$.
  + Calculate the eigenvalues $p_plus.minus$ and eigenvectors of $rho$.
  + Determine the spin polarization
    $ pi = (p_+ - p_-)/(p_+ + p_-). $ <eq:polarization>
]

+ Neutrons are spin-$1/2$ particles. As such, they occupy states in a Hilbert space $cH tilde.eq CC^2$, meaning all considerations concerning density operators and Bloch vectors from exercise 1.d) apply. The Bloch vector for a beam containing equal parts $x$- and $y$-polarized neutrons reads $ba = (1/2, 1/2, 0)$ which results in a density operator
  $ rho eqby("eq:rho-bloch") 1/2 (one_2 + 1/2 sigma_1 + 1/2 sigma_2) = 1/2 mat(1, 1/2 - i/2; 1/2 + i/2, 1). $ <eq:rho-beam>
+ Recalling eq. @eq:bloch-ev, we can immediately state the spin operator's expectation value,
  $ ev(bs) = planck/2 ev(bsigma) = planck/2 ba = planck/4 vec(1, 1, 0). $
+ $rho$ as defined in @eq:rho-beam has eigenvalues
  $ p_plus.minus = 1/4 (2 plus.minus sqrt(2)), $ <eq:eigenvalues>
  belonging to the eigenvectors
  $ bfb_plus.minus = 1/2 vec(plus.minus (1 - i), sqrt(2)). $
+ Inserting @eq:eigenvalues into @eq:polarization results in a spin polarization of $pi = 1/sqrt(2)$.

= Entropy of the microcanonical ensemble #points(2)

#task[Calculate the von Neumann entropy for the microcanonical ensemble of quantum statistical mechanics, and show that it equals Boltzmann's constant times the logarithm of the microcanonical partition function.]

The von Neumann definition of entropy is
$ S = -kB tr_cH [rho ln(rho)] $ <eq:von-neumann>
where the density operator is given by $rho = sum_n p_n ket(n) bra(n)$ and $n$ sums over a complete set of states of the Hilbert space $cH$. The microcanonical ensemble consists of all states $ket(n)$ whose energy lie within a small interval of uncertainty $E_n in I_Delta = [E - Delta, E]$ around the macroscopically observed energy $E$.#footnote[$Delta$ takes into account thermal and quantum fluctuations which prevent us from knowing the energy with absolute certainty for any finite sized system. It vanishes in the thermodynamic limit, reducing the interval to a point.] Since all accessible states are weighted equally, $p_n = 1 \/ Zm$, where the partition function $Zm$ counts the total number of states. Thus, a density operator for the microcanonical ensemble takes the form
$ rho_m = sum_({n | E_n in I_Delta}) 1/Zm ket(n) bra(n) = 1/Zm P_Delta, $ <eq:rho-micro>
where $P_Delta$ defined as
$ P_Delta = sum_({n | E_n in I_Delta}) ket(n) bra(n) $
projects onto the subspace of accessible microstates $cH_Delta subset cH$. It follows from the density operator's normalization condition $tr(rho) limits(=)^! 1$ that $Zm = tr[P_Delta]$. Inserting @eq:rho-micro into @eq:von-neumann yields
$ S = -kB tr[1/Zm P_Delta ln(1/Zm P_Delta)] = kB 1/Zm ln(Zm) underbrace(tr[P_Delta], = Zm) - k_B/Zm tr[P_Delta ln(P_Delta)]. $ <eq:s-micro>
As we showed in exercise 1, the trace is basis independent. We may therefore evaluate the second term using an energy eigenbasis in which $P_Delta$ has diagonal form with eigenvalue one for every state that lies in $cH_Delta$ and zero else. The logarithm of a diagonal matrix is just the logarithm of the eigenvalues. Thus, $ln(P_Delta)$ vanishes wherever $P_Delta$ has unit entry, while the zero entries contribute $0 ln 0 = lim_(x -> 0) x ln x = 0$. Hence, the product $P_Delta ln(P_Delta)$ vanishes identically and the von Neumann entropy @eq:s-micro simplifies to
$ S = kB ln(Zm). $

= Partition function #points(2)

#task[
  Given a Hamiltonian $H$ with discrete spectrum $E_0 < E_1 < E_2 < ...$, where for all $n$, $E_n$ is a $(n + 1)$-fold degenerate eigenvalue,
  + express the canonical partition function $Z_c$ in terms of a sum over $n$,
  + for $E_n = planck omega (n + 1/2)$, $omega > 0$, calculate $Z_c$ and the expectation value of the energy.
]

+ The canonical partition function sums over all states weighted by their energy. Since states in quantum mechanics furnish a Hilbert space $cH$, the partition function can be written very elegantly as the trace of the weighting factor,
  $ Z_c = tr_cH (e^(-beta H)). $ <eq:z-trace>
  Since the trace is basis-independent, we make a convenient choice and evaluate it in a normalized eigenbasis of the Hamiltonian $H$. Different eigenstates are linearly independent -- even if they correspond to the same degenerate eigenvalue. Thus the Hilbert space of a Hamiltonian with eigenvalues running up to $E_n$, each of degeneracy $n + 1$, has dimension
  $ d = sum_(i=0)^n (i + 1) = 1/2 (n + 2)(n + 1). $
  To form a complete#footnote[Completeness here means that the span of basis vectors includes (in fact coincides with) the whole space.] eigenbasis of $H$, we need $d$ eigenstates. In general, $d$ is not finite and then neither is the cardinality of the basis.#footnote[We are working with separable Hilbert spaces which contain countable dense subsets, meaning even if the number of basis states becomes infinite, they will always be countable.] Denoting the basis vectors $ket(psi_(m j))$, where $m in {0, ..., n} subset NN_0$ counts the eigenvalues and $j in {1, ..., m + 1}$ their degeneracy, @eq:z-trace can be written
  $
    Z_c & = sum_(m=0)^n sum_(j=1)^(m+1) bra(psi_(m j)) underbrace(e^(-beta H) ket(psi_(m j)), e^(-beta E_m) ket(psi_(m j))) = sum_(m=0)^n e^(-beta E_m) sum_(j=1)^(m+1) underbrace(chevron.l psi_(m j)|psi_(m j) chevron.r, 1) \
        & = sum_(m=0)^n (m + 1) e^(-beta E_m).
  $ <eq:z-sum>
+ For $E_m = planck omega (m + 1/2)$, $omega > 0$ and $n -> infinity$, @eq:z-sum becomes
  $ Z_c = sum_(m=0)^infinity (m + 1) e^(-beta planck omega (m + 1/2)) = e^(-epsilon/2) sum_(m=0)^infinity (m + 1) e^(-m epsilon) = e^(-epsilon/2) (1 - partial_epsilon) sum_(m=0)^infinity e^(-m epsilon), $
  where we defined the ratio of oscillatory and thermal energy $epsilon = (planck omega)/(kB T) > 0$. Since $e^(-epsilon) < 1$, by the geometric series we have
  $ Z_c = e^(-epsilon/2) (1 - partial_epsilon) 1/(1 - e^(-epsilon)) = e^(-epsilon/2) (1/(1 - e^(-epsilon)) + e^(-epsilon)/(1 - e^(-epsilon))^2) = e^(3/2 epsilon)/(e^epsilon - 1)^2. $
  The expected energy follows immediately from the partition function,
  $ ev(E) = -1/Z_c partial_beta Z_c = -1/Z_c (3/2 planck omega - 2 planck omega e^epsilon/(e^epsilon - 1)) Z_c = (planck omega)/2 (1 + 4/(e^(beta omega planck) - 1)), $
  which approaches the ground state energy of the harmonic oscillator $1/2 planck omega$ for $beta -> infinity$, i.e. $T -> 0$. Interestingly, as can be seen from the right-hand plot below, the expected energy is not a monotonic function of $omega$ but rather decreases at first for increasing angular frequency before approaching a linear relation. In the static case $omega -> 0$, we find
  $ lim_(omega -> 0) ev(E) = lim_(omega -> 0) (2 planck omega)/(e^(beta omega planck) - 1) = 2 kB T. $
  #align(center, energy-plots)
