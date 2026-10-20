#import "/notes.typ": dd, notes, tagged, task
#import "@preview/cetz:0.5.2": canvas, draw
#import "@preview/cetz-plot:0.1.4": plot

#show: notes.with(
  title: [General Relativity -- Exercise Sheet 1],
  subtitle: [Exercise sheet 1, General Relativity, Prof. Björn Schäfer],
  date: [Solutions by Janosh Riebesell, 15.04.2015],
)

= Problem 1: Gravitational Train (10 points)

#task[
  #grid(
    columns: (1fr, auto),
    gutter: 12pt,
    [In order to save CO#sub[2]-emissions from air traffic, the governments of France and New Zealand have decided, very realistically, to bore a tunnel through the center of the Earth, directly connecting their land masses with a straight tube, through which a train can travel without any friction and solely accelerated by grav. pull.],
    align(horizon, canvas(length: 1.25cm, {
      import draw: *
      set-style(stroke: 0.6pt)
      circle((0, 0), radius: 1)
      let at(deg) = (calc.cos(deg * 1deg), calc.sin(deg * 1deg))
      line(at(112), at(-68), stroke: (dash: "dashed"))
      line(at(158), at(72), stroke: (dash: "dashed"))
      content((rel: (-0.12, 0.12), to: at(112)), text(8pt)[F])
      content((rel: (0.18, -0.12), to: at(-68)), text(8pt)[NZ])
      content((rel: (-0.38, 0), to: at(158)), text(7pt)[London])
      content((rel: (0.2, 0.14), to: at(72)), text(7pt)[Berlin])
      content((0.34, 0.47), text(6.5pt)[$d_2 = 900 "km"$])
      content((0.5, -0.2), text(6.5pt)[$d_1 = 2 R_E$])
    })),
  )
]

#task(label: "a")[
  #set enum(numbering: "i)")
  How long does it take for the train to travel one way if Earth's radial density $rho(r)$ follows
  + $rho(r) = rho_0 = 5.5 "g"/"cm"^3$, where $0 <= r <= R_E$?
  + $rho(r) = rho_1 R_E/r$, where $rho_1 = 3.7 "g"/"cm"^3$ and $0 < r <= R_E$?
]

*i)* The gravitational pull on the train depends on its current distance $r$ from the Earth's core, since only the Earth's mass below it, i.e. $M(r) = 4/3 pi rho_0 r^3$, contributes. The force is therefore given by
$ F_g = -G (M(r) m_"train")/r^2 = -4/3 pi G rho_0 dot m_"train" r, $
which yields the equation of motion
$ m_"train" dot.double(r) = F_g = -underbrace(4/3 pi G rho_0, k^2) m_"train" r = -m_"train" k^2 r quad ==> quad dot.double(r) = -k^2 r. $
Unsurprisingly, we find that a train in a tube through Earth's centre without friction behaves like a harmonic oscillator, bouncing back and forth between France and New Zealand.

The period $P$, in this case twice the travel time $t$, of a harmonic oscillator depends solely on its suspension rate $k$ such that
$ P = (2 pi)/k = 2 t, quad t = pi/k = pi/sqrt(4/3 pi G rho_0) = sqrt((3 pi)/(4 G rho_0)) approx 2530 "s" approx 42.2 "min". $
Interestingly, the travel time depends only on the Earth's density $rho_0$.

*ii)* In this case, $M(r) = 4/3 pi r^3 rho(r) = 4/3 pi R_E rho_1 r^2$ and
$ F_g = -G (M(r) m_"train")/r^2 = -4/3 pi R_E rho_1 G m_"train" $
is independent of $r$. Under a constant force, the acceleration
$ a = 4/3 pi R_E rho_1 G $
is also constant, rendering the distance travelled easily calculable via $s = a/2 t^2$. Solving for $t$ and inserting $s = d_1$, we obtain
$ t = sqrt((2 s)/a) = sqrt((4 R_E)/(4/3 pi R_E rho_1 G)) = sqrt(3/(pi rho_1 G)) approx 1970 "s" approx 32.8 "min". $

#task(label: "b")[Assume there was a similar tunnel between London and Berlin. How long would that journey take?]

#grid(
  columns: (1fr, auto),
  gutter: 12pt,
  [In this scenario, only two quantities are changed from part a): the force accelerating the train and the length of the tunnel. However, the distance $r$ from the train to Earth's core is no longer ideally suited to describe the train's position. Instead, we consider
    $ x(r) = r cos(alpha), $
    where $alpha$ is the angle between a line perpendicular to the tunnel through the Earth's core and the direction of gravity.],
  align(horizon, canvas(length: 1.7cm, {
    import draw: *
    set-style(stroke: 0.6pt)
    circle((0, 0), radius: 1)
    let y0 = 0.72
    let xb = calc.sqrt(1 - y0 * y0)
    line((-xb, y0), (xb, y0), stroke: 0.9pt)
    content((-xb - 0.12, y0 + 0.08), text(8pt)[L])
    content((xb + 0.12, y0 + 0.08), text(8pt)[B])
    line((0, 0), (0, y0), stroke: (dash: "dashed"))
    line((0, 0), (-0.38, y0), stroke: (dash: "dashed"))
    circle((-0.38, y0), radius: 0.04, fill: black)
    circle((0, 0), radius: 0.035, fill: black)
    content((-0.3, 0.3), text(7pt)[$r$])
    content((-0.19, y0 + 0.12), text(7pt)[$x$])
    arc((0, 0), start: 90deg, delta: 27.8deg, radius: 0.32, anchor: "origin")
    content((-0.08, 0.45), text(6.5pt)[$alpha$])
  })),
)
From the sketch we see that only the comp. of gravity acting parallel to the tunnel produces acceleration on the train, i.e.
$ F_"ac" = F_g dot cos(alpha) = -underbrace(4/3 pi G rho_0, k^2) m_"train" r cos(alpha) = -k^2 m_"train" x(r). $
Surprisingly, this yields the same e.o.m. as in a), just with a new coordinate, namely
$ m_"train" dot.double(x)(r) = F_"ac" = -k^2 m_"train" x(r). $
Since the suspension rate $k$ of this new harmonic oscillator remains the same as the old one, we can infer that its period, and hence the travel time, is also unchanged at $42.2$ minutes.

#task(label: "c")[What is the period $T$ of a hypothetical satellite that orbits the Earth on its surface? Why is it exactly the same as the time for the return journey of the Earth?]

A stable orbit requires opposing gravitational and centrifugal forces of equal strength. From this, one can calculate the orbital velocity at a given distance from the Earth, in this case $R_E$:
$ F_g = -G (M_E m_"sat")/R_E^2 = -(m_"sat" v^2)/R_E = -F_c quad ==> quad v = sqrt((G M_E)/R_E), $
where $M_E = integral_(V_E) rho(r) dd(3, r) = 4/3 pi R_E^3 rho_0$. With this, the orbital period $T$ follows easily:
$ T = s/v = (2 pi R_E)/sqrt(4/3 pi R_E^2 G rho_0) = sqrt((3 pi)/(G rho_0)) = 2 t_"travel". $

= Problem 2: Lagrangian Uniqueness (10 points)

#task[
  Consider the Lagrangian for a point mass within a potential $V(q)$,
  #tagged(1, $ cal(L)(q, dot(q), t) = m/2 dot(q)^2 - V(q). $)
]

#task(label: "a")[
  Show that the equations of motion (Euler-Lagrange eqs.) won't change under transformations of the type
  #tagged(2, $ cal(L)(q, dot(q), t) -> cal(L)'(q, dot(q), t) = alpha cal(L)(q, dot(q), t) + dif/(dif t) f(q, t), $)
  or, in other words, that the action $S = integral dd(t) cal(L)(q, dot(q), t)$ is invariant under scaling and gauge transformations which add only a total time derivative to the Lagrangian.
]

By an application of the principle of stationary action to the action functional $S[cal(L)]$, one can derive the Euler-Lagrange equation
$ dif/(dif t) (partial cal(L))/(partial dot(q)) - (partial cal(L))/(partial q) = 0, quad "where" quad cal(L) = cal(L)(q(t), dot(q)(t), t). $
We perform this derivation explicitly for a transformed Lagrangian as defined by the exercise and show that it yields the above e.o.m. First, we note that the action under such a transformation becomes
$ S -> S' = integral_(t_i)^(t_f) cal(L)'(q, dot(q), t) dif t = integral_(t_i)^(t_f) (alpha cal(L)(q, dot(q), t) + dif/(dif t) f(q, t)) dif t = alpha S + f(q, t)|_(t = t_f) - f(q, t)|_(t = t_i), $
where $t_i, t_f$ are initial and final time. Now we perform a variation of $S'$ w.r.t. $q = q(t)$, where the endpoints, $q_i = q(t = t_i)$ and $q_f = q(t = t_f)$, are held fixed, i.e. $delta q_i = delta q_f = 0$:
$ delta S' = alpha delta S + underbrace(delta f(q, t)|_(t = t_f), 0) - underbrace(delta f(q, t)|_(t = t_i), 0) = alpha delta S. $
Apparently, the variation of $S'$ is simply that of $S$ multiplied by the scaling factor. From this, we can immediately see that the Euler-Lagrange eqs. remain invariant up to a multiplication by the scaling factor,
$ alpha (dif/(dif t) (partial cal(L))/(partial dot(q)) - (partial cal(L))/(partial q)) = 0, $
which we can safely get rid of by division.

#task(label: "b")[What is the physical interpretation of the property you just showed?]

In part a), we showed that the Lagrangian is invariant under gauge transformations. The transformation we applied to the Lagrangian is equivalent to a gauge transformation of the 4-vector potential $A^mu$. Among other possible interpretations, gauge invariance can be seen as a manifestation of the nonobservability of $A^mu$.

This question more likely aims at the fact that with gauge invariance, one associates symmetries and conservation laws.

#task(label: "c")[Show that under the infinitesimal transformation $q -> q + dif q$, the Lagrangian gains a contribution of potential energy that can be written in the familiar form $F dif s$. This means, that in this case, we don't have homogeneity of space.]

Since generalized coordinates and generalized velocities are all independent variables, transforming the Lagrangian $cal(L)(q, dot(q), t) = m/2 dot(q)^2 - V(q)$ amounts to only transforming $V(q)$. Since we apply an infinitesimal transformation, we may Taylor-expand $V(q + dif q)$ to linear order without picking up an error using the formula for the Taylor polynomial to order $n$ of $f(x)$ at $x = a$,
$ T_n (f(x), a) = sum_(k = 0)^n 1/k! (dif^k f(x))/(dif x^k)|_(x = a) (x - a)^k, $
where in our case $n = 1$, $f(x) = V(q + dif q)$, $x = q + dif q$ and $a = q$. We obtain
$
  V(q + dif q) & approx 1/0! (dif^0 V(q + dif q))/(dif (q + dif q)^0)|_(q + dif q = q) (q + dif q - q)^0 + 1/1! (dif^1 V(q + dif q))/(dif (q + dif q)^1)|_(q + dif q = q) (q + dif q - q)^1 \
  & = V(q) + V'(q) dif q.
$
Hence, the Lagrangian changes as
$ cal(L) attach(-->, t: q -> q + dif q) cal(L)' = m/2 dot(q)^2 - V(q) - V'(q) dif q, $
where $-V'(q) dif q = F(q) dif q$, in analogy to $F dif s$, where $F(q)$ is a conservative force.

#task(label: "d")[Give an example of a symmetry that the above Lagrangian $cal(L)$ does exhibit, and name the associated conserved quantity.]

The above Lagrangian has several symmetries. For instance, it remains invariant under the transformation $dot(q) -> -dot(q)$. However, there is no assoc. conserved quantity since this is not a continuous symmetry.

By contrast, $t -> t' = t + epsilon$ is a continuous symmetry. For clarity, $q$ and $dot(q)$ are independent and do not participate in the transformation, i.e. $q(t) -> q(t)$, $dot(q)(t) -> dot(q)(t)$. The conserved quantity associated with time translational invariance is energy.

= Problem 3: Newton's Space Rope (10 points)

#task[
  Consider a rope that is connected to the surface of the Earth on the equator. It is affected by the gravitational force
  $ F_g (r) = G (M m)/r^2, $
  as well as a centrifugal force
  $ F_c (r) = (m v^2)/r = m omega^2 r. $
]

#task(label: "a")[Write the forces as integrals along the rope axis. Assume a constant length density $sigma$.]

This seems pointless. For points, we still note
$ F_g (overline(R_E H)) = integral_(R_E)^H G M/r^2 sigma dif r, quad F_c (overline(R_E H)) = integral_(R_E)^H sigma omega^2 r dif r, $
where $H$ denotes the height of the space rope from Earth's core and $F_g (overline(R_E H))$ stands for the accumulated force along the entire rope $overline(R_E H)$.

#task(label: "b")[At what point do the two forces cancel out, i.e. how long does the rope have to be to be in equilibrium? Use the dimensionless variable $xi = x/R_E$ to express its length in Earth radii.]

At Earth's geostationary orbital radius $R_g$, gravitational and centrifugal forces cancel, i.e.
$ F_g (R_g) = -G (M m)/R_g^2 = -m omega^2 R_g = -F_c (R_g). $
From this, we gather that $omega^2 = (G M)/R_g^3$. For the space rope to be in equilibrium, we now impose
$
  0 & attach(=, t: !) F_g (overline(H R_E)) + F_c (overline(H R_E)) = -integral_(R_E)^H G M/r^2 sigma dif r + integral_(R_E)^H sigma (G M)/R_g^3 r dif r = G M sigma integral_(R_E)^H (-1/r^2 + r/R_g^3) dif r \
  & = G M sigma (1/H - 1/R_E + 1/(2 R_g^3) (H^2 - R_E^2)).
$
The obtained expression is a cubic polynomial which we need to solve for $H$. We drop the prefactor and rewrite:
$
  0 & = H - R_E - (R_E H)/(2 R_g^3) (H^2 - 2 R_E H + R_E^2 + 2 R_E H - 2 R_E^2) = H - R_E - (R_E H)/(2 R_g^3) ((H - R_E)^2 + 2 R_E (H - R_E)) \
  & = (H - R_E) (1 - (R_E H)/(2 R_g^3) (H - R_E + 2 R_E)).
$
Apparently, $(H - R_E)$ can be factorised from our polynomial, meaning $H = R_E$ is a solution. However, it is obviously not the one we are looking for. We turn towards the second factor:
$ 0 = 1 - (R_E H)/(2 R_g^3) (H + R_E) quad <==> quad 0 = R_E (H^2 + R_E H - (2 R_g^3)/R_E) = R_E ((H + R_E/2)^2 - R_E^2/4 - (2 R_g^3)/R_E). $
The remaining factor yields two solutions, one of which we discard due to negativity:
$ H = -R_E/2 plus.minus sqrt(R_E^2/4 + (2 R_g^3)/R_E), quad x = H - R_E = -(3 R_E)/2 + sqrt(R_E^2/4 + (2 R_g^3)/R_E) approx 143,800 "km", quad xi approx 22.58. $

#task(label: "c")[What is the orbital velocity of the outermost point of the rope? (You may assume that the rope is rigid.)]

The velocity follows easily from
$ v = s/t = (2 pi H)/d approx 10.92 "km"/"s" quad (d "stands for one Earth day"). $

= Problem 4: Keplerian Orbits (10 points)

#task[
  Given the Lagrangian
  #tagged(3, $ cal(L) = m/2 (dot(r)^2 + r^2 dot(phi)^2) - U(r), $)
  we're going to find out whether Keplerian orbits are closed.
]

#task(label: "a")[Name $q$ and $dot(q)$. What assumption about the shape of the orbits has been made? Is this a sensible choice given what you know about planetary orbits?]

$ q = {r, phi}, quad dot(q) = {dot(r), dot(phi)}. $
The Lagrangian in eq. (3) assumes that there is no orbital movement along the polar angle. For this to be true requires all orbital motion to lie in a two-dimensional plane. Based on our knowledge of the orbits of the planets in our solar system, this is a reasonable assumption.

#task(label: "b")[What is the physical interpretation of the three summands?]

Assumingly, this question refers to the three summands in Lagrangian (3). The first two combined represent the kinetic energy. The third is the potential energy.

#task(label: "c")[What is the total energy $E$ of the system? Where applicable, write it in terms of the canonical momentum in $phi$-direction $p_phi = (partial cal(L))/(partial dot(phi))$.]

$p_phi$ can be easily calculated:
$ p_phi = m r^2 dot(phi). $
$E$ is simply the sum rather than the subtraction of kinetic and potential energy in the Lagrangian, i.e.
$ E = m/2 (dot(r)^2 + r^2 dot(phi)^2) + U(r) = m/2 dot(r)^2 + p_phi^2/(2 m r^2) + U(r). $

#task(label: "d")[
  From the above, you can easily arrive at
  #tagged(4, $ (dif r)/(dif t) = sqrt(2/m (E - U(r) - p_phi^2/(2 m r^2))). $)
  Try to express $dif phi$ in terms of $dif r$! (Tip: $p_phi = m r^2 (dif phi)/(dif t)$.) Extra question: What condition needs to apply that $phi$ describes a closed curve?
]

Vague wording. We assume here that $dif phi$ does not denote the complete differential since $cal(L)$ is cyclic in $phi$. Perhaps
$ (dif phi)/(dif t) = sqrt(2/(m r^2) (E - U(r) - underbrace(1/r^2 ((dif r)/(dif t))^2, p_phi^2/(m^2 r^2)))) $
is what is asked for. Extra answer: $dot(r) attach(=, t: !) 0$.

#task(label: "e")[
  From eq. (4), we can immediately see that $dot(r) = 0$ iff
  $ E = U(r) + p_phi^2/(2 m^2 r^2) = U(r) + m/2 r^2 dot(phi)^2. $
  What very special form of orbit do we have in the case of $dot(r) = 0$? Given $U(r) = G (M m)/r$, produce a plot of $E(r)$ for
  $ M = 2 dot 10^30 "kg", quad m = 10^24 "kg", quad dot(phi) = 2 dot 10^(-7) 1/"s". $
  If done correctly, you should see a minimum at $r approx 150 dot 10^6 "km"$. Guess whose potential you just plotted!
]

For $dot(r) = 0$, our orbit is a circle. We guess it's Jupiter's potential!

#align(center, canvas(length: 1cm, {
  // E(r) = G M m / r + m/2 r^2 phidot^2 in units of 1e33 J, r in units of 1e11 m
  let (G, M, m, w) = (6.674e-11, 2e30, 1e24, 2e-7)
  let energy(x) = (G * M * m / (x * 1e11) + m / 2 * calc.pow(x * 1e11 * w, 2)) / 1e33
  plot.plot(
    size: (7, 4),
    x-label: $r [10^11 "m"]$,
    y-label: $E(r) [10^33 "J"]$,
    x-min: 0,
    x-max: 3,
    y-min: 0,
    y-max: 4,
    x-tick-step: 0.5,
    y-tick-step: 1,
    {
      plot.add(energy, domain: (0.35, 2.8), samples: 120, style: (stroke: 0.9pt))
      plot.add(((1.49, 0), (1.49, energy(1.49))), style: (stroke: (dash: "dashed", thickness: 0.5pt)))
      plot.add(((0, energy(1.49)), (1.49, energy(1.49))), style: (stroke: (dash: "dashed", thickness: 0.5pt)))
      plot.add-anchor("ymin", (0, energy(1.49)))
    },
    name: "plot",
  )
  draw.content("plot.ymin", anchor: "south-west", padding: 0.08, text(8pt)[$approx 4/3 dot 10^33 "J"$])
}))

= Problem 5: Extra: Mechanical Similarity (5 points)

#task[
  A team of astronauts lands on Mars. They transmit their first steps on the red planet live on TV and in order to prove that it's not a hoax, one of them uses a simple pendulum of length $l = 1 "m"$ to show the audience that they really are on Mars.

  As the gravitational constant is supposedly lower on Mars than in a TV studio on Earth, the pendulum should have a larger period $T prop sqrt(1/g)$. Can you, as TV audience, distinguish between a lower gravitational constant $g$ and a slower passage of time? Could this still be hoax?
]

No, we can't. It could still be a hoax.
