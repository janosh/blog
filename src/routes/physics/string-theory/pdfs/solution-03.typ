#import "/notes.typ": note, task, vb, eps, eqby
#import "/string-theory/sheet.typ": SP, u1, u2, sheet

#show: sheet.with(3, [October 26th, 2015], [November 4th, 2015])

#let Xh = $hat(X)$
#let (NN, DD, DN) = ($"NN"$, $"DD"$, $"DN"$)
#let u3(x) = math.underparen(x)
// the "no longer depends on" strike-through of an argument
#let struck(x) = math.cancel(x, angle: 45deg)

= Mixed Dirichlet-Neumann boundary conditions

#task[
  The derivation of the mode expansion for the open string with Neumann-Neumann NN boundary conditions is easiest performed with the help of the so-called doubling trick: Starting from the open string field $X_mu (tau, sigma)$ with $0 <= sigma <= l$, one defines the auxiliary field $Xh_mu (tau, sigma)$ for $-l <= sigma <= l$ via
  $ Xh_mu (tau, sigma) = cases(X_mu (tau, sigma) quad & "for" 0 <= sigma <= l\,, X_mu (tau, -sigma) & "for" -l <= sigma <= 0.) $
  + Show that requiring that $Xh_mu (tau, sigma)$ can be extended to $sigma in RR$ as a smooth periodic function with period $2 l$ is equivalent to requiring Neumann-Neumann boundary conditions for $X_mu (tau, sigma)$ at $sigma in {0, l}$.
  + Use this to deduce the oscillator expansion for the Neumann-Neumann open string. Start with a solution for $partial_plus.minus Xh_mu (tau, sigma)$ and integrate this to a solution for $X_mu (tau, sigma)$ subject to the correct boundary conditions.
  + Repeat this procedure for Dirichlet-Dirichlet DD boundary conditions by first finding a suitable definition of $Xh_mu (tau, sigma)$ that incorporates the DD boundary conditions for $X_mu (tau, sigma)$ and then integrating the solution for $partial_plus.minus Xh_mu (tau, sigma)$.
  + Find the open string expansion for DN boundary conditions (i.e. Dirichlet boundary conditions at $sigma = 0$ and Neumann boundary conditions at $sigma = l$).
  + For each of the three types of boundary conditions -- NN, DD, DN -- give the centre-of-mass position and the total momentum of the string and discuss the result.
]

+ Since $Xh_mu (tau, sigma)$ is symmetric around $sigma = 0$, by the chain rule, its derivative has to be antisymmetric,
  $ Xh_mu (tau, sigma) = Xh_mu (tau, -sigma) wide => wide partial_sigma Xh_mu (tau, sigma) = -partial_sigma Xh_mu (tau, -sigma). $
  This immediately implements the Neumann boundary condition for the real string field $X_mu (tau, sigma)$ at $sigma = 0$,
  $ partial_sigma X_mu (tau, 0) = partial_sigma Xh_mu (tau, 0) limits(=)^! -partial_sigma Xh_mu (tau, 0) = -partial_sigma X_mu (tau, 0) wide => wide partial_sigma X_mu (tau, 0) = 0. $
  By further taking into account periodicity of the auxiliary field, i.e. $X_mu (tau, l) limits(=)^! X_mu (tau, -l)$, we get exactly the same condition at $sigma = l$,
  $ partial_sigma X_mu (tau, l) = partial_sigma Xh_mu (tau, l) limits(=)^! -partial_sigma Xh_mu (tau, -l) = -partial_sigma X_mu (tau, l) wide => wide partial_sigma X_mu (tau, l) = 0. $
+ We prefer to work with the actual string field $X_mu (tau, sigma)$ here as opposed to the auxiliary $Xh_mu (tau, sigma)$. We will have to take care to implement the boundary conditions by hand but this has the advantage of making it clearer what is going on.

  To deduce the string field's mode expansion, we first need its equation of motion. It can be obtained from the Polyakov action, which in flat gauge ($h_(a b) = eta_(a b)$) becomes
  $
    SP & = -1/(4 pi alpha') integral_Sigma dif tau dif sigma sqrt(-h) h^(a b) partial_a X_mu partial_b X^mu limits(-->)^(h_(a b) = eta_(a b)) -T/2 integral_Sigma dif tau dif sigma underbrace(sqrt(-eta), 1) eta^(a b) partial_a X_mu partial_b X^mu \
    & = T/2 integral_Sigma dif tau dif sigma [(partial_tau X)^2 - (partial_sigma X)^2] = 2 T integral_Sigma dif tau dif sigma partial_+ X_mu partial_- X^mu,
  $
  where in the last step, we used lightcone coordinates $xi^plus.minus = tau plus.minus sigma$ in which the partial derivatives read $partial_plus.minus = 1/2 (partial_tau plus.minus partial_sigma)$. By varying $SP$ w.r.t. $X^mu (tau, sigma)$, we get the string field's e.o.m.,
  $
    delta SP & = T/2 integral_Sigma dif tau dif sigma [2 partial_tau X_mu partial_tau delta X^mu - 2 partial_sigma X_mu partial_sigma delta X^mu] \
    & = -T integral_Sigma dif tau dif sigma [partial_tau^2 X_mu - partial_sigma^2 X_mu] delta X^mu \
    & quad + T integral_0^l dif sigma partial_tau X_mu delta X^mu|_(t_i)^(tau = t_f) - T integral_(t_i)^(t_f) dif tau partial_sigma X_mu delta X^mu|_0^(sigma = l).
  $
  We drop the two boundary terms in the last line because we desperately want to avoid non-local terms in the string field's e.o.m. Actually, this step isn't as unfounded as we just made it sound. As usual, our variation underlies the constraint that the initial and final string state are held fixed, i.e. $delta X^mu (tau = t_i, sigma) = delta X^mu (tau = t_f, sigma) = 0$, so the $tau$-boundary takes care of itself in any case. At least for the _closed_ string, the $sigma$-boundary is trivial as well: There simply is none. Instead we have the periodic boundary condition $X^mu (tau, sigma = l) limits(=)^! X^mu (tau, sigma = 0)$. The part where it becomes interesting is the $sigma$-boundary of the _open_ string. Since now there is no periodicity in $sigma$, we need $partial_sigma X_mu delta X^mu = 0$ at $sigma = l$ and $sigma = 0$ separately. This amounts to requiring (for each spacetime dimension $mu$ individually) either
  $
    & partial_sigma X^mu (tau, sigma) = 0 #h(3em) && "at" sigma = l "and/or" 0 #h(3em) && "(Neumann b.c.)," \
    "or" quad & delta X^mu (tau, sigma) = 0 && "at" sigma = l "and/or" 0 && "(Dirichlet b.c.)."
  $
  If we do this, then by the usual arguments of $delta X^mu (tau, sigma)$ being an arbitrary variation but $delta SP$ having to vanish for all of them, we obtain as the string field e.o.m. the nice and simple result of a free wave equation $(partial_tau^2 - partial_sigma^2) X^mu (tau, sigma) = 0$. Expressed in lightcone coordinates, this becomes
  $ partial_+ partial_- X^mu (xi^+, xi^-) = 0. $ <eq:wave>
  This is all well and good but was done mostly for completeness sake. Our task in this exercise is actually to derive the NN open string mode expansion. Let's start.

  Since partial derivatives commute, we can draw two interesting conclusions from @eq:wave:
  $
    partial_+ partial_- X^mu (xi^+, xi^-) = 0 wide => wide partial_- X^mu (struck(xi^+), xi^-) = partial_- X^mu (xi^-), \
    partial_- partial_+ X^mu (xi^+, xi^-) = 0 wide => wide partial_+ X^mu (xi^+, struck(xi^-)) = partial_+ X^mu (xi^+).
  $
  This means that $X^mu (xi^+, xi^-)$ is the sum of a left- and a right-moving wave along the string, i.e.
  $ X^mu (xi^+, xi^-) = X_L^mu (xi^+) + X_R^mu (xi^-). $ <eq:left-right>
  Equation @eq:left-right is the most general ansatz admitted by the partial differential equation @eq:wave. We specialize it to describe the NN open string by implementing the Neumann boundary conditions at both ends. Firstly, at $sigma = 0$, we have
  $ partial_sigma X_NN^mu (tau, sigma)|_(sigma = 0) = lr((partial X_L^mu (xi^+))/(partial xi^+) (partial xi^+)/(partial sigma) |)_(sigma = 0) + lr((partial X_R^mu (xi^-))/(partial xi^-) (partial xi^-)/(partial sigma) |)_(sigma = 0) = partial_+ X_L^mu (tau) - partial_- X_R^mu (tau) = 0, $ <eq:neumann-0>
  where $partial_- X_R^mu$ picked up a minus sign due to the chain rule. Since their $sigma$-derivatives are equal, the functions $X_L^mu$ and $X_R^mu$ have to be identical up to an additive constant $c^mu$.#footnote[If we were working with the auxiliary field $Xh^mu$, we could have arrived at the same conclusion by exploiting $sigma$-parity in eq. @eq:left-right, i.e. invariance of $Xh^mu$ under $sigma -> -sigma$.] By replacing $X_R^mu = X_L^mu + c^mu$ and redefining $X_L^mu -> X_L^mu + c^mu/2$, eq. @eq:left-right becomes
  $ X_NN^mu (xi^+, xi^-) = X_L^mu (xi^+) + X_L^mu (xi^-). $ <eq:nn-ansatz>
  Essentially, this equation states that left-moving waves are reflected into right-moving ones at the left boundary and vice versa, so it suffices to define one type of mover and we kept $X_L^mu$. For the boundary at $sigma = l$, we get
  $ partial_sigma X_NN^mu (tau, sigma)|_(sigma = l) = partial_+ X_L^mu (tau + l) - partial_- X_L^mu (tau - l) = 0. $
  Since this equation must hold for all $tau$, we learn that $partial_plus.minus X_L^mu$ is periodic in its _single_ argument with period $2 l$. This intermediate result is particularly important as it means that $partial_plus.minus X_L^mu$ fulfills the _Dirichlet conditions_ which determine whether or not a function $f(x)$ can be expanded into a Fourier series. The Dirichlet conditions are:
  #set enum(numbering: "1.")
  + $f(x)$ must be periodic.
  + $f(x)$ must be single-valued and continuous, except at a finite number of finite discontinuities.
  + $f(x)$ must have only a finite number of maxima and minima within a period.
  + The integral over one period of $|f(x)|$ must converge.

  Periodicity was the only missing piece out of the above four. We are therefore entitled to make the following ansatz for $partial_plus.minus X_L^mu (xi^plus.minus)$,
  $ partial_plus.minus X_L^mu (xi^plus.minus) = pi/l sqrt(alpha'/2) sum_(n in ZZ) alpha_n^mu e^(-(2 pi i)/(2 l) n xi^plus.minus), $ <eq:fourier>
  where the $alpha_n^mu$ are the string field's modes, $2 l$ is one period, and the awkward prefactor $pi/l sqrt(alpha' \/ 2)$ as well as the sign in the exponent was introduced to follow the lecture note's convention where the positive frequency modes correspond to $n < 0$. Note that we were not required to introduce two sets of Fourier coefficients, say $(alpha_n^plus.minus)^mu$ because we identified for the open NN string $X_L^mu$ and $X_R^mu$ as one and the same function right from the start. It is trivial to see that eq. @eq:fourier fulfills the original e.o.m. $partial_minus.plus partial_plus.minus X_L^mu (xi^plus.minus) = 0$.

  The next step is to integrate eq. @eq:fourier w.r.t. $xi^plus.minus$,
  $
    X_L^mu (xi^plus.minus) & = integral dif xi^plus.minus partial_plus.minus X_L^mu (xi^plus.minus) = pi/l sqrt(alpha'/2) integral dif xi^plus.minus (alpha_0^mu + sum_(n != 0) alpha_n^mu e^(-(pi i)/l n xi^plus.minus)) \
    & = pi/l sqrt(alpha'/2) (alpha_0^mu xi^plus.minus - l/(pi i) sum_(n != 0) alpha_n^mu/n e^(-(pi i)/l n xi^plus.minus)) + x_0^mu/2.
  $ <eq:integrated>
  Here, $x_0^mu/2$ is just a suggestively named integration constant with no further meaning as yet. (It will later turn out to be the string's centre-of-mass position at $tau = 0$.) Inserting eq. @eq:integrated into our ansatz @eq:nn-ansatz, we finally get the NN open string field's mode expansion
  $
    X_NN^mu (xi^+, xi^-) & = X_L^mu (xi^+) + X_L^mu (xi^-) \
    & = x_0^mu + pi/l sqrt(alpha'/2) alpha_0^mu (xi^+ + xi^-) + i sqrt(alpha'/2) sum_(n != 0) alpha_n^mu/n (e^(-(pi i)/l n xi^+) + e^(-(pi i)/l n xi^-)) \
    & = x_0^mu + pi/l sqrt(2 alpha') alpha_0^mu tau + i sqrt(2 alpha') sum_(n != 0) alpha_n^mu/n e^(-(pi i)/l n tau) cos(pi/l n sigma).
  $
+ Dirichlet boundary conditions require that the string endpoints are fixed, i.e. $delta X_DD^mu (tau, sigma) = 0$ for $sigma in {0, l}$, or equivalently $partial_tau X_DD^mu (tau, 0) = partial_tau X_DD^mu (tau, l) = 0$. A suitable auxiliary field that automatically implements Dirichlet boundary conditions would be
  $ Xh_mu (tau, sigma) = cases(X_mu (tau, sigma) quad & "for" 0 <= sigma <= l\,, -X_mu (tau, -sigma) & "for" -l <= sigma <= 0.) $
  Again, we prefer to proceed with the actual string field. Everything we did in part b) for the derivation of open NN string mode expansion carries over one-to-one up to eq. @eq:neumann-0. Since we now differentiate w.r.t. $tau$, which appears with positive sign in both $xi^+$ and $xi^-$, we don't pick up a minus here from the chain rule when calculating $partial_tau X_DD^mu (xi^plus.minus)$. Consequently, we get
  $ partial_tau X_DD^mu (tau, sigma)|_(sigma = 0) = partial_+ X_L^mu (tau) + partial_- X_R^mu (tau) = 0, $
  which allows us to identify $X_R = -X_L + c^mu$ and eq. @eq:nn-ansatz becomes
  $ X_DD^mu (xi^+, xi^-) = X_L^mu (xi^+) - X_L^mu (xi^-) + c^mu. $ <eq:dd-ansatz>
  Note that this time, the additive constant $c^mu$ cannot be absorbed equally into $X_L^mu (xi^+)$ and $X_L^mu (xi^-)$ because they appear with different sign. Instead, by taking the equation to the $sigma = 0$ endpoint of the string,
  $ X_DD^mu (xi^+, xi^-)|_(sigma = 0) = X_L^mu (tau) - X_L^mu (tau) + c^mu = c^mu equiv x_0^mu, $
  we find $c^mu$ is now the fixed position $x_0^mu$ of one end of the string. At $sigma = l$, we find
  $ partial_tau X_DD^mu (tau, sigma)|_(sigma = l) = partial_+ X_L^mu (tau + l) - partial_- X_L^mu (tau - l) = 0, $
  i.e. as expected, $partial_plus.minus X_L^mu$ is again periodic and can be expanded into the same Fourier series @eq:fourier and integrated in the same way as before. Plugging in the integrated Fourier series @eq:integrated into $X_DD^mu (tau, sigma)$ from eq. @eq:dd-ansatz yields the mode expansion for the DD open string,
  $
    X_DD^mu (xi^+, xi^-) & = x_0^mu + X_L^mu (xi^+) - X_L^mu (xi^-) \
    & = x_0^mu + pi/l sqrt(alpha'/2) alpha_0^mu (xi^+ - xi^-) + i sqrt(alpha'/2) sum_(n != 0) alpha_n^mu/n (e^(-(pi i)/l n xi^+) - e^(-(pi i)/l n xi^-)) \
    & = x_0^mu + pi/l sqrt(2 alpha') alpha_0^mu sigma + sqrt(2 alpha') sum_(n != 0) alpha_n^mu/n e^(-(pi i)/l n tau) sin(pi/l n sigma).
  $
  At $sigma = l$, this mode expansion reads
  $ X_DD^mu (tau, l) = x_0^mu + pi sqrt(2 alpha') alpha_0^mu, $
  which is indeed independent of $tau$ as it must be to respect the fixed string end. From this we can gather that the string stretches across a distance of $pi sqrt(2 alpha') alpha_0^mu$ in the $mu$-direction,
  $ X_DD^mu (tau, l) - X_DD^mu (tau, 0) = x_0^mu + pi sqrt(2 alpha') alpha_0^mu - x_0^mu = pi sqrt(2 alpha') alpha_0^mu equiv x_l^mu - x_0^mu $
  where it makes sense to define $x_l^mu$ as the $mu$-coordinate of the other fixed point of the string in order to write the mode expansion as
  $ X_DD^mu (xi^+, xi^-) = x_0^mu + (x_l^mu - x_0^mu) sigma/l + sqrt(2 alpha') sum_(n != 0) alpha_n^mu/n e^(-(pi i)/l n tau) sin(pi/l n sigma). $
+ DN boundary conditions translate into
  $ partial_tau X_DN^mu (tau, sigma)|_(sigma = 0) = 0 #h(3em) "and" #h(3em) partial_sigma X_DN^mu (tau, sigma)|_(sigma = l) = 0. $
  We therefore again get eq. @eq:dd-ansatz with the string's $sigma = 0$-end fixed at $x_0^mu$
  $ X_DN^mu (xi^+, xi^-) = X_L^mu (xi^+) - X_L^mu (xi^-) + x_0^mu. $ <eq:dn-ansatz>
  Applying the condition $partial_sigma X_DN^mu (tau, sigma)|_(sigma = l) = 0$ gives
  $ partial_sigma X_DN^mu (tau, sigma)|_(sigma = l) = partial_+ X_L^mu (tau + l) + partial_- X_L^mu (tau - l) = 0, $
  which marks $partial_+ X_L^mu$ as an antiperiodic function of the form $f(t - T/4) = -f(t + T/4)$, where the period is now $T = 4 l$. Doubling the period can be implemented in the Fourier expansion by making the mode counter half-integer, i.e.
  $ partial_plus.minus X_L^mu (xi^plus.minus) = pi/l sqrt(alpha'/2) sum_(n in ZZ + 1/2) alpha_n^mu e^(-(pi i)/l n xi^plus.minus). $ <eq:dn-fourier>
  One immediate consequence is that there is no longer a phase-factor-free zero mode $alpha_0^mu$. If we integrate eq. @eq:dn-fourier and plug the result into eq. @eq:dn-ansatz, we get
  $
    X_DN^mu (xi^+, xi^-) & = x_0^mu + X_L^mu (xi^+) - X_L^mu (xi^-) \
    & = x_0^mu + i sqrt(alpha'/2) sum_(n in ZZ + 1/2) alpha_n^mu/n (e^(-(pi i)/l n xi^+) - e^(-(pi i)/l n xi^-)) \
    & = x_0^mu + sqrt(2 alpha') sum_(n in ZZ + 1/2) alpha_n^mu/n e^(-(pi i)/l n tau) sin(pi/l n sigma).
  $
+ This business of finding mode expansions is getting dull. But fear not, we can change the topic now. Our next task is to find the centre-of-mass position $q^mu$ and the total momentum $p^mu$ of the string for each set of boundary conditions discussed above.
  #set enum(numbering: "1.")
  + NN:
    $
      q_NN^mu & equiv 1/l integral_0^l dif sigma X_NN^mu (tau, sigma) = 1/l integral_0^l dif sigma (x_0^mu + pi/l sqrt(2 alpha') alpha_0^mu tau + i sqrt(2 alpha') sum_(n != 0) alpha_n^mu/n e^(-(pi i)/l n tau) cos(pi/l n sigma)) \
      & = x_0^mu + pi/l sqrt(2 alpha') alpha_0^mu tau + i sqrt(2 alpha') sum_(n != 0) alpha_n^mu/n e^(-(pi i)/l n tau) 1/l integral_0^l dif sigma underbrace(cos(pi/l n sigma), "integrates to" l/(pi n) sin(pi n) = 0) \
      & = x_0^mu + pi/l sqrt(2 alpha') alpha_0^mu tau, \
      p_NN^mu & = integral_0^l dif sigma Pi_NN^mu (tau, sigma) = T integral_0^l dif sigma partial_tau X_NN^mu (tau, sigma) \
      & = T integral_0^l dif sigma (pi/l sqrt(2 alpha') alpha_0^mu + sqrt(2 alpha') sum_(n != 0) alpha_n^mu pi/l e^(-(pi i)/l n tau) cos(pi/l n sigma)) \
      & = pi T sqrt(2 alpha') alpha_0^mu + T sqrt(2 alpha') sum_(n != 0) alpha_n^mu pi/l e^(-(pi i)/l n tau) underbrace(integral_0^l dif sigma cos(pi/l n sigma), "0, as above") \
      & = pi T sqrt(2 alpha') alpha_0^mu = alpha_0^mu/sqrt(2 alpha').
    $
    Knowing that $alpha_0^mu = sqrt(2 alpha') p_NN^mu$, we can also write the open NN string's centre-of-mass position as
    $ q_NN^mu = x_0^mu + (2 pi alpha')/l p_NN^mu tau = x_0^mu + p_NN^mu/(T l) tau. $
    This is a very nice result as it means that the string's c.o.m. just moves in a straight line with constant velocity $p_NN^mu/(T l)$. This is consistent with the fact that so far we've been working entirely in a free theory (see Polyakov action, no terms above quadratic order appear).
  + DD:
    $
      q_DD^mu & = 1/l integral_0^l dif sigma X_DD^mu (tau, sigma) = 1/l integral_0^l dif sigma (x_0^mu + (x_l^mu - x_0^mu) sigma/l + sqrt(2 alpha') sum_(n != 0) alpha_n^mu/n e^(-(pi i)/l n tau) sin(pi/l n sigma)) \
      & = x_0^mu + 1/2 (x_l^mu - x_0^mu) + sqrt(2 alpha') sum_(n != 0) alpha_n^mu/n e^(-(pi i)/l n tau) 1/l integral_0^l dif sigma sin(pi/l n sigma) \
      & = 1/2 (x_0^mu + x_l^mu) + sqrt(2 alpha') sum_(n != 0) alpha_n^mu/n e^(-(pi i)/l n tau) 1/(pi n) (1 - underbrace(cos(pi n), (-1)^n)) \
      & = 1/2 (x_0^mu + x_l^mu) + 2/pi sqrt(2 alpha') sum_(n in 2 ZZ + 1) alpha_n^mu/n^2 e^(-(pi i)/l n tau),
    $ <eq:q-dd>
    $
      p_DD^mu & = integral_0^l dif sigma Pi_DD^mu (tau, sigma) = T integral_0^l dif sigma partial_tau X_DD^mu (tau, sigma) \
      & = T integral_0^l dif sigma (-(pi i)/l sqrt(2 alpha') sum_(n != 0) alpha_n^mu e^(-(pi i)/l n tau) sin(pi/l n sigma)) \
      & = -T (pi i)/l sqrt(2 alpha') sum_(n != 0) alpha_n^mu e^(-(pi i)/l n tau) l/(pi n) (1 - underbrace(cos(pi n), (-1)^n)) = sqrt(2 \/ alpha')/(i pi) sum_(n in 2 ZZ + 1) alpha_n^mu/n e^(-(pi i)/l n tau).
    $ <eq:p-dd>
    Interestingly, both c.o.m. position and total momentum depend only on the odd-numbered modes $alpha_n^mu$ with $n in 2 ZZ + 1$. Since the string is not free to move as a whole, its momentum is not conserved but oscillates.
  + DN:
    $
      q_DN^mu & = 1/l integral_0^l dif sigma X_DN^mu (tau, sigma) = 1/l integral_0^l dif sigma (x_0^mu + sqrt(2 alpha') sum_(n in ZZ + 1/2) alpha_n^mu/n e^(-(pi i)/l n tau) sin(pi/l n sigma)) \
      & eqby("eq:q-dd") x_0^mu + sqrt(2 alpha') sum_(n in ZZ + 1/2) alpha_n^mu/n e^(-(pi i)/l n tau) 1/(pi n) (1 - underbrace(cos(pi n), 0)) = x_0^mu + sqrt(2 alpha')/pi sum_(n in ZZ + 1/2) alpha_n^mu/n^2 e^(-(pi i)/l n tau), \
      p_DN^mu & = integral_0^l dif sigma Pi_DN^mu (tau, sigma) = T integral_0^l dif sigma partial_tau X_DN^mu (tau, sigma) \
      & eqby("eq:p-dd") -T (pi i)/l sqrt(2 alpha') sum_(n in ZZ + 1/2) alpha_n^mu e^(-(pi i)/l n tau) l/(pi n) (1 - 0) = -i/(pi sqrt(2 alpha')) sum_(n in ZZ + 1/2) alpha_n^mu/n e^(-(pi i)/l n tau).
    $

= Conformal transformations and their algebra

#task[
  The conformal Killing equation is defined as
  $ (P dot eps)_(a b) equiv nabla_a eps_b + nabla_b eps_a - h_(a b) nabla^c eps_c = 0. $ <eq:killing>
  + Recall the significance of a vector field $eps(xi)$ satisfying the conformal Killing equation @eq:killing.
  + Show that a conformal Killing vector leads to a conserved current $J^a = T^(a b) eps_b$. Which properties of $T^(a b)$ are needed for this?
  + Now go to lightcone gauge and show from the definition in part a) that the conformal Killing vectors are precisely the ones generating transformations
    $ xi^plus.minus -> tilde(xi)^plus.minus (xi^plus.minus) = xi^plus.minus + eps^plus.minus (xi^plus.minus). $ <eq:residual>
    Recall from the lecture that these were the residual gauge symmetries in flat gauge.
  + Using $T_(plus.minus plus.minus) = -1/alpha' partial_plus.minus X dot partial_plus.minus X$ and the equal-time Poisson brackets
    $
      {X^mu (tau, sigma), X^nu (tau, sigma')}_"PB" = {dot(X)^mu (tau, sigma), dot(X)^nu (tau, sigma')}_"PB" = 0, \
      {X^mu (tau, sigma), dot(X)^nu (tau, sigma')}_"PB" = 1/T eta^(mu nu) delta(sigma - sigma'),
    $
    calculate the Poisson brackets
    $ {T_(plus.minus plus.minus) (tau, sigma), X^mu (tau, sigma')}_"PB". $ <eq:t-x-bracket>
    *Hint:* It is useful to first work out, from the definition of the Poisson bracket as given in the lecture, how to express quantities such as ${A B, C}$ in terms of elementary Poisson brackets involving only two fields.
  + Use the definition (for the closed string)
    $ L_(eps^plus.minus) equiv -l/(4 pi^2) integral_0^l dif sigma eps^plus.minus (xi^plus.minus) T_(plus.minus plus.minus) (xi^plus.minus), $
    and the result of part d) to calculate the Poisson brackets
    $ {L_(eps^plus.minus), X^mu (tau, sigma)}_"PB". $
    Use this to argue that the $L_(eps^plus.minus)$ generate infinitesimal conformal transformations via the Poisson bracket.
  + One can decompose the functions $eps^plus.minus (xi^plus.minus)$ into a discrete sum of Fourier components $e^(i (2 pi)/l m xi^plus.minus)$, $m in ZZ$. The resulting generators
    $ L_m^- = -l/(4 pi^2) integral_0^l dif sigma T_(--) e^(i (2 pi)/l m (tau - sigma)), #h(3em) L_m^+ = -l/(4 pi^2) integral_0^l dif sigma T_(++) e^(i (2 pi)/l m (tau + sigma)), $ <eq:virasoro-def>
    then form two copies of the Witt algebra with respect to the Poisson bracket, i.e.
    $ {L_m^plus.minus, L_n^plus.minus} = -i(m - n) L_(m+n)^plus.minus. $ <eq:witt>
    Verify explicitly that the above commutation relations satisfy the Jacobi identity, i.e. form a Lie algebra.
  + Show that the generators $L_0$, $L_1$ and $L_(-1)$ form a Lie subalgebra.
  + Show that the combination $(L_0^+ - L_0^-)$ generates rigid $sigma$-translations along the closed string. How about $(L_0^+ + L_0^-)$?
]

+ A long list could be compiled of all the important properties of conformal Killing vector fields. We will mention only three.
  #set enum(numbering: "1.")
  + Vector fields that satisfy the conformal Killing equation are exactly those whose flow preserves the conformal structure of a manifold. Expressed in the language of conformal geometry: The conformal Killing equation on a manifold $M$ with metric tensor $vb(h)$ applies to those vector fields $eps(xi)$ which preserve $vb(h)$ up to a scaling, i.e.
    $ cal(L)_eps vb(h) = lambda(xi) vb(h) $ <eq:lie-derivative>
    where $cal(L)_eps$ is the Lie derivative and $lambda(xi)$ some function of position on $M$. It is easy to see, that eq. @eq:lie-derivative is completely equivalent to eq. @eq:killing. Inserting $cal(L)_eps h_(a b) = nabla_a eps_b + nabla_b eps_a$ into eq. @eq:killing and bringing $h_(a b) nabla^c eps_c$ to the other side, we have
    $ cal(L)_eps h_(a b) = nabla_a eps_b + nabla_b eps_a = (nabla^c eps_c) h_(a b). $
    Hence $lambda(xi)$ is given by $nabla^c eps_c$.
  + In particular, property 1 results in the fact that for diffeomorphisms of the form @eq:residual, i.e.
    $ xi^a -> tilde(xi)^a (xi) = xi^a + eps^a (xi), #h(3em) xi^a in {tau, sigma}, $
    where $eps^a (xi)$ is a conformal Killing vector field, the effect on the metric can be undone by a Weyl rescaling.
  + Even after gauge fixing to the flat metric, $h_(a b) = eta_(a b)$, the Polyakov action retains a large residual gauge symmetry, of which the conformal Killing vectors are the generators.

  A fourth very important property will be demonstrated in part b).
+ Every conformal Killing vector field $eps^a (xi)$ yields an associated conserved current $J_eps^a = T^(a b) eps_b$ with $nabla_a J_eps^a = 0$. There exist infinitely many such $eps^a (xi)$.

  *Proof:* By Noether's theorem, $T_(a b)$ is the conserved current resulting from local diffeomorphism invariance on the worldsheet. In math: $nabla^a T_(a b) = 0$ for an on-shell string field $X(tau, sigma)$ since the action remains invariant under the following change in coordinates $xi^a in {tau, sigma}$ and metric $h_(a b)$,
  $ xi^a -> tilde(xi)^a (xi) = xi^a + eps^a (xi), $ <eq:diffeo>
  $ h_(a b) -> h'_(a b) = h_(a b) + delta h_(a b) = h_(a b) + nabla_a eps_b + nabla_b eps_a. $ <eq:metric-variation>
  To make this statement explicit, we recall the definition of the energy-momentum i.t.o. the Polyakov action,
  $ T_(a b) = (4 pi)/sqrt(-h) (delta SP)/(delta h^(a b)), $ <eq:em-tensor>
  followed by considering the total variation of $SP = SP [X, h]$,
  $ 0 = delta SP = integral dif tau dif sigma underbrace((delta SP)/(delta X^mu), 0) delta X^mu + integral dif tau dif sigma (delta SP)/(delta h^(a b)) delta h^(a b) eqby("eq:em-tensor") 1/(4 pi) integral dif tau dif sigma sqrt(-h) T_(a b) delta h^(a b) $
  where the very first equality holds because the action is invariant under the transformations @eq:diffeo and @eq:metric-variation, and the variation of $SP$ w.r.t. $X^mu$ vanishes on-shell, i.e. upon use of the string field's e.o.m. Inserting $delta h^(a b) = -(nabla^a eps^b + nabla^b eps^a)$, which follows from eq. @eq:metric-variation, and using $T^(a b) = T^(b a)$, we get
  $
    0 & = 1/(4 pi) integral dif tau dif sigma sqrt(-h) T_(a b) delta h^(a b) = -1/(2 pi) integral dif tau dif sigma sqrt(-h) T_(a b) nabla^a eps^b \
    & = -1/(2 pi) integral dif tau dif sigma [nabla^a (sqrt(-h) T_(a b) eps^b) - nabla^a (sqrt(-h) T_(a b)) eps^b] \
    & = 1/(2 pi) integral dif tau dif sigma nabla^a (sqrt(-h) T_(a b)) eps^b,
  $
  where the first term in the second line is a volume integral over a total derivative. Using Stokes theorem, it can be converted to a surface integral sans derivative, which by the usual argument of exclusively treating localized systems that do not extend outwards to infinity, can be taken to vanish. The remaining term in the third line has to vanish for all and every $eps^b (xi)$ since the action is invariant under general diffeomorphisms. The only way for the integral to be zero regardless of which $eps^b (xi)$ we plug in, is for $nabla^a (sqrt(-h) T_(a b))$ to be zero. From $nabla^a h_(b c) = 0$, it follows by the chain rule that also $nabla^a sqrt(-h) = 0$. Hence we are left with our initial statement,
  $ nabla^a T_(a b) = 0. $ <eq:conservation>
  Due to eq. @eq:conservation, we have
  $ nabla_a J_eps^a = nabla_a (T^(a b) eps_b) = T^(a b) nabla_a eps_b = 1/2 T^(a b) (nabla_a eps_b + nabla_b eps_a), $
  where in the last step, we again exploited the energy-momentum tensor's symmetry $T^(a b) = T^(b a)$. Inserting the conformal Killing equation, we get
  $ nabla_a J_eps^a = 1/2 underbrace(T^(a b) h_(a b), 0) nabla^c eps_c = 0, $
  where we used our result from exercise 1.f) on assignment sheet 2 that the energy-momentum is traceless in any system with an action invariant under Weyl rescalings.
+ The term lightcone gauge can be confusing if one assumes the word lightcone to describe the gauge. A more fitting name for this modus operandi might be flat gauge in lightcone coordinates. What is actually happening is that we partially fix the gauge by flattening the metric, $h_(a b) limits(=)^! eta_(a b)$, followed by a transformation into lightcone coordinates $xi^plus.minus = tau plus.minus sigma$, where now the metric components $a, b$ are no longer $in {tau, sigma}$ but $in {+, -}$. Its components can be inferred from the line element $dif s^2$:
  $ dif s^2 = -dif tau^2 + dif sigma^2 = -dif xi^+ dif xi^- = eta_(a b) dif xi^a dif xi^b wide limits(=>)^(eta_(a b) = eta_(b a)) wide vb(eta) = mat(0, -1/2; -1/2, 0). $
  Since in flat space $nabla_a = partial_a$, the conformal Killing equation in lightcone gauge reads
  $ partial_a eps_b + partial_b eps_a = eta_(a b) partial_c eps^c. $
  From this, we get three equations, namely
  $ partial_+ eps_- + partial_- eps_+ = -1/2 (partial_+ eps^+ + partial_- eps^-), #h(3em) partial_+ eps_+ = 0, #h(3em) partial_- eps_- = 0. $
  The first one is uninteresting, but inserting $eps_plus.minus = eta_(plus.minus minus.plus) eps^minus.plus = -1/2 eps^minus.plus$ into the second and third, respectively, we get
  $ partial_+ eps^- = 0, #h(3em) partial_- eps^+ = 0. $ <eq:chiral>
  From eq. @eq:chiral, we learn that $eps^plus.minus$ are functions of $xi^plus.minus$ only, i.e. $eps^+ = eps^+ (xi^+)$ and $eps^- = eps^- (xi^-)$. We have thus reproduced the coordinate dependencies in eq. @eq:residual.

  Again we note that a transformation of the form
  $ xi^plus.minus -> tilde(xi)^plus.minus (xi^plus.minus) = xi^plus.minus + eps^plus.minus (xi^plus.minus). $
  is not prohibited even after partially fixing the gauge freedom by setting $h_(a b) limits(=)^! eta_(a b)$. This remaining invariance thus constitutes the residual gauge symmetry in flat gauge.
+ The part of Noether's theorem stating that continuous symmetries give rise to conserved currents and associated charges is well known. What is sometimes overlooked is the fact, that Noether's theorem works both ways. In this part, we will demonstrate the converse, namely that conserved charges also generate symmetries. More precisely, we show that the stress energy tensor generates conformal transformations.

  To do so, we will make heavy use of the (equal-time) Poisson bracket defined for two fields $F(tau, sigma)$, $G(tau, sigma')$ as
  $ {F(tau, sigma), G(tau, sigma')}_"PB" equiv integral dif tilde(sigma) ((partial F(tau, sigma))/(partial X^mu (tau, tilde(sigma))) (partial G(tau, sigma'))/(partial Pi_mu (tau, tilde(sigma))) - (partial G(tau, sigma'))/(partial X^mu (tau, tilde(sigma))) (partial F(tau, sigma))/(partial Pi_mu (tau, tilde(sigma)))). $
  To proceed, we employ the identity ${F G, H}_"PB" = F {G, H}_"PB" + {F, H}_"PB" G$, where $F$, $G$, and $H$ are each fields. Using the product rule, its validity is easy to see,
  $
    & {F(tau, sigma) G(tau, sigma'), H(tau, sigma'')}_"PB" \
    & quad = integral dif tilde(sigma) ((partial [F(tau, sigma) G(tau, sigma')])/(partial X^mu (tau, tilde(sigma))) (partial H(tau, sigma''))/(partial Pi_mu (tau, tilde(sigma))) - (partial H(tau, sigma''))/(partial X^mu (tau, tilde(sigma))) (partial [F(tau, sigma) G(tau, sigma')])/(partial Pi_mu (tau, tilde(sigma)))) \
    & quad = F(tau, sigma) integral dif tilde(sigma) ((partial G(tau, sigma'))/(partial X^mu (tau, tilde(sigma))) (partial H(tau, sigma''))/(partial Pi_mu (tau, tilde(sigma))) - (partial H(tau, sigma''))/(partial X^mu (tau, tilde(sigma))) (partial G(tau, sigma'))/(partial Pi_mu (tau, tilde(sigma)))) \
    & quad quad + integral dif tilde(sigma) ((partial F(tau, sigma))/(partial X^mu (tau, tilde(sigma))) (partial H(tau, sigma''))/(partial Pi_mu (tau, tilde(sigma))) - (partial H(tau, sigma''))/(partial X^mu (tau, tilde(sigma))) (partial F(tau, sigma))/(partial Pi_mu (tau, tilde(sigma)))) G(tau, sigma') \
    & quad = F(tau, sigma) {G(tau, sigma'), H(tau, sigma'')}_"PB" + {F(tau, sigma), H(tau, sigma'')}_"PB" G(tau, sigma').
  $ <eq:product-rule>
  With this and the relations given in the exercise, which we restate here for convenience,
  $ T_(plus.minus plus.minus) = -1/alpha' partial_plus.minus X^mu partial_plus.minus X_mu, $ <eq:t-pm>
  $ {X^mu (tau, sigma), X^nu (tau, sigma')}_"PB" = {dot(X)^mu (tau, sigma), dot(X)^nu (tau, sigma')}_"PB" = 0, $ <eq:pb-zero>
  $ {X^mu (tau, sigma), dot(X)^nu (tau, sigma')}_"PB" = 1/T eta^(mu nu) delta(sigma - sigma'). $ <eq:pb-canonical>
  we can simplify the Poisson bracket in eq. @eq:t-x-bracket,
  $
    {T_(plus.minus plus.minus) (tau, sigma), X^mu (tau, sigma')}_"PB" & eqby("eq:t-pm") -1/alpha' {partial_plus.minus X_nu (tau, sigma) partial_plus.minus X^nu (tau, sigma), X^mu (tau, sigma')}_"PB" \
    & eqby("eq:product-rule") -2/alpha' partial_plus.minus X_nu (tau, sigma) {partial_plus.minus X^nu (tau, sigma), X^mu (tau, sigma')}_"PB" \
    & = -1/alpha' partial_plus.minus X_nu (tau, sigma) [{partial_tau X^nu (tau, sigma), X^mu (tau, sigma')}_"PB" \
    & #h(10em) plus.minus {partial_sigma X^nu (tau, sigma), X^mu (tau, sigma')}_"PB"],
  $ <eq:t-x-steps>
  where in the last step we used $partial_plus.minus = 1/2 (partial_tau plus.minus partial_sigma)$. In the last term of eq. @eq:t-x-steps, $partial_sigma$ does not act upon $X^mu (tau, sigma')$, so we may as well pull it out of the bracket and use eq. @eq:pb-zero to obtain
  $ {partial_sigma X^nu (tau, sigma), X^mu (tau, sigma')}_"PB" = partial_sigma {X^nu (tau, sigma), X^mu (tau, sigma')}_"PB" eqby("eq:pb-zero") 0. $
  For the term ${partial_tau X^nu (tau, sigma), X^mu (tau, sigma')}_"PB"$, we can insert eq. @eq:pb-canonical to arrive at
  $ {T_(plus.minus plus.minus) (tau, sigma), X^mu (tau, sigma')}_"PB" = 1/(alpha' T) partial_plus.minus X_nu (tau, sigma) eta^(mu nu) delta(sigma - sigma') = 2 pi partial_plus.minus X^mu (tau, sigma) delta(sigma - sigma'). $ <eq:t-x-result>
+ With eq. @eq:t-x-result in our toolbox, it is trivial to calculate the Poisson bracket of the string field $X^mu (tau, sigma)$ and the conserved charges $L_(eps^plus.minus)$ associated with invariance under conformal Killing transformation. The $L_(eps^plus.minus)$ are given by
  $ L_(eps^plus.minus) = -l/(4 pi^2) integral_0^l dif sigma eps^plus.minus (xi^plus.minus) T_(plus.minus plus.minus) (xi^plus.minus). $
  Therefore,
  $
    {L_(eps^plus.minus), X^mu (tau, sigma)}_"PB" & = -l/(4 pi^2) integral_0^l dif sigma' eps^plus.minus (xi^(plus.minus prime)) {T_(plus.minus plus.minus) (tau, sigma'), X^mu (tau, sigma)}_"PB" \
    & eqby("eq:t-x-result") -l/(4 pi^2) integral_0^l dif sigma' eps^plus.minus (xi^(plus.minus prime)) 2 pi partial_plus.minus X^mu (tau, sigma') delta(sigma - sigma') \
    & = -l/(2 pi) eps^plus.minus (xi^plus.minus) partial_plus.minus X^mu (tau, sigma).
  $
  Since this is precisely the Lie derivative acting on the string field, i.e.
  $ -(2 pi)/l {L_(eps^plus.minus), X^mu (tau, sigma)}_"PB" = eps^plus.minus (xi^plus.minus) partial_plus.minus X^mu (tau, sigma) = cal(L)_(eps^plus.minus) X^mu (tau, sigma), $
  we have shown that the $L_(eps^plus.minus)$ generate conformal transformations.
+ By decomposing a Killing vector field $eps^plus.minus (xi^plus.minus)$ into its Fourier components, i.e.
  $ eps^plus.minus (xi^plus.minus) = sum_(m in ZZ) eps_m^plus.minus e^(i (2 pi)/l m xi^plus.minus), $
  and inserting this sum into the conserved charges $L_(eps^plus.minus)$, we get a series representation for the charges themselves,
  $ L_(eps^plus.minus) = -l/(4 pi^2) sum_(m in ZZ) integral_0^l dif sigma eps_m^plus.minus T_(plus.minus plus.minus) (xi^plus.minus) e^(i (2 pi)/l m xi^plus.minus) equiv sum_(m in ZZ) eps_m^plus.minus L_m^plus.minus. $ <eq:charge-series>
  In eq. @eq:charge-series, the $L_m^plus.minus$ are the generators of the conformal Killing transformations. This assertion will be demonstrated in part h). The $L_m^plus.minus$ are called Virasoro generators and will turn out to be of vital importance as a tool in the full quantum theory to ensure that our description is free of unitarity-spoiling ghosts. Note that eq. @eq:charge-series establishes the Virasoro generators as the Fourier modes of the energy-momentum tensor $T_(a b)$. As stated in eq. @eq:virasoro-def, they are given by#footnote[Note that the lecture notes use a different notation here: $L_m^+ equiv tilde(L)_m$ and $L_m^- equiv L_m$.]
  $ L_m^plus.minus = -l/(4 pi^2) integral_0^l dif sigma T_(plus.minus plus.minus) e^(i (2 pi)/l m xi^plus.minus). $ <eq:virasoro>
  Although we were not tasked to do so by the exercise, we will verify that the set of $L_m^plus.minus$, $m in ZZ$ do indeed satisfy the classical Witt algebra @eq:witt. To that end, we calculate the Poisson bracket of the energy-momentum tensor in lightcone coordinates with itself,
  $
    & {T_(plus.minus plus.minus) (tau, sigma), T_(plus.minus plus.minus) (tau, sigma')}_"PB" = 1/alpha'^2 {partial_plus.minus X_mu (tau, sigma) partial_plus.minus X^mu (tau, sigma), partial_plus.minus X_nu (tau, sigma') partial_plus.minus X^nu (tau, sigma')}_"PB" \
    & eqby("eq:product-rule") 4/alpha'^2 partial_plus.minus X_mu (tau, sigma) partial_plus.minus X_nu (tau, sigma') {partial_plus.minus X^mu (tau, sigma), partial_plus.minus X^nu (tau, sigma')}_"PB" #h(3em) [partial_plus.minus = 1/2 (partial_tau plus.minus partial_sigma)] \
    & = 1/alpha'^2 partial_plus.minus X_mu (tau, sigma) partial_plus.minus X_nu (tau, sigma') [underbrace({partial_tau X^mu (tau, sigma), partial_tau X^nu (tau, sigma')}_"PB", "0, by eq." #ref(<eq:pb-zero>)) plus.minus underbrace({partial_tau X^mu (tau, sigma), partial_(sigma') X^nu (tau, sigma')}_"PB", -partial_(sigma') {X^nu (tau, sigma'), partial_tau X^mu (tau, sigma)}_"PB") \
    & #h(10em) plus.minus underbrace({partial_sigma X^mu (tau, sigma), partial_tau X^nu (tau, sigma')}_"PB", partial_sigma {X^mu (tau, sigma), partial_tau X^nu (tau, sigma')}_"PB") + underbrace({partial_sigma X^mu (tau, sigma), partial_(sigma') X^nu (tau, sigma')}_"PB", "0, by eq." #ref(<eq:pb-zero>))] \
    & eqby("eq:pb-canonical") 1/alpha'^2 partial_plus.minus X_mu (tau, sigma) partial_plus.minus X_nu (tau, sigma') [minus.plus partial_(sigma') 1/T eta^(mu nu) delta(sigma - sigma') plus.minus partial_sigma 1/T eta^(mu nu) delta(sigma - sigma')] \
    & = plus.minus (2 pi)/alpha' partial_plus.minus X_mu (tau, sigma) partial_plus.minus X^mu (tau, sigma') [partial_sigma - partial_(sigma')] delta(sigma - sigma').
  $ <eq:t-t-bracket>
  For the Poisson bracket of the Virasoro generators themselves, we have
  $
    {L_m^plus.minus, L_n^plus.minus}_"PB" & eqby("eq:virasoro") l^2/(4 pi^2)^2 integral_0^l dif sigma integral_0^l dif sigma' {T_(plus.minus plus.minus) (tau, sigma), T_(plus.minus plus.minus) (tau, sigma')}_"PB" e^(i (2 pi)/l m xi^plus.minus) e^(i (2 pi)/l n xi^(plus.minus prime)) \
    & eqby("eq:t-t-bracket") l^2/(2 pi)^4 integral_0^l dif sigma integral_0^l dif sigma' (plus.minus (2 pi)/alpha' partial_plus.minus X_mu (tau, sigma) partial_plus.minus X^mu (tau, sigma') delta(sigma - sigma') [partial_sigma - partial_(sigma')]) e^(i (2 pi)/l m xi^plus.minus) e^(i (2 pi)/l n xi^(plus.minus prime)) \
    & = plus.minus l^2/(2 pi)^3 integral_0^l dif sigma 1/alpha' partial_plus.minus X_mu (tau, sigma) partial_plus.minus X^mu (tau, sigma) [minus.plus i (2 pi)/l m plus.minus i (2 pi)/l n] e^(i (2 pi)/l m xi^plus.minus) e^(i (2 pi)/l n xi^plus.minus) \
    & = -i (2 pi)/l (m - n) l^2/(2 pi)^3 integral_0^l dif sigma underbrace(1/alpha' partial_plus.minus X_mu (tau, sigma) partial_plus.minus X^mu (tau, sigma), -T_(plus.minus plus.minus) (tau, sigma)) e^(i (2 pi)/l (m + n) xi^plus.minus) \
    & = i(m - n) l/(4 pi^2) integral_0^l dif sigma T_(plus.minus plus.minus) (tau, sigma) e^(i (2 pi)/l (m + n) xi^plus.minus) = -i(m - n) L_(m+n)^plus.minus.
  $ <eq:witt-result>
  Using eq. @eq:witt-result, it is easy to show that the Virasoro generators together with the Poisson bracket as binary operation fulfill the Jacobi identity.
  $
    & {{L_l^plus.minus, L_m^plus.minus}_"PB", L_n^plus.minus}_"PB" + {{L_m^plus.minus, L_n^plus.minus}_"PB", L_l^plus.minus}_"PB" + {{L_n^plus.minus, L_l^plus.minus}_"PB", L_m^plus.minus}_"PB" \
    & eqby("eq:witt-result") -i(l - m) {L_(l+m)^plus.minus, L_n^plus.minus}_"PB" - i(m - n) {L_(m+n)^plus.minus, L_l^plus.minus}_"PB" - i(n - l) {L_(n+l)^plus.minus, L_m^plus.minus}_"PB" \
    & eqby("eq:witt-result") -i[-i(l - m)(l + m - n) - i(m - n)(m + n - l) - i(n - l)(n + l - m)] L_(l+m+n)^plus.minus \
    & = -[u1(l^2) - u2(m^2) - n(l - m) + u2(m^2) - u3(n^2) - l(m - n) + u3(n^2) - u1(l^2) - m(n - l)] L_(l+m+n)^plus.minus \
    & = [u1(n l) - u2(n m) + u3(l m) - u1(l n) + u2(m n) - u3(m l)] L_(l+m+n)^plus.minus = 0.
  $
  Since the Poisson bracket is furthermore bilinear and antisymmetric under exchange of its arguments, it together with the Virasoro generators forms a Lie algebra, i.e. the Witt algebra is a Lie algebra.
+ If a set of generators form a Lie algebra, then a subset of those generators is called a Lie subalgebra, if the subset is closed under the Lie bracket. The subset $K = {L_0^plus.minus, L_k^plus.minus, L_(-k)^plus.minus}$ of all Virasoro generators forms a Lie subalgebra of the Witt algebra since
  $
    {L_0^plus.minus, L_k^plus.minus}_"PB" & = -i(-k) L_k^plus.minus wide && in K, \
    {L_0^plus.minus, L_(-k)^plus.minus}_"PB" & = -i k L_(-k)^plus.minus && in K, \
    {L_k^plus.minus, L_(-k)^plus.minus}_"PB" & = -i 2 k L_0^plus.minus && in K.
  $
  In particular, this holds for $k = 1$.
+ To compute the effect of $(L_0^+ - L_0^-)$ and $(L_0^+ + L_0^-)$ on the string field $X^mu (tau, sigma)$, we first need to calculate the Poisson bracket of a Virasoro generator with $X^mu (tau, sigma)$.
  $
    {L_m^plus.minus, X^mu (tau, sigma)}_"PB" & eqby("eq:virasoro") -l/(4 pi^2) integral_0^l dif sigma' {T_(plus.minus plus.minus) (tau, sigma'), X^mu (tau, sigma)}_"PB" e^(i (2 pi)/l m xi^plus.minus) \
    & eqby("eq:t-x-result") -l/(4 pi^2) integral_0^l dif sigma' 2 pi partial_plus.minus X^mu (tau, sigma') delta(sigma - sigma') e^(i (2 pi)/l m xi^plus.minus) \
    & = -l/(2 pi) e^(i (2 pi)/l m xi^plus.minus) partial_plus.minus X^mu (tau, sigma).
  $ <eq:l-x-bracket>
  With this identity, it is a simple matter to compute the Poisson brackets of $(L_0^+ - L_0^-)$ and $(L_0^+ + L_0^-)$ with $X^mu (tau, sigma)$.
  $
    {(L_0^+ - L_0^-), X^mu (tau, sigma)}_"PB" & = {L_0^+, X^mu (tau, sigma)}_"PB" - {L_0^-, X^mu (tau, sigma)}_"PB" \
    & eqby("eq:l-x-bracket") -l/(2 pi) partial_+ X^mu (tau, sigma) + l/(2 pi) partial_- X^mu (tau, sigma) = -l/(2 pi) partial_sigma X^mu (tau, sigma), \
    {(L_0^+ + L_0^-), X^mu (tau, sigma)}_"PB" & eqby("eq:l-x-bracket") -l/(2 pi) partial_+ X^mu (tau, sigma) - l/(2 pi) partial_- X^mu (tau, sigma) = -l/(2 pi) partial_tau X^mu (tau, sigma),
  $
  where we used $partial_+ - partial_- = 1/2 (partial_tau + partial_sigma) - 1/2 (partial_tau - partial_sigma) = partial_sigma$ and $partial_+ + partial_- = 1/2 (partial_tau + partial_sigma) + 1/2 (partial_tau - partial_sigma) = partial_tau$. We have thus shown that $(L_0^+ - L_0^-)$ and $(L_0^+ + L_0^-)$ generate infinitesimal $sigma$- and $tau$-translations, respectively.
