"""Worldsheet of an exact Kibble-Turok closed-string solution to the Nambu-Goto equations, swept through time and colored by local string speed (cusps flare at the speed of light)."""

from pathlib import Path

import numpy as np
from matplotlib.colors import LinearSegmentedColormap
from PIL import Image
from scipy.ndimage import gaussian_filter as blur
from scipy.spatial.transform import Rotation

W, H = 2400, 720
OUT = Path(__file__).with_name("banner.webp")
alpha, psi = 0.55, 1.1
t0, t1 = -0.3 * np.pi, 1.3 * np.pi  # time runs left to right; oscillation period is pi
R = Rotation.from_euler("YXZ", [0.3, 1.2, 0.2]).as_matrix()  # pleasing view
colors = ["#2348a8", "#3a7fd0", "#7a55c8", "#d0479a", "#ff7a4a", "#ffd68a", "#fff6e0"]
cmap = LinearSegmentedColormap.from_list("speed", colors)

acc = np.zeros((H, W, 4))  # rgb + cusp heat
# rows are curves: closed loops at fixed t, then worldlines of string bits at fixed sigma
for n_sig, n_t, rows, strength in [(9000, 150, "xy", 1.0), (56, 30000, "ij", 0.55)]:
    sig_grid = np.linspace(0, 2 * np.pi, n_sig, endpoint=False)
    sigma, t = np.meshgrid(sig_grid, np.linspace(t0, t1, n_t), indexing=rows)
    # x = [a(sigma - t) + b(sigma + t)] / 2 with |a'| = |b'| = 1 solves Nambu-Goto in
    # conformal gauge, cusps where a' = -b'. Evaluate at t, t +- dt for the velocity.
    ts = t + np.array([-1e-5, 0, 1e-5])[:, None, None]
    u, v = sigma - ts, sigma + ts
    a = (1 - alpha) * np.exp(1j * u) + alpha / 3 * np.exp(3j * u)
    x = a.imag + np.sin(v)
    y = -a.real - np.cos(psi) * np.cos(v)
    z = -2 * np.sqrt(alpha * (1 - alpha)) * np.cos(u) - np.sin(psi) * np.cos(v)
    p0, p, p1 = np.einsum("ij,jt...->ti...", R, np.stack([x, y, z])) / 2
    speed = np.linalg.norm(p1 - p0, axis=0) / 2e-5
    sx, sy = (t - t0) * W / (t1 - t0) + p[0] * 243, H / 2 - p[1] * 270
    depth = (p[2] - p[2].min(1, keepdims=True)) / np.ptp(p[2], 1, keepdims=True)
    # nearer parts brighter, sample density normalised by local arc length
    seg = np.hypot(np.gradient(sx, axis=1), np.gradient(sy, axis=1))
    weight = strength * (0.35 + 0.65 * depth) * np.clip(seg, 0.1, 2)
    vals = cmap(np.clip(speed, 0, 1) ** 1.6) * weight[..., None]
    vals[..., 3] *= np.clip((speed - 0.9) / 0.1, 0, 1) ** 3  # alpha slot -> cusp heat
    keep = (sx >= 0) & (sx < W) & (sy >= 0) & (sy < H)
    np.add.at(acc, (sy[keep].astype(int), sx[keep].astype(int)), vals[keep])

img, hot = acc[..., :3], acc[..., 3]
img /= np.percentile(img.sum(2)[img.sum(2) > 0], 97)
hot /= np.percentile(hot[hot > 0], 99)
bloom = sum(blur(img, (s, s, 0)) * w for s, w in [(4, 1.4), (14, 2.2), (40, 3)])
lum = 1 - np.exp(-(blur(img, (0.7, 0.7, 0)) * 1.6 + bloom * 0.9) * 1.2)
hot_glow = sum(blur(hot, s) * w for s, w in [(2, 2), (8, 5), (25, 8)])

# background: deep indigo with a soft central glow
yy, xx = np.linspace(-1, 1, H)[:, None, None], np.linspace(-1, 1, W)[:, None]
bg = [0.025, 0.02, 0.06] + [0.09, 0.04, 0.14] * np.exp(-2.07 * xx**2 - 0.77 * yy**2)
out = bg + lum * (1 - bg) + (1 - np.exp(-0.8 * hot_glow))[..., None] * [1, 0.92, 0.75]
out = np.clip(out, 0, 1) ** (1 / 1.05) * 255
out += np.random.default_rng(7).random((H, W, 1))  # dither against banding
Image.fromarray(out.astype(np.uint8)).save(OUT, quality=85, method=6)
