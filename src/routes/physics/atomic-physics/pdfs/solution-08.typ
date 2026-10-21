#import "/notes.typ": dd, task, unit, ket, braket, eps
#import "/atomic-physics/sheet.typ": fig, sheet, pts, part

#show: sheet.with([Übungsblatt 8], [17\. Juni 2014])

#let (PsiA, PsiB) = ($Psi_(1s,A) (r_A)$, $Psi_(1s,B) (r_B)$)
#let Hh = $hat(H)$

#part[Präsenzaufgaben]

= Molekülbindungen

#task(label: "a")[_Erklären sie, warum nur zwei Elektronen eine kovalente Bindung eingehen können._]

In Molekülen existieren verschiedene Arten von Bindungen, die die Atome zusammen halten und so komplexe Strukturen entstehen lassen. Sie werden in der Chemie nach ihrer Stärke klassifiziert. Man unterscheidet
- die sehr stabilen Primärbindungen; dazu gehören die Ionenbindung, die metallische Bindung und auch die _kovalente Bindung_
- und die deutlich schwächeren sekundären Bindungen, namentlich die Wasserstoffbrückenbindung, die Dipol-Dipol-Bindung und die Van-der-Waals-Bindung.

Eine kovalente _Einfachbindung_ besteht aus einem Paar von Elektronen, das genau zwei Atomen gemeinsam angehört. Dieses Elektronenpaar zeichnet sich durch eine hohe Aufenthaltswahrscheinlichkeit auf der Verbindungslinie beider Kerne aus. Dadurch wird die Coulombabstoßung zwischen den Kernen geschwächt und das System stärker gebunden. Es ist also gewissermaßen schon in der Definition der kovalenten Einfachbindung enthalten, dass sie aus genau zwei Elektronen besteht.

Im Allgemeinen teilen sich bei einer kovalenten Bindung aber ein oder mehrere Reaktionspartner ein oder mehrere Elektronen. So bezeichnet man zum Beispiel auch das einzelne bindende Elektron im $H_2^+$-Ion#footnote[Vgl.: Seite 13, Kapitel 6 der Vorlesung] und die vollständig delokalisierte Wolke der 6 $pi$-Elektronen im Benzolring als kovalente Bindungen. Eine bessere Formulierung der Fragestellung wäre deshalb gewesen, warum eine kovalente Einfachbindung aus nicht mehr als zwei Elektronen bestehen kann.

Der Grund dafür ist, dass die Elektronen einer kovalenten Einfachbindung durch dieselbe Ortswellenfunktion beschrieben werden und somit in allen damit verbundenen Quantenzahlen $n$, $l$ und $m_l$ identisch sind. Die einzige Quantenzahl, die durch die Ortswellenfunktion nicht festgelegt wird, ist der Spin, der für Elektronen als Spin-$1/2$-Teilchen nur die Einstellungen $m_s = plus.minus 1/2$ entlang der Quantisierungsachse annehmen kann. Sind beide Einstellungen belegt, so ist die kovalente Einfachbindung voll besetzt und kann durch keine weiteren Elektronen angenommen werden.

#task(label: "b")[_Ordnen sie die Moleküle $H_2$, $H D$ und $D_2$ nach ihrer effektiven Bindungsenergie in absteigender Reihenfolge._]

Deuterium ist ein Wasserstoffisotop mit einem zusätzlichen Neutron. Diese drei Moleküle unterscheiden sich folglich in ihrer Masse.
$ m_(H_2) approx 2 unit("u") wide m_(H D) approx 3 unit("u") wide m_(D_2) approx 4 unit("u") $
Unter Vernachlässigung von Effekten der schwachen Wechselwirkung zwischen Elektron und Neutron, die aus der nicht verschwindenden Aufenthaltswahrscheinlichkeit von 1s-Elektronen innerhalb des Kerns entstehen können, ist dies auch der einzige Unterschied zwischen den drei Molekülen.

Das Coulomb-Potential und die Energieerhöhung durch das Pauli-Prinzip für sehr kleine Kernabstände im Molekül ändert sich hierdurch nicht, sodass sich die Lennard-Jones-Potentiale von $H_2$, $H D$ und $D_2$ kaum unterscheiden sollten. Somit hängt die Bindungsenergie maßgeblich nur noch von der Nullpunktsenergie des Grundzustands ab: Je kleiner die Energie des Grundzustands, desto größer dessen Bindungsenergie. Nähert man das Lennard-Jones-Potential für kleine Abweichungen vom Gleichgewichtsabstand, also im Bereich des Potentialminimums als harmonisches Potential, so beträgt die Nullpunktsenergie $E_0 = 1/2 planck omega_0$. Über $omega_0 = sqrt(k\/mu)$, wobei $k$ die Rückstellkonstante des Potentials angibt, ist $E_0$ abhängig von der reduzierten Masse $mu$ des Moleküls, sodass gilt
$ E_0 = 1/2 planck omega_0 = planck/2 sqrt(k/mu) prop 1/sqrt(mu) $
$E_0$ sinkt mit steigender Masse. Wegen $mu = (m_1 m_2)/(m_1 + m_2)$ ist
$
  mu_(H_2) & = m_H/2 \
  mu_(H D) & = (m_H m_D)/(m_H + m_D) approx (2 m_H)/3 \
  mu_(D_2) & = m_D/2 approx m_H
$
Aus diesem Grund ist das Molekül $D_2$ stärker gebunden als $H D$ und dieses wiederum stärker als $H_2$.

#task(label: "c")[_Was bedeutet es, wenn man sagt, ein Molekül sei in einem elektronisch angeregten Zustand? Geben sie ein Beispiel für $H_2$._]

Elektronische Anregung liegt vor, wenn sich mindestens ein Elektron des Moleküls nicht im Grundzustand befindet. In der LCAO-Näherung werden Molekülorbitale aus Linearkombinationen der Orbitale aller beteiligten Atome konstruiert. Im Rahmen dieser Näherung heißt das, dass mindestens ein Elektron des Moleküls ein angeregtes Atomorbital besetzt. Beispiele für $H_2$ sind $1s 2s$, $1s 2p$, $3s 4f$.

#task(label: "d")[_Die niedrigsten elektronisch angeregten Zustände von $N_2$ und $O_2$ liegen mehr als $3 unit("eV")$ über dem Grundzustand. Welche Folge hat das auf unsere optische Wahrnehmung der Umgebung?_]

Das Spektrum des sichtbaren Lichts reicht etwa von $400 unit("nm")$ bis $800 unit("nm")$. Nach $E = (h c)/lambda$ entspricht das dem Energieintervall $[1","55 unit("eV"); 3","10 unit("eV")]$. Dies hat zur Folge, dass das für Menschen sichtbare Licht durch die Atmosphäre nur geringfügig absorbiert wird. Luft erscheint transparent.

#task(label: "e")[_Die Energie für Vibrationsübergänge bzw. -zustände von $H C l$ ist deutlich größer (etwa eine Größenordnung) als die von $N a C l$. Warum? Benutzen sie die Lösung von Aufgabe 1, Übungsblatt 7._]

Das Wasserstoffatom ist mit $m_H approx 1 unit("u")$ sehr viel leichter als Natrium mit $m_(N a) approx 23 unit("u")$. Die Vibrationsenergie hängt näherungsweise harmonisch von der reduzierten Masse $mu$ ab, genau wie die Grundzustandsenergie $E_0$ in Aufgabenteil *b)*:
$ E_"vib" = planck omega_"vib" = planck sqrt(k_"vib"/mu) prop 1/sqrt(mu) $
Dieser Effekt alleine würde aber nur ein Verhältnis von $E_("Vib",H C l) \/ E_("Vib",N a C l) approx 3","8$ erklären. Ein weiterer Beitrag ergibt sich aus dem unterschiedlichen Verlauf des Potentials beider Moleküle. Nähert man den Potentialverlauf in Abhängigkeit des Kernabstands $R$ durch ein ionisches Lennard-Jones-Potential, welches in der Umgebung des Minimums einem harmonischen Potential ähnelt, so hängt die Energiedifferenz aufeinanderfolgender Vibrationszustände dort zusätzlich näherungsweise wurzelförmig von der Krümmung des Potentials ab. Man rechtfertigt diese Aussage mit dem harmonischen Potential, in dem sich die Rückstellkonstante $k$ aus der zweifachen Ableitung des Potentials $V(R) = 1/2 k R^2$, also seiner Krümmung, ergibt. Anschaulich ist klar, dass eine stärkere Kraft zurück zur Ruhelage eine schnellere Vibration verursacht.

Um zu verstehen, warum das Potential beider Moleküle verschieden sein sollte und insbesondere warum es für $H C l$ in der Umgebung des Minimums stärker gekrümmt sein sollte, sind einige Aussagen zum Lennard-Jones-Potential erforderlich. Es zeichnet sich durch zwei Beiträge aus:
$ V(R) = A/R^12 - B/R wide A, B in RR_+, "konstant" $
Die $R^(-12)$-Abhängigkeit lässt die potentielle Energie für sehr kleine Abstände divergieren. Dieser Beitrag kommt dadurch Zustande, dass die Elektronen zur Einhaltung des Pauli-Prinzips bei Annäherung der Atomhüllen auf energetisch höhere Orbitale ausweichen müssen. Für sehr kleine Abstände wird hierdurch außerdem die zunehmende Kern-Kern-Abstoßung berücksichtigt.

Der $-R^(-1)$-Term erzeugt für große Abstände eine attraktive Kraft zwischen den $C l^-$- und $H^+$- bzw. $N a^+$-Ionen. Die physikalische Ursache dieser Anziehung ist die elektrostatische Coulomb-Kraft. Für sehr große Kernabstände ist das System nicht länger gebunden, sondern besteht im Prinzip aus einem isolierten Chlor-Anion und einem Wasserstoff- bzw. Natrium-Kation. Für diesen Fall muss das Potential natürlich gegen die Differenz aus Ionisationsenergie und Elektronenaffinität $E_"Ion" - E_"Aff"$ konvergieren.

#figure(
  fig("sheet-08-lennard-jones", width: 40%),
  caption: [Lennard-Jones-Potential für kleine und große Kernabstände. Die grüne Linie zeigt den Potentialverlauf von $N a C l$, die blaue den von $H C l$ mit höherer Ionisationsenergie und deshalb größerer Krümmung.],
) <fig:lennard-jones>

Der $R^(-12)$-Verlauf des Potentials für kleine Kernabstände und auch die maximale Potentialtiefe sind für beide Moleküle ähnlich. Da das Wasserstoff aber eine knapp dreimal so hohe Ionisationsenergie besitzt, wie Natrium ($E_("Ion",H) = 13","6 unit("eV")$ gegenüber $E_("Ion",N a) = 5","14 unit("eV")$), unterscheiden sich die Potentiale für große Kernabstände sehr deutlich (s. @fig:lennard-jones). Man kann sich nun leicht vorstellen, dass wenn das Potentialminimum in beiden Fällen annähernd gleich ist, das $H C l$-Potential für große Kernabstände aber höher liegt, dann muss die Krümmung des Potentials dazwischen und deshalb auch die Energiedifferenz seiner Vibrationszustände größer sein.

#task(label: "f")[_In @fig:potential-curves sind die Potentialkurven zweier diatomarer Moleküle mit der gleichen reduzierten Masse $mu$ gezeigt. Welches Molekül hat_]

#figure(
  fig("sheet-08-potential-curves", width: 40%),
  caption: [Potentialverlauf im Molekül als Funktion des Kernabstands $R$. Entstammt "Quantum Physics" von Eisberg und Resnick, Kap. 12, S. 439.],
) <fig:potential-curves>

#[
  #set enum(numbering: "1.")
  + _den größeren Kernabstand?_

    Der intermolekulare Gleichgewichtsabstand $R_0$ ist festgelegt durch seine Eigenschaft $lr((partial V)/(partial R)|)_(R = R_0) = 0$. In @fig:potential-curves ist klar erkennbar, dass das Potentialminimum von Molekül 1 bei größerem Kernabstand $R$ liegt. Demnach gilt $R_(0","1) > R_(0","2)$.
  + _das größere Trägheitsmoment?_

    Da beide Moleküle dieselbe reduzierte Masse tragen und Molekül 1 einen größeren Kernabstand aufweist, muss auch hier die Trägheit $theta = mu R_0^2$, mit der das Molekül Drehungen entgegenwirkt, größer sein, d.h. $theta_1 > theta_2$.
  + _eine höhere Aufspaltung der Rotationsniveaus mit gleichem $n$ und $nu$?_

    Die Rotationsenergie ist gegeben durch $E_"Rot" (K) = planck^2/(2 theta) K(K + 1)$. Wegen $theta_1 > theta_2$ gilt $Delta E_("Rot",1) < Delta E_("Rot",2)$. Physikalisch kann man sich vorstellen, dass Molekül 2 ein geringeres Trägheitsmoment hat und deshalb im Mittel schneller rotiert. Seine Rotationsniveaus sind weiter aufgespalten.
  + _die höhere Bindungsenergie?_

    Die Grenze zwischen gebundenen und ungebundenen Zuständen liegt bei $E = 0$. Da das Potential von Molekül 2 kleiner wird, als das von 1, gilt $E_(B,1) < E_(B,2)$. Streng genommen muss man von der Potentialtiefe noch die Nullpunktsenergie abziehen, um die Bindungsenergie zu erhalten.
  + _die höhere Nullpunktsenergie_#footnote[Die Nullpunktsenergie ist die Differenz zwischen der Energie, die ein quantenmechanisches System im _Grundzustand_ besitzt, und dem Energieminimum, welches das System hätte, wenn man es klassisch beschreiben würde.]_?_

    Die Nullpunktsenergie $E_0$ als Funktion der Krümmung des Potentialverlaufs beträgt
    $ E_0 = planck/(4 pi sqrt(mu)) sqrt(lr((partial^2 V(R))/(partial R^2) |)_(R = R_0)) $
    Die Kurve von Molekül 2 ist um den Gleichgewichtsabstand $R_0$ und auch sonst stärker gekrümmt, sodass gilt $E_(0","1) < E_(0","2)$.
  + _eine höhere Aufspaltung der Vibrationsniveaus mit gleichem $n$?_

    Die Vibrationsenergie ist $E_"Vib" = (nu + 1/2) planck nu_0$ mit $nu in NN$ und $nu_0 = 2 E_0 \/ planck$. Es gilt also
    $ Delta E_"Vib" = planck nu_0 = 2 E_0, $
    woraus wegen 5. folgt $Delta E_("Vib",1) < Delta E_("Vib",2)$.
]

#part[Übungsaufgaben]

= Molekülzustände #pts(3)

#task(label: "a")[_Die Bezeichnung des $H_2$-Grundzustands ist $attach(Sigma, tl: 1, br: g, tr: +)$. Was bedeuten in dieser Symbolik die einzelnen Größen?_ (2 Punkte)]

_Bemerkung_: Diese Schreibweise wird explizit nur zur Klassifikation von _zweiatomigen_ Molekülen verwendet. Einige der auftretenden Größen sind für mehratomige Moleküle nicht definiert.

Der kapitale, griechische Buchstabe gibt den Betrag der $z$-Komponente der gesamtmolekularen Bahndrehimpulsquantenzahl an. $Sigma$ steht für $Lambda = |m_L| = |L_z| \/ planck = 0$. $Lambda$ ist der Betrag der Summe der $z$-Komponenten der Bahndrehimpulse aller Elektronen (bzw. der Atome, in die der Molekülzustand für $R -> infinity$ dissoziiert):
$ Lambda = |sum_i m_(l,i)| wide "mit" m_(l,i) = l_(z,i)/planck $
Die links hochgestellte Zahl, in diesem Fall 1, gibt die Multiplizität $M$ des Multipletts an, zu dem der vorliegende Zustand gehört. Sie berechnet sich nach $M = 2 S + 1$ und legt somit auch den Gesamtspin $S$ der Elektronenhülle fest.#footnote[$M$ ist auch die Anzahl der möglichen Einstellungen des Spins entlang der Quantisierungsachse.] Der Index $g$ oder $u$ bedeutet gerade bzw. ungerade und legt die Parität der elektronischen Wellenfunktion, also ihre Symmetrie bezüglich Punktspiegelung am Molekülmittelpunkt, fest. Diese Symmetrie kann nur bei zweiatomigen Molekülen mit gleichen Kernen vorliegen. Eine Wellenfunktion mit dem "Exponenten" $+$ oder $-$ wird positiv bzw. negativ genannt. Diese Eigenschaft gibt Auskunft über die Symmetrie der Wellenfunktion bezüglich Spiegelung an einer Ebene, die die Kernverbindungsachse enthält. In der Vorlesung wurde die $x$-$z$-Ebene gewählt, also entspricht die Spiegelung der Operation $y -> -y$. Diese Wahl ist nicht zwingend; für $Sigma$-Zustände ist das Ergebnis für jede Ebene durch die Kernverbindungsachse dasselbe. Diese Symmetrie kann bei homo- und heteronuklearen Molekülen auftreten.

#task(label: "b")[_Wie lautet in dieser Nomenklatur der Grundzustand von $H_2^+$? Geben sie eine kurze Erläuterung des Ergebnisses._ (1 Punkt)]

Der Grundzustand besteht in der LCAO-Näherung aus einer Linearkombination der 1s-Wasserstofforbitale. Da das 1s-Orbital keinen Bahndrehimpuls trägt, gilt dies auch für den $H_2^+$-Grundzustand. Somit ist $L_z = 0$. Desweiteren sind die beiden Enden des Moleküls ununterscheidbar. Das einzige Elektron sieht also an beiden Kernen $A$ und $B$ dasselbe Potential und hat bei beiden Kernen dieselbe Energie. Das System kann deshalb nur Wellenfunktionen wohldefinierter Parität annehmen. Aus zwei 1s-Orbitalen lassen sich durch Linearkombination genau zwei linear unabhängige Molekülorbitale konstruieren (Beweis wird in Aufgabe 2.*b)* erbracht):
$ Psi_(g,u) (bold(r)) = Psi_(1s,A) plus.minus Psi_(1s,B) $
Hierbei wurde die Normierung ignoriert. Durch Lösen der Schrödinger-Gleichung für die ungerade Wellenfunktion stellt sich heraus, dass das System in diesem Zustand stets eine höhere Energie besitzt als die getrennten Bestandteile ($H$-Atom und Proton), also nicht gebunden ist. Da das $H_2^+$-Ion ein stabiles System ist, muss der Grundzustand durch die symmetrische Wellenfunktion beschrieben werden. Zwei der vier gesuchten Quantenzahlen sind also schon bekannt: $Sigma$ und $g$.

Man kann sich nun noch leicht überlegen, dass die gerade Wellenfunktion ebenfalls ihr Vorzeichen bei Ebenenspiegelungen beibehält, schließlich sind 1s-Orbitale isotrop und somit invariant unter allen Arten von Drehungen sowie Punkt- und Ebenenspiegelungen. Die Spinquantenzahl ist trivialerweise 1/2, da die Elektronenhülle von nur einem Elektron bevölkert ist. Die vollständige Bezeichnung des Grundzustands in der Molekülnomenklatur lautet
$ attach(Sigma, tl: 2, br: g, tr: +) $

= Wasserstoff-Molekül-Ion#footnote[Bemerkung: Diese Aufgabe dient der Vertiefung des Stoffes aus Kapitel 6.2 der Vorlesung.] #pts(8)

#task[_Das einfachste Molekül besteht aus zwei Protonen und einem Elektron -- das einfach ionisierte Wasserstoff-Molekül $H_2^+$._]

#task(label: "a")[_Formulieren sie die elektronische Schrödingergleichung für das $H_2^+$ Molekül in der adiabatischen Näherung, d.h. der Abstand der Protonen $R$ wird zunächst als konstant angenommen._ (3 Punkte)]

In der adiabatischen Näherung liegt ein zeitunabhängiges System vor, sodass die Lösung der stationären Schrödinger-Gleichung mithilfe eines Separationsansatzes ausreicht, um das System im Rahmen der Näherung vollständig zu beschreiben.

Die Anwendung des zeitunabhängigen Hamilton-Operators liefert die Summe aus kinetischer und potentieller Energie der elektronischen Wellenfunktion $ket(Psi_"el")$. Die kinetische Energie ist dabei einfach gegeben durch den Hamilton-Operator des freien Teilchens $Hh_"frei" ket(Psi_"el") = E_"kin" ket(Psi_"el")$, die potentielle Energie durch den Potentialoperator, in diesem Fall dem des Coulomb-Potentials $hat(V)_"Coul" ket(Psi_"el") = E_"pot" ket(Psi_"el")$. Letzterer setzt sich für das $H_2^+$-Molekül wiederum aus drei Summanden zusammen:
- der Anziehung zwischen Elektron $e$ und Kern $A$
- der Anziehung zwischen Elektron $e$ und Kern $B$
- der Abstoßung zwischen Kern $A$ und Kern $B$:

#figure(
  fig("sheet-08-h2-ion-coordinates", width: 50%),
  caption: [Koordinaten des $H_2^+$-Moleküls: $A$, $B$ Protonen, $e$ Elektron, $S$ Mittelpunkt der Verbindungslinie $R$ zwischen $A$ und $B$.],
)

$ hat(V)_"Coul" = -e^2/(4 pi eps_0) (1/hat(r)_A + 1/hat(r)_B - 1/hat(R)) $
Da die Masse des Elektrons etwa drei Größenordnungen kleiner als die des Proton ist, kann man näherungsweise annehmen, dass sich die elektronische Wellenfunktion instantan auf Bewegungen der Protonen einstellt (Born-Oppenheimer-Näherung). Es ist deshalb gerechtfertigt, die Position der Protonen als fest zu betrachten und die Schrödinger-Gleichung des Elektronenzustands für jeden Kernabstand $R$ gesondert zu lösen. Bei Vernachlässigung der Elektronenmasse auf den Massenschwerpunkt $S$ des Systems folgt daraus:
$
  Hh ket(Psi_"el" (R)) & = [hat(p)^2/(2 m) - e^2/(4 pi eps_0) (1/hat(r)_A + 1/hat(r)_B - 1/hat(R))] ket(Psi_"el" (R)) \
  & = E_"ges" ket(Psi_"el" (R))
$
Im Ortsraum geht diese Gleichung über in
#math.equation(block: true, numbering: none, $
  Hh Psi_"el" (r, R) & = [(-planck^2)/(2 m) nabla^2 - e^2/(4 pi eps_0) (1/r_A + 1/r_B - 1/R)] Psi_"el" (r, R) \
  & = [Hh_(H,A) - e^2/(4 pi eps_0) (1/r_B - 1/R)] Psi_"el" (r, R) = E_"ges" Psi_"el" (r, R)
$)
mit dem Hamilton-Operator des Wasserstoffatoms $Hh_H$.

#task(label: "b")[_Zeigen sie am Beispiel des $H_2^+$-Grundzustands, dass der Ansatz der LCAO-Näherung zu zwei verschiedenen Molekülorbitalen führt._ (1 Punkt)]

Die LCAO-Näherung geht davon aus, dass das Molekülproblem durch lineare Überlagerung der beteiligten Atomorbitale lösbar ist. Rein anschaulich ist klar, dass diese Näherung vor allem für große Kernabstände gute Ergebnisse liefern sollte, da das System dann zwei dissoziierten Atomen besonders ähnlich ist. Im Falle des $H_2^+$-Ions sind die beteiligten Wellenfunktion im Grundzustand die rein reellen 1s-Wasserstofforbitale
$ Psi_(1s,i) (r_i) = 1/sqrt(pi a_0^3) e^(-r_i/a_0), $
wobei $i in {A, B}$ die beiden Kerne indiziert und $a_0$ den Bohrschen Radius bezeichnet. Die Molekülwellenfunktion konstruiert man hieraus durch
$ Psi_"el" (r, R) = c_A PsiA + c_B PsiB $
mit konstanten Koeffizienten $c_i in RR$. Koeffizienten aus $CC$ mit relativer Phase $e^(i phi.alt)$ zwischen den 1s-Grundzuständen sind prinzipiell auch möglich und verletzen die Forderung nicht, dass man das Elektron bei beiden Kernen mit gleicher Wahrscheinlichkeit vorfindet. Diese zusätzliche Allgemeinheit liefert aber keine weiteren Erkenntnisse. Die Normierung der Molekülwellenfunktion erfordert
$
  1 & limits(=)^! integral_(RR^3) |Psi_"el" (r, R)|^2 dd(3, r) = c_A^2 integral_(RR^3) |PsiA|^2 dd(3, r) \
  & quad + c_B^2 integral_(RR^3) |PsiB|^2 dd(3, r) \
  & quad + 2 c_A c_B "Re" integral_(RR^3) Psi_(1s,A)^* (r_A) PsiB dd(3, r) \
  <=> quad 1 & = c_A^2 + c_B^2 + 2 c_A c_B "Re"(S_(A B))
$ <eq:normalization>
$S_(A B)$ ist eine Abkürzung für das Überlappintegral der beiden Atomorbitale. Im Falle von 1s-Orbitalen ist es rein reell, sodass die Reduktion auf den Realteil hinfällig ist. Allein aufgrund der Symmetrie des Moleküls, also der Tatsache dass beide Kerne gleich und sogar ununterscheidbar sind, muss gelten, dass $|c_A| = |c_B|$ und da $c_A, c_B in RR$ äquivalent dazu $c_A = plus.minus c_B$. Alles andere würde bedeuten, dass das Elektron einen der Kerne bevorzugt. In @eq:normalization eingesetzt ergibt das
$
  1 & = c_A^2 + c_B^2 + 2 c_A c_B thin S_(A B) = 2 c_A^2 plus.minus 2 c_A^2 thin S_(A B) \
  => quad c_A & = plus.minus 1/sqrt(2 plus.minus 2 S_(A B)) = plus.minus c_B
$
Daraus ergeben sich vier mögliche Molekülorbitale
$
  Psi_"el"^(++) (r, R) & = (PsiA + PsiB)/sqrt(2 + 2 S_(A B)) \
  Psi_"el"^(+-) (r, R) & = (PsiA - PsiB)/sqrt(2 - 2 S_(A B)) \
  Psi_"el"^(-+) (r, R) & = (-PsiA + PsiB)/sqrt(2 - 2 S_(A B)) \
  Psi_"el"^(--) (r, R) & = (-PsiA - PsiB)/sqrt(2 + 2 S_(A B))
$
Dabei unterscheiden sich jeweils die erste und die vierte sowie die zweite und die dritte Wellenfunktion nur im Vorzeichen. Linear unabhängig sind höchstens zwei dieser Gleichungen. Man wählt als die beiden Molekülorbitale aus der LCAO-Näherung in der Regel die erste und zweite Wellenfunktion.

#task(label: "c")[_Zeigen sie durch explizites Lösen des LCAO-Ansatzes, dass nur eines der beiden Molekülorbitale einen bindenden Zustand beschreibt. Welche Bindungsenergie hat dieser Zustand?_ (4 Punkte)]

Man berechnet den Energieerwartungswert mithilfe des Hamilton-Operators
$
  chevron.l E_plus.minus chevron.r & = 1/(2 plus.minus 2 S_(A B)) (braket(PsiA, Hh, PsiA) \
  & quad + braket(PsiB, Hh, PsiB) \
  & quad plus.minus 2 braket(PsiA, Hh, PsiB)) \
  & = 1/(1 plus.minus S_(A B)) (braket(PsiA, Hh, PsiA) \
  & quad plus.minus braket(PsiA, Hh, PsiB))
$ <eq:energy-expectation>
Hierbei wurde wieder ausgenutzt, dass die beiden Kerne gleich sind, sodass der Energieerwartungswert des Elektrons nicht davon abhängt, bei welchem Kern es sich aufhält, d.h.
$ braket(PsiA, Hh, PsiA) = braket(PsiB, Hh, PsiB) $
Die Lösung der in @eq:energy-expectation auftretenden Integrale berechnet man am einfachsten in elliptischen Koordinaten. Die Transformationsformeln lauten
#math.equation(block: true, numbering: none, $ {R, r_A, r_B} -> {mu, nu, phi.alt} = {(r_A + r_B)/R, (r_A - r_B)/R, phi.alt} $)
wobei $phi.alt$ der Azimutwinkel um die Kernverbindungsachse ist. Das Volumenelement und die Rücktransformation lauten
$ dd(3, r) = R^3/8 (mu^2 - nu^2) dif mu dif nu dif phi.alt $
$ r_A = R/2 (mu + nu) #h(3em) r_B = R/2 (mu - nu) $
Für das Überlappintegral erhält man damit
#math.equation(block: true, numbering: none, $
  S_(A B) & = 1/(pi a_0^3) integral_(RR^3) e^(-(r_A + r_B)/a_0) dd(3, r) \
  & = R^3/(8 pi a_0^3) [integral_1^infinity integral_(-1)^1 integral_0^(2 pi) (mu^2 - nu^2) e^(-R mu\/a_0) dif phi.alt dif nu dif mu] \
  & = e^(-R\/a_0) (1 + R/a_0 + R^2/(3 a_0^2))
$)
Die Berechnung der in Gleichung @eq:energy-expectation auftretenden Erwartungswerte
#math.equation(block: true, numbering: none, $ braket(Psi_(1s,A) (r_A), Hh, Psi_(1s,A) (r_A)) "und" braket(Psi_(1s,A) (r_A), Hh, Psi_(1s,B) (r_B)) $)
erfolgt recht ähnlich, wird aber aufgrund der Länge nicht ausgeführt. Das Ergebnis lässt sich mithilfe von $rho = R\/a_0$ und der Energie $E_(1s)$ des 1s-Orbitals eines einzelnen Wasserstoffatoms wie folgt schreiben
$
  E_plus.minus (rho) = E_(1s)/(1 plus.minus S_(A B)) [1 - 2/rho (1 + rho) e^(-2 rho) \
  plus.minus (1 - 2\/rho) S_(A B) plus.minus 2(1 + rho) e^(-rho)]
$
Dieses Ergebnis kann am einfachsten grafisch interpretiert werden. @fig:lcao-energies zeigt den funktionellen Verlauf von $E_plus.minus (rho)$. Offenbar weist nur die Energie der symmetrischen Linearkombination $Psi_"el"^+ (r, R)$ der 1s-Atomorbitale ein Minimum bei einem Kernabstand von etwa 2,5 Bohrschen Radien auf. Ein Potentialminimum unterhalb der Energie $E_(1s)$ der getrennten Bestandteile ist für die Existenz eines gebundenen Zustands zwingend erforderlich. Am Minimum $rho approx "2,49"$ ist $E_+ approx "1,13" E_(1s)$, die Bindungsenergie in der LCAO-Näherung beträgt also etwa $"1,76" unit("eV")$ (experimentell: $"2,65" unit("eV")$).

#figure(
  fig("sheet-08-lcao-energies", width: 50%),
  caption: [Energien der beiden Molekülorbitale aus dem LCAO-Ansatz für verschiedene Kernabstände. $E_+ (rho)$ ist die Energie des symmetrischen Zustands, entsprechend $E_- (rho)$ die des antisymmetrischen.],
) <fig:lcao-energies>

= Stabile und instabile Moleküle #pts(9)

#task[_Hinweis: Gehen sie analog zur Tabelle in Kapitel 6.3 der Vorlesung vor._]

#task(label: "a")[_Obwohl das Molekül $H e_2$ instabil ist und nicht vorkommt, ist das Molekül-Ion $H e_2^+$ stabil und hat etwa die Bindungsenergie von $H_2^+$. Erklären sie diese Tatsache mit Hilfe des Molekülorbitalbildes._ (3 Punkte)]

Im Molekülorbitalbild werden die Elektronenorbitale des Moleküls nach der LCAO-Methode aus den Orbitalen der einzelnen Atome konstruiert. Daraus ergeben sich sowohl bindende als auch antibindende Molekülorbitale. Ob ein bestimmtes Orbital bindend oder antibindend wirkt, lässt sich nur durch Lösen der Schrödinger-Gleichung ermitteln. Anschließend werden diese Orbitale analog zu Atomen in der energetisch günstigsten Reihenfolge nach und nach mit den Elektronen des Moleküls besetzt, bis alle verteilt sind. Hierbei sind natürlich Besetzungsregeln, wie das Pauli-Prinzip zu berücksichtigen. Die entscheidende Aussage des Molekülorbitalbilds ist nun, dass ein Molekül nur dann existieren kann, wenn die Anzahl der Elektronen in bindenden Orbitalen größer ist als die in antibindenden.

Im Hinblick auf das Helium-Molekül $H e_2$ zeigt sich, dass dessen vier Elektronen gerade die ersten beiden Molekülorbitale $1s thin sigma_g$ und $1s thin sigma_u^*$ vollständig auffüllen, d.h. $(1s thin sigma_g)^2 (1s thin sigma_u^*)^2$. Diese Orbitale sind bindend bzw. antibindend, sodass keine Nettobindung vorliegt und das Molekül nicht existieren kann. Das Helium-Ion $H e_2^+$ hat gerade ein Elektron weniger, sodass das energetisch höher liegende antibindende Orbital nur halb besetzt ist. Hier liegt also, genau wie beim $H_2^+$, _ein_ nettobindendes Elektron#footnote[Man spricht in diesem Zusammenhang häufig von dem Bindungsgrad $n = 1/2 (N_"bind" - N_"abind")$ definiert über die Anzahl der Elektronen in (anti-)bindenden Molekülorbitalen. In diesem Beispiel hat das Heliumion $H e_2^+$, ebenso wie das $H_2^+$-Ion, einen Bindungsgrad von $n(H e_2^+) = (2 - 1)/2 = 1/2$. Für weitere Informationen, siehe LCAO-Methode, Universität Paderborn.] vor, sodass das Molekül einen stabilen Zustand bildet.

#task(label: "b")[
  _Überprüfen sie, ob die folgenden Sauerstoff-Molekülionen stabil sind._ (3 Punkte)
  #set enum(numbering: "1.")
  + _Disauerstoffkation $O_2^+$_
  + _Hyperoxidanion $O_2^-$_
  + _Peroxidanion $O_2^(2-)$_
]

Das reguläre Sauerstoff-Molekül $O_2$ hat insgesamt 16 Elektronen und besetzt damit die Orbitale
#math.equation(block: true, numbering: none, $ (1s thin sigma_g)^2 (1s thin sigma_u^*)^2 (2s thin sigma_g)^2 (2s thin sigma_u^*)^2 (2p thin sigma_g)^2 (2p thin pi_u)^4 (2p thin pi_g^*)^2 $)
Eine Bindung wird mit einem Stern ($""^*$) gekennzeichnet, wenn sich die Wellenfunktion des zugehörigen Orbitals ungerade bezüglich Spiegelungen an der Mittelebene beider Atomkerne ($z -> -z$) verhält. Solche Wellenfunktion verschwinden notwendigerweise in allen Punkten der Mittelebene (Knotenebene), sodass es sich hierbei stets um antibindende Orbitale handelt. Man erhält nun durch einfaches Abzählen, dass im Sauerstoff-Molekül 10 Elektronen bindende und 6 Elektronen antibindende Orbitale besetzen. Man sagt, Sauerstoff hat den Bindungsgrad $n(O_2) = 1/2 (10 - 6) = 2$. Die Aussage des Molekülorbitalbildes ist, dass alle Moleküle mit einem positiven Bindungsgrad und somit auch das Sauerstoffmolekül stabile Zustände bilden.

#[
  #set enum(numbering: "1.")
  + Dem Disauerstoffkation $O_2^+$ fehlt eines der zwei energetisch höchst gelegenen Elektronen des antibindenden $2p thin pi_g^*$-Orbitals. Der Bindungsgrad steigt deshalb auf $n(O_2^+) = 1/2 (10 - 5) = 5/2$.
  + Im Hyperoxidanion $O_2^-$ ist genau umgekehrt, hier sinkt der Bindungsgrad $n(O_2^-) = 1/2 (10 - 7) = 3/2$.
  + Das Peroxidanion $O_2^(2-)$ geht einen (Halb-)Schritt weiter: $n(O_2^(2-)) = 1/2 (10 - 8) = 1$.
]

#task(label: "c")[_Ordnen sie diese Sauerstoff-Molekülionen und das Sauerstoffmolekül $O_2$ nach ihren Bindungsenergien._]

Die Bindungsenergie $E_"Bind"$ steigt mit dem Bindungsgrad $n$. Auf Basis des Molekülorbitalbildes würde man wegen $n(O_2^(2-)) < n(O_2^-) < n(O_2^+)$ sagen, dass das Peroxidanion am schwächsten gebunden ist, das Hyperoxidanion bereits stärker, aber immer noch schwächer, als nicht-ionische Sauerstoffmoleküle. Das Disauerstoffkation sollte hingegen sehr stark gebunden sein. Tatsächlich findet man im Experiment

#figure(
  table(
    columns: 5,
    stroke: none,
    align: left,
    inset: (x: 8pt, y: 4.5pt),
    table.hline(stroke: 0.8pt),
    [], [$O_2^(2-)$], [$O_2^-$], [$O_2$], [$O_2^+$],
    table.hline(stroke: 0.5pt),
    [$n$], [1], [$3/2$], [2], [$5/2$],
    [$E_"Bind"$], [$1","44 unit("eV")$], [$4","12 unit("eV")$], [$5","11 unit("eV")$], [$6","55 unit("eV")$],
    table.hline(stroke: 0.8pt),
  ),
  caption: [Bindungsgrade und -energien verschiedener Sauerstoffmoleküle],
  kind: table,
)
