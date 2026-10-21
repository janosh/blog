#import "/notes.typ": dd, notes, vb, eps, ev, bra, ket
#import "/string-theory/sheet.typ": SP

#show: notes.with(
  title: [Summary of String Theory],
  date: [Janosh Riebesell, April 2016],
)
#set heading(numbering: "1.1")
#set math.equation(numbering: "(1)")
#show heading.where(level: 2): set block(above: 1.3em, below: 0.8em)

#let ba = $vb(alpha)$
#let bxi = $vb(xi)$

// booktabs-style table: rules above and below the header row and at the bottom
#let booktable(columns, header, ..cells) = table(
  columns: columns,
  stroke: none,
  align: left,
  inset: (x: 6pt, y: 3pt),
  table.hline(stroke: 0.8pt),
  table.header(..header),
  table.hline(stroke: 0.5pt),
  ..cells,
  table.hline(stroke: 0.8pt),
)

#outline(depth: 2)
#pagebreak()

= Motivation

- Modern physics is primarily built on three pillars that have held up to experiment time and again:
  - *Special relativity* is the framework of choice when describing _fast-moving_ objects.
  - *General relativity* prevails in the face of objects so _massive_ that they bend spacetime itself.
  - *Quantum mechanics* claims to describe physics down to the _smallest level_.
- But what if something is both small _and_ fast? To describe such systems, special relativity and quantum mechanics were beautifully incorporated into a multiparticle, relativistic framework called *quantum field theory* -- the most successful physical theory yet, tested to excruciating precision.
- Or, what about systems that are massive yet small (and perhaps fast)? Clearly, for something to be both massive and small implies that we are looking at high densities on short length scales where gravity becomes important and of a magnitude comparable to the other forces. We are entering an exotic regime of physics involving systems such as the early universe and (rotating) black holes. Quantum field theory in its current state is of no use here, as it discards gravity from the outset. In fact, no field-theoretic description of gravity has been found that is both strictly local down to the smallest level and consistently quantizable, i.e. that results in a renormalizable quantum theory.
- As suggested by the Wilsonian interpretation of QFT, a fundamentally new (nonlocal) picture of the microscopic degrees of freedom is needed to make headway. This is where *string theory* comes in, whose central axiom is that _the fundamental objects in Nature are one-dimensional rather than pointlike._ Combined with the standard kinematics of *general covariance*#footnote[General covariance is the paradigm that the form of physical laws should be invariant under arbitrary differentiable coordinate transformations. This statement is motivated by the conviction that coordinates don't exist in nature, and are only artifices of our description. Hence, which ones we choose should play no physical role.] and the usual procedure of *quantization*, this simple statement has resulted in an amazingly rich, mathematically intricate and conceptually insightful framework. In particular, string theory leads to a unified description of all forces, a divergence-free UV completion of QFT, and it recovers Einstein gravity at low energies.

== Central properties

- There is only _one_ free parameter in string theory, the *string length* $ell_s$ which (due to current limits of high-energy colliders) can take any value in the range
  $ "(Planck length)" wide 10^(-35) "m" < ell_s < 10^(-19) "m" wide "(TeV scale)". $
  This is in stark contrast to GR and QFT where _all_ masses and higher couplings are input parameters that have to be taken from experiment. String couplings are given by expectation values of a dynamical field, the scalar dilaton $phi$. That means they can be calculated from within the theory!
- String states can be classified into two regimes:
  + In the *low-energy limit* of distances much larger than $ell_s$, strings appear pointlike. Integrating out the massive string tower results in a low-energy effective theory of only the massless excitations. These are found to model gauge interactions and gravity. Conformal invariance of the field theory on the worldsheet requires that to lowest order, gravity obeys the Einstein equations.
  + The *ultraviolet regime* resides at distances of the order of $ell_s$. The extended nature of the string becomes important, rendering the theory nonlocal with important consequences for interactions: Sharp vertices at which interactions are localized in space and time no longer exist.#footnote[In point-particle theories, the sharp localization of vertices is responsible for the appearance of divergent amplitudes.] Locally, the string always appears free with interactions encoded solely in the global worldsheet topology.
- In string perturbation, each loop order (for a given process) contains only a single diagram. By contrast, the number of Feynman graphs in QFT grows factorially. Due to a feature called *duality*, there is no need to sum over the scattering channels $s$, $t$, $u$. They are all the same in string theory.
- A string can be open or closed. Open strings generate Yang-Mills theory, closed strings produce gravity. Since open strings can close up and vice versa, gravity and Yang-Mills are dynamically related. One automatically implies existence of the other, as it must be, to allow for effects such as energy stored in an electric field to gravitate itself. This is what is meant with the statement that string theory provides a unified description of all forces.

= Classical bosonic string <sec:bosonic>

== Bosonic string action

- The *Nambu-Goto action* of the classical bosonic string spanning the worldsheet $Sigma$ is defined as
  $ S_"NG" [X] = -T integral_Sigma dif A. $
  $T$ is the string tension and $dif A = sqrt(-det(vb(G))) dif tau dif sigma$ the area element of $Sigma$ with coordinates $bxi = (xi^0, xi^1) = (tau, sigma)$. The components of the *pullback $vb(G)$* of the ambient space metric $eta_(mu nu)$ onto $Sigma$ are
  $ G_(a b) = (partial X^mu)/(partial xi^a) (partial X_mu)/(partial xi^b), wide a, b in {0, 1}, quad mu in {0, ..., d - 1}. $
- To eliminate the square root in $S_"NG"$, we introduce the *worldsheet metric* $h^(a b) (tau, sigma)$ as an auxiliary (symmetric two-tensor) field and define the *Polyakov action*
  $ SP [X, h] = -T/2 integral_Sigma dd(2, xi) sqrt(-h) h^(a b) G_(a b), wide "with" h = det(vb(h)). $ <eq:polyakov>
  The bosonic string field $X^mu (tau, sigma)$ in $G_(a b)$ provides an embedding of the worldsheet into ambient space. $X^mu$ is a spacetime vector but a scalar on the worldsheet (due to the absence of worldsheet indices). Hence $SP$ describes $d$ scalar fields $X^mu$ coupled to the dynamical worldsheet metric $h_(a b)$.
  - Since the spacetime coordinates $X^mu$ of the string are promoted to dynamical fields, spacetime becomes a derived concept. The fundamental object is the field theory on the worldsheet.
  - $SP$ and $S_"NG"$ are classically equivalent, i.e. upon enforcing the equation of motion for the auxiliary field $h_(a b)$. However, this equivalence does not extend to the quantum level.
  - @eq:polyakov is not the most general bosonic string action imaginable. $SP$ could be modified in two ways:
    + A *cosmological constant term* $S_Lambda = Lambda integral_Sigma dd(2, xi) sqrt(-h)$ could be added, but this would spoil Weyl invariance which will turn out to be vital for consistency of the CFT on the worldsheet.
    + We might also include an *Einstein-Hilbert term* $S_"EH" = lambda_"EH"/(4 pi) integral_Sigma dd(2, xi) sqrt(-h) cal(R)$ with $cal(R)$ the Ricci scalar of the worldsheet. But this is a total derivative and hence introduces no new dynamics (corresponding to the fact that two-dimensional gravity is dynamically trivial).

== Symmetries

- $SP$ enjoys several symmetries, where it is important to distinguish between spacetime symmetries in $RR^(1,d-1)$ (taken to be flat) and worldsheet symmetries on $Sigma$ (dynamic). $SP$ is invariant under
  + $d$-dimensional _spacetime_ *Poincaré transformations* $X^mu -> Lambda^mu zws_nu X^nu + V^mu$, with $Lambda^mu zws_nu$ in the Lorentz group $S O(1, d - 1)$ and $V^mu in RR^(1,d-1)$ a translation. The associated conserved charges (according to Noether's theorem) are energy, momentum, and angular momentum.
  + Local _worldsheet_ *diffeomorphisms* $xi^a -> xi^a + eps^a (xi)$ under which the string field $X^mu$ transforms as $delta X^mu = eps^a partial_a X^mu$, the metric $h_(a b)$ as $delta h_(a b) = nabla_a eps_b + nabla_b eps_a$, and the object $sqrt(-h)$ as $delta sqrt(-h) = partial_a (eps^a sqrt(-h))$, i.e. like a scalar density of weight $p = 1$.
  + Local *Weyl transformations* $h_(a b) -> Lambda(bxi) h_(a b)$ (parametrized by $Lambda(bxi) = e^(omega(bxi))$ with $omega(bxi) in RR$ for convenient series expansion). This symmetry is special in that it arises only for two-dimensional world#emph[sheets] (as opposed to, say, membranes), making strings a unique generalization of point-particles. This symmetry requires $T^a zws_a = 0$ and is crucial for a consistent string quantization.
- The effect on the metric $h_(a b)$ of certain diffeomorphisms $eps_a$ that fulfill the *conformal Killing eq.* $P^c_(a b) eps_c = (vb(P) vb(eps))_(a b) = 0$ can be undone by a Weyl rescaling $Lambda^(-1)$. The linear operator $vb(P)$ is defined via
  $ delta h_(a b) = nabla_a eps_b + nabla_b eps_a = underbrace(nabla_a eps_b + nabla_b eps_a - nabla^c eps_c h_(a b), P^c_(a b) eps_c) + underbrace(nabla^c eps_c, Lambda) h_(a b). $ <eq:killing>
  These $eps_a$ are the *conformal Killing vectors*. Every such $eps_a$ yields a conserved current $J_eps^a = T^(a b) eps_b$ with $nabla_a J_eps^a = 0$ ($T^a zws_a = 0$ is used to show this). The number of such $eps_a$ is infinite and hence infinitely many conserved currents arise.
- The *energy-momentum tensor* is defined as the variation of $SP$ w.r.t. to the worldsheet metric,
  $ T_(a b) = (4 pi)/sqrt(-h) (delta SP)/(delta h^(a b)) = -1/alpha' (G_(a b) - 1/2 h_(a b) G^c zws_c). $
  It is traceless $T^a zws_a = 0$ (as a consequence of Weyl invariance), and (for on-shell $X^mu$) constitutes the conserved current $nabla^a T_(a b) = 0$ with respect to local worldsheet diffeomorphisms.
  - The e.o.m. $T_(a b) = 0$ for $h_(a b)$ implies $G_(a b) = G^c zws_c/2 h_(a b)$, i.e. on-shell $h_(a b)$ is proportional to the pullback.

== Gauge-fixing

- On a $D$-dimensional worldmembrane $h_(a b)$ has $D/2 (D + 1)$ degrees of freedom, while diffeomorphisms plus Weyl rescalings account for $(D + 1)$ parameters. Precisely in $D = 2$ do we have equally many transformational parameters as metric degrees of freedom. Two more features exclusive to $D = 2$ are that the Riemann-tensor has only one degree of freedom given by the Ricci scalar $cal(R)$,
  $ R_(a b c d) = cal(R)/2 (h_(a c) h_(b d) - h_(a d) h_(b c)), $
  and second, that under a Weyl rescaling $Lambda(bxi)$, $cal(R)$ transforms as $cal(R) -> cal(R) - vb(nabla)^2 Lambda(bxi)$. Choosing $Lambda(bxi)$ such that $cal(R) = vb(nabla)^2 Lambda(bxi)$ (locally, this is always possible) thus implies $R_(a b c d) = 0 thick forall a, b, c, d$. This means we can always transform the worldsheet so that locally, it resembles flat space. Once space is flat, we can transform coordinates, i.e. apply a diffeomorphism to bring the metric into Minkowskian shape $h_(a b) = eta_(a b)$. This procedure of fixing the metric is called (partially) *fixing the gauge*.
  - It leaves a large *residual gauge symmetry* generated by the conformal Killing vectors $vb(eps)$ mentioned above. Since these leave the metric invariant, they still represent an unphysical gauge symmetry in our description even after the metric has been fixed.
  - Worldsheets may exhibit topological obstructions to fixing the metric globally. In this case there remain parameters in the metric, so-called *moduli*, which cannot be removed by a conformal rescaling and diffeomorphisms. These moduli are the global properties of worldsheets that account for string interactions (mentioned in item 2 of the central properties of string theory).
- In *flat gauge* $h_(a b) = eta_(a b)$, the Polyakov action reduces to the action of $d$ _free_ scalar fields,
  $ SP [X] = T/2 integral_Sigma dd(2, xi) [(partial_tau vb(X))^2 - (partial_sigma vb(X))^2]. $ <eq:flat-gauge>
- *Lightcone coordinates* $xi^plus.minus = tau plus.minus sigma$ are convenient, e.g. when treating closed string mode expansions with right- and left-moving modes $ba_n^plus.minus$ ($+$ right-moving, $-$ left-moving). The metric in *lightcone gauge* reads
  $ h_(plus.minus plus.minus) = 0, quad h_(plus.minus minus.plus) = -1/2, wide "i.e." vb(h) = mat(0, -1/2; -1/2, 0), quad vb(h)^(-1) = mat(0, -2; -2, 0), $
  yielding the line element $dif s^2 = h_(a b) xi^a xi^b = -dif tau^2 + dif sigma^2 = -dif xi^+ dif xi^-$. The Jacobian of the transformation $vec(tau, sigma) -> vec(xi^+, xi^-) = vec(tau + sigma, tau - sigma)$ from worldsheet to lightcone coordinates has determinant
  $ |det(vb(J))| = abs(det mat(partial_tau xi^+, partial_sigma xi^+; partial_tau xi^-, partial_sigma xi^-)) = abs(det mat(1, 1; 1, -1)) = 2. $
  Thus the measure becomes $dif^2 xi = dif tau dif sigma = 1/2 dif xi^+ dif xi^-$ and the partial derivatives are $partial_plus.minus = 1/2 (partial_tau plus.minus partial_sigma)$.
  - The Polyakov action and energy-momentum-tensor in lightcone coordinates read
    $ SP [X] = T integral_Sigma dd(2, xi) partial_+ vb(X) dot partial_- vb(X), #h(4em) T_(plus.minus plus.minus) = -1/alpha' partial_plus.minus vb(X) dot partial_plus.minus vb(X). $ <eq:lightcone-action>
    Tracelessness translates into $T_(plus.minus minus.plus) = 0$, and conservation into $partial_minus.plus T_(plus.minus plus.minus) = 0 => T_(plus.minus plus.minus) (xi^plus.minus)$. It is important to remember that in flat gauge, the metric's equation of motion $T_(a b) = 0$ still has to be enforced as constraint. Partially fulfilled already by tracelessness, this only amounts to $T_(plus.minus plus.minus) = 0$.
  - The conformal Killing equation $(vb(P) vb(eps))_(a b) = 0$ in lightcone gauge, where now $vb(eps) = (eps_+, eps_-)$, becomes the statement $partial_plus.minus eps_plus.minus = 0$. Using $eps^plus.minus = h^(plus.minus a) eps_a = h^(plus.minus minus.plus) eps_minus.plus = -2 eps_minus.plus$, this means $partial_minus.plus eps^plus.minus = 0 => eps^plus.minus = eps^plus.minus (xi^plus.minus)$, i.e. the $eps^plus.minus$ are chiral.

== Mode expansion

- Varying the Polyakov action @eq:flat-gauge w.r.t. to the bosonic string field yields the free wave equation
  $ (partial_tau^2 - partial_sigma^2) X^mu = 0 = partial_+ partial_- X^mu $
  provided the boundary terms vanish. The closed string has canceling periodic boundaries. The open string requires *Neumann* ($partial_sigma X^mu = 0$) and/or *Dirichlet* ($delta X^mu = 0 = partial_tau X^mu$) boundaries at both ends $sigma in {0, l}$. Each has a different mode expansion, e.g. the open NN string expansion is
  $ X^mu = x^mu + (p^mu tau)/(T l) + i sqrt(2 alpha') sum_(n != 0) alpha_n^mu/n e^(-i pi/l n tau) cos((n pi sigma)/l). $ <eq:nn-expansion>
- From ${X^mu (tau, sigma), Pi^nu (tau, sigma')}_"PB" = eta^(mu nu) delta(sigma - sigma')$ with $Pi^mu = T partial_tau X^mu$, the *Poisson bracket* for the modes follows as ${alpha_m^mu, alpha_n^nu}_"PB" = -i m eta^(mu nu) delta_(m, -n)$ (for both left- and right-movers). Also, ${x^mu, p^nu}_"PB" = eta^(mu nu)$.
- Inserting the $partial_plus.minus X^mu$ that result from @eq:nn-expansion into $T_(plus.minus plus.minus)$ from @eq:lightcone-action yields the mode expansion
  $ T_(plus.minus plus.minus) = 4 alpha' sum_(m in ZZ) L_m^plus.minus e^(-i (2 pi)/l m xi^plus.minus) $
  in terms of the *Virasoro generators* $L_m$. The equation of motion (or constraint if $h_(a b)$ is fixed) $T_(a b) = 0$ thus implies the *Virasoro constraints* $L_m^plus.minus = 0 thick forall m in ZZ$.
- In particular, the *Hamiltonian*, which for the open string reads
  $ H_"op" = pi/l L_0 = pi/l 1/2 sum_(n in ZZ) ba_(-n) dot ba_n = pi/l (1/2 ba_0^2 + 1/2 sum_(n != 0) ba_(-n) dot ba_n) = pi/l (alpha' vb(p)^2 + sum_(n=1)^infinity ba_(-n) dot ba_n), $
  must vanish due to $T_(a b) = 0$ which implies the (classical open string) *mass shell condition*
  $ M^2 = -vb(p)^2 = 1/alpha' sum_(n=1)^infinity ba_(-n) dot ba_n = N/alpha'. $
  For closed strings, $H_"cl" = (2 pi)/l (L_0^+ + L_0^-) prop partial_+ + partial_- prop partial_tau limits(=)^! 0$ implements time reparametrization inv.

= Bosonic string quantization

- There are three popular ways to quantize string theory, each with its own merits and downsides.
  + In the (old) *canonical quantization*, the Virasoro constraints are not implemented until we reach the quantum level. This manifestly retains the Lorentz covariance of the classical theory, but a unitary quantum theory is ensured only in a critical number of spacetime dimensions $d_"crit"$.
  + *Lightcone quantization* enforces the Virasoro constraints already at the classical level, resulting in a manifestly unitary quantum theory. But Lorentz covariance holds only in $d = d_"crit"$.
  + (Modern) *path-integral quantization* uses the Faddeev-Popov gauge fixing procedure. Criticality becomes equivalent to closure of the BRST algebra, which can occur only in $d = d_"crit"$.

== Canonical quantization

- Canonical quantization promotes all fields to operators and postulates the replacement ${dot, dot}_"PB" -> 1/i [dot, dot]$, resulting in the canonical commutation relations
  $ [X^mu (tau, sigma), Pi^nu (tau, sigma')] = i eta^(mu nu) delta(sigma - sigma'), wide [alpha_m^mu, alpha_n^nu] = m eta^(mu nu) delta_(m, -n), wide [x^mu, p^nu] = i eta^(mu nu). $
  - Reality $X^mu in RR$ at the classical level implies hermiticity $(X^mu)^dagger = X^mu$ at the quantum level which in turn requires $(alpha_m^mu)^dagger = alpha_(-m)^mu$. This carries over to the Virasoro generators $L_m^dagger = L_(-m)$.
- As always, this procedure is terribly ambiguous because there is nothing to tell us the 'correct' order within products of noncommuting operators. Hence we simply _define_ the *normal ordering* to be
  $ upright(N)(alpha_m^mu alpha_n^nu) = cases(alpha_m^mu alpha_n^nu quad & "for" m <= n, alpha_n^nu alpha_m^mu quad & "for" n < m) $
  and use this prescription to promote the Virasoro generators to the quantum theory as the operators
  $ L_m = 1/2 sum_(n in ZZ) upright(N)(ba_(m-n) dot ba_n). $ <eq:virasoro-quantum>
  Actual ambiguity arises only in $L_0$ because modes $alpha_m^mu$, $alpha_n^nu$ are noncommuting only if $m = -n$ and for $m != 0$. By defining $L_0^"cl" = L_0^"qu" - a$#footnote[$L_0^"cl"$ and $L_0^"qu"$ are both quantum operators. The superscripts merely indicate that $L_0^"cl"$ has the structure of the classical Virasoro generators without normal-ordering prescription whereas $L_0^"qu"$ does, i.e. is precisely the one defined in @eq:virasoro-quantum.], where $a$ follows from
  $
    L_0^"cl" & = 1/2 sum_(n in ZZ) ba_(-n) dot ba_n = 1/2 sum_(n=-infinity)^(-1) {ba_n dot ba_(-n) + eta_(mu nu) underbrace([alpha_(-n)^mu, alpha_n^nu], -n eta^(mu nu))} + 1/2 sum_(n=0)^infinity ba_(-n) dot ba_n \
             & = 1/2 sum_(n in ZZ) upright(N)(ba_(-n) dot ba_n) + d/2 sum_(n=1)^infinity n = L_0^"qu" - a,
  $
  we capture the ambiguity in a divergent *normal ordering constant* fixed by renormalization later.
- The *Virasoro algebra* formed by the quantum Virasoro generators
  $ [L_m, L_n] = (m - n) L_(m+n) + c/12 m(m^2 - 1) delta_(m, -n) $
  is a central extension by $CC$ of the classical Witt algebra ${L_m, L_n}_"PB" = (m - n) L_(m+n)$ satisfied by the classical Virasoro generators. The *central charge* $c = eta^mu zws_mu = d$ is given by the number of scalars $X^mu$. The fact that $c != 0$ indicates a quantum anomaly of the worldsheet's conformal symmetry.
- To exclude negative norm states from the physical Hilbert space and ensure a unitary theory, we impose (with Ehrenfest's theorem in mind) the *physical state condition*
  $ (L_m - a delta_(m,0)) ket(phi) = 0 wide forall m >= 0 "and" forall ket(phi) in cal(H)_"phys". $ <eq:physical-state>
- Since the (quantum) mass shell condition arises from the level-zero Virasoro constraint, the normal ordering constant $a$ affects the string mass. The structure of the physical Hilbert space is a tower of string excitations with increasing mass according to the number of excitations counted by $N$:
  $ M_"op"^2 ket(phi) = (1/alpha' (N - a) + T^2 Delta vb(x)^2) ket(phi). $ <eq:open-mass>
  $T^2 Delta vb(x)^2$ is the energy contribution from the string's tension, nonzero only for states stretched between noncoincident D-branes. The closed string states with $M_"cl"^2 ket(phi) = 2/alpha' (N^+ + N^- - 2 a) ket(phi)$ are organized by the *level matching condition* $(N^+ - N^-) ket(phi) = 0$.
  - For $a > 0$, the vacuum $ket(0\, vb(p))$ of bosonic string theory is *tachyonic* with $M^2 = -a/alpha'$. This is not inconsistent, but signals an instability of the (naive) vacuum. Such a theory rapidly decays.
  - Analysis of the level-zero Virasoro constraint on a first-excited level state $ket(phi) = xi_mu alpha_(-1)^mu ket(0\, vb(p))$ reveals
    $ (L_0 - a) ket(phi) = (ba_0^2 \/ 2 + ba_1 dot ba_(-1) - a) ket(phi) = (alpha' vb(p)^2 + 1 - a) ket(phi) limits(=)^! 0 wide => wide vb(p)^2 = (a - 1)/alpha'. $
    The level-one constraint evaluates to the requirement of transverse polarization $bxi$,
    $ L_1 ket(phi) = 1/2 (dots.h.c + ba_1 dot ba_0 + ba_0 dot ba_1 + ...) ket(phi) = sqrt(2 alpha') vb(p) dot bxi ket(phi) limits(=)^! 0 wide => wide vb(p) dot bxi = 0. $
    All higher constraints are vacuous (automatically satisfied). Since for $a > 1$ we have $vb(p)^2 > 0$, we can choose $vb(p)$ such that $p^0 = 0$. Then a purely $xi^0$-polarized state fulfills $vb(p) dot bxi = 0$, but, due to $chevron.l phi|phi chevron.r = chevron.l 0, vb(p)|(xi_mu alpha_(-1)^mu)^dagger (xi_mu alpha_(-1)^mu) ket(0\, vb(p)) = xi^mu xi_mu$, has negative norm for every $xi^0 > 0$. Thus $a <= 1$ is necessary for a unitary quantum theory. For $ket(phi)$ twice excited, we similarly find we need $d <= 26$.

== Lightcone quantization

- It is convenient in this procedure to introduce lightcone coordinates also for spacetime:
  $ X^plus.minus = 1/sqrt(2) (X^0 plus.minus X^(d-1)), quad X^i, thin i in {1, ..., d - 2}; quad eta_(plus.minus minus.plus) = -1 = eta_(minus.plus plus.minus), quad eta_(i j) = delta_(i j), $
  so that $vb(X) dot vb(X) = -2 X^+ X^- + sum_i (X^i)^2 = -2 X^+ X^- + vb(X)_perp^2$.
- The key idea of lightcone quantization is to use the infinite dimensional residual symmetry generated by the conformal Killing vectors fulfilling eq. @eq:killing to gauge away an infinite number of oscillator degrees of freedom, i.e. we set $alpha_n^+ = 0 thick forall n != 0$. This is possible because $tau = 1/2 (xi^+ + xi^-)$ fulfills the string field's e.o.m. $partial_+ partial_- tau = 0$. We can thus find a conformal Killing transformation that reshapes the worldsheet so that its time-axis agrees with one of the spacetime coordinates, say $X^+$, i.e. $X^+ = (2 pi alpha')/l p^+ tau + x^+$ (which is just the mode expansion with all modes except $alpha_0^+$ set to zero).
  - Of course, this procedure generally breaks Lorentz covariance as it singles out one coordinate!
- But it enables solving the Virasoro constraints at the classical level. By @eq:lightcone-action, $T_(a b) limits(=)^! 0$ becomes
  $ -2 (partial_tau vb(X) plus.minus partial_sigma vb(X))^+ (partial_tau vb(X) plus.minus partial_sigma vb(X))^- + (partial_tau vb(X) plus.minus partial_sigma vb(X))_perp^2 limits(=)^! 0. $
  Inserting the string field expansion turns the Virasoro constraints into an interdependence of modes
  $ alpha_n^- = 1/(sqrt(2 alpha') p^+) 1/2 sum_(i=1)^(d-2) sum_(m in ZZ) alpha_(n-m)^i alpha_m^i. $ <eq:lightcone-modes>
- Inserting spacetime lightcone coordinates into the flat-gauge Polyakov action from eq. @eq:flat-gauge yields
  $ SP = T/2 integral_Sigma dd(2, xi) [(partial_tau vb(X))_perp^2 - (partial_sigma vb(X))_perp^2] - integral_(-infinity)^infinity dif tau p^+ partial_tau q^-. $
  Following the standard quantization procedure gives canonically conjugate variables $X^i <-> Pi^i$ and $p^+ <-> partial_tau q^-$ with $q^- = 1/l integral_0^l dif sigma X^-$. Eq. @eq:lightcone-modes and $L_m$ quantize as $alpha_(n-m)^i alpha_m^i -> upright(N)(alpha_(n-m)^i alpha_m^i) - a delta_(m,0)$.
  - Since the Virasoro constraints are implemented explicitly, all excitations created by transverse modes $alpha_(-m)^i$ are automatically physical and the spectrum is manifestly free of ghosts.
- *Criticality* in lightcone quantization follows from requiring Lorentz covariance. A long calculation reveals that the *Lorentz algebra* is non-anomalous only if $d = 26$, $a = 1$.
- The quantized Hamiltonian for open NN strings is $H = pi/l (L_0 - a)$. It needs to be *renormalized* due to the divergent $a$. First, we regularize with a cutoff $Lambda$: $a = -(d - 2)/2 sum_(n=1)^infinity n = -lim_(Lambda -> infinity) (d - 2)/2 sum_(n=1)^infinity n (e^(-pi/(l Lambda)))^n$. Using $sum_(n=1)^infinity n q^n = q dif/(dif q) sum_(n=1)^infinity q^n = q/(1 - q)^2$, this becomes
  $ pi/l a = -lim_(Lambda -> infinity) pi/l (d - 2)/2 e^(-pi/(l Lambda))/(1 - e^(-pi/(l Lambda)))^2 = -lim_(Lambda -> infinity) (d - 2)/2 (l/pi Lambda^2 - pi/l 1/12 + cal(O)(Lambda^(-1))). $
  - The divergent $Lambda^2$-term scales with $l$. It can be absorbed by adding (via renormalization) a cosmological constant counterterm $S_"cc" prop Lambda^2 integral_Sigma dd(2, xi) sqrt(-h)$ to the bare Polyakov action.#footnote[We have to cancel the divergent term entirely to preserve conformal invariance: A nonzero cosmological constant term would break conformal symmetry already at the classical level. $a != 0$ also breaks conformal invariance, but only in the form of an acceptable anomaly at the quantum level.]
  - The finite term is only present due to the finite size of the string (it disappears for $l -> infinity$). There exists no local counterterm that could be added to absorb it. This term is therefore physical and defines the *Casimir energy* of the string as $pi/l a = pi/l (d - 2)/24$.
- For mixed rather than pure NN boundary conditions, each transverse NN-/DD-dimension contributes $1/24$ to the normal ordering constant and each ND-/DN-dimension $-1/48$. Thus $a_"tot" = (d - 2)/24 - (n_"ND" + n_"DN")/16$.

== String spectrum

- In a $d$-dimensional Lorentz covariant theory, states form irreducible representations of the subgroup $bb(S)$ -- called *little group* or *stabilizer* -- of the $d$-dimensional Poincaré group $S O(1, d - 1) times.r RR^(1,d-1)$ that leave their momentum $p^mu$ invariant. Depending on whether $p^mu$ is space-/light-/timelike, $bb(S)$ is:
  + For $vb(p)^2 > 0$, we can Lorentz transform to get $vb(p) = (0, p, 0, ..., 0)$ and hence $bb(S) = S O(1, d - 2)$. An example is the tachyonic ground state $ket(0\, vb(p))$ with $vb(p)^2 = a/alpha'$, a scalar of the little group $S O(1, 24)$.
  + For $vb(p)^2 = 0$ we can rotate coordinates so that $vb(p) = (p, p, 0, ..., 0)$, i.e. $bb(S) = S O(d - 2)$. States of this type are the first-level massless transverse excitations $xi_i alpha_(-1)^i ket(0\, vb(p))$. They are spacetime vectors in the fundamental representation (denoted $square$) of $bb(S) = S O(24)$.
  + $vb(p)^2 < 0$ admits $vb(p) = (p, 0, ..., 0)$, i.e. $bb(S) = S O(d - 1)$. All massive states (i.e. at second excited level or higher) form irreducible representations of $bb(S) = S O(25)$. E.g. a second-level state of the form $(xi_i alpha_(-2)^i + zeta_(i j) alpha_(-1)^i alpha_(-1)^j) ket(0\, vb(p))$ has $24 + 24/2 (24 + 1) = 324$ polarization degrees of freedom which combine into the symmetric traceless representation (denoted $square square$) of $S O(25)$.
- A *D$p$-brane* is a $(p + 1)$-dimensional hypersurface on which open strings can end, fixing them in place in the dimensions normal to it. DD boundary conditions allow for momentum flow off the string ends which implies that D-branes are dynamical (albeit non-perturbative) objects themselves.
- *Open string spectrum*: 1. The presence of a single D$p$-brane allows the following low-level states#footnote[The lightcone coordinates $X^plus.minus = 1/sqrt(2) (X^0 plus.minus X^25)$ must lie in NN dimensions for a treatment within lightcone quantiz.]:
  - The ground state $ket(0\, vb(p))$ can have nonzero momentum $vb(p)$ only in NN dimensions along the brane.
  - Excitations $xi_i alpha_(-1)^i ket(0\, vb(p))$ _parallel_ to the brane for $i in {1, ..., p - 1}$ form a massless vector from the perspective of the D$p$-brane. Its interactions identify it as a gauge potential. Thus a *single brane hosts a $U(1)$ gauge theory*! Excitations _normal_ to the brane $xi_a alpha_(-1)^a ket(0\, vb(p))$ for $a in {p, ..., 24}$ form $25 - p$ massless scalars. They are the *Goldstone bosons* associated with spontaneous breaking of the 26-dimensional Poincaré symmetry by the brane.

  2. Strings stretched between parallel D$p$-branes located at $x_1^a$ and $x_2^a$ receive a mass contribution $T^2 sum_a (x_2^a - x_1^a)^2$ from tension, rendering the above gauge and Goldstone excitations massive.

  3. For $N$ coincident D$p$-branes, states need to be labelled by *Chan-Paton factors* $r, s in {1, ..., N}$ enumerating the branes to keep track of the boundaries. We get the same states listed under 1, but $N^2$ copies of each, i.e. $N^2$ massless vectors and $N^2 (25 - p)$ massless scalars. The vectors enhance the original $U(1)$ gauge symmetry to a non-Abelian $U(N)$. States can be expanded in terms of the $N^2$ hermitian $N times N$-Chan-Paton-matrices $vb(lambda)^a$ that span the Lie algebra of $U(N)$.#footnote[In orientifolded theories, also $S O(N)$ and the symplectic $S p(2 N)$ are possible gauge groups of coincident branes.]
- *Closed string spectrum*: The polarization two-tensor $xi_(i j)$ of the first excited level decomposes into irreducible representations of the little group $S O(24)$: $xi_(i j) = g_(i j) + B_(i j) + phi delta_(i j)$, where $g_(i j)$ is symmetric traceless and describes massless, transversely polarized spin 2 particles, i.e. *gravitons*, while the antisymmetric $B_(i j)$ is called *Kalb-Ramond tensor field* and models a generalized (i.e. higher-rank) gauge potential. Lastly, $phi$, the trace part of $xi_(i j)$, is a scalar field called the *dilaton*.

== Covariant quantization

- The modern covariant approach to quantization utilizes the path integral which is particularly suitable for theories with gauge symmetries, and a powerful tool to compute string interactions.
- The naive partition function $Z = integral cal(D) X cal(D) h e^(i SP [X, h])$ overcounts due to gauge-equivalent configurations of the auxiliary field $h_(a b)$. The solution is to isolate the integral over gauge space, in this case over all diffeomorphisms $eps_a$ and Weyl rescalings $Lambda$, and cancel it by division with the gauge group's volume. This can be achieved with the Faddeev-Popov gauge fixing procedure and yields
  $ Z = integral cal(D) X det(vb(P)) e^(i SP [X, hat(h)]) $ <eq:fp-partition>
  with $hat(h)_(a b)$ an arbitrary reference metric, and $det(vb(P))$ the *Faddeev-Popov determinant*, stemming from the Jacobian of the transformation used to factor out $cal(D) eps$ and $cal(D) Lambda$ and cancel with $"Vol"_("diff" times "Weyl")^(-1)$,
  $ cal(D) h -> cal(D) eps cal(D) Lambda det((partial (vb(P) vb(eps), Lambda))/(partial (vb(eps), Lambda))) = cal(D) eps cal(D) Lambda det mat(vb(P), 0; 0, 1). $
  - We assumed every metric $h_(a b)$ can be transformed to $hat(h)_(a b)$ for precisely one combination of $eps_a$ and $Lambda$. There is, however, a double mismatch: 1. The conformal Killing vectors generate as yet unfixed residual gauge transformations which leave the metric invariant and must not be integrated over to avoid overcounting. 2. For worldsheets of complicated topology the metric contains global properties -- the moduli -- not accounted for by local gauge transformations. For topologies more complicated than the vacuum, we must sum over these moduli by hand.
- By introducing the Grassmann-valued Faddeev-Popov ghost $c^a (xi)$ and antighost $b_(a b) (xi)$, $det(vb(P))$ can be expressed as the Berezin integral $det(vb(P)) = integral cal(D) b cal(D) c e^(1/(4 pi) integral_Sigma dif^2 xi (-hat(h))^(1/2) vb(b) dot (vb(P) dot vb(c)))$ with which @eq:fp-partition becomes
  $ Z = integral cal(D) X cal(D) b cal(D) c e^(i (SP + S_g)). $
  $c^a (xi)$ and $b_(a b) (xi)$ are anti-commuting, fermionic fields with integer spin in violation of the spin-statistics theorem, thus producing negative norm states. They are governed by the ghost action
  $ S_g = (-i)/(2 pi) integral_Sigma dd(2, xi) (-hat(h))^(1/2) hat(h)^(a b) c^d nabla_a b_(b d) limits(=)^"lcg" i/pi integral_Sigma dd(2, xi) (c^+ partial_- b_(++) + c^- partial_+ b_(--)) $
  and the equations of motion $nabla^a b_(a b) = 0 = partial_minus.plus b_(plus.minus plus.minus)$ and $P^c_(a b) c_c = 0 = partial_minus.plus c^plus.minus => c^a$. The latter tells us that the ghost vectors $c^a$ are in one-to-one correspondence with the conformal Killing vectors $eps_a$.
- Ghosts and antighosts are canonically conjugate fields. Their modes $b_n$, $c_n$ fulfill the anti-commutation relations ${c_m, b_n} = delta_(m,-n)$ and ${c_m, c_n} = {b_m, b_n} = 0$. I.t.o. the ghost modes, the ghost Virasoro generators read $L_m^g = sum_(n in ZZ) (m - n) upright(N)(b_(m+n) c_(-n))$. The $L_m^g$ satisfy the *ghost Virasoro algebra*
  $ [L_m^g, L_n^g] = (m - n) L_(m+n)^g + m/6 (1 - 13 m^2) delta_(m,-n). $
  Defining $L_m^"tot" = L_m^X + L_m^g - a^"tot" delta_(m,0)$ yields the combined *ghost and bosonic Virasoro algebra*
  $ [L_m^"tot", L_n^"tot"] = (m - n) L_(m+n)^"tot" + [c^"tot"/12 m(m^2 - 1) + 2 m(a^"tot" - 1)] delta_(m,-n), $ <eq:total-virasoro>
  with central charge $c^"tot" = c^X + c^g$ where $c^g = -26$, $c^X = d$ in $RR^(1,d-1)$, and total normal ordering constant $a^"tot" = a^X + a^g$, where $a^g = -1/12$ and $a^X = d/24$ in a covariant gauge that treats $X^plus.minus$ as independent d.o.f. The presence of a central term signals a Weyl anomaly of the full action $SP + S_g$ and, hence, the path integral. But we used Weyl invariance to factor out the integration over gauge-equivalent metrics. Self-consistency thus requires that the central term vanishes which is the case precisely in $d = 26$ (this really fixes the central charge $c^X$ and only indirectly constrains $d$).
- In path integral quantization of gauge theories, the physical state condition is implemented via the *BRST symmetry*, a global, fermionic, residual symmetry of the full action $SP + S_g$ invariant under
  $ delta_epsilon X^mu = epsilon (c^+ partial_+ + c^- partial_-) X^mu, quad delta_epsilon c^plus.minus = epsilon (c^+ partial_+ + c^- partial_-) c^plus.minus, quad delta_epsilon b_(plus.minus plus.minus) = i epsilon (T_(plus.minus plus.minus)^X + T_(plus.minus plus.minus)^g), $
  where $epsilon$ is a global Grassmann-valued parameter. BRST invariance is present even after gauge fixing $h_(a b) = eta_(a b)$. It is generated by the nilpotent, Hermitian, conserved charge $Q_B$ via the brackets
  $ delta_epsilon X^mu = epsilon [Q_B, X^mu], #h(3em) delta_epsilon c^plus.minus = epsilon {Q_B, c^plus.minus}, #h(3em) delta_epsilon b_(plus.minus plus.minus) = epsilon {Q_B, b_(plus.minus plus.minus)}. $
  A long calculation reveals that nilpotence $Q_B^2 = 1/2 {Q_B, Q_B} limits(=)^! 0$, as required for consistency of the BRST symmetry, is equivalent to absence of the Weyl anomaly, i.e. zero central extension in @eq:total-virasoro.
- A physical state must be gauge invariant. Since $Q_B$ acts on $X^mu$ like the residual gauge transformations generated by conformal Killing vectors, a physical state must be invariant under a BRST transformation, i.e. $Q_B ket(phi) = 0 thick forall ket(phi) in cal(H)_"phys"$. This is not sufficient, however. As in quantization of Yang-Mills theory, nilpotence implies that the image of $Q_B$ lies within its kernel, $"Im"(Q_B) subset ker(Q_B)$. The states in $"Im"(Q_B)$ are null, i.e. orthogonal to all states including themselves. The physical (positive-norm) Hilbert space is given by the cohomology of $Q_B$, i.e.
  $ cal(H)_"phys" = cal(C)(Q_B) = ker(Q_B)/"Im"(Q_B). $
  States differing only by elements of $"Im"(Q_B)$ are in the same equivalence class and transform into one another by gauge transformations.

= Conformal field theory

- *Conformal symmetry* is invariance under rescalings which requires a theory to be free of intrinsic length, mass or energy scale, including the absence of massive excitations. Examples are 1. the string worldsheet, 2. fixed points of the renormalization group equations, 3. critical points in condensed matter and statistical physics, where the correlation length diverges, and 4. the AdS/CFT correspondence relates gravity on anti-de Sitter spaces to a conformal field theory on the boundary.
- Conformal transformations (henceforth conformals) are diffeomorphisms $g_(mu nu) (x) -> partial_(mu') x^alpha partial_(nu') x^beta g_(alpha beta) limits(=)^! Lambda(x) g_(mu nu) (x)$ that change the metric only up to a factor $Lambda(x) = e^(omega(x))$. Infinitesimally, this becomes $partial_mu eps_nu + partial_nu eps_mu = omega(x) g_(mu nu)$ where we expanded $x^mu = x'^mu + eps^mu (x)$ and $e^(omega(x)) = 1 + omega(x)$. $omega(x)$ satisfies constraints one of which is vacuous in $d = 2$ making the group of conformals less restrictive, so much so that the algebra of infinitesimal conformals becomes infinite-dimensional. This allows to solve some CFTs in $d = 2$ completely.
  - The set of infinitesimal conformals includes translations, Lorentz transformations, dilations (rescalings), and special conformals (inversion, translation, followed by another inversion).

== Conformal group in $d = 2$

- In $d = 2$, after compactifying the plane $CC union {infinity}$ with a point at infinity to the sphere $bb(S)^2$, a globally defined conformal can be parametrized by $z -> (a z + b)/(c z + d)$ where invertibility requires $a d - b c != 0$. Since rescaling to $a d - b c = 1$ and $(a, b, c, d) limits(->)^(ZZ_2) (-a, -b, -c, -d)$ does not affect the transformation, the conformal group on $bb(S)^2$ is the *Möbius group* $P S L(2, CC) = S L(2, CC) \/ ZZ_2$. It is generated by $l_(-1), l_0, l_1$, where the generators $l_n = -z^(n+1) partial_z$ fulfill the classical *Witt algebra*. An important property of $P S L(2, CC)$-invariance is that it can be used to map any three distinct points to any other three distinct points. In scattering amplitudes, this allows us to remove the residual gauge redundancy by fixing positions of asymptotic in- and out-states, implemented via vertex operators.
- By a *Wick rotation* $tau -> -i tau$, the metric becomes Euclidean $eta_(a b) = delta_(a b)$ and $xi^plus.minus = -i (tau plus.minus i sigma)$. The *conformal map* $tau + i sigma -> e^((2 pi)/l (tau + i sigma))$ then projects the cylinder (worldsheet of a freely propagating closed string) to the compactified plane $CC union {infinity} tilde.equiv bb(S)^2$. Similarly, the strip (worldsheet of a freely propagating open string) is conformally mapped to the (upper) half plane $bb(H)$ by $tau + i sigma -> e^(pi/l (tau + i sigma))$. Both maps translate time ordering on the cylinder/strip to radial ordering on the plane.

== Primary fields and operator product expansion

- *Primary fields* transform as tensors $phi(z, macron(z)) -> phi'(z', macron(z)') = (partial_z f)^(-h) (partial_macron(z) macron(f))^(-macron(h)) phi(z, macron(z))$ under a conformal $z -> z' = f(z)$, where $h$, $macron(h)$ are the conformal weights of $phi(z, macron(z))$. $h + macron(h)$ is the field's mass dimension, $h - macron(h)$ its conformal spin. For infinitesimal $f(z) = z + eps(z)$, this is $delta_(eps, macron(eps)) phi = (h partial_z eps + eps partial_z + macron(h) partial_macron(z) macron(eps) + macron(eps) partial_macron(z)) phi$.
  - Combined with operator product expansions, primaries can be used to express all higher $n$-point functions i.t.o. lower correlators; this enables defining a CFT i.t.o. a finite amount of input data.
  - *Quasi-primary fields* behave like primaries, but only for $f in P S L(2, CC)$.
  - The string field $X^mu$ itself is not a primary (nor even a quasi-primary), but $partial X^mu$ and $upright(N)(e^(i vb(k) dot vb(X)))$ are.
- A purely left-/right-moving field $phi(xi^-) \/ phi(xi^+)$ on the cylinder corresponds to a *chiral/antichiral primary field* $phi(z) \/ phi(macron(z))$ of weight $h \/ macron(h)$ on the plane with Laurent series $phi(z) = sum_(n in ZZ) phi_n z^(-n-h)$.
- In a CFT, the structure of the *operator product expansion* (OPE) given by
  $ cal(O)_i (x_i) cal(O)_j (x_j) = sum_k C_(i j)^k (|x_i - x_j|) cal(O)_k (x_j) $
  is particularly powerful due to three properties that stem from conformal invariance: 1. The OPE of two quasi-primaries involves only other quasi-primaries and their derivatives, the *descendant fields*. 2. The functional dependence of the structure constants $C_(i j)^k$ is completely fixed. 3. The OPE is an exact expression with radius of convergence equal to the distance of the next field insertion.
- By *Wick's theorem*, the radially ordered operator product $upright(R)(product_(i=1)^n phi_i)$ can be expanded as
  $ upright(R)(product_(i=1)^n phi_i) = upright(N){product_(i=1)^n phi_i + sum_(j != k)^n ev(phi_j phi_k) product_(i != j,k)^n phi_i + sum_(j != k, l != m)^n ev(phi_j phi_k) ev(phi_l phi_m) product_(i != j,k,l,m)^n phi_i + ...}. $

== Conformal Ward identities

- Ward identities are general statements that appear in any QFT: given a symmetry transformation, be it a global field shift $phi -> phi + eps delta phi$, a gauge transformation $A^mu -> A^mu + partial^mu alpha(x)$ as in QED, or a conformal as discussed here, the Ward identities tell us how the correlation functions transform. Since a symmetry implies that correlations should remain _un_\changed, this usually results in constraints on the scattering amplitudes, as e.g. in QED, where the Ward identities require $k^mu cal(M)_mu = 0$ for any scattering $cal(M) = xi^mu cal(M)_mu$ with an external photon of momentum $k^mu$ and polarization $xi^mu$.
- By the *conformal Ward identity*, the behavior of a field $phi(z)$ (chiral for brevity) under a conformal $z -> z + eps(z)$ is encoded in the residua of its OPE with the energy-momentum tensor $T(z)$,
  $ delta_eps phi(w) = integral_(C_w) (dif z)/(2 pi i) eps(z) upright(R)[T(z) phi(w)]. $
  - For $phi(w)$ primary of weight $h$, this gives $upright(R)[T(z) phi(w)] = (h phi(w))/(z - w)^2 + (partial_w phi(w))/(z - w) + "terms regular at" z = w$.
  - The energy-momentum tensor's OPE with itself follows from the Virasoro algebra $[L_m, L_n]$ as
    $ T(z) T(w) = (c\/2)/(z - w)^4 + (2 T(w))/(z - w)^2 + (partial_w T(w))/(z - w). $
    Thus, $T(z)$ is a primary of $h = 2$ only if $c = 0$. Otherwise it is quasi-primary. (Here, we expanded $T(z) = sum_(n in ZZ) L_n z^(-n-2)$ and used $L_n = integral.cont (dif z)/(2 pi i) T(z) z^(n+1)$.)

== Operator-state correspondence

- The *operator-state correspondence* is an isomorphism in two-dimensional CFTs that relates the action of primary fields on the $P S L(2, CC)$-invariant vacuum to asymptotic in- and out-states:
  $ ket(phi_"in") = phi(0) ket(0) = phi_(-h) ket(0), #h(6em) bra(phi_"out") = lim_(z -> infinity) z^(2 h) bra(0) phi(z) = bra(0) phi_h, $
  where we took $phi(z)$ to be a primary of weight $h$ with expansion $phi(z) = sum_(n in ZZ) phi_n z^(-n-h)$. The modes $phi_n$, $n > -h$ act as annihilators since $phi_n ket(0) = 0 thick forall n > -h$. Modes $phi_n$ with $n <= -h$ are creators.
- A primary state $ket(phi) = phi(0) ket(0) = phi_(-h) ket(0)$ is eigenstate of the level-zero Virasoro generator $L_0$ with eigenvalue $h$, i.e. $L_0 ket(phi) = h ket(phi)$. Using $[L_m, phi_n] = [m(h - 1) - n] phi_(m+n)$, we can show that for $m > 0$ ($m < 0$) the other $L_m$ act on these so-called *highest-weight states* as annihilators (creators):
  $ L_0 ket(phi) = h ket(phi) wide => wide cases(L_m ket(phi) = 0 & forall m > 0\,, L_0 L_(-m) ket(phi) = (m + h) L_(-m) ket(phi) quad & forall m >= 0.) $
  The complete Hilbert space is obtained by acting with $L_(-m)$, $m > 0$ on all highest weight states $ket(phi_j)$, where $j$ labels all primary fields.
- Requiring BRST-invariance of the $X$-CFT gives as physical state condition $L_m ket(phi) = 0 thick forall m > 0$ and $(L_0 - 1) ket(phi) = 0$. This demonstrates that physical states are in one-to-one correspondence with primaries of weight $h = 1$, leading to the concept of a *vertex operator* as a primary field of $h = 1$.
  - For instance, $upright(N)[e^(i vb(k) dot vb(X))]$ is a primary of weight $h = alpha'/4 vb(k)^2$. $h limits(=)^! 1$ implies $M^2 = -4/alpha'$. Inserted at $z = 0$, this creates the closed string ground state from the vacuum.
  - $upright(N)[partial X^mu (z) e^(i vb(k) dot vb(X)(z))]$ is a primary of weight $h = 1 + alpha'/4 vb(k)^2$. As a vertex operator with $h limits(=)^! 1$, this implies $M^2 = 0$, i.e. this vertex operator produces first-excited level states from the vacuum.
- The *Verma module* $V_(h_j)$ is the span of all states that are of the form
  $ ket(phi_j^(k_1 ... k_m)) = product_i^m L_(-k_i) ket(phi_j) wide "with weight" quad h_V = h_j + sum_i^m k_i quad "and" quad k_i > 0. $
  The $ket(phi_j^(k_1 ... k_m))$ are created by the descendant fields $phi_j^(k_1 ... k_m) (z)$, i.e. derivatives of quasi-primaries. For ordered $k_i$, i.e. $k_1 >= k_2 >= dots.c >= k_m$, the $ket(phi_j^(k_1 ... k_m))$ are linearly independent.
- *CFT unitarity* requires the conformal anomaly to fulfill $c > 0$ and the spectrum of primaries $phi_j$ to have all non-negative weights, $h_j >= 0 thick forall j$. Finally, $h_phi = 0$ must imply $phi = bb(1)$, i.e. only the $P S L(2, CC)$-invariant vacuum may have conformal dimension $h = 0$.
- A two-dimensional CFT is completely specified by its conformal anomaly $c$, the spectrum of primary fields $phi_j$, their weights $h_j$, and their OPE coefficients $C_(i j)^k$. In particular, no action $S_"CFT"$ is needed.

= String interactions

- A key property of string scattering is the *absence of interaction vertices* which fundamentally distinguishes it from point-particle scattering in QFT. Locally, the string worldsheet always looks like that of a freely propagating string! Only global properties of the worldsheet capture interactions, which are hence encoded already in the free two-dimensional CFT without adding arbitrary further terms to the action as in QFT.
- As an important result, correlators of different fields (bosons, fermions, ghosts) decouple! This is completely different from e.g. Yang-Mills which suffers from complicated ghost-gauge interactions.
- The path integral for the computation of scattering amplitudes usually accounts for the initial and final states by admitting only those worldsheets into the sum over histories that asymptote towards the specified in- and out-configurations. Thanks to the operator-state correspondence, the worldsheet CFT allows for a simpler procedure: We consider trivial boundary conditions, i.e. the vacuum, as asymptotic in- and out-states and specify the type of scattering process solely by inclusion of vertex operators in the integrand, corresponding to states being created at different places on the worldsheet.

== String perturbation and worldsheet topologies

- *String perturbation* aims to calculate the *S-matrix* of a scattering process. The loop expansion corresponds to a sum over compact worldsheets of increasingly complex topology, but each with the same number of vertex operators inserted on the surface (closed string) or boundary (open string).
- Which topologies to sum over is determined by the central theorem: _Every compact, connected, oriented two-dimensional manifold is topologically equivalent to a sphere with $g$ handles ($g$ for genus) and $b$ boundaries._ In fact, $b$ and $g$ fully determine a worldsheet's *Euler characteristic* $chi = 2 - 2 g - b$, a topological invariant unaffected by continuous deformations of the worldsheet metric. According to the *Gauss-Bonnet theorem*, it is given by
  $ chi = integral_Sigma (dif^2 xi)/(4 pi) sqrt(-h) cal(R) + integral_(partial Sigma) (dif s)/(2 pi) k, $
  with $cal(R)$ the Ricci scalar of the worldsheet's surface and $k$ the geodesic curvature of its boundary.
  - For instance, the tree-level and one-loop worldsheet topologies of the oriented string are
    #align(center, booktable(
      3,
      ([sector], [tree-level], [one-loop]),
      [open], [disk $bb(D)^2$ with $(g, b) = (0, 1)$, $chi = 1$], [cylinder $bb(C)^2$ with $(g, b) = (0, 2)$, $chi = 0$],
      [closed], [sphere $bb(S)^2$ with $(g, b) = (0, 0)$, $chi = 2$], [torus $bb(T)^2$ with $(g, b) = (1, 0)$, $chi = 0$],
    ))
- Incorporating all of the above statements results in a heuristic expression for $n$-string scattering,
  $ S_(j_i) (k_i) = sum_("compact" \ "topologies") (integral cal(D) X integral cal(D) h)/"Vol"_("diff" times "Weyl") e^(-SP - lambda chi) product_(i=1)^n V_(j_i) (k_i), $
  where $chi$ (added to the action without affecting dynamics) modifies the usual weighting factor $e^(-SP)$ to take into account the worldsheet topology. This is before gauge-fixing, hence the factor $"Vol"_("diff" times "Weyl")^(-1)$.

== Metric moduli of Riemann surfaces

- $vb(P)^dagger$ defines the adjoint of the conformal Killing operator $vb(P)$. It maps two-tensors $t_(a b)$ to vectors via $(vb(P)^dagger vb(t)) = nabla^b t_(a b)$. If there exists a symmetric, traceless $vb(t)_0$ such that $vb(P)^dagger vb(t) = 0$, then for an arbitrary transformation $eps_a$, we have $0 = chevron.l vb(eps), vb(P)^dagger vb(t)_0 chevron.r = (vb(P) vb(eps)|vb(t)_0)$, meaning $vb(P) vb(eps)$ is orthogonal to $vb(t)_0$ for all $eps_a$, i.e. no transformation can be found to obtain the two-tensor $vb(t)_0$. Such tensors are called *metric moduli*. They represent deformations of the metric that _cannot_ be reached by any diffeomorphism or Weyl rescaling. Similar to the ghost e.o.m. $P^c_(a b) c_c = 0$ which identifies normalizable ghost solutions $c_a$ as conformal Killing vectors, the _anti_\ghost e.o.m. shows that the normalizable zero-modes of the $b_(a b)$ are in one-to-one correspondence with the metric moduli.
- A *Riemann surface* is a one-dimensional complex manifold (can be thought of as a deformed version of the complex plane). Its degrees of freedom are given by the number of metric moduli.
- The Riemann-Roch theorem goes on to state that the number $mu = dim(ker vb(P)^dagger)$ of moduli and $kappa = dim(ker vb(P))$ of conformal Killing vectors of (orientable) Riemann surfaces fulfill
  $ mu - kappa = -3 chi #h(3em) "and" #h(3em) cases(mu = 0 quad & "if" chi > 0\,, kappa = 0 & "if" chi < 0.) $
- Deriving the gauge-fixed S-matrix via the Faddeev-Popov procedure yields the prescription:
  + For each conformal Killing vector field $eps_a$ on the worldsheet, we fix one vertex operator $V_(j_i) (vb(k)_i, bxi_i)$ at $hat(bxi)_i$ and replace the integral over the insertion point $integral_Sigma dif^2 xi_i$ by a ghost field $c_i^a (hat(bxi)_i)$ also at $hat(bxi)_i$. Alternatively we can keep the integral but divide by the volume of the remaining gauge group.
  + For each modulus $vb(t)^a$, we insert an antighost field via $(vb(b)|partial_a hat(vb(h)))$ and integrate over the fundamental domain $integral_F dif t^a$ (which ensures only topologically inequivalent worldsheets enter the path integral).
  - For example, the sphere $bb(S)^2$ is the Riemann surface of maximal Euler number. Since $chi > 0$, it is moduli-free $mu = 0$, i.e. no antighost insertions are necessary in S-matrix calculations on $bb(S)^2$ (this holds for all tree-level scatterings in string theory). $kappa = 3 chi = 6$ shows that the sphere is endowed with six conformal Killing vector fields. We count real degrees of freedom, so this is consistent with the gauge group on $bb(S)^2$ being $P S L(2, CC)$ with three independent complex parameters ($a d - b c limits(=)^! 1$), each of infinite range. With less than three integrated vertex operators, nothing cancels this infinity in the S-matrix denominator. Hence, the oriented closed string 0-, 1-, and 2-point functions vanish at tree-level, meaning no vacuum energy, tadpole, and mass renormalization.

== Duality and UV finiteness

- In string theory, amplitudes are completely symmetric in all channels ($s$, $t$, $u$) and exhibit an infinite number of (simple) poles (due to the appearance of $Gamma$-functions such as $Gamma(-1 - alpha'/4 s)$) corresponding to resonances for every mass in the string spectrum, a property called *channel duality*.
  - As a result, a single worldsheet diagram captures what in QFT requires $s$-, $t$-, and $u$-channel Feynman diagrams and a sum over resonances of the propagator $i/(p^2 - m^2)$. Compared to point-particle QFT, this leads to a much faster (exponential) fall off of string amplitudes; a feature partially responsible for *UV finiteness* of string loop diagrams. Heuristically, strings behave differently in the hard-scattering limit because high-energy processes probe on scales of the order of the string length where the string acts as a nonlocal object.
  - Another reason for improved UV behavior is *modular invariance*, i.e. invariance of the worldsheet topology under the action of the modular group (e.g. $P S L(2, ZZ)$ on the torus) which acts as an intrinsic regulator (UV cutoff) for the theory by excluding divergent areas of the moduli space from the fundamental domain.
  - Some UV divergences do arise in string perturbation but they are no issue for UV finiteness due to *worldsheet duality* between the open and closed channel: _all_ UV divergent diagrams turn out to be IR divergences of dual diagrams. For instance, the cylinder is the worldsheet topology for both tree-level closed string and one-loop open string scatterings.

== Strings in curved target space

- The *non-linear $sigma$-model* describes the bosonic string field $X^mu$ propagating on a curved target space with deviations from the flat metric $eta_(mu nu)$ generated by a coherent state of its _own_ massless graviton fluctuations. Including also the other massless excitations into the Polyakov action yields
  $ S_sigma = 1/(4 pi alpha') integral_Sigma dd(2, xi) sqrt(h) {[h^(a b) g_(mu nu) (X) + i eps^(a b) B_(mu nu) (X)] partial_a X^mu partial_b X^nu + alpha' cal(R) phi(X)}. $
  This is the *closed $sigma$-model action* with $g_(mu nu)$ the graviton, $B_(mu nu)$ the antisymmetric Kalb-Ramond field (coupled to an equally antisymmetric worldsheet tensor $eps^(a b)$), and $phi$ the dilaton. $phi(X)$ appears as a generalization of the hitherto unspecified $lambda$ in the topological term
  $ lambda chi = lambda/(4 pi) integral_Sigma dd(2, xi) sqrt(-h) cal(R) wide -> wide 1/(4 pi) integral_Sigma dd(2, xi) sqrt(-h) cal(R) phi(X). $
  Importantly, the string coupling, which determines the probability of strings to split and reconnect, is therefore really given by $g_s = e^(phi(X))$, i.e. the coupling is dynamical (not a constant) and determined by the vacuum expectation value of the string field itself, more precisely that of the dilaton. This holds generally in string theory (not just for $S_sigma$).
  - Consistency of the $sigma$-model requires the absence of a Weyl anomaly, i.e. the classical scale invariance must carry over to the quantum theory. This is the case if
    $ beta_(mu nu)^g (E) = E partial/(partial E) g_(mu nu) (X, E) = alpha' R_(mu nu) + cal(O)[(alpha' \/ R_c)^2] limits(=)^! 0, wide (E "the energy scale") $
    i.e. if the spacetime metric's $beta$-function vanishes. Thus consistency to first order in $alpha'/R_c$ (with $R_c$ the radius of the compact target space) requires that $g_(mu nu)$ is governed by Einstein's equations $R_(mu nu) = 0$ for the vacuum (we set all other fields $B_(mu nu) (X) = phi(X) = 0$ to obtain this result). Continuing the expansion systematically yields stringy higher-curvature corrections to $R_(mu nu) = 0$.

= Superstring theory

- Bosonic string theory is only a toy model due to its lack of fermionic excitations and unstable vacuum (signalled by the tachyonic ground state), both of which are in conflict with observations.

== Classical RNS action

- To overcome these problems, superstring theory adds a fermionic part to the Polyakov action $SP$:
  $ S_"F" [psi] = -i/(4 pi) integral_Sigma dd(2, xi) macron(psi)_A^mu gamma_(A B)^alpha partial_alpha psi_(B, mu) limits(=)^"lcg" i/(2 pi) integral_Sigma dd(2, xi) (vb(psi)_+ dot partial_- vb(psi)_+ + vb(psi)_- dot partial_+ vb(psi)_-). $ <eq:rns>
  $psi_plus.minus$ are Grassmann-valued *Majorana-Weyl*, i.e. real and chiral spinors, governed by the *Dirac eq.* $vb(gamma)^alpha partial_alpha vb(psi) = 0 = partial_minus.plus psi_plus.minus$. By definition, spinors furnish a representation of the Clifford algebra
  $ {vb(gamma)^alpha, vb(gamma)^beta}_(A B) = 2 eta^(alpha beta) bb(1)_(A B) wide (A, B "spinor indices", alpha, beta in {0, 1} hat(=) {tau, sigma} "WS vector indices.") $
  The $vb(psi)$ are chiral both in the sense that $vb(psi)_plus.minus = vb(psi)_plus.minus (xi^plus.minus)$ and that $vb(gamma) vb(psi)_plus.minus = plus.minus vb(psi)_plus.minus$, where $vb(gamma) = vb(gamma)^0 vb(gamma)^1$. They have mass dimension $[psi] = 1/2$ as opposed to bosons with $[X] = -1$.
- The full superstring action $S_"RNS" = SP + S_"F"$ features *supersymmetry* which relates $vb(X)$ and $vb(psi)$ via
  $ delta X^mu = i sqrt(alpha'/2) macron(eps)_A psi_A^mu = i sqrt(alpha'/2) (eps_+ psi_-^mu - eps_- psi_+^mu), wide delta psi_A^mu = eps_B/sqrt(2 alpha') gamma_(A B)^alpha partial_alpha X^mu = plus.minus sqrt(2/alpha') eps_minus.plus partial_plus.minus X^mu, $
  with $vb(eps)(bxi) = (eps_+, eps_-)$ an infinitesimal Grassmann-valued Majorana spinor subject to the chirality condition $vb(gamma)^beta vb(gamma)^alpha partial_beta vb(eps)(bxi) = 0 = partial_minus.plus eps_plus.minus$. Outside superspace, i.e. for gauge-fixed action as in @eq:rns, supersymmetry holds only on-shell. The associated conserved Noether charges $Q_A$ are spinorial and act as generators ${Q_A, macron(Q)_B} = 2 gamma_(A B)^a P_a$ with the momentum operator $P_a$ generating translations.

== Super-conformal invariance

- Local diffeomorphism invariance combined with supersymmetry implies local supersymmetry. It gives rise to *supergravity* in which also the metric $h_(alpha beta)$ has a superpartner, the *gravitino*. The full action $S_"RNS"$ then enjoys *local super-Weyl* and *diffeomorphism invariance*. Moving to flat gauge, only a *residual super-conformal symmetry* generated by the energy-momentum tensor $T_(plus.minus plus.minus) = -1/alpha' partial_plus.minus vb(X) dot partial_plus.minus vb(X) - i/2 vb(psi)_plus.minus dot partial_plus.minus vb(psi)_plus.minus$ and the *supercurrent* $J_plus.minus = (-1)/(2 alpha') vb(psi)_plus.minus dot partial_plus.minus vb(X)$ remains in which supersymmetry is only chiral $eps_plus.minus = eps_plus.minus (xi^plus.minus)$. $T_(plus.minus plus.minus)$ and $J_plus.minus$ obey the *super-Virasoro constraints* $T_(plus.minus plus.minus) limits(=)^! 0$, $J_plus.minus limits(=)^! 0$. These must be imposed on solutions of the e.o.m.s even in flat gauge.

== Ramond and Neveu-Schwarz sectors

- All results derived for the bosonic string in @sec:bosonic remain valid. The fermionic equation of motion follows from variation of $S_"F"$ which, after partial integration, yields
  $ delta S_"F" = -i/(2 pi) integral_(tau_i)^(tau_f) dif tau [vb(psi)_+ delta vb(psi)_+ - vb(psi)_- dot delta vb(psi)_-]|_0^(sigma = l) + i/pi integral_Sigma dd(2, xi) [partial_- vb(psi)_+ dot delta vb(psi)_+ - partial_+ vb(psi)_- dot delta vb(psi)_-]. $ <eq:fermion-variation>
  To avoid nonlocal physics, the boundary term has to vanish, i.e. $vb(psi)_+ delta vb(psi)_+ - vb(psi)_- dot delta vb(psi)_-|_0 limits(=)^! vb(psi)_+ delta vb(psi)_+ - vb(psi)_- dot delta vb(psi)_-|_l$. For the closed sector, periodic boundaries $vb(psi)_plus.minus^mu (sigma) = plus.minus vb(psi)_plus.minus^mu (sigma + l)$ take care of this. Since $vb(psi)_plus.minus^mu$ are spinors on the worldsheet, there is a possibility of picking up a sign by walking around the string, corresponding to antiperiodic boundaries. Parametrizing $psi_plus.minus (sigma + l) = e^(2 pi i phi_plus.minus) psi_plus.minus (sigma)$, we call
  - $phi_plus.minus = 0$ the periodic *Ramond sector*. It has an integer mode expansion (like bosonic strings) of the form $vb(psi)_plus.minus (xi^plus.minus) = sqrt((2 pi)/l) sum_(n in ZZ) vb(b)_n^plus.minus e^(-i (2 pi)/l n xi^plus.minus)$. Its degenerate vacuum $ket(0)_"R"$ is a Majorana spinor with $2^(d\/2)$ real components, furnishing a representation of the $d$-dimensional Clifford algebra.
  - $phi_plus.minus = 1/2$ the antiperiodic *Neveu-Schwarz sector*. It features a half-integer mode expansion $vb(psi)_plus.minus (xi^plus.minus) = sqrt((2 pi)/l) sum_(n in ZZ + 1/2) vb(b)_n^plus.minus e^(-i (2 pi)/l n xi^plus.minus)$. The vacuum $ket(0)_"NS"$ is unique and a spacetime scalar.
  - We can independently choose either boundary type for each of the two spinor components $vb(psi)_+$ and $vb(psi)_-$ of $psi_A^mu$, yielding four sectors total: the pure R-R and NS-NS sectors describe bosonic excitations, whereas mixed boundaries of the type R-NS and NS-R contain fermionic excitations.

  For the open string, the boundary terms in @eq:fermion-variation have to vanish separately. Derivation of the mode expansions yields identical results up to a change of period from $e^(-i (2 pi)/l n xi^plus.minus) -> e^(-i pi/l n xi^plus.minus)$.
- Contributions (per dimension) to the normal ordering constant $a$ for different strings are as follows
  #align(center, booktable(
    3,
    ([statistics], [bosonic], [fermionic]),
    [periodic], [$+1/24$], [$-1/24$],
    [antiperiodic], [$-1/48$], [$+1/48$],
  ))

== GSO projection

- The *GSO projection* is a method to construct a consistent superstring theory by projecting out all but a subset of possible vertex operators in the worldsheet CFT. For consistency of the CFT on the worldsheet, the set $bb(A)$ of operators retained must satisfy
  - *Closure*: The OPE of any two operators $phi_i$, $phi_j$ in $bb(A)$ may contain only operators $phi_k in bb(A)$.
  - *Locality*: No OPE of any two operators in $bb(A)$ may suffer from branch cuts (absence of monodromies). This is necessary to ensure all OPEs are well-defined, i.e. single-valued everywhere.
  - *Modular invariance*: The partition function on the two-torus of the theory containing only the operators in $bb(A)$ must be invariant under the action of the modular group $P S L(2, ZZ)$.

  Starting from the same worldsheet CFT, different GSO projections will lead to string theories with different physical particles. To build models of realistic string vacua, a GSO projection should eliminate the tachyonic ground state of the string and preserve spacetime supersymmetry.
- For the closed oriented superstring, GSO projection results in *Type II A/B theory*. They feature equal numbers of bosons and fermions (128 each at the massless level) as required for supersymmetry, as well as two spin 3/2 fields, the *gravitinos* which imply _local_ supersymmetry. Thus, the low-energy limit of Type II is a supergravity. Worldsheet consistency and vacuum stability imply $d = 10$.
- There is one crucial difference between the Type II and the Type 0 theories. In Type II, the $("NS"_-, "NS"_-)$ sector which contains the tachyonic ground state is projected out. Type II is hence tachyon-free. Type 0 theories still contain the $("NS"_-, "NS"_-)$ sector and its tachyon. This does not render them inconsistent, but dynamically unstable; a universe described by Type 0 rapidly decays at the beginning of the universe and plays no role in the sequel. Type 0 can therefore be discarded.
- In total, there are only five consistent superstring theories known in $d = 10$. They are listed in the following table along with some of their properties.

  The superstring was troubled by the existence of five separate theories until in 1995, it was discovered at the beginning of the second superstring revolution that the theories are related by dualities and might be different limits of a single underlying so-called *M-theory*. This remains a conjecture.

  #align(center, booktable(
    7,
    ([string theory], [$d$], [SUSY generators], [chiral], [open strings], [gauge group], [tachyon]),
    [closed bosonic], [26], [$N = 0$], [no], [no], [none], [yes],
    [open bosonic], [26], [$N = 0$], [no], [yes], [$U(1)$], [yes],
    [type I], [10], [$N = (1, 0)$], [yes], [yes], [$S O(32)$], [no],
    [type IIA], [10], [$N = (1, 1)$], [no], [no], [$U(1)$], [no],
    [type IIB], [10], [$N = (2, 0)$], [yes], [no], [none], [no],
    [heterotic HO], [10], [$N = (1, 0)$], [yes], [no], [$S O(32)$], [no],
    [heterotic HE], [10], [$N = (1, 0)$], [yes], [no], [$E 8 times E 8$], [no],
    [M-theory], [11], [$N = 1$], [no], [no], [none], [no],
  ))

= Compactification, T-duality, D-branes

- The superstring in $d = 10$ gives rise to a fully consistent theory of quantum gravity and Yang-Mills theory, unique up to dualities. It fulfills all prerequisites we pose on a unified theory of all four forces. The only problem is that spacetime does not exhibit 10 large dimensions. To connect the superstring to observations thus requires investigating how the extra 6 spatial dimensions might be compactified, i.e. wound up so tightly as to escape experiment.

== Kaluza-Klein compactification

- Compactification in superstring theory is the operation $RR^(1,9) -> RR^(1,3) times cal(M)^6$. The compactified manifold $cal(M)^6$ is called *internal space*. Its structure determines the value of the dilaton $phi$.
- To see this, consider a massless scalar field theory $partial_mu partial^mu phi(x^mu) = 0$ in $RR^(1,d)$ with dimension $d$ rolled up in a circle of radius $R$, i.e. $x^d = x^d + 2 pi R$. The corresponding compactification is $RR^(1,d) -> RR^(1,d-1) times bb(S)^1$ with internal space $bb(S)^1$. For a diffeomorphism invariant theory, this has three consequences:
  + The most general ansatz for $phi(x^mu)$ that respects the spacetime periodicity is
    $ phi(x^mu) = sum_(n in ZZ) phi_n (x^j) e^(i n/R x^d), $
    with $mu in {0, 1, ..., d}$, $j in {0, 1, ..., d - 1}$. Insertion into the e.o.m. $partial_mu partial^mu phi(x^mu) = 0$ yields
    $ partial_j partial^j phi_n (x^j) = n^2/R^2 phi_n (x^j) #h(3em) forall n. $
    Thus, we get an infinite collection of massive scalars $phi_n (x^j) thick forall n in ZZ$ with $m^2 = n^2/R^2$ from the perspective of the $d$-dimensional theory. These constitute the *Kaluza-Klein tower* of states. Only the zeroth Fourier-mode $phi_0 (x^j)$ is massless and independent of $x^d$.

    As $R -> 0$, the mass of even the lowest state diverges, $m_1^2 -> infinity$, meaning the entire tower disappears from the low-energy spectrum. At energies $E << 1/R$ the theory looks just $d$-dimensional. This is the realm of the *low-energy effective field theory*.
  + There appears an *extra $U(1)$ symmetry* in the $d$ dimensional theory.
  + From the $d$-dimensional perspective, the $g_(d d)$-component of the full metric tensor behaves like a massless scalar field that determines the volume of $bb(S)^1$. Such flat scalar fields whose vacuum expectation values determine geometric properties of the internal space are called *moduli fields*.
- In the presence of compactified dimensions, there exist truly stringy *winding states* stretching around the compact dimension. This is a specialty of string theory and not possible with point-particles. Such states are necessarily closed with independent left-/right-moving modes $ba_n^plus.minus$ and mass $M^2 = (omega^2 R^2)/alpha'^2$, where $omega$ is the winding number. Winding costs energy due to the string tension.
  - These winding states exhibit very special behavior in the limit $R -> 0$. While the Kaluza-Klein tower (a purely field theoretic effect) disappears from the low-energy spectrum, which would make an originally $d + 1$-dimensional field theory effectively $d$-dimensional upon compactification, the winding states become light and excitable due to $M^2 prop R^2$. Thus a string theory remains $d + 1$-dimensional even after compactification to an internal space with $R -> 0$.
- One-dimensional compactification onto $bb(S)^1$ can be generalised to multi-dimensional compactification, e.g. onto a torus $bb(T)^d = bb(S)^1 ... times bb(S)^1$. Of course, toroidal compactification is yet another special case. The larger $d$, the more possibilities for general internal spaces $cal(M)$ exist. Of special interest to the superstring are six-dimensional *Calabi-Yau manifolds*, on which string propagation is successfully described by special internal CFTs, so called *Gepner models*.

== T-duality

- *T-duality* is the operation $n <-> omega$ and $R <-> R' = alpha'/R$, which exchanges the momenta of the Kaluza-Klein tower and the winding states. It is an exact symmetry that (for the closed bosonic string) acts as parity on right-moving modes of the compactified dimension $x^d$, i.e. $p_L^d -> p_L^d$, $p_R^d -> -p_R^d$ which extends to $X_L^d -> X_L^d$, $X_R^d -> -X_R^d$.
- Physically, since the spectrum and all interactions are left invariant, T-duality relates processes at $R < sqrt(alpha')$ to those occurring at $R > sqrt(alpha')$. This establishes a minimal distance $R = sqrt(alpha')$, the *self-dual radius*. There is no point to distances smaller than $sqrt(alpha')$ in string theory because we can always map all processes at smaller scales back to bigger distances.
- For Type IIA/B superstrings, T-duality similarly dons a sign to right-movers, $X_R^9 -> -X_R^9$, $psi_R^9 -> -psi_R^9$. It also flips their chirality and therefore transforms the various superstring sectors as
  $ ("R"^+, "R"^plus.minus) -> ("R"^+, "R"^minus.plus), #h(6em) ("NS"^+, "R"^plus.minus) -> ("NS"^+, "R"^minus.plus). $
  This exchanges Type IIA and Type IIB theory! More precisely, Type IIB on $bb(S)^1$ with radius $R$ under T-duality corresponds to Type IIA on $tilde(bb(S))^1$ with radius $alpha'/R$.

== D-branes as dynamical objects

- *D-branes* are dynamical objects that *gravitate* by coupling to closed strings in the NS-NS sector, i.e. they have mass. Moreover, they are *charged* under R-R (i.e. periodic string) $p$-form potentials.
- That D-branes must be dynamical is clear already from their momentum exchange with the open strings ending on them (momentum flows off the string ends in DD directions). However, the linkage goes deeper. The worldvolume of a D-brane undergoes fluctuations. These are generated by the quantum fluctuations of open string excitations normal to the brane, which describe massless scalar fields propagating along the brane. These are the above-mentioned modulus fields whose vacuum expectation values determine the position of branes.
- Describing D-branes via an open + closed string CFT is adequate for small string coupling $g_s$ that allows for a perturbative expansion. For large $g_s$, branes attain large masses and start backreacting substantially on the geometry of ambient spacetime, thus forming so-called *black brane solutions* in supergravity (higher-dimensional generalizations of $d = 4$ black hole solutions in Einstein gravity).
- *Intersecting brane worlds* are an important tool in string phenomenology to make contact between $RR^(1,9)$ and $RR^(1,3)$. The key idea behind them is that various D-branes can intersect along some subspace that contains $RR^(1,3)$, endowing this space with interesting gauge theories and matter content. In fact, the structure turns out to be naturally that of the standard model! Two stacks of $N_A$ and $N_B$ coincident branes intersecting along $RR^(1,3)$ give rise to a $U(N_A) times U(N_B)$ Yang-Mills theory plus one chiral fermion transforming in the bifundamental representation $(macron(N)_A, N_B)$. With three stacks $D_A$, $D_B$, $D_C$ and $N_A = 3$, $N_B = 2$, $N_C = 1$, this reproduces the gauge group $S U(3) times S U(2) times U(1)_Y$ of the standard model (up to additional $U(1)$ factors).
- While the string consistency conditions single out a unique theory (up to dualities) in 10 dimensions, every 4-dimensional effective theory obtained from this by compactification corresponds to a choice of vacuum, i.e. to a dynamical solution of the 10-dimensional theory. The set of all $d = 4$-solutions is called the *landscape of string vacua*.
