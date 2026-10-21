#import "/notes.typ": dd, notes, vb, bra, ket, braket
#import "@preview/cetz:0.5.2": canvas, decorations, draw

#show: notes.with(
  title: [Oral Exam Transcript],
  subtitle: [Advanced Quantum Field Theory and String Theory with Prof. Timo Weigand],
  date: [Janosh Riebesell, May 2016],
)
#set heading(numbering: "1")
#set math.equation(numbering: "(1)")

// examiner's questions in blue, my answers below them
#let q(body) = text(fill: rgb("#1a1aa6"), body)

// tree-level fermion scattering via a massive boson and its four-fermion contact limit
#let arrow-mark = (end: "stealth", fill: black, scale: 1.1)
#let fermion(a, b, at: 0.6) = {
  let mid = (a.at(0) + at * (b.at(0) - a.at(0)), a.at(1) + at * (b.at(1) - a.at(1)))
  draw.line(a, mid, mark: arrow-mark)
  draw.line(mid, b)
}
#let legs(v, d: 0.8) = {
  fermion((v.at(0) - d, v.at(1) - d), v)
  fermion(v, (v.at(0) - d, v.at(1) + d))
  fermion((v.at(0) + d, v.at(1) - d), v)
  fermion(v, (v.at(0) + d, v.at(1) + d))
}
#let boson-exchange = canvas(length: 0.75cm, {
  import draw: *
  set-style(stroke: 0.8pt)
  fermion((-0.8, -0.8), (0, 0))
  fermion((0, 0), (-0.8, 0.8))
  fermion((2.8, -0.8), (2, 0))
  fermion((2, 0), (2.8, 0.8))
  decorations.wave(line((0, 0), (2, 0)), amplitude: 0.1, segment-length: 0.25)
  content((0, 0), $-i e$, anchor: "east", padding: 9pt)
  content((2, 0), $-i e$, anchor: "west", padding: 9pt)
  content((1, -0.2), text(size: 7pt, $i/(p^2 - m^2)$), anchor: "north")
  line((3.7, 0), (5.2, 0), mark: arrow-mark, stroke: 0.5pt)
  content((4.45, 0.1), text(size: 7pt, $p^2 << m^2$), anchor: "south")
  legs((6.6, 0))
  content((6.6, 0), $-i g$, anchor: "west", padding: 8pt)
})

This is a write-up of my May 2016 oral exam with Prof. Timo Weigand. He graded me with 1,3.

= Topics

- Advanced quantum field theory (I visited the lecture by Prof. Jürgen Berges), and
- String theory (which I learned from Timo himself).

= How I studied

Both lectures closely followed Timo's notes. In my eyes, they are nothing short of great. That may have been the reason why I felt comfortable studying almost exclusively with them. In any case, the advanced QFT and string theory notes together stack up to almost 300 pages, so I'm not sure anyone would want to read and try to memorize much more. I did borrow 'An Introduction To Quantum Field Theory' by Peskin and Schroeder as well as 'Basic Concepts of String Theory' by Blumenhagen, Lüst, and Theisen from the library but only occasionally read individual sections in the former to get a different or more detailed view. I seldom felt I needed that when reading Timo's string theory notes which is why I barely touched the latter.

Looking back on the exam, there are two reasons why I don't think I benefited much at all from reading beyond Timo's notes.
+ Books are often so full of details or even entire calculations (especially Peskin and Schroeder) that it becomes hard to keep a bird's eye view and get the broader picture while reading them. That doesn't matter when for example referring to them for help with an exercise sheet where you zoom in on one single problem and really bury yourself in its intricacies. But it's of little help in an oral exam, where you quickly skip from one topic to the next in mere minutes and only stop to discuss the major points.
+ Timo is really good at asking pointed questions that can be answered exclusively with knowledge found in his notes. So if you go into one of his exams, that's what you want to be well versed in. He does ask in a way that requires you to think for yourself and develop your understanding beyond what was actually written, but again, I think his notes provide the best basis to do so.

I can also confidently say there is absolutely no point in going through the exercise sheets again. In your oral exam, you will be faced with totally different types of questions that have nothing to do with calculations.

I didn't do a mock exam although that's probably a good idea if you get the chance. Towards the end of my preparations, I did spend a few hours talking about possible exam topics with my friends, and tried to use that time to explain matters to them in my own words. I feel like that helped a lot. Since you'll be expected to do tons of explaining during your exam, any time you spend getting used to talking about physics aloud and as fluently as possible will likely be good practice.

As for time allocation, I wrote Timo an email asking for an appointment to do my exam on the 21st of April. He wrote back the same day and suggested a few dates. I chose the 11th of May which gave me just short of three weeks for hardcore studying. I had written the string theory exam just a few weeks prior so I still had a good grasp of the subject. I wonder if a little more time might have resulted in a better grade. But then I was never one to enjoy spending weeks studying many hours a day. And indeed, I had gotten quite sick of sitting and reading towards the end.

If you're trying to gauge how much time you should allow for your own preparations I'd recommend considering what kind of person you are. If you got the stamina to study for longer, then go for it. It usually pays off. If you already see yourself either not doing much in the beginning or losing motivation towards the end, then there is no point in dragging it out. Choose an amount of time you know you can be productive and work through it!

= Transcript

*Advice* #h(0.5em) Read this section once or twice when beginning your preparations to get a feel for the topics and kinds of questions you'll be expected to answer. This should allow you to better target relevant subjects during your studying. Then do not revisit this part until shortly before the exam. That way you will likely have forgotten most of these questions, which will allow you to use them for an authentic mock exam.

#set enum(spacing: 1.4em)

+ #q[Write down the Polyakov action of the bosonic string.]
  $ S_"P" [X, h] = -T/2 integral_Sigma dd(2, xi) sqrt(-h) h^(a b) partial_a X^mu partial_b X^nu eta_(mu nu). $

+ #q[What are each of the objects you just wrote down?]

  $X^mu (tau, sigma)$ is the bosonic string field. As indicated by its indices, it is a spacetime vector but a scalar on the worldsheet $Sigma$. $h^(a b)$ is the (inverse) worldsheet metric with $h = det(vb(h))$ its determinant. It is introduced into the string action as an auxiliary field to get rid of the cumbersome square root in the Nambu-Goto action. Finally, $eta_(mu nu)$ is the (flat) target space metric -- a priori unrelated to the metric on the worldsheet -- and $T$ is the string tension.

  Importantly, there is no mass term, which makes this action conformally invariant.

+ #q[What is the dimension of the string tension? Can it be expressed in terms of other quantities?]

  In terms of the Regge slope, the string tension is given by $T = 1/(2 pi alpha')$. The Regge slope has units of length squared which gives the string tension mass dimension $[T] = 2$.

+ #q[What about the string length? Where does it come in?]

  The string length is the square root of the Regge slope, $ell_s = 2 pi sqrt(alpha')$.

+ #q[You just mentioned that $S_"P"$ has conformal symmetry. What does that mean?]

  Conformal symmetry refers to invariance under rescalings, more precisely Weyl rescalings when applied solely to the metric. Locally, this can be written as $h_(a b) -> Lambda(tau, sigma) h_(a b)$, where the scale factor $Lambda$ depends on the position on the worldsheet parametrized by $tau$ and $sigma$.

  This property is crucial to a consistent quantization of the CFT on the worldsheet.

+ #q[Can you demonstrate that $S_"P"$ is really invariant under Weyl rescalings?]

  Yes, at least for the case $d = 2$. Since $h_(a b) -> Lambda h_(a b)$, the inverse metric transforms as $h^(a b) -> Lambda^(-1) h^(a b)$. The only other object appearing in $S_"P"$ that participates in the transformations is $sqrt(-h)$, which is mapped to $sqrt(-h) -> sqrt(-h') = sqrt(-det(Lambda vb(h))) = sqrt(-Lambda^d det(vb(h))) = Lambda^(d/2) sqrt(-h)$. So precisely if $d = 2$ do the $Lambda^(-1)$ and the $Lambda^(d/2)$ cancel and the action as a whole remains invariant.

+ #q[You mentioned that conformal symmetry is important for quantization. In what sense?]

  Under infinitesimal Weyl rescalings in two dimensions, the Ricci scalar $cal(R)$ becomes $cal(R) -> cal(R) - nabla^2 omega(tau, sigma)$, where we parametrized $Lambda = e^omega$ and expanded $e^omega = 1 + omega + cal(O)(omega^2)$. That means, we can always -- at least locally -- find an infinitesimal transformation $omega$ such that $cal(R) = nabla^2 omega(tau, sigma)$ upon which the new Ricci scalar $cal(R)' = 0$ vanishes. Since the Riemann tensor $R_(a b c d)$ in two dimensions has just one degree of freedom given by the Ricci scalar itself, this means we can always stretch the worldsheet so as to make it locally flat. It is then a simple matter to find a suitable diffeomorphism that maps the system to a set of coordinates in which the metric is diagonal and even Minkowskian. This process (partially) fixes the gauge invariance of the bosonic string and leaves us with a Polyakov action that simply describes $d$ free scalar fields,
  $ S_"P" [X] = T/2 integral_Sigma dd(2, xi) [(partial_tau vb(X))^2 - (partial_sigma vb(X))^2]. $

+ #q[Why is this important?]

  Do you mean why is it important that the components of the bosonic string decouple?

+ #q[Yes, exactly.]

  Because it drastically simplifies calculations. In particular, we can now easily vary the action to find the bosonic string equation of motion,
  $ (partial_tau^2 - partial_sigma^2) X^mu = 0, $
  or $partial_+ partial_- X^mu = 0$ in lightcone coordinates. Either way, this is just the free wave equation whose most general solution is given by a sum of a left- and a right-moving wave along the string, i.e. $X^mu (xi^+, xi^-) = X_L^mu (xi^+) + X_R^mu (xi^-)$. If the field components didn't decouple, this would have been much more difficult.

  Incidentally, as I just mentioned the gauge is only partially fixed, and that is because there is still an infinite number of diffeomorphisms, the so-called conformal Killing vectors, that change the metric only up to an overall prefactor, which can be undone by a suitable Weyl rescaling. Combined, such transformations still constitute a symmetry of our theory even when the metric is already fixed. In lightcone quantization, where we introduce lightcone coordinates not only on the worldsheet but also as $X^plus.minus = 1/sqrt(2) (X^0 plus.minus X^(d-1))$ for the embedding of the string into spacetime, these degrees of freedom in our description are used to gauge away an infinite number of modes in the expansion of $X^+$, namely all except $alpha_0^+ = sqrt(2 alpha') p^+$, so that $X^+$ is given simply by
  $ X^+ = p^+/(T l) tau + x^+. $
  Together with the Virasoro constraints, this expression can be used to derive an interdependence of modes of the form $alpha_m^- prop sum_(i=1)^(d-2) sum_(n=-infinity)^infinity alpha_(m-n)^i alpha_n^i$ that expresses the remaining lightcone modes $alpha_m^-$ in terms of the transverse modes $alpha_m^i$. This establishes that the lightcone dimensions $X^plus.minus$ aren't actually degrees of freedom.

+ #q[Moving on to BRST quantization, what are the physical and unphysical degrees of freedom there?]

  In BRST quantization, the degrees of freedom of the bosonic string are not infringed. Instead we introduce unphysical 'negative' degrees of freedom, the so-called Faddeev-Popov ghosts $c_a (tau, sigma)$ and antighosts $b_(a b) (tau, sigma)$ that effectively cancel the longitudinal string excitations.

  That is not the whole story, though. To arrive at a consistent quantum theory, we also need to find the Hilbert space of physical states $cal(H)_"phys"$. To that end, we can use that any vector space $H$ with a nilpotent Hermitian operator $Q : H -> H$ acting on it contains two subspaces, namely the kernel $ker(Q)$ and the image $"Im"(Q)$ of $Q$.

  Since for $ket(psi) = Q ket(xi) in "Im"(Q)$ and $ket(chi) in ker(Q)$, we have
  $ braket(psi, psi) = bra(xi) underbrace(Q^2, 0) ket(xi) = 0, #h(5em) braket(psi, chi) = bra(xi) underbrace(Q ket(chi), 0) = 0, $
  vectors in the image of $Q$ are null, i.e. orthogonal to all vectors including themselves. This motivates defining the space of physical states with positive norm as the cohomology of $Q$,
  $ cal(H)_"phys" equiv cal(C)(Q) = ker(Q)/"Im"(Q). $

+ #q[Why can we be sure that this is well-defined?]

  Because $"Im"(Q)$ is strictly a subspace of $ker(Q)$. Every state $ket(psi) = Q ket(xi)$ in the image of $Q$ fulfills $Q ket(psi) = Q^2 ket(xi) = 0$, i.e. is also in $ker(Q)$. Therefore the quotient space $ker(Q) / "Im"(Q)$ really exists.

+ #q[Where does $Q$ come from? Why are we even considering it?]

  This can only be understood after introducing the Faddeev-Popov ghost $c_a$ and antighost $b_(a b)$. With them in place, one finds that even after gauge fixing, the combined ghost plus string action still exhibits a fermionic, residual symmetry called the BRST symmetry. The conserved, nilpotent, Hermitian charge operator $Q$ generates that symmetry via the (anti-)commutator,
  $ epsilon [Q, X^mu] = delta_epsilon X^mu, #h(4em) epsilon {Q, c_a} = delta_epsilon c_a, #h(4em) epsilon {Q, b_(a b)} = delta_epsilon b_(a b). $
  $epsilon$ is just a global Grassmann-valued parameter that makes the transformation fermionic.

  Should I write down the actual transformations?

+ #q[Yes.]

  $Q$ acts on both the bosonic string and the ghost like a conformal Killing vector $vb(epsilon.alt) = (epsilon.alt^+, epsilon.alt^-)$:
  $ delta_epsilon X^mu = epsilon (epsilon.alt^+ partial_+ + epsilon.alt^- partial_-) X^mu, #h(6em) delta_epsilon c^plus.minus = epsilon (epsilon.alt^+ partial_+ + epsilon.alt^- partial_-) c^plus.minus. $

+ #q[How are the ghost fields related to the conformal Killing vectors?]

  Varying the ghost action with respect to $c^plus.minus$ yields $partial_+ c^- = 0 = partial_- c^+$ as ghost equations of motion. This is precisely the conformal Killing equation in lightcone gauge, meaning the ghosts are in one-to-one correspondence with the conformal Killing vectors.

+ #q[Right. So how could we rewrite the transformations you just wrote down?]

  We could replace the $epsilon.alt^plus.minus$ by $c^plus.minus$, i.e.
  $ delta_epsilon X^mu = epsilon (c^+ partial_+ + c^- partial_-) X^mu, #h(6em) delta_epsilon c^plus.minus = epsilon (c^+ partial_+ + c^- partial_-) c^plus.minus. $

+ #q[Exactly, so these are the gauge transformations with the gauge parameter replaced by the Grassmann field which makes sense precisely for the reason you mentioned. But why does it also make sense to restrict our Hilbert space in such a way and why is it consistent with interactions?]

  [Silence]#footnote[I didn't know what to say here. Timo had to rephrase his question before I realized what he was getting at.]

+ #q[Let's say we have a set of incoming states and a theory with interactions. Then we use an operator to define a physical state condition satisfied by these incoming states. Under which condition may we assume that also all the outgoing states of that theory satisfy the physical state condition?]

  A necessary condition for closed time-evolution, i.e. for initial states out of the physical Hilbert space to evolve into final states that lie in the same space is unitarity of the S-matrix $S$. The S-matrix respects all symmetries of a theory. So if we were somehow able to couple unitarity of the S-matrix to a symmetry of the theory, then this condition would be automatically satisfied. That's why we use the symmetry generator $Q$ to define the space of physical states.

+ #q[Very good! You said the S-matrix respects all symmetries of a given theory. Does this automatically also apply to the quantum theory?]

  No, a symmetry may be anomalous. In that case it does not carry over to the quantum theory even though it was present at the classical level. In the path integral formalism, a symmetry is identified as anomalous if its associated transformation does not leave the path integral measure invariant.

+ #q[That's true but let's stay with canonical quantization for the moment. What conditions follow from requiring that the BRST symmetry is nonanomalous?]

  So you're asking what conditions would have to be fulfilled for $Q$ to generate a symmetry transformation also in the quantum theory?#footnote[Just a lame question to buy some time to think and maybe draw some more tips from Timo.]

+ #q[Exactly, with all its classical properties intact, in particular it should remain nilpotent.]

  The fact that the BRST transformation is nilpotent means that $delta_epsilon delta_(epsilon') X^mu = delta_epsilon delta_(epsilon') c_a = delta_epsilon delta_(epsilon') b_(a b) limits(=)^! 0$. For this property to hold also in the quantum theory we need $Q^2 limits(=)^! 0$, i.e. nilpotency must carry over to the BRST generator. Using the anticommutator, $Q^2 = 1/2 {Q, Q}$ can be calculated explicitly. This yields an expression proportional to the combined string plus ghost Virasoro algebra's central extension,
  $ Q^2 = 1/2 {Q, Q} prop [L_m^"tot", L_n^"tot"] - (m - n) L_(m+n)^"tot". $
  The central extension vanishes only if $c^"tot" = c^X + c^g limits(=)^! 0$ and $a^"tot" = a^X + a^g limits(=)^! 1$, where
  $ c^X = eta^mu zws_mu = d, #h(4em) c^g = -26, #h(4em) a^X = d/24, #h(4em) a^g = -2/24. $
  Thus the BRST generator $Q$ is nilpotent and the BRST symmetry non-anomalous only if $d = 26$.#footnote[Arriving at this answer actually took a little back and forth with Timo which I didn't include here for brevity.]

+ #q[Very good. In addition to the bosons, the RNS formalism also contains a fermionic sector. How do we have to modify $c^X$?]

  $c^"RNS" = c^X + c^psi = d + d/2 = 3/2 d$.

+ #q[Correct. Let's talk about conformal field theories. Is QCD a conformal field theory?]

  No, the QCD Lagrangian contains dimensionful couplings, in particular the fermion mass $m_psi$. This introduces a scale into the theory that makes it non-conformal.

+ #q[What if we set the mass of the fermions to zero. Would QCD be conformal then?]

  No. Massless QCD does have an extra symmetry, namely chiral symmetry but the coupling of the gauge potential to the fermions still needs to be renormalized, i.e. is scale-dependent.

+ #q[Could you write down the QCD coupling term? Or better still the whole QCD Lagrangian but neglecting the mass terms.]

  The Lagrangian of massless QCD contains two kinetic terms -- one for the fermions and one for the gauge bosons -- plus an interaction term. Using roman color indices and greek spacetime indices,
  $ cal(L)_"QCD" = macron(psi)^a i gamma_(a b)^mu D_mu psi^b - 1/4 F_(mu nu)^a F_a^(mu nu), $
  where the covariant derivative is $D_mu = partial_mu - i g A_mu$. So the fermion-gauge field interaction term is given by $g macron(psi) gamma^mu A_mu psi$ where the coupling $g$ has mass dimension zero in four-dimensional space.

+ #q[How do we see that?]

  In natural units, the action $S = integral dd(4, x) cal(L)_"QCD"$ is dimensionless. Thus the Lagrangian needs to have mass dimension $[cal(L)_"QCD"] = 4$. Since fermions have mass dimension $[psi] = 3/2$ and gauge bosons contribute $[A] = 1$ to the interaction term, $2[psi] + [A]$ already equals four, so $g$ must have $[g] = 0$.

+ #q[What else must $g$ fulfill for QCD to be a conformal field theory.]

  It would have to have a vanishing $beta$-function.

+ #q[Aha. And is the $beta$-function zero?]

  No, QCD has a negative $beta$-function.

+ #q[What is the $beta$-function?]

  The QCD $beta$-function at one-loop is $beta(g) = -(11 - 2/3 n_f) g^3/(16 pi^2)$, where $n_f = 6$ is the number of quark flavors.

+ #q[Ah, yes indeed, very good. But I was actually only asking for the general definition of the beta function.]

  I see. $beta(g) = (partial g)/(partial ln(mu)) = mu (partial g)/(partial mu)$, where $mu$ is the renormalization scale, so for example the momentum exchange that occurs in an experiment to test the theory.

+ #q[Correct. That means if you were to investigate the conformal symmetry of the classical Lagrangian with regard to anomalies, at what conclusion would you arrive?]

  I would conclude that even though classical chromodynamics is conformally invariant, the non-vanishing $beta$-function in the quantum theory means that the color coupling needs to be renormalized and so the theory suffers from a conformal anomaly.

+ #q[Exactly. If we go back to the gauge-fixed action of the Polyakov string and now add interactions, what can we say about the $beta$-function? And what kind of interactions would those be?]

  Are you referring to the closed string non-linear $sigma$-model?

+ #q[Precisely!]

  In that case, a multitude of interactions are possible. The $sigma$-model couples the string field to all of its own massless excitations which, decomposed into irreducible representations of the stabilizer $S O(24)$, are the graviton $g_(mu nu)$, the Kalb-Ramond gauge field $B_(mu nu)$ and the scalar dilaton $phi$. The corresponding action is of the form#footnote[I did not include all indices nor the prefactors during the exam but only gave the general form to make clear what couples with what.]
  $ S_sigma [X, g, B, phi] = T/2 integral_Sigma dd(2, xi) [partial_a X^mu partial_b X^nu (eta^(a b) g_(mu nu) (X) + i epsilon.alt^(a b) B_(mu nu) (X)) + alpha' cal(R) phi(X)], $
  where $eta^(a b)$ is the gauge-fixed worldsheet metric, the prefactor of the antisymmetric Kalb-Ramond field $epsilon.alt^(a b)$ is an equally antisymmetrized worldsheet tensor, and $cal(R)$ is the Ricci scalar.

  This action describes the propagation of strings in a curved _target_ space. In particular, this model admits one very interesting discovery concerning the dilaton ...

+ #q[A quick question: Is $cal(R)$ the target space Ricci scalar or does it describe the worldsheet?]

  $cal(R)$ denotes the worldsheet Ricci scalar.

+ #q[Correct. Carry on.]

  The $sigma$-model reveals that the dilaton is in fact the coupling of the string $g_s = e^(phi(X))$ which governs the opening and closing of strings. Importantly, this makes the string coupling dynamical and calculable by the theory itself! This is completely different from the situation in point-particle QFT where couplings are arbitrary parameters that have to be taken from experiment.

  Coming back to the issue of conformal invariance: Comparing the $sigma$-model action with the Polyakov action, the conformal symmetry of the latter is only retained if all $X$-dependent quantities have vanishing $beta$-function. In particular, to first order in $sqrt(alpha')/R$, where $R$ denotes the typical radius of the target space curvature, and with all other fields set to zero, a vanishing graviton $beta$-function $beta_(mu nu) (g) limits(=)^! 0$ requires $R_(mu nu) limits(=)^! 0$ with $R_(mu nu)$ the target space Ricci tensor. Thus the $sigma$-model recovers the Einstein equations (for the vacuum because we set all other fields to zero)! What's more, we can use the $sigma$-model to successively compute higher-curvature stringy corrections to Einstein gravity.

+ #q[Alright, let's move on.]

  Before we do, may I ask a quick question on that topic?#footnote[I wanted to ask whether we shouldn't consider this a concrete prediction of string theory that could be used to test the theory by looking into space and searching for systems such as revolving heavy stars or black holes, where such higher curvature corrections might be observable. But apparently, Timo was anxious to jam as many questions as possible into the one hour he was given. Incidentally, I did get to ask him later that day after the string theory II lecture, where he said that, yes, this is indeed a testable prediction from string theory but that he didn't think it very likely one would find a system that exhibited such high curvatures close enough for us to observe them.]

+ #q[Nope. Let's consider a fermionic theory in four dimensions with quartic interaction? What would such an interaction look like?]

  To obtain a covariant action requires combining Dirac spinors in such a way as to produce terms with well-defined behavior under Lorentz transformations. The only way to produce a four-fermion interaction that transforms like a Lorentz scalar is to combine two spinors $psi$ with two conjugate spinors $macron(psi)$ which leads to $cal(L)_"int" = g macron(psi) macron(psi) psi psi$.

+ #q[Is a Lagrangian with such an interaction term renormalizable?]

  No, due to the kinetic term being $macron(psi) gamma^mu partial_mu psi$, spinors in $d = 4$ have mass dimension $[psi] = 3/2$. The four-fermion interaction hence has $[macron(psi) macron(psi) psi psi] = 6$. To compensate and arrive at $[cal(L)_"int"] = 4$, the coupling needs to have mass dimension $[g] = -2$.

  But the number of vertices $V$ of a diagram appears with the mass dimension $-[g]$ of the vertex's coupling as prefactor in the superficial degree of divergence $D$. Therefore, a theory with couplings of negative mass dimension is not renormalizable.

+ #q[Correct. Assuming we had nevertheless measured such an interaction term, how would you argue its appearance from the effective field theory perspective? Would you say any theory containing such an interaction is not well-defined due to being non-renormalizable?]

  Not at all. The renormalizability of a theory is in no way connected to its well-definedness. If a theory turns out to be non-renormalizable, it simply means we have once again reached a point where the tools of conventional perturbative QFT break down. But this is entirely a problem on our part, not of the theory.

  So you're asking what we would conclude if we were to measure such an interaction even though it is not renormalizable?

+ #q[Yes. How would you explain such a measurement?]

  Via an effective field theory. One could imagine that a four-fermion interaction isn't actually what is going on at the microscopic level where all kinds of particles could be exchanged on very short distances. Short distances are only resolved at high energies, meaning all we would be able to see in our crude low-energy experiments are the results of an effective field theory with $macron(psi) macron(psi) psi psi$ interaction.

+ #q[Very good! What kind of interaction could resemble a four-fermion vertex at low-enough energies?]

  We could have a cubic interaction $e phi macron(psi) psi$ between two fermions and a gauge boson. The boson could be either a scalar resulting in Yukawa theory or a vector as in QED and Yang-Mills theory. In any case, we would get a tree-level diagram that looks like:
  #math.equation(block: true, boson-exchange)
  At energy scales $p^2 << m^2$, higher loop orders would be suppressed by powers of $i/(p^2 - m^2)$ and the tree-level process would look just like a four fermion interaction.

+ #q[Exactly. Could you express the effective coupling $g$ solely in terms of quantities from the underlying fundamental theory?]

  In the regime where the effective theory provides a good approximation, we have $i/(p^2 - m^2) approx (-i)/m^2$. Therefore, $-i g approx (-i e)^2 (-i)/m^2 = i e^2/m^2$.

+ #q[Very nice. Let's change from four- into two-dimensional space. How does that affect the renormalizability of a theory containing a four-fermion interaction?]

  In $d = 2$, the Lagrangian has dimension $[cal(L)] = 2$, but the kinetic term does not change. A fermion must hence be of dimension $[psi] = 1/2$. Then $[macron(psi) macron(psi) psi psi] = 2$, meaning the coupling $g$ is now dimensionless. Such a theory contains only a finite number of divergent amplitudes, making it renormalizable.#footnote[I messed up here at first, assuming that the fermions still had mass dimension $[psi] = 3/2$. Luckily, once I realized that Timo had stopped nodding approvingly, I was able to quickly find and correct my mistake.]

+ #q[Correct. If we now compare this fermionic theory in two dimensions to the same theory in higher dimensions, would you expect divergences in the former to be more, equally, or less severe than those in the latter?]

  Renormalizable theories are symptomatic for logarithmic divergences whereas non-renormalizable theories usually exhibit more violent power-law divergences. I would therefore expect the behavior of the theory in two dimensions to be less precarious than in four.

+ #q[Good. New topic: There is a saying that claims it is difficult to realize light scalars in QFT, or in other words, scalars in QFT are usually heavy. What could this statement refer to?]

  [Stammering]#footnote[Once again, I had no idea what to say.]

+ #q[Put differently, why are we so aghast that the Higgs is relatively light?]

  I didn't know we were.

+ #q[Oh we are, utterly! For a start, write down the Lagrangian of a massive scalar field with quartic interactions.]

  $cal(L)_phi = 1/2 partial_mu phi partial^mu phi - 1/2 m^2 phi^2 - lambda/4! phi^4$.

+ #q[What is the mass that we can actually measure?]

  The physical mass $m$ is given by $m^2 = m_0^2 - delta_(m^2)$, i.e. the difference between bare mass and counterterm. Ah, so the question is why the two cancel almost exactly, even though both diverge?

+ #q[Exactly! Why would we expect the measured mass to be larger than it turned out to be for the Higgs?]

  This goes by the name of fine tuning. Of course, we specifically construct the counter term so as to absorb the divergence of the bare mass. But what could be considered surprising is that the finite part of the bare mass, i.e. what is left as the physical mass after renormalization, is so small.#footnote[This argument can be made more precise with the renormalization group flow of the mass in four-dimensional $phi^4$-theory discussed at the end of chapter 8 of Timo's QFT II lecture notes.]

+ #q[Yes. Can you quantify this? What kind of divergences do we have to deal with in $phi^4$-theory?]

  Mass renormalization in QFT proceeds via the two-point function, a.k.a. the propagator. In $d = 4$, $phi^4$-theory has a superficial degree of divergence of $D = 4 - E$, where $E$ denotes the number of external lines in a diagram. Therefore, if we introduce a momentum cutoff $Lambda$ and take the limit $Lambda -> infinity$, the propagator with two external lines scales as $G_2 prop Lambda^D = Lambda^2$.

+ #q[Correct, which means we need to cancel quadratically divergent quantities. So without fine tuning, the rule of thumb would be that the scalar masses grow quadratically with the cutoff. What exceptions to this rule do you know of, specifically for scalars? How do we still obtain light or massless scalars in the full quantum theory?]

  Through spontaneous symmetry breaking. The potential of scalar $phi^4$-theory is given by $V(phi) = lambda (phi^dagger phi - v)^2$, where $phi$ can be any $N$ component vector containing only scalar fields. The minimum of this potential, i.e. the vacuum, lies not at the origin but rather degenerates to lie anywhere on the sphere $S^(N-1)$ defined by $phi^dagger phi limits(=)^! v$. Even if a universe described by such a theory would start at $phi = 0$, quantum fluctuations would quickly destabilize it, leading the whole universe to decay into one of its true vacuum configurations on $S^(N-1)$. In that configuration, there would now be one direction in field configuration space, namely the one orthogonal to the sphere, in which the potential $V(phi)$ has non-zero curvature giving rise to a massive scalar. The Higgs field is an example of this. In all other $N - 1$ dimensions, the potential is constant, yielding $N - 1$ massless Goldstone bosons.

  These Goldstone bosons are massless scalars in the full quantum theory and therefore pose an exception to the above rule that scalars should be heavy.

+ #q[Exactly, this is one way how a theory still produces massless scalars. But now the question arises why there are no massless scalars in the standard model? Or in other words, is this an answer to the question why the Higgs is so light.]

  We don't encounter any massless scalars in the standard model because the massless scalar degrees of freedom are absorbed as longitudinal excitations into the originally massless vector bosons which thereby become massive. What remains for us to observe is only the massive Higgs.

+ #q[Correct, and are massive scalars protected by Goldstone's theorem?]

  What do you mean 'protected'?

+ #q[Protected from quantum fluctuations. Let's say we didn't have gauge fields that could absorb the Goldstone bosons. Then Goldstone's theorem protects the masses of its bosons by stating that they are massless not only as classical fields but remain massless even in the full quantum theory. In particular, they are not subject to fluctuations. Does this also apply to the Higgs boson that we can observe.]

  No, the Higgs is not a Goldstone boson. Instead it is a regular field in the quantum theory subject to all quantum effects.

+ #q[No indeed. So we still haven't found a solution to the fine tuning problem. What other fields of non-zero spin can appear in a theory without gravity?]

  There are the spin 1 gauge bosons, in particular the photon of electromagnetism, the gluons conveying the strong force, and the $W^plus.minus$ and $Z$ bosons which account for the weak force.

+ #q[Correct. Are they massive, are their masses protected and if so by what?]

  The photon and gluons are massless. The $W^plus.minus$ and $Z$ are massive due to the symmetry breaking mechanisms we just discussed. In the standard model, the gauge group of the weak force and hypercharge spontaneously breaks to $S U(2) times U(1)_Y -> U(1)_"em"$. $U(1)_"em"$ is the gauge group of the photon which therefore remains massless. The three Goldstone bosons resulting from the disappearance of $S U(2)$ lend mass to $W^plus.minus$ and $Z$.

+ #q[So the photon and the gluons remain massless, at least at tree-level. Why don't we get quantum corrections from higher-loop interactions?]

  Because of gauge invariance.#footnote[This statement was a borderline guess. I just figured gauge invariance was the main difference between the photon and gluons on the one hand and $W^plus.minus$ and $Z$ on the other after spontaneously breaking $S U(2)$.]

+ #q[Correct, so there is another process at work here that protects the masses of the photon and gluons that does not apply to the bosons conveying the weak force. Via symmetry breaking, $W^plus.minus$ and $Z$ attain masses on the order of 100 GeV, similar to the Higgs. Does that mean there exists an analogous fine tuning problem in the case of the $W^plus.minus$ and $Z$ bosons?]

  I don't know.

+ #q[Try drawing an energy axis and indicate the effective symmetry depending on the energy.]

  We are essentially facing a situation similar to the one discussed in the context of the effective field theory with four-fermion interaction. For energies much smaller than the masses of the gauge bosons, their exchange as force-mediating particles occurs on such small length scales that we cannot resolve them in experiments. If we don't see the gauge bosons, there is also no corresponding gauge symmetry. So the low-energy limit is effectively gauge-symmetry free.

+ #q[And what about energies much higher than the gauge boson masses?]

  At high energies, we would be able to detect their existence. So at high energies, the theory exhibits the full gauge symmetry which can now serve the same purpose of protecting the masses from quantum fluctuations as for the photon and gluons. That must be the reason why we don't speak of a fine tuning problem for the $W^plus.minus$ and $Z$ bosons.

+ #q[Exactly. Very good. Alright, that's it. Would you please step outside for a minute?]

  Sure.

= About Timo

Timo was able to create a relaxed and informal atmosphere right from the start. We had to wait a few minutes for the transcript writer to arrive. We spent the time talking about trivial things like the weather and what he does over the weekend. For some reason I felt more curious than nervous on the morning of the exam, but even if I had been panicking, I'm sure I would have calmed down right then and there.

As mentioned in the beginning, Timo really sticks to the stuff he covers in his lecture notes. Of course, that's quite a lot but I felt like knowing for sure what to learn really helped me during the long and painful hours of preparation. Imagine yourself constantly doubting whether or not what you are learning is actually relevant for the exam. I think that would have really hindered my progress.

Sometimes his questions did lead beyond his notes, but in every case starting from something he did cover in his lecture and then thinking for yourself from there was the way to go. I think that's where Timo assesses if you have some of what it takes to be a physicist or if you're just a walking encyclopedia. I genuinely felt as though Timo won't discredit you for not being entirely saddle fast on some topics as long as you started thinking in the right direction after given a few hints. That's why it's an excellent idea to just start talking -- even about something only remotely related -- if Timo asks you something you don't know how to deal with and then let him guide you towards the answer he is after. When faced with such a situation, it is especially important to watch Timo closely and take into account his reactions to your statements. He nods approvingly and utters words of encouragement whenever you say something that leads in the direction of the point he's trying to make (I tried to give an impression of this behavior in Timo's phrases in the transcript).

*Disclaimer* #h(0.5em) Of course, the actual exam was in German, so the transcript is really only how I recall the conversation and how I would translate it. Written in English, I hope this transcript will benefit international students as well.
