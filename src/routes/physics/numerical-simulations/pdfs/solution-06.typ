#import "/notes.typ": note, task, vb, eps, kB, unit, eqby
#import "/numerical-simulations/sheet.typ": fig, sheet

#show: sheet.with(6, [December 4th, 2015], [Molecular Dynamics, Fluid Entropy])

#let (bv, br, ba, nab) = ($vb(v)$, $vb(r)$, $vb(a)$, $vb(nabla)$)
#let DD = $upright(D)$
#let Dt = $DD t$

= A simple molecular dynamics code

#task[
  In this exercise, we construct a simple molecular dynamics code, using first the microcanonical ensemble in which the system is closed and its total energy stays constant. We want to simulate a simple system of $N = N_"1d"^3$ argon atoms, interacting via a Lennard-Jones potential,
  $ V(r) = 4 eps [(sigma/r)^12 - (sigma/r)^6], $
  meaning that the total potential energy is given by
  $ E_"pot" = 1/2 sum_(i != j)^N V(|br_i - br_j|). $
  For argon, we will use the parameters
  $
    sigma & = 3.4 times 10^(-10) unit("m"), \
      eps & = 120 unit("K") dot kB = 1.65 times 10^(-21) unit("J"), \
        m & = 6.69 times 10^(-26) unit("kg"),
  $
  where $sigma$ and $eps$ characterize the potential, and $m$ is the mass of each atom. Write code that integrates the equations of motion of $N$ argon atoms, placed into a cubical box of side-length $L$ with periodic boundary conditions. Proceed along the following steps:
  + In your code, express all length units in terms of $sigma$, all energies in terms of $eps$, and all masses in terms of $m$. In other words, introduce dimensionless distances
    $ br' = br/sigma, $
    dimensionless energies $E' = E\/eps$, etc., and rewrite all relevant equations in terms of the dimensionless quantities. What is a suitable quantity to scale the velocities?
  + Write a function that sets up $N_"1d"$ particles per dimension on a regular grid in a periodic box of size $L$. We adopt a mean particle spacing of $macron(d) = 5 sigma$ (implying that $L' = 5 N_"1d"$ in the scaled length units). For the initial velocities, assume that we prescribe a certain kinetic temperature $T$ in Kelvin, from which we can compute a one-dimensional velocity dispersion as
    $ sigma = sqrt((kB T)/m). $
    Scale this velocity dispersion to internal dimensionless units, yielding $sigma'$. Now draw three random numbers $(tilde(v)_x, tilde(v)_y, tilde(v)_z)$ for every atom from a Gaussian distribution with zero mean and a dispersion of unity, and scale them with $sigma'$ to get the initial velocities $bv' = sigma' tilde(bv)$. This means your initial velocities will then correspond to a Maxwellian with temperature $T$. \
    Note: If you only have a random number generator that produces uniform random numbers in the interval $]0, 1[$, you can produce a Gaussian distributed number $g$ by drawing two random numbers $u_1$, $u_2$ from $]0, 1[$ and transforming them as
    $ g = sqrt(-2 ln(u_1)) cos(2 pi u_2). $
  + Now write a function that calculates the acceleration $ba'_i$ of each particle, in the dimensionless units used by your code. For simplicity, sum over all distinct other particles in the box and always consider the nearest periodic image for each pair. Use a (quite large) cut-off radius for the potential equal to $r_"cut" = 10 sigma$, i.e. set the potential to zero for distances larger than $r_"cut"$.
  + Use the Leapfrog time integration scheme to advance the particles. To this end, prepare a function that 'kicks' the particles with their stored accelerations for a given time interval $Delta t$. Also, produce a function that 'drifts' the particles with constant velocity over a given time interval $Delta t$. After the particles have been moved, map them back periodically into the principal box in case they have left it.
  + Now, write a driver routine that first initializes the particles, and then calculates the accelerations once at the beginning. Add a loop over $N_"steps"$ that first kicks the particles by half a step, then drifts them by the full step, followed by a new force calculation. Finally, complete the step by again kicking the particles by half a step. To simplify the coding work, you can use the C-template provided on the Moodle site. (Note that for this exercise, the speed advantage of C is an asset. You may try with Python as well, but be prepared for significant wait times.)
  + In the force calculation routine, add a computation of the total potential seen by each particle due to its neighbors. Also, write a routine that computes the total kinetic energy and total potential energy of the system, as well as the instantaneous kinetic temperature. Call this function whenever a full timestep has been completed, and output the mean kinetic energy per particle, mean potential energy per particle, and kinetic temperature to a file.
  + Run your code with a timestep $Delta t' = 0.01$ in internal units (corresponding to $Delta t = sqrt(m\/eps) sigma Delta t'$) for 60~000 steps using $N_"1d" = 8$ (i.e. $N = 512$ atoms) and $T_"init" = 80 unit("K")$. Confirm that the total energy is conserved well.
  + Now we want to ensure that the system maintains a temperature equal to a prescribed temperature $T$, meaning that we deviate from the microcanonical ensemble and rather seek a coarse approximation of a canonical ensemble. To this end, add a function that scales the velocities such that the instantaneous kinetic energy corresponds to the imposed value. Call this scaling function every 100th step in your timestep loop.
  + Run your molecular dynamics simulations for the target temperature 80~K, and also for a temperature 70~K. Estimate from the results for the last 10~000 steps (to reduce the influence of the initial transient phase) the molar heat capacity at fixed volume, $C_v$, at the temperature $T approx 75 unit("K")$ (and the given density). Also, do a similar exercise to estimate the heat capacity at a temperature of $T approx 400 unit("K")$. Compare both results with the heat capacity of $C_V = 3/2 R$ expected for a mono-atomic ideal gas, where $R$ is the gas constant. Interpret your result.
  + Finally, carry out an MD simulation where you set the imposed temperature to $T = 30 unit("K")$. Make a plot that shows the mean kinetic and mean potential energies per particle as a function of time, as well as the total mean energy. Interpret your result.
]

+ $w = sqrt(eps\/m)$ defines a suitable scale for in-system velocities.

For parts (b) to (f), see `molecular_dynamics.c`.

#set enum(start: 7)
+ As can be seen from @fig:energy-80k, the total energy at $T = 80 unit("K")$ is stable.
  #figure(fig("md-total-energy-80k", width: 60%), caption: [Total energy $E_"tot"$ as a function of time $t$]) <fig:energy-80k>

For part (h), see `molecular_dynamics.c`.

#set enum(start: 9)
+ For the isochoric heat capacity $C_V (T)$, we find
  $
     C_V (T approx 75 unit("K")) & = 1.7333 thin R, \
    C_V (T approx 400 unit("K")) & = 1.5233 thin R.
  $
  These values suggest that our numerical value approaches the analytic one of $3/2 R$ with increasing temperature. This is expected since with increasing temperature, kinetic energies of individual particles increase relative to their potential energies. At very high temperatures, the Lennard-Jones potential is effectively rendered irrelevant and the system behaves like an ideal gas.
+ @fig:energies-30k displays the kinetic, potential, and total energy over time at $T = 30 unit("K")$.
  #figure(fig("md-energies-30k", width: 60%), caption: [Kinetic, potential and total energy as a function of time $t$]) <fig:energies-30k>
  Since we now rescale the velocities in regular intervals such that the average kinetic energy of each particle produces a constant temperature, the system is effectively coupled to a heat bath. This apparently causes the total energy to decrease over time, from which we can infer that the system gives off heat to its environment. In fact, #link("https://www.youtube.com/watch?v=p28cAWb5_EE")[looking closely] at individual particle positions, we see that groups of argon atoms coalesce into lumps all throughout our simulation domain. We therefore interpret our results as a phase transition, i.e. the condensation of argon gas into argon fog.

= Entropy evolution of an ideal gas
#set enum(start: 1)

#task[
  Consider the _entropic function_
  $ A equiv P/rho^gamma = (gamma - 1) u/rho^(gamma - 1) $ <eq:entropic>
  for an ideal gas with adiabatic index $gamma$ (while $A$ is not identical to the specific thermodynamic entropy, it is a direct function of it and thus can be used in lieu of it).
  + Show from the differential form of the Euler equations that $A$ remains constant along the path of a fluid element, or in other words, that
    $ (DD A)/Dt = 0. $
  + You may have been told that entropy increases at shock waves. How can we reconcile this statement with the above result?
]

+ The Lagrangian (or convective) derivative is defined in terms of the flow velocity $bv$ as
  $ DD/Dt = partial/(partial t) + bv dot nab. $
  By the first Euler equation (representing mass conservation), we have
  $ 0 = (partial rho)/(partial t) + nab dot (rho bv) = ((partial rho)/(partial t) + bv dot nab rho) + rho nab dot bv, $
  which is equivalent to
  $ (DD rho)/Dt = -rho nab dot bv. $ <eq:continuity>
  #note[Physically, $DD rho \/ Dt = 0$ just means that the density $rho$ while moving with the fluid remains constant. This explains why an incompressible fluid has to fulfill $nab dot bv = 0$.]
  Next, we consider the second Euler equation (momentum conservation).
  $ 0 = partial/(partial t) (rho bv) + nab (rho bv^2 + P) = bv ((partial rho)/(partial t) + nab dot (rho bv)) + rho ((partial bv)/(partial t) + bv dot nab bv) + nab P. $
  In the above sum, the first term vanishes due to the first Euler equation. The second contains the Lagrangian derivative of the fluid velocity $bv$. We thus obtain
  $ (DD bv)/Dt = -(nab P)/rho. $ <eq:momentum>
  Finally, the third Euler equation (energy conservation) gives
  $ 0 = partial/(partial t) (rho e) + nab dot [(rho e + P) bv] = e ((partial rho)/(partial t) + nab dot (rho bv)) + rho ((partial e)/(partial t) + bv dot nab e) + nab dot P bv. $
  The first term on the r.h.s. again vanishes by the first Euler equation and the second is the Lagrangian derivative of the total energy per unit mass $e$. We thus obtain
  $ (DD e)/Dt = -P/rho nab dot bv - bv/rho dot nab P. $ <eq:energy>
  Taking eqs. @eq:continuity, @eq:momentum and @eq:energy, we are fully armed to tackle the problem. Using the definition of the entropic function given in eq. @eq:entropic, we can write its Lagrangian derivative as
  $
    (DD A)/Dt & = (gamma - 1)/rho^(gamma - 1) [(DD u)/Dt - ((gamma - 1) u)/rho (DD rho)/Dt] \
    & eqby("eq:continuity") (gamma - 1)/rho^(gamma - 1) [(DD e)/Dt - 1/2 (DD bv^2)/Dt + ((gamma - 1) u)/rho rho nab dot bv] \
    & eqby("eq:energy") (gamma - 1)/rho^(gamma - 1) [-P/rho nab dot bv - bv/rho dot nab P - bv (DD bv)/Dt + P/rho nab dot bv] \
    & eqby("eq:momentum") (gamma - 1)/rho^(gamma - 1) [-bv/rho dot nab P + bv/rho dot nab P] = 0,
  $
  where we used in the second step, that the thermal energy per unit mass $u$ can be expressed as $u = e - bv^2/2$ i.t.o. the total energy p.u.m. $e$ and the fluid velocity $bv$.
+ In the presence of shock waves, thermodynamic quantities such as density, temperature, and entropy exhibit discontinuities. Hence, the starting point of our discussion in part (a), i.e. the Euler equations in differential form, would break down. Consequently, the result of part (a) is not valid for shock waves and entropy is free to increase.
