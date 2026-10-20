"""Exact hydrogen orbital probability densities |psi_nlm|^2 rendered as glowing x-z cross-sections."""

from pathlib import Path

import numpy as np
from matplotlib import colormaps
from PIL import Image
from scipy.ndimage import gaussian_filter
from scipy.special import eval_genlaguerre, lpmv

y, x = np.mgrid[0:720, 0:2400.0]
light = np.zeros_like(x)
rads = np.array([165, 190, 225, 300, 225, 190, 165])  # display radii [px]
centers = np.cumsum(np.r_[-5, rads[:-1] + rads[1:] - 30])  # neighbors overlap by 30 px
orbitals = [(3, 1, 0), (5, 4, 0), (4, 2, 1), (6, 3, 1), (5, 2, 0), (4, 3, 1), (3, 2, 0)]
for cx, rad, (n, l, m) in zip(centers, rads, orbitals):
    r = np.linspace(0, 6 * n**2, 20_000)  # Bohr radii
    rho = 2 * r / n
    R = np.exp(-rho / 2) * rho**l * eval_genlaguerre(n - l - 1, 2 * l + 1, rho)  # R_nl
    cdf = np.cumsum((r * R) ** 2)
    scale = r[np.searchsorted(cdf / cdf[-1], 0.985)] / rad  # rad px hold 98.5% of P(r)
    d = np.hypot(x - cx, y - 360)
    dens = (np.interp(d * scale, r, R) * lpmv(m, l, (360 - y) / (d + 1e-9))) ** 2
    edge = np.clip(1.25 - d / rad, 0, 1) ** 2 * (0.8 + rad / 1500)  # outer ones dimmer
    light += (dens / dens.max()) ** 0.33 * edge

# bloom, tone map, horizontal vignette, deep violet floor instead of pure black
img = light + 0.35 * (gaussian_filter(light, 8) + gaussian_filter(light, 60))
img = (1 - np.exp(-1.9 * img)) * (1 - 0.3 * (x / 1200 - 1) ** 2)
rgb = np.maximum(colormaps["inferno"](0.97 * img)[..., :3], [0.025, 0.012, 0.05])
im = Image.fromarray(np.uint8(rgb * 255))
im.save(Path(__file__).with_name("banner.webp"), quality=85, method=6)
