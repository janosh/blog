"""Liquid-hydrogen bubble chamber event: pi- p -> Lambda K0s + pions in 1.6 T, with Bethe-Bloch energy loss, multiple scattering, delta rays, V0 decays, a gamma -> e+e- conversion and a pi -> mu -> e chain."""

from pathlib import Path

import numpy as np
from matplotlib.colors import LinearSegmentedColormap
from PIL import Image
from scipy.ndimage import gaussian_filter

rng = np.random.default_rng(11)
B, X0, T_CUT = 1.6, 890.0, 0.15  # T, LH2 radiation length [cm], min delta KE [MeV]
ME, MMU, MPI, MK, MP, MLAM = 0.511, 105.66, 139.57, 497.6, 938.27, 1115.68  # MeV
K, DMIN = 0.307075 * 0.99212 * 0.0708, 0.273  # LH2 K Z/A rho, ~min dE/dx [MeV/cm]
OUT = Path(__file__).with_name("banner.webp")
bubbles = []  # (positions x + iy [cm] in the 200 x 60 cm window, momenta [MeV/c])


def add(z, th, p, m, q, depth=0, x_stop=215):
    """Step a charged particle through the chamber dropping bubbles ~ dE/dx, recurse into delta rays."""
    ke = np.hypot(p, m) - m
    while ke > 0.08 and -15 < z.real < x_stop and -15 < z.imag < 75:
        beta, bg = p / (ke + m), p / m
        tmax = 2 * ME * bg**2 / (1 + 2 * (ke + m) * ME / m**2 + (ME / m) ** 2)
        loss = K / beta**2 * (np.log(np.sqrt(2 * ME * tmax) * bg / 21.8e-6) - beta**2)
        loss += (m == ME) * ke / X0  # bremsstrahlung
        tmax = ke / 2 if m == ME else tmax  # Moller
        radius = p / (3 * B)  # cm
        ds = min(0.03 * radius, 0.25, max(0.04 * ke / loss, 0.002))
        th += -q * ds / radius + rng.normal(0, 13.6 / (beta * p) * np.sqrt(ds / X0))
        z += ds * np.exp(1j * th)
        u = ds * rng.random(rng.poisson(13 * ds * max(loss, DMIN) / DMIN))
        bubbles.append((z - u * np.exp(1j * th), np.full(u.size, p)))
        n_delta = 0.5 * K / beta**2 * (1 / T_CUT - 1 / tmax) * ds  # 1/T^2 spectrum
        for _ in range(rng.poisson(n_delta) if depth < 2 and tmax > T_CUT else 0):
            t = 1 / (1 / T_CUT - rng.random() * (1 / T_CUT - 1 / tmax))
            pe = np.sqrt(t * t + 2 * t * ME)
            ang = np.arccos(min(t / pe * np.sqrt(1 + 2 * ME / tmax), 1))
            add(z, th + rng.choice([-1, 1]) * ang, pe, ME, -1, depth + 1)
        ke = max(ke - loss * ds, 0.0)
        p = np.sqrt(ke * ke + 2 * ke * m)
    return z, th


R_BEAM = 4000 / (3 * B)  # 4 GeV/c pi- beam from the left, arcs centred on the window
th0 = -105 / R_BEAM
for y0 in [4.0, 10.5, 15.0, 21.5, 27.0, 41.0, 47.5, 53.0, 58.5]:
    add(-12 + 1j * y0, th0, 4000, MPI, -1)

# beam track aimed at the vertex (72, 30.5): pi- p -> Lambda K0s pi+ pi- pi+ pi- pi0
y0 = 30.5 - R_BEAM * (np.cos(th0) - np.cos(th0 + 84 / R_BEAM))
v, th_v = add(-12 + 1j * y0, th0, 4000, MPI, -1, x_stop=72)
for dth, p, q in [(0.06, 1100, -1), (-0.12, 700, 1), (-0.55, 330, -1)]:
    add(v, th_v + dth, p, MPI, q)
z, th = add(v, th_v + 1.15, 112, MPI, 1)  # stops, pi+ -> mu+ nu
z, th = add(z, th + 2.2, 29.8, MMU, 1)  # 4.1 MeV mu+ -> e+ nu nu
add(z, th - 1.9, 38.0, ME, 1)

# V0 decays Lambda -> p pi-, K0s -> pi+ pi- at rest-frame angle a, boosted to the lab
V0 = [(950, MLAM, MP, 0.9, 0.24, 10.5), (720, MK, MPI, 1.25, -0.3, 8.5)]
for p0, m0, m1, a, dth, dist in V0:
    th = th_v + dth
    pstar = np.sqrt((m0**2 - (m1 + MPI) ** 2) * (m0**2 - (m1 - MPI) ** 2)) / (2 * m0)
    for m, q in ((m1, 1), (MPI, -1)):
        ks = q * pstar * np.exp(1j * a)  # rest frame, real part along the flight path
        k = ks + (np.hypot(p0, m0) / m0 - 1) * ks.real + p0 / m0 * np.hypot(pstar, m)
        add(v + dist * np.exp(1j * th), th + np.angle(k), abs(k), m, q)

# pi0 -> gamma gamma, one 175 MeV photon converts to an e+ e- pair near the window centre
for q, e in ((-1, 0.38 * 175), (1, 0.62 * 175)):
    add(v + 27 * np.exp(1j * (th_v + 0.035)), th_v + 0.035 - 0.004 * q, e, ME, q)

# elastic scatter of a beam track downstream: kink + short heavily-ionizing recoil proton
add(146 + 41j, th0 + 158 / R_BEAM - 0.05, 3980, MPI, -1)
add(146 + 41j, th0 + 158 / R_BEAM - 1.35, 260, MP, 1)

# Compton electrons knocked out by stray photons (position, momentum)
compton = [(30 + 18j, 14.5), (122 + 12j, 9.5), (168 + 50j, 22.5), (50 + 52j, 7.5)]
compton += [(190 + 20j, 11.5), (110 + 55j, 5.5), (12 + 40j, 9.5)]
for z, p in compton:
    add(z, rng.uniform(-np.pi, np.pi), p, ME, -1)

# splat jittered bubbles coloured by momentum on a 2x supersampled canvas
H, W, PX = 1440, 4800, 24  # px/cm
colors = ["#fff1c9", "#ffc15e", "#ff7a59", "#e0457b", "#a23cc0", "#5b4ad8"]
cmap = LinearSegmentedColormap.from_list("p", colors)
zb, pb = map(np.concatenate, zip(*bubbles))
py, px = np.array([60 - zb.imag, zb.real]) * PX + rng.normal(0, 0.5, (2, zb.size))
rgb = cmap(np.log(pb) / np.log(4000))[:, :3] * rng.uniform(0.6, 1.4, (zb.size, 1))
hist = [np.histogram2d(py, px, (H, W), [[0, H], [0, W]], weights=c)[0] for c in rgb.T]
acc = np.stack(hist, -1)
acc[rng.integers(0, H, 1400), rng.integers(0, W, 1400)] += [0.5, 0.45, 0.6]  # boiling

# glow, flash-lit violet background and film grain
glow = sum(w * gaussian_filter(acc, (s, s, 0)) for s, w in [(1.3, 10), (5, 4), (28, 6)])
yy, xx = np.ogrid[0 : 1 : H * 1j, 0 : 1 : W * 1j]
flash = np.exp(-(((xx - 0.48) / 0.55) ** 2) - ((yy - 0.5) / 0.9) ** 2)[..., None]
img = 1 - np.exp(-glow) + [0.015, 0.012, 0.035] + flash * [0.08, 0.045, 0.14]
img += rng.normal(0, 0.006, (H, W, 1))
out = Image.fromarray(np.uint8(np.clip(img, 0, 1) * 255))
out.resize((2400, 720), Image.LANCZOS).save(OUT, quality=85, method=6)
