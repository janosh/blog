#import "/notes.typ": task, vb, kB, eqby, pd
#import "/statistical-physics/sheet.typ": points, sheet
#import "@preview/cetz:0.5.2": canvas
#import "@preview/cetz-plot:0.1.4": plot

#show: sheet.with(9, [January 13th, 2017])

#let (bp, bq, bx) = ($vb(p)$, $vb(q)$, $vb(x)$)

// the two factors of the mean-field magnetization below T_c = 1 and their product m_c(T)
#let critical-plot = canvas({
  plot.plot(
    size: (7, 4.5),
    x-label: $T$,
    y-label: none,
    x-tick-step: 0.2,
    y-tick-step: 0.5,
    x-min: 0,
    x-max: 1.1,
    y-min: 0,
    y-max: 2.8,
    axis-style: "school-book",
    legend: "inner-north-east",
    legend-style: (item: (spacing: 0.15)),
    {
      plot.add(t => calc.sqrt(3 * (1 / t - 1)), domain: (0.28, 1), samples: 200, style: (stroke: blue + 0.8pt), label: text(size: 7pt, $sqrt(3) (T_c \/ T - 1)^(1\/2)$))
      plot.add(t => calc.sqrt(3) * calc.pow(t, 1.5), domain: (0, 1.1), style: (stroke: red + 0.8pt), label: text(size: 7pt, $sqrt(3) (T \/ T_c)^(3\/2)$))
      plot.add(t => calc.sqrt(3) * calc.pow(t, 1.5) * calc.sqrt(1 / t - 1), domain: (0.001, 1), samples: 200, style: (stroke: rgb("#ff8000") + 0.8pt), label: text(size: 7pt, $m_c (T)$))
    },
  )
})

// Onsager's spontaneous magnetization of the 2d Ising model, T_c = 2 J / ln(1 + sqrt(2)) k_B
#let onsager-plot = canvas({
  let beta-J(t) = calc.ln(1 + calc.sqrt(2)) / (2 * t)
  let m(t) = if t >= 1 { 0 } else { calc.pow(1 - calc.pow(calc.sinh(2 * beta-J(t)), -4), 1 / 8) }
  plot.plot(
    size: (5.5, 4.5),
    x-label: $T \/ T_c$,
    y-label: $m(0, T)$,
    x-tick-step: 0.5,
    y-tick-step: 0.5,
    x-min: 0,
    x-max: 1.8,
    y-min: 0,
    y-max: 1.5,
    axis-style: "school-book",
    {
      plot.add(t => m(t), domain: (0.02, 1.8), samples: 600, style: (stroke: blue + 1pt))
      plot.add(t => t, domain: (0, 1), style: (stroke: (dash: "dashed", thickness: 0.5pt)))
    },
  )
})

= Oscillators #points(3)

#task[Calculate the canonical partition function for a system of $N$ classical harmonic oscillators, and determine the thermodynamics of this system.]

The Hamiltonian for a single classical harmonic oscillator in $n$ dimensions with isotropic potential and continuous degrees of freedom $bq$ and $bp$ reads $H_1 (bp, bq) = bp^2/(2 m) + k/2 bq^2$ with $omega = sqrt(k \/ m)$. Its canonical partition function can be computed using Gaussian integrals,
$ Z_1 (T) = 1/h^n integral_(RR^n) integral_(RR^n) e^(-beta H_1 (bp, bq)) dif^n q dif^n p = 1/h^n (2 pi m \/ beta)^(n/2) (2 pi \/ beta k)^(n/2) = 1/(beta planck omega)^n. $
Assuming the oscillators to be both distinguishable and non-interacting, the partition function for a system of $N$ such oscillators is just a product of single-oscillator partition functions,
$ Z(T, N) = Z_1 (T)^N = 1/(beta planck omega)^(n N). $
This results in the Helmholtz free energy
$ F(T, N) = -1/beta ln(Z) = n N kB T ln(beta planck omega), $
which is extensive, i.e. grows linearly with $N$. Since $F$ does not depend on the volume, we get a vanishing pressure,
$ p = -pd(F, V, (N,T)) = 0. $
This is due to the lack of interactions between oscillators and because the angular frequency is independent of volume and density. \
The internal energy is
$ U(N, T) = -(partial ln(Z))/(partial beta) = n N kB T, $
which gives a heat capacity of $C = partial U \/ partial T = n N kB$. \
Unlike the pressure, the entropy for a system of $N$ oscillators -- interacting or not -- should not vanish, and indeed using $F = U - T S$, we find
$ S = 1/T (U - F) = n N kB [1 - ln(beta planck omega)]. $ <eq:entropy>
Just like in exercise 1 on sheet 8, where we derived the Sackur-Tetrode equation for the entropy of an ideal gas, the low temperature limit remains problematic. Equation @eq:entropy suggests that the entropy of a system of harmonic oscillators becomes negative for $(planck omega)/(kB T) > e$. This is the regime where the thermal energy $kB T$ becomes comparable to the harmonic oscillator spacing of energy levels $planck omega$, suggesting that we need to employ quantum mechanics to model the low temperature behavior of the entropy correctly.

= Mean-field critical exponents #points(3)

#task[
  The mean-field magnetization per spin $m = m(T, h)$ of an Ising ferromagnet is
  $ m = tanh(2 d beta J m + beta h), $ <eq:mean-field>
  with $beta = 1/(kB T)$ (and $J > 0$). We have seen that in the zero-field limit $h -> 0^+$, a non-zero solution exists for $T < T_c$ where $2 d beta_c J = 1$. Determine how this solution $m = m(T, 0^+)$ behaves as a function of $T_c - T$ as $T arrow.tr T_c$, and how $m(T_c, h)$ depends on $h$ for $h -> 0^+$. \
  Hint: Use the Taylor expansion of tanh around zero. Determine only the leading behaviour.
]

From $2 d beta_c J = 1$ follows the critical temperature $T_c = 2 d J \/ kB$ i.t.o. which @eq:mean-field reads
$ m(T, h) = tanh(T_c/T m + beta h). $ <eq:mean-field-tc>
In the zero-field limit, @eq:mean-field-tc reduces to $m(T, 0^+) = tanh(T_c/T m)$. At $T = T_c$, we know that $m = 0$ is the only solution of this transcendental equation. Since $m$ is continuous#footnote[$m$ continuous holds generally, even at the Curie point, i.e. during the second-order phase transition between the ferro- and paramagnetic state. According to Ehrenfest's classification, the order of a phase transition is determined by the order of the first discontinuous derivative of the free energy. $m prop -(partial F)/(partial h)$ is the free energy's first derivative w.r.t. the applied field and increases continuously from zero as the temperature is lowered below the Curie temperature. The magnetic susceptibility $chi prop -(partial^2 F)/(partial h^2)$ is the second derivative. It diverges at $T_c$.], we infer $m << 1$ near $T lt.tilde T_c$. We may therefore use the Taylor expansion of tanh around zero,
$ tanh(x) = x - x^3/3 + cal(O)(x^5), $
to expand $m(T, 0^+)$ near but below $T_c$ as
$ m_c approx T_c/T m_c - 1/3 T_c^3/T^3 m_c^3. $
Solving for $m_c$ yields
$ m_c (T) approx sqrt(3) (T/T_c)^(3/2) (T_c/T - 1)^(1/2). $ <eq:m-critical>
The first factor depends only weakly on $T$ around $T_c$. The dominant contribution comes from the second factor whose derivative is singular at $T = T_c$, as can be seen from the following plot.
#align(center, critical-plot)
Expanding the critical magnetization @eq:m-critical to first order in $(T_c - T)$ gives
$ m_c (T) approx sqrt(3 \/ T_c) (T_c - T)^(1/2) + cal(O)[(T_c - T)^(3/2)]. $
Thus, near the critical point, the magnetization follows a simple power law with critical exponent $1/2$ (conventionally called $beta$). \
Expanding $m_c (T_c, h) = tanh(m_c + beta_c h)$ to first order in $h$ around $h = 0$ gives
$ m_c (T_c, h) = tanh(m_c) + beta_c/(cosh^2 (m_c)) h + cal(O)(h^2). $
Again using $m_c << 1$ near $T_c$, we can expand $tanh(m_c) approx m_c - m_c^3/3$ and approximate $cosh(m_c) approx 1$ to get
$ m_c approx m_c - m_c^3/3 + beta_c h. $
Solving for $m_c$, we find
$ m_c approx root(3, 3 beta_c h) prop h^(1/3), $
which is again a power law, $m prop h^(1\/delta)$ with critical exponent $delta = 3$.

= When Ising stole Christmas #points(4)

#task[
  Calculate the free energy of the $d$-dimensional Ising model with ferromagnetic nearest-neighbour interaction for zero magnetic field. \
  Hints:
  #set enum(numbering: "1.")
  + Start with $d = 1$, then $d = infinity$, then $d = 2$, then $d = infinity - 1$, etc.
  + This is a bonus question: You get 4 extra points for $d = 1$, $4^((4^4))$ for $d = 2$, and $aleph_4$ for $3 <= d < infinity$.
]

*$d = 1$* #h(0.5em) The energy of a chain of $N$ Ising spins occupying the spin configuration $s$ is given by the Hamiltonian
$ H(s) = J sum_(i=1)^N (1 - s_i s_(i+1)) - h sum_(i=1)^N s_i. $ <eq:ising>
The sum over 1 just gives rise to an overall constant $N J$, which we drop to simplify our calculation. Further, we assume periodic boundary conditions such that $s_1 = s_(N+1)$, making the chain a ring of spins. We will study the Ising model in the canonical ensemble for which the partition function is
$ Z_c = sum_(s in cal(S)_N) e^(-beta H(s)), $ <eq:partition>
where $cal(S)_N$ is the set of all possible spin configurations of cardinality $|cal(S)_N| = 2^N$. From @eq:partition, the free energy may be computed as
$ F = -1/beta ln(Z_c). $ <eq:free-energy>
We will leave $h != 0$ for now and take $h = 0$ only in the end. Inserting @eq:ising into @eq:partition, we get
$
  Z_c & = sum_(s_1, ..., s_N in {plus.minus 1}) e^(beta (J sum_(i=1)^N s_i s_(i+1) + h sum_(i=1)^N s_i)) \
      & = sum_(s_1, ..., s_N in {plus.minus 1}) e^(beta (J s_1 s_2 + h s_1)) ... e^(beta (J s_N s_1 + h s_N)) \
      & = sum_(s_1, ..., s_N in {plus.minus 1}) M_(s_1 s_2) M_(s_2 s_3) ... M_(s_N s_1),
$
where the $M_(s s')$ are matrix elements defined by
$ M_(s s') = e^(beta J s s' + beta h s). $
This allows us to write the partition function as:
$ Z_c = sum_(s_1 in {plus.minus 1}) (M^N)_(s_1 s_1) = "tr"(M^N) = lambda_1^N + lambda_2^N, $
where $lambda_i$ are the two eigenvalues of $M$ and we used that the trace is basis independent, so we may perform it in a basis in which $M$ takes diagonal form.#footnote[Note that $M$ has two distinct real eigenvalues (see below) and is therefore diagonalizable.] Let $lambda_1$ be the eigenvalue of larger magnitude. In the thermodynamic limit, we then get
$ lim_(N -> infinity) Z_c = lim_(N -> infinity) lambda_1^N (1 + lambda_2^N \/ lambda_1^N) tilde lambda_1^N. $
Hence, all we need to do to find $Z_c$ is to compute the larger of the two eigenvalues of
$ M = mat(e^(beta (J + h)), e^(beta (-J + h)); e^(-beta (J + h)), e^(beta (J - h))). $
The eigenvalues of a general $2 times 2$ matrix $A$ are
$ lambda_plus.minus = "tr"(A)/2 plus.minus sqrt("tr"(A)^2/4 - det(A)). $
For $M$, we get
$
  "tr"(M) & = e^(beta (J - h)) + e^(beta (h + J)) #h(3em) && det(M) = e^(beta (h + J) - beta (h - J)) - e^(beta (h - J) - beta (h + J)) \
          & = 2 e^(beta J) cosh(beta h), && #h(4.4em) = 2 sinh(2 beta J).
$
Thus the larger eigenvalue reads
$ lambda_1 = e^(beta J) cosh(beta h) + sqrt(e^(2 beta J) sinh^2 (beta h) + e^(-2 beta J)), $
and the free energy per spin is
$
  f(h, T) & = lim_(N -> infinity) F(h, T)/N eqby("eq:free-energy") -kB T lim_(N -> infinity) 1/N ln[Z_c (h, T)] \
          & = -kB T ln[e^(beta J) cosh(beta h) + sqrt(e^(-2 beta J) + sinh^2 (beta h) e^(2 beta J))].
$
For vanishing field $h = 0$ this result simplifies to
$ f(0, T) = -kB T ln(e^(beta J) + e^(-beta J)) = -kB T ln(2 cosh(beta J)). $

*$d = 2$* #h(0.5em) In two dimensions, the Ising model is still solvable for vanishing external field. This is the Onsager solution, presented in Kerson Huang's "Statistical Mechanics" (pp. 268 - 293). Reproducing here the full derivation would be too lengthy. The final result, eq. (15.133), for the free energy per spin reads
$ beta f(0, T) = -ln[2 cosh(2 beta J)] - 1/(2 pi) integral_0^pi dif phi ln[1/2 (1 + sqrt(1 - kappa^2 sin^2 (phi)))], $
where $kappa = 2 tanh(2 beta J) \/ cosh(2 beta J)$. The interesting thing about this solution is that it displays a phase transition at a critical temperature. This can be seen simply from the fact that the elliptic integral has a singularity at $kappa = 1$. This divergence turns out to be a logarithmic one. The value of the critical temperature is found to be
$ 2 tanh^2 ((2 J)/(kB T_c)) limits(=)^! 1 wide => wide T_c approx 2.27 J/kB. $
The magnetization may also be computed (another tedious task). The deceptively simple result
$ m(0, T) = cases(0 quad & T > T_c, {1 - [sinh(2 beta J)]^(-4)}^(1/8) quad & (T < T_c)), $
is a spontaneous magnetization in the sense that it is non-zero only below the critical temperature and its derivative diverges in the limit $T -> T_c^-$. We plot it below.
#align(center, onsager-plot)
