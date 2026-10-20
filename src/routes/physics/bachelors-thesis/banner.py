"""Ray-marched graphene sheet 3.33 Å above a lattice-mismatched hBN layer (C-C 1.42 Å, B-N 1.446 Å)."""

from pathlib import Path

import numpy as np
from PIL import Image

W, H, SS = 2400, 720, 2  # output size, supersampling factor per axis
R_ATOM, R_BOND, D_LAYER, PI3 = 0.3, 0.085, 3.33, np.pi / 3
CAM, PITCH, FOV = np.c_[[0.0, 0.0, 2.6]], np.radians(9), np.tan(np.radians(44))
# warm key light (upper left, slightly behind), cool fill from the right above the camera
KEY, FILL = np.array([[-0.6, 0.45, 0.66], [0.55, -0.35, 0.76]])[..., None]
KEY_RGB, FILL_RGB = np.array([[1.25, 0.97, 0.75], [0.2, 0.27, 0.45]])[..., None]
# material colors (columns): C atom, C-C bond, B, N, B-N bond (hBN dimmer)
PAL = np.array([[88, 55, 75, 16, 30], [90, 58, 51, 52, 27], [97, 68, 19, 75, 34]]) / 100


def honeycomb(p, a):
    """SDF of a honeycomb layer of bond length a, is-atom flag and sublattice index."""
    cell = np.c_[[3 * a, np.sqrt(3) * a]]  # two hexagon centers per cell: pick nearest
    r1, r2 = np.mod(p[:2] + cell / 2, cell) - cell / 2, np.mod(p[:2], cell) - cell / 2
    r = np.where((r1**2).sum(0) < (r2**2).sum(0), r1, r2)
    rho, th = np.hypot(*r), np.arctan2(r[1], r[0])
    # flat-top hexagon: atoms at angles k pi/3, bond normals at pi/6 + k pi/3
    psi = np.mod(th + PI3 / 2, PI3) - PI3 / 2
    atom = np.sqrt(rho**2 + a**2 - 2 * a * rho * np.cos(psi) + p[2] ** 2) - R_ATOM
    bond = np.hypot(0.866 * a - rho * np.cos(np.abs(psi) - PI3 / 2), p[2]) - R_BOND
    return np.minimum(atom, bond), atom < bond, np.round(th / PI3).astype(int) % 2


def scene(p):
    """SDF and material index into PAL."""
    g, g_atom, _ = honeycomb(p, 1.42)
    h, h_atom, boron = honeycomb(p + np.c_[[0.91, -0.37, D_LAYER]], 1.446)  # moiré
    mat = np.where(g <= h, 1 - g_atom, np.where(h_atom, 2 + boron, 4))
    return np.minimum(g, h), mat


v, u = np.mgrid[H / W : -H / W : H * SS * 1j, -1 : 1 : W * SS * 1j] * FOV
d = np.stack([u, np.cos(PITCH) + v * np.sin(PITCH), v * np.cos(PITCH) - np.sin(PITCH)])
d = d.reshape(3, -1) / np.linalg.norm(d, axis=0).ravel()
# sky/fog color by ray elevation: deep blue fading to purple and a hot horizon glow
elev = np.abs(np.clip(d[2], -1, 0.2))
col = np.c_[[0.012, 0.012, 0.035]] + np.c_[[0.048, 0.018, 0.095]] * np.exp(-elev / 0.25)
col += np.c_[[0.43, 0.19, 0.18]] * np.exp(-elev / 0.035)
# sphere-trace from the top of the graphene until hit or past the hBN
t = (CAM[2] - R_ATOM - 0.02) / np.maximum(-d[2], 1e-9)
hit, idx = np.zeros(t.size, bool), np.flatnonzero(t < 220)
for _ in range(220):
    dist = scene(CAM + d[:, idx] * t[idx])[0]
    eps = np.maximum(2e-3, t[idx] * FOV / (W * SS) * 0.8)
    t[idx] += np.where(dist < eps, 0, np.maximum(dist, eps / 2))
    hit[idx] = dist < eps
    idx = idx[~hit[idx] & (t[idx] < 220)]
hit = np.flatnonzero(hit)
p, view = CAM + d[:, hit] * t[hit], -d[:, hit]
mat = scene(p)[1]
nrm = np.stack([scene(p + e)[0] - scene(p - e)[0] for e in 1e-3 * np.eye(3)[..., None]])
nrm /= np.linalg.norm(nrm, axis=0)
ao = 1 / 32 + sum(scene(p + 0.12 * k * nrm)[0] / (0.12 * k * 2**k) for k in range(1, 6))
ao = np.clip(ao, 0, 1) ** 1.2
sh, ts = 1.0, np.full(hit.size, 0.03)  # soft shadow toward key light
for _ in range(40):
    dist = scene(p + nrm * 0.004 + KEY * ts)[0]
    sh = np.minimum(sh, 10 * dist / ts)
    ts += np.clip(dist, 0.02, 0.4)
sh = np.clip(sh, 0, 1) ** 2 * (3 - 2 * np.clip(sh, 0, 1))
rim = np.c_[[0.3, 0.14, 0.15]] * (1 - np.clip((nrm * view).sum(0), 0, 1)) ** 3
lit = (PAL[:, mat] * np.where(mat < 2, 0.06, 0.35) + rim) * ao
for light, rgb, power in ((KEY, KEY_RGB * sh, 30), (FILL, FILL_RGB, 50)):
    half = (light + view) / np.linalg.norm(light + view, axis=0)
    spec = np.clip((nrm * half).sum(0), 0, 1) ** power
    lit += rgb * (PAL[:, mat] * np.clip((nrm * light).sum(0), 0, 1) + spec)
fog = (1 - np.exp(-np.maximum(t[hit] - 4, 0) / 45)) ** 1.3
col[:, hit] = lit * (0.35 + 0.65 * ao) * (1 - fog) + col[:, hit] * fog
img = col.reshape(3, H, SS, W, SS).mean((2, 4)).transpose(1, 2, 0)
y, x = np.ogrid[-1 : 1 : H * 1j, -1 : 1 : W * 1j]
img = 1 - np.exp(-1.6 * img * (1 - 0.175 * x**2 - 0.105 * y**2)[..., None])
img = Image.fromarray(np.uint8(255 * img ** (1 / 1.15) + 0.5))
img.save(Path(__file__).with_name("banner.webp"), quality=85, method=6)
