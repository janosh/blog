#import "/notes.typ": task, vb, kB, unit, pd, eqby
#import "/statistical-physics/sheet.typ": points, sheet
#import "@preview/cetz:0.5.2": canvas
#import "@preview/cetz-plot:0.1.4": plot

#show: sheet.with(4, [November 25th, 2016])


// zeroth to second order virial isotherms for R = 8.31 J/(mol K), T = 300 K, B_1 = 10^3, B_2 = -10^3
#let virial-isotherms = canvas({
  let RT = 8.31 * 300
  let (B1, B2) = (1e3, -1e3)
  let p0(v) = RT / v
  let p1(v) = p0(v) + B1 / (v * v)
  let p2(v) = p1(v) + B2 / (v * v * v)
  plot.plot(
    size: (6, 4.5),
    x-label: $v thin ["m"^3 \/ "mol"]$,
    y-label: $p thin ["Pa"]$,
    x-tick-step: 1,
    y-tick-step: 2000,
    y-format: y => str(int(y)).clusters().rev().chunks(3).map(c => c.rev().join()).rev().join(","),
    y-min: 0,
    legend: "inner-north-east",
    {
      for (f, paint, label) in (
        (p0, red, $p_0 = R T \/ v$),
        (p1, blue, $p_1 = p_0 + B_1 \/ v^2$),
        (p2, orange, $p_2 = p_1 + B_2 \/ v^3$),
      ) { plot.add(f, domain: (0.5, 5.5), samples: 200, style: (stroke: paint + 0.8pt), label: label) }
    },
  )
})

// Maxwell-Boltzmann speed distribution P(v) of a particle of mass 1 u at three temperatures
#let maxwell-speeds = canvas({
  let (m, kB) = (1.66e-27, 1.38e-23)
  let P(T) = v => {
    let a = m / (2 * kB * T)
    4 * calc.pi * calc.pow(a / calc.pi, 1.5) * v * v * calc.exp(-a * v * v) * 1e4
  }
  plot.plot(
    size: (6, 4.5),
    x-label: $v thin ["m/s"]$,
    y-label: $P(v) thin [10^(-4)]$,
    x-tick-step: 2000,
    x-format: x => str(int(x)).clusters().rev().chunks(3).map(c => c.rev().join()).rev().join(","),
    y-tick-step: 2,
    y-min: 0,
    legend: "inner-north-east",
    {
      for (T, paint) in ((100, red), (300, rgb("#e6c200")), (1000, blue)) {
        plot.add(P(T), domain: (0, 8000), samples: 200, style: (stroke: paint + 0.8pt), label: [#T~K])
      }
    },
  )
})

= Virial coefficients #points(2)

#task[
  Let the equation of state of a gas be given by#footnote[@eq:dieterici is known as the Dieterici equation of state. Similar to the van der Waals' equation, $a > 0$ takes into account molecular interactions and $b > 0$ models molecules of finite size.]
  $ p = (R T)/(v - b) e^(-a/(v R T)). $ <eq:dieterici>
  Compute the first two virial coefficients $B_1 (T)$ and $B_2 (T)$. Discuss qualitatively the shape of the isotherms to zeroth, first, and second order in the virial expansion assuming $B_1 > 0$ and $B_2 < 0$.
]

The virial expansion yields the pressure $p$ of a thermodynamic system in equilibrium as a power series in the number density $n \/ V = 1/v$. The factor in front of the $1 \/ v^2$ term is called the first virial coefficient, the one in front of $1 \/ v^3$ is the second and so on. In the case of @eq:dieterici, using the geometric series for $(R T)/(v - b)$ (where we assume $v > b$) and Taylor-expanding the exponential gives
$
  (p v)/(R T) & = 1/(1 - b/v) e^(-a/(v R T)) = sum_(i=0)^infinity (b/v)^i sum_(j=0)^infinity 1/j! ((-a)/(v R T))^j \
  & = (1 + b/v + b^2/v^2 + cal(O)(v^(-3))) (1 - a/(v R T) + a^2/(2 v^2 R^2 T^2) + cal(O)(v^(-3))) \
  & = 1 + b/v + b^2/v^2 - a/(v R T) + a^2/(2 v^2 R^2 T^2) - (a b)/(v^2 R T) + cal(O)(v^(-3)) \
  & = 1 + (b - a/(R T)) 1/v + (b^2 + a^2/(2 R^2 T^2) - (a b)/(R T)) 1/v^2 + cal(O)(v^(-3)).
$
Thus,
$ B_1 (T) = b R T - a, #h(3em) B_2 (T) = b^2 R T - a b + a^2/(2 R T). $
These coefficients give the following zeroth, first and second order virial approximations to the pressure @eq:dieterici,
$
  p_0 & = (R T)/v, \
  p_1 & = p_0 + B_1/v^2 = (R T)/v + (b R T - a)/v^2, \
  p_2 & = p_1 + B_2/v^3 = (R T)/v + (b R T - a)/v^2 + (b^2 R T - a b + a^2/(2 R T))/v^3.
$
For $B_1 > 0$ and $B_2 < 0$, these equations of state produce isotherms as plotted below.#footnote[For this plot, we set $R = 8.31 unit("J") unit("mol")^(-1) unit("K")^(-1)$, $T = 300 unit("K")$, $B_1 = 10^3 unit("J") unit("m")^3 unit("mol")^(-2)$, $B_2 = -10^3 unit("J") unit("m")^6 unit("mol")^(-3)$.] Note however, that we can rewrite $B_2$ as
$ B_2 (T) = R T (b - a/(2 R T))^2 + a^2/(4 R T), $
which is non-negative for all $a, b in RR$ and $R, T >= 0$, meaning $B_2 < 0$ is not a physical choice.
#align(center, virial-isotherms)
This plot shows that higher order virial corrections become negligible for large volumes $v$. This is expected since an expansion in $1 \/ v$ converges quickly for large $v$. On the other hand, at intermediate $v approx 1$, higher order corrections change the pressure dependence substantially. For small $v$, we expect the virial approximation to break down. Indeed, the maximum of the $p_2$-isotherm is situated at
$ v^2 + (2 B_1)/(R T) v - (3 |B_2|)/(R T) limits(=)^! 0 wide => wide v_max = -B_1/(R T) + sqrt(B_1^2/(R T)^2 + 3 (|B_2|)/(R T)). $
For volumes below $v_max$, the approximation $p_2$ loses validity as evidenced by the fact that it predicts a rapid drop in pressure (even reaching negative values) with decreasing volume.

= Specific heat #points(2)

#task[
  Show that the specific heat $c_V = C_V \/ n$ of a van der Waals gas depends only on temperature. Derive the adiabatic equation for this gas in case of constant $c_V$.
]

The heat capacity at constant volume is defined as
$ C_V = pd(U, T, V) = T pd(S, T, V), $
The second equality follows from the first law $dif U = T dif S - p dif V$ by expanding both $dif U$ and $dif S$ as functions of $V$ and $T$ and comparing coefficients of $dif T$. Differentiating w.r.t. $V$ at constant $T$ and inserting the Maxwell relation
$ pd(S, V, T) = pd(p, T, V) $
that derives from $dif F = -S dif T - p dif V$, we obtain
$ pd(C_V, V, T) = T (partial^2 S)/(partial T partial V) = T lr((partial^2 p)/(partial T^2) |)_V. $ <eq:cv-derivative>
Van der Waals' equation states that pressure is an affine function of the temperature,
$ p = (R T)/(v - b) - a/v^2. $ <eq:vdw>
Thus, inserting @eq:vdw into @eq:cv-derivative, we conclude that $C_V (T)$ is independent of the volume. The same, of course, holds for $c_V$.

Alternatively, we could write the first law per mole and rearrange to get $dif s = 1/T (dif u + p dif v)$. Expanding $dif u$ for $u = u(v, T)$ and using that $dif s$ is exact yields
$ pd(u, v, T) = T pd(p, T, V) - p = a/v^2, $
which implies
$ pd(c_V, v, T) = (partial^2 u)/(partial T partial v) = 0. $
To find the adiabatic equation of a van der Waals gas, we set $delta Q = 0$ to obtain
$ dif U = pd(U, T, V) dif T + pd(U, V, T) dif V = delta W = -p dif V. $ <eq:adiabatic>
To compute the partial derivatives of $U$, we need van der Waals's caloric equation of state. It can be derived by integrating the first equality in @eq:adiabatic at constant $T$,
$ integral_(V_0)^V dif U = integral_(V_0)^V pd(U, V, T) dif V eqby("eq:helmholtz") integral_(V_0)^V T^2 lr(partial/(partial T) p/T |)_V dif V eqby("eq:vdw-p-t") integral_(V_0)^V (a N^2)/V^2 dif V $ <eq:caloric>
where we used the Helmholtz equation
$ pd(U, V, T) = T^2 lr(partial/(partial T) p/T |)_V, $ <eq:helmholtz>
and inserted the van der Waals equation of state
$ p/T = R/(v - b) - 1/T a/v^2. $ <eq:vdw-p-t>
Performing the integral in @eq:caloric gives
$ U_"vdW" (T, V, N) = U_"vdW" (T, V_0, N) - a N^2 (1/V - 1/V_0). $
When the volume tends to infinity, van der Waals equation of state approaches the ideal gas law which implies $U_"vdW" -> U_"ideal" = n c_V T$ with molar heat capacity $c_V = C_V \/ n = 3/2 R$ for a monatomic ideal gas.#footnote[Heat capacity is the change in internal energy w.r.t. a change in temperature. Since the second term in @eq:u-vdw does not depend on $T$, the heat capacity (at constant volume) of a van der Waals gas is the same as that of the ideal gas.] In the limit $V_0 -> infinity$, we thus get
$ U_"vdW" (T, V, N) = U_"ideal" (T, N) - (a N^2)/V, $ <eq:u-vdw>
From @eq:u-vdw, we get the following partial derivatives of the internal energy,
$ pd(U, T, V) = c_V, #h(3em) pd(U, V, T) = a/v^2. $
Inserting these expressions into @eq:adiabatic yields
$ c_V dif T + (p + a/v^2) dif V = c_V dif T + (R T)/(v - b) dif V = 0. $
Dividing by $R T$ and integrating results in
$ c_V/R ln(T) + ln(v - b) = alpha wide => wide (v - b) T^(c_V/R) = beta, $ <eq:adiabat>
with $beta = e^alpha$ an integration constant. @eq:adiabat governs adiabatic processes in van der Waals gases.

= Maxwell distribution and Gaussian integrals #points(3)

#task[
  Calculate the normalization $cal(N)$, the mean value $macron(v)$ of the absolute value of the velocity, and the most probable value $v_p$ of the absolute value of the velocity, for the Maxwell distribution $w(vb(v)) = cal(N) exp(-(m vb(v)^2)/(2 kB T))$ in three-dimensional space.
]

Since the Maxwell distribution is a Gaussian, its integral in any number of dimensions $d$ factorizes into $d$ identical one-dimensional integrals, each again a Gaussian.
$ integral_(RR^d) w(vb(v)) dif^d v = cal(N) (integral_(-infinity)^infinity e^(-(m v^2)/(2 kB T)) dif v)^d = cal(N) ((2 pi kB T)/m)^(d/2) limits(=)^! 1. $
Thus
$ cal(N) = (m/(2 pi kB T))^(d/2). $ <eq:norm>
The mean velocity $macron(v)$ is the expectation value of $v$ w.r.t. to the Maxwell distribution,
$ macron(v) = integral_(RR^d) v w(vb(v)) dif^d v. $
Since we are only interested in the magnitude of the velocity vector and the Maxwell distribution itself is isotropic, this integral is best performed in spherical coordinates with trivial angular integration. In $d = 3$, we get $dif^3 v = 4 pi v^2 dif v$,
$
  macron(v) & = 4 pi cal(N) integral_0^infinity v^3 e^(-(m v^2)/(2 kB T)) dif v = 4 pi cal(N) integral_0^infinity cancel(v) x e^(-(m x)/(2 kB T)) (dif x)/(2 cancel(v)) \
  & = 2 pi cal(N) (-(2 kB T)/m underbrace(lr(x e^(-(m x)/(2 kB T)) |)_0^infinity, 0) + (2 kB T)/m underbrace(integral_0^infinity e^(-(m x)/(2 kB T)) dif x, (2 kB T)/m)) \
  & = (8 pi k_upright(B)^2 T^2)/m^2 cal(N) eqby("eq:norm") sqrt((8 kB T)/(pi m)),
$
where we first used the substitution $x = v^2$, $dif x = 2 v dif v$ and then integrated by parts with vanishing boundary terms. \
The most probable velocity, $v_p$, is simply the one for which the Maxwell distribution $w(vb(v)) dif^3 v$ maximizes. One must be careful at this point not to jump to the conclusion $v_p = 0$ based on
$ e^(-(m v^2)/(2 kB T)) < 1 #h(3em) forall vb(v)^2 > 0. $
This would neglect the velocity-dependence of the measure itself. Reverting again to spherical coordinates, we can write
$ w(vb(v)) dif^3 v = underbrace(4 pi cal(N) v^2 e^(-(m v^2)/(2 kB T)), P(v)) dif v, $ <eq:speed-dist>
where all $v$-dependence is now explicit. To find the magnitude of the velocity $v_p$ at which @eq:speed-dist maximizes, we set its derivative to zero,
$ dif/(dif v) (v^2 e^(-(m v^2)/(2 kB T))) = (2 v - v^2 (m v)/(kB T)) e^(-(m v^2)/(2 kB T)) limits(=)^! 0. $ <eq:max>
@eq:max is satisfied for $v = 0$, which is obviously not a maximum since $P(v = 0) = 0$, and for
$ v_p = sqrt((2 kB T)/m). $
Evaluating the second derivative of $v^2 e^(-(m v^2)/(2 kB T))$ at this point gives $-4/e < 0$, which identifies $v_p$ as a maximum. Plotting the Maxwell-Boltzmann distribution at different temperatures, we indeed find that the most probable velocity scales with $v_p prop sqrt(T)$.#footnote[In this plot, we set the mass $m = 1 unit("u") approx 1.66 times 10^(-27) unit("kg")$ to one atomic mass unit.]
#align(center, maxwell-speeds)

= Phase space volume #points(3)

#task[
  Show that the volume in $mu$-space remains invariant under time evolution, $dif^3 x dif^3 p = dif^3 x' dif^3 p'$, assuming that the external force $F$ depends only on $x$ but not on $dot(x)$ or higher derivatives. Show this first in one space dimension and then argue what changes in three dimensions.
]

We skip the one-dimensional case. In three dimensions, the $mu$-space volume element $dif^3 x dif^3 p$ is centered on the point $(vb(x), vb(p))$ in phase space. Under time evolution, it will be advected by the flow of probability to a new position $(vb(x)', vb(p)')$. Depending on the properties of the flow, the volume element will be deformed, i.e. compressed in some dimensions and stretched in others. \
To show that the volume of $dif^3 x dif^3 p$ is conserved under time evolution despite any warping that may take place (as long as the external force is velocity-independent), we Taylor expand
$ (vb(x)'(t), vb(p)'(t)) equiv (vb(x)(t + delta t), vb(p)(t + delta t)) $
around $t$ for $delta t << 1$,
$ (vb(x)'(t), vb(p)'(t)) = (vb(x)(t), vb(p)(t)) + (dot(vb(x))(t), dot(vb(p))(t)) delta t + cal(O)(delta t^2). $
Defining $vb(w) = (vb(x), vb(p))$ and $vb(w)' = (vb(x)', vb(p)')$, we can write this as
$ vb(w)'(t) = vb(w)(t) + dot(vb(w)) delta t + cal(O)(delta t^2). $
Using component notation and differentiating w.r.t. $w_j$ gives the Jacobian of time evolution,
$ J_(i j) = (partial w'_i)/(partial w_j) = delta_(i j) + (partial dot(w)'_i)/(partial w_j) delta t + cal(O)(delta t^2) tilde.eq exp((partial dot(w)'_i)/(partial w_j) delta t) + cal(O)(delta t^2), wide i, j in {1, ..., 6}, $
which allows us to write the relation between the two volume elements as
$ dif^6 w' = det(J) dif^6 w. $
For any matrix $M$ we have $ln det(M) = "tr" ln(M)$, hence
$
  ln det(J) & = "tr" ln(J) = "tr"((partial dot(w)'_i)/(partial w_j)) delta t + cal(O)(delta t^2) \
            & = sum_(i=1)^6 ((partial dot(w)'_i)/(partial w_i)) delta t + cal(O)(delta t^2) = (vb(nabla)_w dot dot(vb(w))) delta t + cal(O)(delta t^2).
$
Under time evolution, the volume element therefore scales with
$ dif^3 x' dif^3 p' = exp[(vb(nabla)_w dot dot(vb(w))) delta t] dif^3 x dif^3 p + cal(O)(delta t^2). $ <eq:volume-scaling>
From this expression, we infer that it is the divergence of $dot(vb(w))$ alone that governs the time evolution of a volume element in phase space. Reexpanding $vb(nabla)_w dot dot(vb(w))$, we get
$ vb(nabla)_w dot dot(vb(w)) = (partial dot(x)_i)/(partial x_i) + (partial dot(p)_j)/(partial p_j) = 1/m (partial p_i)/(partial x_i) + 1/m (partial dot(p)_j)/(partial dot(x)_j) = 0. $ <eq:divergence>
The first term vanishes because $p_i$ and $x_i$ are independent variables. In the second term, $dot(p)_j$ is simply the force in $j$-direction which is assumed not to depend on velocity. Inserting @eq:divergence into @eq:volume-scaling gives
$ dif^3 x' dif^3 p' = dif^3 x dif^3 p. $
This result holds not only for infinitesimal time steps but the error $cal(O)(delta t^2)$ vanishes even across a finite time span $Delta t = N delta t$ with $N -> infinity$ as $delta t -> 0$ such that $Delta t$ remains constant, since
$ lim_(N -> infinity) (1 + cal(O)(delta t^2))^N = exp[N cal(O)(delta t^2)] = exp[(Delta t)/(delta t) cal(O)(delta t^2)] limits(-->)^(delta t -> 0) 1. $
