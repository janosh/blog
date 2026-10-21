#import "/notes.typ": note, task, vb, kB, unit
#import "/numerical-simulations/sheet.typ": fig, panels, sheet, cO
#import "@preview/cetz:0.5.2": canvas, draw

#show: sheet.with(2, [October 6th, 2015], [Integration of ordinary differential equations])

#let (by, bf) = ($vb(y)$, $vb(f)$)
#let (p1, p2) = ($phi.alt_1$, $phi.alt_2$)
#let inv(i, j) = $A_(#i #j)^(-1)$

// double pendulum hanging from a ceiling bar
#let pendulum = canvas(length: 1cm, {
  import draw: *
  set-style(stroke: 0.6pt)
  rect((-1.2, 0), (1.6, 0.12), fill: luma(160), stroke: 0.5pt)
  let (o, m1, m2) = ((0, 0), (1.0, -1.8), (2.4, -2.4))
  // vertical reference lines from which the angles are measured
  line(o, (0, -2.4), stroke: 0.3pt)
  line(m1, (1.0, -2.9), stroke: 0.3pt)
  line(o, m1, stroke: 0.8pt)
  line(m1, m2, stroke: 0.8pt)
  let tip = (end: "stealth", fill: black, scale: 0.4)
  arc((0, -1.0), start: -90deg, stop: -61deg, radius: 1.0, stroke: 0.4pt, mark: tip)
  arc((1.0, -2.55), start: -90deg, stop: -23deg, radius: 0.75, stroke: 0.4pt, mark: tip)
  for (pt, name, anchor) in ((m1, $m_1$, "east"), (m2, $m_2$, "south-west")) {
    circle(pt, radius: 0.08, fill: rgb("#3080d0"), stroke: none)
    content(pt, name, anchor: anchor, padding: 4pt)
  }
  content((0.5, -0.9), $l_1$, anchor: "west", padding: 3pt)
  content((1.7, -2.1), $l_2$, anchor: "south", padding: 4pt)
  content((0.22, -1.35), $phi.alt_1$)
  content((1.35, -2.75), $phi.alt_2$)
})

= Order of an ODE integration scheme

#task[
  Consider the differential equation
  $ (dif y)/(dif t) = f(y) $ <eq:ode>
  for the function $y(t)$ and a general right hand side $f(y)$. This may be integrated discretely with a Runge-Kutta scheme of the form
  $
       k_1 & = f(y_n), \
       k_2 & = f(y_n + k_1 Delta t), \
    y_(n+1) & = y_n + 1/2 (k_1 + k_2) Delta t.
  $ <eq:rk2>
  Show that the truncation error per step $cO_s$ is of third-order in the step-size $Delta t$, i.e. $cO_s (Delta t^3)$, or in other words, that the scheme is second-order accurate for the global integration error, $cO_T (Delta t^2)$. \
  _Hint_: Consider a Taylor expansion of the difference $y_(n+1) - y(t_n + Delta t)$ and assume that at the beginning of the step, one starts out with the exact solution $y_n = y(t_n)$.
]

#note[
  Equation @eq:rk2 is the second-order Runge-Kutta method. It is a modification of the Euler method
  $ y_(n+1) = y_n + f(y_n) Delta t, $ <eq:euler>
  which is the simplest possible integrator that yields an approximate solution to an ordinary differential equation such as eq. @eq:ode. It is not particularly stable, nor accurate compared to more sophisticated methods but serves the purpose of exemplifying the basic concept of solving ODEs by discretization: We rewrite the differentials $dif y$ and $dif t$ as finite steps $Delta y$ and $Delta t$. We then multiply the ODE by $Delta t$. This yields the algebraic formula in eq. @eq:euler for the change in the function $y_n$ when $t$ is increased by one stepsize $Delta t$. \
  The Euler method is primitive in the sense that it advances the discretized solution $y_n$ through the interval $Delta t$ but uses only information about $f(y_n)$ at the beginning of the interval. This is where Runge-Kutta becomes more advanced.
]

The Runge-Kutta method takes a _trial step_ to the end of the interval, samples the function $f[y_n + f(y_n) dot Delta t]$ there as well, and then averages it with $f(y_n)$ to compute the change in $y_n$. This symmetrization precisely cancels out both the first- and second-order error terms. Since a method is called $n$-th order accurate if its local error introduced with every step appears with a power no lower than $n + 1$, this makes Runge-Kutta second-order accurate.

To see this, we expand $k_2$,
$
  k_2 & = f(y_n + k_1 Delta t) \
      & = f(y_n) + f'(y_n) k_1 Delta t + 1/2 f''(y_n) (k_1 Delta t)^2 + cO_s (Delta t^3).
$
Inserting this into $y_(n+1)$ as given in eq. @eq:rk2 and using $k_1 = f(y_n)$ yields
$
  y_(n+1) & = y_n + 1/2 (k_1 + k_2) Delta t \
          & = y_n + f(y_n) Delta t + 1/2 f'(y_n) f(y_n) Delta t^2 + 1/4 f''(y_n) [f(y_n)]^2 Delta t^3 + cO_s (Delta t^4).
$
By contrast, when expanding $y_(n+1) = y(t_(n+1)) = y(t_n + Delta t)$ directly, we obtain#footnote[As always, dots indicate derivatives w.r.t. time. Derivatives w.r.t. to $y(t)$ are marked by primes.]
$
  y(t_n + Delta t) & = y(t_n) + dot(y)(t_n) Delta t + 1/2 dot.double(y)(t_n) Delta t^2 + 1/6 dot.triple(y)(t_n) Delta t^3 + cO_s (Delta t^4) \
  & = y_n + f(y_n) Delta t + 1/2 [dif/(dif t) f(y_n)] Delta t^2 + 1/6 [(dif^2)/(dif t^2) f(y_n)] Delta t^3 + cO_s (Delta t^4) \
  & = y_n + f(y_n) Delta t + 1/2 f'(y_n) f(y_n) Delta t^2 \
  & quad + 1/6 [f''(y_n) [f(y_n)]^2 + [f'(y_n)]^2 f(y_n)] Delta t^3 + cO_s (Delta t^4).
$ <eq:exact>
In eq. @eq:exact, we used the original ODE in between the first and second line and executed the chain rule to arrive at the third.

Now, taking the difference of $y_(n+1)$ with the exact solution $y(t + Delta t)$, we see that the terms linear and quadratic in $Delta t$ cancel, and the Runge-Kutta error $e_"RK"$ is of order three:
$
  e_"RK" & = y_(n+1) - y(t_n + Delta t) \
         & = 1/12 [f''(y_n) [f(y_n)]^2 - 2 [f'(y_n)]^2 f(y_n)] Delta t^3 + cO_s (Delta t^4).
$

#note[We can carry this scheme even further by adding more and more evaluations of $f(y)$ into each step. Adding up the right combinations of higher-order terms thus obtained, we can eliminate the error terms order by order. This is the fundamental idea of the Runge-Kutta method. By far in most common use is the _fourth-order_ Runge-Kutta formula, because order $n = 4$ is the highest order that only requires $n$ function evaluations. Methods of order $n >= 5$ require _more than_ $n$ evaluations.]

= Integration of a stiff equation

#task[
  Consider an ionized plasma of hydrogen gas that radiatively cools. Its temperature evolution is governed by the equation
  $ (dif T)/(dif t) = -2/(3 kB) n_upright(H) Lambda(T), $ <eq:cooling>
  where $Lambda(T)$ describes the cooling rate as a function of temperature, $kB = 1.38 times 10^(-16) unit("erg") unit("K")^(-1)$ is Boltzmann's constant, and $n_upright(H)$ is the number density of hydrogen atoms. The cooling rate is a strong function of temperature $T$, which we here approximate by
  $ Lambda(T) = cases(Lambda_0 (T/T_0)^alpha\, quad & "for" T <= T_0, Lambda_0 (T/T_0)^beta\, & "for" T > T_0), $
  with $Lambda_0 = 10^(-22) unit("erg") unit("cm")^3 unit("s")^(-1)$, $T_0 = 20 thin 000 unit("K")$, $alpha = 10.0$, and $beta = -0.5$. We consider isochoric cooling of gas at density $n_upright(H) = 1.0 unit("cm")^(-3)$, with an initial temperature of $T_upright(i) = 10^7 unit("K")$.
  + Determine the temperature evolution $T(t)$ by integrating eq. @eq:cooling with a second-order explicit Runge-Kutta scheme and a fixed timestep of $Delta t = 10^10 unit("s")$, until the temperature has dropped below 6000~K. Make a plot of the time evolution of the temperature, with a logarithmic scale for temperature and a linear scale for the time.
  + How many steps do you roughly need in part (a) to reach the final temperature? Try to play with the timestep size and see whether you can significantly enlarge the timestep without becoming unstable.
  + Now implement the second-order integration from part (a) with an adaptive step size control, based on estimating the local truncation error by carrying out two half-steps for every step. Use an absolute local error limit $Delta T_"err"^max = 50 unit("K")$ for every step. Overplot your result for the temperature evolution, on the plot for part (a), using symbols or a different color. How many steps do you now need? Confirm that your scheme is robust to large changes of the timestep size given as input for the first step.
]

+ A plot of the temperature evolution of the system described by eq. @eq:cooling is shown in @fig:cooling.
  #figure(fig("cooling-rk2", width: 50%), caption: [Second-order Runge-Kutta temperature evolution]) <fig:cooling>
+ Starting from an initial temperature $T_upright(i) = 10^7 unit("K")$, it took our simulation roughly $54 thin 000$ timesteps to reach the final temperature of $T_upright(f) = 6000 unit("K")$.

  As expected, the simulation remains stable upon shrinking of the stepsize by a factor of 10 (see @fig:stepsizes (a)). For comparison, the original simulation is shown in @fig:stepsizes (b). The output also remains invariant when increasing the stepsize by factors of 2 and 4 as shown in @fig:stepsizes (c) and (d), respectively. Upon increasing $Delta t$ by a factor of 6, we introduce the first numerical artifacts (@fig:stepsizes (e)), and when going as far as a factor of 10, the simulation aborts prematurely, i.e. before reaching the final temperature $T_upright(f) = 6000 unit("K")$ (@fig:stepsizes (f)).
  #figure(
    panels(3, (
      ("cooling-dt-1e9", $Delta t = 10^9 unit("s")$),
      ("cooling-dt-1e10", $Delta t = 10^10 unit("s")$),
      ("cooling-dt-2e10", $Delta t = 2 times 10^10 unit("s")$),
      ("cooling-dt-4e10", $Delta t = 4 times 10^10 unit("s")$),
      ("cooling-dt-6e10", $Delta t = 6 times 10^10 unit("s")$),
      ("cooling-dt-1e11", $Delta t = 10^11 unit("s")$),
    )),
    caption: [Temperature evolutions for different stepsizes $Delta t$.],
  ) <fig:stepsizes>
+ Step doubling is a common means for adaptive stepsize control in Runge-Kutta. Comparing the result of a big step with that of two half-sized ones gives a convenient criterion for adjusting the stepsize for the next step, or for recalculating the current step with smaller stepsize if the mismatch was deemed too great.

  For the stepsize $Delta t = 10^10 unit("s")$ as used in part (a) where a second-order Runge-Kutta implementation still showed ample stability, the temperature evolutions with and without adaptive stepsize control look identical (@fig:adaptive (a)). However, increasing the stepsize to the limit of second-order stability as determined in part (b), we find in @fig:adaptive (b) that the adaptive stepsize control upholds stability. This remains true even when increasing the initial stepsize by four orders of magnitude, as seen in @fig:adaptive (c).
  #figure(
    panels(3, (
      ("cooling-adaptive-dt-1e10", $Delta t = 10^10 unit("s")$),
      ("cooling-adaptive-dt-6e10", $Delta t = 6 times 10^10 unit("s")$),
      ("cooling-adaptive-dt-1e14", $Delta t = 10^14 unit("s")$),
    )),
    caption: [Temperature evolution according to Runge-Kutta with adaptive stepsize control],
  ) <fig:adaptive>

= Double pendulum

#task[
  #grid(
    columns: (1fr, auto),
    column-gutter: 1em,
    align: horizon,
    [We consider a friction-less double pendulum that is constrained to move in one plane. The two masses $m_1$ and $m_2$ are connected via massless rods of length $l_1$ and $l_2$, respectively, as depicted in the sketch.],
    pendulum,
  )
  The Lagrangian of this system is given by the expression
  $
    L = & m_1/2 l_1^2 dot(p1)^2 + m_2/2 [l_1^2 dot(p1)^2 + l_2^2 dot(p2)^2 + 2 l_1 l_2 dot(p1) dot(p2) cos(p1 - p2)] \
        & - m_1 g l_1 (1 - cos p1) - m_2 g [l_1 (1 - cos p1) + l_2 (1 - cos p2)]
  $
  + Derive the Lagrangian equations of motion,
    $ dif/(dif t) (partial L)/(partial dot(phi.alt)_i) - (partial L)/(partial phi.alt_i) = 0, #h(3em) i in {1, 2} $
    for the angles $p1$ and $p2$. \
    _Hint_: Declare conjugate momenta $q_i = (partial L)/(partial dot(phi.alt)_i)$ and _do not_ explicitly carry out the absolute time derivative; it is sufficient if you give $(dif q_1)/(dif t)$ and $(dif q_2)/(dif t)$.
  + Cast the system of equations into first-order form, such that the dynamics is described by the ODE
    $ (dif by)/(dif t) = bf(by) $
    where $by$ is a four-component vector. \
    _Hint_: Use the conjugate momenta to eliminate the second derivatives, i.e. adopt $by = (p1, p2, q_1, q_2)$ as state vector.
  + Write a program that integrates the system with a second-order predictor-corrector Runge-Kutta scheme. Consider the initial conditions $p1 = 50 degree$, $p2 = -120 degree$, $dot(p1) = dot(p2) = 0$, and adopt $m_1 = 0.5$, $m_2 = 1.0$, $l_1 = 2.0$, and $l_2 = 1.0$. For simplicity, we shall use units where $g = 1$. Use a fixed timestep of size $Delta t = 0.05$, and integrate for the period $T = 100.0$ time units (equivalent to 2000 steps). Plot the relative energy error,
    $ eta_E = (E_"tot" (t) - E_"tot" (t_0))/(E_"tot" (t_0)), $
    as a function of time.
  + Produce a second version of your code that uses a fourth-order Runge-Kutta scheme instead. Repeat the simulation from part (c) with the same timestep size, and again plot the energy error. How does the size of the error at the end compare, and is this consistent with your expectations?
  + Let's make a visualization of our double pendulum in order to get a feel for its interesting and quite complex behavior. In fact, this pendulum is one of the simplest systems that shows non-linear chaotic behaviour. We would like to end up with a movie file, so this part of the exercise is also meant to guide you through the steps that are necessary for this. But you may also hand in a sequence of still images if you prefer.

    A standard method to make a digital movie is to produce a stack of images equally spaced in time, and then to encode them into a heavily compressed digital video stream. Suppose you have produced such images, named `pic_000.jpg`, `pic_001.jpg`, `pic_002.jpg`, etc. Perhaps the simplest method to make a movie file from them is to encode them with the `ffmpeg` program. A possible command for this is
    ```sh
    ffmpeg -r 24 -qscale 1 -i pic_%03d.jpg movie.mp4
    ```
    which will make use of a high-quality MPEG-4 compression scheme and a frame rate of 24 images per second. Numerous alternative programs for this exist, including `mencoder` and others.

    To produce the images you can for example use the Python template that is provided on Moodle and combine it with your pendulum simulation code. For a nice result, you may want to plot besides the current position of the pendulum the track of all past positions of the masses, as shown in the Python example.
]

+ The conjugate momenta are
  $ q_1 equiv (partial L)/(partial dot(p1)) = (m_1 + m_2) l_1^2 dot(p1) + m_2 l_1 l_2 dot(p2) cos(p1 - p2) $ <eq:q1>
  $ q_2 equiv (partial L)/(partial dot(p2)) = m_2 l_2^2 dot(p2) + m_2 l_1 l_2 dot(p1) cos(p1 - p2) $ <eq:q2>
  By the Euler-Lagrange equations, their time derivatives have to equal
  $ dot(q)_1 = (partial L)/(partial p1) = -m_2 l_1 l_2 dot(p1) dot(p2) sin(p1 - p2) - (m_1 + m_2) g l_1 sin p1 $
  $ dot(q)_2 = (partial L)/(partial p2) = m_2 l_1 l_2 dot(p1) dot(p2) sin(p1 - p2) - m_2 g l_2 sin p2 $
+ By rewriting eqs. @eq:q1 and @eq:q2 for the conjugate momenta in a vector notation, we obtain
  $ vec(q_1, q_2) = mat((m_1 + m_2) l_1^2, m_2 l_1 l_2 cos(p1 - p2); m_2 l_1 l_2 cos(p1 - p2), m_2 l_2^2) vec(dot(p1), dot(p2)) equiv A vec(dot(p1), dot(p2)). $ <eq:matrix>
  Since,
  $
    det(A) & = (m_1 + m_2) l_1^2 dot m_2 l_2^2 - m_2^2 l_1^2 l_2^2 cos^2 (p1 - p2) \
           & = m_1 m_2 l_1^2 l_2^2 + m_2^2 l_1^2 l_2^2 sin^2 (p1 - p2) \
           & = m_2 l_1^2 l_2^2 (m_1 + m_2 sin^2 (p1 - p2)) != 0,
  $
  $A$ is invertible and we can easily find an expression for $dot(p1)$, $dot(p2)$ by multiplying eq. @eq:matrix from the left with $A^(-1)$:
  $ vec(dot(p1), dot(p2)) = A^(-1) vec(q_1, q_2), $ <eq:inverted>
  where the inverse of $A$ is given by
  $ A^(-1) = 1/det(A) "adj"(A) = 1/det(A) mat(m_2 l_2^2, -m_2 l_1 l_2 cos(p1 - p2); -m_2 l_1 l_2 cos(p1 - p2), (m_1 + m_2) l_1^2). $ <eq:inverse>
  By inserting eq. @eq:inverse into eq. @eq:inverted, we can read off the angular velocities,
  $ dot(p1) = inv(1, 1) q_1 + inv(1, 2) q_2, $ <eq:phi1-dot>
  $ dot(p2) = inv(2, 1) q_1 + inv(2, 2) q_2. $ <eq:phi2-dot>
  Defining $by = (p1, p2, q_1, q_2)^T$, we obtain the ordinary differential equation
  $ (dif by)/(dif t) = bf(by) $
  where the right-hand side is given by
  $
    bf(by) & = (dot(p1), dot(p2), dot(q)_1, dot(q)_2)^T = (inv(1, 1) q_1 + inv(1, 2) q_2, #h(0.5em) inv(2, 1) q_1 + inv(2, 2) q_2, #h(0.5em) (partial L)/(partial p1), #h(0.5em) (partial L)/(partial p2))^T \
    & = vec(
      inv(1, 1) q_1 + inv(1, 2) q_2,
      inv(2, 1) q_1 + inv(2, 2) q_2,
      -m_2 l_1 l_2 (inv(1, 1) q_1 + inv(1, 2) q_2)(inv(2, 1) q_1 + inv(2, 2) q_2) sin(p1 - p2) - (m_1 + m_2) g l_1 sin p1,
      m_2 l_1 l_2 (inv(1, 1) q_1 + inv(1, 2) q_2)(inv(2, 1) q_1 + inv(2, 2) q_2) sin(p1 - p2) - m_2 g l_2 sin p2,
    )
  $
  where we inserted eqs. @eq:phi1-dot and @eq:phi2-dot for $dot(p1)$ and $dot(p2)$. Notably, $A^(-1)$ depends only on $p1$ and $p2$.
+ The relative energy error's time-evolution under a second-order Runge-Kutta integration scheme for the specified initial conditions is shown in @fig:energy (a).
  #figure(
    panels(2, (
      ("pendulum-energy-error-rk2", [Second-order accuracy]),
      ("pendulum-energy-error-rk4", [Fourth-order accuracy]),
    )),
    caption: [Time evolution of the Runge-Kutta relative energy error],
  ) <fig:energy>
+ @fig:energy (b) displays the relative energy error of a calculation with matching initial conditions but performed at fourth-order accuracy. As expected, the absolute error still increases over time, but much slower than compared to that of second-order Runge-Kutta.
+ See `double-pendulum.mp4`.
