#import "/notes.typ": notes, ev, bra, ket

#show: notes.with(
  title: [Summary of Advanced Quantum Field Theory],
  date: [Janosh Riebesell, April 2016],
)
#set heading(numbering: "1.1")
#set math.equation(numbering: "(1)")
#show heading.where(level: 2): set block(above: 1.3em, below: 0.8em)

#let (bpsi, bpsib, bgamma, bfeta, bfetab) = (
  $bold(psi)$,
  $macron(bold(psi))$,
  $bold(gamma)$,
  $bold(eta)$,
  $macron(bold(eta))$,
)
#let lie = $frak(h)$

#outline(depth: 2)

= Path integral quantization

== Transition amplitudes and correlation functions

- The path integral provides a formulation of quantum theory equivalent to canonical quantization.
- A quantum mechanical transition amplitude $chevron.l q_f, t_f|q_i, t_i chevron.r = bra(q_f) e^(-i hat(H) (t_f - t_i)) ket(q_i)$ can, by partitioning of the transition time $delta t = (t_f - t_i)/N$ and insertion of complete sets of states $bb(1) = integral_RR dif q_k ket(q_k) bra(q_k)$ between each partition, be expressed as
  $ chevron.l q_f, t_f|q_i, t_i chevron.r = integral_(q(t_i) = q_i)^(q(t_f) = q_f) cal(D) q(t) cal(D) p(t) e^(i integral_(t_i)^(t_f) dif t L(p, q)), $ <eq:pi>
  with $integral_(t_i)^(t_f) dif t L(p, q) equiv S[p, q]$ and $L(p, q) = p dot(q) - H(p, q)$.
- Analytic continuation by rotating $t$ onto the lower half-plane via $t -> t(1 - i epsilon.alt)$ followed by performing the momentum path integral as a Gaussian yields the *Feynman-Kac formula*
  $ chevron.l q_f, t_f|q_i, t_i chevron.r = integral_(q(t_i) = q_i)^(q(t_f) = q_f) cal(D) q(t) e^(i integral_(t_i)^(t_f) dif t L(q, dot(q))), $ <eq:feynman-kac>
  where the factor $C^N = ((-i m)/(2 pi delta t))^(N\/2)$ from completion of the square is absorbed into $D q(t)$.
- The path integral for scalar _fields_ $phi(x)$ (as opposed to particles) is very similar to @eq:feynman-kac,
  $ chevron.l phi_f (x), t_f|phi_i (x), t_i chevron.r = integral_(phi(bold(x), t_i) = phi_i (bold(x)))^(phi(bold(x), t_f) = phi_f (bold(x))) cal(D) phi e^(i integral_(t_i)^(t_f) dif^4 x cal(L)(phi)). $
  The *master formula* for an $n$-point quantum correlation function reads
  $ G(x_1, ..., x_n) equiv bra(Omega) upright(T) product_(j=1)^n hat(phi)(x_j) ket(Omega) = lim_(t -> infinity dot (1 - i epsilon.alt)) (integral cal(D) phi product_(j=1)^n phi(x_j) e^(i integral_(-t)^t dif^4 x cal(L)(phi)))/(integral cal(D) phi e^(i integral_(-t)^t dif^4 x cal(L)(phi))) $ <eq:master>
  - Time ordering $upright(T)$ inside the path integral is taken care of automatically.

== Generating functionals for correlation functions

- The *generating functional* $Z[J]$ of Green's functions $G(x_1, ..., x_n)$ for some source $J(x)$ reads
  $ Z[J] = integral cal(D) phi e^(i S[phi] + i J dot phi), $
  where the functional inner product is defined as $J dot phi = integral_(RR^(1,3)) dif^4 x J(x) phi(x)$. $Z[J]$ maps the function $phi(x)$ to a number in $CC$. It is called _generating_ functional because
  $ Z[J]/Z[0] = sum_(n=0)^infinity i^n/n! (product_(j=1)^n integral_(RR^(1,3)) dif^4 x_j J(x_j)) G(x_1, ..., x_n). $
- This can be solved for $G(x_1, ..., x_n)$ using the tools of functional calculus:
  $ G(x_1, ..., x_n) = lr(1/Z[0] product_(j=1)^n delta/(i delta J(x_j)) Z[J] |)_(J=0). $
- $Z[0]$ contains no external points and represents the *partition function* $Z[0] = e^(sum_i V_i)$, where the sum runs over all vacuum bubbles $V_i$ of the theory. Consequently, $Z[J]/Z[0]$ contains no vacuum bubbles.
- Counting of loops: A fully connected Feynman diagram with $E$ external and $I$ internal lines, $V$ vertices, and $L$ loops (number of unfixed momentum integrals) satisfies *Euler's formula*
  $ L = I - V + 1. $ <eq:euler>
  For $cal(L)_"int" (phi) = lambda/n! phi^n (x)$ we have $E + 2 I = n V$.#footnote[Every vertex connects to $n$ lines, while every external line connects to one and every internal line to two vertices.] Inserting eq. @eq:euler yields
  $ (n - 2) V = 2 L + (E - 2). $
  Hence for fixed $E$, an expansion in $L$ corresponds to an expansion in $V$.

== Schwinger-Dyson equation

- An advantage of the path-integral method is that symmetries are more transparent. It becomes clear that classical symmetries carry over to the quantum theory -- but only provided the path integral measure $cal(D) phi = cal(D) phi'$ is invariant. In that case, the *Schwinger-Dyson equation*
  $ integral cal(D) phi ((delta S[phi])/(delta phi(x)) + J(x)) e^(i S[phi] + i J dot phi) = 0 $ <eq:schwinger-dyson>
  states the classical equation of motion $(delta S)/(delta phi) + J = 0$ (in presence of a source $J$), holds as an operator equation in the quantum theory, i.e. inside the path integral (provided $exists.not$ contact terms $prop delta(x - x_j)$).
- For a continuous global classical symmetry $phi -> phi' = phi + delta phi$ with conserved Noether current $j^mu (x)$ given by $(delta S)/(delta phi(x)) delta phi(x) = -partial_mu j^mu (x) = 0$, acting on eq. @eq:schwinger-dyson with $product_(j=1)^n delta/(i delta J(x_j))$ and taking $J = 0$ afterwards gives the *Ward-Takahashi identity*, i.e. the statement of current conservation up to contact terms inside correlation functions,
  $ partial_mu lr(chevron.l Omega mid(|) upright(T) j^mu product_(j=1)^n phi(x_j) mid(|) Omega chevron.r) = -i sum_(j=1)^n bra(Omega) upright(T) phi(x_1) ... phi(x_(j-1)) [delta phi(x) delta(x - x_j)] phi(x_(j+1)) ... phi(x_n) ket(Omega). $
  Like eq. @eq:schwinger-dyson, the Ward-Takahashi identity only holds for classical symmetries of $S[phi]$ that leave the measure invariant. If $D phi$ is affected, the symmetry is anomalous and current conservation (up to contact terms) does not hold at the quantum level.

== 1PI effective action

- $G(x_1, ..., x_n)$ receives contributions from partially connected Feynman diagrams. As established by the LSZ formalism, only fully connected Greens functions $G^c (x_1, ..., x_n)$ containing Feynman diagrams which do not factor into subdiagrams, enter the computation of scattering amplitudes.
- The generating functional of $G^c (x_1, ..., x_n)$ is denoted $i W[J]$ (not to be confused with the effective action $Gamma$ below). It is closely related to $Z[J]$ via $Z[J]/Z[0] = e^(i W[J])$.
- An important subclass of fully connected Feynman diagrams are the 1-particle-irreducible (1PI) diagrams, which cannot be cut into two non-trivial diagrams by cutting a single (internal) line. These are generated by the *1PI effective action* $Gamma[phi.alt]$ defined as the Legendre transform of $W[J]$,
  $ Gamma[phi.alt] = W[J] - phi.alt dot J, $
  where $phi.alt(x) equiv (delta W[J])/(delta J(x)) = bra(Omega) hat(phi)(x) ket(Omega)_J$, and we assumed there to be a bijection between $J$ and $phi.alt$.#footnote[In the Euclidean theory $W_E [J]$ is convex and such a one-to-one correspondence between sources and $phi$-v.e.v.s exists.]
- $Gamma[phi.alt]$ and $S[phi.alt]$ are the same functionals at tree-level, i.e. $Gamma[phi.alt] = S[phi.alt] + K[phi.alt]$ for some $K[phi.alt]$ starting at one-loop. $(delta Gamma[phi.alt])/(delta phi.alt(x)) = -J(x)$ for $J(x) = 0$ yields the *quantum effective equation of motion*.

== Fermionic path integral

- Fermionic _anti_\commutation relations ${hat(bpsi), hat(bpsi)^dagger} = 1$, ${hat(bpsi), hat(bpsi)} = {hat(bpsi)^dagger, hat(bpsi)^dagger} = 0$ can be implemented using anticommuting (nilpotent) Grassmann-valued fields $bpsi(x)$ out of a *Grassmann algebra* $bb(A)$.
- The *path integral for fermionic fields* $bpsi(x)$, $bpsib(x) = bpsi^dagger (x) bgamma^0$ takes the form
  $ chevron.l bpsi_f (bold(x)), t_f|bpsi_i (bold(x)), t_i chevron.r = integral_(bpsi(bold(x), t_i) = bpsi_i (bold(x)))^(bpsi(bold(x), t_f) = bpsi_f (bold(x))) cal(D) bpsib cal(D) bpsi e^(i integral_(t_i)^(t_f) dif^4 x cal(L)(bpsi, bpsib)), $
  where $cal(L)(bpsi, bpsib) = bpsib(x) [i bgamma^mu partial_mu - m_0] bpsi(x) + cal(L)_"int"$. The four $n times n$-gamma-matrices (one for every spacetime dimension) span the Clifford algebra $C ell^n (CC)$ defined by the anticommutator ${bgamma^mu, bgamma^nu} = 2 eta^(mu nu) bb(1)_n$ with $n = 2^(d\/2) = 4$. To project initial and final states to the vacuum $ket(Omega)$, the trick $m_0 -> m_0 - i epsilon.alt$ can be used (just like in the bosonic case).
- The *generating functional for fermionic correlators* is defined as
  $ Z[bfeta, bfetab] = bra(Omega) upright(T) e^(i integral_(RR^(1,3)) dif^4 x [cal(L)(bpsi, bpsib) + bpsib(x) bfeta(x) + bfetab(x) bpsi(x)]) ket(Omega) = integral cal(D) bpsib cal(D) bpsi e^(i S[bpsi, bpsib] + i bpsib dot bfeta + i bfetab dot bpsi), $
  with the external sources $bfetab(x)$, $bfeta(x)$ as Grassmann-valued classical fields.

== Executive summary of QFT

- Start with a classical action $S[phi]$ in which the field $phi(x)$ arises as the continuum limit $N -> infinity$ of a system of $N$ harmonic oscillators.
- In the classical limit $planck -> 0$, $phi(x)$ is a definite function given by the classical equation of motion $delta S[phi] \/ delta phi(x) = 0$. For $planck$ finite, quantum fluctuations arise. These are encoded in $Z[J]$, where the path integral takes into account all possible functions $phi(x)$ could assume.
- What we can compute in the quantum theory are correlation functions. In particular the quantum expectation value of the field $phi(x)$ in the presence of a source $J$ is
  $ phi.alt_J (x) equiv ev(phi(x))_J equiv bra(Omega) hat(phi)(x) ket(Omega)_J = 1/Z[J] integral cal(D) phi phi(x) e^(-S[phi] + phi dot J). $
- With $Z[J] = e^(-W[J])$ (in Euclidean signature), we can compute this as
  $ phi.alt_J (x) = -(delta W[J])/(delta J(x)). $
- In terms of the Legendre transform $Gamma[phi.alt]$ of $W[J]$, we have
  $ (delta Gamma[phi.alt])/(delta phi.alt(x)) = J(x). $
  By integrating out quantum fluctuations $f(x) = phi(x) - phi.alt(x)$, $Gamma[phi.alt]$ gives a quantum effective action
  $ e^(-Gamma[phi.alt]) = 1/Z[0] integral cal(D) f e^(-S[phi.alt + f] + (delta Gamma)/(delta phi.alt) dot f). $
  Replacing $S[phi]$ by $Gamma[phi.alt]$ introduces 1PI amputated vertices and fully resummed propagators. Thus, computing at tree-level with $Gamma[phi.alt]$ already gives the full quantum theory!

= Renormalization

== Superficial divergence

- For a scalar theory in $d$ dimensions with (bare) Lagrangian $cal(L)_0 = 1/2 (partial phi)^2 - m_0^2/2 phi^2 - lambda_0/n! phi^n$, the naive UV structure of a diagram $cal(D)$ with $L$ loops $prop integral_(RR^d) dif^d k$ and $I$ propagators $prop (k^2 - m^2)^(-1)$ is
  $ cal(D) limits(-->)^(k -> infinity) (integral_(RR^d) dif^d k_1 ... integral_(RR^d) dif^d k_L)/(k_1^2 ... k_I^2). $
  The *superficial degree of divergence* $D$ of $cal(D)$ is defined as the difference in powers of momentum between numerator and denominator, i.e. $D = d L - 2 I$.
  - Regularizing the divergence with a momentum cutoff $Lambda$, i.e. $integral_(-infinity)^infinity dif k -> lim_(Lambda -> infinity) integral_(-Lambda)^Lambda dif k$, diagrams fall into three categories of UV behavior: 1. $D > 0 => cal(D) prop Lambda^D$ (superficially divergent). 2. $D < 0 => cal(D) prop Lambda^(-|D|)$ (superf. finite). 3. $D = 0 => cal(D) prop ln(Lambda)$ (superf. log-divergent).
  - The actual UV behavior may differ from the superficial one for three reasons: 1. For $D >= 0$, a diagram may still be finite if symmetry constrains the amplitude or leads to cancellations among infinite terms. 2. For $D < 0$, a diagram may still be divergent if it contains a divergent subdiagram. 3. Tree-level diagrams have $D = 0$, but are finite.
- For $cal(L)_0$ as above, $D$ depends on the mass dimension of the coupling $[lambda_0] = d - (d - 2)/2 n$ as
  $ D = d - [lambda_0] V - (d - 2)/2 E. $
  The UV properties of a theory are decisively determined by (the sign of) the prefactor of $V$.
  + If $D prop +V$, there exists an infinite number of superficially divergent amplitudes since for every $E$, diagrams with high enough $V$ diverge. The theory is thus *non-renormalizable* $<=> [lambda_0] < 0$.
  + If $D cancel(prop) V$ (and $d >= 2$), only a finite number of diagrams is divergent but divergences appear _at every loop-order_. Such theories are called *renormalizable* and arise for $[lambda_0] = 0$.
  + If $D prop -V$, for high-enough loop order, all diagrams become superf. finite, making the theory *super-renormalizable* $<=> [lambda_0] > 0$.
  - E.g. for $n = d = 4$, we have $[lambda_0] = 0$ and $D = 4 - E$ independent of $L$ or $V$. Hence, $phi^4$-theory in $d = 4$ is renormalizable with only three superficially divergent amplitudes, $E = 0, 2, 4$ (at every loop-order).
- By the *BPHZ theorem*, (power counting) renormalizability is sufficient for a theory to maintain predictivity. (The non-trivial aspect of this theorem concerns the complete cancellation of divergent subdiagrams by counterterms of the previous loop-order.)

== Renormalization of QED

- *Regularization* is the practice of isolating divergences. The three common methods in QFT are
  + *Cutoff reg.* regularizes divergent momentum integrals via $integral_(-infinity)^infinity dif k -> lim_(Lambda -> infinity) integral_(-Lambda)^Lambda dif k$. However, this is inconsistent with the Ward identities and gauge invariance because transformations of the sort $A^mu -> A^mu + partial^mu alpha(x)$ cannot be carried out at the cutoff, making it a useless method in QED.
  + *Dimensional reg.* (used most often) evaluates divergent integrals in $d = 4 - epsilon.alt$ dimensions. The result is expanded in powers of $epsilon.alt$ which isolates the divergence as a pole as $epsilon.alt -> 0$.
  + *Pauli-Villars reg.* takes a divergent diagram and subtracts from it the same diagram but with a fictitious massive particle in the loop, e.g. a photon of mass $Lambda$. This removes the divergence because for $k -> infinity$, the mass in the loop becomes irrelevant and both diagrams asymptote to the same value. But for $Lambda -> infinity$, the auxiliary diagram vanishes and we recover the actual process.
- The QED Lagrangian with symmetry group $U(1)$ describes the coupling of spin-1/2 bispinor fields $bpsi(x)$ (electron, positron) to a covariant spin-1 gauge field $A_mu (x)$ (photon) generated by the transformation behavior of the spinors themselves. $cal(L)_"QED"$ can be expressed i.t.o. the field strength tensor $F_(mu nu) = partial_mu A_nu - partial_nu A_mu$, and the covariant derivative $D_mu = partial_mu + i e A_mu$ as
  $ cal(L)_"QED" = -1/4 F_(mu nu) F^(mu nu) + bpsib (i bgamma^mu D_mu - m) bpsi = -1/4 F^2 + bpsib (i bgamma^mu partial_mu - m) bpsi - A_mu j^mu, $
  where $m$ is the fermion mass, $e$ is the coupling constant equal to the (electric) charge of the bispinor field and $j^mu = e bpsib bgamma^mu bpsi$ is the conserved fermion current associated with the $U(1)$ symmetry.
- A QED diagram with $E_e$ ($E_gamma$) external fermions (photons) has superficial degree of divergence
  $ D = 4 - 3/2 E_e - E_gamma. $
  Since $[e] = 0$, QED is renormalizable with seven superficially (four actually#footnote[The symmetries at work preventing some of QED's superficial divergences are discrete charge conjugation $j^mu -> -j^mu$, $A^mu -> -A^mu$, chiral symmetry (arises for $m = 0$), and the Ward identity $k^mu cal(D)_mu = 0$ for a diagram $cal(D) = xi^mu cal(D)_mu$ involving an external photon of momentum $k^mu$ ($k^2 = 0$) and polarization $xi^mu$.]) divergent diagrams.

== Callan-Symanzik equation

- Renormalization automatically introduces a mass scale $mu$ -- the *renormalization scale* -- into the quantum theory via the renormalization conditions (even when the classical theory was scale-free).
- To quantify the dependence of coupling constants on the renormalization scale $mu$, we can study the *Callan-Symanzik* (or *renormalization group*) equation (here for massive $phi^4$-theory)
  $ (mu partial_mu + beta_lambda partial_lambda + beta_(m^2) partial_(m^2) + n dot gamma_phi) G_n (x_1, ..., x_n) = 0, $ <eq:callan-symanzik>
  where $beta_lambda = lr(mu (dif lambda)/(dif mu) |)_(lambda_0, m_0)$, $beta_(m^2) = lr(mu (dif m^2)/(dif mu) |)_(lambda_0, m_0)$, and $gamma_phi = lr(mu/2 (dif ln(Z))/(dif mu) |)_(lambda_0, m_0)$. $beta_lambda$ for example describes how the physical coupling $lambda$ changes as we change the energy scale $mu$ at which we perform an experiment.
  - The CS equation allows us to (perturbatively) compute $beta_lambda$, $beta_(m^2)$, $gamma_phi$ explicitly by first computing $G_n (x_1, ..., x_n)$ and then plugging it into @eq:callan-symanzik. E.g. $beta_lambda = (3 lambda^2)/(16 pi^2) + cal(O)(lambda^3)$ for massless $phi^4$-theory.
  - The change in $lambda(mu)$ as we change $mu$ is called *renormalisation group flow* or *running coupling*. $lambda(mu)$ gives the strength of the interaction at energy scale $mu$.
- Depending on the sign of $beta$ there are three qualitatively different *RG behaviors*.
  + If $beta(lambda) > 0$, $lambda(mu)$ increases as $mu$ increases. If we start with a perturbative value $lambda_0$ at $mu_0$ and follow the RG flow for increasing $mu$, then at some scale, $lambda(mu)$ may cease to be perturbative. If by a non-perturbative analysis beyond that point one finds $beta(lambda) > 0 thick forall lambda$, then $lambda(mu)$ increases indefinitely. This can result in a divergent coupling $lambda -> infinity$, either asymptotically as $mu -> infinity$, or even for finite values of $mu -> mu_"L"$. The latter instance is referred to as a *Landau pole*.
    - One appears e.g. in QED at $mu_"L" = mu_0 exp((3 pi)/(2 alpha_0))$ since
      $ alpha(mu) = alpha_0/(1 - (2 alpha_0)/(3 pi) ln(mu/mu_0)) limits(-->)^(mu -> mu_"L") infinity. $
    On the other hand, $beta(lambda) > 0$ means the theory is perturbatively well-defined in the infrared, where $lambda$ becomes small. If $lambda -> 0$ as $mu -> 0$, the theory even becomes free in the infrared. Such a non-interacting fixed point is called *Gaussian fixed point*.
  + If $beta(lambda) < 0$, $lambda(mu)$ decreases as $mu$ increases. The theory is perturbative in the UV, but may cease to be perturbative in the IR. If $lambda -> 0$ as $mu -> infinity$, the theory becomes free in the UV. This is called *asymptotic freedom*.#footnote[In $d = 4$, the only known example for asymptotic freedom is Yang-Mills theory.]
  + If $beta = 0 thick forall mu$, $lambda$ is independent of $mu$. Such a theory is *conformal*, i.e. scale-independent. Since the counterterms do not induce any scale dependence, there cannot be any UV divergences altogether and the theory is UV finite.

== Wilsonian interpretation

- The original understanding of renormalization was:
  - The cutoff $Lambda$ is merely a way to regulate divergent integrals without physical meaning.
  - Renormalization is a trick to remove the cutoff-dependence in physical amplitudes. This procedure allows us to take $Lambda -> infinity$ without encountering divergences.
  - This comes at the cost of losing predictability for some physical masses and couplings.
  - In a renormalizable theory, only a finite number of such physical couplings must be taken as input parameters from experiment to end up with a well-defined (otherwise predictive) theory.
- The *Wilsonian approach* gives a different interpretation: We should think of QFT as an _effective description_ accurate only for energies below an intrinsic cutoff $Lambda_0$. At energies beyond $Lambda_0$ the field theory picture does not correctly model the microscopic degrees of freedom.#footnote[For example, QFT neglects gravity but all matter gravitates and gravity becomes non-negligible (compared to the other forces) near the Planck scale $M_"pl" approx 1 \/ sqrt(G_"N") approx 10^19 "GeV"$.]
  - The only known theory that is UV finite and asymptotes to a weakly coupled QFT in the infrared is *string theory*, which abandons the concept of pointlike particles, replacing them with excitations of a one-dimensional string of length $ell_s$. The string length is the intrinsic cutoff of the low-energy effective QFT. At distances near $ell_s$, the theory deviates from a regular field theory in that it becomes non-local, thus avoiding UV divergences and arbitrary input parameters.
- Integrating out the degrees of freedom between the regulator $Lambda$ and an even smaller cutoff $Lambda_0 < Lambda$ yields the *Wilsonian effective action* $S_W^"eff"$. When computing correlators at scales below $Lambda_0$ via $S_W^"eff"$, only momenta $|k| <= Lambda_0$ appear in the loops since all effects of the modes with $Lambda_0 < |k| < Lambda$ are already encoded in $S_W^"eff"$. This is not to be confused with the quantum effective action $Gamma[phi.alt]$ which gives the full quantum theory already at tree-level. $S_W^"eff"$ includes only those quantum effects due to the integrated-out modes $k$ between $Lambda_0 < |k| < Lambda$ and loops must still be performed.
  - Successive applications of this integration to a lower cutoff gives rise to the *renormalisation semi-group* (semi because we can only lower the cutoff; there does not exist an inverse operation).
  - The running couplings in the Wilsonian picture are interpreted as the dependency of the couplings in $S_W^"eff"$ on the cutoff. This identifies $Lambda_0$ as the renormalization scale $mu$.

= Quantisation of Yang-Mills theory

== Classical Yang-Mills theory

- The gauge field $A_mu (x)$ of a Yang-Mills theory with *non-Abelian Lie group* $H$#footnote[Generally, any compact, semi-simple Lie group will do, but most forms of Yang-Mills theory are based on $S U(N)$ with associated Lie algebra $frak(s u)(N)$.] (whose elements are the gauge transformations that leave the theory invariant) takes values in the associated *Lie algebra* $lie$. $lie$ is a vector space equipped with a non-associative antisymmetric bilinear map $[dot, dot] : lie times lie -> lie$, the *Lie bracket*.
- Like any element of $lie$, $A_mu (x)$ can be expressed i.t.o. of a basis ${T^a}$, $a in {1, ..., dim(lie)}$ of $lie$ (that forms a complete set of generators of the underlying Lie group $H$):
  $ A^mu (x) = A_a^mu (x) T^a #h(3em) "(summation over" a "implied)" $
- The basis elements satisfy the Lie algebra's defining relation
  $ [T^a, T^b] = i f^(a b) zws_c T^c, $ <eq:lie-algebra>
  i.t.o. the *structure constants* $f^(a b) zws_c$.#footnote[The $f^(a b) zws_c$ restrict the result of taking the Lie bracket of two generators $T^a$, $T^b$ to a linear combination of all generators ${T^c}$, thereby determining the Lie brackets of all elements of $lie$. This almost completely establishes the group structure of $H$, explaining the name structure constants.] Eq. @eq:lie-algebra in turn fulfills the *Jacobi identity*
  $ [[T^a, T^b], T^c] + [[T^b, T^c], T^a] + [[T^c, T^a], T^b] = 0. $
  - As an example, the Lie algebra $s u(2)$ of dimension 3 has as one possible basis $T^i = sigma_i \/ 2$, with the three Pauli matrices $sigma_i$, which generate the corresponding Lie group $S U(2)$. In this basis, the structure constants are given by the components of the Levi-Civita symbol $epsilon.alt^(i j k)$.
- Every Lie algebra also possesses a symmetric bilinear form, the *Killing form*
  $ kappa^(a b) = T^a circle.small T^b, $
  which is invariant under the *adjoint action* of the Lie group $H$,
  $ h T^a h^(-1) circle.small h T^b h^(-1) = T^a circle.small T^b #h(3em) forall h in H. $
  - When working with $H$ in matrix representation, e.g. $H = S U(N)$, the generators $T^a$ are Hermitian traceless $N times N$-matrices and the Killing form $circle.small$ acts simply as the trace on $lie$,
    $ T^a circle.small T^b = "tr"_lie (T^a T^b) = 1/2 delta^(a b). $
    The last equality only holds if $H$ is compact as a manifold, in which case the Killing form is positive definite and can be suitably normalized.
  - The Killing form $kappa^(a b)$ and its inverse#footnote[$c$ is merely a normalization factor determined by the structure of the Lie group $H$ as a manifold.] $c kappa_(a b)$ can be used to raise and lower Lie-algebra indices, e.g.
    $ f^(a b c) = f^(a b) zws_d kappa^(d c). $
    With all indices appearing on the same footing, the structure constants are totally antisymmetric and therefore invariant under cyclic permutations.#footnote[This is not so much naturally the case as up to our choice of basis matrices ${T^a}$. It can be proven that a basis always exists in which the $f^(a b c)$ have these properties.]
- Under a *gauge transformation* $U in H$ parametrized as $U(x) = e^(-i g alpha(x))$ with $g in RR$ and $alpha(x) in lie$ the gauge potential $A^mu (x)$ transforms to linear order as
  $ A^mu (x) -> A^mu (x) + D^mu alpha(x), $
  where the *adjoint covariant derivative* acts on $lie$-valued fields $alpha(x)$,
  $ D^mu alpha(x) equiv partial^mu alpha(x) + i g [A^mu (x), alpha(x)]. $
- The associated *field strength tensor* of $A^mu$ is given by
  $ F_(mu nu) (x) = 1/(i g) [D_mu, D_nu] = partial_mu A_nu (x) - partial_nu A_mu (x) + i g [A_mu (x), A_nu (x)]. $
  - $F_(mu nu)$ transforms under the adjoint action of $H$, $F_(mu nu) -> U F_(mu nu) U^(-1)$, and satisfies the Bianchi identity $D_rho F_(mu nu) + D_mu F_(nu rho) + D_nu F_(rho mu) = 0$.
  - I.t.o. the field strength $F_(mu nu)$, the gauge-invariant *Yang-Mills Lagrangian* can be written as
    $ cal(L)_"YM" (A) = -1/2 "tr"_(lie, RR^(1,3)) (F^2) = -1/4 F_(mu nu)^a F_a^(mu nu). $
    The commutator in $F_(mu nu)$ introduces cubic and quartic gauge field interactions into $cal(L)_"YM"$. The gauge field's equation of motion is
    $ D_mu F^(mu nu) = 0 #h(3em) <=> #h(3em) partial_mu F^(mu nu) = -i g [A_mu (x), F^(mu nu)]. $

== Quantizing Yang-Mills theory

- Gauge invariance as well as the fact that $A_0 (x)$ appears without a time-derivative in $cal(L)_"YM"$, i.e. is a non-dynamical field without conjugate momentum $Pi_0$, complicates the quantization of Yang-Mills theory. Variation of the action $S_"YM" [A]$ w.r.t. to $A_0 (x)$ yields $D_i F^(0 i) = 0$ ($i in {1, 2, 3}$) which is itself a *non-dynamical constraint*, with $A_0 (x)$ merely an unphysical Lagrange multiplier enforcing it.
- Canonical quantization of constrained systems requires special technology (e.g. the Gupta-Bleuler procedure for $U(1)$ gauge theories). Hence, path integral quantization is preferred for Yang-Mills.
- The naive path integral quantization of a gauge field $A^mu$ proceeds by formulating an action $S[A]$, inverting the kinetic term $(K dot A)^mu = -partial^2 A^mu + partial^mu partial_nu A^nu$ to find the propagator $i D_F = K^(-1)$, and then perturbatively tackling the interacting theory. This runs into trouble because $K$ is in fact _not_ invertible due to its non-trivial kernel $ker(K) != {0}$. Rather, $(K dot partial alpha) = 0 thick forall alpha(x) in lie$.#footnote[This problem is entirely due to gauge invariance and has nothing to do with the gauge group being Abelian or not.]
- The cure is to remove the non-invertibility of $K$ by excluding all but one element out of each set of gauge-equivalent field configurations related to first order by $A^mu -> A^mu + partial^mu alpha$. Untruncated, a full gauge transformation is given by
  $ A^mu -> A_h^mu = h A^mu h^(-1) + i/g (partial^mu h) h^(-1), #h(3em) "for any" h in H. $
  $A^mu$ and $A_h^mu$ are physically equivalent and lead the path integral to overcount because if one satisfies the e.o.m. so does the other. Given any $A^mu$, all equivalent field configurations lie in the same *orbit*
  $ O_A = {A_h^mu | h in H}. $
  Hence, let $cal(A)$ denote the space of _all_ field configurations $A^mu (x)$, then the physically inequivalent ones are captured precisely by the quotient space $cal(A) \/ H$ which picks out exactly one field per orbit.
- Some path integral manipulations yield the *Yang-Mills partition function*
  $ Z_"YM" = integral_cal(A) cal(D) A thin delta[F(A)] det(Delta_"FP") e^(i S_"YM" [A]), $ <eq:z-ym>
  where the argument of the functional Dirac delta is the gauge fixing condition $F(A)$ which, given any field configuration $A^mu (x) in cal(A)$ achieves $F(A^h) = 0$ (ideally) for exactly one unique $h in H$#footnote[The ideal case usually doesn't come to pass due to an irritating *residual gauge symmetry* that results in several gauge equivalent field configurations, so-called *Gribov copies*, which all fulfill $F(A) = 0$. Thus even the gauge-fixed path integral would still overcount if we did not restrict it to a fundamental domain where the gauge is unique.], thereby effectively reducing the integration domain from $cal(A)$ to $cal(A) \/ H$. $Delta_"FP" = -(partial F(A))/(partial A^mu) D^mu$ is the *Faddeev-Popov matrix*. Eq. @eq:z-ym can be used to calculate vacuum expectation values of any (gauge-invariant!) operator $cal(O)(A) = cal(O)(A^h)$ by the usual $t -> infinity (1 - i epsilon.alt)$ prescription (see eq. @eq:master).

== Faddeev-Popov ghosts

- Introducing the $lie$-valued *Nakanishi-Lautrup auxiliary field* $B(x)$, we can rewrite $delta[F(A)]$ as
  $ delta[F(A)] = integral cal(D) B e^(i integral_(RR^(1,3)) dif^4 x B_a (x) F^a (x)). $ <eq:nakanishi-lautrup>
  With the Grassmann-$lie$-valued *Faddeev-Popov ghost* $c(x)$ and *antighost* $macron(c)(x)$, $det(Delta_"FP")$ becomes
  $ det(Delta_"FP") = integral cal(D) macron(c) cal(D) c e^(i integral_(RR^(1,3)) dif^4 x macron(c)_a (x) [Delta_"FP" c(x)]^a). $ <eq:ghosts>
  Inserting eqs. @eq:nakanishi-lautrup and @eq:ghosts into eq. @eq:z-ym, gives $Z_"YM"$ as
  $ Z_"YM" = integral cal(D) A cal(D) B cal(D) macron(c) cal(D) c e^(i S[A, B, macron(c), c]). $
  where the ABc action is
  $ S[A, B, macron(c), c] = integral_(RR^(1,3)) dif^4 x (-1/4 F_(mu nu)^a F_a^(mu nu) + B_a (x) F^a (x) + macron(c)_a (x) [Delta_"FP" c(x)]^a). $ <eq:abc-action>
  The ghosts transform as scalar fields under $S O(1, 3)$, but have fermionic statistics due to their Grassmannian nature. Thus they violate the spin-statistics theorem as well as unitarity since their Fock space does not have a positive definite norm.

== BRST symmetry and physical Hilbert space

We are finished with the path integral and return to the formalism of canonical quantization from here on.

- The problem of determining the physical Hilbert space $H_"phys"$ has two parts. We need to 1. guarantee a positive-definite norm on $H_"phys"$, and 2. show that time-evolution does not lead out of $H_"phys"$, i.e. the S-matrix needs to be a unitary operator on $H_"phys"$. If the criterion for a state to lie in $H_"phys"$ is related to a symmetry of the full interacting theory, then invariance of the physical Hilbert space under time-evolution follows automatically because the S-matrix respects all symmetries.
- Note that the ABc action @eq:abc-action possesses a *global residual fermionic symmetry* -- the *BRST symmetry*. It is implemented via the Grassmann-odd nilpotent operator $R$ acting as
  $ R A^mu = -D^mu c = -(partial^mu c + i g [A^mu, c]), wide R c = (i g)/2 {c, c}, wide R macron(c) = -B, wide R B = 0. $
  Defining $psi(x) = macron(c)^a partial_mu A_a^mu + xi/2 macron(c)^a B_a$, with the *gauge-fixing parameter* $xi$, the ABc Lagrangian reads
  $ cal(L)(A, B, macron(c), c) = -1/4 F_(mu nu)^a F_a^(mu nu) - R psi, $
  which fulfills $R cal(L) = 0$, because for the first term, $R$ is just a gauge transformation on $A^mu$ that leaves $F^2$ invariant, and $R^2 = 0$ in the second.
- Like any quantum symmetry, the *BRST symmetry transformation*
  $ delta_epsilon.alt Phi = epsilon.alt R Phi, #h(3em) Phi in {A, B, macron(c), c} $
  with $epsilon.alt$ a global Grassmann-valued parameter, is generated (in canonical quantization) by its associated *Noether charge* (operator) $hat(Q)_"BRST"$ in the sense that
  $ [epsilon.alt hat(Q)_"BRST", hat(Phi)] = i delta_epsilon.alt hat(Phi). $
  The *BRST charge* $hat(Q)_"BRST"$ is conserved, nilpotent, and hermitian:
  $ dot(hat(Q))_"BRST" = 0 <=> [hat(H), hat(Q)_"BRST"] = 0, #h(3em) hat(Q)_"BRST"^2 = 0, #h(3em) hat(Q)_"BRST"^dagger = hat(Q)_"BRST". $
- Some useful mathematics for finding $cal(H)_"phys"$ of quantum Yang-Mills theory: Any state $ket(psi)$ in a vector space $cal(H)$ with a nilpotent linear operator $hat(Q) : cal(H) -> cal(H)$ acting on it can be classified as either
  - $hat(Q)$-closed if $hat(Q) ket(psi) = 0$, i.e. if $ket(psi) in ker(hat(Q))$, or
  - $hat(Q)$-exact if $exists ket(chi) in cal(H)$ such that $ket(psi) = hat(Q) ket(chi)$, i.e. if $ket(psi) in "Im"(hat(Q))$.

  Since for all $hat(Q)$-exact $ket(psi)$ it holds that $hat(Q) ket(psi) = hat(Q)^2 ket(chi) = 0$, we have $"Im"(hat(Q)) subset ker(hat(Q))$. Further, the *$hat(Q)$-cohomology* is defined as the quotient space $cal(C)(hat(Q)) equiv ker(hat(Q)) \/ "Im"(hat(Q))$.
- Back to physics: The space of states on which the time-evolution operator $hat(U) = upright(T) e^(-i integral_RR hat(H) dif t)$ is independent of the specific choice of gauge-fixing condition is given by $ker(hat(Q)_"BRST")$. Time evolution should not depend on gauge, so we require
  $ ket(psi) in cal(H)_"phys" #h(3em) "only if" quad hat(Q)_"BRST" ket(psi) = 0. $ <eq:physical-state>
  Within $ker(hat(Q)_"BRST")$, the BRST-exact states have zero overlap with all other states since $forall ket(psi) in "Im"(hat(Q)_"BRST")$ with $ket(psi) = hat(Q)_"BRST" ket(chi)$ and $forall ket(xi) in ker(hat(Q)_"BRST")$
  $ chevron.l psi|xi chevron.r = bra(chi) hat(Q)_"BRST"^dagger ket(xi) = bra(chi) underbrace(hat(Q)_"BRST" ket(xi), 0) = 0. $
  States with zero overlap with all other states can never be measured and are therefore unphysical. We thus define the *physical Hilbert space* of quantum Yang-Mills theory as the cohomology
  $ cal(H)_"phys" = cal(C)(hat(Q)_"BRST") = ker(hat(Q)_"BRST")/"Im"(hat(Q)_"BRST"). $
- Evaluating the physical state condition eq. @eq:physical-state reveals $B$-, $macron(c)$-, and $c$-excitations to be unphysical. The only physical states are of the form
  $ ket(psi) in cal(H)_"phys" #h(3em) <=> #h(3em) ket(psi) = xi_mu ket(A^mu (bold(k))) quad "with" k^2 = 0 "and" xi_mu k^mu = 0. $
