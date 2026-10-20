#import "/notes.typ": dd, notes, tagged, task

#show: notes.with(
  title: [General Relativity -- Practice Sheet 1],
  subtitle: [Practice sheet 1, General Relativity, Prof. Björn Malte Schäfer],
  date: [Solutions by Janosh Riebesell, 23.04.2015],
)

= Problem 1 (Noether's theorem)

#task[
  Given the Lagrangian
  $ cal(L)(r, dot(r), phi, dot(phi), t) = m/2 (dot(r), dot(phi)) mat(1, 0; 0, r^2) vec(dot(r), dot(phi)) - alpha/r = m/2 (dot(r)^2 + r^2 dot(phi)^2) - alpha/r, $
]

#task(label: "a")[Find $dif/(dif t) cal(L)$. What does the result imply?]

$
  dif/(dif t) cal(L) & attach(=, t: *_1) (partial cal(L))/(partial r) (dif r)/(dif t) + (partial cal(L))/(partial dot(r)) (dif dot(r))/(dif t) + (partial cal(L))/(partial phi) (dif phi)/(dif t) + (partial cal(L))/(partial dot(phi)) (dif dot(phi))/(dif t) + underbrace((partial cal(L))/(partial t), 0) (dif t)/(dif t) \
  & = (partial cal(L))/(partial r) dot(r) + (partial cal(L))/(partial dot(r)) dot.double(r) + (partial cal(L))/(partial phi) dot(phi) + (partial cal(L))/(partial dot(phi)) dot.double(phi) \
  & attach(=, t: *_2) overbrace(dif/(dif t) (partial cal(L))/(partial dot(r)), = (partial cal(L))/(partial r)) dot(r) + (partial cal(L))/(partial dot(r)) dot.double(r) + overbrace(dif/(dif t) (partial cal(L))/(partial dot(phi)), = (partial cal(L))/(partial phi)) dot(phi) + (partial cal(L))/(partial dot(phi)) dot.double(phi) \
  & attach(=, t: *_3) dif/(dif t) ((partial cal(L))/(partial dot(r)) dot(r) + (partial cal(L))/(partial dot(phi)) dot(phi)) = dif/(dif t) (p_r dot(r) + p_phi dot(phi)),
$
where
- $*_1$: chain rule,
- $*_2$: here we restrict the generality of our final conclusion by imposing the Euler--Lagrange equations of motion,
- $*_3$: inverse product rule.

From this result, which we obtained only because our Lagrangian is not explicitly time-dependent, we can deduce that the total energy of any system described by a Lagrangian with this property is conserved over time, i.e.
$ dif/(dif t) H = dif/(dif t) (p_r dot(r) + p_phi dot(phi) - cal(L)) = dif/(dif t) (p_r dot(r) + p_phi dot(phi)) - dif/(dif t) (p_r dot(r) + p_phi dot(phi)) = 0. $

#task(label: "b")[Find $dif/(dif phi) cal(L)$. What does the result imply?]

$ dif/(dif phi) cal(L) attach(=, t: *_1) (partial cal(L))/(partial r) underbrace((dif r)/(dif phi), 0) + (partial cal(L))/(partial dot(r)) underbrace((dif dot(r))/(dif phi), 0) + underbrace((partial cal(L))/(partial phi), 0) (dif phi)/(dif phi) + (partial cal(L))/(partial dot(phi)) underbrace((dif dot(phi))/(dif phi), 0) + (partial cal(L))/(partial t) underbrace((dif t)/(dif phi), 0) = 0 $
$(dif cal(L))/(dif phi) = 0$ means that $phi$ is a cyclic coordinate and that $p_phi = (partial cal(L))/(partial dot(phi))$, the canonically conjugate momentum of $phi$, also known as the angular momentum, is conserved over time if one imposes the equations of motion, i.e.
$ dif/(dif t) L_phi = dif/(dif t) p_phi = dif/(dif t) (partial cal(L))/(partial dot(phi)) attach(=, t: !) (partial cal(L))/(partial phi) = 0. $

= Problem 2 (Virial theorem)

The physical system in this exercise is taken to be contained in a finite volume and to possess a finite amount of energy.

#task[
  A function $f(x)$ is said to be homogeneous of degree $k$ iff $f(alpha x) = alpha^k f(x)$. Euler's homogeneous function theorem states that for a homogeneous function $f(arrow(x))$
  $ arrow(x) dot nabla f(arrow(x)) = k f(arrow(x)). $
  It is easy to see that the function $T(arrow(v)) = m/2 arrow(v)^2$ is homogeneous of degree 2. Therefore, by the aforementioned theorem,
  $ (partial T)/(partial v_i) v_i = p_i v_i = 2 T(arrow(v)). $
  We rewrite the left-hand term as
  $ p_i v_i = dif/(dif t) (p_i x_i) - dot(p)_i x_i. $
  If we average over time,
  $ chevron.l f chevron.r = lim_(t -> oo) 1/t integral_0^t dd(t') f(t'), $
  we get $2 chevron.l T chevron.r = chevron.l dif/(dif t) (p_i x_i) - dot(p)_i x_i chevron.r = chevron.l -dot(p)_i x_i chevron.r$.
]

#task(label: "a")[Why does the first term vanish?]

$ chevron.l dif/(dif t) (p_i x_i) chevron.r = lim_(t -> oo) 1/t integral_0^t dd(t') dif/(dif t') (p_i x_i) = lim_(t -> oo) 1/t (p_i x_i) |_0^t = 0. $

#task(label: "b")[Rewrite the remaining term as a derivative of the potential $V(x)$.]

Since the Lagrangian is generally of the form $cal(L) = T(dot(q)_i) - V(q_i)$, where in this case $q_i = x_i$, $dot(q)_i = dot(x)_i = v_i$, we can express $dot(p)_i$ in terms of the derivative of $V(x)$:
$ dot(p)_i = dif/(dif t) p_i = dif/(dif t) (partial cal(L))/(partial dot(x)_i) attach(=, t: "e.o.m.") (partial cal(L))/(partial x_i) = -(partial V(x_i))/(partial x_i) quad ==> quad chevron.l -dot(p)_i x_i chevron.r = chevron.l (partial V(x))/(partial x_i) x_i chevron.r = chevron.l arrow(x) dot nabla V(x) chevron.r = chevron.l k V(x) chevron.r, $
where the last step requires $V(arrow(x))$ to be a homogeneous function of order $k$.

#task(label: "c")[Apply Euler's theorem to the potential, as it is a homogeneous function of degree $k$ as well as $T(arrow(v))$.]

See answer to part b) of this problem.

#task(label: "d")[What does this imply for $chevron.l T chevron.r$ and $chevron.l V chevron.r$ in gravitational/electrostatic potentials ($V(r) prop r^(-1)$) and harmonic potentials ($V(r) prop r^2$)?]

Taking our result from 2.b) and plugging it into the expression for $2 chevron.l T chevron.r$, we get the virial theorem
$ 2 chevron.l T chevron.r = chevron.l k V chevron.r, quad k in ZZ. $
In the case of gravitational and electrostatic potentials, we have $k = -1$ so that the virial theorem yields
$ 2 chevron.l T chevron.r = -chevron.l V chevron.r, $
whereas for harmonic potentials, $k = 2$ so that
$ chevron.l T chevron.r = chevron.l V chevron.r. $

= Problem 3 (Gravitational 'Opticks')

#task[
  In general relativity, light rays follow null geodesics, meaning that their paths can be 'bent' by the presence of mass. The deflection angle $alpha$ in general relativity is given by
  #tagged(1, $ alpha = (4 G M)/(c^2 xi), $)
  where $xi$ is the impact parameter (expressing how far away from the centre of the mass the rays are passing). Let us try and recreate this effect with Newtonian gravity.
]

#task(label: "a")[Calculate the escape velocity of a particle from a given potential $V = -G (m M)/r$ from the simple argument that the initial kinetic energy $T_i$ has to be the same as the negative potential energy $-V_i$, so that the particle's total energy $E = T_i + V_i$ is exactly zero by the time it has completely escaped the potential.]

$ T_i = m/2 v_"esc"^2 = +G (m M)/r = -V_i quad ==> quad v_"esc" = sqrt((2 G M)/r). $
For $v_"esc" = c$, we obtain the famous Schwarzschild radius $R_s$
$ R_s = (2 G M)/c^2. $

#task(label: "b")[
  Let's consider the movement of a massive body (later to be called light ray) in a Newtonian gravitational potential again,
  $ F = m (dd(2, r))/(dif t^2) = -G (m M)/r^2. $
  As we're interested in the body reaching us (instead of being bound by the potential), we are looking for hyperbolae as solutions to the above e.o.m. These shall be parametrised by
  #tagged(3, $ r(phi) = (xi (1 + e))/(1 + e cos phi), quad (dif phi)/(dif t) = 1/r^2 sqrt(G M xi (1 + e)), $)
  where the impact parameter $xi$ is the distance of closest approach during the passage, and $e$ is the eccentricity. Writing the vector $arrow(r)$ as
  $ arrow(r) = r vec(cos phi, sin phi), $
  calculate the velocity $arrow(v) = (dif arrow(r))/(dif t)$ and its square.
]

$
  dif/(dif t) arrow(e)_r & = dif/(dif t) vec(cos phi, sin phi) = vec(-sin phi, cos phi) (dif phi)/(dif t) = arrow(e)_phi dot(phi), \
  arrow(v) & = (dif arrow(r))/(dif t) = dif/(dif t) (r arrow(e)_r) = dot(r) arrow(e)_r + r dot(arrow(e))_r = dot(r) arrow(e)_r + r dot(phi) arrow(e)_phi, \
  arrow(v)^2 & = dot(r)^2 underbrace(arrow(e)_r^2, 1) + 2 r dot(r) dot(phi) underbrace(arrow(e)_r dot arrow(e)_phi, 0) + r^2 dot(phi)^2 underbrace(arrow(e)_phi^2, 1) = dot(r)^2 + r^2 dot(phi)^2.
$

#task(label: "c")[
  Let's consider $r -> oo$, which is when the massive body (light ray) reaches us. What condition can you then infer from eq. (3) for the final angle $phi_oo$? If we define
  $ phi_oo = pi/2 + delta, $
  what relation do we get for $sin delta$ and $e$?
]

Solving eq. (3) for $phi_oo$ when performing $r -> oo$, we get
$ phi_oo = arccos(-1/e). $
Using our definition of $phi_oo$, we find
$ phi_oo = pi/2 + delta = arccos(-1/e) quad ==> quad sin delta = sin(arccos(-1/e) - pi/2) = -cos(arccos(-1/e)) = 1/e. $
Apparently, the final deflection angle $alpha = 2 delta = 2 arcsin(1/e)$ depends only on the eccentricity $e$ of the hyperbola, and it in turn on the impact parameter $xi$.

#task(label: "d")[Take your result from part b) and set $arrow(v)^2 = c^2$. Then calculate the deflection angle $alpha = 2 delta$ for the Newtonian case. For this, we can assume small angles $delta$. How does the fraction compare to unity? Can you simplify further? Are there any parallels to the general relativistic deflection angle? Calculate the Newtonian deflection angle of the sun at its surface.]

For $arrow(v)^2 = c^2$, we have $c^2 = dot(r)^2 + r^2 dot(phi)^2$. At the point of closest approach, we can use that $dot(r) = 0$, since $r$ has a minimum at closest approach, and that $r = xi$. Therefore, at this point, it holds that
$ c^2 = xi^2 dot(phi)^2 = xi^2 (G M xi (1 + e))/xi^4 = 1/xi G M (1 + e), $
or, when solved for $e$,
$ e = (c^2 xi)/(G M) - 1. $
Inserting for example mass and radius of the sun for $M$ and $xi$, which are of the order $M_dot.o approx 2 dot 10^30 "kg"$ and $R_dot.o = 7 dot 10^8 "m"$, we find that $(c^2 xi)/(G M)$ is much larger than one, so that we may write
$ e approx (c^2 xi)/(G M). $
For small angles $delta$, we can estimate $sin delta approx delta$ so that our Newtonian formula for the deflection angle $alpha_N$ reads
$ alpha_N = 2 delta approx 2/e approx (2 G M)/(c^2 xi). $
We find the Newtonian deflection angle to be smaller by a factor of 2. At the sun's surface, it takes the value
$ alpha_(N, dot.o) = (2 G M_dot.o)/(c^2 R_dot.o) = 4.25 dot 10^(-6). $

= Problem 4 (Constant constants)

#task[In the lecture, we discussed the four 'most fundamental' constants of modern physics, $c$, $G$, $ħ$ and $k_B$.]

#task(label: "a")[Which change would be most noticeable if one of those were suddenly to be multiplied by a factor of two?]

Impossible to tell.

#task(label: "b")[Which of these would you consider 'least fundamental'?]

None.
