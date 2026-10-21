#import "/notes.typ": cheatsheet, notes, vb, eps, ev, ket
#import "/string-theory/sheet.typ": SP, NO
#import "/string-theory/worldsheets.typ": ws-topologies
#import "@preview/cetz:0.5.2": canvas, draw

#show: notes.with(title: [String Theory -- Exam Sheet], date: [Janosh Riebesell, April 2016])
#show: cheatsheet

#let (ba, bxi, bP) = ($vb(alpha)$, $vb(xi)$, $vb(P)$)

// Parameter space of M-theory: a curvilinear pentagon whose cusps are the weakly coupled
// string theories, joined on the outside by the dualities and operations relating them.
#let m-theory-web = canvas(length: 1cm, {
  import draw: *
  let r = 1.6
  let names = (
    ([heterotic\ $E(8) times E(8)$], 126),
    ([Type II A], 54),
    ([Type II B], -18),
    ([Type I], -90),
    ([heterotic\ $S O(32)$], 198),
  )
  let edges = ([M-theory], [T-duality], [orientifold\ action $Omega$], [S-duality], [compac-\ tification])
  let pt(angle, rad) = (rad * calc.cos(angle * 1deg), rad * calc.sin(angle * 1deg))
  let cusps = names.map(((_, a)) => pt(a, r))
  // concave edges bend towards the center
  let ctrl(a, b) = ((a.at(0) + b.at(0)) * 0.3, (a.at(1) + b.at(1)) * 0.3)
  merge-path(fill: luma(215), stroke: 0.4pt, {
    for i in range(5) {
      let (a, b) = (cusps.at(i), cusps.at(calc.rem(i + 1, 5)))
      bezier(a, b, ctrl(a, b))
    }
  })
  for (i, (name, angle)) in names.enumerate() {
    // nested arcs mark the weakly coupled region around each cusp
    for k in range(3) {
      let (rad, start) = (0.14 + 0.07 * k, angle + 180 - 30)
      // arcs are positioned by their start point, so offset the cusp by the start direction
      let from = pt(angle, r)
      let first = (from.at(0) + rad * calc.cos(start * 1deg), from.at(1) + rad * calc.sin(start * 1deg))
      arc(first, start: start * 1deg, delta: 60deg, radius: rad, stroke: (paint: blue.darken(30%), thickness: 0.3pt))
    }
    content(pt(angle, r + 0.32), text(size: 5.5pt, align(center, name)))
    // outer arc to the next cusp, labelled with the relation between them
    let next = names.at(calc.rem(i + 1, 5)).at(1)
    let stop = if next > angle { next - 360 } else { next }
    arc(pt(angle - 8, r + 0.75), start: (angle - 8) * 1deg, stop: (stop + 8) * 1deg, radius: r + 0.75, stroke: 0.35pt, mark: (end: "stealth", fill: black, scale: 0.35))
    content(pt((angle + stop) / 2, r + 0.75), text(size: 5.5pt, align(center, edges.at(i))), fill: white, frame: "rect", stroke: none, padding: 1pt)
  }
  content((0, 0.15), text(size: 5.5pt)[parameter space of])
  content((0, -0.12), text(size: 6pt, weight: "bold")[M-Theory])
})


= Basics of string theory

- central axiom: fundamental objects in Nature not pointlike, but 1-dimensional (combined with standard kinematics of general covariance and usual procedure of quantization)
  - gen. cov.: inv. of form of physical laws under arb. diff. coordinate trafos.; essential idea: coordinates don't exist in nature, are only artifices in our description, hence should play no phys. role
- two sectors arise from elementary fact string can be open/closed: open = Yang-Mills, closed = gravity; since open strings can close up and vice versa, both are automatically dynamically related

= The classical bosonic string

- $S_"NG" = -T integral_Sigma dif A$ defines *Nambu-Goto action* of classical bosonic string, where $T$ string tension, $dif A = sqrt(-det(vb(G))) dif tau dif sigma$ area element of worldsheet (WS) $Sigma$ with coordinates $bxi = (tau, sigma)$ and induced metric (or pullback of ambient space metric $eta_(mu nu)$ onto $Sigma$) $G_(a b) = (partial X^mu)/(partial xi^a) (partial X_mu)/(partial xi^b)$
- to eliminate square root in $S_"NG"$, introduce WS metric $h^(a b) (tau, sigma)$ as auxiliary field in on-shell-$S_"NG"$-equivalent *Polyakov action* $SP = -T/2 integral_Sigma dif tau dif sigma sqrt(-h) h^(a b) G_(a b)$, with $h = det(vb(h))$; $X^mu$ still spacetime (ST) vector but scalar on WS, hence $SP$ simply action of $d$ scalars
  - *symmetries*: *1.* $d$-dim. ST *Poincaré invariance* $X^mu -> Lambda^mu zws_nu X^nu + V^mu$, with $Lambda^mu zws_nu in S O(1, d - 1)$ *2.* local WS *diffeomorphism inv.* under $xi^a -> xi^a - eps^a (xi)$ under which the WS scalar $delta X^mu = eps^a partial_a X^mu$, the metric $delta h_(a b) = nabla_a eps_b + nabla_b eps_a$, scalar density of weight 1 $delta sqrt(-h) = partial_a (eps^a sqrt(-h))$ *3.* local *Weyl inv.* $h_(a b) -> e^(2 omega(xi)) h_(a b)$, special symmetry only for 2-dim. WS, important for cons. quantization
  - could add 2 terms to $SP$: *1.* cosmol. constant term $S_Lambda = Lambda integral_Sigma dif^2 xi sqrt(-h)$, would spoil conf. inv. *2.* Einstein-Hilbert term $S_"EH" = lambda_"EH"/(4 pi) integral_Sigma dif^2 xi sqrt(-h) cal(R)$, is a total derivative $=>$ no dynamics; also $S_"EH" prop chi$ Euler char.
- *e.-m. tensor* $T_(a b) = (4 pi)/sqrt(-h) (delta SP)/(delta h^(a b)) = -1/alpha' (G_(a b) - 1/2 h_(a b) G^c zws_c)$, traceless $T^a zws_a = 0$ as consequence of Weyl inv., conserved current $nabla^a T_(a b) = 0$ w.r.t. local WS diffeo. for on-shell $X^mu$
- *gauge fixing*: $h_(a b)$ symmetric has $d/2 (d + 1)$ d.o.f., diffeo. + Weyl has $(d + 1)$, hence for $d = 2$ where Weyl trafo. $omega(xi)$ s.t. $sqrt(-h) cal(R) -> sqrt(-h) (cal(R) - 2 Delta omega) = 0$ implies $R^a zws_(b c d) = 0$, we can (locally) gauge away all metric d.o.f., then diffeo. trafo. to obtain flat WS $h_(a b) = eta_(a b)$
  - note: leaves large *residual gauge symmetry* generated by conformal Killing vectors $vb(eps)$ satisfying $(bP dot vb(eps))_(a b) = nabla_a eps_b + nabla_b eps_a - nabla^c eps_c h_(a b) = 0$ whose effect on metric can be undone by Weyl trafo.
- *lightcone coordinates*: $xi^plus.minus = tau plus.minus sigma$; metric $h_(plus.minus plus.minus) = 0$, $h_(plus.minus minus.plus) = -1/2$, $h^(plus.minus minus.plus) = -2$; line element $dif s^2 = h_(a b) dif xi^a dif xi^b = -dif tau^2 + dif sigma^2 = -dif xi^+ dif xi^-$
  - e.m.-tensor: $T_(plus.minus plus.minus) = -1/alpha' partial_plus.minus vb(X) dot partial_plus.minus vb(X)$, tracelessness $T_(plus.minus minus.plus) = 0$, conservation $partial_minus.plus T_(plus.minus plus.minus) = 0 => T_(plus.minus plus.minus) (xi^plus.minus)$; crucial: in flat gauge, $h_(a b)$-e.o.m. $T_(a b) = 0$ still has to be enforced as constraint $T_(plus.minus plus.minus) = 0$
- *mode expansion*: varying flat gauge $SP = T/2 integral_Sigma dif tau dif sigma [(partial_tau vb(X))^2 - (partial_sigma vb(X))^2] = T integral_Sigma dif^2 xi partial_+ vb(X) dot partial_- vb(X)$ yields free wave equation $(partial_tau^2 - partial_sigma^2) X^mu = 0 = partial_+ partial_- X^mu$ as string e.o.m. provided b.t. vanish: cl. string #sym.checkmark, open string requires Neumann ($partial_sigma X^mu = 0$) and/or Dirichlet ($delta X^mu = 0 = partial_tau X^mu$) b.c. at $sigma = 0, l$; each has diff. exp., e.g. open NN string: $X^mu = x^mu + (p^mu tau)/(T l) + i sqrt(2 alpha') sum_(n != 0) alpha_n^mu/n e^(-i pi/l n tau) cos((n pi sigma)/l)$
  - modes fulfill comm. rel. $[alpha_m^mu, alpha_n^nu] = m eta^(mu nu) delta_(m,-n)$; $[x^mu, p^nu] = i eta^(mu nu)$
  - insert resulting $partial_plus.minus X^mu$ into e.m.-tensor to get its mode expansion $T_(plus.minus plus.minus) = 4 alpha' sum_(m in ZZ) L_m^plus.minus e^(-i (2 pi)/l m xi^plus.minus)$ i.t.o. the Virasoro generators $L_m$; $T_(a b) = 0$ implies the *Virasoro constraints* $L_m^plus.minus = 0 thick forall m in ZZ$
- *D$p$-brane* is $(p + 1)$-dim. hypersurface on which open strings can end, fixing them in dims. normal to it; mom. exchange with string implies brane is a dynamical (albeit non-perturbative) object itself
- *Hamiltonian*: $H_"op" = pi/l (1/2 ba_0^2 + 1/2 sum_(n != 0) ba_(-n) dot ba_n) = pi/l L_0$, must vanish since $T_(a b) = 0$ which implies *mass shell cond.*, e.g. for open string $M^2 = -vb(p)^2 = 1/alpha' sum_(n=1)^infinity ba_(-n) dot ba_n$, for closed string $H_"cl" = (2 pi)/l (L_0^+ + L_0^-) prop partial_+ + partial_- prop partial_tau = 0$ implem. time reparametr. inv.

= Bosonic string quantization

- 3 different ways to quantize: *1. old covariant* (OCQ): Viras. constr. implemented at quantum level; manifestly Lorentz covariant, but unitary only in critical number $d_"crit"$ of ST dims. *2. lightcone* (LCQ): Viras. constr. implemented classically, manifestly unitary, but Lorentz covariant only in $d = d_"crit"$ *3. path-integral* (PIQ): uses Faddeev-Popov (FP) gauge fixing procedure, criticality equivalent to closure of BRST algebra, only closed in $d = d_"crit"$
- *normal ordering* $NO(alpha_m^mu alpha_n^nu) = alpha_m^mu alpha_n^nu$ for $m <= n and alpha_n^nu alpha_m^mu$ else introduces ambiguity in $L_0 -> L_0 - a$ only, captured in norm. ord. const. $a$ interpreted as Casimir energy, fixed by consistency cond.
- *Virasoro algebra* $[L_m, L_n] = (m - n) L_(m+n) + c/12 m(m^2 - 1) delta_(m,-n)$ is central extension by $CC$ of classical Witt algebra, *central charge* $c = eta^mu zws_mu = d$ given by number of scalar fields $X^mu$; $c != 0$ indicates quantum anomaly of WS conformal symmetry
- *phys. state cond.* $(L_m - a delta_(m,0)) ket(phi) = 0 thick forall m >= 0 and ket(phi) in cal(H)_"phys"$
- *tower of states*: $M_"op"^2 ket(phi) = (1/alpha' (N - a) + T^2 Delta vb(x)^2) ket(phi)$ with number op. $N$ counting excitations by creators $ba_n$, $n <= 0$; $M_"cl"^2 ket(phi) = 2/alpha' (N^+ + N^- - 2 a) ket(phi)$ governed by level matching condition $(N^+ - N^-) ket(phi) = 0$
- *criticality*: string spectrum analysis reveals unitarity (OCQ)/non-anomalous Lorentz algebra (LCQ) requires $a = 1$, $d = 26$
- bosonic vacuum $ket(0\, vb(p))$ is *tachyonic* $M^2 = -1/alpha'$; known from QFT as not inconsistent, merely signal instability of (naive) vacuum
- for general b.c.s, Casimir energy increases by $1/24$ per NN/DD dim. and decr. by $1/48$ per ND/DN dim., i.e. $a_"tot" = (d - 2)/24 - (n_"ND" + n_"DN")/16$
- open spectrum with D-branes: first-level excitations parallel to brane form *massless vector* = gauge field $=>$ single brane hosts $U(1)$ gauge theory; normal exc. = $n_"DD"$ massless scalars (Goldstone bosons assoc. with spontan. breaking of 26-dim. Poincaré inv.)
- $N$ coincident branes carry $U(N)$ gauge theory; in orientifolded theories also $S O(N)$ and symplectic $S p(2 N)$ gauge groups possible
- first-level closed string polarization tensor decomposes into 3 irred. repr. of little group $S O(24)$: $xi_(i j) = g_(i j) + B_(i j) + phi delta_(i j)$, with $g_(i j)$ massless, transversely polarized spin 2 particle (*graviton*), $B_(i j)$ antisymmetric (*Kalb-Ramond*) tensor field, $phi$ scalar field (*dilaton*)
- *PIQ*: partition function $Z = integral cal(D) X det(bP) e^(i SP [X, hat(h)])$ with FP determinant $det(bP)$, arbitrary reference metric $hat(h)$
  - can be written $Z = integral cal(D) X cal(D) b cal(D) c e^(i (SP + S_g))$, by introducing FP ghost $c^a (xi)$, antighost $b_(a b) (xi)$ (anti-commuting, fermionic fields with integer spin, negative norm states), governed by ghost action $S_g = (-i)/(2 pi) integral_Sigma dif^2 xi sqrt(-hat(h)) hat(h)^(a b) c^d nabla_a b_(b d) limits(=)^"lcg" i/pi integral_Sigma dif^2 xi (c^+ partial_- b_(++) + c^- partial_+ b_(--))$ and e.o.m.s $nabla^a b_(a b) = 0 = partial_minus.plus b_(plus.minus plus.minus)$ & $bP dot vb(c) = 0 = partial_minus.plus c^plus.minus => c^a$ in 1-to-1 corresp. with conf. Killing vects.
- *ghost Virasoro alg.* $[L_m^g, L_n^g] = (m - n) L_(m+n)^g + m/6 (1 - 13 m^2) delta_(m,-n)$ where $L_m^g = sum_(n in ZZ) (m - n) NO(b_(m+n) c_(-n))$ i.t.o. anti-comm. ghost modes $b_n$, $c_n$ with ${c_m, b_n} = delta_(m,-n)$, ${c_m, c_n} = {b_m, b_n} = 0$
  - yields combined Virasoro alg. $[L_m^"tot", L_n^"tot"] = (m - n) L_(m+n)^"tot" + m[c^"tot"/12 (m^2 - 1) + 2(a - 1)] delta_(m,-n)$ with central charge $c^"tot" = c^X + c^g$ where $c^g = -26$, $c^X = d$ in $RR^(1,d-1)$, hence Weyl anomaly in PI absent iff $d = 26$, $a = 1$ (this really fixes $c^X$, only indirectly $d$)
- *BRST symmetry* generated by necessarily nilpotent cons. charge $Q_B$, $Q_B^2 = 0$ holds if full Viras. alg. non-anomalous ($d = 26$, $a = 1$), i.e. BRST consistency requires absence of total Weyl anomaly
  - $Q_B ket(phi) = 0 thick forall ket(phi) in cal(H)_"phys"$ is necessary phys. state cond.; pos. norm Hilbert space $cal(H)_"phys" = cal(H)_"clos"/cal(H)_"exac" = ker(Q_B)/"Im"(Q_B) equiv Q_B$ cohomology

= Conformal field theory

- examples: *1.* string WS is 2-dim. CFT *2.* at fixed points of RG eqs. in QFT, theory becomes scale inv. *3.* at crit. points in CMP and SP where correlation length diverges *4.* AdS/CFT corresp. relates gravity on AdS space to CFT on its boundary
- *conformal trafo.* = diffeom. that changes metric $g_(mu nu) (x) -> partial_(mu') x^alpha partial_(nu') x^beta g_(alpha beta) limits(=)^! e^(omega(x)) g_(mu nu) (x)$ only by a factor, i.e. infinitesimally $partial_mu eps_nu + partial_nu eps_mu = omega(x) g_(mu nu)$ if we set $x'^mu = x^mu - eps^mu (x)$ and $e^(omega(x)) = 1 + omega(x)$
  - conf. trafos. include translations, Lorentz trafos., dilations, special conf. trafos. (= inversion, translation, another inversion)
  - $omega(x)$ satisfies constraints some of which are vacuous in $d = 2 =>$ makes group of infinites. conf. trafos. less restrictive, its volume infinite; this allows to solve some theories exactly/completely
- group of finite conf. diffeos. $z -> (a z + b)/(c z + d)$ on $bb(S)^2$ is *Möbius group* $P S L(2, CC) = S L(2, CC) \/ ZZ_2$ (since $(a, b, c, d) limits(->)^(ZZ_2) (-a, -b, -c, -d)$ same trafo.); generated by $l_(-1), l_0, l_1$, with $l_n = -z^(n+1) partial_z$ (which fulfill *Witt alg.* = Viras. alg. but classical, i.e. no $c$-term)
  - import. prop. of $P S L(2, CC)$: maps any 3 distinct points to any other 3, crucial since used to remove gauge redundancy by fixing positions of asymptotic in- and out-states in scattering ampl.
- *primary fields* transform as tensors $phi(z, macron(z)) -> phi'(z', macron(z)') = (partial_z f)^(-h) (partial_macron(z) macron(f))^(-macron(h)) phi(z, macron(z))$ under conf. trafo. $z -> z' = f(z)$, where $(h, macron(h))$ = conf. weights ($h + macron(h)$ = mass dim., $h - macron(h)$ = spin)
  - infinites.: $f(z) = z + eps(z) => delta_(eps, macron(eps)) phi = -(h (partial_z eps) + eps partial_z + macron(h) (partial_macron(z) macron(eps)) + macron(eps) partial_macron(z)) phi$
  - together with (successive) operator product exps. (OPE), primaries can be used to express all higher $n$-point fcts. i.t.o. lower correlators; this is idea behind defining CFT i.t.o. finite amount of data, namely conf. anomaly $c$, spectrum of primaries $phi_j$, their weights $h_j$ and OPE coeffs. $C_(i j)^k$
  - *quasi-primary field*: like primary, but only for $f in P S L(2, CC)$
  - applied to strings: $X^mu$ not (quasi)primary, but $partial X^mu$, $NO(e^(i k X))$ are
- radially ord. *OPE*: by *Wick's thm.*, $cal(R)(product_i phi_i) = NO{product_i phi_i + sum_(j < k) ev(phi_j phi_k) product_(i != j,k) phi_i + sum_(j != k)^(l != m) ev(phi_j phi_k) ev(phi_l phi_m) product_(i != j,k)^(i != l,m) phi_i + ...}$
- *conf. Ward-Takahashi id.*: $delta_(eps, macron(eps)) cal(O)(z, macron(z)) = -integral_(C_z) [(dif w)/(2 pi i) eps(w) T(w) + (dif macron(w))/(2 pi i) macron(eps)(macron(w)) macron(T)(macron(w))] cal(O)(z, macron(z)) =>$ info about conf. trafos. encoded in residua of OPE with e.m.-tensor (integrand radially ordered)
  - yields OPE of $T(z)$ with primary $phi(w)$ of weight $h$: $cal(R)[T(z) phi(w)] = (h phi(w))/(z - w)^2 + (partial_w phi(w))/(z - w) + "reg. terms"$
  - e.m.-tensor OPE follows from $[L_m, L_n]$ as $T(z) T(w) = (c\/2)/(z - w)^4 + (2 T(w))/(z - w)^2 + (partial_w T(w))/(z - w) => T(z)$ primary of $h = 2$ if $c = 0$
- *operator-state correspondence*: isomorphism in 2-dim. CFT that relates primary fields to highest weight states, e.g. $ket(phi) = phi(0) ket(0) = phi_(-h) ket(0)$ for $h$-weight primary with expansion $phi(z) = sum_(n in ZZ) phi_n z^(-n-h)$, by residue thm. $phi_n = integral_(C_0) (dif z)/(2 pi i) phi(z) z^(n+h-1)$
- requiring BRST-inv. for $X$-CFT gives phys. state cond. $L_m ket(phi) = 0 thick forall m > 0$ and $(L_0 - 1) ket(phi) = 0 =>$ phys. states are in 1-1 corresp. with primaries of weight $h = 1$; leads to concept of *vertex operator* $equiv$ primary field of $h = 1$, e.g. $NO(e^(i vb(k) dot vb(X)))$ with $h = alpha'/4 vb(k)^2 limits(=)^! 1 => M^2 = -4/alpha'$ or $NO[partial X^mu (z) e^(i vb(k) dot vb(X)(z))]$ with $h_(V_1) = 1 + alpha'/4 vb(k)^2 limits(=)^! 1 => vb(k)^2 = 0$ inserted at $z = 0$, creates first exc. level phys. state from $P S L(2, CC)$-inv. vacuum
- *Verma module* $V_(h_j)$ is span of all states of form $ket(phi_j^(k_1 ... k_m)) = product_i^m L_(-k_i) ket(phi_j)$ with ascending $k_i$ and conf. weight $h_V = h_j + sum_i^m k_i$
- *CFT unitarity*: holds if conformal anomaly $c > 0$ and spectrum of primaries $phi_j$ fulfills $h_j >= 0 thick forall j$ and $h_phi = 0 <=> phi = bb(1)$, i.e. only $P S L(2, CC)$-inv. vacuum may have $h = 0$

= String interactions

- no localized vertices, interac. captured by *global WS topology* $=>$ no need to add arbitrary terms to WS action, $SP$ remains free
  - thus correlators of diff. fields (bosons, fermions, ghosts) decouple (unlike e.g. Yang-Mills with ghost-gauge interact.), _very_ useful
- goal in string perturbation: *S-matrix* of scattering process, at each order latter may (by conformal symmetry) be described by compact WS with vertex op. insertions instead of asymptotic in-/out-states
  - S-matrix sums up all WS topols.; imp. thm. 'every compact, connected, oriented 2-dim. manifold topologically equiv. to sphere with $(g, b)$ handles, boundaries' $=>$ WSs classified by *Euler char.* $chi = 2 - 2 g - b$, a topol. inv. under continuous deformations of WS metric, given by *Gauss-Bonnet thm.* $chi = integral_Sigma (dif^2 xi)/(4 pi) sqrt(-h) cal(R) + integral_(partial Sigma) (dif s)/(2 pi) k$, Ricci sc. $cal(R)$, geodesic curvat. $k$
  - $S_(j_i) (k_i) = sum_("comp" \ "topos") (integral cal(D) X integral cal(D) h)/"Vol"_("Diff" times "Weyl") e^(-SP - lambda chi) product_(i=1)^n V_(j_i) (k_i)$ heur. expr. (before gauge fixing) for $n$ string scattering, added $chi$-term to action (without affecting dynamics) to keep track of topol. in PI
- e.g. tree-level and one-loop topologies: disk $bb(D)^2$ $[(0, 1), chi = 1]$, cyl. $bb(C)^2$ $[(0, 2), chi = 0]$, sphere $bb(S)^2$ $[(0, 0), chi = 2]$, torus $bb(T)^2$ $[(1, 0), chi = 0]$
  #block(width: 100%, inset: (y: 3pt), ws-topologies())
- in string theory, single diagram sums over entire mass spectrum, i.e. what in QFT would be described by many diff. Feynman diags.
  - as result amplitudes fall off quicker (exponentially) than in QFT, partially respons. for *UV finiteness* of string loop diags.
  - another reason: *modular inv.* [under action of modular group, e.g. $P S L(2, ZZ)$ on the torus] acts as intrinsic UV cutoff by excluding divergent region of moduli space from fundamental domain
  - some UV divergences arise but no issue for UV finit. due to WS duality between open/closed channel, all can be reinterpreted as IR diver. of dual diagr. e.g. cylinder: tree-level cl., one-loop open
- def. *metric moduli*: deformation of metric that cannot by undone by diffeo. or Weyl resc.; by R.-R.-thm. number $mu = dim(ker P^dagger)$ of moduli and $kappa = dim(ker P)$ of conf. Killing vects. fulfill $mu - kappa = -3 chi$ (if $chi > 0 => mu = 0$, if $chi < 0 => kappa = 0$)
- *non-linear $sigma$-model* describes strings propagating on curved background (generated by coherent state of its _own_ massless fluctuations); consistency to first order in $alpha'/R_c$ yields Einstein eqs. for background metric ($R_c$ typical radius of target space)

= Superstring theory

- remedies tachyon-vacuum, lack of fermionic excitats. of bosonic th.
- obtained by adding $S_"F" = -i/(4 pi) integral_Sigma dif^2 xi macron(psi)_A^mu gamma_(A B)^alpha partial_alpha psi_(B, mu) limits(=)^"lcg" i/(2 pi) integral_Sigma dif^2 xi (vb(psi)_+ dot partial_- vb(psi)_+ + vb(psi)_- dot partial_+ vb(psi)_-)$ to $SP$; $psi_plus.minus$ are Grassmann-valued *Majorana-Weyl spinors* (real, definite chirality) with *Dirac eq.* as e.o.m. $gamma^alpha partial_alpha psi = 0 = partial_minus.plus psi_plus.minus$; mass dim. $[psi] = 1/2$ ($[X] = -1$)
- features *supersymmetry* $delta X^mu = i sqrt(alpha')/sqrt(2) macron(eps)_A psi_A^mu = i sqrt(alpha')/sqrt(2) (eps_+ psi_-^mu - eps_- psi_+^mu)$, $delta psi_A^mu = eps_B/sqrt(2 alpha') gamma_(A B)^alpha partial_alpha X^mu = plus.minus sqrt(2)/sqrt(alpha') eps_minus.plus partial_plus.minus X^mu$; related to Poincaré by ${Q_A, macron(Q)_B} tilde.equiv 2 gamma_(A B)^a P_a$ (laxly SUSY#super[2] = translation)
- generators of *super conformal symmetry*: e.-m. tensor $T_(plus.minus plus.minus) = -1/alpha' partial_plus.minus vb(X) dot partial_plus.minus vb(X) - i/2 vb(psi)_plus.minus dot partial_plus.minus vb(psi)_plus.minus$ and *supercurrent* $J_plus.minus = (-1)/(2 alpha') vb(psi)_plus.minus dot partial_plus.minus vb(X)$
  - *super-Viras. constr.*: $T_(plus.minus plus.minus) limits(=)^! 0$, $J_plus.minus limits(=)^! 0$ imposed on e.o.m. sols.
- local diffeo. inv. + supersymmetry = local supersym. $=>$ *supergravity* in which also metric $h_(a b)$ has superpartner, the *gravitino*
- local e.o.m. needs boundary terms to vanish; closed string b.c.s that not mix $psi_plus.minus$ and respect Poincaré sym. are $psi_plus.minus (sigma + l) = e^(2 pi i phi_plus.minus) psi_plus.minus (sigma)$
  - $phi_plus.minus = 0 thin (1/2)$: (anti-)per. *Ramond (Neveu-Schwarz) sec.* with (half-)integer mode exp. $vb(psi)_plus.minus (xi^plus.minus) = sqrt((2 pi)/l) sum_(n in ZZ (+ 1/2)) vb(b)_n^plus.minus e^(-i (2 pi)/l n xi^plus.minus)$
  - R-R and NS-NS bosonic; R-NS and NS-R fermionic excitations
- *GSO projection*: CFT consistency + stability of vacuum (= no tachyon) $=>$ *Type II A/B* as closed oriented superstring theories
  - equal number of bosons + fermions, $128 + 128$ at massless level
  - 2 spin 3/2 fields (gravitino) $=>$ low-$E$-limit of Type II is SuGra
  - WS consistency + vacuum stability imply local SUSY in $d = 10$
- *Type I#sub[cl] th.* unstable like bosonic theory due to tachyonic vacuum, inconsistent at 1-loop level due to appearance of tadpole
- only 5 consist. superstr. ths. in $d = 10$: *Type II A/B*, *Type I* of closed + unoriented open strings with gauge group $S O(32)$, and the *heterotic* $S O(32)$ and $E(8) times E(8)$ theories

= Compactification, T-duality, D-branes

- compactification in superstring theory is the op. $RR^(1,9) -> RR^(1,3) times cal(M)^6$ with $cal(M)^6$ called *internal space*; flat scalar fields whose VEV determine geometric properties of $cal(M)^6$ called *moduli fields*
- truly stringy *winding states* around compact. dimensions with mass $M^2 = (omega^2 R_c^2)/alpha'^2$ and indep. left-/right-moving modes $ba_n^plus.minus$ possible
- *T-duality*: $n <-> omega$, $R <-> R' = alpha'/R$ is exact symmetry of closed CFT that affects $p_L -> p_L prop ba_0^-$, $p_R -> -p_R prop ba_0^+$, i.e. parity on right-movers
- fig.: parameter space of string th., cusps are weakly coupled limits, interior $d = 11$ M-theory with coupling of order 1, at low energies described by supergravity
  #align(center, block(inset: (y: 4pt), m-theory-web))
- *D-branes*: dynamical objects that gravitate by coupling to closed strings in NS-NS sector, i.e. have mass; are charged under R-R $p$-form potentials
- worldvolume of D-branes not static, exhibit quantum fluctuations in normal directions described by scalar light open-string excitations
- intersecting *brane worlds*: important in string phenomenology to make contact between $d = 10$ and $RR^(1,3)$; stack of two branes $D_A$, $D_B$ intersecting along $RR^(1,3)$ gives rise $U(N_A) times U(N_B)$ Yang-Mills th. + 1 chiral fermion transf. in bifundamental $(macron(N)_A, N_B)$, i.e. structure of SM $S U(3) times S U(2) times U(1)_Y$ for $N_A = 3$, $N_B = 2$, $N_C = 1$
- every 4-dim. eff. th. obtained by compactif. corresp. to diff. choice of vacuum; tog. all solutions called *landscape of string vacua*
