#import "/notes.typ": task, vb
#import "/atomic-physics/sheet.typ": sheet, pts, up, dn
#import "@preview/cetz:0.5.2": canvas, draw

#show: sheet.with([Übungsblatt 5], [20.~Mai 2014])

#let (br1, br2) = ($vb(r)_1$, $vb(r)_2$)
// spectroscopic term symbol n^(2S+1)L_J
#let term(n: none, mult, l, j) = $#n attach(#l, tl: #mult, br: #j)$

#heading(numbering: none)[Präsenzaufgaben]

= Identische Teilchen

#task[Es soll untersucht werden welche Konsequenzen die Ununterscheidbarkeit von identischen Teilchen für die gesamte Quantenmechanik hat. Für eine $N$-Teilchen-Wellenfunktion vertausche der hermitische Operator $hat(P)_(i j)$ sämtliche Koordinaten, also Ort und Spin, der Teilchen $i$ und $j$
  $ hat(P)_(i j) Psi(1, ..., i, ..., j, ..., N) = Psi(1, ..., j, ..., i, ..., N) $]

#task(label: "a")[Überlegen sie welche Eigenwerte $hat(P)_(i j)$ haben kann. Beachten Sie, dass die zweifache Anwendung von $hat(P)_(i j)$ die Identität ergibt. Konstruieren Sie für zwei Teilchen ($N = 2$) die symmetrischen bzw. antisymmetrischen Wellenfunktionen die Eigenfunktionen zu $hat(P)_(i j)$ sind.]

Aufgrund der Hermitizität steht bereits fest, dass $hat(P)_(i j)$ ausschließlich reelle Eigenwerte besitzt. Da die zweifache Vertauschung $hat(P)_(i j)^2$ der Teilchen $i$ und $j$ das $N$-Teilchensystem nicht verändert, gilt mit $lambda in RR$ Eigenwert zu $hat(P)_(i j)$:
$ Psi_(i j) = hat(P)_(i j)^2 Psi_(i j) = hat(P)_(i j) lambda Psi_(i j) = lambda^2 Psi_(i j) quad => quad lambda^2 = 1 $
Hierbei ist $Psi_(i j) = Psi(1, ..., i, ..., j, ..., N)$ lediglich eine Kurzschreibweise. Offenbar ist also $lambda = plus.minus 1$. Man konstruiert nun die Gesamtwellenfunktion eines Systems aus $N = 2$ Teilchen aus der Verknüpfung ihrer Einteilchen-Wellenfunktionen. Im Falle ununterscheidbarer Teilchen lassen sich so genau eine bezüglich Teilchenaustausch symmetrische und eine antisymmetrische (normierte) Ortswellenfunktion bilden:
$
  Psi_plus.minus (br1, br2) & = 1/sqrt(2) (Psi_1 (br1) Psi_2 (br2) plus.minus Psi_1 (br2) Psi_2 (br1)) \
  & = plus.minus 1/sqrt(2) (Psi_1 (br2) Psi_2 (br1) plus.minus Psi_1 (br1) Psi_2 (br2)) = plus.minus Psi_plus.minus (br2, br1)
$ <eq:psi-pm>

#task(label: "b")[Berechnen sie für symmetrische und antisymmetrische Ortswellenfunktionen die Wahrscheinlichkeit, zwei Teilchen am selben Ort $r_i = r_j$ anzutreffen, d.h. den Erwartungswert $chevron.l delta(vb(r)_i - vb(r)_j) chevron.r$.]

Der Erwartungswert für das Ereignis, zwei identische Teilchen am selben Ort vorzufinden, beträgt im Falle der symmetrischen Ortswellenfunktion
$
  chevron.l delta(br1 - br2) chevron.r_(Psi_+) & = chevron.l Psi_+ (br1, br2)|delta(br1 - br2)|Psi_+ (br1, br2) chevron.r \
  & = 1/2 chevron.l Psi_1 (br1) Psi_2 (br2) + Psi_1 (br2) Psi_2 (br1)|delta(br1 - br2)|Psi_1 (br1) Psi_2 (br2) + Psi_1 (br2) Psi_2 (br1) chevron.r \
  & = 1/2 chevron.l Psi_1 (br2) Psi_2 (br2) + Psi_1 (br2) Psi_2 (br2)|Psi_1 (br2) Psi_2 (br2) + Psi_1 (br2) Psi_2 (br2) chevron.r \
  & = 2 chevron.l Psi_1 (br2) Psi_2 (br2)|Psi_1 (br2) Psi_2 (br2) chevron.r
$ <eq:delta-sym>
Dieser Ausdruck ist immer dann ungleich null, wenn die Teilwellenfunktionen $Psi_1 (br2)$ und $Psi_2 (br2)$ nicht disjunkten Träger aufweisen, d.h. wenn es Bereiche gibt, an denen beide Wellenfunktionen nicht verschwindende Wahrscheinlichkeitsdichte aufweisen. Es ist also im Allgemeinen möglich, zwei identische Teilchen, die durch eine symmetrische Ortswellenfunktion beschrieben werden, am gleichen Ort anzutreffen. Im antisymmetrischen Fall gilt
$
  chevron.l delta(br1 - br2) chevron.r_(Psi_-) & = chevron.l Psi_- (br1, br2)|delta(br1 - br2)|Psi_- (br1, br2) chevron.r \
  & = 1/2 chevron.l Psi_1 (br1) Psi_2 (br2) - Psi_1 (br2) Psi_2 (br1)|delta(br1 - br2)|Psi_1 (br1) Psi_2 (br2) - Psi_1 (br2) Psi_2 (br1) chevron.r \
  & = 1/2 chevron.l Psi_1 (br2) Psi_2 (br2) - Psi_1 (br2) Psi_2 (br2)|Psi_1 (br2) Psi_2 (br2) - Psi_1 (br2) Psi_2 (br2) chevron.r = 0.
$ <eq:delta-antisym>
Es ist prinzipiell unmöglich, zwei Teilchen mit antisymmetrischer Ortswellenfunktion zur gleichen Zeit am gleichen Ort vorzufinden.

#task(label: "c")[Zeigen Sie allgemein, dass symmetrische und antisymmetrische Zustände orthogonal zueinander sind, indem Sie $hat(P)_(i j)^2 = 1$ benutzen.]

Mit dem Tipp in der Aufgabenstellung zeigt man leicht
$
  chevron.l Psi_+ | Psi_- chevron.r & = chevron.l Psi_+ |hat(P)_(i j)^2| Psi_- chevron.r = chevron.l hat(P)_(i j) Psi_+ | hat(P)_(i j) Psi_- chevron.r \
  & = chevron.l Psi_+ | -Psi_- chevron.r = -chevron.l Psi_+ | Psi_- chevron.r
$ <eq:orthogonal>
Gleichung @eq:orthogonal kann nur erfüllt sein, wenn $chevron.l Psi_+ | Psi_- chevron.r = 0$.

#task(label: "d")[Antisymmetrische $N$-Teilchen Wellenfunktionen lassen sich als sogenannte Slater-Determinante schreiben. Erläutern Sie welchen Wert die Wellenfunktion annimmt, falls zwei Teilchen exakt die gleichen Quantenzahlen haben und wie sich dies in der Struktur der Slater-Determinante ausdrückt.]

Die Slater-Determinante ist eine sehr kompakte Schreibweise für antisymmetrische $N$-Teilchen-Wellenfunktionen.
$
  Psi(1, ..., N) = 1/sqrt(N!) mat(
    delim: "|",
    Psi_1 (1), Psi_2 (1), dots.c, Psi_N (1);
    Psi_1 (2), Psi_2 (2), dots.c, Psi_N (2);
    dots.v, dots.v, dots.down, dots.v;
    Psi_1 (N), Psi_2 (N), dots.c, Psi_N (N)
  )
$
Hierbei bedeutet $Psi_j (i)$, dass sich das $i$-te Teilchen im Einteilchenzustand $Psi_j$ befindet, d.h. dass sowohl Ort als auch Spin von Teilchen $i$ durch $Psi_j$ beschrieben wird. $Psi_j$ wäre zum Beispiel beim Wasserstoffatom die Wellenfunktion zum $j$-ten Energieeigenwert. Wie man sieht, ist die Vertauschung zweier Teilchenkoordinaten $i_1$ und $i_2$ äquivalent zur Vertauschung der $i_1$-ten und $i_2$-ten Zeile der Slater-Determinante. In der Tensor-Algebra wird die Slater-Determinante als antisymmetrisches Tensorprodukt klassifiziert. Sie ähnelt einer echten Determinante insofern, als dass sie unter Vertauschung zweier Zeilen bzw. Spalten das Vorzeichen ändert.

Gilt nun für irgendwelche zwei Teilchen, dass sie identische Quantenzahlen haben, d.h. dass sie sich im selben Einteilchenzustand $Psi_(j_1) = Psi_(j_2)$ befinden, dann sind die $j_1$-te und $j_2$-te Spalte der Slater-Determinante identisch. Die Vertauschung dieser beiden Spalten lässt die Determinante also unverändert, wechselt aber gleichzeitig ihr Vorzeichen. Nach derselben Logik, die in *c)* verwendet wurde, muss für diesen Fall die Gesamtwellenfunktion verschwinden (Pauli-Prinzip).

#task(label: "e")[Konstruieren Sie für zwei Teilchen mit Spin 1/2 die antisymmetrische Gesamtwellenfunktion aus Orts- und Spinanteil mithilfe eines Produktansatzes. Was folgt für die Wahrscheinlichkeit, die Teilchen am selben Ort anzutreffen?]

Die Gesamtwellenfunktion setzt sich folgendermaßen aus einer Kombination jeweils symmetrischer und antisymmetrischer Orts- und Spinwellenfunktionen zusammen
$
  Psi_"ges" (1, 2) = 1/2 ( & (Psi_1 (br1) Psi_2 (br2) + Psi_1 (br2) Psi_2 (br1)) chi_(S, m_S) \
  & + (Psi_1 (br1) Psi_2 (br2) - Psi_1 (br2) Psi_2 (br1)) lambda_(S, m_S))
$
Hierbei ist die antisymmetrische Spinwellenfunktion $chi_(S, m_S)$ zwei identischer Spin-$1/2$-Teilchen eindeutig festgelegt:
$ chi_("0,0") (1, 2) = 1/sqrt(2) (chi_up (1) chi_dn (2) - chi_up (2) chi_dn (1)) $
Für eine symmetrische Spinwellenfunktion $lambda_(S, m_S)$ zweier Spin-$1/2$-Teilchen gibt es hingegen drei Möglichkeiten:
$
  lambda_("1,1") (1, 2) & = lambda_up (1) dot lambda_up (2) \
  lambda_("1,0") (1, 2) & = 1/sqrt(2) (lambda_up (1) dot lambda_dn (2) + lambda_up (2) dot lambda_dn (1)) \
  lambda_(1,-1) (1, 2) & = lambda_dn (1) dot lambda_dn (2)
$
Die Wahrscheinlichkeit, beide Teilchen am selben Ort anzutreffen, ist wieder durch den Erwartungswert des Operators $delta(br1 - br2)$ gegeben. Da der Operator nur auf den Ortsteil der Wellenfunktion wirkt, wird die Integration über die orthonormalen Spinzustände stets eins ergeben. Es treten auch keine Mischterme aus symmetrischen und antisymmetrischen Spinwellenfunktionen auf, da die symmetrischen und antisymmetrischen Spinwellenfunktionen wie in *c)* gezeigt orthogonal sind. Die Spinanteile stellen in dieser Rechnung deshalb nur Ballast dar und werden von vornherein weggelassen. Unter diesen Vorüberlegungen erkennt man, dass diese Rechnung effektiv nur eine Kombination von @eq:delta-sym und @eq:delta-antisym ist. Das Ergebnis kann somit direkt hingeschrieben werden
$
  chevron.l delta(br1 - br2) chevron.r_(Psi_"ges") & = chevron.l Psi_"ges" |delta(br1 - br2)| Psi_"ges" chevron.r \
  & = chevron.l Psi_1 (br2) Psi_2 (br2)|Psi_1 (br2) Psi_2 (br2) chevron.r
$

#heading(numbering: none)[Übungsaufgaben]
#counter(heading).update(0)

= $L S$- und $j j$-Kopplung #pts(8)

#task[Betrachten sie ein Zwei-Elektronensystem mit einem $2p$ und einem $3d$ Elektron.]

#task(label: "a")[Nehmen sie an, dass die Spin-Bahn-Wechselwirkung der beiden Elektronen sehr stark ist. Bestimmen sie die möglichen Terme in der Form $(j_1, j_2)_J$, wenn reine $j j$-Kopplung vorliegt. (2 Punkte)]

Das $2p$-Elektron trägt die Quantenzahlen $n_(2p) = 2$, $l_(2p) = 1$ und das $3d$-Elektron $n_(3d) = 3$, $l_(3d) = 2$. Außerdem haben beide die Spinquantenzahl $s = 1\/2$.

Mit der Anzahl der Elektronen eines Atoms wächst auch die Stärke der Spin-Bahn-Wechselwirkung. Dies wird anhand der Spin-Bahn-Kopplungskonstante deutlich.
$ a = (Z e^2 mu_0 planck^2)/(8 pi m_e^2 chevron.l r^3 chevron.r) $
$1 \/ chevron.l r^3 chevron.r$ ist hierbei quantenmechanisch als Erwartungswert $chevron.l 1\/r^3 chevron.r$ zu interpretieren und gegeben durch
$ chevron.l 1/r^3 chevron.r = Z^3/(n^3 a_0^3 l (l + 1)(l + 1/2)), $
mit dem Bohrschen Radius $a_0$. Die Stärke der Spin-Bahn-Wechselwirkung wächst sogar mit der vierten Potenz der Kernladungszahl $Z$. Aus diesem Grund spielt in schweren Atomen die gegenseitige Coulomb-Wechselwirkung unter den Elektronen eine untergeordnete Rolle. Für ein leichtes Atom wie Helium ($Z = 2$) ist die Vernachlässigung der Coulomb-Kräfte unter den Elektronen allerdings eine grobe Näherung.

Geht man trotzdem von reiner $j j$-Kopplung aus, so wird der Zustand jedes Elektron durch die "gute" Quantenzahl $j_i$ beschrieben. Die Einzelspins $s_i$ und -drehimpulse $l_i$ aller Elektronen setzen sich also zunächst zu Einzelgesamtdrehimpulsen $j_i$ zusammen. Diese $j_i$ koppeln dann zum Gesamtdrehimpuls der Atomhülle $J$. Die quantenmechanische Addition zweier Drehimpulsquantenzahlen, hier $s_i$ und $l_i$, kann Werte aus der Menge
$ j_i in {|l_i - s_i|, |l_i - s_i| + 1, ..., l_i + s_i} $ <eq:addition>
annehmen. Für das $2p$- und $3d$-Elektron sind mögliche Gesamtdrehimpulse
$ j_(2p) in {1/2, 3/2} #h(3em) j_(3d) in {3/2, 5/2} $
Der Gesamtdrehimpuls der Hülle kann ebenfalls nach Gleichung @eq:addition berechnet werden.
$
  J in cases(
    {1, 2} & "für" j_(2p) = 1/2\, j_(3d) = 3/2,
    {2, 3} & "für" j_(2p) = 1/2\, j_(3d) = 5/2,
    {0, 1, 2, 3} & "für" j_(2p) = 3/2\, j_(3d) = 3/2,
    {1, 2, 3, 4} quad & "für" j_(2p) = 3/2\, j_(3d) = 5/2,
  )
$
Es gibt also genau 12 verschiedene Konfigurationen der Beträge von Spin- und Drehimpulsvektoren dieses Systems aus zwei Elektronen. Hierbei wurden mögliche Unterscheidungen in den $z$-Komponenten noch nicht berücksichtigt.

In der durch die Aufgabenstellung angegebenen Schreibweise lauten diese Konfigurationen
$ (1/2, 3/2)_("1,2") quad (1/2, 5/2)_("2,3") quad (3/2, 3/2)_("0,1,2,3") quad (3/2, 5/2)_("1,2,3,4") $

#task(label: "b")[Betrachten sie dasselbe Problem im Fall schwacher Spin-Bahn-Kopplung, so dass reine $L S$-Kopplung der beiden Elektronen angenommen werden kann. Geben sie die möglichen Terme in der Form $term(2S+1, L, J)$ an. Zeigen sie, dass die Zahl der möglichen Zustände und deren Gesamtdrehimpuls dieselben sind wie im Fall der $j j$-Kopplung. (4 Punkte)]

Die $L S$-Kopplung dominiert die Aufspaltung der Feinstruktur von leichten Atomen, da die Spin-Bahn-Kopplung in Systemen mit einer geringen Anzahl an Elektronen sehr schwach ausfällt. Die $L S$-Kopplung sollte deshalb insbesondere nicht mit der Spin-Bahn-Kopplung einzelner Elektronen verwechselt werden. Die $l s$-Kopplung bezeichnet den Einfluss, den die relative Ausrichtung von Spin und Bahndrehimpuls eines einzelnen Elektrons auf die Energieniveaus in einem Atom haben. Dieser Einfluss wird bei der Kopplung des Gesamtbahndrehimpulses $L$ mit dem Gesamtspin $S$ einer Atomhülle gerade vernachlässigt.

Elektronen wechselwirken also in der reinen $L S$-Kopplung nur über ihre gegenseitige Coulombabstoßung und haben keine Zustände mehr, die sich durch ihren Gesamtdrehimpuls $j$ charakterisieren lassen. Stattdessen ist es praktikabel, die Gesamtwellenfunktion eines atomaren Energieeigenzustands als Produkt aus Orts- und Spinwellenfunktion aller Elektronen zu schreiben. Diese Gesamtwellenfunktionen können mit der spektroskopischen Notation $term(n: n, 2S+1, L, J)$ bzw. $term(2S+1, L, J)$, falls die Hauptquantenzahl nicht von Interesse ist, gekennzeichnet werden.

$S$ und $L$ können nach Gleichung @eq:addition wegen $l_(2p) = 1$, $l_(3d) = 2$ und $s_(2p) = s_(3d) = 1/2$ folgende Werte sein:
$ S in {0, 1} #h(3em) L in {1, 2, 3} $
Daraus ergeben sich folgende Möglichkeiten für den Gesamtdrehimpuls der Atomhülle
$
  J in cases(
    {1} & "für" S = 0\, L = 1,
    {2} & "für" S = 0\, L = 2,
    {3} & "für" S = 0\, L = 3,
    {0, 1, 2} quad & "für" S = 1\, L = 1,
    {1, 2, 3} & "für" S = 1\, L = 2,
    {2, 3, 4} & "für" S = 1\, L = 3,
  )
$
Es sind wieder 12 verschiedene Konfigurationen. Die Häufigkeiten der auftretenden $J$-Quantenzahlen sind sowohl hier als auch in Aufgabenteil *a)*
$
  J = 0 : 1 "Mal" quad J = 1 : 3 "Mal" quad J = 2 : 4 "Mal" \
  J = 3 : 3 "Mal" quad J = 4 : 1 "Mal"
$
Die zugehörigen spektroskopischen Bezeichnungen der Zustände lauten
$
  & term(1, 1, 1) quad term(1, 2, 2) quad term(1, 3, 3) quad term(3, 1, "0,1,2") quad term(3, 2, "1,2,3") quad term(3, 3, "2,3,4") \
  "bzw." quad & term(1, P, 1) quad term(1, D, 2) quad term(1, F, 3) quad term(3, P, "0,1,2") quad term(3, D, "1,2,3") quad term(3, F, "2,3,4")
$

#task(label: "c")[Berücksichtigen sie nun zusätzlich einen Atomkern mit dem Kernspin $I = 3\/2$. In wie viele Hyperfeinkomponenten spaltet der $term(3, D, 3)$-Term aus Aufgabenteil *b)* auf? Geben sie die möglichen Werte der Gesamtdrehimpulsquantenzahl $F$ an. (2 Punkte)]

Die Wechselwirkungsenergie der Hyperfeinstruktur ist gegeben durch
$ Delta V_"HFS" = A/2 (F(F + 1) - J(J + 1) - I(I + 1)) $
$J = 3$ und $I = 3/2$ sind fest, sodass $Delta V_"HFS"$ nur noch von der Gesamtdrehimpulsquantenzahl $F$ des Atoms#footnote[Der Kern wird bei diesen Betrachtungen stets als ruhend angenommen, sodass er keinen Drehimpuls, sondern nur Spin beiträgt. Folglich ist der Gesamtdrehimpuls $vb(F) = vb(J) + vb(I) = vb(L) + vb(S) + vb(I)$ die Summe aus Hüllenbahndrehimpuls $vb(L)$, Hüllenspin $vb(S)$ und Kernspin $vb(I)$.] abhängt. $F$ kann die vier Werte $3/2$, $5/2$, $7/2$ und $9/2$ annehmen, sodass der $term(3, D, 3)$ auch in genau vier Hyperfeinkomponenten aufspaltet.

= Das Helium-Atom #pts(12)

#task[Das Helium-Atom besteht aus einem Kern der Ladung $Q = 2 e$ und zwei Elektronen.]

#task(label: "a")[Wie lautet der Hamiltonoperator für das Helium-Atom, wenn ausschließlich die Coulombsche Wechselwirkungsenergie zwischen den Teilchen berücksichtigt wird? (1 Punkt)]

In der Atomphysik geht man so vor, den Hamilton-Operator des freien Teilchens schrittweise um Wechselwirkungsterme zunehmend geringerer Einflüsse auf die Energieniveaus zu erweitern und dadurch quasi Stück für Stück der tatsächlichen Physik von Elektronen im Atom näher zu kommen. Der stärkste Beitrag zur potentiellen Energie stammt aus dem Coulomb-Potential des Kerns. Ein vor allem in leichten Atomen, wie Helium, ebenfalls starker Effekt ist die Abstoßung zwischen verschiedenen Elektronen der Hülle. Noch genauere Korrekturen, z.B. Spin-Bahn- und Spin-Spin-Wechselwirkungen erzeugen die Fein- und Hyperfeinstruktur.

Der Hamiltonoperator des Helium-Atoms im Ortsraum nach Abseparation der Schwerpunktsbewegung und unter Berücksichtigung lediglich der kinetischen und Coulombschen Energien hat dann die Form#footnote[Hierbei wurde der sogenannte Massenpolarisierungsterm vernachlässigt. Er rührt daher, dass der Schwerpunkt des Systems eigentlich nicht der Ort $r_K$ des Atomkerns ist, auf den die Relativkoordinaten der Elektronen bezogen sind (s. S. 69, Friedrich "Theoretische Atomphysik").]
$
  hat(H) & = sum_(i=1)^2 (-planck^2/(2 mu) vb(nabla)_(r_i)^2 - (Z e^2)/(4 pi epsilon_0 |vb(r)_i|)) + e^2/(4 pi epsilon_0 |br1 - br2|) \
  & = -planck^2/(2 mu) (vb(nabla)_(r_1)^2 + vb(nabla)_(r_2)^2) + e^2/(4 pi epsilon_0) (-2/(|br1|) - 2/(|br2|) + 1/(|br1 - br2|))
$
Hierbei wurde $Z = 2$ für Helium benutzt. $mu$ bezeichnet die reduzierte Masse bezogen auf ein Elektron und den Kern der Masse $m_alpha approx 4 m_p$ (zwei Protonen und zwei Neutronen)
$ mu = (m_alpha m_e)/(m_alpha + m_e) $

#task(label: "b")[Vernachlässigt man die Coulombwechselwirkung zwischen den Elektronen, so können die Elektronen als unabhängig voneinander betrachtet werden. Der Grundzustand des Helium-Atoms ist dann durch die Elektronenkonfiguration $1s 1s$ gegeben. Geben sie die spektroskopische Notation dieses Zustands in der Form $term(n: n, 2S+1, L, J)$ an. Geben sie die antisymmetrisierte Wellenfunktion für diesen Zustand an unter Berücksichtigung der Orts- und Spin-Freiheitsgrade beider Elektronen.

  _Hinweis:_ $n$ ist die Hauptquantenzahl des "Leuchtelektrons", d.h. des angeregten Elektrons, hier $n = 1$. $S$ ist die Quantenzahl des Gesamtspins $vb(S) = vb(S)_1 + vb(S)_2$, $L$ entsprechend die des Gesamtbahndrehimpulses $vb(L) = vb(L)_1 + vb(L)_2$ der Elektronen. Außerdem ist $vb(J) = vb(L) + vb(S)$. (3 Punkte)]

Im $1s 1s$-Zustand ist die Hauptquantenzahl des Leuchtelektrons $n = 1$, der Gesamtspin $S in {0, 1}$ und der Gesamtbahndrehimpuls $L = 0$. Mögliche Werte für $J$ sind also ebenfalls ${0, 1}$. Da die Wellenfunktion des Systems Antisymmetrie aufweisen muss, die $1s$-Wellenfunktion und damit auch die Gesamtortswellenfunktion aber symmetrisch ist, braucht es eine antisymmetrische Spinwellenfunktion. Das ist bekanntermaßen nur mit $S = 0$ möglich. Die spektroskopische Notation des $1s 1s$-Grundzustands kann somit eindeutig als $term(n: 1, 1, 0, 0)$ angegeben werden. Mit den Ortskoordinaten $vb(r)_i$ und den Spinkoordinaten $i in {1, 2}$ der beiden Elektronen lautet die Gesamtwellenfunktion
$
  Psi_"ges"^"He" (br1, 1, br2, 2) & = Psi_"sym" (br1, br2) dot chi_("0,0") (1, 2) \
  & = Psi_(1s) (1) Psi_(1s) (2) 1/sqrt(2) (chi_up (1) chi_dn (2) - chi_up (2) chi_dn (1))
$

#task(label: "c")[Wird dem Helium-Atom genügend Energie zugeführt, so kann eines der beiden Elektronen in den Energiezustand $n = 2$ gebracht werden. Welche angeregten Zustände können in dieser Elektronenkonfiguration realisiert werden? Kennzeichnen sie diese Zustände wiederum durch die spektroskopisch relevanten Quantenzahlen in der Form $term(n: n, 2S+1, L, J)$. Welche der Zustände werden durch symmetrische, welche durch antisymmetrische Ortswellenfunktionen beschrieben? (4 Punkte)]

Die möglichen Quantenzahlen der Elektronen sind
$
  n_1 & = 1, l_1 = 0, s_1 = 1/2 \
  n_2 & = 2, l_2 in {0, 1}, s_2 = 1/2
$
Daraus ergeben sich folgende spektroskop. Quantenzahlen
$ n = 2 #h(3em) S in {0, 1} #h(3em) L in {0, 1} $
$
  J in cases(
    {0} & "für" S = 0\, L = 0,
    {1} & "für" S = 0\, L = 1,
    {1} & "für" S = 1\, L = 0,
    {0, 1, 2} quad & "für" S = 1\, L = 1,
  )
$
In der bekannten Notation also
$ term(n: 2, 1, 0, 0) wide term(n: 2, 1, 1, 1) wide term(n: 2, 3, 0, 1) wide term(n: 2, 3, 1, "0,1,2") $
Es treten insgesamt 2 Singlettzustände ($S = 0$) und vier Triplettzustände ($S = 1$) auf. Die Singlettzustände befinden sich in jedem Fall in der Spinwellenfunktion
$ chi_("0,0") (1, 2) = 1/sqrt(2) (chi_up (1) chi_dn (2) - chi_up (2) chi_dn (1)). $ <eq:singlet>
Diese Gleichung beschreibt die einzige Spinkonfiguration zweier Elektronen, in der $S = 0$ ist. Zum $S = 1$-Zustand gibt es drei Spinwellenfunktionen
$
  lambda_("1,1") (1, 2) & = lambda_up (1) dot lambda_up (2) \
  lambda_("1,0") (1, 2) & = 1/sqrt(2) (lambda_up (1) dot lambda_dn (2) + lambda_up (2) dot lambda_dn (1)) \
  lambda_(1,-1) (1, 2) & = lambda_dn (1) dot lambda_dn (2)
$
Gleichung @eq:singlet verhält sich antisymmetrisch unter Teilchenvertauschung, d.h. $chi_("0,0") (1, 2) = -chi_("0,0") (2, 1)$. Da die Gesamtwellenfunktion, also das Produkt aus Orts- und Spinwellenfunktion, eines Mehrelektronensystems wie der Atomhülle antisymmetrisch sein muss, erfordern die beiden Singlettzustände eine symmetrische Ortswellenfunktion.

Umgekehrt sind alle Triplettzustände symmetrisch unter Teilchenvertauschung, $lambda_(1, m_s) (1, 2) = lambda_(1, m_s) (2, 1)$, sodass die vier angeregten $S = 1$-Zustände eine antisymmetrische Ortswellenfunktion haben müssen.

#task(label: "d")[Betrachtet werden die Elektronenkonfigurationen $1s 2p$ und $1s 3d$. Welche Terme $term(n: n, 2S+1, L, J)$ können in diesen Elektronenkonfigurationen realisiert werden? Welche elektrischen Dipolübergänge sind zwischen diesen Termen möglich?

  _Hinweis:_ Die Auswahlregeln für die im Helium vorherrschende $L S$-Kopplung sind
  $ Delta S = 0 #h(3em) Delta L, Delta J, Delta m_J in {-1, 0, 1}, $
  aber nicht $J = 0 -> J' = 0$ oder $m_j = 0 -> m'_j = 0$. (4 Punkte)]

$1s 2p$ bedeutet $n_1 = 1$, $l_1 = 0$, $s_1 = 1/2$ und $n_2 = 2$, $l_2 = 1$, $s_2 = 1/2$. Somit lauten die spektroskopischen Quantenzahlen
$ n = 2 #h(3em) L = 1 #h(3em) S in {0, 1} $
$ J in cases({1} & "für" S = 0\, L = 1, {0, 1, 2} quad & "für" S = 1\, L = 1) $
Daraus ergeben sich die Terme $term(n: 2, 1, 1, 1)$ und $term(n: 2, 3, 1, "0,1,2")$. Für $1s 3d$ gilt sehr ähnlich $n_1 = 1$, $l_1 = 0$, $s_1 = 1/2$ und $n_2 = 3$, $l_2 = 2$, $s_2 = 1/2$.
$ n = 3 #h(3em) L = 2 #h(3em) S in {0, 1} $
$ J in cases({2} & "für" S = 0\, L = 2, {1, 2, 3} quad & "für" S = 1\, L = 2) $
Die spektroskopischen Bezeichnungen dieses Zustands sind $term(n: 3, 1, 2, 2)$ und $term(n: 3, 3, 2, "1,2,3")$.

Wegen $Delta S = 0$ kann es keine Übergänge zwischen Zuständen mit unterschiedlicher Spinquantenzahl geben. Das bedeutet, mögliche Übergänge bestehen nur zwischen $term(n: 2, 1, 1, 1) <--> term(n: 3, 1, 2, 2)$ und $term(n: 2, 3, 1, "0,1,2") <--> term(n: 3, 3, 2, "1,2,3")$. Gleichzeitig ist $Delta L != 0$, da ja eines der Elektronen seinen Bahndrehimpuls von $p equiv 1$ zu $d equiv 2$ ändern soll. Zwischen den acht zur Betrachtung stehenden Zuständen erlauben diese Auswahlregeln noch insgesamt sieben Übergänge.

#figure(
  canvas(length: 1cm, {
    import draw: *
    let (top, bottom, half) = (3, 0, 0.65)
    let xs = (0, 2.4, 4.2, 6)
    let upper = ($term(n: 3, 1, 2, 2)$, $term(n: 3, 3, 2, 1)$, $term(n: 3, 3, 2, 2)$, $term(n: 3, 3, 2, 3)$)
    let lower = ($term(n: 2, 1, 1, 1)$, $term(n: 2, 3, 1, 0)$, $term(n: 2, 3, 1, 1)$, $term(n: 2, 3, 1, 2)$)
    for (idx, x) in xs.enumerate() {
      line((x - half, top), (x + half, top), stroke: 1.2pt)
      line((x - half, bottom), (x + half, bottom), stroke: 1.2pt)
      content((x, top + 0.3), upper.at(idx))
      content((x, bottom - 0.3), lower.at(idx))
    }
    line((1.2, top + 0.5), (1.2, bottom - 0.5), stroke: (dash: "dotted"))
    // allowed transitions (upper index, lower index, horizontal offsets along the levels)
    for (up-idx, low-idx, up-dx, low-dx) in (
      (0, 0, 0, 0),
      (1, 1, -0.35, -0.2),
      (1, 2, -0.15, -0.3),
      (1, 3, 0.05, -0.4),
      (2, 2, -0.2, 0),
      (2, 3, 0, -0.1),
      (3, 3, 0, 0.3),
    ) {
      line(
        (xs.at(up-idx) + up-dx, top),
        (xs.at(low-idx) + low-dx, bottom),
        stroke: 0.6pt,
        mark: (start: "stealth", end: "stealth", fill: black, scale: 0.6),
      )
    }
  }),
  caption: [Alle möglichen elektrischen Dipolübergänge zwischen dem $1s 2p$- und $1s 3d$-Zustand eines Helium-Atoms],
)
