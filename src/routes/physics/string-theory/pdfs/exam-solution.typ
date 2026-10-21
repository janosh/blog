#import "/notes.typ": note, notes, task, vb, eps, ev, bra, ket
#import "/string-theory/sheet.typ": SP, NO
#import "/string-theory/brane-table.typ": brane-table
#import "/string-theory/worldsheets.typ": ws-topologies
#import "@preview/cetz:0.5.2": canvas, draw

#show: notes.with(
  title: [String Theory -- Final Exam Solution],
  subtitle: [Lecturer: Timo Weigand],
  date: [Janosh Riebesell, February 15th, 2016],
)
#set heading(numbering: "1")
#set math.equation(numbering: "(1)")

#let (bX, bpsi, ba, bA, bphi) = ($vb(X)$, $vb(psi)$, $vb(alpha)$, $vb(A)$, $vb(phi)$)
#let tag(n) = text(size: 7pt, fill: blue.darken(40%), [(#n)])
// list item with a free-form label, e.g. "2. & 3." for a case that yields two of the states
#let case(label, body) = grid(columns: (3.4em, 1fr), column-gutter: 0.4em, row-gutter: 0pt, align(right, label), body)
// equals sign annotated with the equation that justifies the step
#let eqby(n) = $limits(=)^#tag(n)$

// Mexican hat potential V(|phi|) = lambda (|phi|^2 - v)^2 as a wireframe in oblique projection
#let mexican-hat = canvas(length: 1cm, {
  import draw: *
  let V(r) = 0.75 * calc.pow(r * r - 1, 2)
  let proj(r, t) = (1.7 * r * calc.cos(t), 0.55 * r * calc.sin(t) + 1.3 * V(r))
  let rs = range(0, 30).map(i => 0.05 * i)
  let ts = range(0, 49).map(i => i * 7.5deg)
  for r in rs.slice(1) { line(..ts.map(t => proj(r, t)), stroke: 0.3pt) }
  for t in ts.slice(0, -1) { line(..rs.map(r => proj(r, t)), stroke: 0.3pt) }
  line(proj(0, 0deg), (0, 2.3), mark: (end: "stealth", fill: black, scale: 0.5), stroke: 0.5pt)
  content((0, 2.3), $V(phi)$, anchor: "east", padding: 3pt)
  circle(proj(0, 0deg), radius: 0.07, fill: luma(150), stroke: 0.3pt)
  content(proj(0, 0deg), [A], anchor: "south-west", padding: (left: 4pt, bottom: 3pt))
  let b = proj(1, -30deg)
  circle(b, radius: 0.07, fill: luma(150), stroke: 0.3pt)
  bezier((0.15, 1.05), (1.9, 0.4), (1.4, 1.3), mark: (end: "stealth", fill: black, scale: 0.5), stroke: 0.4pt)
  content((1.9, 0.4), [B], anchor: "west", padding: 3pt)
  line((-0.6, -0.4), (-1.4, -0.9), mark: (end: "stealth", fill: black, scale: 0.5), stroke: 0.5pt)
  content((-1.4, -0.9), $"Re"(phi)$, anchor: "east", padding: 2pt)
  line((0.6, -0.4), (1.4, -0.9), mark: (end: "stealth", fill: black, scale: 0.5), stroke: 0.5pt)
  content((1.4, -0.9), $"Im"(phi)$, anchor: "west", padding: 2pt)
})

= RNS Superstring

#task[
  The Polyakov action for an $n$-dimensional membrane in flat $d$-dimensional spacetime is given by
  $ SP [X] = -1/(2 pi) integral_Sigma dif tau dif^n sigma sqrt(-h) h^(a b) partial_a X^mu partial_b X_mu, $ <eq:polyakov>
  with $h = det(vb(h))$.
  #set enum(numbering: "a)")
  + Show how $SP [X]$ transforms under the Weyl rescaling
    $ h^(a b) -> Omega^(-1) (sigma) h^(a b) $ <eq:weyl>
    and argue why the string as a one dimensional object is special in the sense that higher dimensional objects will not lead to a similar theoretical structure.
  + Interpret the appearance of a tachyon from a field theoretic perspective.
  + What is a Majorana spinor?

  Consider the RNS superstring action in conformal gauge
  $ S_"RNS" = -1/(16 pi) integral_Sigma dif tau dif sigma (2/alpha' partial_a X^mu partial^a X_mu + 2 i macron(psi)^mu gamma^a partial_a psi_mu), $ <eq:rns>
  where $psi^mu$ is a $d$-plet of Majorana fermions and the matrices $gamma^a$, $a in {0, 1} equiv {tau, sigma}$ are given by
  $ gamma^0 = mat(0, 1; -1, 0), #h(3em) gamma^1 = mat(0, 1; 1, 0). $
  With respect to this basis write $psi^mu = (psi_+^mu, psi_-^mu)^"T"$. Let $eps = (eps_+, eps_-)^"T"$ be an anticommuting infinitesimal Majorana spinor.
  #set enum(numbering: "a)", start: 4)
  + Introduce lightcone coordinates $xi^plus.minus = tau plus.minus sigma$ and show that the closed string action $S_"RNS"$ is invariant under the SUSY transformation
    $ delta X^mu = i sqrt(alpha'/2) macron(eps) psi^mu, $ <eq:susy-x>
    $ delta psi^mu = 1/2 sqrt(2/alpha') gamma^a partial_a X^mu eps. $ <eq:susy-psi>
    *Hint:* Use the equation of motion and the chiral condition $gamma^b gamma^a partial_b eps(xi) = 0$.

  Consider the boundary conditions
  $ bpsi_+ delta psi_+ - bpsi_- delta psi_-|_(sigma = 0) limits(=)^! bpsi_+ delta psi_+ - bpsi_- delta psi_-|_(sigma = l) $ <eq:boundary>
  #set enum(numbering: "a)", start: 5)
  + State the two string solutions corresponding to these boundaries.
  + Give the four sectors of these boundaries and name if they are bosonic or fermionic.
]

#set enum(numbering: "a)")
+ There are only two quantities in the Polyakov action @eq:polyakov affected by the Weyl rescaling @eq:weyl: The metric $h^(a b)$ itself and its determinant $h$,
  $ sqrt(-h) limits(-->)^tag("eq:weyl") sqrt(-h') = sqrt(det(vb(h)')) = sqrt(det[Omega(sigma) vb(h)]) = Omega^((n+1)/2) (sigma) sqrt(det(vb(h))) = Omega^((n+1)/2) (sigma) sqrt(-h). $
  Thus the whole action Weyl rescales as
  $ SP [X] limits(-->)^tag("eq:weyl") S'_"P" [X] = -1/(2 pi) integral_Sigma dif tau dif^n sigma Omega^((n+1)/2) (sigma) sqrt(-h) Omega^(-1) h^(a b) partial_a X^mu partial_b X_mu. $
  Precisely for the case $n = 1$ of a one-dimensional membrane, i.e. a string, do we recover the original Polyakov action. In this sense, strings are special as their theory enjoys symmetries not encountered with higher-dimensional objects.

+ The tachyonic ground state encountered in bosonic string theory is entirely due to the normal-ordering ambiguity that arises when moving from the classical to the quantum theory.

  It is important to note here that quantum fields with tachyonic states are not at all inconsistent. They merely indicate an instability of the vacuum.

  #note[
    A confirmed real-world example of a quantum field that assumes tachyonic states is the scalar Higgs field $phi$. Its potential is given by
    $ V(|phi|) = lambda (|phi|^2 - v)^2, #h(3em) phi in CC, quad lambda, v in RR_+, $
    which looks like
    #align(center, mexican-hat)
    As the image illustrates, the field is unstable at $phi = 0$ and will, at the slightest perturbation, condense into its true vacuum. Setting the derivative equal to zero,
    $ partial_(|phi|) V(|phi|) = 4 lambda |phi| (|phi|^2 - v) limits(=)^! 0 wide => wide |phi| = 0 "or" |phi| = sqrt(v). $
    we find that the vacuum lies anywhere on the circle $|phi| = sqrt(v)$. From the sketch, we know that the other extremum at $|phi| = 0$ is a maximum, rendering the second derivative, and consequently the mass of the field at this point, negative.
    $ m_phi^2|_(phi = 0) = partial_(|phi|)^2 V(|phi|)|_(phi = 0) = 12 lambda |phi|^2 - 4 lambda v|_(phi = 0) = -4 lambda v < 0. $
    It is at this point still unclear if the same occurs in string theory in the sense that the bosonic string is related, by tachyon condensation, to the superstring theory.
  ]

+ A Majorana spinor $psi$ is one that fulfills the Majorana condition $psi^* = psi$, i.e. is real.

+ The Jacobian of the transformation $vec(tau, sigma) -> vec(xi^+, xi^-) = vec(tau + sigma, tau - sigma)$ from worldsheet to lightcone coordinates has determinant
  $ |det(vb(J))| = abs(det mat(partial_tau xi^+, partial_sigma xi^+; partial_tau xi^-, partial_sigma xi^-)) = abs(det mat(1, 1; 1, -1)) = 2. $
  Hence, $partial_tau plus.minus partial_sigma = 2 partial_(xi^plus.minus) equiv 2 partial_plus.minus$ and the bosonic term in the RNS action @eq:rns becomes#footnote[$bX = (X^0, ..., X^25)$ and $bpsi = (psi^0, ..., psi^25)$ denote the entire bosonic and fermionic spacetime vectors, respectively.]
  $
    partial_a bX dot partial^a bX & = partial_tau bX dot partial^tau bX + partial_sigma bX dot partial^sigma bX = partial_tau bX dot h^(tau b) partial_b bX + partial_sigma bX dot h^(sigma b) partial_b bX \
    & limits(=)^(vb(h) = mat(-1, 0; 0, 1)) -partial_tau bX dot partial_tau bX + partial_sigma bX dot partial_sigma bX = -(partial_tau + partial_sigma) bX dot (partial_tau - partial_sigma) bX = -4 partial_+ bX dot partial_- bX,
  $ <eq:boson-lc>
  while for the fermionic term, we get
  $
    macron(bpsi) gamma^a dot partial_a bpsi & = macron(bpsi) gamma^tau dot partial_tau bpsi + macron(bpsi) gamma^sigma dot partial_sigma bpsi \
    & eqby("eq:majorana-conj") overbrace((-bpsi_-, bpsi_+) mat(0, 1; -1, 0), (-bpsi_+, -bpsi_-)) dot partial_tau vec(bpsi_+, bpsi_-) + overbrace((-bpsi_-, bpsi_+) mat(0, 1; 1, 0), (bpsi_+, -bpsi_-)) dot partial_sigma vec(bpsi_+, bpsi_-) \
    & = -bpsi_+ dot partial_tau bpsi_+ - bpsi_- dot partial_tau bpsi_- + bpsi_+ dot partial_sigma bpsi_+ - bpsi_- dot partial_sigma bpsi_- \
    & = -bpsi_+ dot (partial_tau - partial_sigma) bpsi_+ - bpsi_- dot (partial_tau + partial_sigma) bpsi_- \
    & = -2 bpsi_+ dot partial_- bpsi_+ - 2 bpsi_- dot partial_+ bpsi_-
  $ <eq:fermion-lc>
  where we used in the second step that since the $bpsi$ are Majorana spinors, we have
  $ macron(bpsi)^mu = bpsi^dagger gamma^0 = bpsi^"T" gamma^0 = (bpsi_+, bpsi_-) mat(0, 1; -1, 0) = (-bpsi_-, bpsi_+). $ <eq:majorana-conj>
  Inserting eqs. @eq:boson-lc and @eq:fermion-lc into eq. @eq:rns, we obtain the RNS action in lightcone coordinates,
  $
    S_"RNS" [bX, bpsi] & = -1/(16 pi) integral_Sigma (1/2 dif xi^+ dif xi^-) [2/alpha' (-4 partial_+ bX dot partial_- bX) + 2 i (-2 bpsi_+ dot partial_- bpsi_+ - 2 bpsi_- dot partial_+ bpsi_-)] \
    & = 1/(8 pi) integral_Sigma dif xi^+ dif xi^- [2/alpha' partial_+ bX dot partial_- bX + i (bpsi_+ dot partial_- bpsi_+ + bpsi_- dot partial_+ bpsi_-)],
  $ <eq:rns-lc>
  #note[Bosons and fermions have mass dimensions $[X] = -1$ and $[psi] = 1/2$, respectively, explaining the relative factor of $1/alpha'$. Also, the objects $bpsi_plus.minus$ are Majorana-Weyl spinors, meaning they are both real and chiral, where chiral in this case refers to having a definite eigenvalue of $plus.minus 1$ w.r.t. the operator $gamma equiv gamma^0 gamma^1$. Such Majorana-Weyl spinors exist only in $2 mod 8$ dimensions.]
  Since to obtain the RNS action @eq:rns, we simply added the canonical kinetic term for Majorana fermions to that of the free boson, the bosonic e.o.m. remains unchanged,
  $ (delta S_"RNS")/(delta bX) = -1/(2 pi alpha') partial_+ partial_- bX limits(=)^! 0. $ <eq:boson-eom>
  On-shell fermions, on the other hand, are governed by the Dirac equation $gamma^a partial_a bpsi = 0$, which i.t.o. of the Majorana-Weyl spinors reads,
  $ (delta S_"RNS")/(delta bpsi_+) = i/(4 pi) partial_- bpsi_+ limits(=)^! 0, wide (delta S_"RNS")/(delta bpsi_-) = i/(4 pi) partial_+ bpsi_- limits(=)^! 0, $ <eq:fermion-eom>
  Thus the $bpsi_plus.minus$ are chiral also in the sense that they are functions of $xi^plus.minus$ only.

  We now have all the tools to show that the RNS action is invariant under the combined transformation of eqs. @eq:susy-x and @eq:susy-psi. Broken into chiral and antichiral components, these read
  $ delta bX = i sqrt(alpha'/2) macron(eps) bpsi eqby("eq:majorana-conj") i sqrt(alpha'/2) (-eps_-, eps_+) vec(bpsi_+, bpsi_-) = i sqrt(alpha'/2) (eps_+ bpsi_- - eps_- bpsi_+), $ <eq:delta-x>
  $
    delta bpsi & = vec(delta bpsi_+, delta bpsi_-) = 1/2 sqrt(2/alpha') gamma^a partial_a bX eps = 1/2 sqrt(2/alpha') (gamma^0 partial_tau + gamma^1 partial_sigma) bX vec(eps_+, eps_-) \
    & = 1/2 sqrt(2/alpha') [mat(0, 1; -1, 0) partial_tau + mat(0, 1; 1, 0) partial_sigma] bX vec(eps_+, eps_-) = sqrt(2/alpha') vec(+eps_- partial_+ bX, -eps_+ partial_- bX).
  $ <eq:delta-psi>
  Before inserting these into the action @eq:rns-lc, we spell out the chirality condition $gamma^b gamma^a partial_b eps(xi) = 0$ in components,
  $ gamma^b gamma^0 partial_b eps = (underbrace(gamma^0 gamma^0, -mat(1, 0; 0, 1)) partial_tau + underbrace(gamma^1 gamma^0, mat(-1, 0; 0, 1)) partial_sigma) eps = -mat(partial_tau + partial_sigma, 0; 0, partial_tau - partial_sigma) vec(eps_+, eps_-) = -2 vec(partial_+ eps_+, partial_- eps_-) = 0, $ <eq:chirality>
  i.e. $eps_plus.minus$ depends only on $xi^minus.plus$. To first order in $eps$ and after integrating by parts (dropping boundary terms), the bosonic part of the action changes by
  $ delta S_"B" = 1/(4 pi alpha') integral_Sigma dif xi^+ dif xi^- (partial_+ delta bX dot partial_- bX + partial_+ bX dot partial_- delta bX) = -1/(2 pi alpha') integral_Sigma dif xi^+ dif xi^- delta bX dot partial_+ partial_- bX. $ <eq:boson-variation>
  For the anticommuting fermions, an integration by parts gives $integral bpsi_+ dot partial_- delta bpsi_+ = -integral partial_- bpsi_+ dot delta bpsi_+ = integral delta bpsi_+ dot partial_- bpsi_+$ (likewise for $bpsi_-$), so that
  $
    delta S_"F" & = i/(4 pi) integral_Sigma dif xi^+ dif xi^- (delta bpsi_+ dot partial_- bpsi_+ + delta bpsi_- dot partial_+ bpsi_-) \
    & eqby("eq:delta-psi") i/(4 pi) sqrt(2/alpha') integral_Sigma dif xi^+ dif xi^- (eps_- partial_+ bX dot partial_- bpsi_+ - eps_+ partial_- bX dot partial_+ bpsi_-) \
    & = i/(4 pi) sqrt(2/alpha') integral_Sigma dif xi^+ dif xi^- (eps_+ bpsi_- - eps_- bpsi_+) dot partial_+ partial_- bX eqby("eq:delta-x") 1/(2 pi alpha') integral_Sigma dif xi^+ dif xi^- delta bX dot partial_+ partial_- bX,
  $ <eq:fermion-variation>
  where in the last line we integrated by parts once more and used the chirality condition @eq:chirality, $partial_- eps_- = partial_+ eps_+ = 0$, so that no derivatives of $eps$ appear.

  Adding eqs. @eq:boson-variation and @eq:fermion-variation, the two variations cancel exactly, $delta S_"RNS" = delta S_"B" + delta S_"F" = 0$. The complete action thus indeed features supersymmetry,
  $ S_"RNS" limits(-->)^(#tag("eq:susy-x"))_(#tag("eq:susy-psi")) S'_"RNS" = S_"RNS". $
  (We did not even need the equations of motion @eq:boson-eom and @eq:fermion-eom; the chirality condition alone suffices.)

+ The boundary conditions stated in eq. @eq:boundary are those of the closed string. This is intuitively clear: If the string is closed then the points $sigma = 0$ and $sigma = l$ are exactly the same, hence the string field evaluated at this point must be the same too.

  If the fermionic string is closed, i.e. periodic in $sigma$ with period $l$, then it obviously has to fulfill
  $ bpsi_plus.minus (sigma) limits(=)^! bpsi_plus.minus (sigma + l). $
  This is not the whole story, however. Since we are dealing with the fermionic string here, which is a worldsheet spinor, it may be that we pick up a minus sign by walking once around the string, $sigma -> sigma + l$,
  $ bpsi_plus.minus (sigma) limits(=)^! plus.minus bpsi_plus.minus (sigma + l). $ <eq:periodicity>
  This is an entirely new possibility that we did not encounter with the bosonic string.

  Looking at eq. @eq:periodicity, it is clear that we now face four possible combinations of boundary conditions, both $bpsi_+$ and $bpsi_-$ can be periodic or antiperiodic, and they each lead to different mode expansions.#footnote[Of course, the two components of the supersymmetry parameter $eps$ have to be chosen such that $delta bX prop macron(eps) bpsi$ is periodic.] Rewriting eq. @eq:periodicity as
  $ bpsi_plus.minus (sigma + l) limits(=)^! e^(2 pi i phi_plus.minus) bpsi_plus.minus (sigma), $
  we define
  - $phi_plus.minus = 0$ as the Ramond sector, and
  - $phi_plus.minus = 1/2$ as the Neveu-Schwarz sector.

  The Ramond sector has strictly periodic boundary conditions and must hence be integer moded with a string expansion of the form
  $ bpsi_plus.minus (xi^plus.minus) = sqrt((2 pi)/l) sum_(n in ZZ) vb(b)_n^plus.minus e^(-(2 pi)/l i n xi^plus.minus). $
  The Neveu-Schwarz sector is antiperiodic which leads to a half-integer moded string expansion,
  $ bpsi_plus.minus (xi^plus.minus) = sqrt((2 pi)/l) sum_(n in ZZ + 1/2) vb(b)_n^plus.minus e^(-(2 pi)/l i n xi^plus.minus). $

+ The following table gives the statistics of each of the four sectors.
  #align(center, table(
    columns: 4,
    stroke: none,
    align: left,
    table.hline(stroke: 0.8pt),
    table.header([$phi_+$], [$phi_-$], [sector], [statistics]),
    table.hline(stroke: 0.5pt),
    [0], [0], [R-R], [bosonic],
    [0], [1/2], [R-NS], [fermionic],
    [1/2], [0], [NS-R], [fermionic],
    [1/2], [1/2], [NS-NS], [bosonic],
    table.hline(stroke: 0.8pt),
  ))
  In the RNS formalism, the NS sector gives spacetime bosons and the R sector spacetime fermions. Note that the R-R sector is thus doubly fermionic, which results in overall bosonic statistics.

= Operator Product Expansion

#task[
  Consider a conformal field theory with free fields $psi$ in two dimensions with a chiral dependence on $z$ and an energy-momentum tensor $T(z) = alpha NO[psi(z) partial_z psi(z)]$, with $alpha in RR$. \
  The two-point function is given by
  $ ev(psi(z) psi(w)) = kappa/(z - w), #h(3em) kappa in RR. $
  #set enum(numbering: "a)")
  + Use Wick's theorem to show that for an appropriate $alpha kappa$, the OPE $T(z) psi(w)$ is given by
    $ cal(R)[T(z) psi(w)] = (h psi(w))/(z - w)^2 + (partial_w psi(w))/(z - w) + "(terms non-singular at" z = w")" $ <eq:ope>
    and determine the constant $h$.
  + What is the conformal dimension of $psi$? Is $psi$ a primary or a quasi-primary field?
  + How does $psi$ transform under $z -> f(z)$, where $f$ is a conformal transformation?
]

+ Since $ev(psi(w) psi(z)) = kappa/(w - z) = -ev(psi(z) psi(w))$, the field $psi$ is fermionic (anticommuting). By Wick's theorem, we have
  $
    cal(R)[T(z) psi(w)] & = alpha cal(R)[NO[psi(z) partial_z psi(z)] psi(w)] \
    & limits(=)^"W.T." alpha [underbrace(NO[psi(z) partial_z psi(z) psi(w)], "non-singular at" z = w) - underbrace(ev(psi(z) psi(w)), kappa/(z - w)) underbrace(partial_z psi(z), partial_w psi(w) + cal(O)(z - w)) + underbrace(ev(partial_z psi(z) psi(w)), -kappa/(z - w)^2) underbrace(psi(z), psi(w) + partial_w psi(w) (z - w) + cal(O)[(z - w)^2])] \
    & = -alpha kappa psi(w)/(z - w)^2 - 2 alpha kappa (partial_w psi(w))/(z - w) + "(terms non-singular at" z = w"),"
  $ <eq:wick>
  where the minus sign in front of the first contraction arises from anticommuting $psi(w)$ past $partial_z psi(z)$, and the self-contraction $ev(NO[psi(z) partial_z psi(z)]) = 0$ vanishes by normal ordering. Thus for $alpha kappa = -1/2$, we reproduce eq. @eq:ope, which makes $h = 1/2$.

+ As we just derived in eq. @eq:wick, $psi$ has conformal dimension $h = 1/2$. Equation @eq:wick also identifies $psi(w)$ as a (chiral) primary since only primaries feature a product expansion of this form with the energy-momentum tensor. (This is the free Majorana-Weyl fermion of the RNS superstring.)

+ Under a conformal transformation $z -> f(z)$, the primary $psi(z)$ transforms as
  $ psi(z) -> psi'(z') = ((partial f(z))/(partial z))^(-1/2) psi(z). $

= Bosonic string in $D = 26$ dimensions

#task[
  Assume a lightcone-gauged open string with
  $ lr(#block[NN \ DD \ ND \ DN] }) "boundary conditions in dimensions" cases({X^+, X^-, X^i | i in I} quad & "with" |I| = n_"NN"\,, {X^j | j in J} & "with" |J| = n_"DD"\,, {X^k | k in K} & "with" |K| = n_"ND"\,, {X^l | l in L} & "with" |L| = n_"DN"\,) $
  and
  $ L_m equiv 1/2 sum_(n=-infinity)^infinity NO(ba_(m-n) dot ba_n). $
  #set enum(numbering: "a)")
  + Show that
    $ L_0 = 1/2 ba_0^2 + sum_(n=1)^infinity ba_(-n) dot ba_n. $
  + Use the physical state condition to show that the mass condition is given by
    $ M^2 = 1/alpha' (N_"NN" + N_"DD" + N_"ND" + N_"DN" - a) + T^2 sum_(j in J) (x_l^j - x_0^j)^2, $ <eq:mass>
    where $N_(x y)$, $x, y in {N, D}$ are the number operators of subsections, $T = 1/(2 pi alpha')$ is the string tension, and $x_0^j$, $x_l^j$ are the endpoints of the string in DD dimensions. \
    You can use
    $ alpha_0^i = sqrt(2 alpha') p^i, #h(3em) alpha_0^j = 1/sqrt(2 pi^2 alpha') (x_l^j - x_0^j), $ <eq:zero-modes>
    and recall that
    $ a = (n_"NN" + n_"DD")/24 - (n_"ND" + n_"DN")/48 $ <eq:a>
    where $n_(x y)$, $x, y in {N, D}$ are the number of dimensions excluding $X^plus.minus$ with the indexed combination of boundary conditions.

  Consider one space-filling D25-brane, seven D9-branes in dimensions ${0, ..., 9}$ and eleven D17-branes in ${0, ..., 4, 10, ..., 22}$ such that the distance of the orthogonal dimensions between the D9- and D17-branes is different from zero.
  #set enum(numbering: "a)", start: 3)
  + What are the gauge groups living on the D9-/D17-stacks?
  + Find the 7 different types of massless states in the open string spectrum, their Chan-Paton factors and the representation of the abelian brane gauge group transformation.
]

+ Normal ordering is defined as
  $ NO(alpha_m^mu alpha_n^nu) = cases(alpha_m^mu alpha_n^nu quad & "for" m <= n\,, alpha_n^nu alpha_m^mu & "for" n < m.) $
  We can therefore rewrite the level-zero Virasoro generator as follows,
  $
    L_0 & = 1/2 ba_0^2 + 1/2 sum_(n=-infinity)^(-1) NO(ba_(-n) dot ba_n) + 1/2 sum_(n=1)^infinity NO(ba_(-n) dot ba_n) \
        & = 1/2 ba_0^2 + 1/2 sum_(n=-infinity)^(-1) ba_n dot ba_(-n) + 1/2 sum_(n=1)^infinity ba_(-n) dot ba_n \
        & = 1/2 ba_0^2 + sum_(n=1)^infinity ba_(-n) dot ba_n.
  $
+ The mass shell#footnote[Note that the word shell is important here since eq. @eq:mass only holds on-shell, i.e. upon use of the equations of motion of the worldsheet metric $h^(a b)$.] condition @eq:mass is a result of the Virasoro constraints#footnote[In the open string sector, no $tilde(L)_m$ appears since left- and right-moving oscillations on the string are reflected into each other at the endpoints by the boundary conditions.]
  $ L_m limits(=)^! 0, #h(3em) forall m in ZZ. $ <eq:virasoro>
  #note[The Virasoro constraints in turn followed from the fact that the Virasoro generators are precisely the Fourier modes of the energy-momentum tensor $T_(a b)$ and it, due to its definition
    $ T_(a b) equiv (4 pi)/sqrt(-h) (delta SP)/(delta h^(a b)) limits(=)^! 0, $
    must vanish on-shell after use of Hamilton's principle.]
  Equation @eq:virasoro is a classical expression. When moving to the quantized theory, it must be implemented as the operator equation
  $ (L_m - a delta_(m,0)) ket(phi) = 0, #h(3em) forall m >= 0 and ket(phi) in cal(H)_"phys", $ <eq:physical-state>
  where $cal(H)_"phys"$ denotes the Hilbert space of physical quantum states. Indeed, $(L_m - a delta_(m,0)) ket(phi) = 0$ implies $bra(phi) (L_m - a delta_(m,0)) ket(phi) = 0 thick forall m in ZZ$.

  To derive the mass shell condition from eq. @eq:physical-state, we are interested in the $m = 0$-case, $(L_0 - a) ket(phi) = 0$. Recalling our result from part a), we can rewrite $L_0$ as
  $
    L_0 & = 1/2 ba_0^2 + sum_(n > 0)^infinity ba_(-n) dot ba_n eqby("eq:zero-modes") 1/2 (2 alpha' sum_(i in I) (p^i)^2 + sum_(j in J) (x_l^j - x_0^j)^2/(2 pi^2 alpha')) \
    & quad + sum_(n=1)^infinity (sum_(i in I) alpha_(-n)^i alpha_n^i + sum_(j in J) alpha_(-n)^j alpha_n^j) + sum_(n in NN_0 + 1/2) (sum_(k in K) alpha_(-n)^k alpha_n^k + sum_(l in L) alpha_(-n)^l alpha_n^l) \
    & = alpha' vb(p)^2 + T/(2 pi) sum_(j in J) (x_l^j - x_0^j)^2 + N_"NN" + N_"DD" + N_"ND" + N_"DN".
  $
  By solving the level-zero constraint $(L_0 - a) ket(phi) = 0$ for the invariant mass $M^2 = -vb(p)^2$, we get
  $
    (L_0 - a) ket(phi) & = (-alpha' M^2 + T/(2 pi) sum_(j in J) (x_l^j - x_0^j)^2 + N_"NN" + N_"DD" + N_"ND" + N_"DN" - a) ket(phi) limits(=)^! 0, \
    => quad M^2 & = 1/alpha' (N_"NN" + N_"DD" + N_"ND" + N_"DN" - a) + T^2 sum_(j in J) (x_l^j - x_0^j)^2.
  $
+ The permeation of space by the above mentioned arrangement of D-branes may be visualised with the following table.
  #brane-table(
    ("D25", 1, range(26)),
    ("D9", 7, range(10)),
    ("D17", 11, range(5) + range(10, 23)),
  )
  Since a stack of $N$ coincident D-branes hosts a $U(N)$ gauge theory, the gauge group living on the D9-stack is a $U(7)$, whereas the D17-stack carries a $U(11)$.
+ There are three different types of D-branes present and each open string has two ends, hence there are a total of $3 dot 3 = 9$ combinations of boundary conditions possible. Each combination has its own set of string states. Which ones are massless depends on
  #set enum(numbering: "1.")
  + the set's normal ordering constant $a$ given by eq. @eq:a, which can be rewritten as
    $ a = overbrace(n_"NN" + n_"DD" + n_"ND" + n_"DN", D - 2)/24 - (n_"ND" + n_"DN")/16 = 1 - (n_"ND" + n_"DN")/16, $ <eq:a-rewritten>
  + the state's excitation level $n in NN_0$, i.e. its eigenvalue w.r.t. the number operator $N$, and
  + the separation of branes $Delta x^j = x_l^j - x_0^j$ in Dirichlet dimensions.

  Let's consider each combination of boundary conditions in turn.
  #case[1.][
    *D25-D25 strings* have Neumann boundary conditions in all dimensions, hence $a = 1$ and the mass is zero if
    $ M^2 ket(phi) = 1/alpha' (N_"NN" - 1) ket(phi) limits(=)^! 0, wide "i.e. for" quad N_"NN" ket(phi) = ket(phi). $ <eq:d25-mass>
    Any state fulfilling eq. @eq:d25-mass must be of the form
    $ ket(phi) = sum_(i=1)^24 A_i alpha_(-1)^i ket(0\, vb(p)), $ <eq:d25-state>
    where we did not have to write any Chan-Paton factors because the D25 is a solitary brane. The $A_i$ form a gauge field, i.e. a massless transverse vector that transforms in the fundamental representation of $S O(24)$.#footnote[Note that $S O(24)$ is not brane gauge group here but one living in regular spacetime. Hence the transformation behavior we stated refers to how the $A_i$ transform as a spacetime vector.]
  ]
  #case[2. & 3.][
    *D9-D9 strings* have
    - Neumann boundary conditions in dimensions $X^plus.minus = 1/sqrt(2) (X^0 plus.minus X^1)$ and $X^i$, $i in I = {2, 3, ..., 9}$, and
    - Dirichlet boundary conditions in dimensions $X^j$, $j in J = {10, 11, ..., 25}$.

    Since $n_"ND" = n_"DN" = 0$, we still have $a = 1$. The branes are all coincident, $Delta x^j = 0$, so there is no mass contribution from tension. The mass vanishes if
    $ M^2 ket(phi) = 1/alpha' (N_"NN" + N_"DD" - 1) ket(phi) limits(=)^! 0. $
    There are two possibilities here. Since $N_"NN"$ and $N_"DD"$ take eigenvalues in $NN_0$, we have either one excitation parallel or one orthogonal to the branes. The corresponding state with Chan-Paton factors $r$, $s$ can be written as
    $ ket(phi) = sum_(r,s=1)^7 (sum_(i=2)^9 bA_i^(r s) alpha_(-1)^i + sum_(j=10)^25 bphi_j^(r s) alpha_(-1)^j) ket(0\, vb(p)\, r s), $ <eq:d9-state>
    where the parallel excitations $bA_i^(r s)$ form a set of $7^2 = 49$ massless vector bosons ($i$ is the vector index) that transform under the adjoint representation of the $U(7)$ gauge group hosted by the coincident D9-branes.#footnote[Note that the $bA_i^(r s)$ now serve two purposes: Just like in eq. @eq:d25-state, they still form a spacetime vector. In addition, they are also $N^2$ $N times N$-matrices (which we indicate by using boldface), one for every combination of Chan-Paton factors $r$ and $s$. These matrices span the Lie algebra of the $U(N)$ gauge group brought into being by the coincident branes. In our case, $N = 7$ due to the 7 coincident D9 branes.] The orthogonal excitations $bphi_j^(r s)$ form 49 sets of $n_"DD" = 16$ scalars each (since $j in {10, ..., 25}$) that transform under the adjoint of $U(7)$. These are the Goldstone bosons associated with spontaneous breaking of the 26-dimensional Poincaré symmetry by the D9-branes.
  ]
  #case[4. & 5.][
    *D17-D17 strings* have
    - Neumann boundary conditions in dimensions $X^plus.minus$ and $X^i$, $i in I = {2, 3, 4, 10, 11, ..., 22}$, and
    - Dirichlet boundary conditions in dimensions $X^j$, $j in J = {5, 6, 7, 8, 9, 23, 24, 25}$.

    Also, $a = 1$ and $Delta x^j = 0$. The mass again vanishes if
    $ M^2 ket(phi) = 1/alpha' (N_"NN" + N_"DD" - 1) ket(phi) limits(=)^! 0, $
    so the state can be written in the same way as eq. @eq:d9-state with some slight modifications,
    $ ket(phi) = sum_(r,s=1)^11 (sum_(i in I) bA_i^(r s) alpha_(-1)^i + sum_(j in J) bphi_j^(r s) alpha_(-1)^j) ket(0\, vb(p)\, r s). $
    The $bA_i^(r s)$ now form a set of $11^2 = 121$ massless vector bosons that transform in the adjoint representation of the $U(11)$ gauge group living on the coincident D17-branes. The orthogonal excitations $bphi_j^(r s)$ form 121 sets of $n_"DD" = 8$ scalars each that transform under the adjoint representation of $U(11)$.
  ]
  #case[6.][
    *D25-D9 (D9-D25) strings* have
    - Neumann boundary conditions in dimensions $X^plus.minus$ and $X^i$, $i in I = {2, 3, ..., 9}$, and
    - mixed Neumann-Dirichlet (Dirichlet-Neumann) boundary conditions in dimensions $X^(k(l))$, $k(l) in K(L) = {10, 11, ..., 25}$.

    Inserting $n_"ND" + n_"DN" = 16$ into eq. @eq:a-rewritten, we get a normal ordering constant of $a = 1 - 16/16 = 0$. Without DD dimensions, there is no tension contribution, so the mass $M^2 = N/alpha'$ vanishes already for the ground state,
    $ ket(phi) = sum_(r(s)=1)^7 lambda^(r(s)) ket(0\, vb(p)\, r(s)). $
    Since only one end of the string sits on the D9-stack, the state carries a single Chan-Paton factor. These massless scalars transform in the (anti-)fundamental representation of $U(7)$ and are charged under the $U(1)$ of the D25-brane.
  ]
  #case[7.][
    *D25-D17 (D17-D25) strings* have
    - Neumann boundary conditions in dimensions $X^plus.minus$ and $X^i$, $i in I = {2, 3, 4, 10, 11, ..., 22}$, and
    - mixed Neumann-Dirichlet (Dirichlet-Neumann) boundary conditions in dimensions $X^(k(l))$, $k(l) in K(L) = {5, 6, 7, 8, 9, 23, 24, 25}$.

    Inserting $n_"ND" + n_"DN" = 8$ into eq. @eq:a-rewritten, we get a normal ordering constant of $a = 1 - 8/16 = 1/2$. The ground state is thus tachyonic, but the first half-integer excitation in an ND (DN) direction, $N = 1/2$, is massless,
    $ ket(phi) = sum_(r(s)=1)^11 sum_(k(l) in K(L)) psi_(k(l))^(r(s)) alpha_(-1/2)^(k(l)) ket(0\, vb(p)\, r(s)). $
    These are $n_"ND" = 8$ massless scalars in the (anti-)fundamental representation of $U(11)$, again charged under the $U(1)$ of the D25-brane.
  ]
  #case[–][
    *D9-D17 (D17-D9) strings* have
    - Neumann boundary conditions in dimensions $X^plus.minus$ and $X^i$, $i in I = {2, 3, 4}$,
    - Dirichlet boundary conditions in dimensions $X^j$, $j in J = {23, 24, 25}$, and
    - mixed boundary conditions in the $n_"ND" + n_"DN" = 5 + 13 = 18$ dimensions $X^5, ..., X^22$.

    This gives a normal ordering constant of $a = 1 - 18/16 = -1/8$, so that
    $ M^2 = 1/alpha' (N_"NN" + N_"DD" + N_"ND" + N_"DN" + 1/8) + T^2 sum_(j in J) (Delta x^j)^2 > 0. $
    Since all terms are non-negative and the stretching contribution is non-zero, there are no massless states in this sector. The lightest states are massive and transform in the (anti-)bifundamental representation of $U(7) times U(11)$.
  ]

= Scattering Amplitude for the Bosonic String

#task[
  #set enum(numbering: "a)")
  + State the worldsheet topology for the vacuum diagram of the oriented open and closed strings at tree- and one-loop-level. Name their corresponding Euler characteristics, too.
  + The S-matrix describing the scattering of $n$ string states can be written as
    $ S_(j_1, ..., j_n) (k_1, ..., k_n) = sum_("compact" \ "topologies") (integral cal(D) X integral cal(D) h)/"Vol"_("Diff" times "Weyl") e^(-SP - lambda chi) product_(i=1)^n V_(j_i) (k_i) $ <eq:s-matrix>
    Briefly describe the purpose of each term.
  + Which mechanisms protect oriented closed and open strings from UV divergences in the one-loop vacuum amplitudes?
]

+ When calculating scattering amplitudes via the path integral, we must sum over all possible worldsheet topologies. To characterize the types of worldsheets that have to be considered at each level of its perturbative expansion, string theory makes use of the following theorem:
  #note(label: [Theorem:])[Every compact, connected, oriented two-dimensional manifold is topologically equivalent to a sphere with $g$ handles ($g$ for genus) and $b$ boundaries. A topological invariant of two-dimensional oriented surfaces is the Euler characteristic $chi = 2 - 2 g - b$.]
  What this boils down to is that we can obtain the topological characteristics of higher and higher loop-level worldsheet topologies by successively increasing in one-step increments the number of handles $g$ in case of the closed string and the number of boundaries $b$ for the open sector. We thus get the following topologies for the vacuum diagram of the two sectors up to one-loop level:
  #align(center, table(
    columns: 5,
    stroke: none,
    align: (left + horizon, left, left, left, left),
    inset: (x: 6pt, y: 2pt),
    table.hline(stroke: 0.8pt),
    table.header([sector], [order], [topology], [$(g, b)$], [Euler char.]),
    table.hline(stroke: 0.5pt),
    table.cell(rowspan: 2)[open string], [tree-level], [disk $bb(D)^2$], [$(0, 1)$], [$chi = 1$],
    [one-loop], [cylinder $bb(C)^2$], [$(0, 2)$], [$chi = 0$],
    table.cell(rowspan: 2)[closed string], [tree-level], [sphere $bb(S)^2$], [$(0, 0)$], [$chi = 2$],
    [one-loop], [torus $bb(T)^2$], [$(1, 0)$], [$chi = 0$],
    table.hline(stroke: 0.8pt),
  ))
  #block(breakable: false)[
    #align(center)[*Tree-level and one-loop vacuum amplitude*]
    #ws-topologies(length: 0.8cm)
  ]
+ We will briefly explain what each of the operations in eq. @eq:s-matrix are for.
  - The sum over compact worldsheet topologies serves the purpose of incorporating contributions to a given scattering process at all loop levels.#footnote[While eq. @eq:s-matrix is formally exact, the practical need to truncate the sum over topologies means we end up with only a perturbative approximation.]
  - The path integrals $integral cal(D) X integral cal(D) h$ take into account all possible intermediate configurations that converge for $tau -> minus.plus infinity$ to the specified asymptotic in- and outgoing states of both the string field $X^mu (tau, sigma)$ and the worldsheet metric $h^(a b) (tau, sigma)$.#footnote[$h^(a b) (tau, sigma)$ describes the exact shape and curvature of the worldsheet for a given topology.]
  - The denominator $"Vol"_("Diff" times "Weyl")$ is required to avoid the standard problem in the path integral quantization of gauge theories, i.e. overcounting of gauge equivalent configurations. The solution is always to factorize the path integral into an integral over physical degrees of freedom and over the gauge parameters. The latter can then be cancelled by dividing by the volume of the gauge group. In the case at hand, this can be achieved by converting the integral over all worldsheet metrics into an integral over all diffeomorphisms $eps^a (tau, sigma)$ and Weyl rescalings $Lambda(tau, sigma)$ that take us to the gauge transformed $h'$ starting from some fixed reference metric $hat(h)$.
  - $e^(-SP - lambda chi)$ is a weighting factor. The first part $e^(-SP)$ weighs string and worldsheet configurations to ensure that configurations that are more likely to occur have a higher contribution to the path integral. $e^(-lambda chi)$ on the other hand contains the aforementioned Euler characteristic $chi$. Unlike the Polyakov action $SP [X]$, it has no dynamics of its own but merely serves to weigh the contribution of different worldsheets to the overall S-matrix.
  - Finally, the product of vertex operators $product_(i=1)^n V_(j_i) (k_i)$ serves to specify the in and out states, i.e. what type and number of particles are inserted at $tau = -infinity$ and what we want to end up with at $tau = infinity$. This is the only part of the S-matrix that actually contains information about what type of scattering process we are looking at.
+ In point particle theories the sharp localization of the interaction vertex is responsible for the appearance of divergent amplitudes. In string theory, no localized vertices are present. Instead, interactions are mediated via the global worldsheet topology.

  More specifically, at the one-loop level, string theory's ultraviolet behavior benefits from a feature called *modular invariance*, which on the torus is invariance under $P S L(2, ZZ)$ transformations $tau -> (a tau + b)/(c tau + d)$ of the modular parameter $tau$. Restricting the moduli integral to the fundamental domain excludes the region $tau -> 0$ of short worldsheet tori that would correspond to the UV divergence of analogous point particle theories, so modular invariance acts as an intrinsic ultraviolet cutoff for the closed string. For the open string, the one-loop cylinder amplitude can be reinterpreted via open-closed worldsheet duality as tree-level closed string exchange, so its would-be UV divergence turns into an IR divergence in the dual closed string channel.
