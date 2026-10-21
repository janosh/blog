#import "/notes.typ": task, unit
#import "/atomic-physics/sheet.typ": fig, sheet, pts, part, nonum

#show: sheet.with([Übungsblatt 10], [01\. Juli 2014])

#let ddt(x) = $(dif #x)/(dif t)$
#let (IS, Iin, Iout, N20) = ($I_S$, $I_"in"$, $I_"out"$, $N_(2","0)$)
#let Wcp = $W_(c p)$
#let sat = $(1 + I/IS)$
#let e1 = $e^(-(1 + I/IS) t/tau)$

#part[Präsenzaufgaben]

= Drei- und Vier-Niveaulaser

#task[_Erklären Sie, warum die Schwellinversion für einen Vier-Niveaulaser einfacher zu erreichen ist, als für einen Drei-Niveaulaser._]

Vorbemerkung: Mit _Inversion_ bezeichnet man den Zustand eines lasenden Systems, in dem die Teilchendichte $N_2$ des energetisch höher liegenden Laser-Zustands größer ist, als die des unteren am Laser-Übergang beteiligten Zustands $N_1$. Die Stärke der Inversion wird durch den Parameter $N$ charakterisiert. Inversion liegt genau dann vor, wenn $N$ größer null ist:
$ N = N_2 - N_1 limits(>)^! 0 $
Die Existenz einer Inversion sichert, dass die stimulierte Emission nicht von der induzierten Absorption im Lasermedium übertroffen wird. Dies ist aber noch kein Garant dafür, dass Laseremission zustande kommt. Dafür wird zusätzlich eine _Schwellinversion_ $N_c > 0$ benötigt, die dafür sorgt, dass die Verstärkung im Lasermedium groß genug ist, um die Verluste des Laserresonators auszugleichen. @fig:laser-setup zeigt den inneren Aufbau eines Lasers und die Position von Lasermedium und -resonator.

#figure(
  fig("sheet-10-laser-setup", width: 55%),
  caption: [Schematischer Aufbau der wichtigsten Komponenten eines Lasers],
) <fig:laser-setup>

Um zu klären, welchen Nachteil ein Drei-Niveaulaser hat, sollte zunächst kurz etabliert werden, wie ein Vier-Niveaulaser funktioniert. Zur Realisierung eines Vier-Niveaulasers wird ein System benötigt, das aus mindestens vier Energieniveaus besteht (s. @fig:four-level-scheme). Das nullte Niveau sei der Grundzustand mit der Besetzungsdichte $N_0$. Durch Absorption der Pumpenergie - meistens Licht - werden Ionen vom Grundzustand in das Niveau 3 mit der Besetzungsdichte $N_3$ angeregt. Von diesem Niveau aus erfolge ein _schneller_ und _strahlungsloser_ Zerfall in das obere Laserniveau 2 mit der Besetzungsdichte $N_2$. Der Laserübergang findet nun vom Niveau 2 in das Niveau 1 mit der Besetzungsdichte $N_1$ statt, worauf wieder ein _schneller_ Zerfall in den Grundzustand folge.#footnote[Diese Forderungen an die Zustände und ihre Zerfallsraten eines Lasermediums erklären übrigens auch, warum so wenige Materialien für den Bau eines Lasers in Frage kommen.] Aufgrund der kurzen Lebensdauer der Niveaus 1 und 3 kann näherungsweise angenommen werden, dass sie nicht besetzt sind, d.h. $N_1 = N_3 = 0$. Dies hat zur Folge, dass es beim idealen Vier-Niveau-Laser
#[
  #set enum(numbering: "1.")
  + keine stimulierte Emission auf der Pumpwellenlänge gibt
  + keine Reabsorption auf der Laserwellenlänge auftritt.
]

#figure(
  fig("sheet-10-four-level-scheme", width: 35%),
  caption: [Energieübergänge in einem Vier-Niveaulaser. Gestrichelte Pfeile symbolisieren schnell ablaufende Übergänge.],
) <fig:four-level-scheme>

Ein Drei-Niveaulaser hingegen besitzt entweder ober- oder unterhalb des Laserübergangs nur ein aktives Niveau. Das bedeutet entweder,
#[
  #set enum(numbering: "1.")
  + dass der Zustand der mit der Laserfrequenz zerfällt, derselbe ist, in den gepumpt wird ($E_3$ fällt weg). Hier befinden sich Teilchen bis zum spontanen Zerfall bzw. der sukzessiven stimulierten Emission in Zustand 2, sodass es über diesen Zeitraum auch zu Wechselwirkung mit der Pumpenenergie kommt. Dies hat den stimulierten Rückfall eines Teils der Population in den Grundzustand zur Folge und erschwert somit die Inversionsbildung. Oder aber
  + der Grundzustand wird sowohl durch die Laserfrequenz an Zustand 2 der @fig:four-level-scheme als auch durch die Pumpe an den Zustand 3 gekoppelt ($E_1$ fällt weg). In diesem Fall kann es passieren, dass Teilchen in diesem Zustand durch Laser-Photonen induziert in Zustand 2 angeregt werden, wieder zerfallen und so quasi zwischen diesen beiden Zuständen pendeln ohne netto Laserlicht zu produzieren. Gleichzeitig ist typischerweise die thermische Besetzung des Grundzustands sehr viel höher, als zum Beispiel der des Zustands $E_1$ beim Vier-Niveaulaser. Diese Effekte erhöhen die Verluste im Resonator bzw. erschweren den Aufbau der Schwellinversion.
]

= Laserprinzip, Pumpschemata

#task[
  _Welche der in @fig:pump-schemes dargestellten Pumpschemata kann prinzipiell keine Laserstrahlung erzeugen? Geben Sie eine kurze Begründung der Antwort._

  _Hinweis: Betrachten Sie die Niveaus 1, 2, 3 des aufgespaltenen Grundzustandes und die Niveaus 4, 5 des angeregten Zustandes jeweils als thermisch gekoppelt._
]

#figure(
  fig("sheet-10-pump-schemes", width: 55%),
  caption: [Vier verschiedene Pumpschemata als Kandidaten für einen Laser],
) <fig:pump-schemes>

+ Dieser Prozess ist in der Lage, Laserlicht zu produzieren. Es handelt sich um einen Drei-Niveaulaser mit Besetzungsinversion zwischen den Zuständen 3 und 4. Wichtig ist, dass Zustand 3 relativ schnell zerfällt, da sich ansonsten Teilchen hier aufstauen könnten, was die Inversion aufheben würde.
+ Diese Konfiguration ist für einen Laser ungeeignet. Für rein thermische Kopplung ist der Zustand 2 deutlich schwächer bevölkert, als Zustand 1. Das Besetzungsverhältnis wird in guter Näherung durch die Boltzmann-Verteilung $N_i prop e^(-E_i \/ k_B T)$ beschrieben. Für eine typische Energiedifferenz von $0","1 unit("eV")$ ergibt sich bereits eine um den Faktor 50 kleinere Besetzung des energetisch höheren Zustands. Daraus folgt aber, dass selbst das vollständige Entpumpen des Zustands 2 keine Bevölkerung in Zustand 4 produziert, die oberhalb der von Zustand 1 liegt, d.h. eine Inversion ist nicht möglich. Die induzierte Absorption bei der Laserfrequenz wird immer stärker sein, als die stimulierte Emission.
+ Auch hiermit ist kein Lasen möglich (s. Begründung in *b)*).
+ Mit diesem Pumpschema ist ein Laserbetrieb möglich. Der Zustand 1 ist durch die thermische Kopplung stark besetzt, sodass bei ausreichender Pumpleistung und geringen Verlusten auf dem Zwischenniveau eine hohe Bevölkerung des energetisch höchsten Zustands erzeugt werden kann, die insbesondere die des dritten Zustands übertrifft, sodass Inversion vorliegt.

#part[Übungsaufgaben]

= Zeitabhängige Ratengleichung #pts(4)

#task[
  _Gegeben sei ein homogenes Zwei-Niveausystem aus den Zuständen 1 und 2 mit der Gesamtdichte $N$, der Lebensdauer des oberen Niveaus $tau$ und vernachlässigbarer thermischer Besetzung im oberen Niveau._

  _Berechnen Sie die zeitabhängige Besetzungsdichte $N_2 (t)$ im oberen Niveau in Abhängigkeit von der eingestrahlten Intensität $I(t)$ des resonanten Strahlungsfeldes, wenn dieses bei $t = 0$ eingeschaltet wird, d.h. $I(t) = I thin theta(t)$ mit $I in RR$ konstant und der Heavisideschen Sprungfunktion. Drücken Sie das Ergebnis mit den Größen $I$ und $IS$ aus (s. Kap. 7.1 der Vorlesung). $IS$ ist die sogenannte Sättigungsintensität mit $I\/IS = 2 B tau$ und $B = B_12 = B_21$ der Einstein-Koeffizient._
]

Als Ratengleichung bezeichnet man das Gleichungssystem, das die Zusammenhänge zwischen der Photonendichte $n$ des Strahlungsfeldes in einem Laser und den Besetzungsdichten $N_i$ der am Laserprozess beteiligten Energieniveaus $E_i$ beschreibt.

In einem Systems mit nur zwei an der Laseremission beteiligten Niveaus $E_1$ und $E_2$ betrachtet man hierzu den Einfluß
#[
  #set enum(numbering: "1.")
  + spontaner und stimulierter Emission sowie induzierter Absorption von Photonen beschrieben durch die jeweilige Lebensdauer bzw. Übergangsrate pro spektraler Energiedichte, in diesem Feld zusammenfassend meist Einstein-Koeffizienten genannt mit den Formelzeichen (Reihenfolge wie oben) $A_21$, $B_21$ und $B_12$,
  + der Zerfallsraten $R_1$ und $R_2$ in unbeteiligte Zustände,
  + der Pumprate $P$, mit der das obere Laserniveau aufgefüllt wird und
  + der Resonatorverlustrate $beta$.
]

Das obere Niveau $E_2$ wird sich durch spontane und stimulierte Emission nach $E_1$ sowie durch Zerfall in unbeteiligte Zustände leeren und durch induzierte Absorption und den Pumpmechanismus füllen. Umgekehrt füllt sich das untere Niveau $E_1$ durch stimulierte und spontane Emission aus $E_2$ und leert sich durch induzierte Absorption und Zerfall in unbeteiligte Zustände. Die Photonendichte steigt durch spontane und induzierte Emission und sinkt durch induzierte Absorption und Resonatorverluste. Sind die beiden Niveaus $E_1$ und $E_2$ entartet, d.h. besitzen sie statistische Gewichte $g_1$ und $g_2$, so lauten die Ratengleichungen mit der spektralen Energiedichte $w(nu)$ in Abhängigkeit von der Photonenfrequenz $nu$ wie folgt
$
  ddt(N_1) & = B_21 w(nu) (N_2 - g_2/g_1 N_1) + A_21 N_2 - R_1 N_1 \
  ddt(N_2) & = P - B_21 w(nu) (N_2 - g_2/g_1 N_1) - A_21 N_2 - R_2 N_2 \
  ddt(n) & = B_21 w(nu) (N_2 - g_2/g_1 N_1) - beta n
$
In diesen Ratengleichungen wurde die thermische Besetzung des oberen Niveaus $E_2$ bereits vernachlässigt. Die Berechnung der Besetzungsdichte $N_2 (t)$ vereinfacht sich in diesem Fall erheblich durch den Umstand, dass in der Aufgabenstellung keine Angaben zu Entartung ($g_1 = g_2 = 1$), Zerfall in unbeteiligte Zustände ($R_1 = R_2 = 0$) gemacht werden. Eine Pumpe, die aus einem dritten Zustand, zum Beispiel dem Grundzustand $E_0$ nach $E_2$ anregt, fällt auch weg ($P = 0$), da von vornherein nur zwei Niveaus betrachtet wurden. Aus $g_1 = g_2$ folgt direkt $B_12 = B_21 equiv B$. Mit $A_21 = 1/tau$ lautet die vereinfachte Ratengleichung für den Zustand $E_2$
$ ddt(N_2) = -B w(nu) (N_2 - N_1) - N_2/tau $ <eq:rate>
Diese Gleichung kann noch weiter umgeformt werden, um die Abhängigkeit von der eingestrahlten Intensität zu Tage zu bringen. Man definiert die stimulierte Übergangsrate
$ W_21 = B_21 w(nu) = sigma_21 F, $
wobei $sigma_21$ der Streuquerschnitt des Übergangs $2 -> 1$ und $F$ der Photonenfluss, also Photonenzahl pro Fläche und Zeit ist. Letzterer kann auch ausgedrückt werden durch die Intensität geteilt durch die Energie eines Photons $F = I/(h nu)$. Mit der Sättigungsintensität $IS = (h nu)/(2 sigma tau)$ kann man also schreiben
$ tau thin B thin w(nu) = tau thin sigma thin F = tau thin sigma I/(h nu) = I/((h nu)/(sigma tau)) = I/(2 IS) $
Einsetzen in Gleichung @eq:rate ergibt
$
  tau ddt(N_2) & = -I/(2 IS) (2 N_2 - N) - N_2 \
  & = I/(2 IS) N - sat N_2
$
Diese Differentialgleichung erster Ordnung ist durch Integration analytisch lösbar.
$
  tau integral (dif N_2)/(I/(2 IS) N - sat N_2) & = integral dif t \
  => quad -tau/(1 + I/IS) ln(I/(2 IS) N - sat N_2) & = t + c \
  => quad I/(2 IS) N - sat N_2 & = c' e1 \
  => quad N_2 & = -c'/sat e1 + (I/(2 IS) N)/(1 + I/IS) \
  => quad N_2 & = -c'' e1 + N/(2 (1 + IS/I))
$
Da die thermische Besetzung des oberen Zustands vernachlässigbar sein soll und bis $t = 0$ keine Intensität eingestrahlt wird, die zu Anregungen führen könnte, muss gelten $N_2 (t <= 0) = 0$. Bisher wurde die Zeitabhängigkeit der Intensität nicht explizit mitgeführt. Für den Zeitpunkt $t = 0$ gilt $I(t) = I thin theta(t = 0) = I$. Aus der Anfangsbedingung ergibt sich die Integrationskonstante $c''$ somit zu
#nonum($ N_2 (t = 0) = -c'' + N/(2 (1 + IS/I)) = 0 => c'' = N/(2 (1 + IS/I)) $)
Die Besetzungsdichte des oberen Niveaus im Verlauf der Zeit beträgt somit
$ N_2 = -N/(2 (1 + IS/I)) e1 + N/(2 (1 + IS/I)) $ <eq:population>
Dieser Ausdruck wirkt zunächst etwas unhandlich. Für den Spezialfall $I = 99 thin IS$ geht Gleichung @eq:population über in
$ N_2 = 99/200 N (1 - e^(-100 t/tau)) approx N/2 (1 - e^(-100 t/tau)) $
Für große Intensitäten würde man also erwarten, dass das System nach kurzer Zeit die Hälfte seiner Population in den energetisch höheren Zustand verschiebt. Der Graph dieser Funktion ist in @fig:population-strong dargestellt.

Gilt umgekehrt $IS = 99 thin I$, dann ist @eq:population
$ N_2 = N/200 (1 - e^(-100/99 t/tau)) approx N/200 (1 - e^(-t/tau)) $
In diesem Fall dauert der Besetzungsvorgang deutlich länger als im obigen Fall und die Besetzung erreicht nur etwa ein hundertstel von der bei hoher Strahlungsintensität. Für den Graphen, siehe @fig:population-weak.

#figure(
  fig("sheet-10-population-strong", width: 50%),
  caption: [Besetzungsdichte des oberen Zustands im Verlauf der Zeit für eine Intensität weit über der Sättigungsintensität geht asymptotisch gegen die halbe Gesamtpopulation $N$.#footnote[Bei der Berechnung dieses Ergebnisses mithilfe von Ratengleichungen wurden der Quantenmechanik eigene Kohärenzeffekte vernachlässigt, die besonders bei der Anregung eines Systems mit Lasern auftreten. Eine korrekte, quantenmechanische Rechnung führt zu den bereits bekannten Rabi-Oszillationen. Dass Ratengleichungen dennoch oft gute Ergebnisse liefern, liegt an dekohärierenden Effekten, zum Beispiel durch Phonon-Streuung in Festkörpern.]],
) <fig:population-strong>

#figure(
  fig("sheet-10-population-weak", width: 50%),
  caption: [Besetzungsdichte des oberen Zustands im Verlauf der Zeit für eine schwache Intensität.],
) <fig:population-weak>

= Optischer Verstärker #pts(6)

#task[
  _Für ein verstärkendes Vier-Niveausystem (s. @fig:three-four-level) der Länge $l$ mit Verlusten beschrieben durch den Koeffizienten $alpha$ gilt folgende Differentialgleichung für die Signalintensität $I(z)$_
  $ (dif I(z))/(dif z) = (sigma N20)/(1 + I(z)/IS) I(z) - alpha I(z). $ <eq:amplifier>
  _Hierbei ist $N20 = N_2$, wenn nur mit $W_p$ gepumpt wird, aber noch keine Intensität auf dem Laserübergang $E_2 -> E_1$ umläuft. Die entlang der $z$-Achse eingestrahlte Signalintensität sei $I_"in" = I(z = 0)$. Das Medium wird räumlich homogen gepumpt, d.h. die Inversion ohne eingestrahlte Signalintensität $N20$ ist unabhängig von $z$._#footnote[Ein Verstärker muss bereits vor dem Empfang des zu verstärkenden Signals im Inversionszustand sein, damit es zu viel stimulierter Emission durch die Signalphotonen kommt.]
]

#task(label: "a")[_Berechnen Sie die Intensität am Verstärkerausgang $Iout = I(z = l)$ für $I(z) << IS$, d.h. für einen ungesättigten Verstärker._ (1 Punkt)]

Im ungesättigten Zustand vereinfacht sich die Differentialgleichung @eq:amplifier, die die (zunehmende) Signalintensität beim Durchlaufen des Verstärkers beschreibt zu
$ (dif I(z))/(dif z) = (sigma N20 - alpha) I(z) $
Hierbei handelt es sich wieder um eine lineare, gewöhnliche Differentialgleichung erster Ordnung, die analytisch durch einfache Integration lösbar ist.
#nonum($ ln(I(z)) = integral (dif I(z))/I(z) = integral (sigma N20 - alpha) dif z = (sigma N20 - alpha) z + c $)
mit $c in RR$ konstant. Durch Exponentiation erhält man die Lösung der Differentialgleichung
$ I(z) = c' e^((sigma N20 - alpha) z) $
Die Integrationskonstante $c'$ wird durch die Eingangsbedingung $I(z = 0) = Iin$ auf $c' = Iin$ festgelegt. Die ausgehende Intensität $Iout = I(z = l)$ beträgt somit für einen ungesättigten Verstärker
$ Iout = Iin e^((sigma N20 - alpha) l) $

#task(label: "b")[_Lösen Sie die Differentialgleichung für $I(z) >> IS$, d.h. für einen gesättigten Verstärker. Wie vereinfacht sich das erhaltene Ergebnis für kleine Verluste $alpha l << 1$?_ (3 Punkte)]

Ist der Verstärker gesättigt gilt für @eq:amplifier näherungsweise
$ (dif I(z))/(dif z) = sigma N20 IS - alpha I(z). $
Diese Differentialgleichung ist vom selben Typ, wie in *a)*. Sie lässt sich dementsprechend auf dieselbe Weise lösen:
$ integral (dif I(z))/(sigma N20 IS - alpha I(z)) = integral dif z $
Auswerten der Integrale liefert
$ -1/alpha ln(sigma N20 IS - alpha I(z)) = z + c $
Die Lösung der Differentialgleichung lautet somit
$ I(z) = -c'/alpha e^(-alpha z) + sigma/alpha N20 IS $
Aus der Eingangsbedingung folgt diesmal $Iin = -c'/alpha + sigma/alpha N20 IS$ bzw. nach der Integrationskonstanten $c'$ aufgelöst
$ c' = sigma N20 IS - alpha Iin $
Damit kann die Lösung $I(z)$ am Punkt $z = l$ spezifiziert werden
$ Iout = I(z = l) = (Iin - sigma/alpha N20 IS) e^(-alpha l) + sigma/alpha N20 IS $
Für sehr kleine Verluste $alpha l << 1$ kann man $e^(-alpha l) approx 1 - alpha l$ entwickeln und erhält
$ Iout approx Iin + (sigma N20 IS - alpha Iin) l approx Iin + sigma N20 IS thin l. $
Im gesättigten Verstärker wächst die Intensität also nur noch linear statt exponentiell mit der Länge: Pro Längeneinheit wird eine feste Intensität $sigma N20 IS$ hinzugefügt, unabhängig von der Eingangsintensität.

#task(label: "c")[_Wie groß ist die tatsächliche Inversion $N_2$ des Vier-Niveausystems, die das Abräumen des lasenden Zustands durch die eingestrahlte Intensität berücksichtigt, in den Fällen der Aufgabenteile *a)* und *b)* für $I(l) << IS$ bzw. $I(l) = 49 IS$ am Verstärkerausgang?_ (1 Punkt)]

Auf Seite 17, Kapitel 7 des Skriptes findet sich folgender Zusammenhang zwischen der Inversion $N20$ für den Fall, dass noch keine stimulierte Emission aus dem Zustand 2 durch eingestrahlte Intensität auftritt und der Inversion $N_2$, die diesen Effekt berücksichtigt und folglich kleiner ausfallen sollte. Die Besetzungsdichte $N_1 approx 0$ des schnell zerfallenden Zustands 1 kann für die Inversion in beiden Fällen vernachlässigt werden.
$ N_2 = N20/(1 + I\/IS) $ <eq:inversion>
Für den Fall aus *a)* mit $I(l) << IS$ beträgt die Inversion während des Verstärkerbetriebs nach Gleichung @eq:inversion
$ N_2 (z = l) = N20/(1 + I(l)\/IS) approx N20 $
Bei der hohen Intensität $I(l) = 49 IS$ von Aufgabenteil *b)* gilt
$ N_2 (z = l) = N20/(1 + I(l)\/IS) = N20/(1 + 49 IS\/IS) = N20/50 $

#task(label: "d")[_Welcher der beiden Fälle *a)* oder *b)* hat auf die Pumpleistung bezogen eine höhere Effizienz? Eine Qualitative Argumentation genügt._ (1 Punkt)]

Die Effizienz des Verstärkers bezogen auf die Pumpleistung ist der Anteil der Pumpleistung, der als zusätzliche Signalleistung wieder austritt. Im ungesättigten Fall *a)* bleibt die Inversion $N_2 approx N20$ nahezu unverändert, d.h. fast alle gepumpten Teilchen zerfallen spontan und ihre Energie geht dem Signal verloren. Im gesättigten Fall *b)* räumt das Signal die Inversion dagegen fast vollständig ab ($N_2 = N20\/50$), sodass nahezu jede gepumpte Anregung durch stimulierte Emission in ein Signalphoton umgesetzt wird. Der gesättigte Verstärker hat deshalb die deutlich höhere Effizienz, der ungesättigte dafür die höhere Verstärkung $Iout\/Iin$.

= Direktes Pumpen ins obere Laserniveau #pts(4)

#figure(
  fig("sheet-10-three-four-level", width: 50%),
  caption: [Zustandsschema mit Übergängen für einen Drei- und Vier-Niveaulaser],
) <fig:three-four-level>

#task[_Ein Dauerstrich-Laser#footnote[Deutsch für "continuous wave laser".], der auf dem Übergang $E_2 -> E_1$ anschwingen soll, benötige zum Erreichen der Schwelle eine Schwellinversionsdichte $N_c$. Die Gesamtdichte der Laserzentren, also der relevanten aktiven Atome im Trägermaterial, sei $N$. Gehen Sie jeweils davon aus, dass die Zerfälle von $E_3 -> E_2$ und $E_1 -> E_0$ sehr schnell passieren. Berechnen Sie die nötige Schwellpumprate $Wcp$ in Abhängigkeit von $N_c\/N$_]

#task(label: "a")[_für den Fall des Pumpens über $N_3$, d.h. im Vier-Niveau-Betrieb._ (1 Punkt)]

Diese Aufgabe lässt sich wieder durch Aufstellen der Ratengleichung für den Zustand 2 lösen. Die Lösung dieser Differentialgleichung ist dann eine Gleichung, die $N_2$ in Abhängigkeit aller Systemparameter beschreibt. Wegen $N_1 approx 0$ kann $N_2$ hier gleich der Schwellinversionsdichte $N_c$ gesetzt werden und dann nach der Schwellpumprate $Wcp$ aufgelöst werden.

Folgende Prozesse (in der Reihenfolge von oben nach unten im Niveauschema) be- bzw. entvölkern den Zustand 2:
#enum(
  numbering: idx => ([$+$], [$-$], [$-$], [$+$]).at(idx - 1),
  [der (vermutlich strahlungslose) spontane Zerfall $N_3\/tau_32$ von Zustand 3 nach Zustand 2],
  [der spontane Zerfall bei der Laserfrequenz $N_2\/tau_21$ von Zustand 2 nach Zustand 1],
  [die stimulierte Emission durch Laserphotonen $W_21 N_2$ beim Übergang von Zustand 2 nach Zustand 1],
  [die induzierte Absorption von Laserphotonen $W_12 N_1$ beim Übergang von Zustand 1 nach Zustand 2],
)
#v(-0.6em)
Andere Übergänge zwischen den vier Niveaus, z.B. von $N_2$ direkt nach $N_0$, sind in @fig:three-four-level nicht eingezeichnet und sollten folglich vernachlässigbar klein oder komplett verboten sein.

Da in diesem System die Zustände 1 und 3 sehr schnell zerfallen sollen, können schon vor der Rechnung einige Vereinfachungen gemacht werden. Zunächst sollte wegen $N_3 approx 0$ der Zerfall $N_3\/tau_32$ ungefähr gleich der Pumprate $W_p N_0$ sein. Wegen $N_1 approx 0$ kann man außerdem sagen, dass der Übergang $W_12 N_1$ von Zustand 1 nach Zustand 2 nicht vorkommt, d.h. $W_12 N_1 approx 0$. Die Ratengleichung für Zustand 2 lautet somit
$ ddt(N_2) = W_p N_0 - N_2/tau_21 - W_21 N_2 $
In dieser Gleichung besitzt leider neben $N_2$ auch noch $N_0$ eine unbekannte Zeitabhängigkeit. Diese kann aber wegen $N = N_0 + N_1 + N_2 + N_3 approx N_0 + N_2$ durch die zeitunabhängige Gesamtpopulation des Systems $N$ und die von $N_2$ ersetzt werden:
$ ddt(N_2) = W_p N - (W_p + 1/tau_21 + W_21) N_2 $ <eq:rate-four-level>
Diese Art Gleichung wurde bereits mehrfach in den Aufgaben 1 und 2 gelöst. Das Ergebnis lautet
$ N_2 (t) = -c thin e^(-(W_p + 1/tau_21 + W_21) thin t) + (W_p N)/(W_p + 1/tau_21 + W_21) $
mit der Integrationskonstanten $c$, die wie in Aufgabe 1 gezeigt den Wert $c = W_p N \/ (W_p + 1/tau_21 + W_21)$ besitzt, falls die Pumpe zur Zeit $t = 0$ eingeschaltet wird und somit bis zu diesem Zeitpunkt wegen vernachlässigbarer thermischer Besetzung gelten muss $N_2 (t <= 0) = 0$. \
Die Zeitabhängigkeit beschreibt die Entwicklung in den Gleichgewichtszustand. Die Berechnung einer Schwellinversionsdichte macht nur im Gleichgewicht Sinn. Man betrachtet also hierzu den Fall
$ N_(2,"equi") = N_2 (t -> infinity) = (W_p N)/(W_p + 1/tau_21 + W_21) $ <eq:equilibrium>
In der Aufgabenstellung ist von keinen Resonatorverlusten die Rede. Sie werden deshalb als vernachlässigbar bzw. nicht vorhanden angesetzt. In diesem Fall ist die Gleichgewichtsinversion $N_(2,"equi") - N_(1,"equi") approx N_(2,"equi")$ gleich der Schwellinversion $N_c$, d.h. $N_(2,"equi") = N_c$ und die Pumpleistung $W_p$ gerade der Schwellpumpleistung $Wcp$, sodass Gleichung @eq:equilibrium wie folgt lautet
$ N_c = (Wcp N)/(Wcp + 1/tau_21 + W_21) $
Auflösen nach der Schwellpumpleistung $Wcp$ liefert
$ Wcp = ((1 + W_21 tau_21) N_c)/((N - N_c) tau_21) $ <eq:threshold>
In dieser Gleichung ist wieder die Intensität $I_21$ der für den Laserübergang resonanten Strahlung versteckt. @eq:threshold kann umgeschrieben werden zu
$ Wcp = ((1 + I_21\/2 IS) N_c)/((N - N_c) tau_21) $ <eq:threshold-intensity>
Auch dieser Ausdruck ist noch etwas unhandlich. Für den Fall kleiner Intensitäten $I_21 << IS$ vereinfacht er sich deutlich. Aus Aufgabe 1 ist nämlich bekannt, dass für kleine Intensitäten auch die Inversionsdichte $N_c$ gegenüber der Gesamtdichte der aktiven Teilchen im Lasermedium $N$ klein ausfällt, sodass @eq:threshold-intensity für kleine Intensitäten genähert werden kann zu
$ Wcp approx N_c/(N tau_21) $
Für sehr große Intensitäten $I_21 >> IS$ zeigte sich in Aufgabe 1, dass fast genau die Hälfte der aktiven Teilchen im energetisch höher liegenden Zustand vorkamen. Die Erkenntnis bezog sich auf ein Zwei-Niveausystem. Da die Zustände 1 und 3 sehr schnell zerfallen sollen, können sie dem Pumpprozess aber keine nennenswerte Population entziehen, sodass sich das System in dieser Hinsicht gleich verhält. Die halbe Population in Zustand 2 führt zu einer Gleichgewichtsinversion von $N_(2,"equi") = N_c = N/2$, sodass die Schwellpumpleistung unabhängig von den Teilchendichten wird:
$ Wcp approx 1/tau_21 (1 + I_21/(2 IS)) $

#task(label: "b")[_für den Fall des Pumpens direkt nach $N_2$, d.h. im Drei-Niveau-Betrieb._ (2 Punkte)]

Wird Zustand 2 durch die Pumpe direkt an Zustand 0 gekoppelt, was beim Laserbetrieb ohne Zustand 3 unvermeidlich ist, so ergibt sich ein weiterer Effekt, der den Zustand 2 entvölkert. Aktive Teilchen in Zustand 2 werden durch die Pumpenergie zur stimulierten Emission gebracht, was durch einen weiteren Term $-W_p N_2$ in der Differentialgleichung @eq:rate-four-level berücksichtigt werden muss:
$ ddt(N_2) = W_p N - (2 W_p + 1/tau_21 + W_21) N_2 $
Der sich dadurch ergebende Faktor 2 kann leicht durch die ganze Rechnung aus *a)* getragen werden. Man erhält letztendlich die Schwellinversion
$ N_c = (Wcp N)/(2 Wcp + 1/tau_21 + W_21), $
woraus sich eine Schwellpumpleistung von
$ Wcp = ((1 + W_21 tau_21) N_c)/((N - 2 N_c) tau_21) = ((1 + I_21\/2 IS) N_c)/((N - 2 N_c) tau_21) $
ergibt. Für kleine Intensitäten verhält sich die Schwellpumpleistung des Drei-Niveaulasers offenbar ähnlich. Interessant ist hier aber der Grenzfall großer Intensität, wenn $N_c approx N\/2$ wird. Anscheinend divergiert die Schwellpumpleistung für hohe Laserintensitäten, die die angeregte Atome in Zustand 2 schnell abräumt. Dies ist auch anschaulich klar: Je schneller der Zustand 2 durch stimulierte Emission entleert wird, desto schwieriger wird es, eine Besetzungsinversion aufzubauen.

#task(label: "c")[_Ab welchen $N_c$-Werten kann der Laser in den Fällen *a)* bzw. *b)* nicht mehr zum Anschwingen gebracht werden?_ (1 Punkt)]

Aufgabe *a)* hat ergeben, dass die Schwellpumprate eines Vier-Niveaulasers erst für $N_c -> N$ divergiert, er also für alle $N_c < N$ anschwingen kann. *b)* zeigt dagegen, dass die Schwellpumprate eines Drei-Niveaulasers bereits für $N_c -> N\/2$ divergiert. Für $N_c >= N\/2$ kann der Drei-Niveaulaser also nicht mehr zum Anschwingen gebracht werden, da das direkte Pumpen das obere Laserniveau höchstens zur Hälfte besetzen kann.
