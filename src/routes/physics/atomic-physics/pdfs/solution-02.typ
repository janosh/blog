#import "/notes.typ": dd, task, vb, unit, bra, ket, braket
#import "/atomic-physics/sheet.typ": sheet, pts, up, dn
#import "@preview/cetz:0.5.2": canvas, draw

#show: sheet.with([Übungsblatt 2], [29.~April 2014])

#let (H0, H1, Hh) = ($hat(H)_0$, $hat(H)_1$, $hat(H)$)
#let (Et, Psit) = ($tilde(E)$, $tilde(vb(Psi))$)
#let one = $hat(bold(1))$

#heading(numbering: none)[Präsenzaufgaben]

= Nicht-entartete, zeitunabhängige Störungstheorie

#task[
  Diskutieren sie die wesentliche Idee der zeitunabhängigen Störungsrechnung. Der Hamilton-Operator $Hh$ bestehe aus den zwei Anteilen
  $ Hh = H0 + lambda H1. $
  Der Störterm $lambda H1$ sei ein kleiner Zusatzterm im Vergleich zu $H0$. Die Eigenwerte $E_(0,n)$ und zugehörigen Eigenfunktionen $ket(n_0)$ des Operators $H0$ seien exakt bekannt und nicht entartet, d.h.
  $ H0 ket(n_0) = E_(0,n) ket(n_0) $
  Gesucht sind die diskreten, stationären Zustände $ket(n)$ und Eigenwerte $E_n$ von $Hh$.
]

+ #task[
    Nehmen sie an, dass sich Eigenwerte und -funktionen entwickeln lassen als#footnote[Die Indizes $0, 1, 2, ...$ in Gleichung @eq:expansion signalisieren die Ordnung der Entwicklung und nicht etwa die Zugehörigkeit zu einem bestimmten Operator. Im Falle von $E_(0,n)$ und $ket(n_0)$ handelt es sich dennoch um Eigenfunktionen zu $H0$.]
    $
      E_n & = E_(0,n) + lambda E_(1,n) + lambda^2 E_(2,n) + ... \
      ket(n) & = ket(n_0) + lambda ket(n_1) + lambda^2 ket(n_2) + ...
    $ <eq:expansion>
    Setzen sie die Entwicklungen von $Hh$, $E_n$ und $ket(n)$ in die stationäre Schrödingergleichung ein und führen sie einen Koeffizientenvergleich zu den Potenzen $lambda^0$, $lambda^1$ und $lambda^2$ durch.
  ]

  Unter Vernachlässigung von Termen der Ordnung 3 und höher in $lambda$ ergibt @eq:expansion eingesetzt in die Schrödinger-Gleichung des gestörten Operators $Hh ket(n) = E_n ket(n)$ auf der linken Seite
  $
    Hh ket(n) & = (H0 + lambda H1)(ket(n_0) + lambda ket(n_1) + lambda^2 ket(n_2)) \
              & = H0 ket(n_0) + lambda H1 ket(n_0) + lambda H0 ket(n_1) + lambda^2 H1 ket(n_1) + lambda^2 H0 ket(n_2) + lambda^3 H1 ket(n_2) \
              & approx H0 ket(n_0) + lambda (H0 ket(n_1) + H1 ket(n_0)) + lambda^2 (H0 ket(n_2) + H1 ket(n_1)).
  $ <eq:lhs>
  Ausmultiplizieren der Energie- und Zustandsentwicklung liefert
  $
    & (E_(0,n) + lambda E_(1,n) + lambda^2 E_(2,n))(ket(n_0) + lambda ket(n_1) + lambda^2 ket(n_2)) \
    & = E_(0,n) ket(n_0) + lambda E_(0,n) ket(n_1) + lambda^2 E_(0,n) ket(n_2) + lambda E_(1,n) ket(n_0) + lambda^2 E_(1,n) ket(n_1) + lambda^3 E_(1,n) ket(n_2) \
    & quad + lambda^2 E_(2,n) ket(n_0) + lambda^3 E_(2,n) ket(n_1) + lambda^4 E_(2,n) ket(n_2) \
    & approx E_(0,n) ket(n_0) + lambda (E_(0,n) ket(n_1) + E_(1,n) ket(n_0)) + lambda^2 (E_(0,n) ket(n_2) + E_(1,n) ket(n_1) + E_(2,n) ket(n_0))
  $ <eq:rhs>
  Da zwei Linearkombinationen (der gleichen Elemente) genau dann gleich sind, wenn ihre jeweiligen Koeffizienten gleich sind folgt aus dem Vergleich der Ergebnisse von Gleichungen @eq:lhs und @eq:rhs:
  $ H0 ket(n_0) = E_(0,n) ket(n_0) $ <eq:order0>
  $ H0 ket(n_1) + H1 ket(n_0) = E_(0,n) ket(n_1) + E_(1,n) ket(n_0) $ <eq:order1>
  $ H0 ket(n_2) + H1 ket(n_1) = E_(0,n) ket(n_2) + E_(1,n) ket(n_1) + E_(2,n) ket(n_0) $ <eq:order2>

+ #task[Wählen sie die Normierung $braket(n_0, n) = 1$, sodass $braket(n_0, n_1) = braket(n_0, n_2) = dots.c = 0$ gilt. Berechnen sie die Energiekorrektur 1. Ordnung $E_(1,n)$ durch Multiplikation der Koeffizientengleichung zu $lambda$ mit $bra(n_0)$.]

  Gleichung @eq:order1 multipliziert mit $bra(n_0)$ ergibt:
  $ braket(n_0, H0, n_1) + braket(n_0, H1, n_0) = braket(n_0, E_(0,n), n_1) + braket(n_0, E_(1,n), n_0) $ <eq:proj1>
  Die Energieentwicklungskoeffizienten können aus dem Skalarprodukt gezogen werden. Aufgrund der in der Aufgabenstellung bestimmten Orthogonalität des ungestörten Zustands zu allen Störungen verschwindet der erste Summand der rechten Seite von Gleichung @eq:proj1. Wegen der Selbstadjungiertheit von $H0$ gilt außerdem $braket(n_0, H0, n_1) = E_(0,n) braket(n_0, n_1) = 0$, sodass auch der erste Summand der linken Seite verschwindet und
  $ E_(1,n) = braket(n_0, H1, n_0) $

+ #task[Multiplizieren sie die Koeffizientengleichung zu $lambda$ mit $bra(m_0)$#footnote[Bei $ket(m_0)$ handelt es sich um eine von $ket(n_0)$ verschiedene, aber aus derselben Entwicklungsordnung (ebenfalls ungestört) stammende Eigenfunktion von $H0$]. Finden sie die Zustandskorrektur über die Entwicklung $ket(n_1) = sum_(m != n) ket(m_0) braket(m_0, n_1)$. Für $m = n$, wäre $braket(n_0, n_1) = 0$, sodass in diesem Fall der Koeffizient verschwindet.]

  Multipliziert man Gleichung @eq:order1 mit $bra(m'_0)$#footnote[Der Strich dient zur Erinnerung, dass über dieses $bra(m_0)$ nicht summiert wird.] statt mit $bra(n_0)$ und entwickelt alle $ket(n_1)$, folgt daraus
  $
    & sum_(m != n) braket(m'_0, H0, m_0) braket(m_0, n_1) + braket(m'_0, H1, n_0) \
    & = sum_(m != n) braket(m'_0, E_(0,n), m_0) braket(m_0, n_1) + braket(m'_0, E_(1,n), n_0) \
    & = E_(0,n) sum_(m != n) underbrace(braket(m'_0, m_0), delta_(m' m)) braket(m_0, n_1) + E_(1,n) underbrace(braket(m'_0, n_0), 0) \
    & = E_(0,n) braket(m'_0, n_1)
  $ <eq:proj-m>
  In der ersten Zeile von Gleichung @eq:proj-m wirkt der ungestörte Hamilton-Operator $H0$ auf seinen Eigenzustand $H0 ket(m_0) = E_(0,m) ket(m_0)$. Nutzt man an dieser Stelle wieder die Orthogonalität der Eigenzustände, erhält man $sum_(m != n) braket(m'_0, H0, m_0) braket(m_0, n_1) = E_(0,m') braket(m'_0, n_1)$, sodass die Koeffizienten $braket(m_0, n_1)$ gegeben sind durch
  $ braket(m_0, n_1) = braket(m_0, H1, n_0)/(E_(0,n) - E_(0,m)) $
  Die Zustandskorrektur erster Ordnung lautet also
  $ lambda ket(n_1) = lambda sum_(m != n) ket(m_0) braket(m_0, H1, n_0)/(E_(0,n) - E_(0,m)) $

+ #task[Berechnen sie die Energiekorrektur 2. Ordnung $E_(2,n)$ aus der Koeffizientengleichung zu $lambda^2$. Benutzen sie dazu das Ergebnis aus c).]

  Gleichung @eq:order2 vereinfacht sich durch Multiplikation von links mit dem Zustand $bra(n_0)$ zu
  $
    E_(2,n) & = braket(n_0, H0, n_2) + braket(n_0, H1, n_1) \
            & = braket(H0 n_0, n_2) + braket(n_0, H1, n_1) \
            & = E_(0,n) underbrace(braket(n_0, n_2), 0) + braket(n_0, H1, n_1) = braket(n_0, H1, n_1),
  $
  wobei in der zweiten Zeile die Selbstadjungiertheit des ungestörten Hamilton-Operators verwendet wurde. Mit der gerade gefundenen Darstellung von $ket(n_1)$ ergibt sich daraus
  $
    E_(2,n) & = sum_(m != n) braket(n_0, H1, m_0) braket(m_0, H1, n_0)/(E_(0,n) - E_(0,m)) \
            & = sum_(m != n) (|braket(m_0, H1, n_0)|^2)/(E_(0,n) - E_(0,m))
  $

#heading(numbering: none)[Übungsaufgaben]
#counter(heading).update(0)

= Radiale Wellenfunktion #pts(6)

#task[
  Die radiale Wellenfunktion des Wasserstoffatoms hängt von den Quantenzahlen $n$ und $l$ ab über
  $ R_(n,l) (r') prop e^(-r'\/n) ((2 r')/n)^l L_(n+l)^(2 l + 1) (2 r' \/ n) $
  mit $r' = r\/a_0$. Beachten sie, dass die zugeordneten Laguerre-Polynome $L_p^k (x)$ durch $k$-fache Ableitung aus den gewöhnlichen Laguerre-Polynomen $L_p (x)$ hervorgehen, d.h. $L_p^k (x) = dif^k / (dif x^k) L_p (x)$ für $k <= p$. Nehmen sie an, dass alle Nullstellen der Polynome auf der positiven reellen Achse $RR_+$ liegen.
]

+ #task[Bestimmen sie die Anzahl der Knoten der radialen Wellenfunktion in Abhängigkeit von $n$ und $l$. (3 Punkte)]

  Als Knoten bezeichnen wir hier die Nullstellen der radialen Komponente der Wellenfunktion. Wir betrachten zuerst die Laguerre-Polynome. Es gilt: Die Laguerre-Polynome bilden ein System von Orthonormalpolynomen über $[0, infinity)$ bzgl. der Gewichtsfunktion $omega(x) = e^(-x)$. D.h. für das Skalarprodukt haben wir:
  $ (L_n, L_m)_omega := integral_0^infinity L_n (x) e^(-x) L_m (x) dd(x) = delta_(n m) $
  Wir wollen nun allgemein zeigen, dass für eine positive Gewichtsfunktion $omega in C(a, b)$ und $omega(x) > 0$ für alle $x in (a, b)$ mit dem Skalarprodukt $(dot, dot)_omega$ die zugehörigen Orthogonalpolynome $p_k (x)$ von echtem Grad $k$ genau $k$ einfache Nullstellen in $(a, b)$ besitzen.

  _Beweis:_ Es seien $x_1, ..., x_m$ die $m <= k$ verschiedenen Nullstellen in $(a, b)$, an denen $p_k$ sein Vorzeichen wechselt. Das Polynom
  $ q(x) := (x - x_1) dot ... dot (x - x_m) $
  wechselt dann an den gleichen Stellen sein Vorzeichen, sodass die Funktion $omega(x) thin p_k (x) thin q(x)$ ihr Vorzeichen in $(a, b)$ nicht ändert, da $omega$ nach Voraussetzung ja eine positive Gewichtsfunktion ist. Folglich gilt
  $ (q, p_k) = integral_a^b q(x) omega(x) p_k (x) dd(x) != 0. $
  Es steht aber $p_k$ senkrecht auf allen Polynomen vom Grad $k - 1$ (nach Voraussetzung Orthogonalsystem), weshalb $"grad" q = m >= k$. Damit ist die Behauptung bewiesen. Insbesondere hat also das Laguerre-Polynom $L_n$, welches ein Polynom $n$-ter Ordnung ist, $n$ einfache Nullstellen auf der positiven Achse.

  Da $L_n$ also $n$-mal das Vorzeichen wechselt, besitzt es $n - 1$ Extremstellen und dementsprechend die erste Ableitung auch $n - 1$ einfache Nullstellen. Induktiv folgt damit, dass $L_n^k (x)$ genau $n - k$ einfache Nullstellen auf der positiven Achse aufweist.

  Insgesamt hat daher die radiale Komponente $R_(n,l) (r')$ genau $(n + l) - (2 l + 1) = n - l - 1$ Knoten auf der positiven Halbachse $(0, infinity)$. Zählt man den Ursprung dazu, so haben wir die Fallunterscheidung:
  $
    s-"Orbitale": n - 1 & unit("Knoten") \
    "restliche Orbitale": n - l & unit("Knoten")
  $

+ #task[Wie viele Maxima hat die radiale Aufenthaltswahrscheinlichkeit $w_(n,l) (r) = r^2 R_(n,l)^2 (r')$? (1 Punkt)]

  Nach obiger Überlegung hat $R_(n,l)$ genau $n - l - 1$ einfache Nullstellen auf der positiven Achse. Durch Quadrieren werden diese zu doppelten Nullstellen und somit zu Minima-Stellen von $R_(n,l)^2$. Man bemerke am Rande, dass $R_(n,l)^2 thin forall n, l$ eine positiv semi-definite Funktion ist. Wegen des Faktors $r^2$ und dem Exponentialterm in der Radialkomponente besitzt $w_(n,l)$ ein zusätzliches Minimum im Ursprung und im Unendlichen. Da bei einer stetig differenzierbaren Funktion zwischen zwei Minima stets ein Maximum liegt, besitzt $w_(n,l)$ insgesamt $(n - l - 1) + 2 - 1 = n - l$ Maxima.

+ #task[Zeigen sie, dass es bei maximaler Drehimpulsquantenzahl $l$ genau ein Maximum in der radialen Aufenthaltswahrscheinlichkeit gibt. Zeigen sie ferner, dass für diesen Fall der Abstand des Maximums zum Kern quadratisch mit der Hauptquantenzahl $n$ wächst. (2 Punkte)]

  Die maximale Drehimpulsquantenzahl hat den Wert $l = n - 1$. Nach vorheriger Teilaufgabe folgt sofort, dass die radiale Aufenthaltswahrscheinlichkeit genau ein Maximum aufweist. Weiterhin gilt:
  $ R_(n,n-1) (r') prop e^(-r'\/n) dot ((2 r')/n)^(n-1) $
  $ => w_(n,n-1) (r) prop r^2 dot R_(n,n-1)^2 (r') prop r^(2 n) dot e^(-2 r'\/n) $
  Nullsetzen der 1. Ableitung liefert uns die quadratische Abhängigkeit des Abstandes vom Kern zum einzigen Maximum bzgl. der Hauptquantenzahl $n$.
  $ (r_(n,n-1))_max = n^2 dot a_0 $

= Orbitale Kopplung #pts(8)

#task[
  Wir betrachten ein reduziertes Wasserstoffatom. Die Eigenvektoren sind die Wasserstoff-Wellenfunktionen ohne Fein- oder Hyperfeinstruktur (s. Vorlesung). Wir begrenzen das Problem auf die drei ersten Orbitale 1s, 2s, 2p:
  $ vb(Psi) = (Psi_(1 s), Psi_(2 s), Psi_(2 p))^T, wide H0 vb(Psi) = (E_1, E_2, E_3)^T vb(Psi). $
  $hat(V)$ ist ein weiterer Kopplungsoperator, der nur die 1s und 2p Orbitale miteinander koppelt.
]

+ #task[Bestimmen sie die Eigenwerte $(Et_1, Et_2, Et_3)^T$ des gesamten Hamilton-Operators $Hh = H0 + hat(V)$ durch Diagonalisierung der Matrix. (Hinweis: Schrödingergleichung in Matrixform schreiben.) (3 Punkte)]

  Die Schrödinger-Gleichung in Matrixform lautet
  $ Hh vb(Psi) = (H0 + hat(V)) vb(Psi) = mat(E_1, 0, V_(2 p); 0, E_2, 0; V_(1 s), 0, E_3) mat(Psi_(1 s); Psi_(2 s); Psi_(2 p)). $
  In diagonalisierter Form hat $Hh$ folgende Gestalt
  $ Hh_"dia" = hat(S)^(-1) Hh hat(S) = mat(E_-, 0, 0; 0, E_2, 0; 0, 0, E_+), $ <eq:diag>
  mit $E_plus.minus = 1/2 (E_1 + E_3 plus.minus sqrt((E_1 - E_3)^2 + 4 V_(1 s) V_(2 p)))$ und der $3 times 3$-Matrix $hat(S)$, deren Spalten aus den Eigenvektoren des Gesamthamilton-Operators $Hh$ bestehen, d.h.
  $ hat(S) = (Psit_1, Psit_2, Psit_3) $
  Multipliziert man Gleichung @eq:diag nun von links mit $hat(S)$, ergibt sich die Eigenwertgleichung $Hh hat(S) = hat(S) Hh_"dia"$. Da $Hh_"dia"$ Diagonalgestalt hat, kann diese Gleichung auch spaltenweise aufgefasst werden als
  $ Hh Psit_i = H_("dia",i i) Psit_i $
  Es handelt sich bei den Diagonaleinträgen von $Hh_"dia"$ also um die Eigenwerte von $Hh$:
  $ (Et_1, Et_2, Et_3)^T = (E_-, E_2, E_+)^T $
  Man kann die Ausdrücke für $E_plus.minus$ noch etwas vereinfachen, wenn man berücksichtigt, dass die Kopplung $hat(V)$ zwischen den Zuständen 1s und 2p eine rein reelle Änderung der Zustandsenergien hervorruft, sodass es sich bei $hat(V)$ um einen hermiteschen Operator handeln muss. Für die Matrixelemente einer hermitschen Matrix gilt die Beziehung $a_(i j) = a_(j i)^*$, woraus folgt, dass $V_(1 s) = V_(2 p)^* equiv V$. Eingesetzt in den Ausdruck von $Et_(1,3)$:
  $ Et_(1,3) = 1/2 (E_1 + E_3 minus.plus sqrt((E_1 - E_3)^2 + 4 |V|^2)) $

+ #task[Nähern sie den Ausdruck für die neuen Energieeigenwerte $(Et_1, Et_2, Et_3)^T$, wenn $|V_(n,m)|^2 << |E_n - E_m|^2$ und stellen sie das Ergebnis in einem Energieniveauschema dar. (2 Punkte)]

  Die Energie des 2s-Zustands ist durch den Kopplungsoperator nicht beeinflusst und muss dementsprechend auch nicht genähert werden.

  Für den in der Aufgabenstellung spezifizierten Spezialfall sind $Et_(1,3)$ wegen $E_1 < E_3$, d.h. $sqrt((E_1 - E_3)^2) = -(E_1 - E_3)$, gegeben durch
  $
    Et_(1,3) & = 1/2 (E_1 + E_3 plus.minus (E_1 - E_3) sqrt(1 + (4 |V|^2)/(E_1 - E_3)^2)) \
             & approx 1/2 (E_1 + E_3 plus.minus (E_1 - E_3) (1 + (2 |V|^2)/(E_1 - E_3)^2)) \
             & = 1/2 (E_1 + E_3 plus.minus (E_1 - E_3 + (2 |V|^2)/(E_1 - E_3)))
  $
  wobei die Näherung $sqrt(1 + x) approx 1 + x/2$ für kleine $x$ verwendet wurde. Das bedeutet explizit
  $ Et_1 approx E_1 + (|V|^2)/(E_1 - E_3) #h(3em) Et_3 approx E_3 - (|V|^2)/(E_1 - E_3). $
  Hierbei ist $E_1 - E_3 < 0$, sodass der Zustand $E_3$ durch die Kopplung angehoben und $E_1$ abgesenkt wird. Die Energien der beiden gekoppelten Niveaus haben sich also weiter voneinander entfernt.

  #figure(
    canvas(length: 1cm, {
      import draw: *
      let (w, h) = (2.2, 5.6)
      rect((0, 0), (w, h), fill: rgb("#c6dcf5"), stroke: none)
      rect((w, 0), (2 * w, h), fill: rgb("#c9eac0"), stroke: none)
      line((w, 0), (w, h), stroke: (dash: "dotted", thickness: 0.6pt))
      line((0, 0), (0, h + 0.4), mark: (end: "stealth"), stroke: 0.8pt)
      line((0, h), (2 * w, h), stroke: 0.8pt)
      content((0.1, h + 0.35), $E$, anchor: "west")
      content((-0.1, h), $0$, anchor: "east")
      content((w / 2, h - 0.8), $H0$)
      content((1.5 * w, h - 0.8), $Hh$)
      // unperturbed levels on the left, coupled ones on the right
      for (y-left, y-right, label, label-right) in ((3.7, 4.0, $E_3$, $Et_3$), (2.6, 2.6, $E_2$, $Et_2$), (0.6, 0.3, $E_1$, $Et_1$)) {
        line((0, y-left), (w, y-left), (w + 0.3, y-right), (2 * w, y-right), stroke: 0.9pt)
        content((-0.1, y-left), label, anchor: "east")
        content((2 * w + 0.1, y-right), label-right, anchor: "west")
      }
    }),
    caption: [Energieniveauschema des ungekoppelten Systems links und des gekoppelten Systems rechts#footnote[In dieser Skizze wurde verwendet, dass die Energieeigenwerte im Wasserstoffatom mit steigender Hauptquantenzahl $n$ (in immer kleineren Schritten) zunehmen und dass die Kopplungskorrektur kleiner ist, als die Energien des ungestörten Systems.]],
  )

+ #task[Vergleichen sie das Ergebnis mit der Störungsrechnung zweiter Ordnung aus der Präsenzübung. (3 Punkte)]

  Ein direkter Vergleich der Ausdrücke zeigt Ähnlichkeiten in den Störtermen auf:
  $ Et_1 approx E_1 + (|V|^2)/(E_1 - E_3) #h(3em) Et_3 approx E_3 - (|V|^2)/(E_1 - E_3). $ <eq:compare>
  $ E_(2,n) = sum_(m != n) (|braket(m_0, H1, n_0)|^2)/(E_(0,n) - E_(0,m)) $ <eq:second-order>
  Der Störoperator $H1$ verursacht nun eine Kopplung und kann mit $hat(V)$ identifiziert werden. Es fällt auf, dass die Energiekorrektur in allen Fällen durch das Betragsquadrat des Matrixelements dieses Operators zwischen den beiden Zuständen gegeben ist, geteilt durch die Differenz der Energien der beiden zu koppelnden ungestörten Zustände.

  Außerdem liefert die Summe über alle $m != n$ aus Gleichung @eq:second-order für das System dieser Aufgabenstellung nur einen nicht verschwindenden Term. Beispielweise wird für $bra(n_0) = bra(Psi_(1 s))$ über $bra(Psi_(2 s))$ und $bra(Psi_(2 p))$ summiert. Aber nur der Summand mit $bra(Psi_(2 p))$ gibt einen Beitrag, da der Kopplungsoperator nicht zwischen $bra(Psi_(2 s))$ und $bra(Psi_(1 s))$ wirkt.

  Das unterschiedliche Vorzeichen der beiden ansonsten gleichen Kopplungsterme in Gleichung @eq:compare entstammt der Differenz der Energieeigenwerte im Nenner.

= Dirac-Gleichung #pts(10)

#task[
  Die Dirac-Gleichung für ein freies Teilchen lautet
  $ i planck partial/(partial t) Psi(vb(r), t) = mat(m_0 c^2 one, -i c vb(sigma) nabla; -i c vb(sigma) nabla, -m_0 c^2 one) Psi(vb(r), t) $ <eq:dirac>
  und dient zur relativistischen Beschreibung von Spin-1/2-Teilchen. Die Wellenfunktion $Psi$ ist ein vierkomponentiger Vektor, $one$ ist die $2 times 2$-Einheitsmatrix und $sigma_i, i in {1, 2, 3}$ sind die Pauli-Matrizen.
]

+ #task[Zeigen sie, dass sich der zeitabhängige Anteil der Gleichung für positive Energien lösen lässt durch (2 Punkte)
    $ Psi_+ (vb(r), t) = Psi_+ (vb(r)) e^(-i E/planck t). $]

  Die linke Seite der Dirac-Gleichung angewandt auf den zeitabhängigen Anteil der Wellenfunktion liefert die Energie $E$ des freien Teilchens
  $ i planck partial/(partial t) e^(-i E/planck t) = E thin e^(-i E/planck t) $ <eq:time>
  Auf der rechten Seite stehen keinerlei Operatoren, die auf die Zeitabhängigkeit $e^(-i E/planck t) != 0 quad forall t$ der Wellenfunktion wirken, sodass nach @eq:time durch diesen Faktor geteilt werden kann. Es folgt
  $ E Psi_+ (vb(r)) = mat(m_0 c^2 one, -i c vb(sigma) nabla; -i c vb(sigma) nabla, -m_0 c^2 one) Psi_+ (vb(r)) $
  Die Zeitabhängigkeit der Dirac-Gleichung des freien Teilchens konnte also einfach durch einen Separationsansatz gelöst werden.

+ #task[Lösen sie die Dirac-Gleichung für positive Energien mit Hilfe des Ansatzes
    $ Psi_+ (vb(r), t) = N e^(i (vb(p) vb(r) - E/planck t)) vec(phi.alt, chi), $ <eq:ansatz>
    wobei $N$ eine Normierungskonstante ist und $phi.alt$, $chi$ konstante Zweiervektoren sind. Bestimmen sie die Eigenwerte $E_p$ der Dirac-Gleichung. Benutzen sie die Relation $(vb(sigma) vb(p))^2 = vb(p)^2$. (4 Punkte)]

  Einsetzen von @eq:ansatz in die Dirac-Gleichung @eq:dirac ergibt
  $ E N e^(i (vb(p) vb(r) - E/planck t)) vec(phi.alt, chi) = N e^(i (vb(p) vb(r) - E/planck t)) mat(m_0 c^2 one, c vb(sigma) vb(p); c vb(sigma) vb(p), -m_0 c^2 one) vec(phi.alt, chi) $
  Dies ist ein System aus vier gekoppelten Gleichungen. Zur Vereinfachung können die Normierungskonstante und die komplexe Exponentialfunktion direkt gekürzt werden.
  $ E phi.alt = m_0 c^2 one phi.alt + c vb(sigma) vb(p) chi = m_0 c^2 phi.alt + c vb(sigma) vb(p) chi $ <eq:upper>
  $ E chi = c vb(sigma) vb(p) phi.alt - m_0 c^2 one chi = c vb(sigma) vb(p) phi.alt - m_0 c^2 chi $ <eq:lower>
  Gleichung @eq:lower aufgelöst nach $chi$ liefert den Ausdruck
  $ chi = (c vb(sigma) vb(p))/(E + m_0 c^2) phi.alt $
  Dies setzt man zurück in Gleichung @eq:upper ein und erhält die relativistisch invariante Energie-Impuls-Relation
  $
    & E phi.alt = m_0 c^2 phi.alt + c vb(sigma) vb(p) (c vb(sigma) vb(p))/(E + m_0 c^2) phi.alt \
    <=> quad & (E - m_0 c^2)(E + m_0 c^2) phi.alt = c^2 vb(sigma)^2 vb(p)^2 phi.alt = c^2 vb(p)^2 phi.alt \
    <=> quad & E^2 = m_0^2 c^4 + c^2 vb(p)^2
  $

+ #task[Bestimmen sie für $vb(p) = (0, 0, p)^T$ die vierkomponentigen Eigenvektoren zu $phi.alt_up = vec(1, 0)$ sowie zu $phi.alt_dn = vec(0, 1)$. (3 Punkte)]

  Für den Fall $vb(p) = (0, 0, p)^T$ und $phi.alt_up$ lauten die Gleichungen @eq:upper und @eq:lower:
  $ E vec(1, 0) = m_0 c^2 vec(1, 0) + c sigma_3 p vec(chi_up, chi_dn) $ <eq:up-upper>
  $ E vec(chi_up, chi_dn) = c sigma_3 p vec(1, 0) - m_0 c^2 vec(chi_up, chi_dn) $ <eq:up-lower>
  Mit $sigma_3 = mat(1, 0; 0, -1)$ folgt aus @eq:up-upper sofort $chi_dn = 0$ und aus @eq:up-lower $chi_up = (c p)/(E + m_0 c^2)$. Entsprechendes gilt für $vb(p) = (0, 0, p)^T$ und $phi.alt_dn$:
  $ E vec(0, 1) = m_0 c^2 vec(0, 1) + c sigma_3 p vec(chi_up, chi_dn) $ <eq:dn-upper>
  $ E vec(chi_up, chi_dn) = c sigma_3 p vec(0, 1) - m_0 c^2 vec(chi_up, chi_dn) $ <eq:dn-lower>
  Hier ist wegen @eq:dn-upper offenbar $chi_up = 0$ und wegen @eq:dn-lower muss $chi_dn = -(c p)/(E + m_0 c^2)$ sein. Die vollständigen Eigenvektoren lauten somit:
  $
    phi.alt_up: quad & Psi_+ (vb(r), t) = N e^(i (vb(p) vb(r) - E/planck t)) (1, 0, (c p)/(E + m_0 c^2), 0)^T \
    phi.alt_dn: quad & Psi_+ (vb(r), t) = N e^(i (vb(p) vb(r) - E/planck t)) (0, 1, 0, -(c p)/(E + m_0 c^2))^T
  $

+ #task[Berechnen sie das Verhältnis zwischen großen und kleinen Komponenten aus c) für den nicht-relativistischen Grenzfall $c p << m_0 c^2$. (1 Punkt)]

  Das Verhältnis $|chi| \/ |phi.alt|$ beträgt in beiden Fällen ($phi.alt_up$ und $phi.alt_dn$)
  $ (|chi|)/(|phi.alt|) = (c p)/(E + m_0 c^2) = (c p)/(sqrt(m_0^2 c^4 + c^2 p^2) + m_0 c^2) approx p/(2 m_0 c) $
