#import "/notes.typ": dd, note, task, vb, unit, ket, braket
#import "/atomic-physics/sheet.typ": fig, sheet, pts
#import "@preview/cetz:0.5.2": canvas, draw

#show: sheet.with([Übungsblatt 3], [06.~Mai 2014])

#let ddt = $dif / (dif t)$
#let (H0, Wh, VHFS, Vmag) = ($hat(H)_0$, $hat(W)$, $hat(V)_"HFS"$, $hat(V)_"mag"$)
#let (bS1, bS2, bF, bB, bmu) = ($hat(vb(S))_1$, $hat(vb(S))_2$, $hat(vb(F))$, $vb(B)$, $vb(mu)$)
#let (Fz, S1z, S2z) = ($hat(F)_z$, $hat(S)_(1,z)$, $hat(S)_(2,z)$)
#let mup = $e^+\/mu^+$
#let mm = $m_(S_1), m_(S_2)$
#let ph(E) = $e^(-i #E / planck t)$
#let half = $1/2$

// === level diagrams ===
#let (blue, green) = (rgb("#c6dcf5"), rgb("#c9eac0"))
#let thin-line = 0.4pt
#let level = 0.9pt

// 1s_{1/2} line splitting (dotted) into the levels `mag` inside a blue V_mag box, optionally
// followed by a green V_HFS box with the shifted levels `hfs`; `labels` are (y, content) pairs
// placed right of the last box
#let pb-diagram(mag, hfs: none, labels: (), arrows: none) = canvas(length: 0.75cm, {
  import draw: *
  let (x0, w, gap) = (3.2, 2.4, 0.3)
  let span(ys) = (calc.min(..ys), calc.max(..ys))
  let (lo, hi) = span(mag)
  rect((x0, lo), (x0 + w, hi), fill: blue, stroke: none)
  line((0, 0), (2.4, 0), stroke: level)
  content((0.1, 0.1), $1 s_(1\/2)$, anchor: "south-west")
  for y in mag {
    line((2.4, 0), (x0, y), stroke: (dash: "dotted", thickness: 0.8pt))
    line((x0, y), (x0 + w, y), stroke: level)
  }
  if arrows == none {
    content((x0 + w / 2, (lo + hi) / 2 + 0.3), $V_"mag"$)
  } else {
    content((x0 + 0.15, hi - 0.15), $V_"mag"$, anchor: "north-west")
  }
  let x-end = x0 + w
  if hfs != none {
    let x1 = x0 + w + gap
    let (lo, hi) = span(hfs)
    rect((x1, lo), (x1 + w, hi), fill: green, stroke: none)
    for (y-mag, y) in mag.zip(hfs) {
      line((x0 + w, y-mag), (x1, y), stroke: (dash: "dotted", thickness: 0.8pt))
      line((x1, y), (x1 + w + 0.2, y), stroke: level)
    }
    content((x1 + w / 2, (lo + hi) / 2 - 0.3), $V_"HFS"$)
    x-end = x1 + w + 0.2
  }
  for (y, label) in labels {
    content((x-end + 0.15, y), text(size: 8pt, label), anchor: "west")
  }
  if arrows != none {
    let (x, ys, label) = arrows
    for (ya, yb) in ys.zip(ys.slice(1)) {
      line((x, ya), (x, yb), mark: (start: "stealth", end: "stealth", scale: 0.6), stroke: thin-line)
      content((x + 0.1, (ya + yb) / 2), text(size: 8pt, label), anchor: "west")
    }
  }
})

// hyperfine splitting of 1s_{1/2} into F = 1 (+1/4 A ħ²) and F = 0 (-3/4 A ħ²)
#let hfs-split(x-split, x-end, x-arrow, extent) = {
  import draw: *
  let (up, down) = (0.25 * extent, -0.75 * extent)
  line((0, 0), (x-split, 0), stroke: level)
  content((0.1, 0.1), $1 s_(1\/2)$, anchor: "south-west")
  line((x-split, 0), (x-end, 0), stroke: (dash: "dotted", thickness: thin-line))
  for (y, label, anchor) in ((up, $F = 1$, "south-west"), (down, $F = 0$, "north-west")) {
    line((x-split, 0), (x-split + 1, y), stroke: (dash: "dashed", thickness: 0.7pt))
    line((x-split + 1, y), (x-end, y), stroke: level)
    content((x-split + 1.1, y + if y > 0 { 0.05 } else { -0.05 }), label, anchor: anchor)
  }
  for (ya, yb, label) in ((0, up, $1/4 A planck^2$), (0, down, $-3/4 A planck^2$)) {
    line((x-arrow, ya), (x-arrow, yb), mark: (start: "stealth", end: "stealth", scale: 0.6), stroke: thin-line)
    content((x-arrow + 0.1, (ya + yb) / 2), text(size: 8pt, label), anchor: "west")
  }
  content(((x-split + 1 + x-arrow) / 2, down / 2), $V_"HFS"$)
}

#heading(numbering: none)[Präsenzaufgaben]

= Zeitabhängige Störungstheorie

#task[
  Diskutieren sie anhand der folgenden Aufgabe die Prinzipien der zeitabhängigen Störungstheorie. Es soll ein System mit Hamiltonoperator $H0$ mit diskreten Eigenwerten $E_n$ und Eigenvektoren $ket(phi.alt_n)$, d.h. $H0 ket(phi.alt_n) = E_n ket(phi.alt_n)$, betrachtet werden, das ab dem Zeitpunkt $t = 0$ durch eine zeitabhängige Störung $lambda Wh(t)$ mit $lambda << 1$ verändert wird. Für Zeiten $t > 0$ entwickelt sich das System also gemäß der Schrödingergleichung
  $ i planck ddt ket(Psi(t)) = [H0 + lambda Wh(t)] ket(Psi(t)), $
  wobei hier die Anfangsbedingung $ket(Psi(t = 0)) = ket(phi.alt_i)$ angenommen werden soll.

  Die Übergangswahrscheinlichkeit in einen Zustand $ket(phi.alt_f)$ ist dann gegeben durch $P_(i f) (t) = |braket(phi.alt_f, Psi(t))|^2$.
]

+ #task[Zeigen sie, dass in der Basis ${ket(phi.alt_n)}$, in der $ket(Psi(t)) = sum_n c_n (t) ket(phi.alt_n)$ und $W_(n k) (t) = braket(phi.alt_n, Wh(t), phi.alt_k)$ ist, die folgende Gleichung gilt
    $ i planck ddt c_n (t) = E_n c_n (t) + lambda sum_k W_(n k) (t) c_k (t) $ <eq:cn>]

  Der Ausdruck @eq:cn ergibt sich direkt aus der zeitabhängigen Schrödinger-Gleichung durch Multiplikation von links mit dem Bra-Vektor $chevron.l phi.alt_n|$, wenn man berücksichtigt, dass die Koeffizienten $c_n (t)$ des Eigenzustands in der Basis ${ket(phi.alt_n)}$ gegeben sind durch $braket(phi.alt_n, Psi(t))$:
  $
    i planck ddt braket(phi.alt_n, Psi(t)) & = braket(phi.alt_n, H0, Psi(t)) + lambda braket(phi.alt_n, Wh(t), Psi(t)) \
    & = braket(H0 phi.alt_n, Psi(t)) + lambda sum_k braket(phi.alt_n, Wh(t), phi.alt_k) braket(phi.alt_k, Psi(t)) \
    & = E_n c_n (t) + lambda sum_k W_(n k) (t) c_k (t)
  $ <eq:cn-derivation>

+ #task[Zeigen sie weiter, dass mithilfe der Ersetzung $c_n (t) = b_n (t) ph(E_n)$ und mit $omega_(n k) = (E_n - E_k)/planck$ folgt
    $ i planck ddt b_n (t) = lambda sum_k e^(i omega_(n k) t) W_(n k) (t) b_k (t) $]

  Für die linke Seite von Gleichung @eq:cn-derivation ergibt sich
  $ i planck ddt (b_n (t) ph(E_n)) = i planck dot(b)_n (t) ph(E_n) + E_n thin b_n (t) ph(E_n) $
  und für die rechte dementsprechend
  $ E_n b_n (t) ph(E_n) + lambda sum_k W_(n k) (t) b_k (t) ph(E_k). $
  Abziehen gleicher Terme und Multiplikation mit $e^(i E_n / planck t)$ liefert das gewünschte Ergebnis
  $
    i planck ddt b_n (t) & = lambda sum_k W_(n k) (t) b_k (t) e^(-i E_k / planck t) e^(i E_n / planck t) \
                         & = lambda sum_k W_(n k) (t) b_k (t) e^(i omega_(n k) t)
  $ <eq:bn>

+ #task[Expandieren sie die Funktionen $b_n (t)$ in eine Potenzreihe in $lambda$, d.h. $b_n (t) = b_(n,0) (t) + lambda b_(n,1) (t) + lambda^2 b_(n,2) (t) + ...$ mit Koeffizientenfunktionen $b_(n,j) (t)$ und finden sie eine Rekursionsformel für die $b_(n,j) (t)$.]

  Setzt man die Reihenentwicklung $b_n (t) = sum_(j=0)^infinity lambda^j b_(n,j) (t)$ in Gleichung @eq:bn ein, entsteht
  $ i planck ddt sum_(j=0)^infinity lambda^j b_(n,j) (t) = lambda sum_k W_(n k) (t) e^(i omega_(n k) t) sum_(j=0)^infinity lambda^j b_(k,j) (t) $ <eq:series>
  Diese Gleichung liefert einige Erkenntnisse durch einen Koeffizientenvergleich in $lambda$:
  / $lambda^0$: Ein Term ohne $lambda$ findet sich in Gleichung @eq:series nur auf der linken Seite. Daraus folgt zwangsläufig
    $ ddt b_(n,0) (t) = 0. $
    $b_(n,0)$ ist also zeitunabhängig.
  / $lambda^j$: Alle Terme mit höherer Potenz in $lambda$ haben dieselbe Struktur einer Rekursionsformel:
    $ i planck ddt b_(n,j) (t) = sum_k W_(n k) (t) e^(i omega_(n k) t) b_(k,j-1) (t) $ <eq:recursion>
    Hierbei wurde in Gleichung @eq:series das $lambda$ vor der Summe über $k$ mit in die Summe über $j$ gezogen und anschließend der Summationsindex um 1 erhöht.

    Mit Gleichung @eq:recursion ist es also möglich aus $b_(n,0)$ iterativ alle weiteren Entwicklungskoeffizienten $b_(n,j)$ durch Integration über die Zeit zu berechnen. $b_(n,0)$ ist durch die Anfangsbedingung eines Systems eindeutig bestimmt.

+ #task[Bestimmen sie den Zustand des Systems zur Zeit $t$ in erster Ordnung und geben sie die Übergangswahrscheinlichkeit $P_(i f) (t)$ (Fermis goldene Regel) an. Für den Anfangszustand $ket(Psi(t = 0)) = ket(phi.alt_i)$ zeige man für die Koeffizienten $b_(n,0) (t = 0) = delta_(n i)$ und $b_(n,j>0) (t = 0) = 0$.]

  Da die zeitabhängige Störung erst ab $t = 0$ auf das System wirkt, ist das System vor diesem Zeitpunkt ungestört und somit $b_n (t = 0) = b_(n,0) (t = 0)$ sowie $b_(n,j) (t = 0) = 0 thin forall j > 0$. $b_(n,0) (t = 0)$ lässt sich damit aus der Anfangsbedingung $ket(Psi(t = 0)) = ket(phi.alt_i)$ explizit berechnen:
  $
    b_(n,0) (t = 0) & = c_n (t = 0) e^(i E_n / planck dot 0) = braket(phi.alt_n, Psi(t = 0)) \
                    & = braket(phi.alt_n, phi.alt_i) = delta_(n i)
  $
  In Aufgabenteil *c)* wurde gezeigt, dass $b_(n,0)$ zeitunabhängig ist, sodass diese Gleichung auch für spätere Zeiten gilt. Aus der Rekursionsformel @eq:recursion folgt für $b_(n,1) (t)$
  $ i planck ddt b_(n,1) (t) = sum_k W_(n k) (t) e^(i omega_(n k) t) b_(k,0) (t) = W_(n i) (t) e^(i omega_(n i) t) $
  Zeitliche Integration dieses Ausdrucks ergibt
  $ b_(n,1) (t) = 1/(i planck) integral_0^t W_(n i) (t') e^(i omega_(n i) t') dd(t') $
  Der Zustand des gestörten Systems zur Zeit $t$ ist also nach zeitabhängiger Störungsrechnung bis zur ersten Ordnung in der Basis ${ket(phi.alt_n)}$ gegeben durch
  $
    ket(Psi(t)) & = sum_n c_n (t) ket(phi.alt_n) = sum_n b_n (t) ph(E_n) ket(phi.alt_n) \
                & approx sum_n [b_(n,0) + lambda b_(n,1) (t)] ph(E_n) ket(phi.alt_n) \
                & = ph(E_i) ket(phi.alt_i) + lambda/(i planck) sum_n (integral_0^t W_(n i) (t') e^(i omega_(n i) t') dd(t')) ph(E_n) ket(phi.alt_n)
  $
  Dieser Ausdruck ist nicht normiert. Nun soll noch die Übergangswahrscheinlichkeit $P_(i f) (t)$ berechnet werden, wobei von $i != f$ ausgegangen wird, da sonst kein Übergang stattfindet. Es gilt deshalb $braket(phi.alt_i, phi.alt_f) = 0$, da die ${ket(phi.alt_n)}$ als Eigenzustände eines Hamilton-Operators orthogonal sind.
  $
    P_(i f) (t) & = |braket(phi.alt_f, Psi(t))|^2 = |braket(phi.alt_f, ph(E_i), phi.alt_i) + lambda/(i planck) sum_n (integral_0^t W_(n i) (t') e^(i omega_(n i) t') dd(t')) ph(E_n) braket(phi.alt_f, phi.alt_n)|^2 \
                & = |lambda/(i planck) integral_0^t W_(f i) (t') e^(i omega_(f i) t') dd(t') ph(E_f)|^2 \
                & = 1/planck^2 |integral_0^t braket(phi.alt_f, lambda Wh(t'), phi.alt_i) e^(i omega_(f i) t') dd(t')|^2
  $

#heading(numbering: none)[Übungsaufgaben]

#heading(numbering: none)[Zeeman- und Paschen-Back-Effekt im Grundzustand von Positronium und Myonium]
#counter(heading).update(0)

#task[
  Betrachtet wird die Aufspaltung des Grundzustandes von Positronium und Myonium unter Berücksichtigung der Hyperfeinwechselwirkung und der Wechselwirkung des Systems mit einem äußeren Magnetfeld $bB = (0, 0, B_0)^T$. Diese exotischen Atome setzen sich wie folgt zusammen:
  - Das Positronium besteht aus einem Elektron $e^-$ und einem Positron $e^+$ (Ladung $q = +e$, Masse $m_(e^+) = m_e$, Spin $s = 1/2$).
  - Das Myonium besteht aus einem Elektron und einem Antimyon $mu^+$ (Ladung $q = +e$, Masse $m_(mu^+) approx 207 m_e$, Spin $s = 1/2$).
  Der Elektronenspin werde mit $bS1$, der des Positrons bzw. Antimyons mit $bS2$ bezeichnet. Das magnetische Moment des Elektrons ist dann durch $bmu_e = gamma_1 bS1$, das des Positrons und Antimyons durch $bmu_mup = gamma_2 bS2$ gegeben. Hierbei bezeichnet $gamma_i$ das gyromagnetische Verhältnis des jeweiligen Teilchens, welches sich wie folgt zusammensetzt aus dessen Landé-Faktor $g_i$ und seinem Magneton $mu_i$:
  $ gamma_i = g_i mu_i / planck wide "mit" mu_i = (q_i planck)/(2 m_i) $
  Für das Elektron gilt somit
  $ gamma_1 = g_(e^-) (-e)/(2 m_(e^-)) = g_(e^-) (-mu_B)/planck $
  und für Positron bzw. Antimyon
  $ gamma_2 = g_mup e/(2 m_mup) = g_mup m_(e^-)/m_mup mu_B / planck $
  mit $g_(e^-) approx -2$ und $g_mup approx 2$. Da sich sowohl Landé-Faktoren als auch die Magnetone von Elektron und Positron im Vorzeichen unterscheiden, haben beide Teilchen das gleiche gyromagnetische Verhältnis.
]

#note(label: [Anmerkung:])[Die Aufgabenstellung zählt das Vorzeichen der Elektronladung doppelt: Mit $gamma_i = g_i q_i \/ (2 m_i)$ ist $g_(e^-) approx +2$, denn das magnetische Moment des Elektrons ist antiparallel zu seinem Spin, das des Positrons bzw. Antimyons parallel. Es gilt also $gamma_1 = -g_s mu_B \/ planck approx -2 mu_B \/ planck$ und $gamma_(e^+) = -gamma_(e^-)$. Die folgende Lösung verwendet diese physikalisch korrekten Vorzeichen.]

= Zeeman-Effekt #pts(12)

#figure(
  fig("sheet-03-zeeman-hydrogen", width: 55%),
  caption: [Aufspaltungen der Wasserstoffniveaus unter Einfluss eines Magnetfeldes. [Wikipedia -- Zeeman-Effekt]],
)

#task[
  Zunächst soll die Struktur des Grundzustandes unter Einfluß der Hyperfeinwechselwirkung $VHFS = A thin bS1 dot bS2$ und eines schwachen Magnetfeldes $bB = (0, 0, B_0)^T$ betrachtet werden. Schwach bedeutet in diesem Fall, dass die Wechselwirkungsenergie der magnetischen Momente von Elektron und Positron/Antimyon mit dem äußeren Magnetfeld klein ist gegenüber der Hyperfeinwechselwirkungsenergie.
]

+ #task[Es sei $bF = bS1 + bS2$ der Gesamtspin des Systems. Vernachlässigen sie zunächst den Einfluss des äußeren Magnetfeldes und geben sie einen Ausdruck für den Energieabstand zwischen den Hyperfeinstrukturkomponenten des Grundzustands $1 s_(1\/2)$ an. Skizzieren sie die Hyperfeinstrukturaufspaltung. (4 Punkte)]

  Für die Berechnung der Energieaufspaltung bedient man sich einer der wichtigsten Methoden der quantenmechanischen Drehimpulsalgebra:
  $ bF^2 = bS1^2 + bS2^2 + 2 bS1 bS2 quad => quad bS1 bS2 = 1/2 (bF^2 - bS1^2 - bS2^2) $
  Daraus ergibt sich für die Wechselwirkungsenergie
  $ VHFS = A thin bS1 dot bS2 = A/2 (bF^2 - bS1^2 - bS2^2) $ <eq:hfs>
  Für dieses System bietet sich der Satz $bF^2$, $bS1^2$, $bS2^2$, $Fz$ kommutierender Observablen mit gemeinsamen Eigenzuständen $ket(F\, m_F)$ an. Gleichung @eq:hfs angewendet auf solch einen gemeinsamen Eigenzustand lautet
  $
    VHFS ket(F\, m_F) & = A/2 (bF^2 - bS1^2 - bS2^2) ket(F\, m_F) \
                      & = (A planck^2)/2 (F (F + 1) - S_1 (S_1 + 1) - S_2 (S_2 + 1)) ket(F\, m_F)
  $
  Die Gesamtspinquantenzahl $F$ eines Zweiteilchensystems bestehend aus den Spins $bS1$ und $bS2$ kann ganzzahlige Werte aus der Menge ${|S_1 - S_2|, ..., S_1 + S_2}$ annehmen. In diesem Fall sind die Einstellungen $F = 1/2 - 1/2 = 0$ und $F = 1/2 + 1/2 = 1$ möglich. Der Energieabstand benachbarter Hyperfeinstrukturkomponenten beträgt
  $
    Delta E_(F+1,F) & = braket(F + 1\, m_F, VHFS, F + 1\, m_F) - braket(F\, m_F, VHFS, F\, m_F) \
                    & = (A planck^2)/2 ((F + 1)(F + 2) - F (F + 1)) \
                    & = (A planck^2)/2 (F + 1)(F + 2 - F) = underline(underline(A planck^2 (F + 1)))
  $
  Die Energiedifferenz benachbarter Hyperfeinstrukturkomponenten hängt also linear von der Gesamtspinquantenzahl ab, wobei $F$ hier stets auf den unteren der beiden betrachteten Zustände bezogen ist. Für Positronium und Myonium ist demnach $F = 0$, sodass man eine Energiedifferenz der Hyperfeinstrukturkomponenten von $Delta E_(1,0) = A planck^2$ erwarten würde.

  Dieses Ergebnis deckt sich mit den tatsächlichen Energiekorrekturen beider Systeme
  $ VHFS ket(0\, 0) = (A planck^2)/2 (0 - 3/4 - 3/4) ket(0\, 0) = -(3 A planck^2)/4 ket(0\, 0) $
  $ VHFS ket(1\, m_F) = (A planck^2)/2 (2 - 3/4 - 3/4) ket(1\, m_F) = (A planck^2)/4 ket(1\, m_F), $ <eq:hfs-triplet>
  wobei in Gleichung @eq:hfs-triplet $m_F$ die Einstellungen ${-1, 0, 1}$ haben kann. Der $F = 1$ Zustand ist also dreifach entartet. Die Korrektur wirkt auf den Zustand $F = 0$ allerdings auch dreimal stärker, sodass die Aufspaltung in @fig:hfs insgesamt die Summenregel erfüllt, d.h. der $1 s_(1\/2)$-Linienschwerpunkt bleibt unverändert.

  #figure(
    canvas(length: 0.75cm, hfs-split(3.5, 7.6, 7.6, 3.2)),
    caption: [Hyperfeinstrukturaufspaltung durch Wechselwirkung der Spins in Positronium bzw. Myonium],
  ) <fig:hfs>

+ #task[Nun wird das schwache Magnetfeld als kleine Störung hinzugenommen. Da das Magnetfeld schwach ist, kann die Wechselwirkungsenergie des Systems mit dem äußeren Magnetfeld durch ein effektives magnetisches Moment
    $ hat(bmu)_"eff" = ((bmu_e + bmu_mup) bF)/(|bF|) dot bF/(|bF|) $
    beschrieben werden: $V_"mag" = -hat(bmu)_"eff" dot bB$ Diese Energie soll als Störung der Hyperfeinstruktur betrachtet werden. Zeigen sie, dass die Aufspaltung der Hyperfeinstrukturkomponenten in ihre Zeeman-Niveaus durch
    $ Delta E_"Zee" (F, m_F) = planck/2 (gamma_1 + gamma_2) m_F B_0 $
    gegeben ist. Skizzieren sie die Zeeman-Aufspaltung der Hyperfeinstruktur des Grundzustands beider Systeme. (6 Punkte)]

  Der allgemeine Ausdruck für die Wechselwirkungsenergie $Vmag$ mit dem Magnetfeld kann für ein Feld nur in $z$-Richtung $bB = (0, 0, B_0)^T$ spezialisiert werden
  $
    Vmag & = -hat(bmu)_"eff" dot bB = -((bmu_e + bmu_mup) bF)/(|bF|^2) Fz B_0 \
         & = -(gamma_1 bS1 + gamma_2 bS2)(bS1 + bS2) (Fz B_0)/(|bF|^2) \
         & = -(gamma_1 bS1^2 + gamma_1 bS1 bS2 + gamma_2 bS2 bS1 + gamma_2 bS2^2) (Fz B_0)/(|bF|^2) \
         & = -(gamma_1 bS1^2 + gamma_1/2 (bF^2 - bS1^2 - bS2^2) + gamma_2/2 (bF^2 - bS2^2 - bS1^2) + gamma_2 bS2^2) (Fz B_0)/(|bF|^2) \
         & limits(=)^#footnote[In diesem Schritt wurde bereits ausgenutzt, dass $bS1^2$ und $bS2^2$ angewandt auf Eigenzustände $ket(F\, m_F)$ denselben Wert liefern, um Papier zu sparen.] -1/2 (gamma_1 + gamma_2) bF^2 (Fz B_0)/(|bF|^2) = -1/2 (gamma_1 + gamma_2) Fz B_0
  $
  Die Aufspaltung der Hyperfeinstrukturkomponenten in ihre Zeeman-Niveaus erhält man nun durch Bildung des Erwartungswert des Wechselwirkungsoperator
  $
    Delta E_"Zee" (F, m_F) & = braket(F\, m_F, Vmag, F\, m_F) \
                           & = -1/2 (gamma_1 + gamma_2) B_0 braket(F\, m_F, Fz, F\, m_F) = -planck/2 (gamma_1 + gamma_2) m_F B_0
  $
  Das Vorzeichen in der Aufgabenstellung ist also zu korrigieren.
  Das gyromagnetische Verhältnis $gamma = g mu/planck = g q/(2 m)$ setzt sich zusammen aus dem Landé-Faktor $g$, der Ladung $q$ und der Masse $m$ eines Teilchens. Da sich Elektron und Positron nur im Vorzeichen der Ladung unterscheiden, ist $gamma_(e^+) = -gamma_(e^-)$. Die Zeeman-Aufspaltung des Positroniums verschwindet somit in dieser Ordnung:
  $ Delta E_("Zee,Pos") (m_F) = -planck/2 (gamma_(e^-) + gamma_(e^+)) m_F B_0 = 0 $
  Die magnetischen Momente von Elektron und Positron heben sich im Zustand $ket(F\, m_F)$ im Mittel gerade auf. (In höherer Ordnung mischt das Magnetfeld die Zustände $ket(1\, 0)$ und $ket(0\, 0)$, was zu einer quadratischen Verschiebung führt.)
  Für das Myonium gilt mit $gamma_1 = -g_s mu_B \/ planck$ wegen $m_e << m_(mu^+)$ näherungsweise
  $
    Delta E_("Zee,Myo") & = planck/2 ((g_s mu_B)/planck - m_e/m_(mu^+) (g_(mu^+) mu_B)/planck) m_F B_0 \
                        & approx planck/2 (g_s mu_B)/planck m_F B_0 approx mu_B thin m_F thin B_0.
  $ <eq:zeeman-myo>
  Der Zeeman-Effekt führt im Myonium also zu einer $2 F + 1$-fachen Aufspaltung jedes Hyperfeinstrukturniveaus. Der Grad der Aufspaltung hängt nur vom Magnetfeld und von der Magnetquantenzahl ab, was die Namensgebung letzterer erklärt. @fig:zeeman zeigt die Zeeman-Aufspaltung der verschiedenen Hyperfeinstrukturkomponenten von Myonium.

  #figure(
    canvas(length: 0.75cm, {
      import draw: *
      let (axis, top, b0, x-end) = (7.2, 0.6, 10.2, 11.4)
      hfs-split(2.2, x-end, 5, 2.4)
      line((axis, -2.4), (axis, 2.1), mark: (end: "stealth"), stroke: 0.6pt)
      line((axis - 0.2, -2.6), (x-end + 0.3, -2.6), mark: (end: "stealth"), stroke: 0.6pt)
      content((axis + 0.1, 2), $Delta E_"Zeeman"$, anchor: "north-west")
      content((x-end + 0.3, -2.7), $B$, anchor: "north")
      content((b0, -2.7), $B_0$, anchor: "north")
      // Zeeman fan of the F = 1 level
      for (dy, label) in ((1, $m_F = 1$), (0, $m_F = 0$), (-1, $m_F = -1$)) {
        line((axis, top), (x-end, top + dy), stroke: level)
        content((x-end + 0.1, top + dy), text(size: 8pt, label), anchor: "west")
      }
      let slope = 1 / (x-end - axis)
      let dy = slope * (b0 - axis)
      line((b0, -2.6), (b0, top - dy), stroke: (dash: "dotted", thickness: thin-line))
      for (ya, yb) in ((top, top + dy), (top - dy, top)) {
        line((b0, ya), (b0, yb), mark: (start: "stealth", end: "stealth", scale: 0.5), stroke: thin-line)
      }
      content((b0 + 0.1, top + dy / 2), text(size: 8pt, $mu_B B_0$), anchor: "west")
      content((axis + 1.6, -0.8), $V_"mag"$)
    }),
    caption: [Zeemanaufspaltung im Myonium. Im Positronium tritt keine lineare Zeeman-Aufspaltung auf.],
  ) <fig:zeeman>

+ #task[Schätzen sie für Myonium einen Magnetfeldbereich ab, in dem das Magnetfeld als schwach bezeichnet werden kann. Verwenden sie hierzu das Kriterium, dass der Energieabstand zwischen zwei Zeeman-Komponenten des Myoniums um den Faktor 10 kleiner sein soll als der Energieabstand zwischen zwei Hyperfeinstrukturkomponenten des Grundzustands von Myonium (für Myonium gilt $Delta E_"HFS" = 2","8 dot 10^10 planck\/upright(s) = 2","95 dot 10^(-24) unit("J")$. (2 Punkte)]

  Das Kriterium wird hier auf die Zeeman-Komponenten des $F = 1$ Zustands angewandt, da $F = 0$ nicht aufspaltet. Der Abstand zwischen den Hyperfeinstrukturkomponenten des Grundzustands von Myonium beträgt laut Aufgabenstellung $Delta E_"HFS" = 2","95 dot 10^(-24) unit("J")$ und soll um den Faktor 10 größer sein, als der Abstand zwischen den Zeeman-Komponenten. Setzt man diese Bedingung in die Näherung aus Gleichung @eq:zeeman-myo ein, erhält man folgende magnetische Flussdichte
  $
    Delta E_"HFS" = 2","95 dot 10^(-24) unit("J") & limits(>)^! 10 Delta E_"Zeeman" \
    => quad B_0 = (Delta E_"Zeeman")/mu_B & < underline(underline(0","032 unit("T")))
  $

= Paschen-Back-Effekt #pts(8)

#task[Wird ein genügend starkes Magnetfeld angelegt, so ist die Hyperfeinwechselwirkungsenergie $VHFS = A bS1 dot bS2$ wesentlich kleiner als die Wechselwirkungsenergie der magnetischen Momente von Elektron und Positron bzw. Antimyon mit dem äußeren Magnetfeld $Vmag = -(bmu_e + bmu_mup) dot bB$. Dieses Magnetfeldregime bezeichnet man als Paschen-Back-Regime.]

+ #task[Vernachlässigen sie zunächst die Hyperfeinwechselwirkung gegenüber der Wechselwirkung des Systems mit dem äußeren Magnetfeld. Geben sie einen Ausdruck für die Aufspaltung des Grundzustands $1 s_(1\/2)$ unter dem Einfluß von $Vmag$ an. Berechnen sie also
    $ Delta E_B = braket(mm, Vmag, mm). $
    Skizzieren sie die Aufspaltung sowohl für Positronium als auch für Myonium. (4 Punkte)]

  Der magnetische Wechselwirkungsoperator $Vmag$ kann für ein Magnetfeld nur in $z$-Richtung wieder deutlich vereinfacht werden
  $
    Vmag & = -(bmu_e + bmu_mup) dot bB = -(gamma_1 bS1 + gamma_2 bS2) dot bB \
         & = -(gamma_1 S1z + gamma_2 S2z) dot B_0
  $
  $Delta E_"B"$ berechnet sich somit einfach aus Anwendung der Spinoperatoren auf ihre Eigenfunktionen:
  $
    Delta E_"B" & = -braket(mm, (gamma_1 S1z + gamma_2 S2z) dot B_0, mm) \
                & = -planck (m_(S_1) gamma_1 + m_(S_2) gamma_2) dot B_0
  $
  Hierbei gelten die Eigenwertgleichungen $S1z ket(mm) = planck m_(S_1) ket(mm)$ und $S2z ket(mm) = planck m_(S_2) ket(mm)$. Da es sich bei Elektron, Positron und Antimyon um Spin-$1/2$-Teilchen handelt, kann die magnetische Spinquantenzahl lediglich die Werte $plus.minus 1/2$ annehmen. Der Grundzustand $1 s_(1\/2)$ wird somit im Allgemeinen vierfach aufgespalten, je nach Ausrichtung der Spinvektoren des jeweiligen gebundenen Systems.
  $
    Delta E_("B",1) & = -planck/2 (gamma_1 + gamma_2) B_0 & quad & "für" m_(S_1) = m_(S_2) = half \
    Delta E_("B",2) & = -planck/2 (gamma_1 - gamma_2) B_0 && "für" m_(S_1) = half, m_(S_2) = -half \
    Delta E_("B",3) & = -planck/2 (-gamma_1 + gamma_2) B_0 && "für" m_(S_1) = -half, m_(S_2) = half \
    Delta E_("B",4) & = -planck/2 (-gamma_1 - gamma_2) B_0 && "für" m_(S_1) = m_(S_2) = -half
  $
  Für das Positronium gilt wieder $gamma_1 = gamma_(e^-) = -gamma_(e^+) = -gamma_2$, sodass hier $Delta E_("B",1) = Delta E_("B",4) = 0$ ist. Für die beiden Fälle mit entlang der Quantisierungsachse antiparallel ausgerichteten Spins gilt
  $ Delta E_("B",2) = -planck gamma_(e^-) B_0 approx 2 mu_B B_0 = -Delta E_("B",3) $

  #let m-labels(..pairs) = pairs.pos().map(((y, a, b)) => (y, $m_(s_1) = #a, m_(s_2) = #b$))
  #figure(
    pb-diagram(
      (1.4, 0, -1.4),
      labels: m-labels((1.4, $1\/2$, $-1\/2$), (-1.4, $-1\/2$, $1\/2$)) + ((0, $m_(s_1) = m_(s_2)$),),
      arrows: (4.6, (1.4, 0, -1.4), $2 mu_B B_0$),
    ),
    caption: [Paschen-Back-Effekt im Positronium#footnote[$m$ bezeichnet hier nach wie vor die magnetische Spinquantenzahl und sollte nicht etwa mit der Teilchenmasse verwechselt werden.]],
  )

  Im Myonium sind die gyromagnetischen Verhältnisse von Elektron und Antimyon verknüpft über
  $
    gamma_2 = gamma_(mu^+) & = g_(mu^+) e/(2 m_(mu^+)) = g_(mu^+) m_(e^-)/m_(mu^+) mu_B / planck \
                           & limits(approx)^#footnote[Die Ungenauigkeit kommt daher, dass $g_(mu^+)$ nur ungefähr gleich $g_(e^-)$ ist.] -m_(e^-)/m_(mu^+) gamma_(e^-) = -m_(e^-)/m_(mu^+) gamma_1,
  $
  mit $m_e \/ m_(mu^+) approx 0","0048$. Es ergeben sich für Myonium also vier Aufspaltungen des $1 s_(1\/2)$-Grundzustands, wobei $Delta E_("B",1)$ eine geringfügig schwächere positive Korrektur als $Delta E_("B",2)$ darstellt und ebenso $Delta E_("B",4)$ eine etwas schwächere negative Korrektur als $Delta E_("B",3)$ beschreibt.
  $
    Delta E_("B",1) & = -planck/2 gamma_1 (1 - m_(e^-)/m_(mu^+)) B_0 & quad & "für" m_(S_1) = m_(S_2) = half \
    Delta E_("B",2) & = -planck/2 gamma_1 (1 + m_(e^-)/m_(mu^+)) B_0 && "für" m_(S_1) = half, m_(S_2) = -half \
    Delta E_("B",3) & = -planck/2 gamma_1 (-1 - m_(e^-)/m_(mu^+)) B_0 && "für" m_(S_1) = -half, m_(S_2) = half \
    Delta E_("B",4) & = -planck/2 gamma_1 (-1 + m_(e^-)/m_(mu^+)) B_0 && "für" m_(S_1) = m_(S_2) = -half
  $
  #let myo-labels(ys) = m-labels(
    (ys.at(0), $1\/2$, $-1\/2$),
    (ys.at(1), $1\/2$, $1\/2$),
    (ys.at(2), $-1\/2$, $-1\/2$),
    (ys.at(3), $-1\/2$, $1\/2$),
  )
  #figure(
    pb-diagram((1.4, 1.1, -1.1, -1.4), labels: myo-labels((1.65, 1.0, -1.0, -1.65))),
    caption: [Paschen-Back-Effekt im Myonium],
  )

+ #task[Berücksichtigen sie nun den Einfluss von $VHFS$ auf die in *a)* berechneten Unterzustände. Behandeln sie hierzu $VHFS$ als kleine Störung auf die Unterzustände und berechnen sie die Energiekorrektur
    $ Delta E_"HFS" = braket(mm, VHFS, mm). $
    Verwenden sie hierzu die folgende Identität für den Operator $bS1 dot bS2$ zusammengesetzt aus den Spinoperatoren der Systemkomponenten
    $
      & braket(mm, bS1 dot bS2, mm) \
      & = chevron.l mm|S1z S2z + 1/2 (hat(S)_(1,+) hat(S)_(2,-) + hat(S)_(1,-) hat(S)_(2,+)) |mm chevron.r \
      & = braket(mm, S1z S2z, mm)
    $
    Skizzieren sie die sich daraus ergebende Korrektur der Energieniveaus aus Aufgabenteil *a)*. (4 Punkte)]

  Die Korrekturen auf die Energieniveaus des Paschen-Back-Regimes ergeben sich leicht mithilfe der in der Aufgabenstellung gegebenen Identität:
  $ Delta E_"HFS" = A braket(mm, S1z S2z, mm) = A planck^2 m_(S_1) m_(S_2) $
  Aus diesem Ausdruck wird ersichtlich, dass Zustände mit gleichem Vorzeichen in der magnetischen Spinquantenzahl energetisch angehoben werden, während solche mit umgekehrtem Vorzeichen nach unten korrigiert werden. Das entspricht der Erwartung, dass ein Zweiteilchensystem mit parallel ausgerichteten Spins#footnote[Genauer: Projektion des Spinvektors entlang der Quantisierungsachse] eine höhere Energie aufweist, als eines mit antiparallelen Spinvektoren.

  Für das Positronium bedeutet es, dass die beiden außen liegenden Paschen-Back-Aufspaltungen (antiparallele Spins) energetisch um $A planck^2 \/ 4$ abgesenkt werden, während die zwei inneren um $A planck^2 \/ 4$ angehoben werden.

  #figure(
    pb-diagram(
      (1.4, 0, -1.4),
      hfs: (1.1, 0.5, -1.7),
      labels: m-labels((1.1, $1\/2$, $-1\/2$), (-1.7, $-1\/2$, $1\/2$)) + ((0.5, $m_(s_1) = m_(s_2)$),),
    ),
    caption: [Paschen-Back-Regime von Positronium mit Hyperfeinstrukturkorrekturen],
  )

  Beim Myonium treten Korrekturen desselben Betrags auf. Hier findet allerdings eine Annäherung der beiden oberen Aufspaltungen $Delta E_("B",2)$ und $Delta E_("B",1)$ statt, während die unteren Aufspaltungen sich in der Hyperfeinstruktur weiter aufspalten, wie in @fig:myo-hfs skizziert.

  #figure(
    pb-diagram((1.4, 1.1, -1.1, -1.4), hfs: (1.3, 1.2, -0.8, -1.7), labels: myo-labels((1.55, 1.05, -0.8, -1.75))),
    caption: [Paschen-Back-Regime von Myonium mit Hyperfeinstrukturkorrekturen],
  ) <fig:myo-hfs>
