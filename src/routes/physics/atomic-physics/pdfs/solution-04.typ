#import "/notes.typ": task, vb
#import "/atomic-physics/sheet.typ": fig, sheet, pts

#show: sheet.with([Übungsblatt 4], [13.~Mai 2014])

#let Et = $tilde(E)$
#let root = $sqrt((E_2 - E_1 - (a + b) x)^2 + 4 k^2)$

#heading(numbering: none)[Präsenzaufgaben]

= Absorption unter Berücksichtigung der Impulserhaltung

#task[Diskutieren sie die Folien aus dem Vorlesungsskript Teil 3b, Seiten (3-37) bis (3-40).]

#task(label: "a")[Folgen sie den Rechnungen zur Energie- und Impulserhaltung. Welche Frequenz erwarten sie bei der Emission von Lichtquanten ausgehend von einem Atom mit dem Anfangsimpuls $vb(p)_0$?]

Ein Atom mit Anfangsimpuls $vb(p)_0$ fliegt nach Aussendung eines Photons mit dem Impuls $planck vb(k)$ mit $vb(p) = vb(p)_0 - planck vb(k)$ weiter. Das Atom trägt zu Beginn neben der kinetischen Energie $vb(p)_0^2 \/ 2 m$ noch die interne Anregungsenergie $planck omega_0$. Aus Energieerhaltung folgt
$ E_"Atom" = vb(p)_0^2/(2 m) + planck omega_0 = (vb(p)_0 - planck vb(k))^2/(2 m) + planck omega_"ph" = E'_"Atom" + E_"ph" $
Auflösen nach $omega_"ph"$ ergibt die Emissionsfrequenz des Photons
$ omega_"ph" = omega_0 + (vb(p)_0 vb(k))/m - (planck vb(k)^2)/(2 m) $
Die reine Übergangsfrequenz $omega_0$ zwischen atomaren Energieniveaus wird also in zweierlei Hinsicht modifiziert. Der erste Summand erhöht die Frequenz des Photons, wenn Wellenvektor des Photons und Impuls des Atoms parallel liegen und verringert sie, wenn beide antiparallel stehen. Dies ist der Dopplereffekt. Der zweite Summand ist immer negativ und ist so etwas wie die Rückstoßenergie durch das Photon, geteilt durch $planck$. Das bedeutet, egal in welche Richtung es ausgesandt wird, die Bewegungsenergie, die das Atom durch die Emission zusätzlich bekommt, wird dem Photon abgezogen.

#task(label: "b")[Wie lässt sich unter Ausnutzung des Photonenrückstoßes ein Atominterferometer realisieren?

  Stellen sie sich hierzu die atomaren Impulszustände $p_1 = 0$ und $p_2 = 2 planck k$ als Zweiniveausystem mit den Zuständen $|g_1 chevron.r$ und $|g_2 chevron.r$, wie in Abbildung 1a vor. Diskutieren sie die Entwicklung des Zustandes unter der Einwirkung der verschiedenen Interferometer-Strahlteiler-Pulse im sogenannten Mach-Zehnder-Atominterferometer (Abbildung 1b). Was können sie damit messen und was wird die eigentliche Messgröße sein?]

Ein Atominterferometer erfordert einen kohärenten Atomstrahl und Bauteile, die als Analogon für Strahlteiler und Spiegel aus der Interferometrie mit Photonen fungieren.

Für die kohärenten Wellenpakete greift man in der Regel auf Bose-Einstein-Kondensate zurück.

Das Analogon zum Strahlteiler lässt sich mithilfe zweier Laser leicht unterschiedlicher Frequenz realisieren. Das Prinzip beruht auf der Rabi-Oszillation. Sie tritt auf, wenn Atome mit dem elektrischen Feld eines Lasers wechselwirken, dessen Frequenz $omega_L$ in der Nähe der Übergangsfrequenz zweier Atomniveaus $omega_0 = (E_2 - E_1) \/ planck$ liegt. Bei resonanter Einstrahlung $omega_L = omega_0$ beobachtet man, dass die Aufenthaltswahrscheinlichkeiten und damit die Besetzungen beider Niveaus mit der Rabi-Frequenz
$ Omega = (vb(d)_12 dot vb(E)_0)/planck $
oszillieren. Hierbei ist $vb(d)_12$ das Übergangsdipolmoment, hervorgerufen durch eine Verschiebung der Elektronendichte während des Übergangs, und $vb(E)_0$ der Feldvektor des eingestrahlten Lasers.

Der erste Laser wird auf Resonanz gestellt und die Strahlbreite oder -intensität so angepasst, dass die Flugzeit der Atome durch den Strahl genau einer Viertel Rabi-Oszillation entspricht. Dadurch wird die Hälfte der Atome in den angeregten Zustand gehoben; man spricht von einem $pi\/2$-Strahl. Gleichzeitig wird den Atomen entsprechend der Überlegungen aus Aufgabenteil *a)* ein Impuls übertragen, sodass es zu einer Aufspaltung des Atomstrahls kommt. Durch spontane Emission würde der Strahl aus angeregten Atomen während der Propagation zerstreuen und seine Kohärenz verlieren. Um das zu vermeiden, verwendet man einen zweiten Laser mit leicht niedrigerer Frequenz $omega_L - epsilon$ als $pi$-Strahler, der alle _angeregten_ Atome durch induzierte Emission eines Photons der Laserfrequenz wieder in den Grundzustand bringt. Aus dem Frequenzunterschied beider Laser folgt, dass bei diesem Prozess netto Energie und Impuls übertragen wurde. Der Strahl wird also weiterhin aufgespalten, allerdings sehr viel schwächer und er besteht aus kontrolliert propagierenden Atomen im Grundzustand.

#figure(
  box(width: 75%, grid(
    columns: (39%, 61%),
    column-gutter: 1em,
    align: bottom,
    fig("sheet-04-level-scheme"), fig("sheet-04-mach-zehnder"),
    text(size: 9pt)[(a) Niveauschema der Laseranregung], text(size: 9pt)[(b) Atominterferometer mit Mach-Zehnder-Geometrie],
  )),
  caption: [Atominterferometrie mit Laserführung],
) <fig:interferometer>

Nach einer Flugzeit $T$ wird das Pendant zum Spiegel benötigt, um die Teilstrahlen auf Interferenzkurs zu schicken. Auch hierfür verwendet man zwei Laser (pro Strahl). Diesmal werden allerdings die Interaktionszeiten so gewählt, dass es im Strahl zu einer halben Rabi-Oszillation kommt ($pi$-Strahler). Dadurch werden im Idealfall alle Atome abgelenkt und die Strahlen nicht weiter aufgeteilt.

Auf den Punkt der Kreuzung werden zwei weitere Laser gerichtet. Hierbei handelt es sich wieder um $pi\/2$-Strahler, die einen Teil der Atome zurück in die Strahlführung des jeweils anderen Strahls ablenken. Dadurch kommt es zu Interferenz der Atomwellen entlang des kompletten Weges bis zum Schirm. Am Schirm untersucht man die Intensität der beiden Atomstrahlen. Aus der beobachteten Phasendifferenz kann wegen der äußerst kurzen (de-Broglie-)Wellenlänge der Atome auf sehr kleine Störeffekte entlang der individuellen Strahlführung geschlossen werden. Ein Verwendungszweck ist zum Beispiel die Messung von minimalen, lokalen Schwankungen im Gravitationspotential.

#heading(numbering: none)[Übungsaufgaben]
#counter(heading).update(0)

= Adiabatischer Populationstransfer #pts(10)

#task[Lesen sie Kapitel 2.1 aus der Veröffentlichung "Annual Reviews of Physical Chemistry 52, 763 (2001)" zu finden auf der Vorlesungsseite im Internet und beantworten sie folgende Fragen:]

#task(label: "a")[Skizzieren und erklären sie das System und die Kopplung, die hier beschrieben werden. (2 Punkte)]

#figure(
  fig("sheet-04-two-level-system", width: 75%),
  caption: [Skizze des Zweiniveausystems unter Laserbestrahlung. $epsilon(t)$ bezeichnet die Amplitude des Laserfeldes und $omega_L$ dessen Frequenz. $omega_0$ entspricht der Frequenz des atomaren Übergangs, wobei $omega_L != omega_0$. Man sagt, der Laser ist verstimmt.],
) <fig:two-level>

@fig:two-level zeigt das Zweiniveausystem eines Atoms aus den Zuständen $Psi_1$, $Psi_2$ im elektrischen Feld eines Laserstrahls. Der Laser fungiert als Kopplung zwischen den beiden Energieniveaus. Die Laserfrequenz $omega_L$ wird nahresonant zur Bohrschen Übergangsfrequenz $omega_0$ gewählt, sodass eine sog. kohärente Anhebung der Atompopulation in das angeregte Niveau erfolgt. Bei der kohärenten Anregung kommt es zu einer induzierten Polarisation des Systems.

#task(label: "b")[Was versteht man unter "adiabatischen" und "diabatischen" Zuständen? (2 Punkte)]

Als adiabatische Zustände bezeichnet man die instantanen, zeitabhängigen Eigenfunktionen des Hamilton-Operators $hat(H)(t)$. Es handelt sich dabei um Superpositionen der ungestörten Zustände $Psi_1$, $Psi_2$ mit zeitabhängigen Koeffizienten. Im Zweiniveausystem gilt
$
  Phi_+ & = sin(Theta(t)) Psi_1 + cos(Theta(t)) Psi_2 \
  Phi_- & = cos(Theta(t)) Psi_1 - sin(Theta(t)) Psi_2
$ <eq:adiabatic>
mit dem Mischwinkel $Theta(t) = 1/2 arctan(Omega(t) \/ Delta(t))$ (mit $2 Theta in [0, pi]$), der von der Rabi-Frequenz $Omega(t)$ und der Laserverstimmung $Delta(t) = omega_0 - omega_L (t)$ abhängt. Die ungestörten Zustände des Systems ohne Einwirkung externer Felder werden als diabatisch bezeichnet.

Eine unitäre Transformation in die Basis der adiabatischen Zustände erleichtert die theoretische Beschreibung eines zeitlich veränderlichen Quantensystems.

#task(label: "c")[Erklären sie in eigenen Worten welche Bedingungen für die adiabatische Entwicklung gelten müssen. (2 Punkte)]

Die zeitliche Änderung eines (Zweiniveau-)Systems kann adiabatisch beschrieben werden, falls die Kopplung zwischen den adiabatischen Zuständen $Phi_+$ und $Phi_-$ vernachlässigbar ist gegenüber der Differenz ihrer Eigenfrequenzen:
$ |chevron.l dot(Phi)_+ | Phi_- chevron.r| << |epsilon_+ - epsilon_-|, $
$epsilon_plus.minus$ sind die Frequenzen assoziiert mit den Energien der adiabatischen Zustände, also den Eigenwerten des Hamilton-Operators $E_plus.minus = planck epsilon_plus.minus$.

Für einen experimentellen Aufbau bestehend aus einem atomaren Ensemble in einem Laserstrahl erfordert die adiabatische Beschreibung, dass der Laser über lange Zeit und nicht abrupt auf das System einwirkt. Außerdem sollte der atomare Übergang eine hohe Rabi-Frequenz und der Laser eine große Verstimmung aufweisen.

Sind diese Bedingungen erfüllt, kommt es zu keinem Populationstransfer zwischen den adiabatischen Zuständen.

#task(label: "d")[Was ist die "schnelle adiabatische Passage" und welche Vorzüge hat sie gegenüber dem Zustandstransfer über Rabi-Oszillationen? (2 Punkte)]

Es gibt zwei grundsätzlich verschiedene Typen von adiabatischen Populationstransfers. Die beiden linken Bilder in @fig:passage zeigen den zeitlichen Verlauf der Energien und der Populationen des Zweiniveausystems im Falle der "no-crossing-passage" verursacht durch einen Laser-Puls mit konstanter Verstimmung.

#figure(
  fig("sheet-04-adiabatic-passage", width: 65%),
  caption: ["no-crossing passage" links und "rapid adiabatic passage" rechts. [Vitanov et al, 2001]],
) <fig:passage>

Zu Zeiten vor und nach dem Laserpuls werden die diabatischen Zustände jeweils mit demselben adiabatischen Zustand identifiziert.
$
  Phi_- (t -> plus.minus infinity) & = Psi_1 \
  Phi_+ (t -> plus.minus infinity) & = Psi_2
$
Außerhalb der Interaktionszeit stimmen deshalb dia- und adiabatische Energien überein. Dazwischen sind die adiabatischen Zustände allerdings durch eine Überlagerung der diabatischen Zustände gegeben, wie in Gleichung @eq:adiabatic. Da sich in der adiabatischen Entwicklung die Populationszahlen der adiabatischen Zustände nicht ändern, muss ein Teil der Atome durch den Laserpuls in den angeregten Zustand angehoben werden. Anschließend gehen die Atome sämtlich zurück in den Grundzustand über, sodass wieder $Phi_- (t -> infinity) = Psi_1$ gilt.

Die schnelle adiabatische Passage, in @fig:passage die rechten Bilder, bezeichnet den Effekt, der auftritt, wenn eine Atompopulation einem Laserstrahl ausgesetzt wird, dessen Verstimmung langsam und kontinuierlich einen großen Frequenzbereich durchläuft. Groß bedeutet hierbei, dass der Bereich von einer negativen bis zu einer positiven Verstimmungsfrequenz läuft, deren Betrag viel größer ist, als die Rabi-Frequenz $Omega(t)$.

Für $t -> plus.minus infinity$ gilt für das Verhältnis $Delta(t) \/ Omega(t) -> plus.minus infinity$, sodass der Mischwinkel $Theta$ aus Gleichung @eq:adiabatic während der Anregung von $Theta(t = -infinity) = pi\/2$ nach $Theta(t = infinity) = 0$ rotiert und sich die Zusammensetzung der adiabatischen Zustände entsprechend ändert. Zu Zeiten lange vor und nach dem Laserpuls können die adiabatischen Zustände nach Gleichung @eq:adiabatic also wieder mit konkreten diabatischen Zuständen assoziiert werden.
$
  Phi_+ (t = -infinity) & = Psi_1 wide && Phi_+ (t = infinity) & = Psi_2 \
  Phi_- (t = -infinity) & = -Psi_2 && Phi_- (t = infinity) & = Psi_1
$
Die komplette Population des Systems beginnt also im Zustand $Psi_1$, welcher zu der Zeit identisch ist mit $Phi_+ (t)$ und endet im Zustand $Psi_2$. Das ist aber nach wie vor $Phi_+ (t)$, da die Population während einer adiabatischen Entwicklung nicht nach $Phi_- (t)$ wechselt. Der Laserpuls mit Verstimmungs-Sweep hat also zu einem vollständigen Populationstransfer geführt. Da der Prozess innerhalb einer Zeit kürzer als die Lebensdauer des angeregten Zustands ablaufen muss, spricht man von der "rapid adiabatic passage".

Die Vorteile dieses Anregungsprozesses gegenüber der Rabi-Oszillation mithilfe eines Lasers konstanter Anregungsfrequenz lauten
- weniger anfällig gegenüber Variationen der Laserintensität
- weniger anfällig gegenüber Variationen der Verstimmung
- Interaktionszeit flexibel, bis zur spontanen Emission im angeregten Zustand verbleiben, während Rabi-Oszillation im Anschluss an einen vollständigen Transfer sofort einen Rücktransfer verursachen
- vollständiger Populationstransfer für breites Dopplerspektrum möglich

#task(label: "e")[Welche Bedingung muss bei der Passage gelten, um ausgehend von einem einzelnen Zustand eine 50%-ige Superposition beider Systemzustände zu erhalten? (2 Punkte)]

Die Übergangswahrscheinlichkeit zwischen zwei sich kreuzenden diabatischen Zuständen kann mithilfe der Landau-Zener-Formel berechnet werden.
$ P = 1 - exp(-pi/2 (Omega^2 (t = t_0))/(|dot(Delta)(t = t_0)|)) $
Hierbei ist $dot(Delta)(t = t_0)$ die Änderungsrate der Verstimmung zum Zeitpunkt der Kreuzung. Damit genau die Hälfte der Atompopulation angeregt wird, muss also gelten
$ Omega^2 (t = t_0) = (2 ln(2))/pi |dot(Delta)(t = t_0)| $
Die Landau-Zener-Formel ist lediglich eine Näherung und erfordert streng genommen eine für alle Zeiten konstante Rabi-Frequenz $Omega(cancel(t))$ und konstante Änderung der Verstimmung $dot(Delta)(cancel(t))$.

= Vermiedene Kreuzungen #pts(10)

#task[Energieniveaus von Atomen können durch die Wechselwirkung mit externen Feldern (Zeemaneffekt, Starkeffekt) verschoben werden. Dies kann zu Kreuzungen der Niveaus führen. Werden diese Energieniveaus zusätzlich miteinander gekoppelt kommt es zu einer sogenannten vermiedenen Kreuzung (avoided crossing). Diese Vermeidung ist ein Grundprinzip der Quantenmechanik von gekoppelten Systemen und soll hier erarbeitet werden. Man untersucht dazu ein Zweiniveausystem mit den Zuständen $|1 chevron.r$ und $|2 chevron.r$.

  Der Hamiltonoperator für dieses System in der Basis ${|1 chevron.r, |2 chevron.r}$ sei gegeben durch
  $ hat(H) = mat(E_1 + a x, k; k, E_2 - b x) $
  Der Parameter $x$ soll hier eine variable physikalische Größe darstellen, mit der die Energieniveaus entsprechend den Proportionalitätskonstanten $a$ und $b$ verstimmen. Das könnte beispielsweise die Wechselwirkung des magnetischen Moments des Atoms mit einem äußeren Magnetfeld sein, d.h. in diesem Fall wäre $x = B$. Die Kopplung der beiden Zustände wird durch die Konstante $k$ beschrieben; dies könnte beispielsweise die L-S-Kopplung sein.]

#task(label: "a")[Skizzieren sie den Energie-Verlauf der Eigenzustände des Hamiltonoperators für verschwindende Kopplung $k = 0$, für $a = b = 1$ und $E_1 = 0$, $E_2 = 5$ und für $x in [0, 5]$. (2 Punkte)]

Für verschwindende Kopplung hat $hat(H)$ Diagonalgestalt, wobei die Diagonaleinträge genau die Eigenwerte sind.
$ hat(H) = mat(x, 0; 0, 5 - x) $
$x$-Werte aus dem Intervall $[0, 5]$ ergeben den Verlauf in @fig:crossing. Die Eigenwerte kreuzen sich bei $x = "2,5"$.

#figure(fig("sheet-04-crossing", width: 50%), caption: [Verlauf der Energieeigenzustände]) <fig:crossing>

#task(label: "b")[Bestimmen sie die Eigenzustände für nicht verschwindende Kopplung unter der Annahme, dass $a, b, k in RR_+$ und zeigen sie, dass sich für diese Zustände die Energieeigenwerte nicht kreuzen. Bestimmen sie den Ort und Wert des minimalen Energieabstands. (3 Punkte)]

Die Eigenfunktionen des Hamilton-Operators bezeichnet man als adiabatische Zustände (s. Aufgabe 1). Sie können entsprechend Gleichung @eq:adiabatic als Superposition der Eigenzustände des ungekoppelten Systems geschrieben werden. Die Zusammensetzung ist durch den Mischwinkel
$ Theta = 1/2 arctan(Omega/Delta), quad 2 Theta in [0, pi] $
festgelegt. Hierbei ist die Rabi-Frequenz $Omega = 2 k \/ planck$ gegeben durch die Kopplungsenergie $k$ auf den Nebendiagonalen des Hamilton-Operators bezogen auf $planck$. $Delta$ bezeichnet den Frequenzunterschied der gekoppelten Zustände [S. 769, Annu.Rev.Phys.Chem., Vitanov et al, 2001], also
$ Delta = 1/planck (E_2 - b x - E_1 - a x). $
Mit $D := E_2 - E_1 - (a + b) x$ und $R := root$ ist $cos(2 Theta) = Delta \/ sqrt(Delta^2 + Omega^2) = D\/R$. Die Halbwinkelformeln $cos^2 Theta = (1 + cos 2 Theta)\/2$ und $sin^2 Theta = (1 - cos 2 Theta)\/2$ ergeben dann folgenden Ausdruck für die adiabatischen Zustände als Superposition der Zustände $|1 chevron.r$, $|2 chevron.r$:
$
  Phi_+ & = sin(Theta) |1 chevron.r + cos(Theta) |2 chevron.r = sqrt((1 - D\/R)/2) |1 chevron.r + sqrt((1 + D\/R)/2) |2 chevron.r
$ <eq:phi-plus>
$
  Phi_- & = cos(Theta) |1 chevron.r - sin(Theta) |2 chevron.r = sqrt((1 + D\/R)/2) |1 chevron.r - sqrt((1 - D\/R)/2) |2 chevron.r
$ <eq:phi-minus>
Die Energieeigenwerte der gekoppelten Zustände ergeben sich aus dem charakteristischen Polynom der Hamilton-Matrix
$
  & det mat(E_1 + a x - Et, k; k, E_2 - b x - Et) = 0 \
  => quad & Et_("1,2") = 1/2 ((E_2 + E_1 + (a - b) x) minus.plus root)
$
Damit es zu einer Kreuzung der beiden Energieniveaus kommt müssen $Et_1$ und $Et_2$ gleich werden. Dies ist offenbar nur dann möglich, wenn die Wurzelterme verschwinden, d.h. wenn
$ (E_2 - E_1 - (a + b) x)^2 + 4 k^2 = 0. $ <eq:no-crossing>
Da $k$ reell ist, muss $(E_2 - E_1 - (a + b) x)^2 < 0$ gelten, damit Gleichung @eq:no-crossing erfüllt ist. Da aber alle Größen innerhalb der Klammer ebenfalls reell sind, ist dieser Ausdruck nichtnegativ und wegen $k > 0$ die gesamte Summe echt positiv, sodass es keinen Schnittpunkt der gekoppelten Energien $Et_1$ und $Et_2$ geben kann.

Den Ort und Wert des minimalen Abstands der Eigenwerte gibt die Nullstelle der Ableitung ihrer Differenz
$
  partial/(partial x) (Et_2 - Et_1) & = partial/(partial x) root \
  & = ((a + b)((a + b) x - E_2 + E_1))/root limits(=)^! 0 \
  => quad x_0 & = (E_2 - E_1)/(a + b)
$
An diesem Punkt beträgt die Energiedifferenz
$ Delta Et(x_0) = sqrt((E_2 - E_1 - (a + b) (E_2 - E_1)/(a + b))^2 + 4 k^2) = 2 k $

#task(label: "c")[Skizzieren sie für die Parameter aus Aufgabenteil *a)* und für $k = 1$ den Energieverlauf der neuen Eigenzustände. (2 Punkte)]

Mit den gegebenen Spezifikationen lauten die Eigenwerte des gekoppelten Hamilton-Operators
$ Et_("1,2") = 1/2 (5 minus.plus sqrt((5 - 2 x)^2 + 4)) $
@fig:avoided-crossing zeigt die Energien der gekoppelten Eigenzustände für Wechselwirkungsparameter aus dem Intervall $x in [0, 5]$.

#figure(
  fig("sheet-04-avoided-crossing", width: 50%),
  caption: [Die neuen Energieeigenwerte $Et_1$, $Et_2$ unter Berücksichtigung einer Kopplung zwischen den Zuständen $|1 chevron.r$ und $|2 chevron.r$. $Et_1$ in rot, $Et_2$ in blau. Die vorige Kreuzung bei $x = "2,5"$ wird nun von beiden Niveaus vermieden.],
) <fig:avoided-crossing>

#task(label: "d")[Was passiert mit einem System im Anfangszustand $|1 chevron.r$, wenn der Parameter $x$ von kleinen zu großen Werten variiert wird. (1 Punkt)]

Dazu schreibt man die diabatischen Zustände in der Basis der adiabatischen Zustände. Aus den Gleichungen @eq:phi-plus und @eq:phi-minus folgt
$ |1 chevron.r = sin(Theta) Phi_+ + cos(Theta) Phi_- $ <eq:ket-1>
$ |2 chevron.r = cos(Theta) Phi_+ - sin(Theta) Phi_- $ <eq:ket-2>
Mit $a = b = k = 1$ und $E_1 = 0$, $E_2 = 5$ ist $D\/R = (5 - 2 x) \/ sqrt((5 - 2 x)^2 + 4)$. Für $x = 0$ ist also $cos^2 Theta = (1 + 5\/sqrt(29))\/2 approx 0","96$, d.h. der Anfangszustand $|1 chevron.r$ ist fast identisch mit dem unteren adiabatischen Zustand $Phi_-$. Für $x -> infinity$ gilt dagegen $D\/R -> -1$, also $Theta -> pi\/2$ und
$ lim_(x -> infinity) |1 chevron.r = Phi_+, quad lim_(x -> infinity) |2 chevron.r = -Phi_-. $
Was mit dem System passiert, hängt also davon ab, wie schnell $x$ variiert wird:
- Wird $x$ langsam (adiabatisch) erhöht, folgt das System dem adiabatischen Zustand $Phi_-$ auf dem unteren Ast der vermiedenen Kreuzung und endet (bis auf eine Phase) im Zustand $|2 chevron.r$. Es kommt zu einem vollständigen Populationstransfer, genau wie bei der schnellen adiabatischen Passage aus Aufgabe 1, wobei $x$ die Rolle der Verstimmung übernimmt.
- Wird $x$ dagegen schnell gegenüber der Kopplung variiert, kann das System der Änderung der adiabatischen Zustände nicht folgen und verbleibt im diabatischen Zustand $|1 chevron.r$, springt also über die vermiedene Kreuzung hinweg auf den oberen Ast. Die Wahrscheinlichkeit dafür gibt die Landau-Zener-Formel aus Aufgabe 1e an.

#task(label: "e")[Stellen sie eine Verbindung zwischen dieser Rechnung und dem in der Vorlesung besprochenen Beispiel des Übergangs vom Zeeman- in das Paschen-Back-Regime (s. Seite 2-14) her. Welche der Zustände koppeln im Paschen-Back-Regime? Beachten sie dafür die Beziehung $hat(vb(L)) hat(vb(S)) = hat(L)_z hat(S)_z + 1/2 (hat(L)_+ hat(S)_- + hat(L)_- hat(S)_+)$ mit den Aufsteige- und Absteigeoperatoren für Drehimpuls und Spin. (2 Punkte)]

Mit dem Zeeman-Effekt und dem Paschen-Back-Effekt werden die Aufspaltung und Verschiebung von atomaren Energieniveaus in einem von außen angelegten Magnetfeld bezeichnet. Sie beziehen sich lediglich auf unterschiedliche Bereiche der Kopplungsstärke. Im Zeeman-Regime ist die Störung der Energieniveaus verursacht durch das Magnetfeld kleiner als die Störeffekte der Spin-Bahn-Kopplung, d.h. $vb(mu) vb(B)_"ext" < vb(L) vb(S)$. Im Paschen-Back-Regime verhält es sich genau umgekehrt. Dazwischen befindet sich ein Übergangsbereich, dessen Verschiebungseffekte von beiden Herangehensweisen nicht korrekt erfasst werden.

Die bisherigen Überlegungen sind auf den Wechsel vom Zeeman- in das Paschen-Back-Regime insofern übertragbar, als dass auch hierbei die Kopplungsstärke $vb(B)$, ehemals $x$ erhöht wird, was zu vermiedenen Kreuzungen der Energieniveaus im Übergangsbereich führt.

Mithilfe der Beziehung $hat(vb(L)) hat(vb(S)) = hat(L)_z hat(S)_z + 1/2 (hat(L)_+ hat(S)_- + hat(L)_- hat(S)_+)$ und einigem Rechnen kann man zeigen, dass nur solche Zustände, die die gleiche Magnetquantenzahl $m_J$ aufweisen, durch die Spin-Bahn-Kopplung aneinander gekoppelt werden.
