"""Transverse-plane collider event display: charged helices in a 2 T solenoid (R = pT/0.3B), silicon/TRT hits, EM + hadronic calorimeter deposits and muons."""

from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.collections import LineCollection, PatchCollection, PolyCollection
from matplotlib.colors import LinearSegmentedColormap, to_rgba
from matplotlib.patches import Wedge
from PIL import Image
from scipy.ndimage import gaussian_filter

plt.switch_backend("agg")  # fixed-size buffer regardless of the display backend

rng = np.random.default_rng(7)
W, H = 2400, 720
R_SOL = 1.2  # m, solenoid radius
SILICON = [0.033, 0.0505, 0.0885, 0.1225, 0.299, 0.371, 0.443, 0.514]  # pixel + SCT
LAYERS = [(1.50, 1.58, 64), (1.58, 1.82, 256), (1.82, 1.97, 256)]  # EM (r0, r1, n_phi)
LAYERS += [(2.28, 2.70, 64), (2.70, 3.65, 64), (3.65, 4.25, 64)]  # hadronic
MU_RADII = [(4.9, 0.30), (7.1, 0.40), (9.5, 0.40)]  # muon stations (r, thickness)
# per-layer energy fractions, (EM, hadronic) shower width in phi; muons leave MIP energy
DEPOSIT = {"mu": ([0.1] * 3 + [0.6] * 3, 0.004, 0.01)}
DEPOSIT["gam"] = DEPOSIT["ele"] = ([0.25, 0.65, 0.10, 0, 0, 0], 0.012, 1)
DEPOSIT["had"] = DEPOSIT["neu"] = ([0.05, 0.18, 0.07, 0.22, 0.36, 0.12], 0.03, 0.045)
LEPTON = {"mu": "#ff6a48", "ele": "#c8ff6a"}
STRUCT = "#5b7fb8"
from_list = LinearSegmentedColormap.from_list
trk_cmap = from_list("trk", ["#2456d8", "#2fb8ff", "#9ff0ff", "#ffffff"])
em_cmap = from_list("em", ["#0d3b2e", "#1fa36b", "#9be15d", "#fff4a3"])
had_cmap = from_list("had", ["#3b0f14", "#b8321f", "#f07b2a", "#ffd27a"])


def rmap(r):
    """Display radius (px): linear (true curvature) in the tracker, compressed outside."""
    return np.interp(r, [0, R_SOL, 4.25, 20], [0, 276, 605.4, 2054.4])


def polar(r, a):
    return np.stack([r * np.cos(a), r * np.sin(a)], axis=-1)


def helix(pt, phi, eta, q, dl=0.002):
    """Helix (R = pT / 0.3 B, B = 2 T): tracker points, (x, y, phi) at the solenoid."""
    s = np.arange(dl, min(8, 2.7 / abs(np.sinh(eta))), dl)  # stop at the end caps
    ang = phi - q * 0.6 / pt * np.expm1(0.04 * s) / 0.04  # R ~ exp(-0.04 s): loopers
    xy = dl * np.cumsum(polar(1, ang), axis=0)
    r = np.hypot(*xy.T)
    k = np.argmax(np.append(r >= R_SOL, True))
    return xy[:k][r[:k] <= 1.082], (*xy[k], ang[k]) if k < len(s) else None


def angle_at(exit_pt, r):
    """Polar angle where the line from exit_pt = (x, y, phi) reaches radius r."""
    x, y, phi = exit_pt
    b = x * np.cos(phi) + y * np.sin(phi)
    t = -b + np.sqrt(b * b - x * x - y * y + r**2)
    return np.arctan2(y + t * np.sin(phi), x + t * np.cos(phi))


def wedge(r0, r1, a0=0, a1=360, **kw):
    """Annular sector between physical radii r0 and r1, angles in degrees."""
    return Wedge((0, 0), rmap(r1), a0, a1, width=rmap(r1) - rmap(r0), **kw)


# ---- event: underlying event + 4 jets of charged/neutral hadrons and photons ------
phi, eta = rng.uniform(-1, 1, (2, 140)) * [[np.pi], [2.5]]
pt = 0.2 + rng.exponential(0.6, 140)
jets = [(410, 0.10, 0.3, 44), (365, np.pi + 0.16, -0.5, 40)]  # (pT, phi, eta, n)
for pt_jet, phi_j, eta_j, n in jets + [(85, -2.05, 0.9, 16), (55, 1.95, -1.1, 11)]:
    frac = rng.gamma(0.55, size=n)
    pt_i = np.maximum(pt_jet * frac / frac.sum(), 0.4)
    dphi, deta = rng.normal(0, 0.012 + 0.12 * np.exp(-pt_i / 6), (2, n))
    pt, phi, eta = np.r_[pt, pt_i], np.r_[phi, phi_j + dphi], np.r_[eta, eta_j + deta]
kind = rng.choice(["had", "gam", "neu"], pt.size, p=[0.62, 0.26, 0.12])
q = np.where(kind == "had", rng.choice([-1, 1], pt.size), 0)
particles = [*zip(pt, phi, eta, q, kind), (48, 2.72, 0.4, -1, "mu")]
particles += [(41, -0.42, -0.2, 1, "mu"), (36, 0.86, 0.6, -1, "ele")]
# ---- propagate: tracker hits, muon stations, calo energy Gaussian-shared in phi ------
cells = [np.abs(rng.normal(0, 0.08, n)) for *_, n in LAYERS]  # noise / pile-up floor
hit_radii = np.r_[SILICON, np.linspace(0.563, 1.052, 18)]  # + every other TRT straw
rr = np.linspace(R_SOL, 12, 200)
tracks, rgba, widths, hits, hit_colors, stations = [], [], [], [], [], []
for pt, phi, eta, q, kind in particles:
    pts, exit_pt = helix(pt, phi, eta, q) if q else ([], (0.0, 0.0, phi))
    if len(pts) > 2:
        c = np.clip(np.log10(pt / 0.2) / np.log10(150), 0, 1)
        rgba.append(to_rgba(LEPTON.get(kind, trk_cmap(c))))
        widths.append(2.2 if kind in LEPTON else 0.7 + c)
        tracks.append(rmap(1) * pts)  # rmap is linear inside the solenoid
        r = np.hypot(*pts.T)[:, None]
        hits += list(tracks[-1][(r >= hit_radii).argmax(axis=0)[hit_radii <= r.max()]])
        hit_colors += [rgba[-1]] * (len(hits) - len(hit_colors))
    if abs(eta) > 1.45 or exit_pt is None:
        continue  # outside the barrel calorimeter
    if kind == "mu":  # straight through the calorimeters into the spectrometer
        line = polar(rmap(rr), angle_at(exit_pt, rr))
        tracks[-1] = np.vstack([tracks[-1], line])
        stations += [line[(rr > r - 0.05) & (rr < r + th + 0.3)] for r, th in MU_RADII]
    fracs, *sigmas = DEPOSIT[kind]
    energy = 1 if kind == "mu" else pt * np.cosh(eta)
    for i, (r0, r1, n) in enumerate(LAYERS):
        d = (np.arange(n) + 0.5) * 2 * np.pi / n - angle_at(exit_pt, (r0 + r1) / 2)
        w = np.exp(-0.5 * (np.angle(np.exp(1j * d)) / sigmas[i > 2]) ** 2)
        cells[i] += energy * fracs[i] * w / w.sum()
# ---- draw (2x supersampled): tracker, solenoid, calo envelopes, muon system
fig = plt.figure(figsize=(W / 100, H / 100), dpi=200, facecolor=(0.012, 0.016, 0.04))
ax = fig.add_axes((0, 0, 1, 1), frame_on=False, xlim=(-1200, 1200), ylim=(-360, 360))
annuli = [(r - 0.004, r, STRUCT, 0.5) for r in [0.025, *SILICON, 0.554, 1.082]]
annuli += [(0.554, 1.082, "#2a4a80", 0.1), (1.15, 1.25, "#7a8fb0", 0.18)]
annuli += [(1.45, 1.97, "#1d6b5a", 0.1), (2.28, 4.25, "#7a3a2a", 0.09)]
for r0, r1, fc, alpha in annuli:
    ax.add_patch(wedge(r0, r1, fc=fc, alpha=alpha))
a = np.pi / 4 * np.arange(8) + np.pi / 8 + [[-0.015], [0.015]]  # 8 toroid coils x 2
coils = polar(rmap(np.array([4.4, 10.2])), a.reshape(-1, 1))
ax.add_collection(LineCollection(coils, colors="#8a7fb8", lw=1, alpha=0.22))
r, th = np.repeat(MU_RADII, 16, axis=0).T[..., None]  # 16 sectors x 3 stations
k = np.arange(48)[:, None]
rd = rmap(r + 0.25 * (k % 2) + th * [0, 1, 1, 0])  # chamber corners
hh = rd[:, :1] * np.tan(np.pi / 16) * (1 - 0.3 * (k % 2)) * [-1, -1, 1, 1]
corners = polar(np.hypot(rd, hh), k * np.pi / 8 + np.arctan2(hh, rd))
ax.add_collection(PolyCollection(corners, fc="#3d5c99", ec=STRUCT, lw=0.5, alpha=0.24))
for i, ((r0, r1, n), e) in enumerate(zip(LAYERS, cells)):  # calorimeter cells
    cmap, e_min, e_max = (em_cmap, 0.4, 120) if i < 3 else (had_cmap, 1.2, 150)
    c = np.clip(np.log(e / e_min) / np.log(e_max / e_min), 0, 1)
    fc = np.c_[cmap(c)[:, :3], (e > e_min) * (0.25 + 0.75 * c**0.6)]
    grid = [wedge(r0, r1, a, a + 360 / n) for a in 360 * np.arange(n) / n]
    ax.add_collection(PatchCollection(grid, fc=fc, ec=STRUCT + "33", lw=0.3, zorder=3))
tower = sum(e.reshape(64, -1).sum(axis=1) for e in cells)  # 64 summed phi towers
k = np.flatnonzero(tower > 2)
a = 2 * np.pi * (k[:, None] + 0.5) / 64
bars = polar(rmap(4.3) + 26 * np.sqrt(tower[k, None]) * [0, 1], a)
cols = had_cmap(np.clip(0.45 + np.log1p(tower[k]) / 9, 0, 1))
ax.add_collection(LineCollection(bars, colors=cols, lw=9, alpha=0.75, zorder=3))
for scale, alpha in [(3.2, 0.1), (1, 0.95)]:  # track glow + core
    lw = scale * np.array(widths)
    ax.add_collection(LineCollection(tracks, colors=rgba, lw=lw, alpha=alpha, zorder=4))
ax.scatter(*np.array(hits).T, s=2.2, c=hit_colors, alpha=0.9, lw=0, zorder=6)
ax.add_collection(LineCollection(stations, color="#ffd0b0", lw=5, alpha=0.85, zorder=6))
fig.canvas.draw()
img = np.asarray(fig.canvas.buffer_rgba())[..., :3] / 255
yy, xx = np.ogrid[-H / 2 : H / 2 : 1j * len(img), -W / 2 : W / 2 : 1j * len(img[0])]
glow = np.exp(-((np.hypot(xx, yy) / 520) ** 2))[..., None] * [0.035, 0.05, 0.11]
img = 1 - (1 - img) * (1 - glow)  # screen blends stay <= 1
bright = img * np.clip((img.max(axis=2, keepdims=True) - 0.35) / 0.65, 0, 1)
for sigma, weight in [(4, 0.6), (14, 0.45), (40, 0.35)]:  # bloom: screen-blend blurs
    img = 1 - (1 - img) * (1 - weight * gaussian_filter(bright, (sigma, sigma, 0)))
img = Image.fromarray((img * 255).astype(np.uint8)).resize((W, H), Image.LANCZOS)
img.save(Path(__file__).with_name("banner.webp"), quality=85, method=6)
