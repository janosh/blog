#import "/notes.typ": dd, notes

#show: notes.with(
title: [General Relativity -- Exam Sheet],
subtitle: [Prof. Björn Schäfer, Heidelberg University, summer 2015],
date: [Formula summary by Janosh Riebesell],
)

#set text(size: 9.5pt)
#set par(justify: false, leading: 0.55em)

// one ruled-off entry of the cheat sheet
#let entry(head, body) = block(
width: 100%,
breakable: true,
stroke: (bottom: 0.4pt + luma(150)),
inset: (bottom: 4pt),
below: 4pt,
[*#head* #body],
)


#entry[Newton's axioms:][1\. free particles move along straight lines at constant velocity, 2. $arrow(F) = m dot.double(arrow(x))$, 3. $"actio" = -"reactio"$]

#entry[Galilei transformations:][universal time $t = t'$ $forall$ observers; 2 frames $S, S'$ in relative motion $parallel$ $x$-axis: $x'_1 = x_1 - v t$, $x'_2 = x_2$, $x'_3 = x_3$, \ $u'_1 = (dif x'_1)/(dif t) = u_1 - v$; $a'_1 = (dif u'_1)/(dif t) = a_1$ $==>$ accelerations identical in all frames, particles free in $S$ are free in $S'$]

#entry[Lorentz transformations:][$t != t'$, based on two assumptions: 1. spacetime homogeneous, 2. $c = c'$ $forall$ observers. Classification of events valid in all frames: $dif s^2 > 0$ timelike, $dif s^2 = 0$ lightlike, $dif s^2 < 0$ spacelike]

#entry[Proper time][$tau$ displayed by comoving clock; $dif s^2 = c^2 dif tau^2$, $dif tau = 1/gamma dif t$]

#entry[(Weak) equivalence principle:][$m_i = m_g$, i.e. inertial and gravitational mass of any object are equal]

#entry[Length of a curve $C$][parametrized by $lambda$: $I = integral_C dd(s) = integral_C sqrt(|g_(mu nu) dif x^mu dif x^nu|) = integral_a^b dd(lambda) sqrt(|g_(mu nu) (dif x^mu)/(dif lambda) (dif x^nu)/(dif lambda)|)$, area: $dif A = sqrt(|g_(mu nu)|) dif x^mu dif x^nu attach(=, t: 2 d) sqrt(|g_11 g_22|) dif x^1 dif x^2$]

#entry[Riemannian manifolds][are locally Cartesian, i.e. can locally be matched to Minkowski space]

#entry[Christoffel symbols (affine connection):][$Gamma^rho_(mu nu) = 1/2 g^(rho sigma) (partial_mu g_(nu sigma) + partial_nu g_(sigma mu) - partial_sigma g_(mu nu))$, can be obtained by diff. $g_(mu nu) = arrow(e)_mu dot arrow(e)_nu$ w.r.t. $x^rho$ and cyclically perm. indices; $Gamma^rho_(mu nu) = arrow(e)^rho partial/(partial x^nu) arrow(e)_mu$; equivalence: locally Cartesian $<->$ vanishing connection; torsion $T^alpha_(mu nu) := Gamma^alpha_(mu nu) - Gamma^alpha_(nu mu)$]

#entry[Cov. derivative][of contravector $nabla_mu V^nu = partial_mu V^nu + Gamma^nu_(mu rho) V^rho$, of covector $nabla_mu V_nu = partial_mu V_nu - Gamma^rho_(mu nu) V_rho$; $nabla_mu V^nu = partial_mu V^nu$ if locally Cartesian]

#entry[Geodesic][(on torsion-free manifold): shortest connection of two points, more generally curve with constant tangent. Geodesic equation (eq. of parallel transport): $(dd(2, x)^mu)/(dif lambda^2) + Gamma^mu_(rho sigma) (dif x^rho)/(dif lambda) (dif x^sigma)/(dif lambda) = 0 = (dif u^mu)/(dif lambda) + Gamma^mu_(rho sigma) u^rho u^sigma$, path-dependent due to varying $Gamma^mu_(rho sigma)$]

#entry[Riemann tensor][$R^rho_(sigma mu nu) = partial_mu Gamma^rho_(nu sigma) - partial_nu Gamma^rho_(mu sigma) + Gamma^rho_(mu lambda) Gamma^lambda_(nu sigma) - Gamma^rho_(nu lambda) Gamma^lambda_(mu sigma)$, $R_(rho sigma mu nu) = g_(rho lambda) R^lambda_(sigma mu nu)$; symmetries: $R_(rho sigma mu nu) = -R_(sigma rho mu nu) = R_(sigma rho nu mu)$, $R_(rho sigma mu nu) = R_(mu nu rho sigma)$, $R_(rho sigma mu nu) + R_(rho mu nu sigma) + R_(rho nu sigma mu) = 0$, $d = n^2/12 (n^2 - 1)$ indep. comp.; metric's comp. constant $<==>$ $R^rho_(sigma mu nu) = 0$ $<==>$ space flat]

#entry[Ricci tensor][$R_(mu nu) = R^lambda_(mu lambda nu) = R_(nu mu)$, Ricci scalar $R = R^mu_mu = g^(mu nu) R_(mu nu)$]

#entry[Bianchi identity][$nabla_lambda R_(rho sigma mu nu) + nabla_rho R_(sigma lambda mu nu) + nabla_sigma R_(lambda rho mu nu) = 0$; Riemann tensor on 2-sphere $R^i_(j k m) = 1/r^2 (delta^i_k g_(j m) - delta^i_m g_(j k))$]

#entry[Energy-mom. tensor of perfect fluid][(:= isotropic in its rest frame) $T^(mu nu) = (rho + p/c^2) u^mu u^nu - p eta^(mu nu) = "diag"(rho c^2, p, p, p)$]

#entry[Einstein field eqs.][$G_(mu nu) = R_(mu nu) - R/2 g_(mu nu) = (8 pi G)/c^4 T_(mu nu)$]

#entry[FLRW:][$dif s^2 = c^2 dif t^2 - a^2(t) [(dif r^2)/(1 - k r^2) + r^2 dif theta^2 + r^2 sin^2 theta dif phi^2]$, inv. under $k -> k\/|k|$, $r -> sqrt(|k|) r$, $a -> a\/sqrt(|k|)$; metric singular at $r = plus.minus 1$
  - $k = -1 <-> $ negative curvature $<->$ open universe $<-> rho < rho_"crit" <-> Omega < 1$
  - $k = 0 <-> $ no curvature $<->$ flat universe $<-> rho = rho_"crit" <-> Omega = 1$
  - $k = 1 <-> $ positive curvature $<->$ closed universe $<-> rho > rho_"crit" <-> Omega > 1$

  For $k = plus.minus 1 ->$ new radial coordinate $r = sin chi$ ($k = 1$) or $r = sinh chi$ ($k = -1$), $(dif r)/(dif chi) = sqrt(1 minus.plus r^2)$; $rho_"crit" = (3 H^2)/(8 pi G)$; \
  $Gamma^1_11 = (k r)/(1 - k r^2)$, $Gamma^0_11 = (a dot(a))/(c(1 - k r^2))$, $Gamma^0_22 = (a dot(a) r^2)/c$, $Gamma^0_33 = (a dot(a) r^2)/c sin^2 theta$, $Gamma^1_01 = Gamma^1_10 = Gamma^2_02 = Gamma^2_20 = Gamma^3_30 = Gamma^3_03 = dot(a)/(c a)$, $Gamma^1_22 = -r(1 - k r^2)$, $Gamma^1_33 = Gamma^1_22 sin^2 theta$, $Gamma^2_33 = -sin theta cos theta$, $Gamma^2_12 = Gamma^2_21 = Gamma^3_13 = Gamma^3_31 = 1/r$, $Gamma^3_32 = cot theta$; \
  $R_00 = -3 dot.double(a)/(c^2 a)$, $R_11 = 1/c^2 (a dot.double(a) + 2 dot(a)^2 + 2 c^2 k)/(1 - k r^2)$, $R_22 = r^2/c^2 (a dot.double(a) + 2 dot(a)^2 + 2 c^2 k)$, $R_33 = R_22 sin^2 theta$, $R = -6/(c^2 a^2) (a dot.double(a) + dot(a)^2 + c^2 k)$]

#entry[Friedmann eqs.:][$H^2 = dot(a)^2/a^2 = 8/3 pi G rho + c^2/3 Lambda - c^2/a^2 k$, $dot.double(a)/a = -(4 pi G)/3 (rho + 3/c^2 p) + c^2/3 Lambda$; eq. of state $w = p\/rho c^2$]

#entry[Schwarzschild:][$dif s^2 = -(1 - (2 G M)/r) dif t^2 + (dif r^2)/(1 - (2 G M)/r) + r^2 dif Omega^2$, contains two symmetry assumptions: sphericity & static; asymptotically flat for $r -> oo$ or $M -> 0$; $g_(t t)$ and $g_(r r)$ switch sign at $r = r_s = (2 G M)/c^2$ $=>$ light cones flip and are undefined at $r_s$; \
  $Gamma^1_00 = (G M)/r^3 (r - 2 G M)$, $Gamma^1_11 = (-G M)/(r(r - 2 G M)) = -Gamma^0_01$, $Gamma^2_12 = Gamma^2_21 = Gamma^3_13 = Gamma^3_31 = 1/r$, $Gamma^1_22 = -r(1 - (2 G M)/r)$, $Gamma^1_33 = Gamma^1_22 sin^2 theta$, $Gamma^2_33 = -sin theta cos theta$, $Gamma^3_23 = cot theta$; \
  $R^(mu nu rho sigma) R_(mu nu rho sigma) = (12 r_s^2)/r^6$ (while $R = 0$) $-->$ curvature finite except at $r = 0$; in Kruskal coord. $(u, v, theta, phi)$: $dif s^2 = (4 r_s^3)/r e^(-r/(2 G M)) (dif v^2 - dif u^2) + r^2 dif Omega^2$]

#entry[Linearized gravity:][$square overline(h)^(mu nu) = -(16 pi G)/c^4 T^(mu nu)$, gauge: $partial_nu overline(h)^(mu nu) = 0$, $overline(h)^(mu nu) = h^(mu nu) - h/2 eta^(mu nu)$ (harmonic gauge condition $partial_mu overline(h)^mu_nu = 0$); in vacuum: $square overline(h)^(mu nu) = 0$ solved by plane wave $overline(h)^(mu nu) = A^(mu nu) e^(plus.minus i k_sigma x^sigma)$ with $k^2 = 0$; traceless transverse gauge fixes all gauge freedom, leaves 2 physical d.o.f., $overline(h)^"TT"_(mu nu) = h^"TT"_(mu nu)$, $A^(mu nu)_"TT" = mat(0, 0, 0, 0; 0, a, b, 0; 0, b, -a, 0; 0, 0, 0, 0)$]

#entry[Lie derivative][of $V$ w.r.t. vector field $a$: $cal(L)_a V^mu = a^nu partial_nu V^mu - V^nu partial_nu a^mu$, $cal(L)_a V_mu = a^nu partial_nu V_mu + V_nu partial_mu a^nu$; $cal(L)_a g_(mu nu) = nabla_nu a_mu + nabla_mu a_nu$ for metric compatible connection; if $cal(L)_xi g_(mu nu) = 0$, then $xi$ is Killing vector field]

#entry[][Killing vector fields are vector fields on a Riemannian manifold that preserve the metric. They are the infinitesimal generators of isometries which in turn generate symmetries.]


== Useful formulae from exercises

- harmonic oscillator $m dot.double(x) = -k x$ with angular frequency $omega = sqrt(k/m) = (2 pi)/T$ and period $T$, $x(t) = A cos(omega t + phi)$, potential energy $U = 1/2 k x^2(t)$
- gravit. force $F_g = -(G m_1 m_2)/r^2$, centrifugal force $F_c = (m_2 v^2)/r$; in stable orbit $-F_g = F_c ==>$ orbital velocity $v = sqrt((G m_1)/r)$
- e.o.m. invariant under $L(q, dot(q), t) --> alpha L(q, dot(q), t) + dif/(dif t) f(q, t)$, this yields symmetries and conservation laws, $(partial L)/(partial q_i) = 0 => dif/(dif t) (partial L)/(partial dot(q)_i) = dif/(dif t) p_i = 0$
- escape velocity follows from $T + V = m/2 v_"esc"^2 - (G m M)/r = 0 ==> v_"esc" = sqrt((2 G M)/r)$, for $v_"esc" = c$, we get $R_s = (2 G M)/c^2$
- $eta_(mu nu) = Lambda^rho_mu Lambda^sigma_nu eta_(rho sigma)$ follows from requiring $|x'|^2 = |x|^2$
- relativistic velocity addition: $w = (u + v)/(1 + (u v)/c^2)$; proper velocity $v = s/tau = (1/gamma d)/tau = sqrt(1 - v^2/c^2) d/tau$, where e.g. $d/tau = c$ for $d = x$ ly and $tau = x$ years; relativistic Doppler effect: observer moving away with $v$ measures frequency $f' = sqrt((1 - beta)/(1 + beta)) f_0$; two events separated by timelike (spacelike) intervals, i.e. $Delta s^2 > (<) 0$, may have (may not have) cause-effect relationship, $exists$ frame s.t. events at same location (time)
- weak field limit: holds for slowly moving particles ($v << c$) and weak gravitational fields $g_(mu nu) = eta_(mu nu) + h_(mu nu)$ with $|h_(mu nu)| << 1$ (that are static, i.e. $partial_0 g_(mu nu) = 0$)
- Christoffel symbols in spherical coord.: $Gamma^1_22 = -r$, $Gamma^1_33 = -r sin^2 theta$, $Gamma^2_12 = Gamma^2_21 = 1/r$, $Gamma^2_33 = -sin theta cos theta$, $Gamma^3_13 = Gamma^3_31 = 1/r$, $Gamma^3_23 = Gamma^3_32 = cot theta$, all others zero
- effective potential for orbiting objects $V_"eff" (r) = -(G M)/r + L^2/(2 r^2) - (G M L^2)/(c^2 r^3)$, where last term is a pure GR contribution
- particles experiencing grav. waves don't change their position because of them
- Pauli matrices $sigma_1 = mat(0, 1; 1, 0)$, $sigma_2 = mat(0, -i; i, 0)$, $sigma_3 = mat(1, 0; 0, -1)$
- coordinate transformations: \
  Cartesian $<->$ spherical $vec(x, y, z) = vec(r cos phi sin theta, r sin phi sin theta, r cos theta)$, $vec(r, theta, phi) = vec(sqrt(x^2 + y^2 + z^2), arccos(z\/sqrt(x^2 + y^2 + z^2)), arctan(y\/x))$; \
  Cartesian $<->$ cylindrical $vec(x, y, z) = vec(rho cos phi, rho sin phi, z)$, $vec(rho, phi, z) = vec(sqrt(x^2 + y^2), arcsin(y\/rho), z)$; \
  Cartesian $<->$ ellipsoidal $vec(x, y, z) = vec((r^2 + a^2)^(1\/2) sin theta cos phi, (r^2 + a^2)^(1\/2) sin theta sin phi, r cos theta)$; \
  Cartesian $<->$ ellipsoid $vec(x, y) = vec(a cosh mu cos nu, a sinh mu sin nu)$; \
  Cartesian $<->$ hyperbolic $vec(x, y) = vec(v e^u, v e^(-u))$, $vec(u, v) = vec(1/2 ln(x\/y), sqrt(x y))$
- Tensor $underline(T)$ of rank $(k, l)$ is a multilinear map that takes $k$ dual vectors and $l$ vectors and projects them onto a number in $RR$. \
  Expansion: $underline(T) = T^(mu_1 dots mu_k)_(nu_1 dots nu_l) partial_(mu_1) times.o dots.c times.o partial_(mu_k) times.o dif x^(nu_1) times.o dots.c times.o dif x^(nu_l)$. \
  Transformation: $T^(mu'_1 dots mu'_k)_(nu'_1 dots nu'_l) = (partial x^(mu'_1))/(partial x^(mu_1)) dots.c (partial x^(mu'_k))/(partial x^(mu_k)) (partial x^(nu_1))/(partial x^(nu'_1)) dots.c (partial x^(nu_l))/(partial x^(nu'_l)) T^(mu_1 dots mu_k)_(nu_1 dots nu_l)$ \
  Christoffel symbol transformation $Gamma^(alpha')_(mu' nu') = (partial x^mu)/(partial x^(mu')) (partial x^nu)/(partial x^(nu')) (partial x^(alpha'))/(partial x^alpha) Gamma^alpha_(mu nu) - (partial x^mu)/(partial x^(mu')) (partial x^nu)/(partial x^(nu')) (partial^2 x^(alpha'))/(partial x^mu partial x^nu)$
