#import "/notes.typ": note, task, unit
#import "/numerical-simulations/sheet.typ": fig, panels, sheet

#show: sheet.with(7, [December 11th, 2015], [Fluid instability and blast waves])

#let cM = $cal(M)$
#let excl = $limits(=)^!$
#let dif = $upright(d)$
#let athena = "http://www.astro.princeton.edu/~jstone/downloads/athena/athena4.1.tar.gz"

= Trinity shock wave

#task[
  Consider the image sequence in @fig:trinity, showing the blast wave of the first atomic bomb triggered in 1945. We expect the radius $R_s$ of the blast wave (which is an extremely strong shock) to evolve as
  $ R_s prop ((E t^2)/rho)^(1/5) $ <eq:sedov-taylor>
  in three dimensions (according to the so-called Sedov-Taylor solution), with a proportionality coefficient close to unity (and which we assume is exactly one). Here $E$ is the energy released and $rho$ is the background density.
  + Confirm by dimensional analysis that $R_s$ is the only length scale that one can construct from an energy $E$, a density $rho$, and a time $t$.
  + Estimate the released explosion energy $E$ based on the images, and convert to the equivalent in kilotons of TNT ($1 unit("kt") upright("TNT") tilde.eq 5 times 10^12 unit("J")$).
  + Estimate the post-shock temperature at time $t = 1 unit("ms")$.
]

+ $E$, $rho$ and $t$ have dimensions
  $ [E] = upright(J) = (upright("kg") thin upright(m)^2)/upright(s)^2, wide [rho] = upright("kg")/upright(m)^3, wide [t] = upright(s). $
  To determine if there exists a unique combination of these building blocks to construct a length scale, we impose
  $
    upright(m) = [R_s] excl [E]^alpha dot [rho]^beta dot [t]^gamma = ((upright("kg") thin upright(m)^2)/upright(s)^2)^alpha dot (upright("kg")/upright(m)^3)^beta dot upright(s)^gamma = upright("kg")^(alpha + beta) dot upright(m)^(2 alpha - 3 beta) dot upright(s)^(-2 alpha + gamma)
  $
  The above equation is only satisfied if
  $
    cases(reverse: #true, alpha + beta & excl 0, 2 alpha - 3 beta & excl 1, -2 alpha + gamma & excl 0) quad => quad alpha = 1/5, quad beta = -1/5, quad gamma = 2/5.
  $
  #figure(fig("trinity-blast-wave", width: 45%), caption: [Trinity test in New Mexico, 1945]) <fig:trinity>
+ From the last snapshot on the left in @fig:trinity, we can estimate that the explosion had a diameter of roughly $2 R_s approx 70 unit("m")$ after a time $t = 0.94 unit("ms")$. Assuming a background density of Earth's atmosphere at sea level, $rho_upright(E) = 1.225 thin upright("kg")/upright(m)^3$, eq. @eq:sedov-taylor yields an explosion energy of
  $ E = (rho_upright(E) R_s^5)/t^2 approx 7.28 times 10^13 unit("J") approx 17.41 unit("kt") upright("TNT") $
+ To estimate the post-shock temperature, we need the shock's Mach number $cM$ defined i.t.o. the velocity $v$ with which the shock discontinuity propagates and the pre-shock speed of sound $c_s approx 343.2 thin upright(m)/upright(s)$,
  $ cM = v/c_s = 1/c_s (dif R_s)/(dif t) = 2/(5 c_s) (E/(rho t^3))^(1/5) approx 41.8. $
  The post-shock temperature $T'$ can be expressed as (see p. 189, "Theoretical Astrophysics" by M. Bartelmann for a derivation)
  $ T'/T = q/r, $
  where $T$ is the pre-shock temperature, and $q$ and $r$ are the ratio of post- to pre-shock density and pressure, respectively,
  $ r = rho'/rho = (cM^2 (gamma + 1))/(cM^2 (gamma - 1) + 2) approx 5.98, wide q = P'/P = (2 gamma cM^2 - gamma + 1)/(gamma + 1) approx 2040. $ <eq:jump>
  Thus, assuming a pre-shock temperature of $T = 20 thin degree upright(C)$, the post-shock temperature is approximately given by
  $ T' = q/r T approx 10^5 unit("K") $
  #note[Doing a rough energy estimate of the resulting kinetic energy with this temperature (assuming diatomic molecules with a mean molecular mass of $m = 29 unit("u")$, a post-shock density according to the jump condition @eq:jump of $rho' = 5.98 thin rho$ and a spherical volume $V = 4/3 pi R_s^3 (t = 1 unit("ms"))$), we get a total number of particles inside the fireball of
    $ N = (rho' V)/m approx 2.94 times 10^31 $
    and hence a kinetic energy
    $ E_"kin" = 5/2 N k_upright(B) T approx 1.02 times 10^14 unit("J") $
    Since this is larger than the energy released by the explosion, and much larger still than that part of the energy which is actually located inside the post-shock region (most of the energy released is carried outward by the shock-wave after all), the post-shock region where thermodynamics is applicable must be confined to a volume much smaller than $V$ inside the actual blast sphere.]

= Kelvin-Helmholtz instability

#task[
  For definiteness, we consider a two-dimensional domain of extension $[0, L] times [0, L]$ with periodic boundaries on the left and right sides, and reflecting boundaries on the top and bottom. Let the upper half of the box be filled with gas ($gamma = 5\/3$) at density $rho_1 = 1.0$, pressure $P_1 = 1.0$, and velocity $u_1 = 0.3$ in the $x$-direction (i.e. to the right). The lower half has density $rho_2 = 2.0$, the same pressure $P_2 = P_1$, and moves with velocity $u_2 = -0.3$ to the left. In order to avoid a perfectly sharp boundary in the initial conditions between these two phases (which is prone to triggering secondary instabilities at grid corners) we introduce a small transition region that smoothly connects them:
  $ rho(x, y) = rho_1 + (rho_2 - rho_1)/(1 + exp[sigma(y - 1/2)]), $
  and similarly
  $ u(x, y) = u_1 + (u_2 - u_1)/(1 + exp[sigma(y - 1/2)]), $
  with $sigma = 100$. In these unperturbed initial conditions, we now impose a seed perturbation in the velocity in the $y$-direction of the form
  $ v(x, y) = A cos(k x) thin e^(-k|y - 1/2|), $
  with wavenumber $k = 2 (2 pi)/L$ and perturbation amplitude $A = 0.05$. For simplicity, we refrain from imparting a perturbation in $rho$ and $u$ as well that would be consistent with the velocity perturbation in the $y$-direction at the linear theory level, kind of hoping that we get away with this on the grounds that the perturbation should anyway grow (which is expected if the shear flow is indeed unstable against arbitrarily small transverse perturbations).
  + We want to simulate this problem with the Athena mesh code developed by the group of Jim Stone (Princeton University). You can download version 4.1 of this code from #link(athena)[#raw(athena)]. Then, unpack the code with the command: `tar -zxvf athena4.1.tar.gz`.

    We want to run the problem with Athena until time $t = 3.0$ and create an image of the resulting density field at the end. To this end, you need to implement appropriate initial conditions in a problem generator according to the design of this code, and then compile the code appropriately. For the problem generator, you can use the file `kelvin.c` provided on moodle and place it into the subdirectory `src/prob` of Athena. Edit the file to finish off the implementation of the initial conditions (there are primarily three lines to fill out - see the comments in the file). Then configure the code with
    ```sh
    ./configure --with-problem=kelvin --with-gas=hydro --with-eos=adiabatic --with-flux=roe
    ```
    followed by the compilation step with `make all`.

    Next, you also need to setup a parameter file that is passed to Athena at run time. This sets things such as the resolution you want to use, the number and times of outputs you want to have, the desired simulation time span, etc. You can try the parameter file `kelvin.param` supplied on moodle to get started, which you may modify as you see fit (for example to change the resolution or the parameters of the initial conditions generator). Then run the code with
    ```sh
    ./bin/Athena -i <parameterfile>
    ```
    where you replace the name of the parameterfile with your file `kelvin.param`.

    At the final time, you should get a `.ppm` image file displaying a slice of the density field, e.g. `kh.0060.d.ppm`. Load this into an image view program of your choice. Carry out a series of simulations with different resolutions, equal to $64 times 64$, $128 times 128$, and $256 times 256$ mesh cells, and produce images for them at the same nominal pixel resolution, for example $512 times 512$ pixels, by enlarging the images accordingly. Compare them visually and discuss.
  + We now want to check whether we can verify the linear growth rate of the perturbation. As discussed in the lecture, the growth rate of a single mode $k$ is given by $prop e^(omega t)$, with
    $ omega = k |u_1 - u_2| sqrt(rho_1 rho_2)/(rho_1 + rho_2). $ <eq:growth-rate>
    Make a plot of the log of the mean kinetic energy in the $y$-direction as a function of time (you can get this quantity from the history output in `kh.hst`, column 1 has the time, column 9 the kinetic energy in the $y$-direction), and overplot a growth line reflecting the above timescale. Why is the growth initially slower than expected based on eq. @eq:growth-rate? What could be the reason that there is a large slow-down at late times?
  + Now repeat the Kelvin-Helmholtz simulation of part (a) but add a constant velocity of $Delta u = 5.0$ everywhere to the initial conditions. At time $t = 3.0$, would you expect the result to look different than in part (a)? Compare with what you actually obtain when doing this test, and discuss the result.
]

+ The final state at time $t = 3.0$ of our Kelvin-Helmholtz simulations at different resolutions is shown in @fig:kh-resolutions (a) to (d). Higher resolutions produce noticeably sharper density gradients at the interface of both gases. Also, vortices lengthen considerably.
  #figure(
    panels(2, (
      ("kelvin-helmholtz-64.jpg", $64 times 64$),
      ("kelvin-helmholtz-128.jpg", $128 times 128$),
      ("kelvin-helmholtz-256.jpg", $256 times 256$),
      ("kelvin-helmholtz-512.jpg", $512 times 512$),
    )),
    caption: [Images of a Kelvin-Helmholtz instability at different resolutions],
  ) <fig:kh-resolutions>
+ The evolution over time of the mean kinetic energy in $y$-direction is shown and fitted in @fig:kh-energy.
  #figure(fig("kelvin-helmholtz-kinetic-energy", width: 60%), caption: [Time evolution of kinetic energy]) <fig:kh-energy>
  The initial drop-off arises because our seed perturbation, a pure $y$-velocity without the corresponding perturbations in $rho$ and $u$, is not an eigenmode of the linearized problem. Only part of it projects onto the growing mode, while the rest decays (or propagates away as sound waves) during the first time units, after which the growing mode dominates. The fall-off for later times can be attributed to nonlinearity and size effects; after an initial rapid growth phase, the vortices no longer increase in size but start to overlap and flow into each other. This dampens a further increase of motion in the $y$-direction.
+ Repeated Kelvin-Helmholtz simulations with a constant velocity shift of $Delta u = 5.0$ applied to both $u_1$ and $u_2$ at resolutions $128 times 128$ and $512 times 512$ are shown in @fig:kh-shifted (a) and (c), respectively. For comparison, we displayed the previous final state obtained without velocity shift at equal resolution next to either (@fig:kh-shifted (b) and (d)).

  Physically, one might argue that an equal shift applied to the velocities of both gases should not have an effect on the behavior of the system since it seems like we are just performing a change of reference frame. However, our simulations clearly show at both $128 times 128$ and $512 times 512$ that this "change of reference frame" diffuses vortices and decreases their length.

  This is due to our finite grid: Eulerian mesh codes are not Galilean invariant. With $Delta u = 5.0$, the fluid streams across the mesh much faster than before, and the truncation error of each advection step adds numerical diffusion that grows with the velocity relative to the grid. This smears out small-scale structure such as the vortices.
  #figure(
    panels(2, (
      ("kelvin-helmholtz-shifted-128.jpg", [$128 times 128$ with $Delta u = 5$]),
      ("kelvin-helmholtz-128.jpg", [$128 times 128$ no shift]),
      ("kelvin-helmholtz-shifted-512.jpg", [$512 times 512$ with $Delta u = 5$]),
      ("kelvin-helmholtz-512.jpg", [$512 times 512$ no shift]),
    )),
    caption: [Kelvin-Helmholtz instability with equal relative, but increased absolute gas velocities],
  ) <fig:kh-shifted>
