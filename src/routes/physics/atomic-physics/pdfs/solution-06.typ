#import "/notes.typ": task, vb, unit
#import "/atomic-physics/sheet.typ": fig, sheet, pts
#import "@preview/cetz:0.5.2": canvas, draw

#show: sheet.with([Übungsblatt 6], [27.~Mai 2014])

#let Rb = $attach(upright("Rb"), tl: 85, bl: 37)$
#let (bmu, bB, bF) = ($vb(mu)$, $vb(B)$, $vb(F)$)

// |B(r)| along one axis through the trap centre
#let field-profile(curve, label) = canvas(length: 1cm, {
  import draw: *
  line((-1.6, 0), (1.6, 0), mark: (end: "stealth", fill: black, scale: 0.5), stroke: 0.5pt)
  line((0, 0), (0, 2), mark: (end: "stealth", fill: black, scale: 0.5), stroke: 0.5pt)
  content((1.75, 0), $r$)
  content((0, 2.25), $|arrow(B)(arrow(r))|$)
  content((0, -0.25), $0$)
  curve
  if label != none { content((0.32, 0.2), label) }
})

#heading(numbering: none)[Präsenzaufgaben]

= Magnetische Falle für Rubidium

#task[$Rb$ ist ein Alkaliatom und hat einen Kernspin von $I = 5\/2$, $g_(F=2) = -1\/3$ und $g_(F=3) = 1\/3$. Es gilt $mu_B approx "1,5" unit("h MHz/G")$ und $k approx 20 unit("h GHz/K")$.]

#task(label: "a")[Skizzieren sie das Funktionsprinzip einer magnetischen Falle.]

Die magnetische Falle ist ein Apparat zum Einfangen neutraler Teilchen - meist Atome - mit einem magnetischen Moment. Aufgrund der weiten Verbreitung magnetischer Momente unter Atomen und Molekülen ist sie vielseitig einsetzbar. Sie hat allerdings den Nachteil, dass die festzuhaltenden Teilchen stets stark vorgekühlt werden müssen, da ausreichend starke Feldgradienten zur Bindung der Brownschen Bewegungen von Atomen bei Raumtemperatur mit Magnetfeldern nicht realisierbar sind.

#figure(
  grid(
    columns: 2,
    column-gutter: 3em,
    field-profile(draw.line((-1.4, 1.6), (0, 0), (1.4, 1.6), stroke: (dash: "dashed", thickness: 0.6pt)), none),
    field-profile(
      draw.catmull((-1.3, 1.75), (-0.65, 0.75), (0, 0.45), (0.65, 0.75), (1.3, 1.75), stroke: (dash: "dashed", thickness: 0.6pt)),
      $B_0$,
    ),
  ),
  caption: [Verlauf der Magnetfeldstärken in einer Maxwell-Spule und einer parabolischen Falle mit Offsetfeld],
) <fig:traps>

Die Realisierung einer magnetischen Falle erfordert die Erzeugung eines lokalen Feldextremums. Eine Möglichkeit hierzu bietet zum Beispiel die Maxwell-Spule, auch Anti-Helmholtz-Spule genannt. Sie besteht aus zwei gleichen Spulen mit gegensinnigem Stromfluss, die so angeordnet werden, dass sie zusammen die Deckelflächen eines Zylinders bilden. Bei korrekter Justierung des Spulenabstands ermöglicht dieser Aufbau ein verschwindendes Magnetfeld im Zentrum der Anordnung, das Magnetfeldminimum, mit linearem Anstieg der Feldstärke in alle Richtungen. Beim Einfangen von Teilchen sind zwei Fälle zu unterscheiden. Teilchen, deren magnetisches Moment antiparallel zur Magnetfeldrichtung weist, nennt man "low-field-seekers", da sie stets zu einem Feldminimum hinstreben, um entsprechend
$ E_"mag" = -bmu dot bB = -|bmu||bB| cos(phi) = |bmu||bB| $ <eq:energy>
ihre Energie zu minimieren. Umgekehrt suchen Teilchen mit parallel zum Magnetfeld ausgerichtetem Moment stets den Ort mit lokal höchster Feldstärke auf ("high-field-seekers"). Aus den Maxwellgleichungen folgt, dass es kein dreidimensionales Maximum statischer Magnetfelder im freien Raum geben kann (Earnshaw-Theorem). Dies hat zur Folge, dass die zweite Sorte Teilchen nur in zeitlich veränderlichen Magnetfeldkonfigurationen gefangen werden können, nicht jedoch in einer statischen Magnetfalle.

Nach Gleichung @eq:energy ist die Kraft bei Auslenkung aus der Ruhelage für low-field-seeker
$ bF_"mag" = -vb(nabla)(|bmu||bB|) = -|bmu| vb(nabla)|bB|, $
wirkt also stets entgegen dem Gradienten des Magnetfelds in Richtung des Feldstärkeminimums. Im Minimum gilt $vb(nabla)|bB| = 0$, sodass keine Kraft wirkt.

#task(label: "b")[Welche magnetischen Hyperfeinzustände $m_F$ von $Rb$ lassen sich magnetisch speichern?]

Siehe Aufgabenteil *a)*: In statischen Magnetfeldern sind alle $m_F$-Zustände fangbar, deren magnetisches Moment antiparallel zum Magnetfeld ist bzw. genauer, alle für die das Skalarprodukt $bmu dot bB$ negativ ist. Da aber auf nicht ausgerichtete Momente stets ein Drehmoment wirkt, bis sie (anti-)parallel zum Magnetfeld stehen, werden nur die Fälle parallel und antiparallel unterschieden. Um speicherbare Hyperfeinzustände konkret anzugeben sind einige Grundlagen nötig.

In einer Magnetfalle herrschen kleine Feldstärken, sodass die Aufspaltung der atomaren Energieniveaus im Zeeman-Regime erfolgt; das Paschen-Back-Regime bzw. der Übergangsbereich wird nicht erreicht. Das magnetische Moment $bmu$ eines Atoms ist dann
$ bmu = -g_F m_F mu_B vb(e)_B, $ <eq:moment>
- mit dem Landé-Faktor $g_F$ des Hyperfeinstrukturniveaus
  $ g_F approx g_J (F(F + 1) - J(J + 1) - I(I + 1))/(2 F(F + 1)), $
- mit der Magnetquantenzahl $m_F$ des atomaren Gesamtdrehimpulses $bF$, welcher sich zusammensetzt aus dem Gesamtdrehimpuls $vb(J)$ (i.e. Gesamtspin $vb(S)$ plus Gesamtbahndrehimpuls $vb(L)$) der Hüllenelektronen und dem Kernspin $vb(I)$, d.h. $bF = vb(J) + vb(I)$,
- dem Bohrschen Magneton $mu_B$
- und dem Einheitsvektor in Magnetfeldrichtung $vb(e)_B$.

@eq:moment eingesetzt in @eq:energy ergibt
$ E_"mag" = g_F m_F mu_B |bB| $
Die Energie wird zusammen mit der Magnetfeldstärke $|bB|$ minimal, wenn $g_F m_F > 0$ gilt, d.h. wenn $g_F m_F$ das Moment quasi nicht nochmal umkehrt, sondern antiparallel zum Feld belässt. Für $Rb$ sind das die folgenden Konfigurationen
$
  g_(F=2) = -1\/3: & quad m_F in {-1, -2} \
   g_(F=3) = 1\/3: & quad m_F in {1, 2, 3}
$

#task(label: "c")[Die $Rb$-Atome befinden sich im am stärksten vom Magnetfeld beeinflussten Unterzustand von $F = 2$. Der Gradient des Magnetfeldes beträgt $|vb(nabla) bB| = 100 unit("G")/unit("cm")$. Schätzen sie die Temperatur einer gespeicherten Atomwolke ab die sich auf einem Raumbereich von $d = plus.minus 1 unit("mm")$ konzentriert? Was ist in diesem Zusammenhang unter "Temperatur" zu verstehen?]

Der am stärksten gebundene $F = 2$-Zustand ist nach Aufgabenteil *b)* $m_F = -2$ mit $g_F = -1\/3$. Eine sehr grobe Abschätzung der Energie gibt das Produkt aus Kraft $bF$ und Strecke $vb(s)$, wenn man davon ausgeht, dass beide in etwa parallel stehen und dass die Atome innerhalb der Falle Strecken zurücklegen, die etwa der halben Ausdehnung der Atomwolke entsprechen, also $|vb(s)| approx |d|$.
$
  E_"kin" = bF vb(s) & = |bF||vb(s)| cos(phi) approx |bF||d| \
  & = |bmu| |vb(nabla) bB||d| = g_F m_F mu_B |vb(nabla) bB||d|
$
Mit $T approx E_"kin" \/ k_B$ erhält man eine geschätzte Temperatur von
$ T approx (g_F m_F mu_B)/k_B |vb(nabla) bB||d| = "4,48" dot 10^(-4) unit("K") $
Die Temperatur ist in dieser Abschätzung proportional zur kinetischen Energie, was der Anschauung entspricht, dass makroskopisch mess- und spürbare Temperaturunterschiede auf mikroskopischer Ebene durch unterschiedlich schnelle, ungeordnete Teilchenbewegungen verursacht werden. Die Temperatur kann in diesem Zusammenhang auch als Maß für die Tiefe einer Potentialfalle verstanden werden: Je höher die Temperatur der gefangenen Teilchen, desto höher auch ihre kinetische Energie und umso tiefer muss die Falle sein, damit es nicht zu Verlusten kommt.

#task(label: "d")[Überlegen sie sich Methoden, um ein gefangenes Ensemble zu kühlen.]

Eine Möglichkeit zu kühlen ist, besonders schnelle Teilchen durch Absenken der Potentialbarriere einfach entweichen zu lassen. Diesen Vorgang nennt man evaporatives Kühlen. Er hat den Nachteil, dass er die im Experiment für gewöhnlich ohnehin geringe Teilchenzahl weiter verknappt. Alternativ kann man auch mit rotverstimmten Lasern kühlen, die bevorzugt solche Teilchen durch Photonenabsorption abbremsen, die sich mit einer durch den Experimentator frei wählbaren Geschwindigkeit auf den Laser zu bewegen, sodass sie die Laserfrequenz durch den Dopplereffekt gerade auf Resonanz verschoben sehen.

#heading(numbering: none)[Übungsaufgaben]
#counter(heading).update(0)

= Magnetooptische Falle #pts(17)

#task[Die magnetooptische Falle ist heutzutage ein Standardinstrument in der modernen Atomphysik zur Erzeugung kalter Atome und wird in vielen Labors direkt zu Messungen oder auch als Vorkühlstufe zur Erzeugung entarteter Quantengase (Bose-Einstein Kondensate, entartete Fermi-Gase) genutzt. In dieser Übung sollen sie mit Hilfe einer wissenschaftlichen Publikation die Grundprinzipien der magnetooptischen Speicherung von Atomen erschließen.

  Besorgen und lesen sie die Publikation zur Realisierung der ersten magnetooptischen Falle:

  E.L. Raab, M. Prentiss, A. Cable, S. Chu und D.E. Pritchard, "Trapping of neutral sodium atoms with radiation pressure", Physical Review Letters 59, 2631 (1987).]

#task(label: "a")[Skizzieren sie nochmals das in der Vorlesung besprochene Niveauschema von Natrium und begründen sie, warum man in guter Näherung von einem wasserstoffähnlichen System ausgehen kann. Skizzieren sie die Hyperfeinstrukturaufspaltung der in der Veröffentlichung benutzten Niveaus. Der Kernspin von Natrium ist $I = 3\/2$ und die Energie steigt mit wachsendem $F$. Zeichnen sie die benutzten Übergangslinien ein. (4 Punkte)]

Natrium hat die Ordnungszahl $Z = 11$. Von seinen 11 Elektronen füllen zwei das $1s$-Orbital, zwei das $2s$-Orbital und jeweils zwei die drei $2p_i$-Orbitale mit $i in {x, y, z}$. Diese Schalen sind alle vollbesetzt und tragen nicht zum Bahndrehimpuls oder Spin, also kurz zum Drehimpuls des Atoms bei. Das verbliebene Elektron befindet sich im Grundzustand im vergleichsweise kernfernen $3s$-Orbital.#footnote[Genau genommen ist die Zuweisung von Elektronen zu bestimmten Energieniveaus unphysikalisch. In einem Atom mit mehreren Hüllenelektronen befindet sich jedes Elektron mit einer gewissen Wahrscheinlichkeit in allen besetzten Orbitalen.]

#figure(
  fig("sheet-06-sodium-orbitals", width: 55%),
  caption: [Besetzung der Orbitale in Natrium. Das $3s$-Elektron wurde der Notation folgend als Spin-Up eingezeichnet. Es befindet sich aber im Allgemeinen in einer Überlagerung des Spin-Up- und Spin-Down-Zustands.],
)

#figure(fig("sheet-06-sodium-levels", width: 40%), caption: [Niveauschema des Natrium-Valenzelektrons])

Zur Begründung der Aussage, das Natriumatom verhalte sich in guter Näherung wasserstoffähnlich, bedient man sich dem effektiven Ein-Teilchen-Modell zur Beschreibung von Mehrelektronen-Atomen. In diesem Modell wird die Coulomb-Wechselwirkung der Elektronen untereinander nicht explizit, sondern nur gemittelt als Beitrag zu einem effektiven Zentralpotential berücksichtigt. Maßgeblich ist hier die Bindung der Elektronen an das Coulombpotential des Kerns. Bei der Berechnung der Energien weit außen liegender Orbitale, wie dem $3s$-Orbital des Natriums, wird die Abschirmung des Kerns aufgrund stärker gebundener Elektronen durch Einführung eines effektiven Kernpotentials berücksichtigt. Die Gesamtwellenfunktion der Atomhülle wird als Produkt der unabhängigen Ein-Teilchen-Wellenfunktionen angesetzt.#footnote[Hierbei ist auf die Antisymmetrisierung der Gesamtwellenfunktion bezüglich Koordinatentausch zweier Teilchen zu achten (s. Slater-Determinante).]

Zurück zum Natrium. Da, wie bereits erwähnt, die abgeschlossene $1s$-, $2s$- und $2p$-Schalen keinen Drehimpuls tragen, ist, zumindest im Rahmen des effektiven Ein-Teilchen-Modells, der einzige Effekt dieser Elektronen auf das Atom die Abschirmung des Kerns. Für das Verhalten von Natrium bei Anregungen und Bindungen ist ausschließlich das $3s$-Elektron von Bedeutung. Im Ein-Teilchen-Modell unterscheiden sich Natrium und Wasserstoff also nur durch den Verlauf ihres Zentralpotentials und durch den Abstand des Valenzelektrons vom Kern.

Laut Veröffentlichung ist die magnetooptische Falle insofern anpassungsfähig, als das Trapping mit einer Vielzahl an leicht unterschiedlichen Pumpschemata erreicht werden konnte. Grundsätzlich wurde mit Übergängen zwischen den $3s_(1\/2)$- und $3p_(3\/2)$-Orbitalen gearbeitet.#footnote[Die Notation der Orbitalquantenzahlen erfolgt wieder in der Reihenfolge $n l_j$ mit der Hauptquantenzahl $n in NN$, der Bahndrehimpulsquantenzahl $l in NN$ geschrieben als $s$, $p$, $d$, $f$, $g$, $h$, $i$, ... und dem Gesamthüllendrehimpuls $j in {|l - s|, ..., l + s}$.] Das dazwischenliegende $3p_(1\/2)$-Niveau wurde nicht verwendet. Unter Ausnutzung der Hyperfeinniveaus sind nun zum Beispiel die folgenden zwei Laserkonfigurationen möglich
- Der $F = 2 -> F' = 2$-Betrieb ist in @fig:hyperfine a dargestellt. Der Rückpumplaser arbeitet von $F = 1$ nach $F' = 2$ (im Paper von $F = 1$ nach $F' = 0$).
- Eine andere Möglichkeit zeigt die @fig:hyperfine b. Hier treibt der Kühllaser den Übergang $F = 2 -> F' = 3$ und der Rückpumplaser $F = 1 -> F' = 2$ (genau wie im Paper). Dieser Betrieb soll einen deutlich kompakteren Ball aus gefangenen Atomen produziert haben.

#figure(
  grid(
    columns: (57%, 43%),
    column-gutter: 1.5em,
    align: bottom,
    fig("sheet-06-cooling-f2-f2"), fig("sheet-06-cooling-f2-f3"),
    text(size: 9pt)[(a) Der Kühllaser treibt den Übergang $F = 2 -> F' = 2$],
    text(size: 9pt)[(b) Der Kühllaser treibt den Übergang $F = 2 -> F' = 3$],
  ),
  caption: [Hyperfeinstrukturniveaus von Natrium mit Übergangslinien der optischen Pumpprozesse in einer magnetooptischen Falle. Gestrichelte Linien repräsentieren durch Auswahlregeln erlaubte Zerfallskanäle.],
) <fig:hyperfine>

#task(label: "b")[Beschreiben sie in eigenen Worten basierend auf der Erklärung in der Veröffentlichung, wie eine magnetooptische Falle mit einem $S = 0 -> S' = 1$-Übergang funktioniert.

  _Hinweis:_ Bedenken sie, dass $sigma^plus.minus$polarisiertes Licht nur Übergänge mit $Delta m_S = plus.minus 1$ antreiben kann. (4 Punkte)]

Übersetzung der relevanten Textstelle der Veröffentlichung:

"Das grundlegende Prinzip der Falle (in einer Dimension) kann verdeutlicht werden anhand eines hypothetischen Atoms mit einem $S = 0$, $m_S = 0$ Grundzustand und einem $S = 1$, $m_S in {-1, 0, 1}$ angeregten Zustand. In einem schwachen inhomogenen Magnetfeld $B(z) = B_0 z$ sind die Energieniveaus des Atoms um den Betrag $Delta E = m_S mu B(z) = m_S mu B_0 z$ Zeeman-aufgespalten (s. @fig:zeeman). Nun wird das Atom mit gebündeltem $sigma^-$-Licht beschienen, das in $-z$-Richtung propagiert und mit $sigma^+$-Licht, das in $+z$-Richtung propagiert. Ist der Laser unterhalb der Resonanzfrequenz bei $B(z) = 0$ gestimmt, so wird das Atom im Grundzustand für $z > 0$ mehr $sigma^-$-Photonen absorbieren, als $sigma^+$-Photonen, da der $sigma^-$-Laser näher an der $Delta m = -1$-Resonanzfrequenz liegt. Infolgedessen wird das Atom im zeitlichen Mittel eine Netto-Kraft zurück zum Ursprung spüren. Für ein Atom bei $z < 0$ ist die Zeeman-Verschiebung invertiert, sodass auch die Kraft entgegengesetzt wieder zum Ursprung $z = 0$ wirkt. Die Rotverstimmung des schwachen Lasers relativ zur Resonanz erzeugt außerdem einen Abbrems-Effekt.

#figure(
  fig("sheet-06-zeeman-mot", width: 55%),
  caption: [Energieniveau-Diagramm des hypothetischen Atoms mit ortsabhängiger Zeeman-Aufspaltung im Magnetfeld $B(z) = B_0 z$.],
) <fig:zeeman>

Dieses Schema lässt sich leicht auf drei Dimensionen erweitern, indem man entgegengerichtet propagierende $sigma^+$- und $sigma^-$-Strahlen entlang der $x$- und $y$-Achsen und ein sphärisch-symmetrisches Quadrupol-Magnetfeld hinzufügt."

#figure(
  fig("sheet-06-mot-3d", width: 50%),
  caption: [Aufbau einer magnetooptischen Falle in drei Dimensionen],
)

Nach dieser Erklärung ist zum besseren Verständnis anzumerken, dass die Netto-Kraft erst durch eine große Anzahl von Absorptions- und _spontanen_ Emissionsprozessen zustande kommt. Stimulierte Emission trägt zur rücktreibenden Kraft nicht bei, da das emittierte Photon in dieselbe Richtung fliegt, wie das absorbierte. Der Impulsübertrag ist somit gleich null. Die spontane Emission verteilt sich dagegen isotrop im Raum, sodass deutlich mehr Impuls zurück zum Fallenzentrum absorbiert wird, als in die entgegengesetzte Richtung emittiert wird. Aus diesem Grund darf auch die Intensität des Lasers nicht zu stark sein, da sonst die spontane gegenüber der stimulierten Emission kaum noch eine Rolle spielt.

#task(label: "c")[Machen sie die entsprechende Funktionsskizze für den Fall des $F = 2 -> F' = 3$-Übergangs in Natrium und erklären sie kurz wieso sich das Prinzip auf diesen Fall übertragen lässt. (4 Punkte)]

Für die Skizze, siehe @fig:hyperfine b. Die Aussagen zum hypothetischen Atom in Aufgabenteil *b)* bezogen sich auf Übergänge zwischen Spinzuständen. Laserlicht kann aber natürlich genauso Übergänge zwischen verschiedenen Hyperfeinzuständen antreiben, die sich in ihrer Gesamtdrehimpulsquantenzahl $F$ unterscheiden. Es gelten sogar dieselben Auswahlregeln:
$ Delta F in {-1, 0, 1} #h(3em) Delta m_F in {-1, 0, 1} $
Der einzige Unterschied von Natrium gegenüber dem gedachten Atom ist, dass der Grundzustand nun ebenfalls aufgespalten ist und überhaupt eine größere Anzahl Zustände zur Verfügung steht. Auf die Funktionalität der magnetooptischen Falle hat dies keinen negativen Einfluss.

#task(label: "d")[Wieso oszillieren die Atome nicht in der magnetooptischen Falle, sondern kommen nach dem vorgestellten Modell im Zentrum zur Ruhe? (1 Punkt)]

Dies wurde bereits in der Übersetzung des Papers in Aufgabenteil 1.*b)* begründet: Die Laser sind leicht rotverstimmt. Dadurch absorbieren vor allem solche Atome Photonen, die sich auf den Laser zu bewegen, sodass für sie die Laserfrequenz aufgrund der Dopplerverschiebung erhöht ist. Der Impulsübertrag der absorbierten Photonen wirkt der Bewegung also entgegen, während sich die Rückstöße der anschließenden, isotrop verteilten spontanen Emission im Mittel aufheben. Netto erfahren die Atome dadurch eine geschwindigkeitsabhängige, abbremsende Reibungskraft. Siehe auch optische Melasse bzw. Laserkühlung.

#task(label: "e")[Wie groß ist die erwartete Rückstellkraft für ein um einen Millimeter ausgelenktes Atom in SI-Einheiten für die Parameter in der Veröffentlichung? Welche Beschleunigung erfährt es also? (2 Punkte)]

In einer idealen magnetooptischen Falle wirkt die Kraft von allen Punkten aus isotrop in Richtung des Fallenzentrums. Es reicht also, die Kraft in einer Dimension zu bestimmen. Man wählt ohne Einschränkung die $z$-Achse und erhält im Falle kleiner Auslenkungen und Geschwindigkeiten der Atome für die Rückstellkraft
$ F_("Rück",z) = -kappa z - alpha dot(z) $
Die Ergebnisse einer Modellrechnung zu den Proportionalitätskonstanten $kappa$ und $alpha$ sind im Paper angegeben und lauten für einen Feldgradienten von $dif B \/ dif z = 5 unit("G")/unit("cm")$
$
  kappa & = (dif B)/(dif z) "2,67" dot 10^(-16) unit("dyn")/unit("G") = "1,34" dot 10^(-18) unit("N")/unit("m") \
  alpha & = "6,07" dot 10^(-18) (unit("dyn") unit("s"))/unit("cm") = "6,07" dot 10^(-21) (unit("N") unit("s"))/unit("m")
$
Für eine gute Abschätzung der Rückstellkraft bietet es sich nun an, $z = 1 unit("mm")$ wie in der Aufgabenstellung zu setzen und für die mittlere Geschwindigkeit $dot(z)$ das Recoil-Limit (s. Aufgabe 2) $dot(z) = v_"RL" = p_"Ph"/m_"Na"$ zu verwenden. Im Natrium wird durch den Kühllaser der Übergang $3s_(1\/2) -> 3p_(3\/2)$ gepumpt. Dies ist eine der beiden dominanten Spektrallinien im Natriumspektrum und hat historisch den Namen $D 2$-Linie bekommen (gegenüber der $D 1$-Linie von $3s_(1\/2)$ nach $3p_(1\/2)$). Die Wellenlänge dieses Übergangs beträgt $lambda_(D 2) = 589 unit("nm")$. Daraus folgt ein Photonenimpuls von $p_"ph" = "1,12" dot 10^(-27) unit("kg m")/unit("s")$ und mit $m_"Na" = 23 unit("u")$ ein Recoil-Limit von $dot(z) = "0,03" unit("m")/unit("s")$. Eine gute Abschätzung der Rückstellkraft ist somit
$
  F_("Rück",z) = -kappa z - alpha dot(z) & = -"1,34" dot 10^(-18) unit("N")/unit("m") dot 1 unit("mm") \
  & #h(1.2em) - "6,07" dot 10^(-21) (unit("N") unit("s"))/unit("m") dot "0,03" unit("m")/unit("s") = -"1,51" dot 10^(-21) unit("N")
$
Die Beschleunigung $a_"Na"$ auf ein Natriumatom mit dieser Auslenkung und dieser Geschwindigkeit beträgt
$ a_"Na" = F_("Rück",z)/m_"Na" = -"3,97" dot 10^4 unit("m")/unit("s")^2 approx -4040 thin g $
mit der Erdbeschleunigung $g$.

#task(label: "f")[Wie ist zu erklären, dass jeweils zwei Laserfrequenzen nötig waren, um die Falle zu betreiben? (2 Punkte)]

Auf Seite 2632 heißt es in dem Paper

"Two laser frequencies are used in the model to avoid optically pumping the atom into an inaccessible ground hyperfine state."

D.h. zwei Laserfrequenzen sind nötig, da angeregte Atome spontan in ein für den Primärlaser unzugängliches Niveau zerfallen können, in dem sie dann nicht mehr durch die Falle gefangen wären. Unzugänglich heißt hierbei, dass der Primärlaser entweder zu weit abseits der Resonanz strahlt und/oder dass die Anregung durch Auswahlregeln unterdrückt wird, z.B. aufgrund falscher Polarisation des Lasers. Die Problematik wird in @fig:rubidium für den Fall von Rubidium verdeutlicht.

#figure(
  fig("sheet-06-rubidium-transitions", width: 45%),
  caption: [Laserübergänge, die für das magnetooptische Festhalten von Rubidium $attach(upright("Rb"), tl: 85)$ gebraucht werden. a) und b) zeigen den Absorptions-Emissionszyklus. Die Laserfrequenz ist bis zur gestrichelten Linie im Energiediagramm rotverstimmt. c) und d) sind aufgrund von Auswahlregeln verbotene Übergänge. e) zeigt die Möglichkeit, dass ein angeregtes Atom aus dem $F = 3$-Zustand in den für den Kühllaser "blinden", tiefliegenden $F = 2$-Hyperfeinzustand zerfällt. Dieser Effekt würde sowohl den Kühlvorgang abbrechen, als auch die Fallen-Wirkung aufheben, wäre da nicht der Rückpumplaser f). [Wikipedia - Magneto-Optical Trap]],
) <fig:rubidium>

= Recoil Limit #pts(3)

#task[Ein Wasserstoffatom gehe durch Emission eines Photons aus dem ersten angeregten in den Grundzustand über. Bestimmen sie die Temperatur, die aus der Rückstoßenergie resultiert, welche bei der Emission des Photons auf das Atom übertragen wird. Benutzen Sie die Annahme $E_"kin" approx k_B T$.]

Die Energieniveaus des Elektrons im Wasserstoffatom ohne Berücksichtigung von Spin-Bahn-Kopplung, Spin-Spin-Kopplung, relativistischen und quantenelektrodynamischen Effekte lauten
$ E_n = -m_e/2 (e^2/(4 pi epsilon_0 planck))^2 1/n^2 wide "mit" n in NN $
Die Energie des Photons, das beim Übergang vom ersten angeregten Zustand $n = 2$ in den Grundzustand $n = 1$ emittiert wird, beträgt
$
  E_"ph" = E_2 - E_1 & = -m_e/2 (e^2/(4 pi epsilon_0 planck))^2 (1/2^2 - 1/1^2) \
  & = (3 m_e)/8 (e^2/(4 pi epsilon_0 planck))^2 = "1,63" dot 10^(-18) unit("J") = "10,20" unit("eV")
$
Mit dieser Energie geht ein Photonimpuls von
$ p_"ph" = E_"ph"/c = "5,45" dot 10^(-27) unit("kg m")/unit("s") $
einher. Das Gesamtsystem aus Photon und Wasserstoffatom ist abgeschlossen, sodass die Summe ihrer Impulse erhalten bleiben muss. Im Ruhesystem des Wasserstoffs vor dem Zerfall trägt das Atom danach deshalb den entgegengesetzten Impuls des Photons $p_"H" = -p_"ph"$. In der nichtrelativistischen Näherung, die bei diesem Zerfall gut erfüllt sein sollte, beträgt die kinetische Energie des Atoms somit
$ E_"kin" = p_H^2/(2 m_H) = p_"ph"^2/(2 m_H) $
Daraus folgt eine Rückstoßtemperatur von
$ T approx E_"kin"/k_B = p_"ph"^2/(2 m_H k_B) = "6,44" dot 10^(-4) unit("K"), $
wobei es streng genommen nur sinnvoll ist, von einer Temperatur zu sprechen, wenn eine große Anzahl solcher Systeme präpariert wurde, die alle simultan zerfallen, z.B. durch die stimulierte Emission mithilfe eines Lasers. Man nennt diese Temperatur im Jargon der Laser-Kühlung auch Recoil Limit bzw. Rückstoßgrenze. Es ist die niedrigste Temperatur, die mit Laser-Kühlungsmethoden erreichbar ist, die eine permanente Interaktion der zu kühlenden Atome mit dem Laserlicht involvieren.
