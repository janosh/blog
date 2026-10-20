#import "/notes.typ": dd, notes
#import "@preview/cetz:0.5.2": canvas, decorations, draw

#show: notes.with(
  title: [Quantum Field Theory II -- Exam Sheet],
  subtitle: [Advanced Quantum Field Theory],
  date: [Exam cheat sheet by Janosh Riebesell],
)

#set text(size: 9pt)
#set par(justify: false, leading: 0.5em, spacing: 0.7em)
#set list(spacing: 0.7em, indent: 0pt)
#show heading.where(level: 1): set block(above: 1.1em, below: 0.6em)
#show heading.where(level: 1): set text(size: 11pt)
#show math.equation.where(block: true): set block(above: 0.5em, below: 0.5em)

// Feynman slash notation
#let fsl(x) = math.cancel(x, angle: 25deg, length: 110%)

// inline Feynman diagrams
#let fd(body) = box(baseline: 35%, inset: (x: 1pt), canvas(length: 0.42cm, {
  import draw: *
  set-style(stroke: 0.6pt)
  body
}))
#let ph(a, b) = decorations.wave(draw.line(a, b), amplitude: 0.13, segment-length: 0.3)
// fermion line with an arrow in the middle
#let fe(a, b) = {
  let m = ((a.at(0) + b.at(0)) / 2, (a.at(1) + b.at(1)) / 2)
  draw.line(a, m, mark: (end: ">", fill: black, scale: 0.6))
  draw.line(m, b)
}
#let blob(pt, r: 0.32, body: none) = {
  let hatch = tiling(size: (3pt, 3pt), line(start: (0%, 100%), end: (100%, 0%), stroke: 0.4pt))
  draw.circle(pt, radius: r, fill: if body == none { hatch } else { white })
  if body != none { draw.content(pt, text(size: 5pt, body)) }
}
#let ct(pt, r: 0.28) = {
  draw.circle(pt, radius: r, fill: white)
  let d = r * 0.7
  draw.line((pt.at(0) - d, pt.at(1) - d), (pt.at(0) + d, pt.at(1) + d))
  draw.line((pt.at(0) - d, pt.at(1) + d), (pt.at(0) + d, pt.at(1) - d))
}
#let mom(a, b, label) = {
  draw.line(a, b, mark: (end: ">", fill: black, scale: 0.5), stroke: 0.45pt)
  draw.content(((a.at(0) + b.at(0)) / 2, a.at(1) + 0.38), text(size: 6pt, label))
}
#let lab(pt, body) = draw.content(pt, text(size: 6pt, body))
#let boxed(body) = box(stroke: 0.5pt, inset: (x: 2pt, y: 1pt), baseline: 30%, body)

= Path Integral

- QM transition amplitude: $chevron.l q_F, t_F | q_I, t_I chevron.r = chevron.l q_F | e^(-i hat(H) overbrace((t_F - t_I), Delta t)) | q_I chevron.r$, #h(0.3em) $delta t = (Delta t)/(N + 1)$, $N -> oo$, $e^(-i hat(H) Delta t) = e^(-i hat(H) delta t) dots.c e^(-i hat(H) delta t)$. Insert $bb(1) = integral dd(q_k) |q_k chevron.r chevron.l q_k|$ to get
  $ chevron.l q_F, t_F | q_I, t_I chevron.r = lim_(N -> oo) integral product_(k=1)^N dif q_k chevron.l q_F | e^(-i hat(H) delta t) | q_N chevron.r chevron.l q_N | e^(-i hat(H) delta t) | q_(N-1) chevron.r dots.c chevron.l q_1 | e^(-i hat(H) delta t) | q_I chevron.r, $
  now assume $hat(H)(hat(p), hat(q)) = f(hat(p)) + V(hat(q))$ and use BCH formula $e^(-i hat(H) delta t) = e^(-i V(hat(q)) delta t) e^(-i f(hat(p)) delta t) + cal(O)(delta t^2)$, thus $chevron.l q_(k+1) | e^(-i hat(H) delta t) | q_k chevron.r = integral dd(p_k) chevron.l q_(k+1) | e^(-i f(hat(p)) delta t) | p_k chevron.r chevron.l p_k | e^(-i V(hat(q)) delta t) | q_k chevron.r$, where $chevron.l p_k | q_k chevron.r = e^(-i p_k q_k) / sqrt(2 pi)$ so that $integral (dif p_k)/(2 pi) e^(-i (f(p_k) + V(q_k)) delta t) e^(i p_k (q_(k+1) - q_k))$. Reinsertion gives
  $
    chevron.l q_F, t_F | q_I, t_I chevron.r & = lim_(N -> oo) integral (dif p_0)/(2 pi) product_(k=1)^N (dif p_k dif q_k)/(2 pi) e^(i sum_(k=0)^N [p_k (q_(k+1) - q_k)/(delta t) - H(p_k, q_k)] delta t) \
    & stretch(->)^(delta t -> 0) integral_(q_I)^(q_F) cal(D) q(t) cal(D) p(t) e^(i integral_(t_I)^(t_F) (p dot(q) - H(hat(p), hat(q))) dif t) = integral_(q_I)^(q_F) cal(D) q(t) cal(D) p(t) underbrace(e^(i integral_(t_I)^(t_F) dd(t) L(p, q)), e^(i S[p, q]))
  $
- Scalar fields: path integral master formula for quantum correlation fcts.
  $ G(x_1, ..., x_n) = chevron.l Omega | T product_(i=1)^n hat(phi)_H (x_i) | Omega chevron.r = lim_(T -> oo (1 - i epsilon)) (integral cal(D) phi(x) product_(i=1)^n phi(x_i) e^(i integral_(-T)^T dd(4, x) cal(L)(phi(x))))/(integral cal(D) phi(x) e^(i integral_(-T)^T dd(4, x) cal(L)(phi(x)))) $
- $Z[J]$ generating functional of Green's fcts.: $G(x_1, ..., x_n) = 1/Z[0] product_(i=1)^n delta/(i delta J(x_i)) Z[J]|_(J=0)$; #h(0.3em) $Z_0 [J] = integral cal(D) phi e^(-1/2 phi dot D_F^(-1) dot phi + i phi dot J)$
- Schwinger--Dyson eq. $integral cal(D) phi ((delta S)/(delta phi(x)) + J(x)) e^(i (S[phi] + J dot phi)) = 0$, states that cl. e.o.m. holds as operator eq. in quantum theory; $((delta S)/(delta phi)|_(phi = delta/(i delta J)) + J) Z[J] = 0$
- effective action $i W[J]$ generating fctnal of fully connected Green's fcts.; $i W[J] = ln Z[J]/Z[0]$
- 1PI effective action $Gamma[phi.alt]$ Legendre transform of $W[J]$, i.e. $Gamma[phi.alt] := W[J_phi.alt] - phi.alt dot J_phi.alt$; $(delta Gamma)/(delta phi.alt(x)) = -J_phi.alt (x)$, $G_2^((c)) (x_1, x_2) = -Gamma_2^(-1) (x_1, x_2)$
- fermionic path integral: $chevron.l Psi_F (arrow(x)_F), t_F | Psi_I (arrow(x)_I), t_I chevron.r = integral cal(D) overline(Psi)(x) cal(D) Psi(x) e^(i integral_(t_I)^(t_F) dd(4, x) cal(L)(Psi, overline(Psi)))$
- if $H(p, q) = p^2/(2m) + V(q)$, integrate $integral cal(D) p$ explicitly by analytic continuation $delta t -> delta t (1 - i epsilon)$ (so that $"Re"(a) > 0$) to get
  $ integral (dif p_k)/(2 pi) e^(i (p_k (q_(k+1) - q_k) - delta t p_k^2/(2m))) = e^(i m/(2 delta t) (q_(j+1) - q_j)^2) sqrt((-i m)/(2 pi delta t)) $
- ex. of compl. the square in fermionic path integral:
  $ S_0 [overline(Psi), Psi] + overline(eta) dot Psi + overline(Psi) dot eta = i overline(Psi) dot S_F^(-1) dot Psi + overline(eta) dot Psi + overline(Psi) dot eta = (overline(Psi) - i S_F overline(eta)) dot i S_F^(-1) dot (Psi - i S_F eta) + i overline(eta) dot S_F dot eta $

= Renormalization

- Superficial degree of divergence $D$: $phi^n$ in $d$ dim $D_(phi^n) = d - overbrace((d - n (d-2)/2), [lambda^((n))]) V - (d-2)/2 E$ with $n V = 2 I + E$ and Euler's formula $L = I - V + 1$ or $L = sum_i I_i - sum_j V_j + 1$
- $D >= 0$ may still be finite due to symmetries, $D < 0$ may still be divergent due to divergent subdiagram; tree-level diagrams have $D = 0$ but are finite
- a QFT is 1. renormalizable if number of superf. diverg. ampl. is finite, but superf. divergs. appear at every order; 2. super-renormalizable if number of superf. divergent ampl. is finite; 3. non-renormalizable if infinite; #h(0.3em) 1. $hat(=) [lambda] = 0$, 2. $hat(=) [lambda] > 0$, 3. $hat(=) [lambda] < 0$
- BPHZ theorem: if a QFT is renormalizable, i.e. has finite number of divergent diagr., one can absorb divergencies order by order in counterterms
- in a QFT with dimensionless coupling, $[lambda] = 0$, the dimension of an amplitude is equal to $D$
- QED: $D_"QED" = 4 - E_gamma - 3/2 E_f$, QED is renormalizable since $[e] = 0$, symmetric under charge conj.!, respects Ward identity!
- Callan--Symanzik eq.: $mu dif/(dif mu) G_n^((0)) (x; lambda_0, m_0)|_(lambda_0, m_0 "fixed") = 0 = mu dif/(dif mu) (Z^(n\/2) G_n (x; lambda, m; mu))|_(lambda_0, m_0 "fixed")$, where $G_n (x_1, ..., x_n) = chevron.l Omega | T product_(i=1)^n phi(x_i) | Omega chevron.r|_"connected"$ and $phi(x_i) = Z^(-1\/2) phi_0 (x_i)$; chain rule yields
  $ (mu partial/(partial mu) + beta_lambda partial/(partial lambda) + beta_(m^2) partial/(partial m^2) + n dot gamma_phi) G_n (x; lambda, m; mu) = 0 $
  with $beta_lambda := mu (dif lambda)/(dif mu)|_(lambda_0, m_0)$, $beta_(m^2) = mu (dif m^2)/(dif mu)|_(lambda_0, m_0)$, $gamma_phi = 1/2 mu/Z (dif Z)/(dif mu)|_(lambda_0, m_0)$
- Renormalization group (RG) flow (eq.) given by the beta function $beta(lambda) = (dif lambda(mu))/(dif ln(mu))$ describes change of $lambda(mu)$ with $mu$: $beta(lambda) > 0 thin (< 0) <==> lambda(mu)$ increases (decreases) as $mu$ increases. Landau pole: $lambda -> oo$ as $mu -> mu^*$ with $mu^*$ finite; Gaussian IR (UV) fixed point: $lambda -> 0$ as $mu -> 0 thin (oo)$; $beta = 0 thin forall mu => lambda(cancel(mu)) <-->$ theory is scale-ind. or conformal
- RG flow of dimensionful operators: $integral dd(d, x) C_i cal(O)_(d_i)$ with $[cal(O)_(d_i)] = d_i$, $[C_i] = d - d_i$, $C_i = g_i mu^(d - d_i)$, then CS eq. reads
  $ 0 = [mu partial/(partial mu) + beta_lambda partial/(partial lambda) + n gamma_phi + underbrace((gamma_i + d_i - d) g_i, beta_i := (dif g_i)/(dif ln mu)) partial/(partial g_i)] G_n (x; lambda, g_i, mu) $
  if $[C_i] = d - d_i < 0 thin (> 0) <-->$ $C_i$ is non-renormalizable (super-renormalizable) coupling which becomes irrelevant (relevant) in the IR
- Wilsonian approach: QFT just an effective description of physics accurate only at energies below an intrinsic cutoff $Lambda_0$ (or at large distances)
- Dim. reg. integrals:
  $
    integral (dd(d, l))/(2 pi)^d 1/(l^2 - Delta)^n & = ((-1)^n i)/(4 pi)^(d\/2) Gamma(n - d/2)/Gamma(n) Delta^(d/2 - n), quad integral (dd(d, l))/(2 pi)^d l^2/(l^2 - Delta)^n = ((-1)^(n-1) i)/(4 pi)^(d\/2) d/2 Gamma(n - d/2 - 1)/Gamma(n) Delta^(1 + d/2 - n), \
    integral (dd(d, l))/(2 pi)^d (l^mu l^nu)/(l^2 - Delta)^n & = ((-1)^(n-1) i)/(4 pi)^(d\/2) eta^(mu nu)/2 Gamma(n - d/2 - 1)/Gamma(n) Delta^(1 + d/2 - n)
  $
  frequent identity: $Gamma(2 - d/2)/(4 pi)^(d\/2) Delta^(d/2 - 2) = 1/(16 pi^2) (2/epsilon - ln Delta - gamma + ln 4 pi + cal(O)(epsilon))$,
  $ 1/(A_1^(m_1) A_2^(m_2) dots.c A_n^(m_n)) = integral_0^1 dd(x_1) dots.c dif x_n delta(sum_i x_i - 1) (product x_i^(m_i - 1))/[sum_i x_i A_i]^(sum m_i) Gamma(m_1 + dots.c + m_n)/(Gamma(m_1) dots.c Gamma(m_n)), quad 1/(A B^n) = integral_0^1 dd(x) (n (1-x)^(n-1))/[x A + (1-x) B]^(n+1) $
- Trace identities: $tr(gamma^mu) = 0$, $tr(gamma^(mu_1) dots.c gamma^(mu_n)) = 0$ for $n$ odd, $tr(gamma^mu gamma^nu) = 4 eta^(mu nu)$, $tr(gamma^mu gamma^nu gamma^rho gamma^sigma) = 4 (eta^(mu nu) eta^(rho sigma) - eta^(mu rho) eta^(nu sigma) + eta^(mu sigma) eta^(nu rho))$, $gamma^mu gamma^nu gamma_mu = -2 gamma^nu$, $gamma^mu gamma^nu gamma^rho gamma_mu = 4 eta^(nu rho)$

= Yang--Mills theory

- starting point: Lie group $H$ with Lie algebra $"Lie"(H)$ s.t. every $h in H$ can be expressed as $h = e^(-i g alpha)$ with $g in RR$, $alpha = alpha_a T^a in "Lie"(H)$, where $T^a$ are a basis of $"Lie"(H)$, i.e. the generators of $H$, satisfying defining relation $[T^a, T^b] = i f^(a b c) T^c$ and Jacobi identity $[[T^a, T^b], T^c] + "c.p." = 0$
- (adjoint) covariant derivative: $D_mu alpha(x) := partial_mu alpha(x) + i g [A_mu (x), alpha(x)]$ used to define $F_(mu nu) (x) = 1/(i g) [D_mu, D_nu] = partial_mu A_nu - partial_nu A_mu + i g [A_mu, A_nu]$, field strength satisfies Bianchi identity $D_mu F_(alpha beta) + D_alpha F_(beta mu) + D_beta F_(mu alpha) = 0$
- pure Yang--Mills Lagrangian: $cal(L)_"YM" = -1/2 tr(F_(mu nu) F^(mu nu)) = -1/4 F^a_(mu nu) F^(mu nu a)$ is gauge invariant; e.o.m. for $A_mu$: $D_mu F^(mu nu) = 0 = partial_mu F^(mu nu) + i g [A_mu, F^(mu nu)]$
- generators $T^a$ normalized to $tr(T^a T^b) = 1/2 delta^(a b)$ (used in the second step of $cal(L)_"YM"$)
- for $cal(L)_"YM" + cal(L)_"matter"$, the e.o.m. become $D_mu F^(mu nu a) = j^(nu a)$ for some $j^(nu a) (phi, Psi, ...)$

= Possible exam questions

+ #underline[Derivation of the fermionic PI]: trans. ampl. $chevron.l Psi_F, t_F | Psi_I, t_I chevron.r = chevron.l Psi_F | e^(-i hat(H) (t_F - t_I)) | Psi_I chevron.r$ with $e^(-i hat(H) (t_F - t_I)) = lim_(N -> oo) (e^(-i hat(H) delta t))^N$, $delta t = (t_F - t_I)/(N + 1)$. Now insert identities
  $ chevron.l Psi_F, t_F | Psi_I, t_I chevron.r = lim_(N -> oo) integral product_(j=1)^N dif Psi_j^* dif Psi_j chevron.l Psi_F | e^(-i hat(H) delta t) | Psi_N chevron.r dots.c chevron.l Psi_1 | e^(-i hat(H) delta t) | Psi_I chevron.r $
  since $bb(1) = integral dd(Psi)_j^* dif Psi_j |Psi_j chevron.r e^(-Psi_j^* Psi_j) chevron.l Psi_j|$. We assume $hat(H) = hat(Psi)^dagger M hat(Psi)$ with Grassmann-even $M$. Then
  $ chevron.l Psi_(j+1) | e^(-i hat(H) delta t) | Psi_j chevron.r = chevron.l Psi_(j+1) | (1 - i hat(Psi)^dagger M hat(Psi) delta t) | Psi_j chevron.r = e^(Psi_(j+1)^* Psi_j) e^(-i Psi_(j+1)^* M Psi_j delta t) = e^(Psi_(j+1)^* Psi_(j+1)) e^(Psi_(j+1)^* (Psi_j - Psi_(j+1))) e^(-i Psi_(j+1)^* M Psi_j delta t), $
  where the factors $e^(Psi_(j+1)^* Psi_(j+1))$ cancel with those from identities, except for $e^(Psi_F^* Psi_F)$. Thus
  $
    chevron.l Psi_F, t_F | Psi_I, t_I chevron.r & = lim_(N -> oo) integral product_(j=1)^N dif Psi_j^* dif Psi_j e^(Psi_F^* Psi_F) e^(sum_(j=0)^N (-Psi_(j+1)^* (Psi_(j+1) - Psi_j) - i delta t H(Psi_(j+1)^*, Psi_j))) \
    & stretch(->)^(N -> oo) integral cal(D) Psi^* cal(D) Psi e^(i integral_(t_I)^(t_F) dd(t) (Psi^* i (partial Psi)/(partial t) - H)).
  $
+ #underline[Renormalization of QED]: $D = 4 L - P_e - 2 P_gamma$, $L = P_e + P_gamma - V + 1$, $V = 2 P_gamma + I_gamma = 1/2 (2 P_e + I_e) ==> D = 4 - 3/2 I_e - I_gamma$. \
  Divergent amplitudes (superficially):
  #fd({ blob((0, 0)); lab((0, -0.7), $D = 4$) }) can be absorbed into $V_0$,
  #fd({ ph((0.3, 0), (1.5, 0)); blob((0, 0)); lab((0, -0.7), $D = 3$) }) zero by $A_mu -> -A_mu$ symmetry,
  #boxed[#fd({ ph((-1.4, 0), (1.4, 0)); blob((0, 0)); lab((0, -0.7), $D = 2$) })] logarithmically divergent,
  #fd({ ph((-1.2, 0.6), (0, 0)); ph((-1.2, -0.6), (0, 0)); ph((0, 0), (1.3, 0)); blob((0, 0)); lab((0, -0.75), $D = 1$) }) 0 by $A_mu -> -A_mu$,
  #fd({ ph((-1.2, 0.6), (0, 0)); ph((-1.2, -0.6), (0, 0)); ph((0, 0), (1.2, 0.6)); ph((0, 0), (1.2, -0.6)); blob((0, 0)); lab((0, -0.75), $D = 0$) }) divergent parts cancel due to Ward identity,
  #fd({ fe((1.4, 0), (0, 0)); blob((0, 0)) }) 0 by charge conserv.,
  #boxed[#fd({ fe((-1.4, 0), (0, 0)); fe((0, 0), (1.4, 0)); blob((0, 0)); lab((0, -0.7), $D = 1$) })] logarithm. divergent,
  #boxed[#fd({ fe((-1.2, 0.7), (0, 0)); fe((0, 0), (-1.2, -0.7)); ph((0, 0), (1.3, 0)); blob((0, 0)); lab((0, -0.8), $D = 0$) })] logarithm. divergent,
  $ cal(L)_"QED" = -1/4 (F_(mu nu))^2 + overline(Psi) (i fsl(partial) - m) Psi - e A_mu overline(Psi) gamma^mu Psi - 1/4 delta_A (F_(mu nu))^2 + overline(Psi) (i delta_Psi fsl(partial) - delta_m) Psi - delta_e A_mu overline(Psi) gamma^mu Psi, $
  where $Psi = Z_Psi^(-1\/2) Psi_0$, etc. \
  Feynman rules:
  #box[#fd({ ph((0, 0), (2, 0)); mom((0.6, 0.3), (1.4, 0.3), $q$); lab((-0.3, 0), $mu$); lab((2.3, 0), $nu$) }) $= (-i eta_(mu nu))/q^2$],
  #box[#fd({ fe((0, 0), (2, 0)); mom((0.6, 0.3), (1.4, 0.3), $p$) }) $= (i (fsl(p) + m))/(p^2 - m^2)$],
  #box[#fd({ fe((-1.1, 0.7), (0, 0)); fe((0, 0), (-1.1, -0.7)); ph((0, 0), (1.3, 0)); lab((1.6, 0), $mu$) }) $= -i e gamma^mu$],
  #box[#fd({ ph((0, 0), (2.4, 0)); ct((1.2, 0)); mom((0.8, 0.45), (1.6, 0.45), $q$); lab((-0.3, 0), $mu$); lab((2.7, 0), $nu$) }) $= -i (eta_(mu nu) q^2 - q_mu q_nu) delta_A$],
  #box[#fd({ fe((0, 0), (1.2, 0)); fe((1.2, 0), (2.4, 0)); ct((1.2, 0)); mom((0.8, 0.45), (1.6, 0.45), $p$) }) $= i (fsl(p) delta_Psi - delta_m)$],
  #box[#fd({ fe((-1.1, 0.7), (0, 0)); fe((0, 0), (-1.1, -0.7)); ph((0, 0), (1.3, 0)); ct((0, 0)); lab((1.6, 0), $mu$) }) $= -i e gamma^mu delta_e$] \
  Renormalization conditions: $Sigma(fsl(p) = m) = 0$, $dif/(dif fsl(p)) Sigma(fsl(p) = m) = 0$, $Pi(q^2 = 0) = 0$, $-i e Gamma^mu (p' - p = 0) = -i e gamma^mu$, where
  #box[#fd({ ph((0, 0), (3, 0)); blob((1.5, 0), r: 0.38, body: [1PI]); mom((0.3, 0.45), (0.9, 0.45), $q$); lab((-0.3, 0), $mu$); lab((3.3, 0), $nu$) }) $= i Pi^(mu nu) (q) = i (q^2 eta^(mu nu) - q^mu q^nu) Pi(q^2)$]
  and $(#fd({ fe((-1.1, 0.7), (0, 0)); fe((0, 0), (-1.1, -0.7)); ph((0, 0), (1.3, 0)); blob((0, 0)); lab((1.6, 0), $mu$) }))_"amp" = -i e Gamma^mu (p', p)$. We use dim. reg. to control UV and photon mass $mu$ to control IR divergencies.
  $
    #fd({ fe((0, 0), (1.2, 0)); fe((1.2, 0), (2.4, 0)); blob((1.2, 0)) }) |_"1-loop" & = #fd({ fe((0, 0), (2, 0)); mom((0.6, 0.3), (1.4, 0.3), $p$) }) + #fd({
      fe((0, 0), (0.8, 0)); fe((0.8, 0), (2.4, 0)); fe((2.4, 0), (3.2, 0))
      decorations.wave(draw.arc((2.4, 0), start: 0deg, stop: 180deg, radius: 0.8), amplitude: 0.12, segment-length: 0.3)
      lab((0.35, -0.4), $p$); lab((1.6, -0.4), $k$); lab((2.6, 1.05), $p - k$)
    }) + #fd({ fe((0, 0), (1.2, 0)); fe((1.2, 0), (2.4, 0)); ct((1.2, 0)); mom((0.8, 0.45), (1.6, 0.45), $p$) }) = (i (fsl(p) + m))/(p^2 - m^2) - i Sigma_2 (p) + i (fsl(p) delta_Psi - delta_m) \
    -i Sigma_2 (p) & = (-i e)^2 integral (dd(d, k))/(2 pi)^d gamma^mu (i (fsl(k) + m))/(k^2 - m^2) gamma_mu (-i)/((p - k)^2 - mu^2) = -e^2 integral_0^1 dd(x) integral (dd(d, l))/(2 pi)^d (-2 x fsl(p) + 4 m)/[l^2 - Delta]^2 \
    & = (-i e^2)/(4 pi)^(d\/2) integral_0^1 dd(x) (Gamma(epsilon/2) [(4 - epsilon) m - 2 (1 - epsilon/2) x fsl(p)])/[(1-x) m^2 + x mu^2 - x(1-x) p^2]^(epsilon\/2)
  $
  $ Sigma(fsl(p) = m)|_"1-loop" = -i Sigma_2 (m) + i (m delta_Psi - delta_m) attach(=, t: !) 0 ==> m delta_Psi - delta_m = Sigma_2 (m) = (e^2 m)/(4 pi)^(d\/2) integral_0^1 dd(x) (Gamma(epsilon/2) (4 - 2x - epsilon (1-x)))/[(1-x)^2 m^2 + x mu^2]^(epsilon\/2) $
  $
    dif/(dif fsl(p)) Sigma(fsl(p) = m)|_"1-loop" & = -i dif/(dif fsl(p)) Sigma_2 (m) + i delta_Psi attach(=, t: !) 0 \
    ==> delta_Psi & = -e^2/(4 pi)^(d\/2) integral_0^1 dd(x) Gamma(epsilon\/2)/[(1-x)^2 m^2 + x mu^2]^(epsilon\/2) [(2 - epsilon) x - epsilon/2 (2x (1-x) m^2)/((1-x)^2 m^2 + x mu^2) (4 - 2x - epsilon (1-x))]
  $
