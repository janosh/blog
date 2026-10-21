// Title block and shorthands shared by the string theory exercise solutions.
#import "/notes.typ": notes
#import "@preview/cetz:0.5.2": draw

// e.g. #show: sheet.with(1, [October 11th, 2015], [October 14th, 2015])
#let sheet(n, date, due, body) = {
  show: notes.with(
    title: [String Theory -- Solution to Assignment #n],
    subtitle: [Lecturer: Timo Weigand],
    date: [Janosh Riebesell, #date (due #due)],
  )
  set heading(numbering: "1")
  set math.equation(numbering: "(1)")
  set enum(numbering: "a)")
  body
}

#let SP = $S_"P"$
#let NO = $cal(N)$
#let cR = $cal(R)$
#let zb = $macron(z)$
#let wb = $macron(w)$
// contour integral around the point p
#let oint(p) = $integral.cont_(C_#p)$
// once and twice underlined indices
#let u1(x) = math.underline(x)
#let u2(x) = math.underline(math.underline(x))
// Christoffel symbol with upper index a and lower indices b, and Riemann tensor R^a_(bcd)
#let chr(a, b) = $Gamma^#a zws_#b$
#let riem(a, b) = $R^#a zws_#b$

// === CeTZ drawing helpers ===
#let arrow-mark = (end: "stealth", fill: black, scale: 0.6)
#let lbl(pt, body, anchor: "center", padding: 2pt) = draw.content(pt, text(size: 8pt, body), anchor: anchor, padding: padding)
