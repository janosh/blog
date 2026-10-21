#import "/notes.typ": notes, one, ev, bra, ket, eps
#import "/statistical-physics/sheet.typ": distributions, cF, cH, cP, hH, hN, ni

#show: notes.with(
  title: [Fock spaces and the grand canonical partition function],
  date: [Janosh Riebesell],
)
#set math.equation(numbering: "(1)")

#let hA = $hat(A)$
// run-in paragraph heading in bold sans-serif, like LaTeX's \paragraph
#let par-head(body) = text(weight: "bold", body) + h(0.6em)

#par-head[Fock space]Let $cH$ denote a single-particle Hilbert space. Then the $n$-fold (anti-)symmetrized tensor product $cH_plus.minus^n = cP_plus.minus cH^(times.o n)$ constitutes the $n$-boson (-fermion) subspace of the many-particle Fock space $cF_plus.minus (cH)$ given by the direct sum
$ cF_plus.minus (cH) = plus.o.big_(n=0)^infinity cH_plus.minus^n = CC plus.o cH plus.o (cP_plus.minus cH times.o cH) plus.o (cP_plus.minus cH times.o cH times.o cH) plus.o .... $
The (anti-)symmetrizer is defined as
$ cP_plus.minus ket(psi_1) times.o dots.c times.o ket(psi_n) = 1/n! sum_(pi in S_n) (plus.minus 1)^pi ket(psi_(pi(1))) times.o dots.c times.o ket(psi_(pi(n))), $
with $S_n$ the symmetric group of order $n!$ of all permutations on $n$ objects. An element $ket(Psi)$ of $cF_plus.minus (cH)$ is then given by
$
  ket(Psi)_plus.minus & = ket(Psi_0)_plus.minus plus.o ket(Psi_1)_plus.minus plus.o ket(Psi_2)_plus.minus plus.o ... \
                      & = a_0 ket(0) plus.o ket(psi_1) plus.o sum_(i j) a_(i j) ket(psi_(2,i)\, psi_(2,j))_plus.minus plus.o ...
$ <eq:entangled>
where $ket(0)$ is the vacuum state#footnote[$ket(0)$ has length 1, meaning that for $ket(Psi)_plus.minus$ normalized, $a_0 in CC$ can be non-zero only if all the higher coefficients are zero and then it must be phase $a_0 = e^(i phi)$. This makes sense because if a state contains particles, it should not also contain the vacuum.], $ket(psi_1) in cH$ is a single-particle state (without any statistics), and
$ a_(i j) ket(psi_(2,i) psi_(2,j))_plus.minus = a_(i j)/2 (ket(psi_(2,i)) times.o ket(psi_(2,j)) plus.minus ket(psi_(2,j)) times.o ket(psi_(2,i))) in cP_plus.minus cH times.o cH, wide "with" a_(i j) = plus.minus a_(j i) in CC. $
For the Fock space $cF_plus.minus (cH)$ to be itself a Hilbert space requires that its elements have finite norm. Since each state is an infinite series, this is a non-trivial requirement. If implemented, $cF_plus.minus (cH)$ consists only of those infinite tuples $ket(Psi)_plus.minus = (ket(Psi_0)_plus.minus, ket(Psi_1)_plus.minus, ket(Psi_2)_plus.minus, ...)$ for which
$ ||ket(Psi)_plus.minus||_plus.minus^2 = sum_(n=0)^infinity chevron.l Psi_n|Psi_n chevron.r_plus.minus < infinity, $
where each of the $n$-particle subspaces $cH_plus.minus^n$ has its own inner product defined by
$ chevron.l Psi_n|Psi_n chevron.r_plus.minus = sum_(i_1, ..., i_n \ j_1, ..., j_n) a_(i_1, ..., i_n)^* a_(j_1, ..., j_n) chevron.l psi_(i_1)|psi_(j_1) chevron.r dots.c chevron.l psi_(i_n)|psi_(j_n) chevron.r. $

#par-head[Pure and entangled states]For density operators, we had made the important distinction between pure and mixed states described respectively by operators of the form
$ rho = ket(psi) bra(psi), #h(3em) "and" #h(3em) rho = sum_n p_n ket(psi_n) bra(psi_n), $
with $0 <= p_n <= 1$, $sum_n p_n = 1$. A similar distinction can be made for elements of a Fock space where a pure $n$-particle state can be written as a direct product of single-particle states,
$ ket(psi)_plus.minus = cP_plus.minus ket(psi_1) times.o ket(psi_2) times.o dots.c times.o ket(psi_n). $
Of the $n$ particles, anyone might be in state $ket(psi_1)$, $ket(psi_2)$, $ket(psi_3)$, etc. We don't care which one is where. Our formalism does not distinguish between individual particles, only how many there are. Quantum mechanics tells us they are fundamentally indistinguishable, which would make any assignment of particles to states an artificial construct existent only in our description with no basis in nature, similar to coordinate systems in general relativity and string theory. This is the central insight behind second quantization.

A state that cannot be written as a pure state (or product of pure states) is called entangled. Entangled states are given by linear combinations of pure states such as the one in @eq:entangled. As such, they don't correspond to any fixed number of particles but may contain contributions from states with an infinite range of particles.

#par-head[Basis]A particularly convenient basis for a Fock space can be written i.t.o. occupation numbers. Given a single-particle basis ${ket(psi_n)}_(n in NN_0)$ of $cH$#footnote[In the case of an ideal Bose or Fermi gas with Hamiltonian $hat(H) = hat(p)^2/(2 m) = (planck^2 k^2)/(2 m)$ the momentum eigenstates $ket(k)$ are a particularly convenient choice of basis since the Hamiltonian and momentum operator $hat(p) = planck k$ commute.], we can denote a basis state of $cF_plus.minus (cH)$ with $n_i$ particles in state $ket(psi_i)$ for $i in NN_0$ by
$
  ni(plus.minus) = ket(n_0\, n_1\, n_2\, ...)_plus.minus & = cP_plus.minus times.o.big_(i=0)^infinity ket(psi_i)^(times.o n_i) \
  & = cP_plus.minus ket(psi_0)^(times.o n_0) times.o ket(psi_1)^(times.o n_1) times.o ...
$ <eq:basis>
where again $n_i^- in {0, 1}$ for fermions and $n_i^+ in NN_0$ for bosons. Of course, for a finite-particle state, at some point all particles will be distributed among the available single-particle states, resulting in a lot of trailing zeros from all the $n_i$ with $i > i_max$. To simplify our notation, these zeros can safely be dropped without changing the state. The number of particles in a state like @eq:basis is
$ hN ket(n_0\, n_1\, ...\, n_k)_plus.minus = sum_(i=0)^infinity n_i ket(n_0\, n_1\, ...\, n_k)_plus.minus, $ <eq:n-eigen>
where $hN$ denotes the number operator on $cF_plus.minus (cH)$. If we restrict our considerations to many-particle systems without interactions among the particles (typical examples include the ideal Bose and Fermi gases), then the energy of a many-particle state is just
$ hH ket(n_0\, n_1\, ...\, n_k)_plus.minus = sum_(i=0)^infinity n_i eps_i ket(n_0\, n_1\, ...\, n_k)_plus.minus, $ <eq:h-eigen>
where $hH$ is the Hamiltonian on $cF_plus.minus (cH)$, and $eps_i$ denotes the energy of the single-particle state $ket(psi_i)$. Thus, in the case of non-interacting systems, the occupation number states are eigenstates of both the number operator and the Hamiltonian. Operators that allow for a shared eigenbasis commute. If $hN$ carries no explicit time dependence, i.e. $(partial hN)/(partial t) = 0$, then Heisenberg's equation
$ (dif hA)/(dif t) = i/planck [hH, hA] + (partial hA)/(partial t) $
implies that the total number of particles must be conserved. Of course, this is not a particularly surprising statement. $(partial hN)/(partial t) != 0$ would describe an open system which particles can exit or enter based on external stimuli. Without this possibility and in the absence of interactions, there is no mechanism by which particles could be created, destroyed, removed from or brought into the system. Thus their number must be conserved. \
From eqs. @eq:n-eigen and @eq:h-eigen, we can infer what form $hH$ and $hN$ must take when constructed from their single-particle counterparts $hat(h)$ and $hat(n)$ acting on $cH$, namely
$ hH = sum_(n=0)^infinity (hat(h) times.o underbrace(one times.o dots.c times.o one, n - 1 "times") + one times.o hat(h) times.o underbrace(one times.o dots.c times.o one, n - 2 "times") + dots.c + underbrace(one times.o dots.c times.o one, n - 1 "times") times.o hat(h)), $
and likewise for $hN$. For instance, acting only on the two-particle subspace $cH_plus.minus^2$, $hH$ would be $hat(h) times.o one + one times.o hat(h)$, where $one$ is the identity on $cH$.

#par-head[Grand canonical partition function]Using the occupation number basis, the grand canonical partition function on the space $cF_plus.minus (cH)$ can be evaluated as the weighted sum over states
$ Z_g^plus.minus = tr_(cF_plus.minus (cH)) (e^(-beta (hH - mu hN))) = sum_(N=0)^infinity sum_({n_i}_i^plus.minus) lr(chevron.l {n_i}_i^plus.minus |e^(-beta (hH - mu hN))| {n_i}_i^plus.minus chevron.r) delta_(N, sum n_i). $
This is a rather complicated sum running over all possible combinations of occupation numbers $n_i$ of all single-particle states $ket(psi_i) in cH$. The Kronecker symbol ensures that in each term of the sum over $N$ only configurations with the correct number of total particles appear. If we had instead chosen to work in the canonical ensemble, we would still have this restriction but the sum over $N$ (and the fugacity $z^hN = e^(beta mu hN)$) would be absent from the partition function, making the evaluation of $Z_c$ extremely difficult. The sum over all possible number of particles turns out to be a crucial advantage of the grand canonical ensemble when it comes to quantum gases. \
We make full use of it by dropping both the sum over $N$ and the Kronecker symbol. This lets the $n_i$ roam freely, so to speak. We still sum over all possibilities of distributing an arbitrary number of particles (up to infinitely many) onto the single-particle states in $cH$, thus still taking into account every possible value for the total particle number $N$. By furthermore using @eq:n-eigen and @eq:h-eigen, $Z_g^plus.minus$ factorizes into
$
  Z_g^plus.minus & = sum_({n_i}_i^plus.minus) e^(-beta sum_(j=0)^infinity n_j (eps_j - mu)) underbrace(chevron.l {n_i}_i^plus.minus | {n_i}_i^plus.minus chevron.r, 1) \
  & = sum_(n_0^plus.minus = 0)^(infinity "or" 1) sum_(n_1^plus.minus = 0)^(infinity "or" 1) sum_(n_2^plus.minus = 0)^(infinity "or" 1) dots.c product_(j=0)^infinity e^(-beta n_j (eps_j - mu)) = product_(j=0)^infinity sum_(n_j^plus.minus = 0)^(infinity "or" 1) e^(-beta n_j (eps_j - mu)).
$
For fermions, the sum over $n_j$ contains only two terms,
$ Z_g^- = product_(j=0)^infinity (1 + e^(-beta (eps_j - mu))), $
while for bosons, we may use the geometric series to get
$ Z_g^+ = product_(j=0)^infinity 1/(1 - e^(-beta (eps_j - mu))). $
Of course, there is an important point to consider here. The geometric series will only converge if $eps_j - mu > 0 thick forall j$, i.e. if all single-particle energies are larger than the chemical potential. If we set the ground state energy to $E_0 = 0$, then the bosonic grand partition function can only be computed in this way for systems with $mu < 0$. For fermions, due to their capped occupation number, $mu$ remains unrestricted. \
The grand potential is the logarithm of the partition function,
$ Omega_g^plus.minus = -1/beta ln(Z_g^plus.minus) = plus.minus 1/beta sum_(j=0)^infinity ln(1 minus.plus e^(-beta (eps_j - mu))). $ <eq:grand-potential>
It is a function of temperature, chemical potential and volume. The volume enters via the sum over single-particle states indexed by $j$ and via their energies $eps_j$. Once we have an explicit expression for $Omega_g^plus.minus$, we can immediately calculate from it average occupation numbers for all single-particle states by differentiating w.r.t. that state's energy. To see this, note that
$
  ev(n_i)_g & = 1/Z_g^plus.minus tr_(cF_plus.minus (cH)) (n_i e^(-beta (hH - mu hN))) = 1/Z_g^plus.minus product_(j=0)^infinity sum_(n_j) n_i e^(-beta n_j (eps_j - mu)) \
            & = 1/Z_g^plus.minus product_(j=0)^infinity sum_(n_j) (-1/beta partial/(partial eps_i)) e^(-beta n_j (eps_j - mu)) = -1/beta 1/Z_g^plus.minus partial/(partial eps_i) Z_g^plus.minus \
            & = -1/beta partial/(partial eps_i) ln(Z_g^plus.minus) = partial/(partial eps_i) Omega_g^plus.minus
$
Inserting @eq:grand-potential gives
$
  ev(n_i)_plus.minus & = plus.minus 1/beta partial/(partial eps_i) sum_(j=0)^infinity ln(1 minus.plus e^(-beta (eps_j - mu))) = plus.minus 1/beta 1/(1 minus.plus e^(-beta (eps_i - mu))) partial/(partial eps_i) (minus.plus e^(-beta (eps_i - mu))) \
  & = e^(-beta (eps_i - mu))/(1 minus.plus e^(-beta (eps_i - mu))) = 1/(e^(beta (eps_i - mu)) minus.plus 1).
$
These are the familiar Bose-Einstein and Fermi-Dirac distributions.#footnote[Note that we ignored the issue of spin throughout this entire discussion. However, if the single-particle energies are spin-independent and we don't introduce any spin-spin interactions within multi-particle states, then treating particles with spin $s$ will only result in an uninteresting degeneracy factor $g_s = 2 s + 1$.] We plot them as well as the Maxwell-Boltzmann distribution below.
#align(center, distributions())
This illustrates the problem we mentioned earlier that the bosonic partition function diverges for $eps_i - mu < 0$ which carries over to the occupation numbers. Fermions, even though their distribution differs from that of bosons only by an inconspicuous sign, are well-behaved at any chemical potential.
