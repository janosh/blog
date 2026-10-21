#import "/notes.typ": note, task, vb, ket, tag, eqby
#import "/string-theory/sheet.typ": NO, sheet
#import "/string-theory/brane-table.typ": brane-table

#show: sheet.with(5, [November 10th, 2015], [November 24th, 2015])

#let (bp, bA, bphi, bpsi, bxi, blam) = ($vb(p)$, $vb(A)$, $vb(phi)$, $vb(psi)$, $vb(xi)$, $vb(lambda)$)
#let vac = $ket(0\, bp)$
#let cvac = $ket(0\, 0\, bp)$
#let GS = $ket("GS")$
#let L1 = $ket("L1")$
#let Nperp = $hat(N)_perp$

= String spectrum on D-branes

#task[
  Consider the following setup of D-branes (all present at the same time) in bosonic string theory
  - one spacetime-filling D25-brane,
  - a stack of five coincident D12-branes along directions $mu in {0, 1, ..., 11, 12}$,
  - a stack of seven coincident D5-branes along directions $mu in {0, 1, 2, 12, 13, 14}$,

  where you should assume an arbitrary separation of the second and third brane stack along the common (DD) directions. Describe the open string spectrum up to the first excited level. The discussion should include an account of the mass of the states, the Chan-Paton factors and the gauge group along the various D-branes. What happens to the gauge group along the second brane as you separate the stack of coincident branes into 5 individual branes at non-zero relative distance?
]

The permeation of space by this arrangement of D-branes may be visualised with the following table which colours dimensions filled by branes (the darker the cell, the higher-dimensional the brane) and gives the kind and number of branes present in each dimension.

#brane-table(
  ("D25", 1, range(26)),
  ("D12", 5, range(13)),
  ("D5", 7, (0, 1, 2, 12, 13, 14)),
)

We will describe the complete open string spectrum that emerges given the above D-brane constellation up to first excited level by giving all states $ket(phi_i)$, their masses $M_i^2$ and the normal ordering constants $a_i$ for each possible combination of boundary conditions. \
Before getting into close action, however, we need to prepare the necessary machinery.

- The states are the easiest: We simply start from the vacuum and act on it with modes $alpha_i^mu$ corresponding to the excitation level, i.e. $i in {0, 1}$ since we only investigate to first level, and contracted with gauge fields $A_i^mu$ corresponding to the gauge group of the D-brane stack.
- To calculate the mass of a state, the relation
  $ alpha_n^- = 1/(sqrt(2 alpha') p^+) 1/2 sum_(i=1)^(D-2) sum_(m in ZZ) alpha_(n-m)^i alpha_m^i, $ <eq:alpha-minus>
  comes in mighty handy. We proved this statement for the open string subject to pure Neumann boundary conditions in exercise 3 on assignment 4. For brevity, we will perform the following derivation with this limitation and then generalize to mixed boundary conditions at the end. For a metric with signature $(-1, 1, ..., 1)$, we know that $M^2$ equals $-bp^2$. In lightcone gauge, where the metric's components become $eta_(+-) = -1 = eta_(-+)$, $eta_(i j) = delta_(i j)$, $i, j in {1, ..., D - 2}$, $bp^2$ can be written as
  $ M^2 = -bp^2 = 2 p^+ p^- - sum_(i=1)^(D-2) p^i p^i. $ <eq:mass-p>
  Using $alpha_0^mu = sqrt(2 alpha') p^mu$, eq. @eq:mass-p can be rewritten as
  $
    M^2 & = 2/sqrt(2 alpha') p^+ alpha_0^- - 1/(2 alpha') sum_(i=1)^(D-2) alpha_0^i alpha_0^i \
    & eqby("eq:alpha-minus") 1/(2 alpha') sum_(i=1)^(D-2) sum_(m in ZZ) alpha_(-m)^i alpha_m^i - 1/(2 alpha') sum_(i=1)^(D-2) alpha_0^i alpha_0^i \
    & = 1/(2 alpha') sum_(i=1)^(D-2) (sum_(m in ZZ) NO(alpha_(-m)^i alpha_m^i) - 2 a_perp - alpha_0^i alpha_0^i),
  $ <eq:mass-modes>
  where we reintroduced normal ordering and compensate by subtracting the normal ordering constant $a_perp$ in lightcone gauge as it is precisely defined by the sum over the commutator of all transverse modes,
  $ a_perp = -1/2 sum_(i=1)^(D-2) sum_(m < 0) underbrace([alpha_(-m)^i, alpha_m^i], -m eta^(i i) delta_(-m,-m)) = -(D - 2)/2 underbrace(sum_(m > 0) m, zeta(-1) = -1/12) = (D - 2)/24. $ <eq:a-perp>
  Now the normal-ordered sum can be written as
  $ sum_(m in ZZ) NO(alpha_(-m)^i alpha_m^i) = sum_(m < 0) alpha_m^i alpha_(-m)^i + alpha_0^i alpha_0^i + sum_(m > 0) alpha_(-m)^i alpha_m^i = alpha_0^i alpha_0^i + 2 sum_(m > 0) alpha_(-m)^i alpha_m^i. $
  Reinsertion into eq. @eq:mass-modes yields
  $ M^2 = 1/alpha' sum_(i=1)^(D-2) sum_(m > 0) alpha_(-m)^i alpha_m^i - a_perp/alpha' equiv 1/alpha' (N_perp - a_perp), $
  where we defined the number operator in lightcone gauge $N_perp$ which only counts excitations of physical degrees of freedom, i.e. excluding excitations in $X^plus.minus$.
- For a string with Neumann boundary conditions in all dimensions, $N_perp$ takes the simple form as given above, i.e. $N_perp = sum_(i=1)^(D-2) sum_(m > 0) alpha_(-m)^i alpha_m^i$. More generally though, we may have any type of boundary condition in any dimension. If we let the indices $i$, $j$, $k$, and $l$ count each type of boundary, i.e.
  $ lr(#block[NN \ DD \ ND \ DN] }) "boundary conditions in dimensions" cases({X^+, X^-, X^i | i in I} quad & "with" |I| = n_"NN"\,#footnote[$|I|$ denotes the cardinality of the set $I$, i.e. the number of elements in $I$.], {X^j | j in J} & "with" |J| = n_"DD"\,, {X^k | k in K} & "with" |K| = n_"ND"\,, {X^l | l in L} & "with" |L| = n_"DN"\,) $
  then $N_perp$ generalizes straightforwardly to
  $ N_perp = sum_(m in NN) [sum_(i in I) alpha_(-m)^i alpha_m^i + sum_(j in J) alpha_(-m)^j alpha_m^j] + sum_(n in NN_0 + 1/2) [sum_(k in K) alpha_(-n)^k alpha_n^k + sum_(l in L) alpha_(-n)^l alpha_n^l]. $ <eq:n-perp>
- The normal ordering constant needs to be modified as well. We saw in eq. @eq:a-perp that $a_perp$ receives a contribution of $1/24$ for every dimension with NN boundary conditions. The same holds for DD boundary conditions. Due to the string field being half-integer moded in ND and DN dimensions, a careful calculation involving zeta function renormalization shows that each such dimension enters $a_perp$ with a contribution of $-1/48$. Thus altogether, we get
  $
    a_perp & = (n_"NN" + n_"DD")/24 - (n_"ND" + n_"DN")/48 = (n_"NN" + n_"DD" + n_"ND" + n_"DN")/24 - (n_"ND" + n_"DN")/16 \
           & = (D - 2)/24 - (n_"ND" + n_"DN")/16.
  $ <eq:a-general>
- There is one more contribution to the string's mass we need to consider if it is no longer free to move but attached to D-branes: its tension. For every dimension $X^j$, $j in J$ with Dirichlet boundary conditions at both ends, the string's mass receives a contribution that grows linearly with the connected branes' separation $Delta x_j = x_(l,j) - x_(0,j)$. The total string rest mass for an arbitrary constellation of boundary conditions therefore reads
  $ M^2 = 1/alpha' (N_perp - a_perp) + T^2 sum_(j in J) Delta x_j^2, $ <eq:mass>
  where $N_perp$ and $a_perp$ are now the ones from eqs. @eq:n-perp and @eq:a-general, respectively. This formula for $M^2$ incorporates everything: a shifted normal ordering constant, energy stored in strain, and a number operator that includes contributions from NN, DD, ND, and DN dimensions.

We are finally in a position to actually tackle the open string spectrum. Since each string has two ends, there are a total of $3^2 = 9$ different combinations possible with the above three types of D-branes present. We will treat each case in turn (and assume $D = 26$ in the sequel).

#set enum(numbering: "1.")
+ *D25-D25 strings* have NN boundary conditions in all dimensions, meaning $n_"ND" = n_"DN" = 0$ and eq. @eq:a-general gives the familiar result $a_perp = 1$.
  - The *ground state* $GS$ is precisely the vacuum $vac$, defined by the condition $alpha_n^i vac = 0 thick forall n > 0$. Since this implies $N_perp vac = 0$, its mass is just
    $ M^2 vac eqby("eq:mass") -a_perp/alpha' vac = -1/alpha' vac. $ <eq:gs-mass>
    The pure Neumann ground state is thus tachyonic. Its corresponding field transforms as a Lorentz scalar on the brane.#footnote[For brevity, transformational behaviors will not be shown here.] This counts for all the other ground states we will consider as well and will not be reiterated each time.
  - We get *first level excited states* by acting on the ground state with the lowest possible creation operator $alpha_(-1)^i$. Since the string lives on a spacetime-filling D-brane, the index $i$ enumerates all transverse dimensions, $i in I = {1, 2, ..., D - 2}$ resulting in 24 linearly independent excitations $alpha_(-1)^i vac$. A general state at first excited level (L1) is a linear combination of all these basis states:
    $ L1 = sum_(i=1)^(D-2) A_i alpha_(-1)^i vac. $
    Acting with $N_perp$ on any of the basis states gives
    $
      N_perp alpha_(-1)^i vac & = sum_(h in I) sum_(m in NN) alpha_(-m)^h alpha_m^h alpha_(-1)^i vac = alpha_(-1)^i alpha_1^i alpha_(-1)^i vac \
      & = alpha_(-1)^i (alpha_(-1)^i alpha_1^i + underbrace([alpha_1^i, alpha_(-1)^i], eta^(i i) delta_(1,-(-1)))) vac = alpha_(-1)^i vac, #h(3em) ("no sum over" i).
    $ <eq:n-l1>
    Equation @eq:n-l1 also holds for $L1$. This results in states at first excited level carrying a mass of
    $ M^2 L1 = 1/alpha' (N_perp - a_perp) L1 = 1/alpha' (1 - 1) L1 = 0. $ <eq:l1-mass>
    This entire level of the string spectrum is massless. Note further that the vector field $A_mu$ transforms as a $U(1)$ gauge field on the D25 brane. This suggests a remarkable result: The open string spectrum includes photon states! Our entire approach to string theory started from the Polyakov action. It carries absolutely no hint of electromagnetic gauge invariance. Nevertheless, open strings exhibit Maxwellian field excitations. This result is entirely due to the normal ordering mass shift we encountered when passing from the classical to the quantum theory.
+ *D12-D12 strings* have NN boundary conditions along $X^0, X^1, ..., X^12$ and DD boundary conditions along $X^13, X^14, ..., X^25$. Thus, $n_"ND"$ and $n_"DN"$ remain zero and the normal ordering constant is still $a = 1$.

  We face a new problem now: The exercise states that we are dealing with a stack of five coincident D12-branes. String states connected to coincident branes need an extra container of information to remember on which of the multiple overlapping branes a string starts and ends. A general basis of string states therefore needs to incorporate labels for
  #set enum(numbering: "1.")
  + the Fock state $ket(n)$ (where $n$ is just the oscillation number, e.g. 0 in the case of the vacuum),
  + the momentum vector $bp$ (more precisely those components of $bp$ that lie in the NN dimensions; since all dimensions containing even one Dirichlet boundary are fixed at a particular point in space, they necessarily carry zero net momentum), and finally
  + a pair of integers $r$, $s$, the so-called Chan-Paton factors, that run over the $N$ coincident branes.

  Assembling parts 1 to 3, a completely determined basis state would be of the form $ket(n\, bp\, r s)$. To express an arbitrary string state in this basis, we need to linearly combine the basis vectors in a way that is compatible with the group theoretic structure of D-brane stacks. A stack of $N$ coincident branes hosts a $U(N)$ gauge group for which we can construct a representation by introducing $N^2$ Hermitian $N times N$-matrices.#footnote[The fact that coincident branes father extra gauge groups should come as no surprise to us. After all, a gauge symmetry is just a redundancy in our description of the _actual_ physics going on, and exchanging the Chan-Paton factors certainly does not alter anything with regard to the physical position of the string or its spectrum. Hence we are dealing with pure gauge information here.] Using these so-called Chan-Paton matrices $blam^(r s)$, which encode the charge of a string state, an arbitrary state can be expressed as the following linear combination of basis states $ket(0\, bp\, r s)$,
  $ ket(n\, bp\, blam) = sum_(r,s=1)^N blam^(r s) ket(n\, bp\, r s). $ <eq:chan-paton>
  - Employing this notation, the D12-D12 *ground state* can be written as
    $ GS = sum_(r,s=1)^5 blam^(r s) ket(0\, bp\, r s). $
    Of course, the Chan-Paton matrices commute freely with the modes and hence also with the number operator, so we still have $N_perp ket(0\, bp\, r s) = 0$. The ground state's mass thus remains unchanged at
    $ M^2 GS eqby("eq:gs-mass") -1/alpha' GS. $
  - The *first excited state* is given by
    $ L1 = sum_(r,s=1)^5 (sum_(i=2)^12 bA_i^(r s) alpha_(-1)^i + sum_(j=13)^25 bphi_j^(r s) alpha_(-1)^j) ket(0\, bp\, r s), $ <eq:d12-l1>
    and carries zero mass, both for excitations parallel and transverse to the brane,
    $ M_A^2 L1 eqby("eq:l1-mass") 0, #h(3em) M_phi^2 L1 eqby("eq:l1-mass") 0. $
    The parallel excitations $bA_i^(r s)$ are $5^2 = 25$ massless vector bosons that transform as $U(5)$ gauge fields on the coincident D12-branes. The orthogonal excitations $bphi_j^(r s)$ form 25 sets of 13 scalars each (since $j in {13, ..., 25}$) that transform under the adjoint of $U(5)$. These are the Goldstone bosons associated with spontaneous breaking of the 26-dimensional Poincaré invariance by the D12-branes.
+ The *D5-D5 strings* live on 7 coincident branes, have NN boundary conditions in dimensions $X^i$ for $i in I = {0, 1, 2, 12, 13, 14}$ (we build the lightcone directions $X^plus.minus = 1/sqrt(2) (X^0 plus.minus X^1)$ from two of them), and DD boundary conditions else. Since there are still no ND or DN dimensions, the normal ordering constant is $a_perp = 1$.
  - In complete analogy to the D12-D12 string states, the *ground state* is given by
    $ GS = sum_(r,s=1)^7 blam^(r s) ket(0\, bp\, r s), $
    and carries mass $M^2 GS eqby("eq:gs-mass") -1/alpha' GS$. (Bear in mind that the $p^i$ may be nonzero only for $i in I$.)
  - A general state at *first excited level* is of the form
    $ L1 = sum_(r,s=1)^7 (sum_(i in I \\ {0, 1}) bA_i^(r s) alpha_(-1)^i + sum_(j in J) bphi_j^(r s) alpha_(-1)^j) ket(0\, bp\, r s), $ <eq:d5-l1>
    and carries zero mass, $M_A^2 L1 = M_phi^2 L1 eqby("eq:l1-mass") 0$. Again, the vectors $bA_i^(r s)$ describe $U(7)$ gauge fields whereas the $bphi_j^(r s)$ are scalars (49 sets of 20 each) transforming under the adjoint representation of $U(7)$.
+ *D12-D25 (D25-D12) strings* have NN boundary conditions along $X^i$, $i in I = {0, 1, 2, ..., 12}$, and DN (ND) boundary conditions else. Finally, we get a result for $a_perp$ that is different from 1, namely
  $ a_perp = (D - 2)/24 - (n_"ND" + n_"DN")/16 = 1 - 13/16 = 3/16. $
  This automatically means there can be no massless states in this sector.
  - Since only one end of the string attaches to a stack of coincident branes, states are labelled with only one Chan-Paton factor. The *ground state* thus reads
    $ GS = sum_(r(s)=1)^5 blam^(r(s)) ket(0\, bp\, r(s)), $
    with a mass of $M^2 GS = -a_perp/alpha' GS = -3/(16 alpha') GS$.
  - Removing one Chan-Paton factor from eq. @eq:d12-l1 and making the mode operator in the DN (ND) dimensions half-integer, the *first excited level* states read
    $ L1 = sum_(r(s)=1)^5 (sum_(i=2)^12 bA_i^(r(s)) alpha_(-1)^i + sum_(l(k)=13)^25 bpsi_(l(k))^(r(s)) alpha_(-1/2)^(l(k))) ket(0\, bp\, r(s)), $
    and carry a mass of
    $
      M_A^2 L1 & = 1/alpha' (N_perp^A - a_perp) L1 = 1/alpha' (1 - 3/16) L1 = 13/(16 alpha') L1, \
      M_psi^2 L1 & = 1/alpha' (N_perp^psi - a_perp) L1 = 1/alpha' (1/2 - 3/16) L1 = 5/(16 alpha') L1.
    $
    The parallel excitations $A_i^(r(s))$ are massive vector bosons transforming under the (anti-)fundamental representation of $U(5)$.#footnote[The only difference between the fundamental and anti-fundamental vectors is that they are complex conjugates fields, i.e. they have opposite charge.] The orthogonal excitations $psi_(l(k))^(r(s))$ are massive scalars in the (anti-)fundamental representation of $U(5)$.
+ The *D5-D25 (D25-D5) strings* have NN boundary conditions in dimensions $X^i$, $i in I = {0, 1, 2, 12, 13, 14}$, and DN (ND) boundary conditions in $X^(l(k))$, $l(k) in L(K) = {3, 4, ..., 11, 15, 16, ..., 25}$. That makes for a negative normal ordering constant of
  $ a_perp = 1 - 20/16 = -1/4. $
  - As a direct consequence, the *ground state*
    $ GS = sum_(r(s)=1)^7 lambda^(r(s)) ket(0\, bp\, r(s)), $
    is no longer tachyonic,#footnote[It is, of course, still a scalar, though.]
    $ M^2 GS = -a_perp/alpha' GS = 1/(4 alpha') GS. $
  - And just like before, the *first excited level states*
    $ L1 = sum_(r(s)=1)^7 (sum_(i in I \\ {0, 1}) A_i^(r(s)) alpha_(-1)^i + sum_(l(k) in L(K)) psi_(l(k))^(r(s)) alpha_(-1/2)^(l(k))) ket(0\, bp\, r(s)), $
    are all massive,
    $
      M_A^2 L1 & = 1/alpha' (N_perp^A - a_perp) L1 = 1/alpha' (1 + 1/4) L1 = 5/(4 alpha') L1, \
      M_psi^2 L1 & = 1/alpha' (N_perp^psi - a_perp) L1 = 1/alpha' (1/2 + 1/4) L1 = 3/(4 alpha') L1.
    $
    Once again, the $A_i^(r(s))$ are in the (anti-)fundamental and the $psi_(l(k))^(r(s))$ in the fundamental representation of $U(7)$.
+ The *D5-D12 (D12-D5) strings* have
  #set enum(numbering: "i.")
  + NN boundary conditions in dimensions $X^0$, $X^1$, $X^2$, and $X^12$,
  + DD boundary conditions in $X^j$ with $j in J = {15, 16, ..., 25}$,
  + DN (ND) boundary conditions in $X^(l(k))$ with $l(k) in L(K) = {3, 4, ..., 11}$, and
  + ND (DN) boundary conditions in $X^13$, $X^14$.

  This interesting combination of branes yields a normal ordering constant of
  $ a_perp = (D - 2)/24 - (n_"ND" + n_"DN")/16 = 1 - 11/16 = 5/16. $
  - The ground state now carries two Chan-Paton factors. We let $r$ run from 1 to 7 and $s$ from 1 to 5. Then#footnote[Note that $bp$ may be non-zero only for $p^0$, $p^1$, $p^2$, $p^12$. The string field is thus effectively restrained to the intersection $"D5" inter "D12"$.]
    $ GS = sum_(r=1)^7 sum_(s=1)^5 blam^(r s) ket(0\, bp\, r s(s r)). $
    In some dimensions, the string starts and ends on different D-branes with non-zero separation. The mass therefore receives a contribution from tension for the first time,
    $ M^2 GS = (1/alpha' (N_perp - a_perp) + T^2 sum_(j in J) Delta x_j^2) GS = (-5/(16 alpha') + T^2 sum_(j=15)^25 Delta x_j^2) GS $
  - Writing down a state that captures all possible excitations at *first excited level* results in the somewhat unwieldy expression
    $ L1 = sum_(r=1)^7 sum_(s=1)^5 (underbrace(sum_(i in {2, 12}) bA_i^(r s(s r)) alpha_(-1)^i, "NN") + underbrace(sum_(j=15)^25 bphi_j^(r s(s r)) alpha_(-1)^j, "DD") + underbrace(sum_(l(k) in L(K)) bpsi_(l(k))^(r s(s r)) alpha_(-1/2)^(l(k)), "DN (ND)") + underbrace(sum_(k(l) in {13, 14}) bxi_(k(l))^(r s(s r)) alpha_(-1/2)^(k(l)), "ND (DN)")) ket(0\, bp\, r s(s r)). $
    The mass spectrum is
    $ M_A^2 L1 = M_phi^2 L1 = (11/(16 alpha') + T^2 sum_(j=15)^25 Delta x_j^2) L1, $
    $ M_psi^2 L1 = M_xi^2 L1 = (3/(16 alpha') + T^2 sum_(j=15)^25 Delta x_j^2) L1. $
    Quoting the lecture notes (p. 168), the Chan-Paton factors reveal that all excitations transform under the (anti-)bifundamental#footnote[This is an abbreviation for the fundamental $times$ antifundamental (antifundamental $times$ fundamental) representation.] representation of the gauge group $U(5) times U(7)$.

= Orientifolds

#task[
  In the lecture we have so far discussed only the so-called oriented string theory. This means that there is a clear distinction between left- and right-movers for the closed string and between the two endpoints at $sigma = 0$ and $sigma = l$ for the open theory.
  #set enum(numbering: "a)")
  + Show that even after gauge fixing the classical worldsheet action is invariant under the parity transformation
    $ tau -> tau, #h(3em) sigma -> l - sigma. $
  At the quantum level this so-called *orientifold symmetry* is implemented via a unitary operator $Omega$ acting on the string field as
  $ X^mu (tau, sigma) -> Omega^dagger X^mu (tau, sigma) Omega = X^mu (tau, l - sigma). $
  #set enum(numbering: "a)", start: 2)
  + Show that this induces the following action in the modes of the string field
    #align(center, grid(
      columns: 4,
      column-gutter: 1.5em,
      row-gutter: 0.8em,
      align: left,
      [i)], [closed], [$Omega^dagger alpha_(l,n)^mu Omega = alpha_(r,n)^mu$,], [$Omega^dagger alpha_(r,n)^mu Omega = alpha_(l,n)^mu$,],
      [ii)], [open NN], [$Omega^dagger alpha_n^mu Omega = (-1)^n alpha_n^mu$,], [],
      [iii)], [open DD], [$Omega^dagger alpha_n^mu Omega = (-1)^(n+1) alpha_n^mu$,], [$Omega^dagger x_(0\/l) Omega = x_(l\/0)$,],
      [iv)], [open DN], [$Omega^dagger alpha_(n+1/2)^mu Omega = i(-1)^(n+1) alpha_(n+1/2)^mu$.], [],
    ))
  + One can now define the unoriented or orientifolded string theory by keeping only those states in the string spectrum which are invariant under the above orientifold action. In other words, one considers the quotient theory of the original string theory by the $ZZ_2$ action defined in i). To determine this quotient, one needs to know in addition the phase of the action of $Omega$ on the vacuum. This is not fixed uniquely, but constrained by subtle quantum constraints (tadpole cancellation conditions) in the full theory which are beyond our techniques at this stage. In the closed string sector, the consistent phase of $Omega$ acting on the vacuum is $+1$. For the open string it turns out that there are 2 possibilities: $+1$ and $-1$.

    According to this logic, which states does the closed orientifolded string theory contain at the first excited level? For the respective phases $+1$ or $-1$, which excitation levels are kept for open strings ending on a single D-brane in the NN and DD sector?
  + Now consider the open string sector for a stack of $N$ coincident D-branes. Depending on the phase, the orientifold action acts on the vacuum as
    $ Omega ket(0\, bp\, r s) = plus.minus ket(0\, bp\, s r), $
    i.e. the Chan-Paton factors are exchanged. What does this mean for the states kept at the first excited level for the two signs? How many states are kept?

    For group theory experts: Guess the corresponding gauge groups on the D-branes.
]

#set enum(numbering: "a)")
+ After gauge fixing to a flat worldsheet metric, the Polyakov action reduces to a set of $D$ free scalar fields $X^mu$, $mu in {0, ..., D - 1}$,
  $ S_"P" = T/2 integral_Sigma dif tau dif sigma ((partial_tau X)^2 - (partial_sigma X)^2). $
  This integral remains invariant under worldsheet parity,
  $
    S_"P" limits(-->)^(tau -> tau)_(sigma -> l - sigma) S'_"P" & = T/2 integral_(-infinity)^infinity dif tau integral_l^0 (-dif sigma) ((partial_tau X)^2 - (-partial_sigma X)^2) \
    & = T/2 integral_(-infinity)^infinity dif tau integral_0^l dif sigma ((partial_tau X)^2 - (partial_sigma X)^2) = S_"P".
  $
+ Since the Polyakov action is unaffected by worldsheet parity, the same must be true for the string field's equation of motion $(partial_tau^2 - partial_sigma^2) X^mu = 0$ (which it obviously is). But if the e.o.m. is unaltered, then its solution need not be modified either. Therefore, we may impose that the string field's mode expansion remains invariant under worldsheet parity.
  #set enum(numbering: "i)")
  + The closed string mode expansion is very similar to that of the open string as derived in exercise 1 on assignment 3, except that with periodic boundary conditions, left- and right-moving oscillations are not reflected at $sigma = 0$ or $l$. Instead they continuously propagate along the loop of the string without obstruction. To include both left- and right-moving excitations, the mode expansion therefore needs to contain two types of modes $alpha_(l,n)^mu$ and $alpha_(r,n)^mu$,
    $ X_"cl"^mu (tau, sigma) = x_0^mu + (2 pi alpha')/l p^mu tau + i sqrt(alpha'/2) sum_(n != 0) alpha_(l,n)^mu/n e^(-(2 pi i)/l n (tau + sigma)) + alpha_(r,n)^mu/n e^(-(2 pi i)/l n (tau - sigma)). $
    Acting with $Omega$ on $X_"cl"^mu (tau, sigma)$, we get
    $ Omega^dagger X_"cl"^mu (tau, sigma) Omega = x_0^mu + (2 pi alpha')/l p^mu tau + i sqrt(alpha'/2) sum_(n != 0) (Omega^dagger alpha_(l,n)^mu Omega)/n e^(-(2 pi i)/l n (tau + sigma)) + (Omega^dagger alpha_(r,n)^mu Omega)/n e^(-(2 pi i)/l n (tau - sigma)), $ <eq:closed-omega>
    #v(-0.6em)
    #align(center, $||$)
    #v(-0.6em)
    $ X_"cl"^mu (tau, l - sigma) = x_0^mu + (2 pi alpha')/l p^mu tau + i sqrt(alpha'/2) sum_(n != 0) alpha_(l,n)^mu/n e^(-(2 pi i)/l n (tau - sigma)) underbrace(e^(-2 pi i n), 1) + alpha_(r,n)^mu/n e^(-(2 pi i)/l n (tau + sigma)) underbrace(e^(2 pi i n), 1). $ <eq:closed-parity>
    Equations @eq:closed-omega and @eq:closed-parity are equal only if
    $ Omega^dagger alpha_(l,n)^mu Omega = alpha_(r,n)^mu, #h(3em) Omega^dagger alpha_(r,n)^mu Omega = alpha_(l,n)^mu. $ <eq:closed-modes>
  + For the open NN string, $Omega$ acts on the mode expansion as
    $ Omega^dagger X_"NN"^mu (tau, sigma) Omega = x_0^mu + (2 pi alpha')/l p^mu tau + i sqrt(2 alpha') sum_(n != 0) (Omega^dagger alpha_n^mu Omega)/n e^(-(pi i)/l n tau) cos(pi/l n sigma), $
    #v(-0.6em)
    #align(center, $||$)
    #v(-0.6em)
    $ X_"NN"^mu (tau, l - sigma) = x_0^mu + (2 pi alpha')/l p^mu tau + i sqrt(2 alpha') sum_(n != 0) alpha_n^mu/n e^(-(pi i)/l n tau) underbrace(cos(pi n - pi/l n sigma), (-1)^n cos(pi/l n sigma)), $
    where we used $cos(a - b) = sin(a) sin(b) + cos(a) cos(b)$. Invariance under worldsheet parity thus requires
    $ Omega^dagger alpha_n^mu Omega = (-1)^n alpha_n^mu. $ <eq:nn-modes>
  + For the open DD string, $Omega$ acts on the mode expansion as
    $ Omega^dagger X_"DD"^mu (tau, sigma) Omega = x_0^mu + (x_l^mu - x_0^mu) sigma/l + sqrt(2 alpha') sum_(n != 0) (Omega^dagger alpha_n^mu Omega)/n e^(-(pi i)/l n tau) sin(pi/l n sigma), $ <eq:dd-omega>
    #v(-0.6em)
    #align(center, $||$)
    #v(-0.6em)
    $ X_"DD"^mu (tau, l - sigma) = x_0^mu + underbrace((x_l^mu - x_0^mu) (l - sigma)/l, x_l^mu - x_0^mu + (x_0^mu - x_l^mu) sigma/l) + sqrt(2 alpha') sum_(n != 0) alpha_n^mu/n e^(-(pi i)/l n tau) underbrace(sin(pi n - pi/l n sigma), (-1)^(n+1) sin(pi/l n sigma)), $ <eq:dd-parity>
    where we used $sin(a - b) = sin(a) cos(b) - cos(a) sin(b)$. Comparing eqs. @eq:dd-omega and @eq:dd-parity, we conclude
    $ Omega^dagger alpha_n^mu Omega = (-1)^(n+1) alpha_n^mu #h(3em) "and" #h(3em) Omega^dagger x_(0\/l) Omega = x_(l\/0). $ <eq:dd-modes>
  + Since $Omega$ effectively turns the string around, it transforms DN into ND boundary conditions. The effect of $Omega$ on the DN mode expansion is therefore
    $ Omega^dagger X_"DN"^mu (tau, sigma) Omega = x_0^mu + sqrt(2 alpha') sum_(n in ZZ) (Omega^dagger alpha_(n+1/2)^mu Omega)/(n + 1/2) e^(-(pi i)/l (n + 1/2) tau) sin[pi/l (n + 1/2) sigma], $ <eq:dn-omega>
    #v(-0.6em)
    #align(center, $||$)
    #v(-0.6em)
    $ X_"ND"^mu (tau, l - sigma) = x_0^mu + i sqrt(2 alpha') sum_(n in ZZ) alpha_(n+1/2)^mu/(n + 1/2) e^(-(pi i)/l (n + 1/2) tau) underbrace(cos[pi (n + 1/2) - pi/l (n + 1/2) sigma], (-1)^n sin[pi/l (n + 1/2) sigma]), $ <eq:nd-parity>
    where we again used $cos(a - b) = sin(a) sin(b) + cos(a) cos(b)$. For the right hand sides eqs. @eq:dn-omega and @eq:nd-parity to be equal, we need
    $ Omega^dagger alpha_(n+1/2)^mu Omega = i(-1)^n alpha_(n+1/2)^mu. $
    This differs from the phase stated in the exercise by an overall sign, which is fixed only by the sign convention for the ND mode expansion (equivalently the DN expansion derived on assignment 3).
+ Our task is to investigate, which states survive the orientifold projection for both the closed and open string sectors. We will make use of a result derived from tadpole cancellation conditions, namely that the closed string vacuum $cvac$ needs to be orientifold-even whereas the open string vacuum $vac$ may be either even or odd. We proceed by treating each case in turn.
  #set enum(numbering: "1.")
  + As mentioned above, the closed string spectrum contains both left- and right-moving oscillations, travelling in both directions along the string. The spectrum is balanced by the level-matching condition $N_l = N_r$, which enforces an equal number of left- and right-movers in every physical state. Therefore, raising the vacuum $cvac$ with $N_l = N_r = 0$ to the first excited level $N_l = N_r = 1$ already requires acting on it with two modes.

    An expression capturing all $(D - 2)^2 = 576$ linearly independent states with fixed momentum $bp$ at first excited level can thus be written as
    $ bxi ket(1\, 1\, bp) = sum_(i,j=1)^24 xi_(i j) alpha_(l,-1)^i alpha_(r,-1)^j cvac, $ <eq:closed-l1>
    where $xi_(i j)$ are the $(D - 2)^2$ components of the so-called polarization tensor.
    #note[
      Like any square matrix, $xi_(i j)$ can be decomposed into a symmetric and antisymmetric part,
      $ xi_(i j) = 1/2 (xi_(i j) + xi_(j i)) + 1/2 (xi_(i j) - xi_(j i)) equiv S_(i j) + B_(i j). $
      The symmetric part $S_(i j)$ can be broken down further into a symmetric traceless portion and the trace,
      $ S_(i j) = (S_(i j) - (delta^(k l) S_(k l))/(D - 2) delta_(i j)) + (delta^(k l) S_(k l))/(D - 2) delta_(i j) equiv g_(i j) + phi delta_(i j), $
      where summation over $k$ and $l$ is implied. It is easy to check that $g_(i j)$ is indeed traceless,
      $ g^i zws_i = S^i zws_i - (delta^(k l) S_(k l))/(D - 2) underbrace(delta^i zws_i, D - 2) = S^i zws_i - S^l zws_l = 0. $
      All told, the polarization tensor splits into the three parts
      $ xi_(i j) = g_(i j) + B_(i j) + phi delta_(i j), $
      each of which is entirely independent of the other two. These three parts have a very interesting physical interpretation. Firstly, note that since the closed string spectrum is organized into levels according to $M_"cl"^2 = 1/alpha' (N_perp - a_perp)$, where $a_perp = 1$ and $N_perp equiv N_(l\/r)$, all first level states are massless. At this point one might become suspicious when looking at $g_(i j)$. After all, a massless symmetric tensor field sounds rather reminiscent of an object central to general relativity. Indeed, a closer investigation reveals that $g_(i j)$ describes transversely polarised, spin 2, one-particle states. That is why string theory identifies $g_(i j)$ as the *graviton*. The antisymmetric two-tensor $B_(i j)$ is called the Kalb-Ramond field and can be thought of as a generalised (i.e. higher-rank) *gauge potential*. \
      Finally, $phi delta_(i j)$ is just a scaled version of the unit matrix, i.e. has only one degree of freedom. It represents a scalar field and is called the *dilaton*. $phi$ will be of crucial importance in the context of string interactions.
    ]
    Now, going back to our first-excited-level state @eq:closed-l1, we calculate its behavior under worldsheet parity.
    $
      Omega bxi ket(1\, 1\, bp) & = xi_(i j) Omega alpha_(l,-1)^i underbrace(Omega^dagger Omega, bb(1)) alpha_(r,-1)^j underbrace(Omega^dagger Omega, bb(1)) cvac \
      & eqby("eq:closed-modes") xi_(i j) alpha_(r,-1)^i alpha_(l,-1)^j cvac \
      & limits(=)^(i <-> j) xi_(j i) alpha_(l,-1)^i alpha_(r,-1)^j cvac = bxi^T ket(1\, 1\, bp),
    $
    where summation over $i$ and $j$ is implied. Also, we used $Omega$'s unitarity $Omega^dagger = Omega^(-1)$, and the fact that it squares to the identity#footnote[This also implies $(Omega^dagger)^2 = bb(1)$ since $(Omega^dagger)^2 = (Omega Omega)^dagger = bb(1)^dagger = bb(1)$.] $Omega^2 = bb(1)$ to write
    $ Omega alpha_(l,-1)^i Omega^dagger = underbrace((Omega^dagger)^2, bb(1)) Omega alpha_(l,-1)^i Omega^dagger underbrace(Omega^2, bb(1)) = Omega^dagger alpha_(l,-1)^i Omega eqby("eq:closed-modes") alpha_(r,-1)^i. $
    So effectively, $Omega$ flips the indices on the polarization tensor $bxi$. This is fine for both $g_(i j)$ and $phi delta_(i j)$. Since they are symmetric in $i$ and $j$, the orientifold operator acts like the identity on the graviton and dilaton. In the case of $B_(i j)$ however, we pick up a sign,
    $ Omega B_(i j) alpha_(l,-1)^i alpha_(r,-1)^j cvac = -B_(i j) alpha_(l,-1)^i alpha_(r,-1)^j cvac, $
    which makes the Kalb-Ramond field worldsheet-parity-odd. It therefore falls victim to the orientifold projection.
  + Moving on to the open string sector, we consider strings with Neumann boundary conditions in dimensions $X^i$, $i in I$, and ending on a single D-brane, i.e. Dirichlet boundary conditions, in the others, $X^j$, $j in J$. We quote our expression from exercise 1 for a general state of this type,
    $ (bA + bphi) ket(1\, bp) = sum_(i in I) A_i alpha_(-1)^i + sum_(j in J) phi_j alpha_(-1)^j vac. $
    Acting with $Omega$ on excitations parallel to the brane gives
    $
      Omega bA ket(1\, bp) & = A_i underbrace(Omega alpha_(-1)^i Omega^dagger, #tag("eq:nn-modes"): (-1)^(-1) alpha_(-1)^i) underbrace(Omega vac, plus.minus vac) \
      & = minus.plus A_i alpha_(-1)^i vac = minus.plus bA ket(1\, bp)
    $
    Apparently, the one-particle photon excitations $A_i$ are projected out of string theory (survive the orientifold action) if the vacuum has a phase of $+1$ ($-1$).

    For excitations $phi_j$ that are transverse to the brane, we get
    $
      Omega bphi ket(1\, bp) & = phi_j underbrace(Omega alpha_(-1)^j Omega^dagger, #tag("eq:dd-modes"): (-1)^0 alpha_(-1)^j) underbrace(Omega vac, plus.minus vac) \
      & = plus.minus phi_j alpha_(-1)^j vac = plus.minus bphi ket(1\, bp),
    $
    i.e. it is precisely the other way round. The Goldstone bosons associated with spontaneous breaking of the $D$-dimensional Poincaré symmetry carry over to (are missing from) the unoriented theory if the vacuum has a phase of $+1$ ($-1$).
+ For the open strings sector in the presence of $N$ coincident D-branes, the orientifold action acts on the vacuum
  $ Omega ket(0\, bp\, r s) = plus.minus ket(0\, bp\, s r), $
  where the Chan-Paton factors $r$, $s$ swap since $Omega$ reverses the string.

  We express states at the first excited level of this spectrum in terms of a basis of suitable $N times N$-matrices $blam_(r s)$,
  $ ket(n\, bp\, blam) = sum_(r,s=1)^N blam^(r s) ket(n\, bp\, r s). $ <eq:chan-paton-2>
  These are the same Hermitian Chan-Paton matrices we already encountered in eq. @eq:chan-paton of exercise 1. Recall from eq. @eq:nn-modes that the gauge boson excitations $alpha_(-1)^i$ along the branes are orientifold-odd. Looking at eq. @eq:chan-paton-2, it is then clear that in order for the massless gauge bosons $blam^(r s) alpha_(-1)^i ket(0\, bp\, r s)$ to survive the orientifold projection, we need one of the following two combinations of attributes
  $
    & Omega ket(0\, bp\, r s) = +ket(0\, bp\, s r) #h(3em) && + #h(3em) && blam^(r s) = -blam^(s r), \
    "or" #h(3em) & Omega ket(0\, bp\, r s) = -ket(0\, bp\, s r) && + && blam^(r s) = blam^(s r).
  $
  So before orientifolding, we are in the oriented theory with $N$ coincident D-branes hosting a $U(N)$ gauge group. The corresponding algebra is spanned by $N^2$ linearly independent basis states. Of those $N^2$ states, only $N/2 (N - 1)$ or $N/2 (N + 1)$ carry over to the unoriented string theory, depending on whether the vacuum has phase $+1$ or $-1$, respectively.

  As for the change in gauge group precipitated by the orientifold action, we note the following: For strings that are unoriented, the group representations associated with each string end obviously have to be the same. This in particular forces the symmetry group to be one with a _real_ fundamental representation, specifically a (special) orthogonal or symplectic group.#footnote[Symplectic matrices are automatically orientation preserving, i.e. have a determinant of one. Orthogonal matrices can either preserve or reverse orientation, so we really need the special orthogonal matrices.] Since the antisymmetric matrices form the Lie algebra of the orthogonal group (and the $N/2 (N + 1)$-dimensional symmetric case matches the dimension of $S p(N)$), we formulate the following hypothesis:
  $ "For a vacuum phase of" vec(+1, -1, delim: "{") #block[$Omega$ reduces the gauge group of $N$ \ coincident D-branes from $U(N)$ to] cases(S O(N)., S p(N).) $

= Partition function, level density, Hagedorn temperature

#task[
  In this exercise we will estimate the number of states in the tower of string excitations at a given level. Consider the normalized state (for simplicity, we work in the open NN string sector with light-cone quantization),
  $ ket(n_m^i) equiv 1/sqrt(n! m^n) (alpha_(-m)^i)^n ket(0), $
  where $i in {1, ..., D - 2}$ enumerates all transverse dimensions in lightcone gauge, i.e. all except $X^plus.minus = 1/sqrt(2) (X^0 plus.minus X^(D-1))$, $m in NN$ is the oscillation number of modes creating the Fock space from the vacuum, i.e. creators only, and $n in NN_0$ counts the number of excitations by a certain oscillation number $m$. Since the $ket(n_m^i)$ are members of a Fock space, they are also eigenstates of the number operator,
  $ Nperp ket(n_m^i) = m n ket(n_m^i), #h(3em) "where" quad Nperp = sum_(m=1)^infinity sum_(i=1)^24 alpha_(-m)^i alpha_m^i. $
  To find the number of states at a given level, we introduce the *partition function*
  $ Z(q) = "tr"(q^Nperp) equiv product_(m,i) sum_n chevron.l n_m^i|q^Nperp|n_m^i chevron.r. $ <eq:partition>
  Here $q in CC$, $|q| < 1$ is some auxiliary variable.
  #set enum(numbering: "a)")
  + Argue that $Z(q)$ is a generating function for the number $d_N$ of states at level $N$ in the sense that
    $ Z(q) = sum_N d_N q^N $ <eq:generating>
    and that $d_N$ can be computed by the contour integral
    $ d_N = 1/(2 pi i) integral.cont_(|q|=1) dif q thin q^(-N-1) Z(q). $ <eq:contour>
  + Show that
    $ Z(q) = product_(m=1)^infinity (1 - q^m)^(-24). $ <eq:product>
    *Hint:* You may have encountered a similar computation in statistical mechanics.

    *Remark:* $Z(q)$ can be rewritten as
    $ Z(q) = q eta(tau)^(-24), wide eta(tau) = exp((i pi tau)/12) product_(n=1)^infinity (1 - e^(2 pi i n tau)), wide q = e^(2 pi i tau), wide tau in CC, $
    in terms of the famous *Dedekind eta-function*.
  + Now parametrise $q = rho e^(i phi)$ so that
    $ dif q = e^(i phi) dif rho + i rho e^(i phi) dif phi = q/rho dif rho + i q dif phi, $ <eq:dq>
    and pick a contour with constant $rho$ so that $integral.cont_(|q|=rho) dif q = i integral_(-pi)^pi q dif phi$ to argue that
    $ d_N = 1/(2 pi) integral_(-pi)^pi q e^(f(q)) dif phi, #h(3em) f(q) = -(N + 1) ln(q) - 24 sum_(m=1)^infinity ln(1 - q^m). $
    We will now crudely approximate $d_N$ by the so-called *saddle-point approximation*: Suppose there is some $q_0 = rho_0 e^(i phi_0)$ such that $f(q)$ has a sharply peaked maximum in the $phi_0$-direction at $q_0$. Suppose furthermore that the prime contribution to the integral comes from the region around that maximum, i.e. the integral localises around this maximum/saddle point. Under these assumptions argue that we can approximate
    $ d_N approx 1/(2 pi) q_0 e^(f(q_0)) integral_(-pi)^pi dif phi exp(1/2 lr((partial^2 f)/(partial^2 phi) |)_(q_0) phi^2 + i phi), $
    and approximate further
    $ d_N approx 1/sqrt(2 pi) e^(f(q_0))/sqrt(lr((partial^2 f)/(partial^2 q) |)_(q_0)) exp[-(2 q_0^2 lr((partial^2 f)/(partial^2 q) |)_(q_0))^(-1)]. $
  + It turns out that for $N >> 1$ the function $f(q)$ has such a sharp maximum at $q_0 approx 1 - (2 pi)/sqrt(N) = 1 - x$ (i.e. $x << 1$). The simplest way to extract the very crude behaviour of $d_N$ is to approximate
    $ f(q) approx (4 pi^2)/(1 - q) - (N + 1) ln(q), $
    for $q = 1 - x$, $x << 1$. Show this using the series
    $ ln(1 - q) = -sum_(m=1)^infinity q^m/m, #h(3em) sum_(m=1)^infinity 1/m^2 = pi^2/6. $
    Finally deduce that in this primitive approximation
    $ d_N approx N^(-3/4) e^(4 pi sqrt(N)). $
    *Remark:* A more accurate approximation using non-trivial properties of the Dedekind function yields
    $ d_N approx N^(-27/4) e^(4 pi sqrt(N)), $
    which is indeed the correct leading term in the famous Hardy-Ramanujan formula for the asymptotic behaviour of the number of partitions of a large integer $N$.
  + Use the relation $alpha' M^2 = N - 1$, the macroscopic definition of entropy and the thermodynamic relation between entropy and temperature to argue that for high energies there exists a maximum temperature, the Hagedorn temperature $T_"H"$, of the order
    $ k_B T_"H" approx 1/(4 pi sqrt(alpha')). $
    *Note:* The appearance of such a maximum temperature might play an important role in early cosmology and is a consequence of the exponential degeneracy of the string tower at high energy levels.
]

#set enum(numbering: "a)")
+ First, we show that $Z(q) equiv sum_(m,n,i) chevron.l n_m^i|q^Nperp|n_m^i chevron.r$ is equal to $sum_N d_N q^N$. By Taylor expanding $q^Nperp$,
  $ q^Nperp = e^(ln(q) Nperp) = 1 + ln(q) Nperp + 1/2 ln(q)^2 Nperp^2 + 1/3! ln(q)^3 Nperp^3 + ... $
  and inserting into the matrix element in the partition function, we get
  $
    chevron.l n_m^i|q^Nperp|n_m^i chevron.r & = chevron.l n_m^i|1|n_m^i chevron.r + chevron.l n_m^i|ln(q) Nperp|n_m^i chevron.r + 1/2 chevron.l n_m^i|ln(q)^2 Nperp^2|n_m^i chevron.r + ... \
    & limits(=)^#footnote[We used here that the states are normalized to one, $chevron.l n_m^i|n_m^i chevron.r = 1$.] 1 + ln(q) m n + 1/2 ln(q)^2 (m n)^2 + ... \
    & = q^(m n),
  $ <eq:matrix-element>
  and hence $Z(q) = product_(m,i) sum_n q^(m n)$. This expression is already promisingly close to the generating function of $d_N$ that we are after. What we need to do now is count how often $q$ appears in the sum with different combinations of $m$ and $n$ that multiply to give the same exponent $N$. To that end, note that since $N = m n$ is the eigenvalue of the number operator, and it ended up in the exponent of $q$ by summing over all states in the Fock space, it is clear that $q^N$ appears exactly as often as the eigenvalue $N$ in the spectrum, i.e. with the degeneracy $d_N$ of states at level $N$. Therefore,
  $ Z(q) = product_(m,i) sum_n q^(m n) = sum_(N=0)^infinity d_N q^N. $
  #note[
    Out of interest, we want to do some state counting and find out what values $d_N$ actually takes.
    - Start with the case $N = 0$, i.e. $Nperp ket(n_m^i) = 0$. There is only one state that satisfies this equation and that is the vacuum $ket(0)$. Hence, $d_0 = 1$.
    - To get $Nperp ket(n_m^i) = 1 ket(n_m^i)$, we need to excite the vacuum exactly once, i.e. $ket(1_1^i) = alpha_(-1)^i ket(0)$. But it doesn't matter which of the $(D - 2)$ transverse dimensions we choose to excite, i.e. $i$ is random here but summed over in the number operator (and the partition function), so we get a degeneracy of $d_1 = (D - 2) = 24$ at the first excited level.
    - For $Nperp ket(n_m^i) = 2 ket(n_m^i)$, there are now two possibilities,
      $
        ket(1_2^i) & = alpha_(-2)^i ket(0), \
        ket(1_1^i \; 1_1^j) & = ket(1_1^i) times.o ket(1_1^j) = alpha_(-1)^i alpha_(-1)^j ket(0).
      $
      $ket(1_2^i)$ again amounts to a vector of 24 degenerate states. $ket(2_1^i j)$ can by thought of as a $24 times 24 = 576$-dimensional matrix. Note, however, that it doesn't matter here which dimension, $i$ or $j$, we excite first. The resulting state will be the same either way. We are therefore dealing with a symmetric matrix with only $24/2 (24 + 1) = 300$ independent entries. So the second excited level has a degeneracy of $d_2 = 24 + 300 = 324$.
    - A state with $Nperp ket(n_m^i) = 3 ket(n_m^i)$ can be constructed by three distinct mode combinations,
      $
        ket(1_3^i) & = alpha_(-3)^i ket(0), \
        ket(2_1^i \; 1_1^j) & = ket(2_1^i) times.o ket(1_1^j) = alpha_(-2)^i alpha_(-1)^j ket(0), \
        ket(1_1^i \; 1_1^j \; 1_1^k) & = ket(1_1^i) times.o ket(1_1^j) times.o ket(1_1^k) = alpha_(-1)^i alpha_(-1)^j alpha_(-1)^k ket(0).
      $
      $ket(1_3^i)$ gives 24 states. Since the oscillation number of the modes creating $ket(2_1^i \; 1_1^j)$ now differ, this matrix is not symmetric and we get the full $(D - 2)^2 = 576$ states. Finally, $ket(1_1^i \; 1_1^j \; 1_1^k)$ is a three dimensional matrix that is symmetric in all three indices. It therefore gives another $24/6 (24 + 1)(24 + 2) = 2600$ states. All told, the degeneracy of level 3 is $d_3 = 24 + 576 + 2600 = 3200$.

    We could continue indefinitely with this exercise, but it grows increasingly tedious the larger $N$ becomes. In any case, we already have enough information at this point to recognize a pattern. The numbers 1, 24, 324, and 3200 are precisely the first four coefficients in the expansion of $e^(2 pi i tau)/(eta^24 (tau))$, where $eta(tau)$ is number theory's Dedekind eta-function,
    $ e^(2 pi i tau)/(eta^24 (tau)) = 1 + 24 e^(2 pi i tau) + 324 e^(4 pi i tau) + 3200 e^(6 pi i tau) + 25650 e^(8 pi i tau) + ... $
  ]
  Now that we have verified eq. @eq:generating, it is a simple matter to also check eq. @eq:contour.
  $
    1/(2 pi i) integral.cont_(|q|=1) dif q thin q^(-N-1) Z(q) & eqby("eq:generating") 1/(2 pi i) integral.cont_(|q|=1) dif q thin q^(-N-1) sum_(N'=0)^infinity d_(N') q^(N') \
    & = 1/(2 pi i) sum_(N'=0)^infinity d_(N') overbrace(integral.cont_(|q|=1) dif q thin q^(N'-N-1), 2 pi i delta_(N'-N-1,-1)) = sum_(N'=0)^infinity d_(N') delta_(N',N) = d_N.
  $
+ Next we show eq. @eq:product. Finally, an exercise that requires nothing but some honest calculations.
  $ Z(q) eqby("eq:partition") product_(m,i) sum_n chevron.l n_m^i|q^Nperp|n_m^i chevron.r eqby("eq:matrix-element") product_(m,i) sum_n q^(m n) = product_(m,i) 1/(1 - q^m) = product_(m=1)^infinity (1 - q^m)^(-24). $ <eq:z-product>
+ To prepare the contour integral representation @eq:contour of $d_N$ for a saddle-point approximation, we parametrize the auxiliary variable as $q = rho e^(i phi)$ so that the contour integral for some constant $rho != 0$ becomes $integral.cont_(|q|=rho) dif q eqby("eq:dq") i integral_(-pi)^pi q dif phi$.
  $
    d_N & = 1/(2 pi i) integral.cont_(|q|=rho) dif q thin q^(-N-1) Z(q) eqby("eq:z-product") i/(2 pi i) integral_(-pi)^pi q dif phi e^(-(N+1) ln(q)) product_(m=1)^infinity (1 - q^m)^(-24) \
    & = 1/(2 pi) integral_(-pi)^pi q dif phi exp(-(N + 1) ln(q) - 24 sum_(m=1)^infinity ln(1 - q^m)) equiv 1/(2 pi) integral_(-pi)^pi q dif phi e^(f(q)),
  $ <eq:d-n-integral>
  where $f(q) = -(N + 1) ln(q) - 24 sum_(m=1)^infinity ln(1 - q^m)$. \
  Now for the actual saddle-point approximation: We assume there exists a $q_0 = rho_0 e^(i phi_0)$ such that $f(q)$ has a sharp maximum at $rho_0$ in $phi_0$-direction and lay our $phi$-contour at a distance of $rho_0$ from the origin so that we integrate right through this maximum. We further assume that said maximum lies on the real axis, i.e. $phi_0 = 0$ (see part d) of the exercise for confirmation). Then the Taylor expansion of $f(q)$ around $phi = 0$ with $rho$ held constant at $rho_0$ reads
  $ f(q)|_(rho_0) = underbrace(f(rho, phi)|_(rho_0, phi_0), f(q_0)) + underbrace(lr((partial f(rho, phi))/(partial phi) |)_(rho_0, phi_0), "0 at maximum") phi + 1/2 lr((partial^2 f(rho, phi))/(partial^2 phi) |)_(rho_0, phi_0) phi^2 + cal(O)[phi^3], $ <eq:taylor>
  By Inserting eq. @eq:taylor into eq. @eq:d-n-integral and neglecting terms cubic and higher in $phi$, we get
  $ d_N approx 1/(2 pi) integral_(-pi)^pi q dif phi e^(f(q_0) + 1/2 lr((partial^2 f(rho, phi))/(partial^2 phi) |)_(q_0) phi^2) = q_0/(2 pi) e^(f(q_0)) integral_(-pi)^pi dif phi e^(1/2 lr((partial^2 f(rho, phi))/(partial^2 phi) |)_(q_0) phi^2 + i phi), $ <eq:localized>
  where we used that due to integrating along a circle with radius $rho_0$, we have $q = rho_0 e^(i phi) = q_0 e^(i phi)$.

  At this point, a third approximation becomes necessary. Due to $f(q)$'s sharp maximum at $q_0$, the integral @eq:localized localizes around $phi_0$. This allows us to extend the integration bounds without much affecting the result, so we may as well extend them all the way out to $plus.minus infinity$ and solve it as a Gaussian integral using the well-known formula $integral_(-infinity)^infinity exp(-a x^2 + b x + c) dif x = sqrt(pi \/ a) exp(b^2/(4 a) + c)$.
  $ d_N approx q_0/(2 pi) e^(f(q_0)) sqrt(pi/(-1/2 lr((partial^2 f(rho, phi))/(partial^2 phi) |)_(q_0))) exp(i^2/(-4/2 lr((partial^2 f(rho, phi))/(partial^2 phi) |)_(q_0))) = 1/sqrt(2 pi) e^(f(q_0))/sqrt(lr((partial^2 f(q))/(partial^2 q) |)_(q_0)) exp(-1/(2 q_0^2 lr((partial^2 f(q))/(partial^2 q) |)_(q_0))), $ <eq:gaussian>
  where in the last step we used $partial_phi^2 f|_(q_0) = -q_0^2 partial_q^2 f|_(q_0)$, which follows from $partial_phi = i q partial_q$ and $partial_q f|_(q_0) = 0$.
+ The series in $f(q) = -(N + 1) ln(q) - 24 sum_(m=1)^infinity ln(1 - q^m)$ can be *crudely* approximated as
  $ -24 sum_(m=1)^infinity ln(1 - q^m) = 24 sum_(m=1)^infinity sum_(k=1)^infinity (q^m)^k/k approx 24 sum_(m=0)^infinity sum_(k=1)^infinity q^m/k^2 = (24 pi^2)/6 sum_(m=0)^infinity q^m = (4 pi^2)/(1 - q), $ <eq:crude>
  where we used
  $ ln(1 - q^m) = -sum_(k=1)^infinity (q^m)^k/k, #h(3em) "and" #h(3em) sum_(k=1)^infinity 1/k^2 = pi^2/6, $
  in the first and third step, respectively. \
  The exercise asserts that for large $N$, $f(q)$ does indeed have a sharp maximum on the real line approximately at $q_0 approx 1 - (2 pi)/sqrt(N)$. Using this information and our approximate $f(q)$ with eq. @eq:crude inserted, we calculate
  $ e^(f(q_0)) approx e^((4 pi^2)/(1 - q_0) - (N + 1) ln(q_0)) limits(approx)^(q_0 approx 1 - (2 pi)/sqrt(N)) e^(2 pi sqrt(N)) (1 - (2 pi)/sqrt(N))^(-(N+1)) approx e^(4 pi sqrt(N)), $
  where we used that the series expansion of $(1 - (2 pi)/sqrt(N))^(-(N+1))$ at $N -> infinity$ is
  $ (1 - (2 pi)/sqrt(N))^(-(N+1)) = exp(2 pi sqrt(N) + 2 pi^2 + (2 pi)/sqrt(N) + ...). $
  Next, we compute
  $
    lr((partial^2 f(q))/(partial^2 q) |)_(q_0) & approx partial/(partial q) lr([(4 pi^2)/(1 - q)^2 - (N + 1)/q] |)_(q_0) = lr((8 pi^2)/(1 - q)^3 + (N + 1)/q^2 |)_(q_0) \
    & approx (8 pi^2)/((8 pi^3)/N^(3/2)) + (N + 1)/q_0^2 = N^(3/2)/pi + (N + 1)/q_0^2 limits(-->)^(N -> infinity) N^(3/2)/pi,
  $
  in order to see that
  $ exp(-1/(2 q_0^2 lr((partial^2 f(q))/(partial^2 q) |)_(q_0))) approx exp(-1/(2 q_0^2 N^(3/2)/pi + 2(N + 1))) limits(-->)^(N -> infinity) 1. $
  Putting everything back into eq. @eq:gaussian, we obtain the heavily approximated result for the large-$N$ behavior of $d_N$,
  $ lim_(N -> infinity) d_N approx 1/sqrt(2 pi) e^(4 pi sqrt(N))/sqrt(N^(3/2)/pi) approx N^(-3/4) e^(4 pi sqrt(N)). $
  Considering the large number of daredevil approximations we performed, this result is still remarkably close to $d_N approx N^(-27/4) e^(4 pi sqrt(N))$, which can be derived by leveraging more involved number-theoretic machinery.
+ A system's macroscopic entropy $S$ is given by the logarithm of the total number of microstates $Omega$ the system can occupy. That number obviously depends on the system's energy $E$, or in the case of a string, on the mass $M$ of its state. Fortunately, all we've been doing in this exercise is to derive a relation $d_N$ between the mass level $N$ of a state and its degeneracy with respect to the number operator $Nperp$, so we can directly insert $d_N$ for $Omega$ to get
  $ S(N) = ln(d_N) = ln(N^(-3/4) e^(4 pi sqrt(N))) = 4 pi sqrt(N) + ln(N^(-3/4)) limits(-->)^(N -> infinity) 4 pi sqrt(N). $
  The relation $alpha' M^2 = N - a$ gives all masses in the tower of states. For highly excited states with large $N$, we can neglect the normal ordering constant $a <= 1$, i.e. $sqrt(alpha') M = sqrt(N)$. Thus the entropy as a function of mass for large $M$ reads
  $ S(M) approx 4 pi sqrt(alpha') M. $
  The macroscopic temperature can be calculated from $S(M)$ by simple differentiation,
  $ T = ((partial S(M))/(partial M))^(-1) = 1/(4 pi sqrt(alpha')) equiv T_"H". $
  Interestingly, the temperature of strings with high mass, i.e. energy, is entirely constant. We could increase the energy to arbitrarily high levels and yet never break this temperature cutoff called the Hagedorn temperature.
