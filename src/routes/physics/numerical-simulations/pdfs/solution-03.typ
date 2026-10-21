#import "/notes.typ": task, vb, eps, unit, ev
#import "/numerical-simulations/sheet.typ": panels, sheet, booktable, cO

#show: sheet.with(3, [November 13th, 2015], [Collisionless dynamics and the tree code])

#let (bF, bx, br, ba) = ($vb(F)$, $vb(x)$, $vb(r)$, $vb(a)$)


= Collisionless system in equilibrium

#task[
  The energy per unit mass of a particle in a stationary collisionless system can be written as
  $ eps_i = 1/2 v_i^2 + Phi_i, $
  where $v$ is the speed of the particle and $Phi$ is the value of the gravitational potential at its current position. Prove that the total energy of the system is equal to
  $ E = 1/3 M ev(eps) $ <eq:total-energy>
  where $ev(eps)$ is the mass-weighted average of $eps$ for all particles, and $M$ is the total mass of the particles.
]

The identity in eq. @eq:total-energy follows from an application of the Virial theorem (VT) which relates the time-averaged total kinetic and potential energies, $ev(T)$ and $ev(U)$, of a stable many-particle system bound by potential forces:
$ 2 ev(T) = n ev(U), $
where $n$ is determined by the force $bF = -vb(nabla) U(r)$ with a potential of the form $U(r) = alpha r^n$ acting between any two particles of the system. Thus, for a gravitational potential, $n = -1$ and $2 ev(T) = -ev(U)$. Using this to rewrite the total energy, we obtain the desired result:
$
  E & = ev(T) + ev(U) = 1/3 (3 ev(T) + 3 ev(U)) limits(=)^"VT" 1/3 (ev(T) + 2 ev(U)) \
    & = 1/3 sum_(i=1)^N m_i/2 v_i^2 - 2/3 sum_(i<j)^N (G m_i m_j)/(|bx_i - bx_j|) = 1/3 sum_(i=1)^N m_i/2 v_i^2 - 1/3 sum_(i != j)^N (G m_i m_j)/(|bx_i - bx_j|) \
    & = 1/3 sum_(i=1)^N m_i (v_i^2/2 underbrace(- sum_(j != i)^N (G m_j)/(|bx_i - bx_j|), Phi_i)) = 1/3 sum_(i=1)^N m_i eps_i = 1/3 sum_(i=1)^N m_i (sum_(i=1)^N m_i eps_i)/(sum_(i=1)^N m_i) = 1/3 M ev(eps).
$

= Tree code

#task[
  Tree algorithms can approximately calculate the forces in an $N$-body system by means of a hierarchical multipole expansion. This reduces the computational cost's scaling with $N$ from $cO[N^2]$ to $cO[N ln(N)]$. On the Moodle page of the lecture, a simple skeleton tree code (in C) can be downloaded (note that this implementation uses only monopole order and is not optimized for speed or memory consumption). You can use this template for this exercise, either directly or translated to another language, or if you wish, you may also write your own tree code from scratch. \
  Consider $N$ particles of total mass $M_"tot" = 1$ placed randomly into a cubical box of unit side-length. For definiteness, we assume all particles have the same mass, and we adopt $G = 1$. Assume that the gravitational potential of individual particles is Plummer-softened with a gravitational softening length $eps = 0.001$, i.e. we adopt the potential
  $ phi(br) = -m/(br^2 + eps^2)^(1\/2) $
  for a single particle of mass $m$. Calculate the gravitational forces for all $N$ particles with an oct-tree and determine the typical force accuracy and calculation time in comparison with direct summation, both as a function of $N$ and of the opening angle parameter $theta$. To this end, carry out the following steps:
  + The provided code template is incomplete, so start by filling in the missing pieces. Places where you have to complete the code are marked with the comment `TO BE FILLED IN`. In particular, you need to add the computation of the multipole moments of tree nodes from their subnodes, as well as the partial force calculation from a tree node that is used in the tree walk. Also, please add a calculation of the exact forces by direct summation. When you're done, verify that the force approximation delivered by the tree code is roughly correct by adding suitable output to the code.
  + To allow a more quantitative analysis, add an automatic measurement of the average force error after all forces have been calculated by the tree and direct summation. To this end, consider the relative force error
    $ eta_i = (|ba_(i,"tree") - ba_(i,"direct")|)/(|ba_(i,"direct")|), #h(3em) i in {1, ..., N}, $
    for each particle, and determine a simple arithmetic average $ev(eta)$ of the mean relative force error#footnote[Note that a more careful analysis of the errors should really consider the full distribution of the errors. It could well be that there are occasionally very large, catastrophic errors that go unnoticed in a simple average such as $ev(eta)$. To diagnose this, one needs to look at the error distribution function.]. Also, add diagnostic code that tells you the average number of particle-node interactions per particle, i.e. how many nodes the multipole expansion on average involves.
  + Make a little grid of calculations for $N in {5000, 10 thin 000, 20 thin 000, 40 thin 000}$, and opening angles $theta in {0.2, 0.4, 0.8}$. In each case, measure the calculation time for the tree-based force calculation and for direct summation, as well as $ev(eta)$ and the mean number of terms the tree code used per particle. Report the results in a table.
  + Using the previous results, make a plot of the execution time of the force calculation with the tree as a function of $N$ (for the $theta = 0.4$ case). Use logarithmic axes and fit a regression line (in the log) to the 4 data points you obtained. Also include the results for direct summation. Estimate the time needed for $10^10$ particles for both methods by extrapolating your timing results.
]

+ We verify that our tree method force calculation is approximately correct by comparing the acting forces to those obtained via direct summation in a random sample fashion, i.e. we look at just one, but _any_ one particle per calculation. A typical example of such a random sample for an opening angle of $theta = 0.8$ looks like
  $
    a_("tree",x) & = -2.80, wide && a_("tree",y) & = 1.60, wide && a_("tree",z) & = -6.16, \
     a_("dir",x) & = -2.78, && a_("dir",y) & = 1.57, && a_("dir",z) & = -6.18,
  $
  which we take to be sufficiently accurate.
+ See `tree.c`.
+ Calculation times both for the tree method ($t_"tree"$) and for a direct summation of forces ($t_"dir"$), relative errors ($eta$), and average number of particle-node interactions per particle in the tree calculation ($n_"int"$) for a range of parameters are shown in @tab:results.
  #figure(
    {
      let block(angle, rows) = (
        table.cell(rowspan: 4, align: horizon, $theta = #angle$),
        ..rows.flatten(),
        table.hline(stroke: 0.4pt),
      )
      booktable(
        columns: 6,
        align: (left, left, left, left, left, left),
        header: ([], [$N$], [5000], [10~000], [20~000], [40~000]),
        body: (
          ..block("0.2", (
            ([$t_"dir"$], [3.87~s], [15.06~s], [62.41~s], [239.42~s]),
            ([$t_"tree"$], [1.75~s], [4.91~s], [12.52~s], [32.62~s]),
            ([$eta$], [0.02~%], [0.02~%], [0.02~%], [0.02~%]),
            ([$n_"int"$], [1736.48], [2414.91], [3128.12], [3975.71]),
          )),
          ..block("0.4", (
            ([$t_"dir"$], [3.85~s], [15.10~s], [61.80~s], [246.06~s]),
            ([$t_"tree"$], [0.51~s], [1.19~s], [3.00~s], [6.93~s]),
            ([$eta$], [0.20~%], [0.16~%], [0.14~%], [0.12~%]),
            ([$n_"int"$], [507.94], [623.32], [738.95], [867.69]),
          )),
          table.cell(rowspan: 4, align: horizon, $theta = 0.8$),
          [$t_"dir"$], [3.93~s], [15.10~s], [60.13~s], [252.77~s],
          [$t_"tree"$], [0.11~s], [0.24~s], [0.54~s], [1.37~s],
          [$eta$], [1.29~%], [1.13~%], [1.00~%], [0.85~%],
          [$n_"int"$], [111.63], [129.23], [144.16], [162.31],
        ),
      )
    },
    caption: [Computational results],
    kind: table,
  ) <tab:results>
+ @fig:timing shows a log-log plot of the execution time as a function of the particle number $N$ for the force calculations of both the tree method and direct summation. It depicts the case $theta = 0.4$. Slope and intercept values for the linear regressions of $t_"tree" (N)$ and $t_"dir" (N)$ are given in @tab:regression. Using these values to project an estimate on the execution time for
  #figure(
    booktable(
      columns: 3,
      align: left,
      header: ([], [$t_"tree" (N)$], [$t_"dir" (N)$]),
      body: ([slope $m$], [1.26], [2.00], [intercept $b$], [$-11.41$], [$-15.72$]),
    ),
    caption: [Linear regression values],
    kind: table,
  ) <tab:regression>
  a calculation involving $10^10$ particles according to
  $ t_"exec" [upright(s)] = e^(m dot ln(N) + b), $
  yields
  $
    t_"tree" (N = 10^10) & approx 4.31 times 10^7 unit("s") approx 500 unit("d"), \
     t_"dir" (N = 10^10) & approx 1.60 times 10^13 unit("s") approx 506 thin 245 unit("yr").
  $
  #figure(
    panels(2, (("tree-timing-measured", [Calculated values]), ("tree-timing-projected", [Projected values]))),
    caption: [Log-log plot of the execution time as a function of the particle number $N$],
  ) <fig:timing>
  A graphical representation of these estimates is given in @fig:timing (b). Interestingly, this plot also shows at which value of $N$ the overhead introduced by the tree method actually becomes a time penalty: $N lt.tilde 340$. However, extrapolations from our four data points into such low ranges of $N$ need to be taken with a grain of salt. Actual runs showed that the tree method was still slightly faster even below $N = 100$.
