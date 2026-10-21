#import "/notes.typ": notes, task, eps, ev
#import "/numerical-simulations/sheet.typ": cO

#show: notes.with(
  title: [Fundamentals of Simulation Methods],
  subtitle: [Final Exam with Answers],
  date: [Janosh Riebesell #sym.dot.c Lecturer: Volker Springel #sym.dot.c February 8th, 2016],
)
#set heading(numbering: "1")
#set math.equation(numbering: "(1)")
#set enum(numbering: "a)")

#let epsm = $epsilon.alt_upright(m)$
#let pts(n) = text(size: 9pt)[(#n pts)]

*Note* #h(0.5em) The provided answers earned a 1,0 in the actual exam.

= Short questions #pts(24)

#task[
  State whether the following statements are right or wrong, and discuss in 1 to 2 sentences why this is the case. Note: there might be any number of correct statements.
  + Solvers for fluid dynamical problems:
    #set enum(numbering: "1)")
    + Finite-volume solvers on a fixed Cartesian grid are Galilean invariant.
    + Smoothed particle hydrodynamics has a higher spatial resolution in high density regions.
    + The spatial order of a discontinuous Galerkin scheme can be increased by increasing the order of the basis polynomials.
    + Roe's Riemann solver provides an exact solution of the piecewise constant initial value problem.
]

+ Fluid dynamics
  #set enum(numbering: "1)")
  + False. Smoothed particle hydrodynamics are fully Galilean invariant. Finite-volume solvers are not.
  + Correct. Due to its Lagrangian character, the local resolution of SPH follows the mass flow automatically, a property that is convenient in representing the large density contrasts often encountered in astrophysical simulations.
  + Correct. This so-called $p$-refinement can even be remarkably more efficient than an $h$-refinement, i.e. an increase in the grid resolution.
  + False. As the full name Roe's _approximate_ Riemann solver suggests, it yields an approximate solution.

#task[
  #set enum(start: 2)
  + You want to solve Poisson's equation for a given density field on a 3D periodic grid of 1000 cells per dimension using iterative solvers. First, you employ a Gauss-Seidel iteration scheme and find the system to converge quite slowly. Which of the following methods could be used to speed up the convergence rate?
    #set enum(numbering: "1)")
    + Jacobi iteration scheme instead of Gauss-Seidel.
    + Red-black sweeps.
    + Multigrid methods.
    + Clouds-in-cell (CIC) assignment.
]

#set enum(start: 2)
+ Iterative solvers
  #set enum(numbering: "1)")
  + False. Gauss-Seidel's immediate use of updated $Phi$-values allows it to attain a faster (usually close to twice as fast) rate of convergence than experienced with Jacobi iterations.
  + False. Red-black sweeping is a way to (partially) overcome Gauss-Seidel's poor parallelizability and the dependence of the final result on which grid element is taken first when starting the iteration. It does not improve the convergence rate.
  + Correct. Multigrid methods converge _substantially_ faster than Gauss-Seidel. That is because multigrid methods operate on much coarser and hence computationally cheaper grids for much of the time. Converged results from the coarse grid levels are used to improve the initial guess on finer levels, reducing the amount of work that has to be done at full resolution.
  + False. CIC is a mass (or charge) assignment kernel used with the particle mesh technique. It has nothing at all to do with iterative solvers.

#task[
  #set enum(start: 3)
  + When simulating a collisionless system, gravitational softening is needed to
    #set enum(numbering: "1)")
    + prevent self-forces on particles.
    + reduce two-body interactions with sizable deflections.
    + prevent the formation of bound particle pairs.
    + allow the use of the Verlet integrator instead of a 2nd-order Runge-Kutta.
]

#set enum(start: 3)
+ Gravitational softening
  #set enum(numbering: "1)")
  + False. Self-forces are unrelated to gravitational softening. Vanishing self-forces are ensured by employing the same assignment kernel $W$ to calculate forces at the particle positions as was used in the initial density construction on the fiducial mesh.
  + Correct. In a singular potential, close-range interactions result in large-angle scatterings. Adding a softening parameter $eps$ to the gravitational potential effectively introduces a smallest resolved length scale into the system which prohibits such close contact.
  + Correct. If $ev(v^2) >> (G m)/eps$, a softening length $eps$ prevents highly correlated bound states which would violate the system's supposed collisionlessness.
  + False. The Verlet method is a symplectic integrator particularly popular in molecular dynamics simulations. A gravitational softening is in no way related to the use of a specific integrator.

#set enum(start: 1)

= Runge-Kutta methods #pts(24)

#figure(image("/numerical-simulations/figures/kepler-orbit-rk2.pdf", width: 45%), caption: [Kepler orbit]) <fig:kepler>

#task[
  An explicit Runge-Kutta method to solve the equation
  $ dif/(dif t) y = f(t) $ <eq:ode>
  needs two function evaluations and can be generally written as
  $ y(t + Delta t) = y(t) + [b_1 f(t) + b_2 f(t + alpha Delta t)] Delta t. $ <eq:rk>
  + Show that for the construction of the second-order accurate scheme, $b_1$, $b_2$, and $alpha$ are not uniquely determined. Which relations do $b_1$, $b_2$, and $alpha$ have to obey?
  + @fig:kepler shows an orbit (i.e. a planet orbiting around a star) integration carried out with a Runge-Kutta method. How can you recognize that the result is inaccurate? Explain how the accuracy could be improved.
]

+ The relations that $b_1$, $b_2$ and $alpha$ need to fulfill in order for eq. @eq:rk to constitute a second-order accurate integrator follow from two straightforward Taylor expansions. For the exact solution $y_"ex" (t + Delta t)$, we can write
  $
    y_"ex" (t + Delta t) & = y(t) + dot(y)(t) Delta t + 1/2 dot.double(y)(t) Delta t^2 + cO_s (Delta t^3) \
               & = y(t) + f(t) Delta t + 1/2 dot(f)(t) Delta t^2 + cO_s (Delta t^3),
  $
  where we used the ODE @eq:ode in the second step. $f(t + alpha Delta t)$ on the other hand, we may expand into
  $ f(t + alpha Delta t) = f(t) + alpha dot(f)(t) Delta t + cO_s (Delta t^2). $
  The difference between the exact solution $y_"ex" (t + Delta t)$ and the approximate method $y(t + Delta t)$ is then
  $
    y_"ex" (t + Delta t) - y(t + Delta t) & = y(t) + f(t) Delta t + 1/2 dot(f)(t) Delta t^2 + cO_s (Delta t^3) \
    & quad - {y(t) + [b_1 f(t) + b_2 (f(t) + alpha dot(f)(t) Delta t + cO_s (Delta t^2))] Delta t} \
    & = (1 - b_1 - b_2) f(t) Delta t + (1/2 - alpha b_2) dot(f)(t) Delta t^2 + cO_s (Delta t^3).
  $
  Thus, eq. @eq:rk is second-order accurate if
  $ 1 - b_1 - b_2 = 0 wide "and" wide 1/2 - alpha b_2 = 0. $
  These are just two constraints for the three variables $b_1$, $b_2$, and $alpha$. They are hence not uniquely determined by requiring second-order accuracy alone.
+ The simulation's inaccuracy manifests itself in the rapidly changing orbit and its increasing eccentricity. Both suggest a violation of phase-space volume conservation (as mandated by the Liouville theorem) and a secular drift of the total energy.

  The simulation could be carried out with higher accuracy by resorting to a symplectic integrator. When applied to Hamiltonian systems such as a Kepler orbit, their use of structure-preserving maps awards them with excellent conservation properties as far as the above-mentioned energy and phase-space volume are concerned.

= Pitfalls of floating point math #pts(24)

#task[
  + Assume you have a single-precision IEEE floating point variable $x$ (which has a mantissa of 24~bit). You use it as a counter in a loop that carries out $10^9$ iterations, and in each iteration you add 1 to $x$ (starting with an initial value $x = 0$). Once the loop has finished, what do you get for $x$? Why?
  + Now repeat the experiment from above, but you add 4 to $x$ in each iteration of the loop. What will be the final result now? Why?
  + Suppose you have a long data set with $N$ measurement values $x_i$, and you want to determine the variance
    $ sigma^2 = ev(x^2) - ev(x)^2 $
    of them. Let's consider two possible approaches to implement this on a computer:
    #set enum(numbering: "1)")
    + We first write a loop to build the sum of the $x_i$, namely
      $ S = sum_(i=1)^N x_i, $
      and the sum of the $x_i^2$ as
      $ T = sum_(i=1)^N x_i^2, $
      then we calculate $sigma^2$ as
      $ sigma^2 = T/N - S^2/N^2. $
    + Alternatively, we do not calculate $T$ but write a second loop in which we evaluate
      $ Q = sum_(i=1)^N (x_i - S/N)^2, $
      and then set
      $ sigma^2 = Q/N. $

    Discuss advantages and disadvantages of these solutions.
]

+ One of the most common issues encountered in floating point calculations are round-off errors. Operations such as $x + y = x$ can occur if $y$ lies below the employed data type's machine precision $epsm$, i.e. if $|y| < epsm |x|$. In this case, we have $y = 1$, a precision of $p = 24$, and $epsm = 1/2^p = 1/2^24$, which yields for $x$ a final value of
  $ x_upright(f) = 1/epsm = 2^24 approx 1.68 times 10^7. $
+ If we add 4 with each iteration, the criterion for round-off to occur simply becomes $4 < epsm |x|$, and hence $x_upright(f)$ now reads
  $ x_upright(f) = 4/epsm = 4 times 2^24 approx 6.71 times 10^7. $
+ Method 1) is called a _one-pass_ formula, because $S$ and $T$ can both be calculated simultaneously and independent of each other. On average, $x_i^2 > (x_i - S/N)^2$. Therefore, Method 1) is more prone to suffer from _overflow_. More importantly, if the variance is small compared to $ev(x)^2$, $T\/N$ and $S^2\/N^2$ are two large and nearly equal numbers. Their difference then suffers from _catastrophic cancellation_ and can lose all significant digits or even turn negative.

  Method 2) is a _two-pass_ formula because it first requires calculating $S$ before it is able to determine $Q$. For large deviations $x_i$ from the mean value $S/N$ of the distribution, $Q$ may assume a large value while the summation is still in progress. Repeated small contributions that might add up to significance when put all together will then all be lost to _round-off errors_.

  Method 2) avoids the cancellation and is therefore the numerically more robust choice, at the cost of a second pass over the data. For large $N$, both accumulate round-off in their running sums, which makes the result depend on the ordering of the data (mitigated e.g. by pairwise or Kahan summation).

= Code example #pts(24)

#task[
  The following two functions are part of a code which adds particles to a discrete 1D density field (first function), solves Poisson's equation in some way to calculate a discretized acceleration field (not shown here) and maps the force field back to the particles (second function).
  + Assuming that all parts of the code which are not shown work perfectly fine, what problem will occur when running the code with the two functions shown below?
  + Modify the second function such that the above problem is solved. It's sufficient if you write pseudo code.
  + Do the functions work for periodic boundary conditions? Why?

  ```c
  void add_particle_to_density_field(double rho_field[N], //the density discretized on a grid of length N
      int N,
      double cellsize, //size of a single cell of the grid
      double particle_pos, // the particle position
      double particle_mass) // the particle mass
  {
      double xx = particle_pos / cellsize;
      int i = floor(xx); //floor(x) truncates all decimal digits of the floating point number x, similar to (int) x in C (or: it does a strict rounding to the next lower integer number; floor(5.9) = 5

      double u = xx - i;

      int ii = i + 1;
      if(ii >= N)
          ii = 0;

      rho_field[i] += (1 - u) * particle_mass / cellsize;
      rho_field[ii] += u * particle_mass / cellsize;
  }
  ```

  ```c
  double interpolate_force_field_to_particle_position(double acc_field[N],
      // the acceleration field discretized on a grid of length N
      int N,
      double cellsize, //size of a single cell fo the grid
      double particle_pos, // the particle position
      double particle_mass) // the particle mass
  {
      double xx = particle_pos / cellsize;

      int i = floor(xx + 0.5);

      double acceleration = acc_field[i];

      return acceleration * particle_mass;
  }
  ```
]

+ A particle mesh simulation carried out with the above functions will suffer from nonvanishing self-forces and non-antisymmetric pairwise forces, the reason being that the force interpolation function uses a different assignment kernel than what was used in the initial density construction performed by `add_particle_to_density_field`.
+ The problem may be remedied by modifying the force interpolation as follows:
  ```c
  double interpolate_force_field_to_particle_position(double acc_field[N],
      int N, double cellsize, double particle_pos, double particle_mass)
  {
      double xx = particle_pos / cellsize;

      int i = floor(xx);

      double u = xx - i;

      int ii = i + 1;
      if(ii >= N)
          ii = 0;

      double acc = (1 - u) * acc_field[i] + u * acc_field[ii];

      return acc * particle_mass;
  }
  ```
+ Yes, the two functions are compatible with periodic boundary conditions since `ii` is mapped back to 0 if `ii >= N`.
