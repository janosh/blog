#import "/notes.typ": task, eqby, pd
#import "/statistical-physics/sheet.typ": points, sheet
#import "@preview/cetz:0.5.2": canvas, draw

#show: sheet.with(1, [November 4th, 2016])


// p-V diagram of the idealized Otto cycle: two adiabats joined by two isochores
#let otto-cycle = canvas(length: 1cm, {
  import draw: *
  set-style(stroke: 0.6pt)
  let navy = rgb("#00008b")
  let (v-min, v-max) = (1.2, 5.5)
  let adiabat(p0) = range(0, 41).map(i => {
    let v = v-min + (v-max - v-min) * i / 40
    (v, p0 * calc.pow(v-min / v, 0.6))
  })
  let (top, bottom) = (adiabat(4.4), adiabat(2.7))
  line((0, 0), (6.2, 0), mark: (end: "stealth", fill: black, scale: 0.5))
  line((0, 0), (0, 4.9), mark: (end: "stealth", fill: black, scale: 0.5))
  content((6.2, 0), $V$, anchor: "west", padding: 2pt)
  content((0, 4.9), $p$, anchor: "west", padding: 2pt)
  let (a, b, c, d) = (top.first(), top.last(), bottom.last(), bottom.first())
  let dashed = (dash: "dashed", thickness: 0.5pt)
  line((0, a.at(1)), a, stroke: dashed)
  line((0, c.at(1)), c, stroke: dashed)
  line((v-min, 0), d, stroke: dashed)
  line((v-max, 0), c, stroke: dashed)
  content((0, a.at(1)), $p_max$, anchor: "east", padding: 3pt)
  content((0, c.at(1)), $p_min$, anchor: "east", padding: 3pt)
  content((v-min, 0), $V_min$, anchor: "north", padding: 3pt)
  content((v-max, 0), $V_max$, anchor: "north", padding: 3pt)
  line(..top, stroke: navy + 1pt)
  line(..bottom, stroke: navy + 1pt)
  line(a, d, stroke: navy + 1pt)
  line(b, c, stroke: navy + 1pt)
  for (pt, name, anchor) in ((a, $a$, "south"), (b, $b$, "west"), (c, $c$, "west"), (d, $d$, "east")) {
    circle(pt, radius: 0.04, fill: black)
    content(pt, name, anchor: anchor, padding: 3pt)
  }
  content((v-min - 0.1, 3.6), text(fill: red, $Q_(d a) arrow.double$), anchor: "east")
  content((v-max + 0.1, 1.5), text(fill: blue, $arrow.double Q_(b c)$), anchor: "west")
})

= Otto motor #points(3)

#task[
  Consider the cyclic process $a -> b -> c -> d -> a$ as an idealization of the cycle of an Otto motor,
  #block(inset: (left: 2em))[
    $a -> b$: adiabatic expansion, temperature falls from $T_a$ to $T_b$; \
    $b -> c$: cooling to $T_c$ at constant volume $V_max$; \
    $c -> d$: adiabatic compression, temperature rises from $T_c$ to $T_d$; \
    $d -> a$: heating to $T_a$ at constant volume $V_min$.
  ]
  In a real Otto motor the heating between $d$ and $a$ is caused by the explosion after ignition and chemical energy is introduced during the gas exchange. In our idealized model all parts of the cycle are performed reversibly, and we consider the gas in the cylinder to be ideal; energy is introduced as heat $Q$ between $d$ and $a$ without changing the decomposition of the ideal gas. The exhaust between $b$ and $c$ releases the heat $Q'$.
  + Sketch the $p$-$V$-diagram.
  + Compute the efficiency $eta = W \/ Q$ of the motor as a function of the temperatures $T_a$ and $T_b$, and as a function of the compression ratio $V_min \/ V_max$.
]

+ The reversible cycle of an idealized Otto motor corresponds to the following closed path through $p$-$V$-space consisting of two parallel isochorics and two quasi-parallel adiabats.
  #align(center, otto-cycle)
  Along the adiabatic expansion $a -> b$, the gas does work on the piston which can be extracted to power a machine or propel a car, but no heat enters or leaves the system. The same is true for the adiabatic compression $c -> d$, except now the piston does work on the gas by compressing it. Processes $b -> c$ and $d -> a$ are isochoric cooling and heating, respectively. No work is done as that would require a change in the system's boundaries.
+ Since a complete cycle returns the gas to its original state of temperature, pressure and volume, the net internal energy change $Delta U$ must be zero. With
  $
    Q_(a b) = 0, wide Q_(b c) < 0, wide Q_(c d) = 0, wide Q_(d a) > 0, \
    W_(a b) < 0, wide W_(b c) = 0, wide W_(c d) > 0, wide W_(d a) = 0,
  $
  this becomes
  $ Delta U = W_(a b) + Q_(b c) + W_(c d) + Q_(d a) = 0. $ <eq:delta-u>
  @eq:delta-u reflects that along $a -> b -> c$, the system loses energy, which is replaced by first doing work on and then adding heat to it in $c -> d -> a$. \
  The efficiency is given by the net work _performed_ by the system (thus the minus sign) divided by the heat _added_ to it,#footnote[The sign in front of the work appears because we define $Delta U = Q + W$, i.e. work being done on the system counts positive.]
  $ eta = -(W_(c d) + W_(a b))/Q_(d a) eqby("eq:delta-u") (Q_(b c) + Q_(d a))/Q_(d a) = 1 + Q_(b c)/Q_(d a). $ <eq:efficiency>
  The isochoric heat change in an ideal gas is determined by the temperature difference,
  $ Q_(i f) = integral_(T_i)^(T_f) C_V dif T = C_V (T_f - T_i), $ <eq:isochoric>
  where $C_V = 3/2 n R$ for a monatomic ideal gas. Inserting @eq:isochoric into @eq:efficiency gives
  $ eta = 1 + (T_b - T_c)/(T_d - T_a). $
  By the second law of thermodynamics, a reversible process is isentropic, i.e. it produces no entropy. Thus
  $ integral.cont dif S = integral.cont (delta Q)/T = C_V integral_(T_b)^(T_c) (dif T)/T + C_V integral_(T_d)^(T_a) (dif T)/T = C_V ln(T_a/T_d) + C_V ln(T_c/T_b) = C_V ln(T_a/T_d T_c/T_b) limits(=)^! 0. $
  From the last equality, it follows that $T_a/T_d = T_b/T_c$, and so
  $ eta = 1 - T_b/T_a (1 - T_c \/ T_b)/(1 - T_d \/ T_a) = 1 - T_b/T_a. $
  In order to express this i.t.o. the compression ratio $V_min \/ V_max$, we make use of the fact that along adiabatic processes such as $a -> b$ we have $dif S = delta Q \/ T = 0$. Since $dif U = T dif S - p dif V$ and $dif U = C_V dif T$, this yields the adiabatic equation
  $ dif S = (dif U)/T + p/T dif V = C_V (dif T)/T + (n R)/V dif V limits(=)^! 0, $
  which we can integrate to get
  $ ln(T_b/T_a) = -(n R)/C_V ln(V_max/V_min). $
  Thus
  $ eta = 1 - (V_min/V_max)^((n R)/C_V). $
  For the ideal gas $C_p - C_V = n R$, so the exponent has the form $(C_p - C_V)/C_V = gamma - 1$.

= Differential forms #points(3)

#task[
  + Is the following 1-form exact?
    $ mu = x z^2 dif x + y z dif y + x z dif z + y z dif x. $
  + Does the following 1-form have an integrating factor?
    $ nu = (2 y)/x dif x + dif y $
    What does the existence of an integrating factor mean geometrically?
]

+ An exact form is a differential that lies in the image of the exterior derivative $dif$. Thus, $mu$ would be exact if there existed a differential form $alpha$ of one degree less than $mu$ s.t. $mu = dif alpha$. $alpha$ would then be called a potential for $mu$. \
  In three dimensions $(x, y, z) in RR^3$, any 1-form $Q$ is of the form
  $ Q = A(x, y, z) dif x + B(x, y, z) dif y + C(x, y, z) dif z. $ <eq:one-form>
  In the case of $mu$,
  $ A(x, y, z) = x z^2 + y z, wide B(y, z) = y z, wide C(x, z) = x z. $ <eq:coefficients>
  $Q$ is exact on a domain $D subset RR^3$ if there exists a scalar function $V(x, y, z)$ on $D$ such that $dif V = Q$, where
  $ dif V = lr((partial V)/(partial x) |)_(y,z) dif x + lr((partial V)/(partial y) |)_(x,z) dif y + lr((partial V)/(partial z) |)_(x,y) dif z. $ <eq:dv>
  Comparing coefficients of @eq:one-form and @eq:dv, we see that exactness requires
  $ A(x, y, z) = lr((partial V)/(partial x) |)_(y,z), wide B(x, y, z) = lr((partial V)/(partial y) |)_(x,z), wide C(x, y, z) = lr((partial V)/(partial z) |)_(x,y). $
  At this point, we may recall Schwarz's theorem, which states that partial derivatives of a function commute if it is twice continuously partially differentiable. So if $V(x, y, z)$ was twice continuously differentiable, the following would have to hold,
  $ lr((partial A)/(partial y) |)_(x,z) = lr((partial B)/(partial x) |)_(y,z), wide lr((partial A)/(partial z) |)_(x,y) = lr((partial C)/(partial x) |)_(y,z), wide lr((partial B)/(partial z) |)_(x,y) = lr((partial C)/(partial y) |)_(x,z). $ <eq:schwarz>
  So @eq:schwarz is necessary for $V(x, y, z)$ to exist. Conversely, on a simply connected domain such as $RR^3$, it is also sufficient (this is Poincaré's lemma, see the alternative solution below). Going back to @eq:coefficients, we see
  $ lr((partial A)/(partial y) |)_(x,z) = z != 0 = lr((partial B)/(partial x) |)_(y,z), $
  and similarly for the other coefficients. Thus $mu$ is inexact.#footnote[If $mu$ were exact, then its integral through Euclidean three-space from some initial point $bold(x)_i$ to some final point $bold(x)_f$ would be path-independent, i.e. $integral_C mu = V(bold(x)_f) - V(bold(x)_i)$ for all paths $C$ that start at $bold(x)_i$ and end at $bold(x)_f$. If $mu$ could furthermore be interpreted as the differential of some thermodynamic quantity, it would constitute a state function.]

  *Alternative solution* #h(0.5em) A shorter, more formal way of showing that $mu$ is not exact is to assume we are operating on a contractible domain such as $RR^3$ or a bounded region $Lambda$. Then by Poincaré's lemma, every closed form on such a domain is also exact. (The converse always holds because $dif^2 = 0$.) A closed form $Q$ is one that lies in the kernel of the exterior derivative, i.e.
  $ Q "closed" quad <==> quad Q in ker(dif) quad <==> quad dif Q = 0. $
  Calculating the exterior derivative of $mu$ yields
  $
    dif mu & = -z dif x and dif y - (2 x z + y) dif x and dif z - y dif y and dif z + z dif x and dif z, \
           & = -z dif x and dif y - (2 x z + y - z) dif x and dif z - y dif y and dif z,
  $
  which is obviously unequal zero, meaning $mu$ is neither closed nor exact on a contractible domain.
+ An integrating factor is a function by which an inexact differential can be multiplied to turn it into an exact differential.#footnote[For instance, in thermodynamics temperature is the integrating factor that makes the entropy an exact differential.] \
  To determine whether or not $nu$ has an integrating factor, we would generally multiply it by a function $f(x, y)$. We can then try to impose exactness on the resulting 1-form, which if it works out, allows us to fix the form of $f(x, y)$. Of course, if $nu$ does not have an integrating factor, this step will fail. For simplicity, we will assume here that the integrating factor can in fact be taken as a function of $x$ only. We just have to keep in mind that, in case it fails, it doesn't mean that $nu$ does not have an integrating factor, as it might have worked with a more general form of $f$.
  $ f(x) nu = f(x) (2 y)/x dif x + f(x) dif y. $
  Imposing exactness amounts to the equality
  $ f(x) 2/x limits(=)^! f'(x), $
  which is a separable differential equation with solution $f(x) = x^2$. Thus $nu$ has an integrating factor. \
  Geometrically, the existence of an integrating factor means that the (multiplied) 1-form is the gradient of some potential and that the integral of the gradient along a curve depends only on the value of the potential at the end points.

= Entropy of the ideal gas #points(4)

#task[
  + Formulate the 1st law in differential form and express the differential heat $delta Q$ in terms of $dif T$ and $dif V$.
  + Show that $delta Q \/ T$ is a total differential and equals $dif S$.
  + Integrate the relation $dif S = delta Q \/ T$ to obtain the entropy $S$ as a function of $T$ and $V$.
  + Rewrite $U$ as a function of $S$ and $V$ (for $dif U$).
]

+ The first law in differential form reads $dif U = delta Q + delta W$. The internal energy of an ideal gas as a function of temperature is $U(T) = C_V (T - T_0)$. Thus, the differential heat may be written
  $ delta Q = dif U - delta W = C_V dif T + p dif V. $
+ Taking the second derivatives of
  $ (delta Q)/T = C_V/T dif T + (n R)/V dif V, $ <eq:dq-t>
  we find they agree,
  $ partial/(partial V) C_V/T = 0 = partial/(partial T) (n R)/V, $
  which makes $(delta Q)/T$ a total differential. \
  By definition, the change in heat per temperature is the change in entropy, i.e. $dif S = delta Q \/ T$.
+ Integrating $dif S$ as in @eq:dq-t gives
  $
    S(T, V) & = S(T_0, V_0) + integral_(T_0)^T C_V/T' dif T' + integral_(V_0)^V (n R)/V' dif V' \
            & = S(T_0, V_0) + C_V ln(T/T_0) + n R ln(V/V_0).
  $
+ Again by definition
  $ dif U = delta Q + delta W limits(=)^"b)" T dif S - p dif V. $
  Solving the result of c) for $T$ and inserting it into $U = C_V (T - T_0)$ gives $U$ as a function of its natural variables,
  $ U(S, V) = C_V T_0 [(V_0/V)^((n R)\/C_V) e^((S - S(T_0, V_0))\/C_V) - 1], $
  whose partial derivatives indeed reproduce $T = pd(U, S, V)$ and $p = -pd(U, V, S) = (n R T)/V$.
