#import "/notes.typ": dd, task, unit, bra, ket, braket, eps
#import "/atomic-physics/sheet.typ": fig, sheet, pts, part, nonum

#show: sheet.with([Übungsblatt 9], [17\. Juni 2014])

#let (bp, br, bd, ba, bL, bE) = ($bold(p)$, $bold(r)$, $bold(d)$, $bold(a)$, $bold(L)$, $bold(E)$)
#let (AB, AB2) = ($Psi_(A 1), Psi_(B 2)$, $Psi_(A 2), Psi_(B 1)$)
#let ezz = $bold(e)_z$
#let phi1s = $phi.alt_(1s(0,0))$
#let phi2p = $phi.alt_(2p(1,0))$
#let rinv(x) = $1/r_#x$

#part[Präsenzaufgaben]

= Molekulare Struktur

#task[_$C O_2$-Molekül hat kein permanentes Dipolmoment. Was können sie daraus über die Anordnung der Atome im Molekül lernen?_]

_Vorbemerkung_: Das Dipolmoment zweier um $Delta q$ verschiedener, starr verbundener Ladungen im Abstand $br$ voneinander ist definiert als
$ bp = Delta q thin br. $
Kohlenstoff und Sauerstoff haben unterschiedliche Elektronegativitäten:
$ chi_O = 3","44 wide chi_C = 2","55 $
Dadurch entstehen im Molekül räumlich getrennte Partialladungen. Bindungen zwischen diesen Partnern sorgen für ein annähernd starres Konstrukt zwischen den Partialladungen und erzeugen somit stets ein Dipolmoment. Das $C O_2$-Molekül kann als Ganzes nur verschwindendes permanentes Dipolmoment aufweisen, wenn sich die Einzelmomente im Molekül gerade wegheben.

Um genauere Aussagen zu treffen, sind weitere Informationen über das Molekül erforderlich. Experimentell findet man, dass es keine direkten Bindungen zwischen den beiden Sauerstoffatomen gibt. Daraus folgt, dass es in $C O_2$ nur zwei Bindungsachsen gibt und somit auch nur zwei Dipolmomente, die einander entgegengerichtet sein müssen. Das ist aufgrund der Definition des Dipolmoments nur möglich, wenn alle drei Atome auf einer Geraden liegen. In der Tat hat $C O_2$ folgende atomare Anordnung

#figure(
  fig("sheet-09-co2-structure", width: 35%),
  caption: [Atomare Struktur von $C O_2$. $delta^plus.minus$ bezeichnet Partialladungen in Einheiten der Elementarladung.],
)

= Rotation und Vibration in Molekülen

#task[_Welchen Effekt hat der zunehmende Drehimpuls $bL$ höherer Rotationszustände eines zweiatomigen Moleküls auf dessen Vibrationszustände?_]

Das effektive Potential $V_"eff" (R)$ des Moleküls als Funktion des Kernabstands $R$ berücksichtigt folgende Beiträge zur Gesamtenergie $E_"ges"$:
- die kinetische Energie der Elektronen $E_"kin"$ und aus der Relativbewegung der Kerne,
- alle Coulombschen-Wechselwirkungen $E_"Coul"$, anziehend oder abstoßend, zwischen Elektronen und Kernen,
- die Rotation der Kerne $E_"Rot"$ und subsequent der Elektronenwolke um ihren gemeinsamen Schwerpunkt
- sowie Vibrationen zwischen den Kernen $E_"Vib"$, also schnelle Oszillationen des Kernabstands.#footnote[Dies ist nicht dasselbe, wie die Relativbewegung der Kerne, die sich in der Schrödinger-Gleichung durch Anwendung des Impulsoperators auf die Kernkoordinaten ergibt.]

Die letzten beiden Beiträge $E_"Rot"$ und $E_"Vib"$ sind bei genauerer Betrachtung über die sogenannte Rotations-Schwingungs-Wechselwirkung gekoppelt. Der Grund dafür ist, dass das für die Winkelgeschwindigkeit der Rotation entscheidende Trägheitsmoment mit den Kernvibrationen schwankt. Ein größerer Kernabstand bedeutet wegen $theta = mu R^2$ auch ein größeres Trägheitsmoment. Dadurch ergibt sich ein zusätzlicher Term zum effektiven Potential, die Rotations-Schwingungs-Wechselwirkungsenergie
$ E_"RSW" = bL^2/(2 theta) = (planck^2 L(L + 1))/(2 mu R^2) $
Hiermit verknüpft ist die Kraft $F_"RSW"$ gegeben durch die negative Ableitung der Wechselwirkungsenergie
$ F_"RSW" = -partial/(partial R) E_"RSW" = (planck^2 L(L + 1))/(mu R^3) $
$F_"RSW"$ wirkt in positiver $R$-Richtung, zeigt also entlang der Verbindungslinie beider Kerne weg vom jeweils anderen Kern und hat somit eine abstoßende Wirkung. Nähert man das effektive Potential $V_"eff" (R)$ durch ein Lennard-Jones-Potential, so zeigt sich (@fig:rsw-potential), dass eine Erhöhung der Abstoßung zu einem flacheren Potential führt.

#figure(
  fig("sheet-09-rsw-potential", width: 55%),
  caption: [Schematischer Verlauf des Lennard-Jones-Potentials mit und ohne RSW-Korrektur.],
) <fig:rsw-potential>

Die Rückstellkraft auf Auslenkungen der Atome im Molekül ist proportional zur ersten Ableitung des Potentials. Sie fällt folglich für ein flacheres Potential schwächer aus. Bei geringerer Rückstellkraft sind aber auch die Energiedifferenzen benachbarter Vibrationszustände kleiner, da die Rückstellkraft als Antrieb der Vibrationen fungiert. Die Antwort auf die Frage lautet also: Hohe Rotationszustände mit großem Drehimpuls haben kleinere Abstände der Vibrationsniveaus zur Folge.

_Nebenbemerkung zum effektiven Potential $V_"eff" (R)$_: Es folgt in der Molekülphysik aus dem kanonischen Ansatz, den Hamilton-Operator aus kinetischer Energie und Coulombabstoßung zunächst nur für die Kerne in Relativkoordinaten zu lösen. Eine eventuelle Bewegung relativ zum Laborsystem wird dabei absepariert und nicht weiter berücksichtigt. Anschließend wird aufgrund der Annahme, dass sich die viel leichteren Elektronen instantan an wechselnde Kernabstände im Molekül anpassen (Born-Oppenheimer-Näherung), die Schrödinger-Gleichung der Elektronen für jeden Kernabstand $R$ gesondert gelöst und die erhaltene Energie als Korrektur zum Kernpotential hinzuaddiert. Man kann nun schrittweise immer kleinere Effekte, wie Molekülrotationen und -vibrationen hinzunehmen und ihre Effekte auf das effektive Potential berechnen. Für zweiatomige Moleküle ist das Endergebnis dieses Vorgehens zumindest näherungsweise ein Lennard-Jones-Potential.

= Austauschwechselwirkung

#task[_Erklären sie den Begriff Austauschwechselwirkung am Beispiel des $H_2$-Moleküls? Welcher Zustand liegt energetisch tiefer, der Singlett oder der Triplett-Zustand? Warum?_]

Die Austauschwechselwirkung oder besser gesagt Austauschenergie erhöht oder erniedrigt die Energie eines Systems mehrerer wechselwirkender, identischer Teilchen gegenüber einem äquivalenten System mit unterscheidbaren Teilchen. Der elektronische Hamilton-Operator des $H_2$-Moleküls in der Ortsdarstellung lautet
$
  hat(H)_"el" = & ((-planck^2)/(2 m) Delta_1 - e^2/(4 pi eps_0 r_(A 1))) + ((-planck^2)/(2 m) Delta_2 - e^2/(4 pi eps_0 r_(B 2))) \
  & + e^2/(4 pi eps_0) (rinv(12) - rinv(A 2) - rinv(B 1)),
$
wobei 1, 2 die Elektronen und $A$, $B$ die Protonen indiziert. Er setzt sich zusammen aus zwei Wasserstoff-Hamiltonians und der Anziehung der Elektronen zum jeweils anderen Kern sowie ihrer gegenseitigen Abstoßung. Zur Lösung der $H_2$-Schrödinger-Gleichung greift man auf die Heitler-London-Näherung zurück und konstruiert aus den 1s-Wasserstofforbitalen das kovalent gebundene, räumlich symmetrische Molekülorbital
#nonum($ ket(Psi) = sqrt(N) (ket(AB) + ket(AB2)) times.o (ket(arrow.t arrow.b) - ket(arrow.b arrow.t))/sqrt(2), $)
wobei $sqrt(N)$ die Ortswellenfunktion normiert. Die spektroskopische Bezeichnung dieses Zustands ist $attach(Sigma, tl: 1, br: g, tr: +)$. Die Berechnung des Energieerwartungswertes liefert
#nonum($
  E & = lr(chevron.l Psi | hat(H)_"el" | Psi chevron.r) = N (bra(AB) + bra(AB2)) hat(H)_"el" (ket(AB) + ket(AB2)) \
  & = 2 N lr(chevron.l AB | hat(H)_"el" (ket(AB) + ket(AB2)) chevron.r) \
  & = 2 N lr(chevron.l AB | 2 E_(1s) + e^2/(4 pi eps_0) (rinv(12) - rinv(A 2) - rinv(B 1)) | AB chevron.r) \
  & quad + 2 N lr(chevron.l AB | 2 E_(1s) + e^2/(4 pi eps_0) (rinv(12) - rinv(A 1) - rinv(B 2)) | AB2 chevron.r) \
  & = 2 E_(1s) + (2 N e^2)/(4 pi eps_0) (lr(chevron.l AB | rinv(12) | AB chevron.r) - 2 lr(chevron.l Psi_(A 1) | rinv(B 1) | Psi_(A 1) chevron.r) \
  & quad + lr(chevron.l AB | rinv(12) | AB2 chevron.r) - 2 S lr(chevron.l Psi_(A 1) | rinv(A 1) | Psi_(B 1) chevron.r))
$)
mit dem Überlappintegral $S = braket(Psi_(A 1), Psi_(B 1))$ und $2 N (1 + S^2) = 1$. Hierbei wurde im zweiten Summanden ausgenutzt, dass $ket(AB2)$ Eigenzustand von $hat(H)_(A 2) + hat(H)_(B 1)$ ist, sodass dort die Wechselwirkungsterme mit vertauschten Kernen auftreten. Es ergeben sich also folgende Terme:
- erwartungsgemäß zweimal die Energie $E_(1s)$ des Elektrons im atomaren $1s$-Orbital, da ja auch zwei $H$-Atome vorliegen,
- ein Beitrag aus der $e^- - e^-$-Abstoßung,
- ein Beitrag aus der Anziehung des Elektrons zum jeweils anderen Kern und
- zuletzt ein Term, der aus dem elektronischen Hamilton-Operator noch nicht ablesbar war: die Austauschenergie.

Physikalisch kann man die Austauschenergie des $H_2$-Moleküls
$ E_("ex",H_2) = (2 N e^2)/(4 pi eps_0) (lr(chevron.l AB | rinv(12) | AB2 chevron.r) - 2 S lr(chevron.l Psi_(A 1) | rinv(A 1) | Psi_(B 1) chevron.r)) $
als Folge des Überlapps der Wellenfunktionen eines der beiden Elektronen mit sich selbst am anderen Kern interpretieren. Der zweite, anziehende Beitrag überwiegt bei typischen Kernabständen, da die 1s-Orbitale stets größer null sind, sodass die Austauschenergie im Singulett-Zustand negativ ist. Das Vorzeichen, mit dem die Austauschenergie in die Gesamtenergie eingeht, hängt aber von der Superposition der Atomorbitale ab. Für die antisymmetrische Ortswellenfunktion der Triplett-Zustände kehrt es sich um, sodass die Triplett-Zustände energetisch höher liegen als der Singulett-Zustand. Der Singulett-Zustand ist bindend, der Triplett-Zustand nicht.#footnote[Siehe auch Kap. 1.3, Solid State Physics von Philip Hofmann.]

#part[Übungsaufgaben]

= Übungsaufgabe 1 #pts(2)

#task[_Erklären sie mithilfe der Skizze der Orbitale auf Seite 31, Kapitel 6 des Skriptes, warum in homonuklearen zweiatomigen Molekülen das $pi_g^(-*)$-Molekülorbital antibindend ist. Sind die geraden Molekülorbitale $lambda_g$ immer antibindend?_]

Ob ein Molekülorbital eines zweiatomigen Moleküls bindend oder antibindend wirkt, hängt maßgeblich von der Menge an Aufenthaltswahrscheinlichkeit des Orbitals zwischen den beiden Kernen ab. Eine hohe elektronische Aufenthaltswahrscheinlichkeit sorgt dafür, dass die Coulomb-Abstoßung der Kerne abgeschirmt und sogar durch eine Anziehung zu den Elektronen dieses Orbitals ersetzt wird.

Die in der Aufgabenstellung erwähnte Skizze findet sich in @fig:pi-orbitals. Die vollständigen Bezeichnungen der dort dargestellten Molekülorbitale lauten $pi_g^(-*)$ für das erste und dritte Molekülorbital und $pi_u^+$ für das zweite und vierte. sie ergeben sich wie folgt aus Überlagerungen zweier $2p_x$- bzw. $2p_y$-Atomorbitale
$
  ket(Psi(pi_g^(-*))) & = sqrt(N) (ket(Psi_A (2p_(x,y))) - ket(Psi_B (2p_(x,y)))) \
  ket(Psi(pi_u^+)) & = sqrt(N) (ket(Psi_A (2p_(x,y))) + ket(Psi_B (2p_(x,y))))
$

#figure(
  fig("sheet-09-pi-orbitals", width: 45%),
  caption: [Grafische Darstellung der Flächen gleicher Aufenthaltswahrscheinlichkeit von $pi_(p_(x,y))$-Molekülorbitalen. Entstammt dem lesenswerten Artikel "LCAO-Methode für homonukleare zweiatomige Moleküle" der Universität Paderborn.],
) <fig:pi-orbitals>

Man sieht sofort, dass der obere (antibindende) Zustand $ket(Psi(pi_g^(-*)))$ kaum für Elektronenaufenthalt zwischen den Kernen sorgt, wohingegen der untere (bindende) Zustand fast ausschließlich hier vorkommt. Gerade Molekülorbitale sind keinesfalls immer antibindend. Zwischen diesen beiden Eigenschaften besteht kein Zusammenhang. Ein naheliegendes Gegenbeispiel zu dieser Frage sind die $sigma$-Orbitale. Hier ist eben die gerade Superposition $ket(Psi(sigma_g^+)) prop ket(Psi_A (1s)) + ket(Psi_B (1s))$ der 1s-Atomorbitale bindend und die ungerade $ket(Psi(sigma_u^+)) prop ket(Psi_A (1s)) - ket(Psi_B (1s))$ antibindend.

= Expansion und Molekülspektren #pts(5)

#task[_Die Asymmetrie im Verlauf der Bindungsenergie $E_"Bind" (R)$ von Molekülen sorgt für die thermische Ausdehnung von Festkörpern. Erklären Sie, wie man aus Molekülspektren die Form dieser Kurve rekonstruieren kann._]

#figure(
  fig("sheet-09-anharmonic-potential", width: 45%),
  caption: [Anharmonischer Potentialverlauf eines zweiatomigen Moleküls. Mit eingezeichnet sind die Energien der Vibrationsniveaus.],
) <fig:anharmonic-potential>

Aus der genauen Analyse molekularer Übergänge zwischen _Vibrationsniveaus_ erhält man vielfältige Informationen über Struktur und Bindungsverhalten mit der für Spektroskopie-Messungen typischen Genauigkeit. Messbare Größen umfassen
- Winkel und Abstände zwischen Atomen im Molekül,
- Temperatur,
- Kraftkonstanten, z.B. von Vibrationen
- und den Potentialverlauf der Bindung.

Letzteres erhält man vor allem aus der Energiedifferenz benachbarter Schwingungsniveaus. In anharmonischen Potentialen nimmt sie mit wachsender Vibrationsquantenzahl $nu$ ab. Für ein zweiatomiges Molekül ist dies in @fig:anharmonic-potential dargestellt. Es ist also möglich aus Messung und Vergleich mehrerer Vibrationszustände ihre Eigenenergien zu bestimmen und daran den Verlauf des Potentials zu fitten. Eine gute Faustregel ist, je schneller die Abstände abnehmen, desto flacher das Potential im Bereich großer Auslenkungen.

Auch die Untersuchung der _Rotationsbanden_ kann hilfreich sein. Kennt man den Abstand und die Quantenzahl benachbarter Rotationsniveaus, so lässt sich für zweiatomige Moleküle hieraus der Gleichgewichtsabstand, also die Lage des Potentialminimums bestimmen. Man nähert dazu
#nonum($
  Delta E_"Rot" & = E_"Rot" (K + 1) - E_"Rot" (K) \
  & = planck^2/(2 theta_(K+1)) (K + 1)(K + 2) - planck^2/(2 theta_K) K(K + 1) \
  & approx planck^2/theta_K (K + 1),
$)
wobei im letzten Schritt angenommen wurde, dass sich das Trägheitsmoment beim Übergang nicht stark ändert, $theta_(K+1) approx theta_K$. Durch Einsetzen von $theta = mu chevron.l R^2 chevron.r$ kann man den Gleichgewichtsabstand $chevron.l R chevron.r approx sqrt(chevron.l R^2 chevron.r)$ abschätzen.

_Zusatzbemerkung_: Übergänge zwischen elektronischen Zuständen $n_i$ und $n_j$ werden als Banden im Frequenzspektrum gemessen. Diese entstehen durch eine Vielzahl an Übergängen, bei denen sich neben $n$ auch die Vibrationsquantenzahl $nu$ ändert, also $Delta nu != 0$, sodass sich die Übergänge in der Energiedifferenz leicht unterscheiden. Die Stärke der einzelnen Linien bestimmt der Franck-Condon-Faktor $|lr(chevron.l Psi_nu | Psi_(nu') chevron.r)|^2$, wobei die Vibrationswellenfunktionen $Psi_nu$ und $Psi_(nu')$ zu den Potentialkurven der beiden verschiedenen elektronischen Zustände gehören.

Nur wenn beide Potentialkurven identisch wären (gleiche Form und gleicher Gleichgewichtsabstand), wären die Vibrationszustände orthogonal, $lr(chevron.l Psi_nu | Psi_(nu') chevron.r) = delta_(nu nu')$, und es gälte bei elektronischen Übergängen stets $Delta nu = 0$.

= Dipolübergänge #pts(9)

#task[_Orientieren sie sich an Kapitel 3 der Vorlesung von Prof. Sengstock._]

#task(label: "a")[
  _Berechnen sie die Matrixelemente für den elektrischen Dipoloperator in $x$-, $y$- und $z$-Polarisation zwischen den Elektron-Zuständen $E_1$ und $E_2$ mit den Wellenfunktionen_
  $
     phi1s (r) & = sqrt(alpha^3/pi) e^(-alpha r) \
    phi2p (r, theta) & = sqrt(alpha^5/pi) cos(theta) r e^(-alpha r)
  $
  _Hierbei ist $alpha = 1 thin upright(Å)^(-1)$. Es gilt $l = m = 0$ für das 1s-Elektron und $l = 1$, $m = 0$ für das 2p-Elektron. Erläutern sie die gefundenen Ergebnisse mit Symmetrieargumenten bzw. Auswahlregeln._ (5 Punkte)
]

Das Übergangsdipolmoment $bp$, undidaktisch auch oft mit Übergangsmatrixelement bezeichnet, entstammt der Spektroskopie und ist ein Maß für die Fähigkeit der Elektronen eines Atoms oder Moleküls, elektromagnetische Strahlung zu absorbieren bzw. zu emittieren. Es ist gegeben durch den Erwartungswert des Dipoloperators $hat(bd) = -e hat(br) = -e br$ für Elektronen in der Ortsdarstellung
#nonum($ bp = lr(chevron.l phi2p | hat(bd) | phi1s chevron.r) = -e integral_(RR^3) phi2p (r) thin br thin phi1s (r) dd(3, r) $)
Aufgrund der Radialsymmetrie der 1s-Wellenfunktion und der Symmetrie der 2p-Wellenfunktionen bezüglich Rotationen um die $z$-Achse (Zylindersymmetrie) wird dieses Integral am einfachsten in Kugelkoordinaten ausgewertet. Die Transformationsformeln lauten
$ br = vec(x, y, z) = r vec(cos(phi.alt) sin(theta), sin(phi.alt) sin(theta), cos(theta)) $
Ein infinitesimales Volumenelement in Kugelkoordinaten ist gegeben durch $dd(3, r) = r^2 sin(theta) dif phi.alt dif theta dif r$. Daraus folgt für das Integral
#nonum($
  bp & = -e integral_0^infinity integral_0^pi integral_0^(2 pi) sqrt(alpha^5/pi) cos(theta) r e^(-alpha r) br sqrt(alpha^3/pi) e^(-alpha r) r^2 sin(theta) dif phi.alt dif r \
  & = -(e alpha^4)/pi integral_0^infinity integral_0^pi integral_0^(2 pi) r^4/e^(2 alpha r) sin(theta) cos(theta) vec(cos(phi.alt) sin(theta), sin(phi.alt) sin(theta), cos(theta)) dif phi.alt dif theta dif r \
  & = -2 e alpha^4 integral_0^infinity integral_0^pi r^4/e^(2 alpha r) sin(theta) cos(theta) vec(0, 0, cos(theta)) dif theta dif r \
  & = -2 e alpha^4 ezz integral_0^infinity integral_0^pi r^4/e^(2 alpha r) sin(theta) cos^2(theta) dif theta dif r \
  & limits(=)^#footnote[Substitution: $u = cos(theta)$, $dif u = -sin(theta) dif theta$ mit $u(theta = 0) = 1$ und $u(theta = pi) = -1$.] -2 e alpha^4 ezz integral_0^infinity integral_1^(-1) r^4/e^(2 alpha r) u^2 dif u dif r = underbrace(-(4 e alpha^4)/3 ezz, ba) integral_0^infinity r^4/e^(2 alpha r) dif r \
  & = underbrace(lr(-(ba r^4)/(2 alpha e^(2 alpha r)) |)_0^infinity, "0, siehe" #footnote[Die Exponentialfunktion steigt schneller als jedes Polynom, sodass für alle $n in RR$ im Unendlichen gilt $lim_(r -> infinity) r^n/e^r = 0$. Aus diesem Grund verschwinden auch die Randterme aller weiteren partiellen Integrationen, weshalb sie nicht mehr mitgeschrieben werden.]) + (4 ba)/(2 alpha) integral_0^infinity r^3/e^(2 alpha r) dif r = (12 ba)/(4 alpha^2) integral_0^infinity r^2/e^(2 alpha r) dif r \
  & = (24 ba)/(8 alpha^3) integral_0^infinity r/e^(2 alpha r) dif r = (24 ba)/(16 alpha^4) integral_0^infinity e^(-2 alpha r) dif r = lr(-(24 ba)/(32 alpha^5) e^(-2 alpha r) |)_0^infinity \
  & = (24 ba)/(32 alpha^5) = (3 ba)/(4 alpha^5) = -3/(4 alpha^5) (4 e alpha^4)/3 ezz = -e/alpha ezz
$)
Das Übergangsdipolmoment zwischen den Atomorbitalen $phi1s (r)$ und $phi2p (r)$ beträgt also
$ bold(P) = vec(0, 0, -e/alpha) = vec(0, 0, -1","60 dot 10^(-29) unit("C") unit("m")) $
und zeigt ausschließlich entlang der $z$-Achse. Das war aber auch zu erwarten, da der Polarwinkel $theta$ in der $x$-$y$-Ebene $pi/2$ beträgt und somit die 2p-Wellenfunktion hier wegen $cos(pi/2) = 0$ überhaupt nicht existiert. Um zurück auf die physikalische Bedeutung des Übergangsdipolmoments als Maß für die Absorptions- bzw. Emissionsfähigkeit zu kommen, bedeutet dieses Ergebnis, dass der Übergang von $1s(0,0)$ zu $2p(1,0)$ nur durch linear $z$-polarisiertes Licht erfolgen kann bzw. dass der Übergang beim Zerfall auch nur in dieser Richtung abstrahlt.

Das Ergebnis, wie in der Aufgabenstellung gefordert, auf Basis der Auswahlregeln zu begründen ist äußerst unphysikalisch, wird aber im nächsten Paragraphen dennoch gemacht. Tatsächlich erfolgt die Begründung gerade andersherum. Auswahlregeln finden ihre Herleitung stets in der Berechnung des Übergangsdipolmoments $bp_(i f)$ zwischen einem initialen Zustand $ket(Psi_i)$ und dem finalen Zustand $ket(Psi_f)$:
$ bp_(i f) = lr(chevron.l Psi_f | sum_n q_n br_n | Psi_i chevron.r), $
wobei der Index $n$ über alle beteiligten Punktladungen $q_n$ summiert. Der genaue Wert der einzelnen Komponenten ist dabei für Auswahlregeln uninteressant. Ein Übergang ist genau dann verboten/koppelt nur an Licht bestimmter Polarisation, wenn der Erwartungswert/eine seiner Komponenten verschwindet.

Bei dieser Aufgabe hätte man schon a priori, also vor Berechnung des Übergangsdipolmoments, vermuten können, dass ein Übergang möglich ist, da es sich bei elektrischer Dipolstrahlung stets um einen Ein-Photon-Prozess handelt. Die Erhaltung des Gesamtdrehimpulses erfordert, dass sich aufgrund des Photon-Spins $S_"ph" = 1$ auch der Drehimpuls zwischen den beiden am Übergang beteiligten Elektron-Zuständen um $plus.minus 1$ ändert. Das ist bei 1s mit $l = 0$ und $2p$ mit $l = 1$ der Fall. Ebenso ließe sich erraten, dass der Übergang nur an linear-polarisiertes Licht koppelt, da mit zirkular-polarisiertem Licht auch stets eine Änderung der magnetischen Quantenzahl $Delta m = plus.minus 1$ verbunden ist.

Ein Großteil der aus dem Übergangsdipolmoment erhaltenen Informationen hätte sich also bereits aus den Auswahlregeln ableiten lassen. Zusammen mit dem oben begründeten Verschwinden der $2p$-Wellenfunktion in der $x$-$y$-Ebene sogar alle, bis auf den genauen Betrag. Man sollte allerdings immer berücksichtigen, dass elektronische Übergänge zwischen Orbitalen zwar hauptsächlich, aber nicht ausschließlich durch elektrische Dipolstrahlung getrieben werden. Alle Aussagen basierend auf diesen Auswahlregeln sind deshalb nur näherungsweise korrekt, da sie Übergänge höherer Ordnung (magnetische Dipol-, elektrische Quadrupolübergänge etc.) sowie Mehrphotonenprozesse ignorieren. Auch Prozesse, die laut den Auswahlregeln eigentlich verboten sein sollten, treten im Experiment auf, wenn auch mit kleinem Wirkungsquerschnitt.

#task(label: "b")[
  _Ein Zustand mit der Energie $E_3$ werde beschrieben durch die Wellenfunktion_
  $ phi.alt_(2p(1,plus.minus 1)) (r, theta, phi.alt) = sqrt(alpha^5/(2 pi)) sin(theta) r e^(-alpha r) e^(plus.minus i phi.alt) $
  _Gibt es für den Übergang zwischen den Zuständen $E_1$ und $E_3$ ebenfalls Auswahlregeln für $x$-, $y$- und $z$-Polarisation_ (4 Punkte)
]

Laut den Auswahlregeln ist dieser Übergang möglich. Für $phi1s -> phi.alt_(2p(1,plus.minus 1))$ gilt $Delta m = plus.minus 1$, sodass er ausschließlich an links oder rechts zirkular polarisiertes Licht koppelt. Da $phi.alt_(2p(1,plus.minus 1))$ entlang der $z$-Achse verschwindet ($sin(theta = 0) = 0$), sollte auch das Übergangsdipolmoment in dieser Komponente null ergeben. Eine genaue Rechnung bestätigt diese Aussagen
$
  bp & = lr(chevron.l phi.alt_(2p(1,plus.minus 1)) | hat(bd) | phi1s chevron.r) \
  & = -e/(sqrt(2) alpha) vec(1, minus.plus i, 0) = -1","13 dot 10^(-29) unit("C") unit("m") vec(1, minus.plus i, 0)
$

= Intensität und Feldstärke #pts(4)

#task[_Ein Laserstrahl werde homogen auf einen kreisrunden Punkt mit einem Durchmesser von $d = 10 thin mu upright(m)$ fokussiert._]

#task(label: "a")[_Welche Intensität muss der Laserstrahl haben, um im Fokus inneratomare elektrische Feldstärken von Festkörpern zu erreichen? Schätzen sie hierfür die inneratomare Feldstärke mit dem Feld einer Elementarladung im Abstand von $r = 2 thin upright(Å)$ ab und nehmen sie in der Berechnung einen Brechungsindex von $n = 1$ an._ (3 Punkte)]

Das elektrische Feld am Punkt $br$ ausgehend von einer Punktladung im Ursprung kann über
$ bE = Q/(4 pi eps_0 thin epsilon_r) dot br/r^3 $
berechnet werden. Da die Art des Festkörpers nicht näher spezifiziert wurde, wird er hier als Vakuum genähert, d.h. $epsilon_r = 1$. Der Betrag des elektrischen Feldes im Abstand $2 thin upright(Å)$ vom Elektron beträgt dann
$ |bE| = lr(|(-e)/(4 pi epsilon_0) dot 1/(2 thin upright(Å))^2|) = 3","60 dot 10^10 upright(V)/upright(m) $ <eq:field>
Die Intensität $I$ ist definiert als Leistung $P$ pro Fläche $A$. Im Zusammenhang mit Wellen, also zum Beispiel Laserstrahlen, ist die _mittlere_ Intensität über eine Wellenlänge gemeint. Sie hängt mit der elektrischen Feldstärke wie folgt zusammen
$ I = (c n eps_0)/2 E^2, $
wobei $c$ die Lichtgeschwindigkeit und $n$ den Brechungsindex bezeichnet. Hier soll gelten $n = 1$. Zur Erzeugung der in @eq:field berechneten Feldstärke benötigt der Laser also eine Intensität von
$ I_L = (c eps_0)/2 (3","60 dot 10^10 (upright("kg") thin upright(m))/(upright(s)^3 thin upright(A)))^2 = 1","72 dot 10^18 upright(W)/upright(m)^2 $

#task(label: "b")[_Welche Ausgangsleistung muss der Laser hierfür erzeugen?_ (1 Punkt)]

Die Leistung $P_L$ des Lasers erhält man aus der Intensität $I_L$ durch Multiplikation mit der beschienenen Fläche $A$:
$
  P_L & = A dot I_L = pi (d/2)^2 I_L = pi ((10 thin mu upright(m))/2)^2 1","72 dot 10^18 upright(W)/upright(m)^2 \
  & = 1","35 dot 10^8 unit("W")
$
