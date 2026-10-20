#import "/notes.typ": dd, notes, tagged, task

#show: notes.with(
  title: [Quantum Field Theory II -- Assignment 6],
  subtitle: [Exercise sheet 6, Advanced QFT, Prof. Jürgen Berges],
  date: [Solutions by Janosh Riebesell, 01.07.2015],
)

// Feynman slash notation
#let fsl(x) = math.cancel(x, angle: 25deg, length: 110%)
#let Psib = $overline(Psi)$
#let etab = $overline(eta)$

= Problem 6.1 (Path integral of the fermionic field with sources)

#task[
  We define the generating functional for the correlation functions of the free Dirac theory as
  #tagged(1, $ Z_0 [etab, eta] = integral cal(D) Psib cal(D) Psi e^(i (S_0 [Psib, Psi] + etab dot Psi + Psib dot eta)) $)
  with $S_0 [Psib, Psi] = integral dd(4, x) Psib (i fsl(partial) - m_0) Psi$.
]

#task(label: "a")[
  Show by means of completing the square that (1) can be rearranged to
  #tagged(2, $ Z_0 [etab, eta] = Z_0 [etab = 0, eta = 0] e^(-etab dot S_F dot eta), $)
  where $S_F$ is the Feynman propagator of the free Dirac theory,
  $ (i fsl(partial)_x - m_0 + i epsilon) S_F (x - y) = i delta^((4)) (x - y). $
]

Since we are working in a free theory, we may choose to shift not the time into the complex plane via $t -> t (1 - i epsilon)$ but instead make the replacement
$ cal(H) -> cal(H) - i epsilon phi^2 (x), quad "i.e." quad m_0^2 -> m_0^2 - i epsilon, quad "(see eq. 7.80)" $
in order to project the initial and final states to the vacuum. Thus, we may write the action as
$ S_0 [Psib, Psi] -> integral dd(4, x) integral dd(4, y) Psib underbrace((i fsl(partial) - m_0 + i epsilon) delta(x - y), i S_F^(-1) (x - y)) Psi = i Psib dot S_F^(-1) dot Psi. $
Completing the square yields
$
  S_0 [Psib, Psi] + etab dot Psi + Psib dot eta & = i Psib dot S_F^(-1) dot Psi + etab dot Psi + Psib dot eta \
  & = (Psib - i S_F etab) dot i S_F^(-1) dot (Psi - i S_F eta) + i etab dot S_F dot eta.
$
We define $Psib' = Psib - i S_F etab$ and $Psi' = Psi - i S_F eta$ and transform our path integration to these new variables. Since we performed just a shift, the Jacobian of the transformation is in both cases just one. Thus, the integration measure remains invariant. Altogether, this gives
$
  Z_0 [etab, eta] & = integral cal(D) Psib' cal(D) Psi' e^(i (underbrace(Psib' dot i S_F^(-1) dot Psi', S_0 [Psib', Psi']) + i etab dot S_F dot eta)) \
  & = Z_0 [etab = 0, eta = 0] e^(-etab dot S_F dot eta).
$

#task(label: "b")[
  We now add an interaction part $integral dd(4, x) cal(L)_"int" (Psib, Psi)$ to $S_0 [Psib, Psi]$. By proceeding as in the lecture for the bosonic case, show that the generating functional for the interacting theory can be written as
  #tagged(3, $ Z[etab, eta] = Z_0 [etab = 0, eta = 0] e^(delta/(delta Psi) dot S_F dot delta/(delta Psib)) e^(i integral dd(4, x) cal(L)_"int" (Psib, Psi)) dot e^(i etab dot Psi + i Psib dot eta) |_(Psib = Psi = 0). $)
]

Our full action now reads
$ S[Psib, Psi] = S_0 [Psib, Psi] + S_"int" [Psib, Psi], $
which makes our generating functional
$
  Z[etab, eta] & := integral cal(D) Psib cal(D) Psi e^(i (S[Psib, Psi] + etab dot Psi + Psib dot eta)) \
  & = integral cal(D) Psib cal(D) Psi e^(i integral dd(4, x) cal(L)_"int" (Psib, Psi)) e^(i (S_0 [Psib, Psi] + etab dot Psi + Psib dot eta)) \
  & = e^(i integral dd(4, x) cal(L)_"int" (-delta/(i delta eta), delta/(i delta etab))) integral cal(D) Psib cal(D) Psi e^(i (S_0 [Psib, Psi] + etab dot Psi + Psib dot eta)),
$
where we used $F[Psi] e^(i etab dot Psi) = F[delta/(i delta etab)] e^(i etab dot Psi)$ for any functional $F[Psi]$. Inserting our result from part a), we obtain
$
  Z[etab, eta] & = e^(i integral dd(4, x) cal(L)_"int" (-delta/(i delta eta), delta/(i delta etab))) Z_0 [etab, eta] \
  & = Z_0 [etab = 0, eta = 0] e^(i integral dd(4, x) cal(L)_"int" (-delta/(i delta eta), delta/(i delta etab))) e^(i etab dot S_F dot i eta).
$
To proceed, we need to understand how to commute two Grassmann-valued functionals containing derivatives. Note that
$
  F[delta/(i delta etab)] G[etab] e^(i etab dot Psi) & = F[delta/(i delta etab)] G[-delta/(i delta Psi)] e^(i etab dot Psi) \
  & = (-1)^(deg(F) deg(G)) G[-delta/(i delta Psi)] F[delta/(i delta etab)] e^(i etab dot Psi) = (-1)^(deg(F) deg(G)) G[-delta/(i delta Psi)] F[Psi] e^(i etab dot Psi),
$
where we used eq. (7.239) to introduce a factor of $(-1)^(deg(F) deg(G))$ with $deg(F), deg(G) in {0, 1}$, depending on whether $F$ and $G$ are Grassmann even or odd, also called bosonic and fermionic, respectively. Since we are treating fermions here, $Psi$, $Psib$, $eta$ and $etab$ are all Grassmann odd. However, that makes both of the exponentials in the above expression for $Z[etab, eta]$ Grassmann even. Thus
$
  Z[etab, eta] & = Z_0 [etab = 0, eta = 0] e^(i integral dd(4, x) cal(L)_"int" (-delta/(i delta eta), delta/(i delta etab))) e^(i etab dot S_F dot i eta) underbrace(e^(i (etab dot Psi + Psib dot eta))|_(Psib = Psi = 0), 1) \
  & = Z_0 [etab = 0, eta = 0] e^(delta/(delta Psi) dot S_F dot delta/(delta Psib)) e^(i integral dd(4, x) cal(L)_"int" (Psib, Psi)) e^(i (etab dot Psi + Psib dot eta))|_(Psib = Psi = 0).
$

= Problem 6.2 (Wick's theorem for fermions)

#task[
  From eq. (3) one may derive that the correlation functions for the free theory are given by
  #tagged(5, $ chevron.l T product_(i=1)^n Psi(x_i) product_(j=n+1)^(m+n) Psib(x_j) chevron.r = e^(-delta/(delta Psi) dot S_F dot delta/(delta Psib)) product_(i=1)^n Psi(x_i) product_(j=n+1)^(m+n) Psib(x_j)|_(Psib = Psi = 0). $)
]

#task(label: "a")[
  Prove Wick's theorem for the free fermions, i.e. show that $chevron.l T product_(i=1)^n Psi(x_i) product_(j=n+1)^(m+n) Psib(x_j) chevron.r = 0$ for $n != m$ and
  #tagged(6, $ chevron.l T product_(i=1)^n Psi(x_i) product_(j=n+1)^(m+n) Psib(x_j) chevron.r & = (-1)^(n/2 (n - 1)) S_F (x_1 - x_(n+1)) S_F (x_2 - x_(n+2)) dots.c S_F (x_n - x_(2n)) \
    & quad + "'all other contractions with appropriate signs'". $)
]

*For $n != m$:* We can get a better grip on the correlation function in eq. (5) by writing the exponential as a series expansion,
$
  chevron.l T product_(i=1)^n Psi(x_i) product_(j=n+1)^(m+n) Psib(x_j) chevron.r & = sum_(k=0)^oo 1/k! (-delta/(delta Psi) dot S_F dot delta/(delta Psib))^k product_(i=1)^n Psi(x_i) product_(j=n+1)^(m+n) Psib(x_j)|_(Psib = Psi = 0) \
  & = sum_(k=0)^(min{m, n}) 1/k! (-delta/(delta Psi) dot S_F dot delta/(delta Psib))^k product_(i=1)^n Psi(x_i) product_(j=n+1)^(m+n) Psib(x_j)|_(Psib = Psi = 0),
$
where the sum aborts at $min{m, n}$ since $m + 1$ functional derivatives acting on just $m$ fields always give zero. If further $m != n$, then after applying all functional derivatives, either $Psi$-fields ($n > m$) or $Psib$-fields ($m > n$) remain in every term appearing due to the product rule. Taking $Psib = Psi = 0$ in the end makes the whole correlation function vanish. Physically, this reflects charge conservation.

On the other hand, if $n = m$, we get
$ chevron.l T product_(i=1)^n Psi(x_i) product_(j=n+1)^(2n) Psib(x_j) chevron.r = sum_(k=0)^n 1/k! (delta/(delta Psib) dot S_F dot delta/(delta Psi))^k product_(i=1)^n Psi(x_i) Psib(x_(n+i))|_(Psib = Psi = 0). $
Again due to taking the limit $Psib = Psi = 0$, in the end all terms of the sum over $k$ disappear except for $k = n$, where we have an equal number of fields and derivatives. Thus
$
  chevron.l T product_(i=1)^n Psi(x_i) product_(j=n+1)^(2n) Psib(x_j) chevron.r & = 1/n! (delta/(delta Psib) dot S_F dot delta/(delta Psi))^n product_(i=1)^n Psi(x_i) Psib(x_(n+i)) \
  & = (-1)^(n/2 (n - 1)) S_F (x_1 - x_(n+1)) S_F (x_2 - x_(n+2)) dots.c S_F (x_n - x_(2n)) \
  & quad + "'all other contractions with appropriate signs'".
$
The last step actually requires lots of tedious combinatorics and commuting of Grassmann-odd fields and derivatives.

#task(label: "b")[
  Show by means of eq. (6) that
  $
    chevron.l T Psib_A (x) M^A""_B Psi^B (x) Psib_C (y) hat(M)^C""_D Psi^D (y) chevron.r = & -tr(S_F (y - x) M S_F (x - y) hat(M)) \
    & + "'uninteresting'" S_F (0)"-terms".
  $
]

To apply eq. (6), we note that in this case, $n = 2$ and so $(-1)^(n/2 (n - 1)) = -1$.
$
  & chevron.l T Psib_A (x) M^A""_B Psi^B (x) Psib_C (y) hat(M)^C""_D Psi^D (y) chevron.r \
  & = (-1)^3 M^A""_B hat(M)^C""_D chevron.l T Psi^B (x) Psi^D (y) Psib_A (x) Psib_C (y) chevron.r \
  & = (-1)^3 M^A""_B hat(M)^C""_D (-S_(F, A)^B (x - x) S_(F, C)^D (y - y) + S_(F, C)^B (x - y) S_(F, A)^D (y - x)) \
  & = -S_(F, A)^D (y - x) M^A""_B S_(F, C)^B (x - y) hat(M)^C""_D + S_(F, A)^B (0) M^A""_B S_(F, C)^D (0) hat(M)^C""_D \
  & = -tr(S_F (y - x) M S_F (x - y) hat(M)) + "'"S_F (0)"-terms'".
$
