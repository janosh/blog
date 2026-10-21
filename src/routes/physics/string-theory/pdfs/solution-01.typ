#import "/notes.typ": task, vb, eps
#import "/string-theory/sheet.typ": chr, riem, sheet

#show: sheet.with(1, [October 11th, 2015], [October 14th, 2015])

// run-in paragraph heading in sans-serif bold, like LaTeX's \paragraph
#let par-head(body) = text(weight: "bold", body) + h(0.6em)
#let hang(head, body) = block(above: 1em, inset: (left: 1.5em))[#h(-1.5em)#par-head(head)#body]

= Differential Geometry for General Relativity

#task[
  Consider the line element of a 2-sphere of radius $a$,
  $ dif s^2 = g_(mu nu) dif x^mu dif x^nu = a^2 [dif theta^2 + sin^2 (theta) dif phi^2]. $
  The metric $g_(mu nu)$ encodes all information on the geometry of a manifold. From it one can determine all those geometric quantities that are relevant for general relativity, namely

  #hang[The metric][Choosing $x^1 = theta$ and $x^2 = phi$, read off the matrix $g_(mu nu)$.]
  #hang[The Christoffel symbols][The Christoffel symbols are defined as
    $ chr(lambda, mu nu) = 1/2 g^(lambda kappa) ((partial g_(mu kappa))/(partial x^nu) + (partial g_(nu kappa))/(partial x^mu) - (partial g_(mu nu))/(partial x^kappa)). $
    They enter the covariant derivatives $nabla_mu V^nu = partial_mu V^nu + chr(nu, mu lambda) V^lambda$, where the correction term with the Christoffel symbol ensures that the covariant derivative indeed transforms covariantly under arbitrary coordinate transformations $x^mu -> x'^mu (x^nu)$, i.e.
    $ nabla_mu V^nu = partial_mu V^nu -> (nabla_mu V^nu = partial_mu V^nu)' = (partial x^lambda)/(partial x'^mu) (partial x'^nu)/(partial x^rho) nabla_lambda V^rho, $
    without second derivatives in the coordinates. Compute the non-vanishing Christoffel symbols for the 2-sphere (Hint: $chr(kappa, lambda mu) = chr(kappa, mu lambda)$).]
  #hang[The Riemann tensor][The Riemann curvature tensor has the form
    $ riem(kappa, lambda mu nu) = partial_mu chr(kappa, lambda nu) - partial_nu chr(kappa, lambda mu) + chr(eta, lambda nu) chr(kappa, eta mu) - chr(eta, lambda mu) chr(kappa, nu eta). $
    Calculate the non-vanishing components of the Riemann tensor for the 2-sphere (Hint: $riem(kappa, lambda mu nu) = -riem(kappa, lambda nu mu)$).

    *Remark:* The Riemann tensor measures the curvature of a space, for instance by quantifying the non-commutativity of the covariant derivatives,
    $ [nabla_mu, nabla_nu] V^kappa = riem(kappa, lambda mu nu) V^lambda. $
    A space with vanishing Riemann tensor is flat, i.e. the metric can be brought to the standard Minkowskian (or Euclidean) form by means of a coordinate transformation.]
  #hang[The Ricci tensor][The Ricci tensor is defined as
    $ R_(mu nu) = riem(kappa, mu kappa nu). $
    Calculate the Ricci tensor for the 2-sphere.]
  #hang[The scalar curvature][The scalar curvature is given by
    $ cal(R) = g^(mu nu) R_(mu nu). $
    Calculate the scalar curvature of the 2-sphere. How does it behave in the limit $a -> infinity$? Interpret this behavior.]
  #hang[The Einstein tensor][The Einstein tensor appears in the field equation of general relativity and it relates the curvature of space-time to the matter distribution,
    $ G_(mu nu) = 8 pi G T_(mu nu), $
    where $G$ denotes Newton's constant, $T_(mu nu)$ is the energy-momentum tensor, and $G_(mu nu)$ denotes the Einstein tensor,
    $ G_(mu nu) = R_(mu nu) - 1/2 cal(R) g_(mu nu). $
    Calculate the Einstein tensor for the 2-sphere.]
]

#hang[The metric][For $x^1 = theta$ and $x^2 = phi$, the equation
  $ g_(mu nu) dif x^mu dif x^nu = a^2 [dif theta^2 + sin^2 (theta) dif phi^2] $
  implies
  $ vb(g) = a^2 mat(1, 0; 0, sin^2 (theta)), #h(3em) "and hence" quad vb(g)^(-1) = 1/a^2 mat(1, 0; 0, 1/sin^2 (theta)). $]

#hang[The Christoffel symbols][Since the Christoffel symbols carry three coordinate indices and we have $d = 2$ dimensions ($theta$, $phi$), there are $d^3 = 8$ Christoffel symbols in total. However, due to the symmetry in the lower two indices, those with lower indices 12 and 21 are equal both for an upper index of 1 and 2, so only $8 - 2 = 6$ of those symbols are independent. We calculate each of those in turn. Since the only nonvanishing metric derivative is $(partial g_22)/(partial x^1) = 2 sin(theta) cos(theta)$, all but $chr(1, 22)$, $chr(2, 12)$, and $chr(2, 21)$ can immediately be seen to vanish:
  $
    chr(1, 11) & = 1/2 g^(1 kappa) ((partial g_(1 kappa))/(partial x^1) + (partial g_(1 kappa))/(partial x^1) - (partial g_11)/(partial x^kappa)) = 0, \
    chr(1, 12) & = 1/2 g^(1 kappa) ((partial g_(1 kappa))/(partial x^2) + (partial g_(2 kappa))/(partial x^1) - (partial g_12)/(partial x^kappa)) = 1/2 g^12 (partial g_22)/(partial x^1) = 0 = chr(1, 21), \
    chr(1, 22) & = 1/2 g^(1 kappa) ((partial g_(2 kappa))/(partial x^2) + (partial g_(2 kappa))/(partial x^2) - (partial g_22)/(partial x^kappa)) \
    & = -1/2 g^11 (partial g_22)/(partial x^1) = -1/(2 a^2) (partial [a^2 sin^2 (theta)])/(partial theta) = -sin(theta) cos(theta), \
    chr(2, 11) & = 1/2 g^(2 kappa) ((partial g_(1 kappa))/(partial x^1) + (partial g_(1 kappa))/(partial x^1) - (partial g_11)/(partial x^kappa)) = 0, \
    chr(2, 12) & = 1/2 g^(2 kappa) ((partial g_(1 kappa))/(partial x^2) + (partial g_(2 kappa))/(partial x^1) - (partial g_12)/(partial x^kappa)) \
    & = 1/2 g^22 (partial g_22)/(partial x^1) = 1/(2 a^2 sin^2 (theta)) (partial [a^2 sin^2 (theta)])/(partial theta) = cot(theta) = chr(2, 21), \
    chr(2, 22) & = 1/2 g^(2 kappa) ((partial g_(2 kappa))/(partial x^2) + (partial g_(2 kappa))/(partial x^2) - (partial g_22)/(partial x^kappa)) = 0.
  $]

#hang[The Riemann tensor][The Riemann tensor has four indices. So for $d = 2$ dimensions, the tensor contains a total of $d^4 = 16$ components. Due to the antisymmetry $riem(kappa, lambda mu nu) = -riem(kappa, lambda nu mu)$ of the last two indices, there is only $d/2 (d - 1) = 1$ independent combination of those two indices, leaving the Riemann tensor with $d^2 dot d/2 (d - 1) = 4$ independent components. In particular, all eight entries where the last two indices are equal must be zero, i.e.
  $
    riem(1, 111) = riem(1, 211) = riem(2, 111) = riem(2, 211) = 0, \
    riem(1, 122) = riem(1, 222) = riem(2, 122) = riem(2, 222) = 0.
  $
  The remaining eight components are potentially nonzero, but form four pairs of two whose members differ only in sign. These we calculate by hand:
  $
    riem(1, 112) & = -riem(1, 121) = partial_1 chr(1, 12) - partial_2 chr(1, 11) + chr(eta, 12) chr(1, eta 1) - chr(eta, 11) chr(1, 2 eta) = 0, \
    riem(1, 212) & = -riem(1, 221) = partial_1 chr(1, 22) - partial_2 chr(1, 21) + chr(eta, 22) chr(1, eta 1) - chr(eta, 21) chr(1, 2 eta) = partial_1 chr(1, 22) - chr(2, 21) chr(1, 22) \
    & = partial_theta [-sin(theta) cos(theta)] - cot(theta) dot [-sin(theta) cos(theta)] \
    & = -cos^2 (theta) + sin^2 (theta) + cos^2 (theta) = sin^2 (theta), \
    riem(2, 112) & = -riem(2, 121) = partial_1 chr(2, 12) - partial_2 chr(2, 11) + chr(eta, 12) chr(2, eta 1) - chr(eta, 11) chr(2, 2 eta) = partial_1 chr(2, 12) + chr(2, 12) chr(2, 21) \
    & = partial_theta cot(theta) + cot(theta) dot cot(theta) = -1 - cot^2 (theta) + cot^2 (theta) = -1, \
    riem(2, 212) & = -riem(2, 221) = partial_1 chr(2, 22) - partial_2 chr(2, 21) + chr(eta, 22) chr(2, eta 1) - chr(eta, 21) chr(2, 2 eta) = 0.
  $
  We found four nonvanishing components. The remark given in the exercise that a space with vanishing Riemann tensor is flat is in fact an "iff"-statement, i.e. a nonvanishing Riemann tensor implies that space is curved. We have therefore proven the unremarkable statement that the 2-sphere is curved.]

#hang[The Ricci tensor][The $d^2 = 4$ components of the Ricci tensor of the 2-sphere are given by
  $
    R_11 & = riem(kappa, 1 kappa 1) = riem(1, 111) + riem(2, 121) = 1, \
    R_12 & = riem(kappa, 1 kappa 2) = riem(1, 112) + riem(2, 122) = 0, \
    R_21 & = riem(kappa, 2 kappa 1) = riem(1, 211) + riem(2, 221) = 0, \
    R_22 & = riem(kappa, 2 kappa 2) = riem(1, 212) + riem(2, 222) = sin^2 (theta).
  $]

#hang[The scalar curvature][In the case of the 2-sphere, $cal(R)$ takes the very simple and memorable form,
  $ cal(R) = g^(mu nu) R_(mu nu) = g^11 R_11 + g^22 R_22 = 1/a^2 dot 1 + 1/(a^2 sin^2 (theta)) dot sin^2 (theta) = 2/a^2. $
  As expected, in the limit $a -> infinity$, we have
  $ lim_(a -> infinity) cal(R) = 0, $
  i.e. a sphere of infinite radius has vanishing curvature.]

#hang[The Einstein tensor][We give the Einstein tensor of the 2-sphere not component-wise, but in covariant matrix form:
  $ vb(G) = vb(R) - 1/2 cal(R) vb(g) = mat(1, 0; 0, sin^2 (theta)) - 1/2 2/a^2 a^2 mat(1, 0; 0, sin^2 (theta)) = mat(0, 0; 0, 0). $
  According to the Einstein equation,
  $ G_(mu nu) = 8 pi G T_(mu nu), $
  a vanishing Einstein tensor requires a trivial matter distribution, $T_(mu nu) = 0$.]

= Transformation of tensors and tensor densities

#task[
  Consider the coordinate change
  $ x^mu -> x'^mu equiv x^(mu'). $ <eq:coord-change>
  The associated transformation matrix and its inverse are
  $ P^mu zws_(nu') = (partial x^mu)/(partial x'^nu), #h(3em) "and" #h(3em) P^(mu') zws_nu = (partial x'^mu)/(partial x^nu), $
  respectively. Recall that a tensor of type, say $T^mu zws_nu$ transforms under eq. @eq:coord-change as
  $ T^mu zws_nu -> T^(mu') zws_(nu') = P^(mu') zws_alpha P^beta zws_(nu') T^alpha zws_beta. $ <eq:tensor-trafo>
  A tensor density $tilde(T)^mu zws_nu$ of weight $w$ is defined by the transformation behavior
  $ tilde(T)^mu zws_nu -> tilde(T)^(mu') zws_(nu') = J^w P^(mu') zws_alpha P^beta zws_(nu') tilde(T)^alpha zws_beta. $
  (and obvious generalisations for general types of tensor densities), where $J = det(vb(P))$.
  + Given the tensor $S_(mu nu)$, convince yourself that $sqrt(det(vb(S)))$ is a scalar density of weight 1.
  + Consider now fields of tensors and tensor densities, e.g. $T^mu zws_nu (x)$. Locally, i.e. infinitesimally, the transformation of eq. @eq:coord-change can be parametrized as $x'^mu = x^mu - eps^mu (x)$. Show the following infinitesimal variations for a scalar field $Phi(x)$, the metric $g_(mu nu) (x)$ and the associated metric density $sqrt(-det(vb(g)))$:
    #set enum(numbering: "i)")
    + $delta Phi = eps^mu partial_mu Phi$,
    + $delta g_(mu nu) = eps^lambda partial_lambda g_(mu nu) + (partial_mu eps^lambda) g_(lambda nu) + (partial_nu eps^lambda) g_(mu lambda) = nabla_mu eps_nu + nabla_nu eps_mu$,
    + $delta sqrt(-det(vb(g))) = partial_lambda [eps^lambda sqrt(-det(vb(g)))]$,

    where the second equality in ii) is true for the metric connection satisfying $nabla_lambda g_(mu nu) = 0$.

    *Hint:* For a scalar field the transformed object is defined via the relation $Phi'(x') = Phi(x)$.
]

+ Since $S_(mu nu)$ is said to be a tensor, we know it transforms as
  $ S_(mu nu) -> S_(mu' nu') = P^alpha zws_(mu') P^beta zws_(nu') S_(alpha beta). $
  or in matrix notation
  $ vb(S) -> vb(S)' = vb(P)_(x -> x')^2 vb(S). $
  Using that the determinant of a product of matrices is the product of the determinants, we have
  $
    sqrt(det(vb(S))) -> sqrt(det(vb(S)')) & = sqrt(det(vb(P)_(x -> x')^2 vb(S))) = sqrt([det(vb(P)_(x -> x'))]^2 det(vb(S))) \
    & = det(vb(P)_(x -> x')) sqrt(det(vb(S))) = J_(x -> x')^1 sqrt(det(vb(S))),
  $
  and thus $sqrt(det(vb(S)))$ is a tensor density of weight 1.
+ We now derive the infinitesimal transformation behavior of a scalar field as well as the metric and the square root of its negated determinant under the transformation $x'^mu = x^mu - eps^mu (x')$.
  #set enum(numbering: "i)")
  + Using $x^mu = x'^mu + eps^mu (x')$, the variation of a *scalar field* follows from the hint that $Phi'(x') = Phi(x)$ together with a simple Taylor expansion of $Phi(x)$ around $x'$,
    $
      Phi(x) -> Phi'(x') limits(=)^! Phi(x) & = Phi(x' + eps(x')) \
      & = sum_(n=0)^infinity 1/n! lr((partial^n Phi(x' + eps(x')))/(partial^n (x'^mu + eps^mu (x'))) |)_(x'^mu + eps^mu (x') = x'^mu) (x'^mu + eps^mu (x') - x'^mu)^n \
      & = Phi(x') + eps^mu (x') partial_(mu') Phi(x') + cal(O)[eps^2 (x')].
    $
    From this transformation law it follows that
    $ Phi'(x) = Phi(x) + eps^mu (x) partial_mu Phi(x) + cal(O)[eps^2 (x)], $
    and hence the variation $delta Phi(x)$ of the scalar field $Phi(x)$ given by the difference of the transformed and the original field reads
    $ delta Phi(x) = Phi'(x) - Phi(x) = eps^mu (x) partial_mu Phi(x) + cal(O)[eps^2 (x)]. $
  + For the *metric* $g_(mu nu) (x)$, we know that it strictly follows the transformational behavior @eq:tensor-trafo of a tensor (field). Therefore,
    $ g_(mu nu) (x) -> g_(mu' nu') (x') = P^alpha zws_(mu') P^beta zws_(nu') g_(alpha beta) (x). $ <eq:metric-trafo>
    Now, all we have to do is expand the expression on the right to first order in $eps^mu (x)$. This can be done by inserting our transformation $x^mu = x'^mu + eps^mu (x')$ into the definition of the transformation matrix $P^mu zws_(nu')$
    $ P^alpha zws_(mu') = (partial x^alpha)/(partial x'^mu) = (partial (x'^alpha + eps^alpha (x')))/(partial x'^mu) = delta^alpha zws_mu + partial_(mu') eps^alpha (x'). $ <eq:jacobian>
    For the metric $g_(alpha beta) (x)$, we do a Taylor expansion,
    $
      g_(alpha beta) (x) & = g_(alpha beta) (x' + eps(x')) \
      & = sum_(n=0)^infinity 1/n! lr((partial^n g_(alpha beta) (x' + eps(x')))/(partial^n (x'^gamma + eps^gamma (x'))) |)_(x'^gamma + eps^gamma (x') = x'^gamma) (x'^gamma + eps^gamma (x') - x'^gamma)^n \
      & = g_(alpha beta) (x') + eps^gamma (x') partial_(gamma') g_(alpha beta) (x') + cal(O)[eps^2 (x')].
    $
    Inserting eq. @eq:jacobian and the Taylor expansion into eq. @eq:metric-trafo, we get
    $
      g_(mu' nu') (x') & = [delta^alpha zws_mu + partial_(mu') eps^alpha (x')][delta^beta zws_nu + partial_(nu') eps^beta (x')] [g_(alpha beta) (x') + eps^gamma (x') partial_(gamma') g_(alpha beta) (x') + cal(O)[eps^2 (x')]] \
      & = delta^alpha zws_mu delta^beta zws_nu g_(alpha beta) (x') + [partial_(mu') eps^alpha (x')] delta^beta zws_nu g_(alpha beta) (x') + delta^alpha zws_mu [partial_(nu') eps^beta (x')] g_(alpha beta) (x') \
      & quad + delta^alpha zws_mu delta^beta zws_nu eps^gamma (x') partial_(gamma') g_(alpha beta) (x') + cal(O)[eps^2 (x')] \
      & = g_(mu nu) (x') + g_(alpha nu) (x') partial_(mu') eps^alpha (x') + g_(mu beta) (x') partial_(nu') eps^beta (x') + eps^gamma (x') partial_(gamma') g_(mu nu) (x') + cal(O)[eps^2 (x')].
    $
    From this we infer that
    $ g_(mu' nu') (x) = g_(mu nu) (x) + g_(alpha nu) (x) partial_mu eps^alpha (x) + g_(mu beta) (x) partial_nu eps^beta (x) + eps^gamma (x) partial_gamma g_(mu nu) (x) + cal(O)[eps^2 (x)], $
    and hence
    $
      delta g_(mu nu) (x) & = g_(mu' nu') (x) - g_(mu nu) (x) \
      & = g_(alpha nu) (x) partial_mu eps^alpha (x) + g_(mu beta) (x) partial_nu eps^beta (x) + eps^gamma (x) partial_gamma g_(mu nu) (x) + cal(O)[eps^2 (x)].
    $
    To see that the second equality in ii) holds, we simply calculate
    $
      nabla_mu eps_nu + nabla_nu eps_mu & = nabla_mu (g_(alpha nu) eps^alpha) + nabla_nu (g_(mu beta) eps^beta) = g_(alpha nu) nabla_mu eps^alpha + g_(mu beta) nabla_nu eps^beta + eps^gamma underbrace(nabla_gamma g_(mu nu), 0) \
      & = g_(alpha nu) (partial_mu eps^alpha + chr(alpha, mu delta) eps^delta) + g_(mu beta) (partial_nu eps^beta + chr(beta, nu zeta) eps^zeta) \
      & quad + eps^gamma (partial_gamma g_(mu nu) - chr(alpha, mu gamma) g_(alpha nu) - chr(beta, nu gamma) g_(mu beta)) \
      & = g_(alpha nu) partial_mu eps^alpha + g_(mu beta) partial_nu eps^beta + eps^gamma partial_gamma g_(mu nu) \
      & quad + g_(alpha nu) chr(alpha, mu delta) eps^delta - eps^gamma chr(alpha, mu gamma) g_(alpha nu) + g_(mu beta) chr(beta, nu zeta) eps^zeta - eps^gamma chr(beta, nu gamma) g_(mu beta) \
      & = g_(alpha nu) partial_mu eps^alpha + g_(mu beta) partial_nu eps^beta + eps^gamma partial_gamma g_(mu nu) = delta g_(mu nu) - cal(O)[eps^2].
    $
  + By part a), we have
    $ sqrt(-det[vb(g)(x)]) -> sqrt(-det[vb(g)'(x')]) = J_(x -> x') sqrt(-det[vb(g)(x)]) = J_(x -> x') g(x), $ <eq:density>
    where to save on writing, we introduced the shorthand notation $sqrt(-det[vb(g)(x)]) = g(x)$. To find the infinitesimal variation $delta sqrt(-det[vb(g)(x)]) = delta g(x)$, we expand eq. @eq:density to first order in $eps(x)$,
    $
      g'(x') & = J_(x -> x') g(x) = det(vb(P)_(x -> x')) g(x' + eps(x')) \
      & = underbrace(det[bb(1) + vb(partial)_(x') vb(eps)(x')], 1 + "Tr"[vb(partial)_(x') vb(eps)(x')] + cal(O)[eps^2 (x')]) (g(x') + eps^gamma (x') partial_(gamma') g(x') + cal(O)[eps^2 (x')]) \
      & = g(x') + [partial_(mu') eps^mu (x')] g(x') + eps^mu (x') partial_(mu') g(x') + cal(O)[eps^2 (x')] \
      & = g(x') + partial_(mu') [eps^mu (x') g(x')] + cal(O)[eps^2 (x')],
    $ <eq:density-expansion>
    where to get to the second line we used $vb(P)_(x -> x') = bb(1) + vb(partial)_(x') vb(eps)(x')$, i.e. eq. @eq:jacobian in matrix form. From eq. @eq:density-expansion, we infer
    $ g'(x) = g(x) + partial_mu [eps^mu (x) g(x)] + cal(O)[eps^2 (x)], $
    from which in turn it follows that
    $ delta g(x) = g'(x) - g(x) = partial_mu [eps^mu (x) g(x)] + cal(O)[eps^2 (x)], $
    or in unshortened notation,
    $ delta sqrt(-det[vb(g)(x)]) = partial_mu [eps^mu (x) sqrt(-det[vb(g)(x)])] + cal(O)[eps^2 (x)]. $

= Action Principle

#task[
  + Consider a field $phi.alt(x)$ and an action in $d$ spacetime dimensions with Minkowskian signature $(-1, +1, ..., +1)$ of the form
    $ S[phi.alt] = integral dif^d x cal(L)(phi.alt(x), partial_mu phi.alt(x)). $ <eq:action>
    The simplest example is the action for the free scalar field
    $ S[phi.alt] = -1/2 integral dif^d x (partial_mu phi.alt partial^mu phi.alt + m^2 phi.alt^2). $ <eq:free-action>
    The variation of the general action @eq:action is defined as
    $ delta S[phi.alt] = integral dif^d x ((partial cal(L))/(partial phi.alt) delta phi.alt + (partial cal(L))/(partial (partial_mu phi.alt)) delta (partial_mu phi.alt)). $ <eq:variation>
    Using integration by parts and neglecting boundary terms show that the action principle $delta S[phi.alt] = 0$ implies the Euler Lagrange equations
    $ partial_mu (partial cal(L))/(partial (partial_mu phi.alt)) = (partial cal(L))/(partial phi.alt). $
  + Use this result to derive the Klein-Gordon equation as the Euler-Lagrange equation of the free scalar field action @eq:free-action.
]

+ Using partial integration on the second term in the variation of the action @eq:variation, $delta S[phi.alt]$ becomes
  $ delta S[phi.alt] = underbrace(lr((partial cal(L))/(partial (partial_mu phi.alt)) delta phi.alt |)_(partial RR^d), 0) + integral dif^d x ((partial cal(L))/(partial phi.alt) - partial_mu (partial cal(L))/(partial (partial_mu phi.alt))) delta phi.alt. $
  Since we assume we are working with localized _physical_ systems, we take the boundary terms to vanish at spatial and temporal infinity, i.e. the term in front can be disregarded.

  At this point, we resort to Hamilton's principle of a stationary action, $delta S[phi.alt] = 0$, which we require to hold for all possible variations $delta phi.alt$ of $phi.alt(x)$. $delta S[phi.alt] = 0$ can hence only be true in general if the integrand itself vanishes. We thus arrive at the renowned Euler-Lagrange equation
  $ (partial cal(L))/(partial phi.alt) - partial_mu (partial cal(L))/(partial (partial_mu phi.alt)) = 0. $ <eq:euler-lagrange>
+ Comparing eqs. @eq:action and @eq:free-action, we see that the Lagrangian $cal(L)(phi.alt(x), partial_mu phi.alt(x))$ of the free scalar field is given by
  $ cal(L)(phi.alt(x), partial_mu phi.alt(x)) = -1/2 (partial_mu phi.alt partial^mu phi.alt + m^2 phi.alt^2). $
  Inserting this expression into eq. @eq:euler-lagrange, we obtain as equation of motion,
  $ -m^2 phi.alt + partial_mu partial^mu phi.alt = 0, $
  which written in a more familiar form reads
  $ (square_x - m^2) phi.alt(x) = 0. $
