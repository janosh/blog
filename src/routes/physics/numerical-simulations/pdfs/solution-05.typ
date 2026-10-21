#import "/notes.typ": note, task, vb, ev
#import "/numerical-simulations/sheet.typ": fig, panels, sheet

#show: sheet.with(5, [November 27th, 2015], [Multigrid solver for linear systems])

#let (bx, bb, br) = ($vb(x)$, $vb(b)$, $vb(r)$)
#let (bA, bI, bP, bR, bT, bU) = ($upright(bold(A))$, $upright(bold(I))$, $upright(bold(P))$, $upright(bold(R))$, $upright(bold(T))$, $upright(bold(U))$)
#let hateq = $hat(=)$

= Galerkin coarse grid approximation

#task[
  Consider the one-dimensional problem
  $ (partial^2 Phi)/(partial x^2) = 4 pi G rho(x), $
  which we want to solve using a multigrid accelerated iterative method on a grid of size $N = 8$ with spacing $h$. The problem can be rephrased in the form
  $ bA bx = bb, $ <eq:linear>
  where $bx hateq Phi$ and $bb hateq 4 pi G rho h^2$ are vectors of size $N$ and $bA$ is an $N times N$-matrix. Given the operator
  $ bA^((h)) = mat(-2, 1, 0, 0, 0, 0, 0, 1; 1, -2, 1, 0, 0, 0, 0, 0; dots.v, dots.v, dots.v, dots.v, dots.v, dots.v, dots.v, dots.v; 0, 0, 0, 0, 0, 1, -2, 1; 1, 0, 0, 0, 0, 0, 1, -2) $
  on the finest grid level ($N = 8$), find the operator $bA^((2 h))$ on the next coarser grid level ($N = 4$, spacing $2 h$). In order to do so, carry out the following steps:
  + Find the prolongation and restriction operators in matrix form,
    $ bI_((2 h))^((h)) : cases(x_(2 i)^((h)) = x_i^((2 h))\,, x_(2 i + 1)^((h)) = 1/2 (x_i^((2 h)) + x_(i+1)^((2 h)))\,) $ <eq:prolong>
    $ bI_((h))^((2 h)) : x_i^((2 h)) = 1/4 (x_(2 i - 1)^((h)) + 2 x_(2 i)^((h)) + x_(2 i + 1)^((h))), $ <eq:restrict>
    where $0 <= i < N \/ 2$. Hint: $bI_((2 h))^((h)) bx^((2 h)) = bx^((h))$ and vice versa.
  + Now calculate the operator $bA^((2 h))$ on the coarse grid using the Galerkin coarse grid approximation $bA_"Gal"^((2 h)) = bI_((h))^((2 h)) bA^((h)) bI_((2 h))^((h))$.
  + Compare the result to an operator obtained by direct discretization on the coarse grid.
]

+ The notation employed in part (a) is quite confusing. We attempt a more natural way of expressing eqs. @eq:prolong and @eq:restrict by introducing
  $
    bI_((2 h))^((h)) & equiv bP^((2 h -> h)), \
    bI_((h))^((2 h)) & equiv bR^((h -> 2 h)),
  $
  and resorting to the well-known index notation:
  $ x_i^((h)) = sum_(j=1)^N P_(i j)^((2 h -> h)) x_j^((2 h)), $ <eq:p-index>
  $ x_i^((2 h)) = sum_(j=1)^N R_(i j)^((h -> 2 h)) x_j^((h)). $ <eq:r-index>
  Looking at eqs. @eq:p-index and @eq:r-index, it is now clear that $bP^((2 h -> h))$ and $bR^((h -> 2 h))$ are $N times N \/ 2$- and $N \/ 2 times N$-matrices, respectively. \
  To implement eqs. @eq:prolong and @eq:restrict, $bP^((2 h -> h))$ and $bR^((h -> 2 h))$ must take the form
  $
    bP^((2 h -> h)) & = mat(1, 0, 0, 0; 1\/2, 1\/2, 0, 0; 0, 1, 0, 0; 0, 1\/2, 1\/2, 0; 0, 0, 1, 0; 0, 0, 1\/2, 1\/2; 0, 0, 0, 1; 1\/2, 0, 0, 1\/2) \
    bR^((h -> 2 h)) & = mat(1\/2, 1\/4, 0, 0, 0, 0, 0, 1\/4; 0, 1\/4, 1\/2, 1\/4, 0, 0, 0, 0; 0, 0, 0, 1\/4, 1\/2, 1\/4, 0, 0; 0, 0, 0, 0, 0, 1\/4, 1\/2, 1\/4)
  $
+ Multiplying the operator $bA^((h))$ from the left with a restriction and from the right with a prolongation, we find
  $ bA_"Gal"^((2 h)) = bR^((h -> 2 h)) bA^((h)) bP^((2 h -> h)) = mat(-1\/2, 1\/4, 0, 1\/4; 1\/4, -1\/2, 1\/4, 0; 0, 1\/4, -1\/2, 1\/4; 1\/4, 0, 1\/4, -1\/2) = 1/4 mat(-2, 1, 0, 1; 1, -2, 1, 0; 0, 1, -2, 1; 1, 0, 1, -2). $
+ Setting out from the coarse grid instead with only $N \/ 2$ points per dimension spaced $2 h$ apart, the discretized Poisson equation would be given by
  $ (Phi_(i+1) - 2 Phi_i + Phi_(i-1))/(2 h)^2 = 4 pi G rho_i, $
  where the index $i$ now runs from $i in {0, 1, 2, ..., N/2 - 1}$ if $N$ is still taken to be the number of points on the fine grid. If we then write this Poisson equation in the form of eq. @eq:linear, i.e. as a system of linear equations with the components of $bb$ now given by
  $ b_i = 4 pi G (2 h)^2 rho_i, $
  we see that $bA^((2 h))$ has to be
  $ bA^((2 h)) = mat(-2, 1, 0, 1; 1, -2, 1, 0; 0, 1, -2, 1; 1, 0, 1, -2) = 4 bA_"Gal"^((2 h)). $
  This $bA^((2 h))$ is larger by a factor of 4 than the one we found in part (b), as it should be since its corresponding $bb$ is also four times larger.

= Iteratively solving Poisson's equation

#task[
  + Suppose we want to solve for the gravitational potential $Phi$ on a _periodic_ mesh with square-shaped domain $[0, L] times [0, L]$ (with $L = 1$ for definiteness) containing $N times N$ cells and housing the mass density distribution
    $ rho(br) = rho_0 exp(-br^2/(2 eta^2)), $
    where $eta = L/10$ is the spread of the mass spike, and $rho_0 = 10$. Discretization of the Poisson equation gives an iteration rule where the left-hand side gives the updated values in terms of the old values on the right-hand side, in the form
    $ x_(i,j)^((n+1)) = 1/4 (x_(i-1,j)^((n)) + x_(i+1,j)^((n)) + x_(i,j-1)^((n)) + x_(i,j+1)^((n)) - b_(i,j)), $
    where $x_(i,j) = Phi_(i,j)$ and $b_(i,j) = 4 pi G h^2 rho_(i,j) - overline(b)$. This can be readily used for Jacobi or Gauss-Seidel iteration schemes. Write a function `jacobi_step(x[], b[], N)` that replaces the input array `x[]` with a correspondingly updated array after one iteration step.
  + To characterize the current error in the solution, write a function that calculates the residual
    $ r_(i,j) = b_(i,j) - (bA bx)_(i,j). $
    Also, write a function that computes the norm
    $ S = (sum_(i,j) r_(i,j)^2)^(1\/2) $
    of this vector and returns it. We can use $S$ as a simple measure of the overall error.
  + Now specialize to the case of $N = 256$ and write a routine that suitably initializes the density field, with the density peak placed in the center of the box. Set the initial guess for the potential to $bx = vb(0)$. Carefully think about how to initialize the array $bb$ (for a periodic system, eq. @eq:linear is only solvable for $ev(bb) = vb(0)$ because the matrix $bA$ is singular, therefore $overline(b)$ has to be chosen appropriately). Now add a loop that calls the Jacobi iteration $N_"steps" = 2000$ times, and after each step, determines the norm of the residual. You may use the C or Python template on the Moodle site and fill in the missing parts in order to reduce the coding work, or write everything from scratch if you prefer. Make a plot of the decay of the log of this residual as a function of step number. What do you expect to get for $sum_(i,j) Phi_(i,j)$?
  + Now produce a second version of your program in which the Jacobi iteration is replaced by Gauss-Seidel iteration where new values for elements of $bx$ are used as soon as they become available, replacing any old value in the array.
  + Change the Gauss-Seidel scheme to a red-black Gauss-Seidel iteration, i.e. you first update the red cells in a chess-board pattern overlaid over the mesh, then the black cells in a second pass. Produce a common plot of the decay rates of the residual for $N_"steps"$ steps with the three iteration variants considered thus far. Interpret the results. The red-black scheme result will perhaps disappoint you at first -- what's going on?
  + We now solve the problem with multigrid acceleration. First, write a function that carries out a restriction step of a mesh with dimension $N times N$ (where $N$ is a power of 2) onto a coarser mesh with dimension $N \/ 2 times N \/ 2$. Make each point in the coarser mesh a weighted average of neighboring points, according to the stencil
    $ bT = mat(delim: "[", 1\/16, 1\/8, 1\/16; 1\/8, 1\/4, 1\/8; 1\/16, 1\/8, 1\/16). $
    Give this function a calling signature `do_restrict(N, fine[], NN, coarse[])` (only `NN = N/2` is allowed when calling this function).
  + Next, write a function that carries out a prolongation step of a mesh of dimension $N times N$ onto a finer mesh of dimension $2 N times 2 N$. Each point in the coarser mesh is additively injected into the finer mesh with weights
    $ bU = lr(\] mat(delim: #none, 1\/4, 1\/2, 1\/4; 1\/2, 1, 1\/2; 1\/4, 1\/2, 1\/4) \[). $
    Note that points of the fine mesh that see a coarse point with weight $1 \/ 4$ will get contributions from 4 coarse points in total, similarly for the points with weight $1 \/ 2$, while the fine-mesh point with weight 1 simply inherits the value of one of the coarse mesh points. Give this function a calling signature `do_prolong(NN, coarse[], N, fine[])` (again, only `NN = N/2` is allowed when calling this function).
  + Now write a function `do_v_cycle(x[], b[], N)` that carries out a V-cycle multigrid iteration on the current solution vector. The steps of the function should be
    #set enum(numbering: "1.")
    + Do a Gauss-Seidel step.
    + Calculate the residuum.
    + Restrict the residuum to a coarser mesh $N' = N \/ 2$, and scale it by a factor of 4 to effectively take care of the $1 \/ h <- 1 \/ (2 h)$ scaling of the differential operator (whose explicit form we leave invariant, for simplicity).
    + Call `do_v_cycle` recursively for the coarser mesh, with a zero error vector as starting guess for `x`, and the coarsened residual for `b`.
    + Now prolong the returned error vector to the fine mesh $N$.
    + Add this to the current solution vector on the fine mesh.
    + Do another Gauss-Seidel step.

    Steps 2 to 6 are only done provided $N > 4$. To simplify the coding, you may use one of the code templates provided on the Moodle site.
  + Finally, solve the original problem by repeatedly calling your V-cycle iteration. Again, plot the residual as a function of the number of steps taken, and compare with the results obtained earlier for plain Jacobi and Gauss-Seidel iteration.
]

For parts (a) and (b), see `jacobi.c`.
#set enum(start: 3)
+ A half-logarithmic plot of the decay rate of the norm $S$ of the residual is shown in @fig:jacobi.
  #figure(fig("residual-jacobi", width: 55%), caption: [Decay of Jacobi residual norm $S$]) <fig:jacobi>
+ See `gausseidel.c`.
+ @fig:gauss-seidel displays the decay rates of the residual norm as produced by the Jacobi method and the Gauss-Seidel method with and without chessboard scheme.
  #figure(fig("residual-gauss-seidel", width: 55%), caption: [Gauss-Seidel residual decay rates compared to that of the Jacobi method]) <fig:gauss-seidel>
  As expected, we see that Gauss-Seidel's superior utilization of available information leads to the norm of its residual $S_"GS"$ decaying considerably faster than that of Jacobi. The same improvement is not observed by further implementing a chessboard-like update scheme for the potential. The decay rate appears largely unchanged except for a spike during the very first step suggesting an ill-suited initial density distribution for this method.

For parts (f) to (h), see `multigrid.c`.
#set enum(start: 9)
+ @fig:multigrid compares the decay rate produced by the multigrid method to those of the Jacobi and Gauss-Seidel methods. We indeed find a dramatic increase in the convergence rate.
  #figure(fig("residual-multigrid.png", width: 55%), caption: [Residual decay of the multigrid method compared to Jacobi and Gauss-Seidel]) <fig:multigrid>

#note[A surface plot of the initial density distribution $rho_upright(i) (br)$ over the entire simulation domain is shown in @fig:surfaces (a). @fig:surfaces (b) to (d) display the noticeably differing corresponding potentials according to the Jacobi, Gauss-Seidel and multigrid methods, respectively. Since each method converges at a different rate, plotting the potential after a constant number of 2000 sweeps is akin to plotting it at different times.]

#figure(
  panels(4, (
    ("density-initial.png", [Initial density]),
    ("potential-jacobi.png", [Jacobi potential]),
    ("potential-gauss-seidel.png", [Gauss-Seidel potential]),
    ("potential-multigrid.png", [Multigrid potential]),
  )),
  caption: [Surface plots of the initial density and calculated potentials],
) <fig:surfaces>
