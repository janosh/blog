#import "/notes.typ": vb, unit, ev
#import "/atomic-physics/sheet.typ": fig, sheet, pts
#import "@preview/cetz:0.5.2": canvas, draw
#import "@preview/cetz-plot:0.1.4": plot

#show: sheet.with([Probeklausur], [20.~Juli~2014], authors: [Janosh Riebesell])

#let (bmu, bs, bl, bB, br) = ($vb(mu)$, $vb(s)$, $vb(l)$, $vb(B)$, $vb(r)$)
#let hv(x) = $hat(vb(#x))$

#align(center, table(
  columns: 19,
  stroke: none,
  inset: (x: 4.5pt, y: 4pt),
  align: left,
  table.hline(stroke: 0.8pt),
  [Aufgabe], ..range(1, 18).map(str), [Summe],
  table.hline(stroke: 0.5pt),
  [Punkte], ..(3, 5, 6, 8, 5, 6, 7, 4, 6, 6, 4, 8, 4, 5, 6, 5, 5).map(str), [50],
  table.hline(stroke: 0.5pt),
  [Erreicht], ..range(18).map(_ => []),
  table.hline(stroke: 0.8pt),
))

= Das Wasserstoffatom #pts(3)

+ _Skizzieren sie die Funktionen $R_(n l)(r)$ und $r^2 R_(n l)^2 (r)$ für die 3s- und 3p-Zustände im H-Atom._ (2 Punkte)
  #figure(
    grid(
      columns: 2,
      column-gutter: 1.5em,
      row-gutter: 0.5em,
      fig("mock-exam-radial-wavefunctions.png"), fig("mock-exam-radial-densities.png"),
      text(size: 9pt)[*(a)* Radialer Anteil $R_(n l)(r)$ der elektronischen Wasserstoff-Wellenfunktion.],
      text(size: 9pt)[*(b)* Radiale Wahrscheinlichkeitsdichte $r^2 R_(n l)^2 (r)$ des Elektrons im Wasserstoffatom.],
    ),
    caption: [Abszissenbeschriftung in Å.],
  )
+ _Welche sinnvolle Größe wird durch $r^2 R_(n l)^2 (r)$ angegeben?_ (1 Punkt)

  $r^2 R_(n l)^2 (r)$ ist die Wahrscheinlichkeit (pro radialem Abstand), das Elektron im radialen Abstand $r$ vom Proton im Wasserstoffatom vorzufinden.

= Spin-Bahn-Kopplung #pts(5)

+ _Wie ist das magnetische Moment des Elektrons definiert?_ (1 Punkt)

  Mit jedem Drehimpuls ist ein magnetisches Moment verbunden. Das Elektron hat einen internen Drehimpuls, den Spin, und einen externen, den Bahndrehimpuls. Sein gesamtes magnetisches Moment ist die Summe dieser Beiträge (wegen der negativen Ladung antiparallel zu den Drehimpulsen):
  $
    bmu_(e^-) = bmu_s + bmu_l = -g_s mu_B bs/planck - g_l mu_B bl/planck = -mu_B/planck (g_s bs + g_l bl) approx -mu_B/planck (2 bs + bl) wide "mit" mu_B = (e planck)/(2 m_e)
  $
+ _Durch welche Wechselwirkung kommt die Spin-Bahn-Aufspaltung zustande? Bitte geben sie präzise die auftretenden Größen an und diskutieren sie die Abhängigkeit der Aufspaltung von der Kernladungszahl $Z$ und der Hauptquantenzahl $n$._ (4 Punkte)

  Magnetische Momente und Magnetfelder zeigen wegen $E_"mag" (br) = -bmu dot bB(br)$ eine Energieabhängigkeit bezüglich ihrer Ausrichtung zueinander. Parallele Ausrichtung minimiert die magnetische Energie, antiparallele Ausrichtung führt zu einer Energieerhöhung. Die Spin-Bahn-Wechselwirkung resultiert nun aus der Bewegung von Elektronen bzw. Protonen in Atomen. Diese führen zu zeitlich variierenden elektrischen Feldern (Strömen) die entsprechend dem erweiterten Durchflutungsgesetz (4. Maxwell-Gleichung) ein magnetisches Wirbelfeld erzeugen. Mit diesem Wirbelfeld wechselwirken die Spinanteile der magnetischen Momente von Elektronen und Protonen, da nur sie auch im Ruhesystem des jeweiligen Teilchens auftreten. Die Spin-Bahn-Wechselwirkungsenergie beträgt somit für Elektronen
  $ E_"mag" (br) = -bmu_s dot bB(br) = g_s mu_B bs/planck dot bB(br) approx e/m_e bs dot bB(br) $
  Die Abhängigkeit der Spin-Bahn-Kopplung von Bahndrehimpuls- und Hauptquantenzahl erhält man aus der Berechnung des Erwartungswertes der Spin-Bahn-Kopplungskonstante $xi(r)$ in der Wellenfunktion des gegebenen Systems, also
  $
    ev(xi(r))_(Psi_(n l)) = integral_0^infinity R_(n l)^* (r) thin xi(r) thin R_(n l)(r) thin r^2 dif r = (m c^2)/4 (Z alpha)^4/(n^3 l (l + 1/2)(l + 1))
  $
  Die Stärke der Spin-Bahn-Aufspaltung steigt also einerseits schnell mit der Anzahl der Ladungen im Atom an, anschaulich weil das Magnetfeld mit der Anzahl der bewegten Ladung zunimmt, andererseits nimmt sie für höhere Hauptquantenzahl auch schnell wieder ab, da die zugehörigen Orbitale weiter außen liegend und somit ein schwächeres Magnetfeld spüren.

= Dirac-Gleichung #pts(5)

+ _Benennen sie in ein bis zwei Sätzen die Gründe, weshalb die Dirac-Gleichung "notwendig" und sinnvoll ist._ (2 Punkte)

  Die Dirac-Gleichung bietet eine lorentzinvariante und somit inhärent relativistische Beschreibung von Spin-$1/2$-Fermionen. Es handelt sich um eine Differentialgleichung gleicher Ordnung in Raum und Zeit, wie durch die Relativitätstheorie gefordert, sodass sie sich unter Lorentz-Transformationen invariant verhält.
+ _Benennen sie vier physikalische Aspekte, die für das Wasserstoffatom aus der Dirac-Gleichung folgen, die sich aber nicht aus der Schrödingergleichung ergeben._ (4 Punkte)

  Es zeigt sich, dass Lösungen der Dirac-Gleichung notwendigerweise mindestens vierkomponentige Wellenfunktionen sind, auch Spinoren genannt. Man interpretiert diese vier Komponenten als Teilchen-/Antiteilchen jeweils mit Spin-Up und Spin-Down ein und desselben Fermions. Die Schrödinger-Gleichung selbst liefert weder Hinweise auf Antiteilchen noch auf den Spin. Aus ihr ergibt sich im Gegensatz zur Dirac-Gleichung deshalb auch keine Spin-Bahn-Kopplung und keine relativistischen Effekte.

= Einflüsse des Kerns #pts(8)

+ _Nennen sie vier Effekte, die bei der Berechnung atomarer Energieniveaus der Hüllen-Elektronen auf Einflüssen des Kerns beruhen._ (4 Punkte)
  #enum(
    numbering: "1)",
    [Coulombpotential],
    [Hüllenspin-Kernbahn-Wechselwirkung (meist einfach Spin-Bahn-Wechselwirkung)],
    [Kernspin-Hüllenspin-Wechselwirkung],
    [Kernspin-Hüllenbahn-Wechselwirkung],
  )
+ _Skizzieren sie alle Energieniveaus des 3s-Zustands in Natrium. Natrium ist ein Alkalimetall in der 1. Hauptgruppe mit Kernspin $I = 3\/2$._ (4 Punkte)

  Im 3$s$-Zustand gilt $n = 3$ und $l = 0$. Mit $s = 1/2$ kann der Hüllendrehimpuls nur $j = 1/2$ betragen. Der Gesamtdrehimpuls entstammt somit der Menge $F in {|j - I|, ..., j + I} = {1, 2}$. Die Hyperfeinstruktur des Natrium-3$s$-Zustands ist in @fig:sodium-hfs dargestellt.
  #figure(
    canvas(length: 0.85cm, {
      import draw: *
      let small(body) = text(size: 8pt, body)
      // F = 2 lies 3A/4 above, F = 1 5A/4 below the unsplit level
      let (up, down) = (1.5, -2.5)
      line((0, 0), (1.6, 0), stroke: blue + 1pt)
      line((1.6, 0), (2.6, up), stroke: gray)
      line((1.6, 0), (2.6, down), stroke: gray)
      line((1.6, 0), (4.6, 0), stroke: (dash: "dotted", thickness: 0.5pt))
      line((2.6, up), (4.1, up), stroke: red + 1pt)
      line((2.6, down), (4.1, down), stroke: 1pt)
      line((3.35, 0), (3.35, up - 0.03), mark: (end: "stealth", fill: black), stroke: 0.6pt)
      line((3.35, 0), (3.35, down + 0.03), mark: (end: "stealth", fill: black), stroke: 0.6pt)
      content((3.35, up + 0.3), small[$F = 2$])
      content((3.35, down - 0.3), small[$F = 1$])
      content((3.35, up / 2), small[$3A\/4$], fill: white, frame: "rect", stroke: none, padding: 1pt)
      content((3.35, down / 2), small[$5A\/4$], fill: white, frame: "rect", stroke: none, padding: 1pt)
      content((0.8, 0.3), small[$3^2 S_(1\/2)$])
      content((4.8, 0), small[$nu = 1772 unit("MHz")$], anchor: "west")
      content((0, 2.4), small[$I = 3\/2$], anchor: "west")
      content((0, 1.7), small[$J = 1\/2$], anchor: "west")
    }),
    caption: [Hyperfeinstruktur des 3$s$-Zustands von Natrium.],
  ) <fig:sodium-hfs>

= Helium-Atom #pts(5)

+ _Was ist die Ursache für das Auftreten von Singlett- und Triplett-Zuständen im Helium-Atom mit seinen beiden Elektronen?_ (2 Punkte)

  Ein System aus zwei Elektronen ist bosonisch und kann entweder den Spin $s_"asy" = 0$ oder $s_"sym" = 1$ haben. Man nennt den Zustand zu $s_"asy"$ Singlett, weil er lediglich in Verbindung mit $m_s = 0$ auftreten kann. Der Zustand zu $s_"sym"$ heißt Triplett, da er mit einer von drei möglichen magnetischen Spinquantenzahlen $m_s in {-1, 0, 1}$ vorkommt.
+ _Wieso liegen die Triplett-Zustände gegenüber den jeweiligen Singlett-Zuständen energetisch tiefer? Zum Beispiel ist $E(2^3 S_1) < E(2^1 S_0)$._ (2 Punkte)

  Bei der Konstruktion der Spinwellenfunktionen
  $ chi_(0,0)(1, 2) = 1/sqrt(2) (chi_arrow.t (1) chi_arrow.b (2) - chi_arrow.b (1) chi_arrow.t (2)) $
  $
     lambda_(1,1)(1, 2) & = lambda_arrow.t (1) lambda_arrow.t (2) \
     lambda_(1,0)(1, 2) & = 1/sqrt(2) (lambda_arrow.t (1) lambda_arrow.b (2) + lambda_arrow.b (1) lambda_arrow.t (2)) \
    lambda_(1,-1)(1, 2) & = lambda_arrow.b (1) lambda_arrow.b (2)
  $
  fällt auf, dass sich das Singlett antisymmetrisch und das Triplett symmetrisch unter Vertauschung der Spinkoordinaten 1 und 2 verhält. Man fordert, dass sich die Gesamtwellenfunktion, also das Produkt aus Orts- und Spinwellenfunktion, antisymmetrisch unter Vertauschung zweier Teilchen verhält. Zur symmetrischen Spinfunktion muss somit eine antisymmetrische Ortsfunktion multipliziert werden und umgekehrt:
  $ phi.alt_"sym" (br_1, br_2) = 1/sqrt(2) (phi.alt_a (br_1) phi.alt_b (br_2) + phi.alt_b (br_1) phi.alt_a (br_2)) $
  $ phi.alt_"asy" (br_1, br_2) = 1/sqrt(2) (phi.alt_a (br_1) phi.alt_b (br_2) - phi.alt_b (br_1) phi.alt_a (br_2)) $
  Im Fall $br_1 approx br_2 = br$, dass beide Hüllenelektronen sich stark annähern, gilt für die Ortswellenfunktionen
  $
    phi.alt_"sym" (br) approx sqrt(2) phi.alt_a (br) phi.alt_b (br) quad => quad |phi.alt_"sym" (br)|^2 approx 2 |phi.alt_a (br) phi.alt_b (br)|^2
  $
  $ phi.alt_"asy" (br) approx 0 quad => quad |phi.alt_"asy" (br)|^2 approx 0 $
  Es ist also davon auszugehen, dass der mittlere Abstand der Elektronen in der antisymmetrischen Ortswellenfunktion größer ist, sodass ihre gegenseitige Coulombabstoßung im Mittel geringer ist und die Triplettzustände stärker gebunden sind.
+ _Wieso gibt es keine elektrischen Dipolübergänge zwischen den Singlett- und Triplett-Zuständen? Betrachten sie dazu die Symmetrien der Wellenfunktionen und des elektrischen Dipoloperators._ (2 Punkte)

  Singlett- und Triplettzustände unterscheiden sich in ihrem Spin. Der elektrische Dipoloperator wirkt aber ausschließlich im Ortsraum und dort auch nur auf elektrische Dipolmomente. Mit dem Spin ist aber lediglich ein magnetisches Dipolmoment verbunden und explizit kein elektrisches Moment, sodass der elektrische Dipoloperator die Spinwellenfunktionen unverändert lässt. Er kann also keine Übergänge zwischen verschiedenen Multipletts treiben. Symmetrisch formuliert: Der Dipoloperator $-e (br_1 + br_2)$ ist spinunabhängig und symmetrisch unter Vertauschung der beiden Elektronen. Er lässt also die Austauschsymmetrie von Orts- und Spinwellenfunktion unverändert, sodass das Matrixelement zwischen einem Singlett (antisymmetrischer Spin) und einem Triplett (symmetrischer Spin) wegen der Orthogonalität der Spinwellenfunktionen verschwindet.

= Zeeman-Effekt und Hyperfeinstruktur #pts(6)

// hyperfine splitting of a 3p_1 level with nuclear spin I = 2, optionally followed by the
// weak-field Zeeman splitting of each F level into its 2F + 1 m_F sublevels
#let hfs-3p1(zeeman: false) = canvas(length: 0.7cm, {
  import draw: *
  let small(body) = text(size: 8pt, body)
  // level energies in units of A hbar^2 (scaled for drawing)
  let scale = 0.75
  let levels = ((3, 2), (2, -1), (1, -3))
  let (x-fan, x-level, x-axis) = (2.6, 4.2, 9)
  if zeeman {
    rect((x-level, -3 * scale), (x-axis, 2 * scale), fill: rgb("#bfdcf5"), stroke: none)
    rect((x-axis, -3.6 * scale), (x-axis + 4.5, 2 * scale + 1.4), fill: rgb("#c4ebc0"), stroke: none)
  }
  line((0, 0), (x-fan, 0), stroke: 1pt)
  content((0.6, 0.45), small[$3p_1$])
  line((x-fan, 0), (if zeeman { x-axis } else { x-level + 3.4 }, 0), stroke: (paint: gray, dash: "dotted", thickness: 0.5pt))
  content(if zeeman { (x-level + 2.4, 0.75) } else { (x-level + 1.6, 0.75) }, small[$V_"HFS"$])
  let x-end = if zeeman { x-axis } else { x-level + 3.4 }
  for (f, energy) in levels {
    let y = energy * scale
    line((x-fan, 0), (x-level, y), stroke: (dash: "dashed", thickness: 0.5pt))
    line((x-level, y), (x-end, y), stroke: 1pt)
    content((x-level + 0.6, y + if f == 3 { 0.35 } else { -0.35 }), small[$F = #f$])
  }
  // energy shifts of the three F levels relative to the unsplit one
  let x-arrow = x-end - 0.35
  let arrow(y0, y1) = line((x-arrow, y0), (x-arrow, y1), mark: (start: "stealth", end: "stealth", fill: black, scale: 0.6), stroke: 0.5pt)
  arrow(0, 2 * scale)
  arrow(0, -1 * scale)
  arrow(-1 * scale, -3 * scale)
  let anchor = if zeeman { "east" } else { "west" }
  let dx = if zeeman { -0.15 } else { 0.15 }
  content((x-arrow + dx, 1 * scale), small[$2A planck^2$], anchor: anchor)
  content((x-arrow + dx, -0.5 * scale), small[$-A planck^2$], anchor: anchor)
  content((x-arrow + dx, -2 * scale), small[$-3A planck^2$], anchor: anchor)
  if zeeman {
    line((x-axis, -3.8 * scale), (x-axis, 2 * scale + 1.5), mark: (end: "stealth", fill: black), stroke: 0.7pt)
    line((x-axis - 0.2, -3.8 * scale), (x-axis + 4.8, -3.8 * scale), mark: (end: "stealth", fill: black), stroke: 0.7pt)
    content((x-axis + 4.6, -3.8 * scale - 0.4), small[$B$])
    content((x-axis + 0.2, 2 * scale + 1.2), small[$Delta E_"Zeeman"$], anchor: "west")
    content((x-axis + 1.4, 0.6), small[$V_"mag"$])
    // each F level fans out into 2F + 1 sublevels, linear in B with slope prop. to m_F
    for (f, energy) in levels {
      let y = energy * scale
      for m in range(-f, f + 1) {
        let y-end = y + 0.22 * m
        line((x-axis, y), (x-axis + 4, y-end), stroke: 0.6pt)
        content((x-axis + 4.15, y-end), text(size: 6pt)[$#m$], anchor: "west")
      }
    }
  }
})

+ _Skizzieren sie die Aufspaltung der Hyperfeinzustände eines $3p_1$-Niveaus in einem schwachen Magnetfeld, wenn der Kernspin $I = 2$ ist._ (4 Punkte)

  Hierfür muss zunächst die Quantenzahl des atomaren Gesamtdrehimpulses $F$ berechnet werden. Der Gesamtdrehimpuls $vb(F) = vb(J) + vb(I)$ ist die Vektorsumme aus Gesamthüllendrehimpuls $vb(J)$ und Kernspin $vb(I)$.#footnote[Eine eventuelle Kernbewegung des Systems kann absepariert werden, sodass der Kern keinen Bahndrehimpuls trägt und $vb(F)$ auch wirklich den gesamten Drehimpuls des Systems aus Elektron im $3p_1$-Niveau und Kern erfasst.] Die $F$-Quantenzahl kann somit die Werte
  $ F in {|J - I|, |J - I| + 1, ..., J + I} $
  annehmen. Der Schreibweise $n thin l_J$ für den Zustand $3p_1$ kann man entnehmen, dass die Quantenzahl des Gesamthüllendrehimpulses $J = 1$ ist. Somit ist $F in {1, 2, 3}$. Mit der Hyperfeinstrukturwechselwirkungskonstante $A$ kann die Auswirkung der Hyperfeinkorrektur auf die Energie eines Zustands über den folgenden Erwartungswert berechnet werden
  $
    ev(hat(V)_"HFS") = A ev(hv(J) dot hv(I)) = A/2 ev(hv(F)^2 - hv(J)^2 - hv(I)^2) = A/2 lr(chevron.l F, m_F mid(|) hv(F)^2 - hv(J)^2 - hv(I)^2 mid(|) F, m_F chevron.r).
  $
  Mit den drei $F$-Einstellungen ergibt sich folglich auch eine dreifache Aufspaltung des Zustands $3p_1$
  $
    Delta E_"HFS" = (A planck^2)/2 (F(F + 1) - J(J + 1) - I(I + 1)) = cases(
      (A planck^2)/2 (2 - 2 - 6) = -3 A planck^2 quad & "für" F = 1,
      (A planck^2)/2 (6 - 2 - 6) = -A planck^2 & "für" F = 2,
      (A planck^2)/2 (12 - 2 - 6) = 2 A planck^2 & "für" F = 3,
    )
  $
  Die Aufspaltung ohne Berücksichtigung des schwachen Magnetfelds ist in @fig:hfs skizziert. Wird das Magnetfeld mit einbezogen, zeigen die Zustände eine weitere Aufspaltung nach der magnetischen Gesamtdrehimpulsquantenzahl $m_F$ (s. @fig:zeeman), die über $hat(V)_"mag" = g_F mu_B hat(F)_z B_z \/ planck$ außerdem linear von der Magnetfeldstärke abhängt.
  #figure(
    hfs-3p1(),
    caption: [Hyperfeinstrukturaufspaltung des $3p_1$-Zustands. Unter Berücksichtigung der Entartung aller drei Zustände (7-fach für $F = 3$, 5-fach für $F = 2$ und 3-fach für $F = 1$) ist der Linienschwerpunkt erhalten und die Summenregel erfüllt.],
  ) <fig:hfs>
  #figure(
    hfs-3p1(zeeman: true),
    caption: [Aufspaltung der Hyperfeinzustände nach der $m_F$-Quantenzahl innerhalb des Zeeman-Regimes eines schwachen Magnetfelds.],
  ) <fig:zeeman>
+ _Was bedeutet "schwaches" Magnetfeld in diesem Fall? Welche Wechselwirkungsenergie(n) ist(sind) in diesem Fall kleiner als welche andere(n)?_ (2 Punkte)

  In einem Atom besteht aufgrund der Spin-Bahn-Kopplung stets eine Wechselwirkung zwischen den Spins und den Bahndrehimpulsen der Hüllenelektronen. Die Stärke der Spin-Bahn-Kopplung geht mit der vierten Potenz der Kernladungszahl $Z$ eines Atoms. Sie fällt deshalb in schweren Atomen deutlich stärker aus, als in kleinen Atomen wie Wasserstoff und Helium. Die Hyperfeinwechselwirkung zwischen Hüllendrehimpuls $vb(J)$ und Kernspin $vb(I)$ ist nochmals um etwa drei Größenordnungen schwächer.

  Schwach bedeutet hier, dass die Zeeman-Energie der magnetischen Momente im äußeren Feld klein ist gegenüber der Hyperfeinwechselwirkung (und damit erst recht gegenüber der Spin-Bahn-Kopplung), also $g_F mu_B B << A planck^2$. Dann bleiben $vb(J)$ und $vb(I)$ zu $vb(F)$ gekoppelt und $F$, $m_F$ sind gute Quantenzahlen. Übersteigt die Zeeman-Energie die Hyperfeinaufspaltung, entkoppeln $vb(J)$ und $vb(I)$ (Paschen-Back-Effekt der Hyperfeinstruktur).

= Atom-Licht-Wechselwirkung #pts(7)

Wir betrachten ein ideales Zwei-Niveausystem ohne spontanen Zerfall aus dem angeregten Niveau und regen dieses System mit elektromagnetischer Strahlung an.

+ _Skizzieren sie den zeitlichen Verlauf der sogenannten "Rabi-Oszillation" (Achsenbeschriftung!) für den Fall, dass die anregende Strahlung in Resonanz mit dem atomaren Zwei-Niveausystem ist und für den Fall außerhalb der Resonanz._ (3 Punkte)
  #figure(
    placement: auto,
    canvas({
      import draw: content
      plot.plot(
        size: (6.5, 3.6),
        x-label: $Omega t$,
        y-label: $p_2 (t)$,
        x-tick-step: 2,
        y-tick-step: 0.2,
        x-min: 0,
        x-max: 10,
        y-min: 0,
        y-max: 1,
        axis-style: "left",
        {
          // p_2(t) = Omega^2 / W^2 sin^2(W t / 2) with W = sqrt(Omega^2 + Delta^2), Omega = 1
          for (detuning, color, label, pos) in (
            (0, rgb("#8080c0"), $Delta = 0$, (2.4, 0.83)),
            (1, rgb("#c080c0"), $Delta = Omega$, (1.9, 0.38)),
            (2, rgb("#c0c080"), $Delta = 2 Omega$, (1.5, 0.12)),
          ) {
            let rabi = calc.sqrt(1 + detuning * detuning)
            plot.add(t => calc.pow(calc.sin(rabi * t / 2), 2) / (rabi * rabi), domain: (0, 10), samples: 300, style: (stroke: color + 0.8pt))
            plot.annotate(content(pos, text(size: 8pt, label)))
          }
        },
      )
    }),
    caption: [Rabi-Oszillationen für verschiedene Grade der Verstimmung $Delta$ zwischen elektrischem Feld und der Resonanzfrequenz. $p_2 (t)$ ist die zeitabhängige Besetzungswahrscheinlichkeit des oberen Zustands und $Omega = vb(d)_12 dot vb(E) \/ planck$ die Rabi-Frequenz mit der die Besetzungswahrscheinlichkeit der beiden Zustände im Falle resonanter Anregung oszilliert. Interessanterweise wird die Oszillationsfrequenz größer und die Amplitude kleiner, wenn die Verstimmung des elektrischen Feldes zunimmt.],
  )
+ _Wenden sie die Auswahlregeln für elektrische Dipolübergänge auf das Heliumatom an. Skizzieren sie dazu die sieben niedrigsten Energiezustände eines Heliumatoms in einem schwachen magnetischen Feld und zeichnen sie die erlaubten elektrischen Dipolübergänge ein._ (4 Punkte)

  Elektrische Dipolübergänge sind Wechselwirkungsprozesse, die die Absorption oder Emission eines Photons involvieren. Da das Photon Spin $s_"ph" = 1$ trägt, kann sich aufgrund der Drehimpulserhaltung auch der Bahndrehimpuls des Atoms höchstens um $Delta l = plus.minus 1$ ändern. Auf den Spin hat der elektrische Dipoloperator, wie in Aufgabe 5.c) begründet, keinen Einfluss; er wirkt nur im Ortsraum und der Spin hat keine Ortswellenfunktion. Daraus folgt die Auswahlregel $Delta s = 0$. Theoretisch wäre es auch möglich, dass der Bahndrehimpuls nur gedreht wird, dass also $Delta l = 0$. Dann wäre aber die Parität der elektronischen Wellenfunktion im Atom wegen $P = (-1)^l$ die gleiche. In diesem Fall verschwindet das Übergangsdipolmoment $vb(p) = -e ev(Psi_f |hat(vb(r))| Psi_i)$, da der Dipoloperator ein ungerader Operator ist. Verschwindendes Übergangsdipolmoment heißt, dass der Übergang nicht stattfinden kann. Eine weitere Auswahlregel für elektrische Dipolübergänge ist somit $Delta l = plus.minus 1$.

  In @fig:helium sind alle Übergänge zwischen den untersten Niveaus von Para- und Orthohelium eingezeichnet, die diese Regeln erfüllen.
  #figure(
    placement: auto,
    fig("mock-exam-helium-levels.png", width: 48%),
    caption: [Erlaubte Übergänge zwischen den Niveaus von Para- und Orthohelium. Da sie sich im Spin unterscheiden, kann es keine Übergänge zwischen Helium mit symmetrischer und antisymmetrischer Spinwellenfunktion geben.],
  ) <fig:helium>

= Kopplungsschemata in Atomen #pts(4)

Betrachten sie ein Zwei-Elektronensystem mit einem $2p$- und einem $3d$-Elektron.

+ _Geben sie die in Mehrelektronenatomen auftretenden Schemata zur sogenannten "Kopplung" der Drehimpulse und Spins der Elektronen an._ (1 Punkt)

  Ein $2p$-Elektron hat die Quantenzahlen $n_(2p) = 2$ und $l_(2p) = 1$, ein $3d$-Elektron $n_(3d) = 3$ und $l_(3d) = 2$. Außerdem haben natürlich beide $s = 1/2$. In der $j$-$j$-Kopplung#footnote[Sie tritt besonders dann auf, wenn die Spin-Bahn-Kopplung jedes einzelnen Elektrons überwiegt gegenüber der Kopplung der Bahndrehimpulse $vb(l)_i$ und der Spins $vb(s)_i$ untereinander zu $vb(L)$ bzw. $vb(S)$. Das ist meist in großen Atomen der Fall, da die $l$-$s$-Kopplung mit $Z^4$ geht. $vb(L)$ und $vb(S)$ werden auch entkoppelt, wenn ein besonders starkes externes Magnetfeld anliegt. Dies nennt man den Paschen-Back-Effekt.] ergeben sich daraus
  $
    mat(delim: #none, j_(2p) in {1/2, 3/2}; ; j_(3d) in {3/2, 5/2}) quad => quad J in cases(
      {1, 2} & "für" j_(2p) = 1/2\, j_(3d) = 3/2,
      {2, 3} & "für" j_(2p) = 1/2\, j_(3d) = 5/2,
      {0, 1, 2, 3} quad & "für" j_(2p) = 3/2\, j_(3d) = 3/2,
      {1, 2, 3, 4} & "für" j_(2p) = 3/2\, j_(3d) = 5/2,
    )
  $
  Alternativ liefert die $L$-$S$-Kopplung, auch Russell-Saunders-Kopplung genannt, die vor allem in leichten Atomen auftritt
  $
    mat(delim: #none, L in {1, 2, 3}; ; S in {0, 1}) quad => quad J in cases(
      {1} & "für" S = 0\, L = 1,
      {2} & "für" S = 0\, L = 2,
      {3} quad & "für" S = 0\, L = 3,
    ) "und" J in cases(
      {0, 1, 2} & "für" S = 1\, L = 1,
      {1, 2, 3} quad & "für" S = 1\, L = 2,
      {2, 3, 4} & "für" S = 1\, L = 3,
    )
  $
+ _Geben sie die möglichen Terme für die beiden Kopplungsschemata in der Form $attach(L_J, tl: 2S + 1)$ bzw. $(j_1, j_2)_J$ an. Zeigen sie durch abzählen, dass die Zahl der möglichen Zustände und deren Gesamtdrehimpuls in beiden Fällen gleich sind._ (3 Punkte)

  Die Terme aus der $j$-$j$-Kopplung sind in @eq:jj-terms angegeben, die der $L$-$S$-Kopplung in @eq:ls-terms.
  $
    (1/2, 3/2)_(1,2) wide (1/2, 5/2)_(2,3) wide (3/2, 3/2)_(0,1,2,3) wide (3/2, 5/2)_(1,2,3,4)
  $ <eq:jj-terms>
  $
    attach(P_1, tl: 1) wide attach(D_2, tl: 1) wide attach(F_3, tl: 1) wide attach(P_(0,1,2), tl: 3) wide attach(D_(1,2,3), tl: 3) wide attach(F_(2,3,4), tl: 3)
  $ <eq:ls-terms>
  Es ergeben sich für beide Kopplungsschemata insgesamt 12 verschiedene Zustände, wovon 1 den Gesamtdrehimpuls $J = 0$ hat, 3 haben $J = 1$, 4 haben $J = 2$, 3 haben $J = 3$ und 1 hat $J = 4$.

= Lichtdruckkraft #pts(6)

+ _Von welchen Größen hängt die Kraft ab, die auf Atome durch einen Laserstrahl wirkt? Die Atome seien zunächst durch ein einfaches Zwei-Niveausystem beschrieben._ (2 Punkt)

  Die Kraft als zeitliche Änderung des Impulses hängt maßgeblich von dem *Photonenimpuls* ab, der bei jeder Absorption auf das Atom übertragen wird. Abhängig vom *Übergangsdipolmoment* zwischen den beiden am Übergang beteiligten atomaren Zuständen ist, wie häufig Atome Photonen absorbieren bzw. ob unter Einhaltung der Auswahlregeln der Übergang überhaupt erlaubt ist. Außerdem diktiert die *Lebensdauer* des angeregten Zustands über die spontane Emission, wie schnell das Atom wieder in das untere Niveau fällt und ein neues Laserphoton absorbieren kann. Die *Laserintensität* ist ebenfalls entscheidend. Ist sie zu hoch, zerfallen angeregte Zustände vornehmlich über induzierte Emission, wobei ein Photon der gleichen Mode, also gleicher Richtung und Frequenz ausgestrahlt wird, wie vorher aufgenommen wurde, sodass keine Netto-Kraft wirkt. Gleichzeitig führt ein zu schwacher Laser dazu, dass es nur selten überhaupt zu Photon-Atom-Interaktionen kommt.
+ _In realen Atomen gibt es stets mehr Energiezustände als das nur idealisiert angenommene Zwei-Niveausystem, das zur Ableitung und Erklärung der Kraft unter a) meist herangezogen wird. Diskutieren sie mit einer Skizze anhand eines effektiven Ein-Elektronen-Atoms mit $4s$-Grundzustand und dem durch einen Laserstrahl induzierten Übergang in den $5p$-Zustand, welche Probleme auftreten, um mit dem Laser eine Kraft auf das Atom wirken zu lassen. Der Kernspin sei $I = 1\/2$._ (3 Punkte)

  Unter Berücksichtigung des Kernspins und der Hyperfeinwechselwirkung spalten die beiden Zustände $4s$ und $5p$ wegen $hat(V)_"HFS" = A_"HFS" hv(J) dot hv(I)$ zweifach auf, je nach Stellung des Kernspins relativ zum Hüllendrehimpuls. Um eine möglichst große Kraft zu erreichen, muss der Laser unter Berücksichtigung der Rückstoßenergie und des Dopplereffekts auf Resonanz einer dieser Übergänge gestellt werden. Die Wahl liegt beim Experimentator. Im allgemeinen ist es aber möglich, dass ein angeregtes Atom unter Einhaltung der Auswahlregeln so zerfällt, dass es in dem Hyperfeingrundzustand landet, der gerade nicht resonant vom Laser angeregt werden kann. Man sagt der Laser ist "blind" für dieses Niveau. Atome, die einmal in diesem Zustand landen, können mit dem Laser nicht mehr oder nur noch schwach wechselwirken. Sie sind dem Experiment effektiv verloren gegangen.
+ _Wie ist(sind) das(die) Problem(e) unter b) im Experiment lösbar?_ (1 Punkt)

  Das Problem ist unter Hinzunahme weiterer, sogenannter Rückpumplaser leicht lösbar. Sie werden so eingestellt, dass sie Atome aus für den Primärlaser unerreichbaren Hyperfeinniveaus resonant anregen und so dem Experiment wieder zugänglich machen.
