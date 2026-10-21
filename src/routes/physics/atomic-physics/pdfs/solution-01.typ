#import "/notes.typ": dd, task, vb, unit, ket, braket
#import "/atomic-physics/sheet.typ": fig, sheet, up, dn

#show: sheet.with([Übungsblatt 1], [15.~April 2014])


#heading(numbering: none)[Präsenzaufgaben]

= Stern-Gerlach-Experiment

#task[
  Ein kollimierter Strahl von Silberatomen ($m approx 108 unit("u")$) propagiert durch ein inhomogenes magnetisches Feld und wird dann auf einer Detektorplatte detektiert. Das Magnetfeld habe einen Gradienten in $z$-Richtung. Das magnetische Moment des Silberatoms entspricht dem eines einzelnen Elektrons $|vb(mu)| = -g_S e/(2 m_e) |vb(s)|$ mit $|vb(s)| = 1\/2$. Aus der Wechselwirkungsenergie $V_"mag" = -vb(mu) dot vb(B)$ des magnetischen Moments mit dem Magnetfeld ergibt sich die Kraft, die das Silberatom im inhomogenen Magnetfeld erfährt, zu
  $ F_z = -partial/(partial z) V_"mag" = mu_z dot (partial B_z)/(partial z) $ <eq:force>
  #figure(
    fig("sheet-01-stern-gerlach-setup", width: 60%),
    caption: [Darstellung des Stern-Gerlach-Experiments. Der Strahl von Silberatomen bewegt sich entlang der $x$-Achse, die Aufspaltung wird in $z$-Richtung beobachtet. Die Länge der Magneten und der Driftstrecke betragen jeweils $L_"mag" = L_"drift" = 0","2 unit("m")$.],
  ) <fig:setup>
]

+ #task[Beschreiben sie den Ausgang des Experiments von Stern und Gerlach. Welches Muster würde man auf der Detektorplatte erwarten, wenn der Spin nicht gequantelt wäre?]

  Die Silberatome verhalten sich wie Elektronen im Hinblick auf ihren Spin, d.h. sie tragen Spin $1/2$ entweder in positiver oder negativer $z$-Richtung. Dieser Spin verursacht gemäß
  $ mu_z = -g_S e/(2 m_e) s_z $ <eq:moment>
  ein magnetisches Moment entlang der $z$-Achse. Solch ein magnetisches Moment erfährt in einem nicht verschwindenden Magnetfeldgradienten eine ablenkende Kraft. Da das Stern-Gerlach-Experiment ein inhomogenes Magnetfeld aufweist, erwartet man, dass sich die Silberatome in zwei disjunkten Flächen auf dem Detektor akkumulieren.

  Ohne Spinquantelung tritt zwar ebenfalls eine Ablenkung der Silberatome mit von null verschiedener $z$-Komponente des magnetischen Moments auf. Da die Ablenkung aber über Gleichung @eq:force linear vom magnetischen Moment abhängt und dieses nun kontinuierlich verteilt ist, wäre auch die Ablenkung kontinuierlich. Der Detektor würde also einen Strich zeigen, der die Flecken des gequantelten Szenarios verbindet.

  #figure(
    fig("sheet-01-stern-gerlach-result", width: 60%),
    caption: ["Experimental result" zeigt das tatsächliche Ergebnis auf dem Schirm des Stern-Gerlach-Experiments.],
  ) <fig:result>

  _Anmerkung_: Aufgrund der Topologie des Magnetfelds wurden im tatsächlichen Experiment keine zwei Flecken beobachtet, sondern eine Verteilung, die dem Umriss des Auges ähnelt (s. @fig:result).

+ #task[Wie groß ist die Aufspaltung auf der Detektorplatte mit einem Magnetfeldgradienten von $partial_z B_z = 40 unit("T/m")$ und einer Austrittsgeschwindigkeit der Silberatome von $v_x = 400 unit("m/s")$?]

  Die Aufspaltung setzt sich aus zwei Beiträgen zusammen. Einerseits erfahren die Silberatome innerhalb des Magneten eine aufspaltende Kraft, andererseits ändern sie dadurch ihre Flugrichtung, sodass sich beide Strahlen auf der Driftstrecke bis zum Detektor weiter voneinander entfernen.

  Der Aufspaltung in $z$-Richtung $s_"mag"$ innerhalb des Magneten lässt sich wie folgt berechnen
  $ s_"mag" = 1/2 a t^2 = 1/2 F_z/m_"Ag" t^2 = 1/2 F_z/m_"Ag" (L_"mag"/v_x)^2 $ <eq:s-mag>
  Man setzt Gleichungen @eq:force und anschließend @eq:moment für $F_z$ ein und erhält
  $ s_"mag" = 1/2 mu_z/m_"Ag" L_"mag"^2/v_x^2 (partial B_z)/(partial z) = -(g_s e s_z)/(4 m_"Ag" m_e) L_"mag"^2/v_x^2 (partial B_z)/(partial z) $ <eq:s-mag-explicit>
  Formel @eq:s-mag-explicit macht deutlich, dass die Elektronen mit Spin $+1/2$ in negativer $z$-Richtung abgelenkt werden und umgekehrt. Für $g_s = 2$ und $s_z = -1/2 planck$ beträgt die Ablenkung
  $ s_"mag" = 2","59 dot 10^(-4) unit("m") = 0","26 unit("mm") $
  Vernachlässigt man Randfelder, so verläuft die Bewegung nach Verlassen des Magnetfelds geradlinig. Die Flugbahn der Silberatome bildet folglich ein rechtwinkliges Dreieck mit der Detektorplatte und der $x$-Achse. Der Ablenkungsbeitrag durch die Driftstrecke kann somit berechnet werden durch
  $ s_"drift" = tan(alpha) dot L_"drift", $
  wobei $alpha$ den Winkel zwischen Flugbahn und $x$-Achse bezeichnet. $tan(alpha)$ ist nun gleich der Ableitung der Parabelbahn, die die Silberatome im Magnetfeld durchführen, beim Verlassen der Magneten.
  $
    s_"drift" & = lr((partial s_"mag" (x))/(partial x) |)_(x = L_"mag") dot L_"drift" \
              & = -(g_s e s_z)/(2 m_"Ag" m_e) (partial B_z)/(partial z) L_"mag"/v_x^2 dot L_"drift" = 2 s_"mag",
  $
  da $L_"mag" = L_"drift" = 0","2 unit("m")$. Die Gesamtaufspaltung beträgt somit
  $ Delta z = 2 (s_"mag" + s_"drift") = 6 s_"mag" = 1","55 unit("mm") $

+ #task[Welches Ergebnis erwartet man für ein Atom mit Gesamtdrehimpuls $F = 1$ bzw. mit Gesamtdrehimpuls $F = 5\/2$? (Hinweis: $F$ ist die Quantenzahl der Hyperfeinstruktur.)]

  Als Drehimpulsquantenzahl erfüllt $F$ die für Drehimpulse bekannten algebraischen Beziehungen. Es gibt demnach zum Gesamtdrehimpuls $F$ genau $2 F + 1$ mögliche Einstellungen der $z$-Komponente. Man erwartet also einen ähnlichen Ausgang des Experiments mit dem Unterschied, dass statt zwei Akkumulationsflächen für $F = 1$ drei und für $F = 5\/2$ sechs auf dem Detektor erscheinen sollten.

+ #task[Wieso ist es viel schwieriger das Experiment mit Elektronen statt mit Atomen durchzuführen?]

  Die Aufspaltung eines Teilchenstrahls in einem inhomogenen Magnetfeld hängt, wie in Gleichung @eq:s-mag-explicit ersichtlich, vom Verhältnis aus Spin und Masse der Teilchen ab. Da Elektronen ebenfalls Spin-$1/2$-Teilchen sind, aber eine um den Faktor $2 dot 10^5$ kleinere Masse aufweisen, wäre ihre Ablenkung um diesen Faktor verstärkt.

  Ein weiterer Unterschied ist, dass Elektronen im Gegensatz zu den Silberatomen elektrische Ladung tragen. Ein potentielles Problem ist also die "in-flight" Abstoßung zwischen Elektronen und ein daraus resultierendes "Ausfransen" des Strahls.

= Drehimpuls

+ #task[Bestimmen sie die möglichen Winkel des Drehimpulsvektors mit der $z$-Achse für ein System mit $l = 2$ und skizzieren sie diese.]

  Der Drehimpuls eines Systems im Zustand $l = 2$ hat den Betrag $|vb(L)| = sqrt(planck^2 l (l + 1)) = sqrt(6) planck$. Die $z$-Komponente kann Werte aus der Menge $L_z in {-2 planck, -1 planck, 0, 1 planck, 2 planck}$ annehmen.

  In einem rechtwinkligen Dreieck mit dem Drehimpulsvektor als Hypotenuse ist der Polarwinkel $theta$ zwischen dem Drehimpuls und seiner $z$-Komponente gegeben durch
  $ theta = arccos(L_z \/ |vb(L)|). $
  Der Winkel $theta$ kann also, genau wie $L_z$ nur in fünf Einstellungen vorliegen. In der Reihenfolge wie bei $L_z$ sind das
  $ theta in {144","74 degree; 114","09 degree; 90 degree; 65","91 degree; 35","26 degree}. $

+ #task[Welche ungefähre Drehimpulsquantenzahl hat eine Vinyl-Schallplatte, die sich auf dem Plattenteller mit $f = 33","3 unit("U/min")$ dreht? ($L = I dot omega$, $I approx 10^(-3) unit("kg m")^2$)]

  Das Quadrat des Drehimpulses $vb(L)^2$ ist gegeben durch den Eigenwert $planck^2 l (l + 1)$ des Drehimpulsoperators $hat(vb(L))^2$:
  $ vb(L)^2 = omega^2 I^2 limits(=)^! planck^2 l (l + 1) approx planck^2 l^2 $
  Daraus ergibt sich die Drehimpulsquantenzahl $l$ direkt zu
  $ l approx (omega I)/planck approx 3","31 dot 10^31 $

= Addition zweier Spins

#task[
  Betrachten sie ein System aus zwei Spin $1\/2$ Teilchen in der Basis ${ket(S_(1,z)\, S_(2,z))} = {ket(up\, up), ket(up\, dn), ket(dn\, up), ket(dn\, dn)}$#footnote[$up$ bedeutet Spin-up, d.h. die $z$-Komponente des Spins wird bei einer Messung den Wert $+1/2 planck$ liefern. Umgekehrt steht $dn$ für Spin-down bzw. $S_z = -1/2 planck$.] bestehend aus Eigenvektoren zu den Operatoren $hat(vb(S))_1^2$, $hat(vb(S))_2^2$, $hat(S)_(1,z)$, $hat(S)_(2,z)$. Finden sie eine neue Basis aus Eigenvektoren zu den Operatoren $hat(vb(S))^2$, $hat(vb(S))_1^2$, $hat(vb(S))_2^2$, $hat(S)_z$ mit $vb(S) = vb(S)_1 + vb(S)_2$ und bestimmen sie die Eigenwerte zu $hat(S)_z$.
]

Der Zustandsraum eines Systems aus 2 Spin-1/2-Teilchen ist das Tensorprodukt der einzelnen Spinzustände der beiden Teilchen $hat(S)_1 times.o hat(S)_2$, und damit vierdimensional. Aus diesem Grund erfordert jede Basis eines solchen Systems auch genau vier linear unabhängige Basisvektoren. Die Vektoren der Menge ${ket(S_(1,z)\, S_(2,z))}$ sind die Eigenzustände der vier Observablen $S_1^2$, $S_2^2$, $S_(1,z)$, $S_(2,z)$.

Man kann nun eine neue Basis $ket(S\, S_z)$ aus Eigenvektoren konstruieren. Hierbei handelt es sich um Eigenvektoren zum Satz $S_1^2$, $S_2^2$, $S^2$, $S_z$ von kommutierenden Observablen. Es gelten die bekannten Eigenwertgleichungen. $vb(S)$ ist ein Drehimpuls, und daher muss $S$ nichtnegativ ganz- oder halbzahlig sein. $S_z$ liegt in ganzzahligen Schritten zwischen $-S$ und $+S$.

Ein System aus zwei Spins hat als mögliche Gesamtspinzustände Werte zwischen $|S_1 - S_2|$ und $S_1 + S_2$, also im Falle zweier Spin-$1/2$-Teilchen $S in {0, 1}$. Daraus ergeben sich die zwei Unterräume $cal(H)(S = 1)$ und $cal(H)(S = 0)$ für den Gesamtspin. Zur Bestimmung der neuen Basis werden beide getrennt betrachtet.

In $cal(H)(S = 1)$ liegt ein Spintriplett vor, da $S_z in {-S, -S + 1, ..., S} = {-1, 0, 1}$. Für $S_z = 1$ ist notwendigerweise $S = 1$ und somit $ket(S\, S_z) = ket(1\, 1)$ der einzige Eigenvektor zu $S_z = 1$. Da $S_z$ und $S^2$ kommutieren, ist er auch Eigenvektor zu $S^2$. Aus $1 = S_z = S_(z,1) + S_(z,2)$ folgt $S_(z,1) = S_(z,2) = 1/2$. Der Zustand $ket(S\, S_z) = ket(1\, 1)$ ist also derselbe, wie $ket(S_(1,z)\, S_(2,z)) = ket(up\, up) = ket(+1/2\, +1/2)$.

Um auch die anderen Zustände des Tripletts zu finden, verwendet man den Absteigeoperator $hat(S)_-$, der $S_z$ bei jeder Anwendung auf die nächst tiefere Quantenzahl absenkt.
$ hat(S)_- ket(S\, S_z) = planck sqrt(S (S + 1) - S_z (S_z - 1)) ket(S\, S_z - 1) $
Damit ergibt sich angewandt auf den Zustand $ket(1\, 1)$:
$
  hat(S)_- ket(1\, 1) & = planck sqrt(1 (1 + 1) - 1 (1 - 1)) ket(1\, 1 - 1) \
                      & = planck sqrt(2 - 1 (0)) ket(1\, 0) = sqrt(2) planck ket(1\, 0)
$
Da der Zustand $ket(1\, 1)$ mit dem Zustand $ket(up\, up)$ aus der alten Basis korrespondiert, kann man auch schreiben:
$ ket(1\, 0) = 1/(sqrt(2) planck) hat(S)_- ket(up\, up) $
Um den neuen Zustand nun explizit mithilfe der alten Basisvektoren auszudrücken, greift man auf die Definition $vb(S) = vb(S)_1 + vb(S)_2$ des Gesamtspins zurück, woraus folgt, dass $hat(S)_- = hat(S)_(1,-) + hat(S)_(2,-)$ ist.
$
  ket(1\, 0) & = 1/(sqrt(2) planck) (hat(S)_(1,-) + hat(S)_(2,-)) ket(up\, up) \
             & = 1/(sqrt(2) planck) (planck sqrt(1/2 (1/2 + 1) - 1/2 (1/2 - 1)) ket(dn\, up) + planck sqrt(1/2 (1/2 + 1) - 1/2 (1/2 - 1)) ket(up\, dn)) \
             & = 1/sqrt(2) (sqrt(3/4 + 1/4) ket(dn\, up) + sqrt(3/4 + 1/4) ket(up\, dn)) \
             & = 1/sqrt(2) (ket(dn\, up) + ket(up\, dn))
$
Durch erneutes Anwenden des Absteigeoperators, diesmal auf $ket(1\, 0)$ erhält man den dritten Zustand des Spintripletts $ket(1\, -1) = 1\/(sqrt(2) planck) hat(S)_- ket(1\, 0)$. Die Darstellung des Zustands $ket(1\, 0)$ in der alten Basis ist bereits bekannt, woraus folgt:
$
  ket(1\, -1) & = 1/(sqrt(2) planck) (hat(S)_(1,-) + hat(S)_(2,-)) 1/sqrt(2) (ket(dn\, up) + ket(up\, dn)) \
              & = 1/(2 planck) (underbrace(hat(S)_(1,-) ket(dn\, up), 0) + hat(S)_(1,-) ket(up\, dn) + hat(S)_(2,-) ket(dn\, up) + underbrace(hat(S)_(2,-) ket(up\, dn), 0)) \
              & = 1/(2 planck) (planck ket(dn\, dn) + planck ket(dn\, dn)) = ket(dn\, dn)
$ <eq:triplet-down>
Der erste und vierte Summand im Mittelteil von Gleichung @eq:triplet-down verschwindet, da der Absteigeoperator in beiden Fällen auf einen Spin wirkt, der bereits im niedrigsten Zustand vorliegt. In solch einem Fall liefert der Absteigeoperator null.

Der vierte und letzte Basisvektor ergibt sich aus dem Spinunterraum $cal(H)(S = 0)$. Hierbei muss es sich um das Spinsinglett $ket(0\, 0)$ handeln, da $S_z$ als einziges den Wert 0 annehmen kann.

An den letzten Basisvektor ergeben sich einige Bedingungen daraus, dass er orthogonal zur restlichen Basis stehen muss. Aus der Orthogonalität zu $ket(up\, up)$ und $ket(dn\, dn)$ folgt, dass es sich um eine Linearkombination aus $ket(up\, dn)$ und $ket(dn\, up)$ handelt.
$
              ket(0\, 0) & = alpha ket(up\, dn) + beta ket(dn\, up) \
  => quad 1 & = braket(0\, 0, 0\, 0) = |alpha|^2 + |beta|^2
$ <eq:singlet-norm>
mit $alpha, beta in CC$. Aus der Orthogonalität von $ket(0\, 0)$ zum mittleren Spintriplett $braket(0\, 0, 1\, 0) = 0$ erhält man schließlich noch
$
  0 = 1/sqrt(2) (& alpha braket(up\, dn, up\, dn) + alpha braket(up\, dn, dn\, up) \
    & + beta braket(dn\, up, up\, dn) + beta braket(dn\, up, dn\, up)) = 1/sqrt(2) (alpha + beta)
$ <eq:singlet-orth>
Wegen @eq:singlet-orth muss also gelten $alpha = -beta$ und mit @eq:singlet-norm sind $alpha$ und $beta$ bis auf einen Phasenfaktor festgelegt.
$ alpha = -beta = 1/sqrt(2) e^(i x) quad "mit" x in RR $
In der Wahl von $x$ ist man frei. Setzt man zum Beispiel $x = 0$, ergibt sich daraus der letzte Basisvektor zu:
$ ket(0\, 0) = 1/sqrt(2) (ket(up\, dn) - ket(dn\, up)) $
Weitere Details zu dieser Rechnung finden sich auf der Website der Universität Mainz.

#heading(numbering: none)[Übungsaufgaben]
#counter(heading).update(0)

= Einfluss der gravitativen Wechselwirkung

#task[
  Zwischen Elektron und Proton im Wasserstoffatom kommt es neben der Coulomb-Wechselwirkung auch zu einer gravitativen Anziehung. Bestimmen sie den relativen Einfluss der gravitativen Wechselwirkung auf die Energieniveaus des Atoms. Die Potentiale beider Wechselwirkungen lauten:
  $ V_C = -(Z e^2)/(4 pi epsilon_0 r) #h(4em) V_G = -G (m_e m_p)/r $
  (Hinweis: Beachten sie, dass Gravitations- und Coulomb-Potential die gleiche $r$-Abhängigkeit besitzen.)
]

Im Wasserstoffatom wirkt streng genommen nicht nur die Coulombsche Anziehungskraft zwischen entgegengesetzten Ladungen $q_1$ und $q_2$, gegeben durch
$ vb(F)_C (vb(r_1)) = (q_1 q_2)/(4 pi epsilon_0) (vb(r)_1 - vb(r)_2)/(|vb(r)_1 - vb(r)_2|^3), $
sondern auch die gravitative Anziehungskraft zwischen zwei Massen $m_1$ und $m_2$:
$ vb(F)_G (vb(r_1)) = G m_1 m_2 (vb(r)_1 - vb(r)_2)/(|vb(r)_1 - vb(r)_2|^3). $
Es handelt sich in beiden Fällen um konservative Kraftfelder. Das effektive Potential auf das Elektron im Wasserstoffatom resultiert also aus der Summe der Potentiale beider Kräfte:
$
  V_"eff" = V_C + V_G & = -1/r (e^2/(4 pi epsilon_0) + G m_e m_p) \
                      & = -(c planck)/r (alpha + (G m_e m_p)/(c planck)) = -(c planck)/r kappa
$
Den relativen Einfluss auf die Energieniveaus des Wasserstoffs $Delta E \/ E_"eff" = (E_"eff" - E_C) \/ E_"eff" = 1 - E_C \/ E_"eff"$ erhält man nun über die Formel $E_n = -1/2 kappa^2 mu c^2 1/n^2$ auf Folie 1-3 des Skripts.
$
  (Delta E)/E_"eff" & = 1 - alpha^2/kappa^2 = 1 - alpha^2/(alpha + (G m_e m_p)/(c planck))^2 \
                    & = 1 - 1/(1 + (G m_e m_p)/(c planck alpha))^2 approx (2 G m_e m_p)/(c planck alpha) = 8","81 dot 10^(-40)
$

= Wasserstoffähnliche Atome

#task[Bestimmen sie die Bindungsenergie und die Ausdehnung des Grundzustands im wasserstoffähnlichen Uran-Ion $U^(91+)$.]

Der mittlere Abstand $chevron.l r_(n,l) chevron.r$ ist gegeben durch den Erwartungswert der radialen Koordinate $r$.
$ chevron.l r_(n,l) chevron.r = integral_(RR^3) Psi_(n,l,m)^* thin r thin Psi_(n,l,m) dd(vb(r)) = integral_0^infinity r thin P_(n,l) (r) dd(r) $
Hierbei bezeichnet $P_(n,l) (r)$ die Wahrscheinlichkeit, das Elektron des Uran-Ions irgendwo im Abstand $r$, also innerhalb einer dünnen Kugelschale zwischen $r$ und $r + dif r$ zu finden. Sie kann durch die Integration der Wahrscheinlichkeitsdichte $|Psi_(n,l,m) (r, theta, phi.alt)|^2$ über das Volumen der Kugelschale berechnet werden.
$
  P_(n,l) (r) & = integral_0^pi integral_0^(2 pi) underbrace(|Psi_(n,l,m) (r, theta, phi.alt)|^2, |R_(n,l) (r)|^2 thin |Y_(l,m) (theta, phi.alt)|^2) r^2 sin(theta) dd(phi.alt) dd(theta) \
              & = r^2 |R_(n,l) (r)|^2 integral_0^pi integral_0^(2 pi) |Y_(l,m) (theta, phi.alt)|^2 sin(theta) dd(phi.alt) dd(theta)
$
Das Integral über den Winkelanteil der Wellenfunktion über alle Winkel ergibt genau 1. Anschaulich bedeutet es, dass das Elektron mit Sicherheit in irgendeiner Richtung vom Kern aus gesehen anzutreffen ist. Mit dem Radialteil der Wellenfunktion des Wasserstoffatoms ergibt sich somit für den mittleren Abstand des Elektrons vom Kern
$ chevron.l r_(n,l) chevron.r = integral_0^infinity r^3 |R_(n,l) (r)|^2 dd(r) = (n^2 a_0)/Z (3/2 - (l (l + 1))/(2 n^2)), $
mit der Kernladungszahl $Z$ und dem bohrschen Radius $a_0 = 0","53 unit(Å)$. Für das Uran-Ion mit dem einzig verbliebenen Elektron im Grundzustand gilt $n = 1$, $l = 0$ und $Z = 92$ und somit
$ chevron.l r_(n,l) chevron.r = 3/2 a_0/92 = underline(underline(0","86 unit("pm"))) $
Die Bindungsenergie lässt sich nicht einfach als Coulomb-Potential im mittleren Abstand berechnen, da die kinetische Energie nicht klein ist: Nach dem Virialsatz gilt $chevron.l T chevron.r = -1/2 chevron.l V chevron.r$, und $chevron.l 1\/r chevron.r = Z\/(n^2 a_0) != 1\/chevron.l r chevron.r$. Die Bohr-Formel liefert für $n = 1$
$ E_"Bind" = 1/2 chevron.l V_C chevron.r = -Z^2 dot 13","6 unit("eV") = underline(underline(-115","2 unit("keV"))) $
Wegen $Z alpha approx 0","67$ sind relativistische Korrekturen allerdings erheblich: Die Dirac-Gleichung liefert $E = m_e c^2 (sqrt(1 - (Z alpha)^2) - 1) approx -132 unit("keV")$.

= Magnetfeld am Ort des Elektrons

#task[
  Bestimmen sie klassisch das Magnetfeld, dem ein Elektron ausgesetzt ist, das ein Proton im Abstand $a_0$ mit Drehimpuls $planck$ umkreist. \
  (Hinweis: Benutzen sie das Ruhesystem des Elektrons und $B = (mu_0 I)/(2 r)$ für eine mit Strom $I$ durchflossene Drahtschlaufe des Radius $r$).
]

Im Ruhesystem des Elektrons ist der Kreisstrom konstant und gegeben durch $I = (partial Q)/(partial t) = e/t_U = e dot f_U$, mit der Zeit $t_U$ für einen Umlauf des Protons um das Elektron. Für den Betrag des Drehimpulses dieses Systems gilt $|vb(L)| = omega dot J(r)$ mit dem Trägheitsmoment $J(r)$.

Anhand des Drehimpulses des Elektrons $|vb(L)_e| = planck$ kann man die (Kreis-)Frequenz berechnen, mit der das Elektron im Ruhesystem des Protons kreist. Mit derselben Frequenz muss dann auch das Proton um das Elektron kreisen.
$ omega_p = omega_e = planck/J(r) $
Das Trägheitsmoment $J(r)$ einer Punktmasse $m$ im Abstand $r$ einer Drehachse beträgt $J(r) = m dot r^2$. Da man ein Zweiteilchensystem hier als effektives Einteilchenproblem behandelt muss korrekterweise für $m$ statt der Elektronenmasse in diesem Fall die reduzierte Masse $mu = (m_e dot m_p)/(m_e + m_p)$ des gebundenen Elektron-Proton-Zustands eingesetzt werden. Die Abweichung ist allerdings aufgrund der viel größeren Protonmasse gering.
$ omega_p = planck/(mu dot a_0^2) quad => quad I = e dot planck/(2 pi mu dot a_0^2) $
Für das Magnetfeld am Ort des Elektrons aufgrund des Kreisstroms verursacht durch das Proton im Abstand $a_0$ folgt daraus
$ B = (mu_0 I)/(2 r) = e dot planck/(2 pi mu a_0^2) mu_0/(2 a_0) = (e thin planck thin mu_0)/(4 pi mu thin a_0^3) $
Setzt man für $a_0$ den Bohrschen Radius von $0","53 unit(Å)$ ein, erhält man $B = 12","52 unit("T")$.
