"""Procedural chalkboard with real QFT and string theory equations (Polyakov action, Virasoro algebra, Veneziano amplitude, ...) and a Feynman vertex thickening into a closed-string pair-of-pants worldsheet."""

from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from PIL import Image
from scipy.ndimage import gaussian_filter, gaussian_filter1d

plt.switch_backend("agg")
plt.rcParams.update({"mathtext.fontset": "cm", "lines.solid_capstyle": "round"})
W, H, SS = 2400, 720, 2
rng = np.random.default_rng(42)
chalk = {"white": "#edede6", "yellow": "#fae08c", "blue": "#99d1f7", "pink": "#f7a8c7"}

# color, x, y, fontsize, rotation, latex. Rows: central column (visible on phones), left,
# right, edge filler (mostly cropped), worldsheet labels, faint half-erased ghosts.
TEXTS = r"""
white 1200 200 34 0.6 $[L_m, L_n] = (m-n)\,L_{m+n} + \frac{c}{12}\,m(m^2-1)\,\delta_{m+n,0}$
white 1200 532 33 -0.5 $S_P = -\frac{1}{4\pi\alpha'}\int d^2\sigma\, \sqrt{-h}\, h^{ab}\, \partial_a X^\mu\, \partial_b X_\mu$
white 350 212 30 -1.0 $Z[J] = \int \mathcal{D}\phi\; e^{\,i S[\phi] + i\int d^4x\, J\phi}$
yellow 340 360 30 0.8 $\beta(g) = -\frac{g^3}{16\pi^2}\left(11 - \frac{2}{3}\, n_f\right)$
white 345 515 30 -0.6 $\mathcal{L} = -\frac{1}{4}F^a_{\mu\nu}F^{a\,\mu\nu} + \bar{c}^{\,a}\,\partial^\mu D_\mu^{ab}\,c^{\,b}$
pink 2050 210 30 0.9 $\alpha' M^2 = 4\,(N - 1),\quad D = 26$
white 2060 360 32 -0.7 $A(s,t) = \frac{\Gamma(-\alpha(s))\,\Gamma(-\alpha(t))}{\Gamma(-\alpha(s)-\alpha(t))}$
blue 2050 518 28.5 0.5 $T(z)T(w) \sim \frac{c/2}{(z-w)^4} + \frac{2T(w)}{(z-w)^2} + \frac{\partial T(w)}{z-w}$
white 390 655 20 0.4 $X^\mu = x^\mu + \alpha' p^\mu \tau + i\sqrt{\frac{\alpha'}{2}}\sum_{n\neq 0}\frac{1}{n}\left(\alpha^\mu_n e^{-in(\tau-\sigma)} + \tilde\alpha^\mu_n e^{-in(\tau+\sigma)}\right)$
yellow 2030 665 26 -0.5 $\partial_\mu j^\mu_5 = \frac{e^2}{16\pi^2}\,\epsilon^{\mu\nu\rho\sigma}F_{\mu\nu}F_{\rho\sigma}$
white 1250 62 26 -0.3 $S_{NG} = -T\int d^2\sigma\,\sqrt{-\det\left(\partial_a X^\mu\, \partial_b X_\mu\right)}$
blue 300 70 26 0.6 $\langle\Omega|T\{\phi(x_1)\cdots\phi(x_n)\}|\Omega\rangle$
pink 2100 60 26 -0.8 $\chi = 2 - 2g$
pink 1572 478 28 0 $\tau$
pink 1705 305 28 0 $\sigma$
ghost 720 120 30 1.2 $\Pi^{\mu\nu}(q) = (q^2 g^{\mu\nu} - q^\mu q^\nu)\,\Pi(q^2)$
ghost 1700 110 30 -1.5 $\{Q, b_n\} = L_n^{\mathrm{tot}}$
ghost 1650 600 30 0.8 $\frac{1}{\epsilon} - \gamma_E + \ln 4\pi$
ghost 800 610 30 -0.9 $\int\frac{d^dk}{(2\pi)^d}\frac{1}{(k^2-\Delta)^2}$
ghost 150 430 34 1.7 $e^{-S_E}$
ghost 2300 440 30 -1.2 $\tau \to -1/\tau$
"""
texts = [line.split(maxsplit=5) for line in TEXTS.strip().splitlines()]
strokes = []  # (x, y, color, linewidth, linestyle)


def draw(color, z, lw=3.0, amp=1.2, ls="-"):  # z: complex pixel coords
    dx, dy = 3.5 * amp * gaussian_filter1d(rng.standard_normal((2, len(z))), 12)
    strokes.append((z.real + dx, z.imag + dy, color, lw, ls))


# Feynman cubic vertex (two particles merge into one), a thickening arrow and an arrow
# along tau: color, start, end, linewidth, wobble, chevron position along line, size
for col, p0, p1, lw, amp, f, size in [
    ("yellow", 745 + 300j, 905 + 365j, 3.2, 1.2, 0.44, 16),
    ("yellow", 745 + 430j, 905 + 365j, 3.2, 1.2, 0.44, 16),
    ("yellow", 905 + 365j, 1030 + 365j, 3.2, 1.2, 0.56, 16),
    ("white", 1055 + 365j, 1122 + 365j, 3.0, 0.6, 1, 18),
    ("pink", 1440 + 478j, 1552 + 478j, 2.6, 0.5, 1, 16),
]:
    draw(col, np.linspace(p0, p1, 60), lw, amp)
    u = size * (p1 - p0) / abs(p1 - p0)  # open chevron arrowhead
    draw(col, p0 + f * (p1 - p0) - u * np.array([1 - 0.55j, 0, 1 + 0.55j]), lw, 0)

# closed-string pair of pants: two incoming loops join into one, smoothstep-blended edges
s = np.linspace(0, 1, 160)
x, k = 1185 + 465 * s, s * s * (3 - 2 * s)
draw("blue", x + 1j * (264 + 51 * k), 3.4)
draw("blue", x + 1j * (466 - 51 * k), 3.4)
draw("blue", 1185 + 190 * (4 * s * (1 - s)) ** 0.8 + 1j * (390 - 50 * s), 3.4)
th = np.linspace(-np.pi / 2, 3 * np.pi / 2, 120)
for c, r in [(1185 + 302j, 38), (1185 + 428j, 38), (1650 + 365j, 50)]:
    draw("white", c + 13 * np.cos(th) + 1j * r * np.sin(th), 3.0, 0.8)
# a constant-tau slice on the outgoing tube: front solid, back dashed
r = 101 - 51 * np.interp(1520, x, k)
for half, lw, amp, ls in [(th[:60], 2.4, 0.5, "-"), (th[60:], 2.2, 0, (0, (3, 3)))]:
    draw("blue", 1520 + 365j + 13 * np.cos(half) + 1j * r * np.sin(half), lw, amp, ls)


def rasterize(texts, lines):
    """Render text and polylines (pixel coords) to premultiplied RGBA at SS x size."""
    fig = plt.figure(figsize=(W / 100, H / 100), dpi=100 * SS, facecolor="none")
    for col, x, y, size, rot, tex in texts:
        txt = fig.text(float(x) / W, 1 - float(y) / H, tex, color=chalk.get(col))
        txt.set(fontsize=float(size), rotation=float(rot), ha="center", va="center")
    for x, y, col, lw, ls in lines:
        fig.add_artist(plt.Line2D(x / W, 1 - y / H, color=chalk[col], lw=lw, ls=ls))
    fig.canvas.draw()
    rgba = np.asarray(fig.canvas.buffer_rgba()) / 255
    return np.dstack([rgba[..., :3] * rgba[..., 3:], rgba[..., 3]])


def noise(sigma):
    n = gaussian_filter(rng.standard_normal((H * SS, W * SS, 1)), sigma)
    return n / n.std()


# board: dark green slate with large-scale mottling and fine grain
img = (1 + 0.07 * noise(25 * SS) + 0.04 * noise(0.7)) * [0.075, 0.115, 0.11]
# eraser smears (broad streaks of leftover chalk dust) and half-erased ghost text
smear = np.clip(0.45 * noise((10 * SS, 60 * SS, 0)), 0, 1)
smear *= np.clip(0.8 + 0.3 * noise((2, 14, 0)), 0, 1.5)
ghost = rasterize([g for g in texts if g[0] == "ghost"], [])[..., 3:]
img += (0.07 * smear + 0.09 * gaussian_filter(ghost, 2.5 * SS)) * [0.8, 0.85, 0.82]

# chalk: grainy, broken strokes (fine grain, streaks, patches) and a faint dust halo
grain = 0.74 + 0.3 * noise(0.8) + 0.14 * noise((0.6, 5, 0)) + 0.1 * noise(6)
ink = rasterize([g for g in texts if g[0] != "ghost"], strokes)
ink = 0.92 * (ink * grain.clip(0, 1) + 0.1 * gaussian_filter(ink, (5 * SS, 5 * SS, 0)))
img = img * (1 - ink[..., 3:]) + ink[..., :3]

# soft vignette and a hint of overhead light
yy, xx, _ = np.ogrid[-0.45 : 0.55 : H * SS * 1j, -0.5 : 0.5 : W * SS * 1j, :1]
img *= np.clip(1.08 - 0.45 * ((xx / 0.62) ** 2 + (yy / 0.95) ** 2), 0.45, 1.1)
img = np.clip(img.reshape(H, SS, W, SS, 3).mean(axis=(1, 3)), 0, 1) ** (1 / 1.05)
img = Image.fromarray((img * 255).astype(np.uint8))
img.save(Path(__file__).with_name("banner.webp"), quality=85, method=6)
