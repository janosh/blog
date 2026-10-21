#import "/notes.typ": task, pd, eqby
#import "/statistical-physics/sheet.typ": points, sheet
#import "@preview/plotsy-3d:0.2.1": plot-3d-surface

#show: sheet.with(3, [November 18th, 2016])


// F(T, V) is concave in T and convex in V, i.e. saddle-shaped (adapted from janosh/diagrams)
#let saddle = plot-3d-surface(
  (v, t) => v * v - t * t,
  color-func: (..) => rgb("#00008B").transparentize(50%),
  subdivisions: 8,
  xdomain: (-2, 2),
  ydomain: (-2, 2),
  scale-dim: (0.1, 0.06, 0.03),
  axis-label-size: 1em,
  axis-label-offset: (0.16, 0.12, 0.12),
  axis-labels: ($V$, $T$, $F(T, V)$),
  axis-step: (1, 1, 2),
)

= Black-body radiation #points(3)

#task[
  Consider the energy $U$ of a general thermodynamic system as a function of $T$ and $V$, with the usual differential work for reversible processes $delta W = -p dif V$.
  + Show that
    $ p = T pd(p, T, V) - pd(U, V, T). $
  + For black-body radiation in a cavity of volume $V$, the caloric equation of state is $U(T, V) = u(T) V$, and the thermal equation of state is $p = 1/3 u(T)$, where $u(T)$ is a function of $T$ alone. Calculate $p$ and $U$ explicitly as functions of $T$ and $V$.
]

+ Inserting the state functions $U(T, V)$ and $S(T, V)$ into $dif U = T dif S - p dif V$ yields
  $ T dif S = T pd(S, T, V) dif T + T pd(S, V, T) dif V = pd(U, T, V) dif T + pd(U, V, T) dif V + p dif V. $ <eq:tds>
  @eq:tds must hold both at constant temperature $dif T = 0$ and constant volume $dif V = 0$. Thus the coefficients of $dif T$ and $dif V$ on both sides must be equal,
  $ T pd(S, T, V) = pd(U, T, V), #h(3em) T pd(S, V, T) = pd(U, V, T) + p. $
  Partially differentiating these two relations w.r.t. $V$ and $T$, respectively, we obtain
  $ (partial^2 S)/(partial V partial T) = partial/(partial V) (1/T pd(U, T, V)), #h(3em) (partial^2 S)/(partial T partial V) = partial/(partial T) (1/T pd(U, V, T) + p/T). $
  As a state function, $S(T, V)$ is twice continuously differentiable. By Schwarz' lemma, the partial derivatives commute, giving
  $ cancel(1/T (partial^2 U)/(partial V partial T)) = -1/T^2 pd(U, V, T) + cancel(1/T (partial^2 U)/(partial T partial V)) + 1/T pd(p, T, V) - p/T^2. $
  Solving the above for the pressure, we arrive at
  $ p = T pd(p, T, V) - pd(U, V, T). $ <eq:pressure>
+ The electromagnetic field inside a cavity, also known as "Hohlraumstrahlung", is created from thermal radiation emitted by the cavity's inner surface. The walls continually emit and absorb radiation until thermal equilibrium is attained, at which point both radiation and thermodynamic properties of the walls no longer change over time. The radiation is then known to be homogeneous, isotropic, and unpolarized. Experiments show that the energy density $u$ of the cavity radiation remains constant under changes in volume of the cavity at fixed temperature. Therefore, we may conjecture that the energy density is a function of temperature only, yielding the caloric equation of state $U = u(T) V$.

  Modelling the cavity radiation as a photon gas, we must assign it a pressure $p$ like any ordinary gas. Thermodynamics cannot provide information about this pressure. However, electromagnetism shows that the pressure exerted by the photon gas fulfills the equation of state $p = 1/3 u(T)$. \
  The radiation thus constitutes a thermodynamic system completely specified by its pressure, the cavity's volume and the temperature of the walls (assumed to be in equilibrium with the radiation and therefore loosely called the temperature of the radiation). We can apply our result from part a) to this case and insert $U = u(T) V$ and $p = 1/3 u(T)$ to obtain
  $ 1/3 u(T) = T/3 lr((dif u(T))/(dif T) |)_V - u(T). $
  Separating variables and integrating on both sides, we arrive at
  $ integral (dif u)/u = 4 integral (dif T)/T wide => wide ln(u) = 4 ln(T) + a, $
  and so $u = b T^4$, where $b = e^a in RR$ is an integration constant. Thus,
  $ U = b T^4 V, #h(3em) p = b/3 T^4. $

= Gibbs free enthalpy #points(2)

#task[
  Consider the Gibbs free enthalpy $G = U - T S + p V$.
  + Starting from the fact that $S$ and $V$ are the natural variables for $U$, determine what the natural variables for $G$ are. Write $dif G$ as a differential in terms of these natural variables and derive the Maxwell relations that result from it.
  + Which variables need to be fixed in a reversible process for $dif G$ to be zero? How does the free enthalpy change if the same variables remain fixed, but the process is irreversible? Which kind of extremum does $G$ reach in equilibrium?
]

+ $U$ having natural variables $S$ and $V$ amounts to $dif U = T dif S - p dif V$. Thus
  $
    dif G & = dif (U - T S + p V) = cancel(T dif S) - cancel(p dif V) - cancel(T dif S) - S dif T + cancel(p dif V) + V dif p \
          & = -S dif T + V dif p.
  $ <eq:dg>
  From this, we can read off the natural variables of $G$ as $T$ and $p$. Its total differential, therefore reads
  $ dif G = pd(G, T, p) dif T + pd(G, p, T) dif p. $ <eq:dg-total>
  Comparing coefficients in @eq:dg and @eq:dg-total yields
  $ S = -pd(G, T, p), #h(3em) V = pd(G, p, T). $
  In multivariate calculus, a differential $H$ is said to be exact if it is of the form $H = dif F$, for some differentiable function $F$. Thus, $dif G$ is an exact one-form by construction since it was obtained by taking the exterior derivative of the zero-form state function $G$. Since we know $dif G$ to have an antiderivative, it must fulfill Schwarz's integrability condition, meaning the second partial derivatives of $G$ w.r.t $T$ and $p$ must commute. From this, we obtain the Maxwell relation
  $ pd(S, p, T) = -(partial^2 G)/(partial T partial p) = -(partial^2 G)/(partial p partial T) = -pd(V, T, p). $
+ From @eq:dg, it is clear that $dif G = 0$ if $dif T = dif p = 0$, i.e. if both pressure and temperature are held constant. However, we may also express $G$ i.t.o. any other two thermodynamic variables $x$ and $y$. $G$ will then also remain unchanged for constant $x$ and $y$ as long as the corresponding transformation $(x, y) |-> (T, p)$ is a diffeomorphism, i.e. smooth and invertible with non-vanishing Jacobian
  $ J = det((partial (T, p))/(partial (x, y))) != 0. $ \
  For irreversible processes, we have $dif S > (delta Q)/T$. Insertion into $dif U = delta Q + delta W$ yields
  $ dif U < T dif S - p dif V. $
  Following the same steps as in @eq:dg and using that $T$ and $p$ are still constant gives
  $ dif G < -S dif T + V dif p = 0. $
  Thus, the Gibbs free enthalpy must strictly decrease during an irreversible process occurring at constant temperature and pressure. This implies that $G$ reaches a minimum once the system is equilibrated and its thermodynamic properties no longer change over time.

= Real gas #points(3)

#task[
  Let the thermodynamics of a gas be described by
  $ T (partial p(T, V))/(partial T) (V - n b) = n R T. $ <eq:real-gas>
  + Derive the corresponding equation of state $p(T, V)$. (Pay attention to integration constants).
  + Compute the free energy $F$.
  + How does the heat capacity $C_V$ depend on volume?
]

+ Integrating @eq:real-gas w.r.t. $T$ gives
  $ p(T, V) = integral (n R)/(V - n b) dif T = (n R T)/(V - n b) + p_0 (V), $ <eq:eos>
  where the integration constant $p_0 (V)$ determines the pressure at $T = 0$.
+ The (Helmholtz) free energy is defined as $F = U - T S$. Using $dif U = T dif S - p dif V$, its differential is
  $ dif F = dif U - T dif S - S dif T = -S dif T - p dif V. $
  At constant temperature, we have
  $ pd(F, V, T) = -p. $
  Inserting the equation of state @eq:eos and integrating w.r.t. $V$ yields
  $ F = -integral ((n R T)/(V - n b) + p_0 (V)) dif V = -n R T ln(V - n b) - integral p_0 (V) dif V + F_0 (T). $ <eq:free-energy>
+ At constant volume, $dif U = T dif S - p dif V$ reduces to
  $ T dif S = dif U = pd(U, T, V) dif T = C_V dif T. $
  The heat capacity at constant volume is thus
  $ C_V = T pd(S, T, V). $ <eq:cv>
  Since $dif F = -S dif T - p dif V$, we have
  $ S = -pd(F, T, V), $
  and so
  $ C_V = -T lr((partial^2 F(T, V))/(partial T^2) |)_V eqby("eq:free-energy") -T lr((partial^2 F_0 (T))/(partial T^2) |)_V. $
  Thus, the heat capacity is independent of the volume. \
  Another way to see this is to differentiate @eq:cv w.r.t. $V$ at constant $T$ and insert the Maxwell relation
  $ pd(S, V, T) = pd(p, T, V) $
  that derives from $dif F = -S dif T - p dif V$. This yields
  $ pd(C_V, V, T) = T (partial^2 S)/(partial T partial V) = T lr((partial^2 p)/(partial T^2) |)_V = 0. $

= Ideal gas #points(3)

#task[
  Consider 1~mol of an ideal gas. Under the assumption that the specific heat is independent of temperature, determine the caloric equation of state $U = U(T, V)$ from the thermal equation of state. Then also determine the Helmholtz free energy $F$ in terms of its natural variables. Determine whether $F$ is a convex or concave function of either of its natural variables, when the other one is kept fixed. \
  Hint: You may use the result from exercise 1a).
]

Inserting the ideal gas law $p V = n R T$, where $n = 1 thin "mol"$, into @eq:pressure yields
$ pd(U, V, T) = p - T pd(p, T, V) = 0. $
Thus, the internal energy is a function of temperature only, $U = U(T)$. Consequently, its total differential is simply
$ dif U = (partial U)/(partial T) dif T = C dif T. $ <eq:du>
Since the heat capacity is temperature-independent, integrating @eq:du is trivial and yields the caloric equation of state#footnote[We could have added an integration constant here, but preferred to keep $U(0) = 0$.]
$ U(T) = C T. $
The Helmholtz free energy is defined as $F = U - T S$. The entropy $dif S = (delta Q)/T$ for an ideal gas can be derived from the first law $delta Q = dif U - delta W = C dif T + p dif V$,
$ dif S = (delta Q)/T = C/T dif T + p/T dif V = C/T dif T + R/V dif V. $
Integrating both sides yields
$ S(T, V) = S_0 + C ln(T \/ T_0) + R ln(V \/ V_0), $
where $S_0 = S(T_0, V_0)$. By inserting this result into $F$, we obtain
$ F = C T - T [S_0 + C ln(T \/ T_0) + R ln(V \/ V_0)]. $
To investigate the free energy's properties as a function of its natural variables $T$ and $V$, we calculate the second partial derivatives,
$
  lr((partial^2 F)/(partial T^2) |)_V & = -C partial^2/(partial T^2) T ln(T/T_0) = -C partial/(partial T) [ln(T/T_0) + 1] = -C/T < 0, \
  lr((partial^2 F)/(partial V^2) |)_T & = -R T partial^2/(partial V^2) ln(V/V_0) = -R T partial/(partial V) 1/V = (R T)/V^2 > 0.
$
From this, we can infer that $F(T, V)$ is a concave function of temperature and a convex function of volume. Hence its graph is shaped like a saddle.
#align(center, saddle)
