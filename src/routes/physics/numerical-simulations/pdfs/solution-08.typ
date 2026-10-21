#import "/notes.typ": note, task, vb
#import "/numerical-simulations/sheet.typ": fig, panels, sheet, booktable

#show: sheet.with(8, [January 8th, 2016], [Hyperbolic conservation laws and finite volume scheme])
#show figure.where(kind: table): set figure.caption(position: top)

#let (bU, bF, bG, bK) = ($vb(U)$, $vb(F)$, $vb(G)$, $vb(K)$)
#let tA = $tilde(upright(bold(A)))$
#let bA = $upright(bold(A))$
#let (tu, tv) = ($tilde(u)$, $tilde(v)$)
#let (imh, iph) = ($i - 1/2$, $i + 1/2$)
#let col(..xs) = math.vec(delim: "(", ..xs)


= An isothermal Riemann problem

#task[
  Consider the isothermal gas equations in one dimension, governed by the set of conservation laws
  $ partial_t col(rho, rho u) + partial_x col(rho u, rho(u^2 + c_s^2)) = 0, $ <eq:isothermal>
  where $rho$ and $u$ are the gas density and velocity, respectively, and $c_s$ is the constant speed of sound. We now consider two streams of gas of equal density $rho_0$ that collide at time $t_0 = 0$ at a fiducial interface $x = 0$, i.e. at $t_0 = 0$, the density is $rho(x) = rho_0$, and the velocity field is $u(x) = -u_0$ for $x > 0$ and $u(x) = u_0$ for $x < 0$.
  + Make a sketch of $rho(x)$ and $u(x)$ at some later time $t_1 > t_0$.
  + Now suppose the density measured at $x = 0$ at this later time is $rho_1 = 3 rho_0$, and a shock propagating towards the right, starting at $x = 0$, has been identified. Calculate the shock velocity in units of $u_0$. (Note that another shock is moving with equal but opposite velocity to the left.)
  + Determine the sound speed in units of $u_0$.
  + What is the Mach number of the two shocks (i.e. their velocity relative to the pre-shock gas, divided by the sound-speed)?
]

+ @fig:sketch (a) and (b) give a rough idea of how the gas density $rho(x)$ and velocity $u(x)$ look like at time $t_1 > t_0$ after the two shocks have begun their outward propagation.
  #figure(
    panels(2, (("riemann-sketch-density", [Sketch of $rho(x)$]), ("riemann-sketch-velocity", [Sketch of $u(x)$]))),
    caption: [Density and velocity distribution in the Riemann problem some time after the initial conditions were allowed to evolve],
  ) <fig:sketch>
+ The Euler equations in their weak formulation as integral equations remain valid even at the discontinuity of a shock front, meaning that even at a shock, mass, momentum and energy must be conserved. These requirements are known as the Rankine-Hugoniot jump conditions and they govern the change in density $rho$, pressure $P = rho c_s^2$, and velocity $u$ during a shock:
  #let jump(lhs, flux, punct) = $#box(width: 13em, align(left, $lhs$)) #box(width: 19em, align(left)[(#flux flux in $limits(=)^!$ #flux flux out)#punct])$
  $ #jump($rho_i u_i = rho_o u_o$, "mass", ",") $ <eq:mass>
  $ #jump($rho_i u_i^2 + P_i = rho_o u_o^2 + P_o$, "momentum", ",") $ <eq:momentum>
  $ #jump($(rho_i e_i + P_i) u_i = (rho_o e_o + P_o) u_o$, "energy", ".") $ <eq:energy>
  #note[
    An isothermal shock necessarily involves some form of heat dissipation, such as thermal radiation. No such process is included in eq. @eq:energy, as it was already absent from its root, the third Euler equation,
    $ partial_t (rho e) + partial_x [(rho e + P) u] = 0. $ <eq:euler-energy>
    Thus, eq. @eq:energy is an incomplete statement about energy conservation in the context of isothermal processes. This also explains the third Euler equation's absence from the isothermal gas equations @eq:isothermal, which are otherwise identical to the Euler equations. While eqs. @eq:energy and @eq:euler-energy could be modified to incorporate heat dissipation, it is more common to simply replace them by the requirement that the flow should return to its original temperature after the shock has passed, i.e.
    $ T_0 = T_1. $
    Conditions @eq:mass and @eq:momentum are derived from the integral form of eq. @eq:isothermal and continue to hold without change also for isothermal systems.
  ]
  To determine the shock velocity, we need to take into account that the two shock waves propagating outward in either direction from $x = 0$ form a compressed region of constant density $rho_1 = 3 rho_0$ and, by symmetry, zero velocity $u_1 = 0$. Furthermore, gas which has not yet gone through the shock front is undisturbed, i.e. still travels with velocity $u_0$ towards the shock. The trick with problems such as this one is to move into the rest frame of one of the shock waves. Let us choose the right-moving one where gas travels into the shock with density $rho_i = rho_0$ and velocity $u_i = -u_0 - u_s$ and out again with density $rho_o = 3 rho_0$ and velocity $u_o = -u_s$. Inserting these values into the first Rankine-Hugoniot condition, i.e. eq. @eq:mass, we obtain
  $ rho_0 (-u_s - u_0) = -3 rho_0 u_s, $
  Solving for $u_s$, we get a shock velocity of
  $ u_s = u_0/2. $
+ We use again that in the rest frame of the shock, gas flows into it with velocity $u_i = -u_0 - u_s$ and out again with $u_o = -u_s$. The in- and outgoing densities remain $rho_i = rho_0$ and $rho_o = rho_1 = 3 rho_0$, so that the second jump condition reads
  $ rho_0 [(u_0 + u_s)^2 + c_s^2] = 3 rho_0 (u_s^2 + c_s^2). $
  which can be simplified to
  $ u_0^2 + 2 u_0 u_s + u_s^2 + c_s^2 = 3 u_s^2 + 3 c_s^2. $
  By inserting our result for the shock velocity from part (b), we obtain
  $ underbrace(u_0^2 + 2 u_0 u_0/2 - 2 u_0^2/4, 3/2 u_0^2) = 2 c_s^2 $
  and thus arrive at a speed of sound of
  $ c_s = sqrt(3)/2 u_0. $
+ The Mach number is defined as the ratio of the shock velocity to the speed of sound _in the rest frame of the gas_ which is hit by the shock. Since in the rest frame of the shock, the gas flows into the shock with velocity $-u_0 - u_s$, the shock appears to move towards the gas with velocity $u_0 + u_s$ in its own rest frame. Dividing $u_0 + u_s$ by the speed of sound, we get a Mach number of
  $ cal(M) = (u_0 + u_s)/c_s = (u_0 + u_0/2)/(sqrt(3)/2 u_0) = sqrt(3). $

= Roe's approximate Riemann solver for the isothermal problem

#task[
  We begin by considering the one-dimensional isothermal Riemann problem, augmented with an advection of the $y$-momentum:
  $ partial_t bU + partial_x bF = 0, $ <eq:conservation>
  where the state vector $bU$ and flux vector $bF(bU)$ are given by
  $ bU = col(rho, rho u, rho v), quad bF = col(rho u, rho(u^2 + c_s^2), rho u v). $
  $c_s$ is the fixed sound speed, and $u$ and $v$ describe the velocity field in the $x$- and $y$-directions, respectively.

  We now seek an (approximate) solution for the flux across the interfaces of cells of width $Delta x$, allowing us to update the state of the cells as
  $ bU_i^(n+1) = bU_i^n + (Delta t)/(Delta x) [bF_imh - bF_iph]. $ <eq:update>
  If we consider each cell interface as an initial value problem with initial conditions
  $ bU(x, 0) = cases(bU_L quad & "for" x < 0\,, bU_R & "for" x > 0\,) $
  then Godunov's original first order method consists of taking as flux $bF_iph = F[bU_iph (0)]$, where $bU_iph (0) = bU_iph (x\/t)$ is the exact self-similar solution of the Riemann problem on the characteristic emanating from the interface. \
  Instead of seeking the exact solution of the isothermal Riemann problem (which is not too difficult actually, but requires the iterative solution of a non-linear equation), we shall here calculate an estimate of the flux based on an approximate solution of the Riemann problem, following the approach of Roe. To this end, we linearize the PDE. We can first rewrite eq. @eq:conservation as
  $ partial_t bU + bA(bU) partial_x bU = 0, quad "where" bA = (partial bF)/(partial bU) $ <eq:linearized>
  is a Jacobian matrix. The central idea for linearizing is now to replace $bA$ with a matrix $tA$ that only depends on the left and right states, $tA = tA(bU_L, bU_R)$. This in turn will convert eq. @eq:linearized into a linear system with constant coefficients. Roe's Riemann solver sets for this matrix
  $ tA = mat(delim: "(", 0, 1, 0; c_s^2 - tu^2, 2 tu, 0; -tu tv, tv, tu), $
  where $tu$ and $tv$ are weighted averages of the velocities of the left and right state, with the weights chosen as square roots of the density, i.e.
  $ tu = (sqrt(rho_L) u_L + sqrt(rho_R) u_R)/(sqrt(rho_L) + sqrt(rho_R)), $
  and similarly for $tv$. Note that $tA(bU, bU) = bA$, i.e. this average is consistent with the original Jacobian. The linearized system can now be diagonalized and solved as a set of linear advection problems.
  + Verify that $lambda_1 = tu - c_s$, $lambda_2 = tu + c_s$, and $lambda_3 = tu$ are eigenvalues of $tA$ with the eigenvectors
    $ bK_1 = col(1, tu - c_s, tv), quad bK_2 = col(1, tu + c_s, tv), quad bK_3 = col(0, 0, 1). $
  + Check that the difference vector $Delta U = (u_1, u_2, u_3) = bU_R - bU_L$ between the states left and right can be expressed in terms of the eigenvectors as $Delta U = sum_i alpha_i bK_i$, with coefficients
    $ alpha_1 = ((tu + c_s) u_1 - u_2)/(2 c_s), quad alpha_2 = (-(tu - c_s) u_1 + u_2)/(2 c_s), quad alpha_3 = u_3 - tv u_1. $
  + Write a subroutine `riemann_roe_isothermal` that takes as input arguments the state left and right of an interface, i.e. $(rho_L, u_L, v_L)$ and $(rho_R, u_R, v_R)$, as well as the sound speed $c_s$, and returns the three components $bF^star = (f_1, f_2, f_3)$ of the flux vector, which is given by
    $ bF^star = 1/2 (bF_L + bF_R) - 1/2 sum_i alpha_i |lambda_i| bK_i. $
  + Test your Riemann solver with the input values given in @tab:roe, assuming $c_s = 2.0$. The first two expected results are included in the table already, verify those and determine the one for the third row.
]

+ Direct computation confirms that the $bK_i$ are eigenvectors of $tA$.
  $ tA bK_1 = col(tu - c_s, c_s^2 - tu^2 + 2 tu (tu - c_s), -tu tv + tv (tu - c_s) + tu tv) = (tu - c_s) col(1, tu - c_s, tv) = lambda_1 bK_1. $
  $ tA bK_2 = col(tu + c_s, c_s^2 - tu^2 + 2 tu (tu + c_s), -tu tv + tv (tu + c_s) + tu tv) = (tu + c_s) col(1, tu + c_s, tv) = lambda_2 bK_2. $
  $ tA bK_3 = col(0, 0, tu) = tu col(0, 0, 1) = lambda_3 bK_3. $
+ We compute the three components of $sum_i alpha_i bK_i$ separately.
  $ (sum_i alpha_i bK_i)_x = alpha_1 + alpha_2 = 1/(2 c_s) [(tu + c_s) u_1 - u_2 - (tu - c_s) u_1 + u_2] = u_1. $ <eq:sum-x>
  $
    (sum_i alpha_i bK_i)_y & = alpha_1 (tu - c_s) + alpha_2 (tu + c_s) \
    & = 1/(2 c_s) [(tu^2 - c_s^2) u_1 - u_2 (tu - c_s) - (tu^2 - c_s^2) u_1 + u_2 (tu + c_s)] = u_2.
  $
  $
    (sum_i alpha_i bK_i)_z & = alpha_1 tv + alpha_2 tv + alpha_3 \
    & = 1/(2 c_s) [(tu + c_s) u_1 tv - u_2 tv - (tu - c_s) u_1 tv + u_2 tv + 2 c_s (u_3 - tv u_1)] = u_3.
  $ <eq:sum-z>
  Combining eqs. @eq:sum-x to @eq:sum-z, we indeed have
  $ sum_i alpha_i bK_i = col(u_1, u_2, u_3) = Delta bU. $
+ See `roes_riemann_solver.c`.
+ A test of our Riemann solver with the input values supplied in @tab:roe was conducted, successfully reproducing the flux values in rows 1 and 2 and generating new values as given in the third row.

#figure(
  booktable(
    columns: 9,
    align: left,
    table.vline(x: 6, stroke: 0.5pt),
    header: ($rho_L$, $u_L$, $v_L$, $rho_R$, $u_R$, $v_R$, $f_1$, $f_2$, $f_3$),
    body: (
      ..([1.0], [1.0], [2.0], [3.0], [1.0], [0.0], [0.0], [6.0], [1.268]),
      ..([2.5], [2.0], [3.0], [1.0], [$-3.0$], [$-2.0$], [2.6243], [24.602], [12.475]),
      ..([2.0], [$-1.0$], [$-2.0$], [1.0], [$-1.0$], [2.0], [$-0.5$], [5.5], [$-2.172$]),
    ),
  ),
  caption: [Riemann solver input values and results],
  kind: table,
) <tab:roe>

= Doing a one-dimensional sweep

#task[
  We now consider a two-dimensional periodic domain of extension $[L_x, L_y]$, subdivided into $N times M$ cells. We want to carry out on this domain one timestep according to eq. @eq:update, with Roe's approximate flux as derived above. \
  To this end, write a subroutine sweep that takes as input parameters the density field $rho[i, j]$ and the velocity fields $u[i, j]$ and $v[i, j]$. Further, the routine should accept the timestep $Delta t$ and the mesh-spacing $Delta x$, as well as the mesh dimensions $N$ and $M$ as input. Finally, pass two small relative offset vectors to the routine which tell it which cell should be considered "left" and which "right" of any current cell. For example, if the $x$-direction is evolved, this offset vector would be $(-1, 0)$ for the left cell and $(+1, 0)$ for the right cell, since $rho_(i-1,j)$ is then considered "left" of $rho_(i,j)$. In terms of output, the subroutine should automatically update the input fields $rho[i, j]$, $u[i, j]$ and $v[i, j]$ with the new values at the end of the timestep. \
  Implement the following steps in the routine `sweep`:
  + Create three empty arrays for the components of the new state $U^(n+1) = (q_1, q_2, q_3)$ at the end of the sweep.
  + Write two nested loops that go over all primary cells, $i in {0, ..., N - 1}$, $j in {0, ..., M - 1}$, and which identify the left and right cells of the current cell (here you need to observe the periodic boundary conditions by wrapping around if needed). Call the routine `riemann_roe_isothermal` that you wrote for both the left and the right interface of the cell, obtaining two flux vectors, $bF_imh^star$ and $bF_iph^star$. Calculate the new state of each cell as
    $ bU^(n+1) = bU^n + (Delta t)/(Delta x) [bF_imh^star - bF_iph^star]. $
  + Based on $q_1[i, j]$, $q_2[i, j]$, and $q_3[i, j]$, calculate the new values for the density field and the velocity fields $u[i, j]$ and $v[i, j]$, which forms the output of the routine.
]

For parts (a) to (c), see `roes_riemann_solver.c`.

= Carrying out a multidimensional simulation

#task[
  We now consider the full two-dimensional isothermal problem, which takes the form
  $ partial_t bU + partial_x bF + partial_y bG = 0, $
  with
  $ bU = col(rho, rho u, rho v), quad bF = col(rho u, rho(u^2 + c_s^2), rho u v), quad bG = col(rho v, rho u v, rho(v^2 + c_s^2)). $
  As we discussed in the lecture, one possibility to solve this system lies in operator splitting, essentially by achieving a full time advance over a timestep $Delta t$ by solving the two problems
  $ partial_t bU + partial_x bF = 0, $
  and
  $ partial_t bU + partial_y bG = 0, $ <eq:y-step>
  independently one after the other. To linear order in time, this can be simply done by carrying out sweeps for these equations one after the other.
  + Verify that our subroutine `sweep` can be used without change to carry out a sweep in the $y$-direction, corresponding to a step of eq. @eq:y-step, provided the velocity fields are appropriately passed. The sequence of calls
    ```c
    sweep(ρ, u, v, Δt, Δx, c_s, N, M, -1, 0, 1, 0);
    sweep(ρ, v, u, Δt, Δy, c_s, N, M, 0, -1, 0, 1);
    ```
    can hence be used to first do a sweep in the $x$-direction, followed by one in the $y$-direction.
  + Write a short code that integrates the two-dimensional isothermal problem over a certain time interval $[0, T_max]$, based on your function sweep. Adopt as timestep
    $ Delta t = C_"CFL" min(Delta x, Delta y)/(c_s + max(u, v)). $
  + For definiteness, take $L_x = 3.0$, $L_y = 1.5$, $c_s = 2.0$, $T_max = 1.5$, and the initial conditions
    $ rho(x, y) = cases(4.0 quad & "for" |x - L_x\/2| < L_x\/4 "and" |y - L_y\/2| < L_y\/4\,, 1.0 & "otherwise"\,) $
    with $u(x, y) = v(x, y) = 0$. Evolve the system with $C_"CFL" = 0.4$ and $N = 60$, $M = 30$. Plot the density field at the final time $t = T_max$ along the $x$-axis and along the $y$-axis through the mid-point of the box. If everything works, the result for the $y$-axis should not be too different from the result in @fig:expected.

    Optional: You may also produce a movie of the time evolution of the density field, and try things out with higher grid resolution.
]

#figure(fig("roe-expected-density-y", width: 45%), caption: [Expected result]) <fig:expected>

For parts (a) and (b), see `roes_riemann_solver.c`.
#set enum(start: 3)
+ @fig:density (a) and (b) show the density at final time $T_max$ along lines of constant $x$ and $y$, respectively.
  #figure(
    panels(2, (("roe-density-y", [$rho(y)$ for constant $x$]), ("roe-density-x", [$rho(x)$ for constant $y$]))),
    caption: [Density $rho(x, y)$ at final time $T_max$ along lines parallel to the $x$- and $y$-axis through the middle of the simulation domain],
  ) <fig:density>
