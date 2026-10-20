"""Ray-traced Schwarzschild black hole: null geodesics through a thin Novikov-Thorne accretion disk with Doppler/gravitational redshift, lensing a star field."""

from pathlib import Path

import numpy as np
from matplotlib import colormaps
from matplotlib.colors import LinearSegmentedColormap
from PIL import Image
from scipy.ndimage import gaussian_filter as blur
from scipy.ndimage import map_coordinates
from scipy.spatial import cKDTree

W, H, SS = 2400, 720, 2  # output size and supersampling factor
R_CAM, INCL = 60.0, np.radians(84.0)  # camera distance (G = c = M = 1), disk tilt
R_IN, R_OUT = 6.0, 32.0  # disk from ISCO outwards
OUT = Path(__file__).with_name("banner.webp")

# pixel centers at focal length 1300 output px. Each ray stays in the plane spanned by e1
# (outward radial at camera) and e2, leaving the camera at angle arctan(rho) from -e1.
Y, X = np.mgrid[H * SS - 1 : -H * SS : -2, 1 - W * SS : W * SS : 2] / (2600 * SS)
rho = np.hypot(X, Y)
e1 = np.array([np.sin(INCL), 0, np.cos(INCL)])
e2 = np.stack([-Y * np.cos(INCL), X, Y * np.sin(INCL)], -1) / rho[..., None]
phi_c = np.mod(np.arctan2(-e1[2], e2[..., 2]), np.pi)  # first crossing of z = 0

# orbit table u(phi; rho), u = 1/r, u'' = 3u^2 - u by leapfrog (v = du/dphi at half
# steps). Rays freeze once they escape (u <= 0, recording the angle) or fall in (u >= 1/2).
n_rho, dphi, n_steps = 30000, 0.004, 2500  # phi up to 10 > 3 pi
rho_grid = np.linspace(0, rho.max() * 1.001, n_rho)
u = np.full(n_rho, 1 / R_CAM)
v = u * np.sqrt(1 - 2 * u) / np.maximum(rho_grid, 1e-9) + dphi / 2 * (3 * u - 1) * u
table = np.empty((n_steps, n_rho), np.float32)
phi_esc = np.full(n_rho, np.inf)
for step in range(n_steps):
    table[step] = u
    live = (u > 0) & (u < 0.5)
    u = np.where(live, u + dphi * v, u)
    esc = live & (u <= 0)
    phi_esc[esc] = (step + table[step, esc] / (table[step, esc] - u[esc])) * dphi
    v += dphi * (3 * u - 1) * u

rng = np.random.default_rng(7)
# turbulent texture: log-normal brightness fluctuations, sheared along Keplerian orbits
tex = blur(rng.normal(size=(192, 1024)), (1, 24), mode="wrap")
tex += 3 * blur(rng.normal(size=(192, 1024)), (4, 60), mode="wrap")
tex = np.exp(0.25 * tex / tex.std())
disk_rgb = [(0.2, 0.01, 0.06), (0.75, 0.16, 0.05), (1, 0.55, 0.18), (1, 0.86, 0.62)]
disk_cmap = LinearSegmentedColormap.from_list("disk", [*disk_rgb, (0.85, 0.92, 1.0)])
# photon angular momentum about the disk axis (physical photon runs opposite to the ray)
lz = -R_CAM * np.sin(INCL) * X / np.sqrt((1 + rho**2) * (1 - 2 / R_CAM))

rgb = np.zeros((*X.shape, 3))
trans = np.ones(X.shape)  # transmittance; the disk thins out at its outer edge
for phi in phi_c + np.arange(3)[:, None, None] * np.pi:  # disk crossings, front to back
    u_k = map_coordinates(table, [phi / dphi, rho / rho_grid[1]], order=1)
    on = (u_k > 1 / R_OUT) & (u_k < 1 / R_IN)
    r, ph = 1 / u_k[on], phi[on]
    az = np.arctan2(np.sin(ph) * e2[on, 1], np.cos(ph) * e1[0] + np.sin(ph) * e2[on, 0])
    # Novikov-Thorne (Page-Thorne) flux normalised to peak 1 at r = 9.55
    s, s3, s6 = np.sqrt(r), np.sqrt(3), np.sqrt(6)
    log = np.log((s + s3) * (s6 - s3) / ((s - s3) * (s6 + s3)))
    flux = 8727 * (s - s6 + s3 / 2 * log) / ((r - 3) * r**2.5)
    # texture coordinates: log r, azimuth wound up by differential rotation
    uv = [114 * np.log(r / R_IN), (az + 2.5 * np.log(r)) * 1023 / (2 * np.pi)]
    flux *= map_coordinates(tex, uv, order=1, mode="wrap")
    g = np.sqrt(1 - 3 / r) / (1 - r**-1.5 * lz[on])  # nu_obs / nu_emit, Keplerian orbit
    col = disk_cmap((g * flux**0.25 - 0.2) / 1.15)[:, :3]  # hue ~ observed temperature
    opacity = np.clip((R_OUT - r) / 12, 0, 1)
    rgb[on] += (trans[on] * opacity * 1.4 * g**4 * flux)[:, None] * col
    trans[on] *= 1 - opacity

# lensed star field (stars ~1 output px wide) and a faint noisy galactic band
pix_esc = np.interp(rho, rho_grid, phi_esc)
esc = np.isfinite(pix_esc)
sky = np.cos(pix_esc[esc, None]) * e1 + np.sin(pix_esc[esc, None]) * e2[esc]
stars = rng.normal(size=(60000, 3))
dist, i = cKDTree(stars / np.linalg.norm(stars, axis=1, keepdims=True)).query(sky)
mag = np.minimum(rng.pareto(1.6, 60000) + 1, 40)[i]
tint = colormaps["twilight_shifted"](rng.uniform(0.15, 0.85, 60000))[i, :3] / 2 + 0.5
bg = (0.12 * mag * np.exp(-((dist * 1300 / 0.7) ** 2) / 2))[:, None] * tint
noise = blur(rng.normal(size=(64, 64, 64)), 3, mode="wrap")
band = map_coordinates(noise / noise.std(), (sky.T + 1) * 31.5, order=1, mode="wrap")
band = np.exp(-((sky @ [0.3, -0.5, 0.81]) ** 2) / 0.08) * (1 + 0.6 * band)
bg += np.clip(band, 0, None)[:, None] * [0.025, 0.018, 0.05]
rgb[esc] += trans[esc, None] * bg

# downsample, add deep-space tint, bloom, tone map
img = rgb.reshape(H, SS, W, SS, 3).mean(axis=(1, 3)) + [0.012, 0.008, 0.02]
bloom = sum(blur(img, (s, s, 0)) * w for s, w in [(4, 0.25), (16, 0.2), (48, 0.15)])
img = (1 - np.exp(-1.6 * (img + 0.6 * bloom))) ** (1 / 1.1)
Image.fromarray((img * 255 + 0.5).astype(np.uint8)).save(OUT, quality=85, method=6)
