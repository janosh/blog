#import "/notes.typ": dd, task, unit
#import "/atomic-physics/sheet.typ": fig, sheet, pts, part

#show: sheet.with([Übungsblatt 7], [03\. Juni 2014])

#let (Eion, Eaff) = ($E_"Ion"$, $E_"Aff"$)

#part[Präsenzaufgaben]

= Molekülzustände

#task[
  _Abbildung 1 zeigt die nach der Born-Oppenheimer Näherung berechneten Energiezustände eines zweiatomigen Moleküls im Grundzustand 1 und im niedrigsten optisch auch bei großen Kernabständen anregbaren Zustand 2._
]

#figure(
  fig("sheet-07-molecular-states", width: 55%),
  caption: [Das effektive Molekülpotential $V_"eff" (R)$ in Abhängigkeit des Kernabstands $R$ beinhaltet Beiträge aus der Coulombabstoßung- bzw. -anziehung zwischen den Elektronen und Kernen sowie die Vibrations- und Rotationsenergie der Kerne. Für sehr kleine Kernabstände wurde empirisch ein $R^(-12)$-Verlauf ermittelt, der daraus resultiert, dass Fermionen zunehmend höhere Niveaus besetzen müssen, um das Pauli-Prinzip zu erhalten. Für sehr große Abstände neutraler Atome folgt das Potential dem $-R^(-6)$-Verlauf der Van-der-Waals-Wechselwirkung.],
) <fig:molecular-states>

#task(label: "a")[
  _Beschriften Sie die Achsen. Geben Sie die Quantenzahlen der dissoziierten, d.h. voneinander getrennten Atome für Zustand 2 an, unter der Annahme, dass es sich bei dem Molekül um $H_2$ mit dem Grundzustand $1s 1s$ handelt. Was stellen die Kurven 1 und 2 dar?_
]

Im Falle sehr großer Kernabstände $R >> 1 unit("nm")$ liegen praktisch zwei isolierte Wasserstoffatome vor, deren Wellenfunktionen sich nicht beeinflussen. Im Grundzustand bedeutet das zwei Elektronen im ungestörten 1s-Wasserstofforbital. Im nächst höheren elektronischen Zustand ist dann eines der beiden Elektronen im $2p$-Orbital, also $1s 2p$.

#task(label: "b")[
  _Was stellen die horizontal eingezeichneten durchgezogenen und gepunkteten Energieniveaus dar?_
]

Die dünnen schwarzen Linien zu jedem Vibrationsniveau $nu$ symbolisieren die verschiedenen Rotationsniveaus $K$ des $H_2$-Moleküls. Die unterste Linie ist stets durchgezogen und steht für den Rotationsgrundzustand $K = 0$ des jeweiligen Vibrationsniveaus.

#task(label: "c")[
  _Zeichnen Sie die stärksten Übergänge in Absorption und Emission ein. Nehmen Sie dabei an, dass das Molekül beliebig kalt ist, also $T -> 0$. Begründen Sie, warum Sie die Übergänge so eingezeichnet haben._
]

Übergänge zwischen elektronischen Niveaus laufen aufgrund des hohen Ladung-zu-Masse-Verhältnisses von Elektronen verglichen mit Protonen sehr schnell ab. In dieser kurzen Zeit haben die Kerne kaum eine Möglichkeit auf die resultierenden Änderungen im Molekülpotential zu reagieren. Beim Übergang zwischen elektronischen Niveaus gilt deshalb stets $Delta R approx 0$. Man nennt diese Aussage auch das Franck-Condon-Prinzip. Die stärksten Übergänge zeichnen sich also dadurch aus, dass die Wellenfunktionen der beiden am Übergang beteiligten Niveaus bei gleichem Kernabstand eine große Amplitude aufweisen. Das bedeutet, dass beide beteiligten Zustände mit großer Wahrscheinlichkeit bei diesem Kernabstand auftreten. So kommen auch der blaue und grüne Pfeil in @fig:molecular-states zustande.

#part[Übungsaufgaben]

= Ionenbindung #pts(3)

#task[
  _Bei welchem Abstand $r$ zwischen einem Natriumatom mit der Ionisationsenergie $Eion = 5","1 unit("eV")$ und einem Chloratom mit der Elektronenaffinität $Eaff = 3","7 unit("eV")$ springt das Elektron der äußeren Schale zum Chloratom über, wenn eine reine Ionenbindung angenommen wird? Betrachten Sie also die Potentialkurve von $"Na"^+ "Cl"^-$._
]

Das Elektron springt genau dann über, wenn die Ionenbindung zwischen $"Na"^+$ und $"Cl"^-$ energetisch günstiger ist, als die unabhängigen Grundzustände $"Na"$ und $"Cl"$. Da rein ionische Wechselwirkung angenommen werden soll, spüren sich die beiden Atome im nicht ionisierten Zustand gar nicht. Die Energie des Systems $"Na" + "Cl"$ ist deshalb unabhängig vom dem Abstand $r$ seiner beiden Konstituenten und kann ohne Einschränkung auf null gesetzt werden.

Unter Vernachlässigung sogar der ionischen Wechselwirkung und der daraus resultierenden Bindungsenergie, die die Atome im Potential des jeweils anderen erfahren, hätte das System aus $"Na"^+$ mit $Eion = 5","1 unit("eV")$ und $"Cl"^-$ mit $Eaff = 3","7 unit("eV")$ im Vergleich zum System der Grundzustände die Energie $E_("Na"^+ "Cl"^-) = Eion - Eaff = 1","4 unit("eV")$, da zu seiner Erzeugung zunächst die Ionisationsenergie aufgebracht werden müsste und bei der Reabsorption des Elektrons die Affinitätsenergie wieder freigesetzt wird. Man kann sich das vorstellen, als würde ein Photon mit der Energie $E_"ph" = 5","1 unit("eV")$ in das System eingestrahlt werden, aber nur eines mit $E'_"ph" = 3","7 unit("eV")$ an einem Detektor hinter dem System wieder registriert werden. Tatsächlich ist die Energie des Systems durch die elektrostatische Anziehung der Ionen aber abstandsabhängig, sodass es einen Abstand gibt $r_0$, bei dem die Energie
$ E_("Na"^+ "Cl"^-) (r) = 1","4 unit("eV") + V_"Coul" (r) $
gerade null wird. Bei diesem Abstand befinden sich die Ionen gerade $1","4 unit("eV")$ tief im Potential des jeweils anderen Ions, wodurch das System an Energie verliert. $r_0$ lässt sich einfach aus dem Coulomb-Potential $V_"Coul"$ berechnen
$
  V_"Coul" (r = r_0) & = -e^2/(4 pi epsilon_0 r_0) limits(=)^! -1","4 unit("eV") \
  => quad r_0 & = e^2/(4 pi epsilon_0 dot 1","4 unit("eV")) = 1","03 unit("nm")
$
Das Elektron springt bei einem Abstand von $1","03 unit("nm")$ vom Natrium zum Chlor.

= Ionisierung des $H_2$-Moleküls #pts(4)

#task(label: "a")[
  _Wie groß ist die Ionisationsenergie des $H_2$-Moleküls, wenn seine Bindungsenergie $E_("Bind",H_2) = -4","48 unit("eV")$, die Bindungsenergie $E_("Bind",H_2^+) = -2","65 unit("eV")$ und die Ionisationsenergie des H-Atoms $E_("Ion",H) = 13","6 unit("eV")$ sind? Zeichnen Sie die Molekülpotential-Kurven in einem Diagramm zur Illustration der Berechnung._ (2 Punkte)
]

Zur Ionisierung des $H_2$-Moleküls sind zwei Energiebeiträge zu erbringen:
- die Verringerung der Bindungsenergie zwischen $H_2$ und $H_2^+$ um $Delta E_"Bind" = E_("Bind",H_2^+) - E_("Bind",H_2) = 1","83 unit("eV")$ und
- die Ionisationsenergie, die zur Trennung eines Elektrons von dem Wasserstoffmolekül aufgebracht werden muss.

Diese Rechnung ist sogar exakt und keine Näherung, denn sie entspricht dem Kreisprozess $H_2 -> H + H -> H + H^+ + e^- -> H_2^+ + e^-$: Zuerst wird das Molekül dissoziiert ($4","48 unit("eV")$), dann eines der Atome ionisiert ($13","6 unit("eV")$) und schließlich das $H_2^+$-Ion gebildet ($-2","65 unit("eV")$). Die Energie zur Ionisation von $H_2$ ist demnach
$ E_("Ion",H_2) = Delta E_"Bind" + E_("Ion",H) = 15","43 unit("eV"), $
in Übereinstimmung mit dem experimentellen Wert der (adiabatischen) Ionisationsenergie von $15","43 unit("eV")$. Eine grafische Darstellung der Molekülpotentiale mit den verschiedenen Übergangsenergien zeigt @fig:h2-potentials.

#figure(
  fig("sheet-07-h2-potentials", width: 55%),
  caption: [Molekülpotentiale von $H_2$ und $H_2^+$.],
) <fig:h2-potentials>

#task(label: "b")[
  _Wie groß wird die gesamte elektronische Energie ohne Kernabstoßung, d.h. die Gesamtbindungsenergie der beiden Elektronen im $H_2$-Molekül, wenn man den Kernabstand $R$ gegen null gehen lässt (Grenzfall des vereinigten Atoms)?_#footnote[Der Zahlenwert für die Antwort ist in Kapitel 4 der Vorlesung zu finden. Es ist keine Berechnung notwendig.] (2 Punkte)
]

Ein $H_2$-Molekül mit verschwindendem Kernabstand ist gerade ein Heliumatom, dem je nach Isotop ein oder zwei Neutronen fehlen. Da Neutronen nicht an der elektronischen Wechselwirkung im Atom teilnehmen, ist dieser Unterschied hier für die Aufgabenstellung aber irrelevant.

Die Energie eines Elektrons im $n$-ten Atomorbital um einen Kern aus $Z$ Elementarladungen lautet
$ E_("el",n) = -m_e/2 ((alpha c Z)/n)^2 $
Im Falle zweier vereinigter Wasserstoffatome ist also $Z = 2$ und $n = 1$ für Elektronen im $1s$-Orbital, sodass die Energie eines Elektrons
$ E_("el",1) = -m_e/2 (2 alpha c)^2 = -54","42 unit("eV") $
beträgt. Nun befinden sich aber zwei Elektronen im $1s$-Orbital, sodass dieser Beitrag doppelt auftritt. Gleichzeitig muss die Coulomb-Abstoßung zwischen den beiden Elektronen im Atom berücksichtigt werden. Man berechnet hierzu das Integral
$ E_C = integral.double Psi_"ges"^* (bold(r)_1, bold(r)_2) (-e)^2/(4 pi epsilon_0 |bold(r)_1 - bold(r)_2|) Psi_"ges" (bold(r)_1, bold(r)_2) dd(3, r_1) dd(3, r_2), $
wobei $bold(r)_1$ und $bold(r)_2$ die Ortsvektoren der beiden Elektronen bezeichnen. Die Berechnung dieses Integrals ist aufwendig und im Bransden Joachain, Kap. 6.5, S. 268 zu finden. Das Ergebnis lautet $E_C = 34 unit("eV")$. Die Energie des Systems wird also durch die Elektronabstoßung um etwa $34 unit("eV")$ angehoben. Die gesamte Bindungsenergie $E_B$ der beiden Elektronen in Grenzfall des vereinigten Atoms beträgt also in der Näherung ausschließlich elektronischer Wechselwirkung
$ E_B = -108","8 unit("eV") + 34 unit("eV") = -74","8 unit("eV"). $
Experimentell findet man $E_("B,exp") = -79","0 unit("eV")$. Die Diskrepanz rührt daher, dass die Elektronabstoßung hier nur in erster Ordnung Störungstheorie mit den ungestörten Wasserstoff-Wellenfunktionen berechnet wurde. Die gegenseitige Abschirmung der Elektronen (variationell etwa durch eine effektive Kernladung $Z_"eff" = 27\/16$ beschrieben) senkt die Energie weiter ab. Fein- und Hyperfeinstruktur-Korrekturen sind dagegen um Größenordnungen kleiner.

= Helium Molekül #pts(10)

#task[
  _Zeigen Sie, dass Helium kein $"He"_2$ Molekül bilden sollte. Benutzen Sie hierfür die Konstanten $epsilon.alt = 10 unit("K")$ und $sigma = 2","5 dot 10^(-10) unit("m")$ im Lennard-Jones-Potential_
  $ U_"eff" (R) = 4 epsilon.alt ((sigma/R)^12 - (sigma/R)^6) quad "mit" R in RR_+ $
  _Schätzen Sie hierzu die maximale Tiefe $U_B$ der Potentialkurve und die Nullpunktstemperatur $U_0$ eines $"He"_2$-Moleküls ab._#footnote[Die tatsächliche Bindungsenergie $U_B + U_0$ und der mittlere Abstand $chevron.l R chevron.r$ wurden durch Beugung eines ultrakalten Helium-Strahls, der auch Helium-Dimere enthielt, an einem Transmissionsgitter bestimmt. Es ergab sich $U_B + U_0 = 1","1 unit("mK")$ und $chevron.l R chevron.r = 52 unit("Å")$, also ein extrem schwach gebundenes Molekül. Ein interessanter Artikel hierzu findet sich auf der Seite #link("http://physics.aps.org/story/v6/st9")]
]

Die Ableitung des Lennard-Jones-Potentials hat genau eine Nullstelle:
$ (dif U_"eff" (R))/(dif R) = 24 epsilon.alt sigma^6 (1/R^7 - (2 sigma^6)/R^13) limits(=)^! 0 => R_0 = root(6, 2) sigma $
Bei $R_0 = root(6, 2) sigma$ liegt ein Minimum vor, denn
$
  lr((dif^2 U_"eff" (R))/(dif R^2) |)_(R_0) & = 24 epsilon.alt sigma^6 lr(((26 sigma^6)/R^14 - 7/R^8) |)_(R_0) \
  & = 24 epsilon.alt sigma^6 ((26 sigma^6)/(2^(14\/6) sigma^14) - 7/(2^(8\/6) sigma^8)) \
  & = 24 epsilon.alt sigma^6 (13/(2^(8\/6) sigma^8) - 7/(2^(8\/6) sigma^8)) \
  & = 24 epsilon.alt sigma^6 6/(2^(8\/6) sigma^8) = (72 epsilon.alt)/(2^(1\/3) sigma^2) \
  & = 9","10 dot 10^21 upright(K)/upright(m)^2 > 0
$
Der Wert des Potentials an diesem Minimum beträgt
$ U_"eff" (R_0) = 4 epsilon.alt (1/2^2 - 1/2) = -epsilon.alt = -10 unit("K") $
Da das Lennard-Jones-Potential auf seinem Definitionsbereich nur dieses ein Minimum besitzt und es am Rand des Definitionsbereichs $R -> infinity$ gegen $U_"eff" (R -> infinity) = 0$ geht, ist sichergestellt, dass es sich hierbei um das globale Minimum und somit auch wirklich um die tiefste Stelle des Potentials handelt. Hier wäre das Helium-Molekül also $-10 unit("K")$ stark gebunden. Nun ist ein typischer Effekt der Quantenmechanik aber, dass ein System nicht die minimale Energie eines Potentials annehmen kann, sondern immer mindestens die sogenannte Nullpunktsenergie bzw. in diesem Fall Nullpunktstemperatur besitzt.

Die Nullpunktstemperatur, also anschaulich vielleicht so etwas wie die minimale relative Schwingung beider Heliumatomen, die das Lennard-Jones-Potential ermöglicht erhält man am einfachsten, indem man den Potentialverlauf in der Umgebung des Minimums durch ein harmonisches Potential annähert. Im harmonischen Fall beträgt die Nullpunktstemperatur nämlich einfach $T_0 = (planck omega_0)/(2 k_B)$. Die zur Berechnung notwendige Grundfrequenz $omega_0$ erhält man aus einem Koeffizientenvergleich der Taylorentwicklung im Minimum des Lennard-Jones-Potentials bis zur zweiten Ordnung mit dem harmonischen Potential.
$
  U_"eff" (R) & = U_"eff" (R_0) + underbrace(lr((dif U_"eff" (R))/(dif R) |)_(R_0), 0) (R - R_0) \
  & quad + 1/2 lr((dif^2 U_"eff" (R))/(dif R^2) |)_(R_0) (R - R_0)^2 + cal(O)((R - R_0)^3) \
  & approx -epsilon.alt + (36 epsilon.alt)/(2^(1\/3) sigma^2) (R - R_0)^2,
$
Vergleicht man dies mit dem harmonischen Potential $U_"H" (R) = U_("H",0) + 1/k_B mu/2 omega_0^2 (R - R_0)^2$, wobei die reduzierte Masse $mu$ nötig ist, da das Potential die relative Bewegung zweier Teilchen beschreibt, erhält man
$ omega_0 = sqrt((72 thin k_B thin epsilon.alt)/(2^(1\/3) mu sigma^2)) $
und eine Nullpunktstemperatur von
$ T_0 = planck/(2 k_B) sqrt((72 k_B epsilon.alt)/(2^(1\/3) mu sigma^2)) = 3 planck sqrt((2^(2\/3) epsilon.alt)/(k_B mu sigma^2)) = 23","5 unit("K") $
Dieser Wert liegt signifikant oberhalb der maximalen Tiefe von $-10 unit("K")$ des Lennard-Jones-Potentials, sodass mit den hier betrachteten Werten für $epsilon.alt$ und $sigma$ keine stabilen Heliummoleküle zu erwarten sind.
