"""Lattice-Boltzmann (D2Q9) flow past a cylinder at Re = 220, rendering the Karman vortex street's vorticity and tracer streaklines (needs numba)."""

from pathlib import Path

import numba as nb
import numpy as np
from matplotlib.colors import LinearSegmentedColormap
from PIL import Image
from scipy.ndimage import gaussian_filter, zoom

NX, NY, S, DT = 1200, 360, 2, 2  # lattice size, pixels per cell, tracer time step
U_IN, D, C = 0.08, 44, 300 + 179.5j  # inflow speed, cylinder diameter and centre
OMEGA = 1 / (3 * U_IN * D / 220 + 0.5)  # BGK relaxation rate for Re = 220
E = np.array([0, 1, 1j, 1 + 1j, 1 - 1j, -1 + 1j, -1 - 1j, -1j, -1])  # E[-i] = -E[i]
W9 = 4 / 9 / 4 ** (abs(E.real) + abs(E.imag))  # weights 4/9, 1/9, 1/36
R = abs(np.arange(NX) + 1j * np.arange(NY)[:, None] - C)  # distance from cylinder axis


@nb.njit
def feq(rho, u, i):  # equilibrium population i at density rho and complex velocity u
    cu = 3 * (E[i].conjugate() * u).real
    return W9[i] * rho * (1 + cu + cu * cu / 2 - 1.5 * (u * u.conjugate()).real)


@nb.njit(parallel=True, fastmath=True)
def step(f, g, u, z):
    """LBM step f -> g (pull-streaming + BGK, velocity into u), then RK2-advect tracers z."""
    for y in nb.prange(NY):
        for x in range(1, NX):  # column x = 0 stays at the inflow equilibrium
            if R[y, x] < D / 2:
                continue
            fi = np.empty(9)
            for i in range(9):  # zero-gradient outflow, half-way bounce-back
                xs, ys = min(x - int(E[i].real), NX - 1), (y - int(E[i].imag)) % NY
                fi[i] = f[y, x, -i] if R[ys, xs] < D / 2 else f[ys, xs, i]
            rho = fi.sum()
            u[y, x] = (fi * E).sum() / rho
            for i in range(9):
                g[y, x, i] = fi[i] + OMEGA * (feq(rho, u[y, x], i) - fi[i])
    for k in nb.prange(len(z)):
        v = 0j
        for h in (0.0, DT / 2):  # bilinear velocity at z, then at the midpoint
            px, py = min((z[k] + h * v).real, NX - 1.001), (z[k] + h * v).imag % NY
            ix, iy, fx, fy = int(px), int(py), px % 1, py % 1
            lo = (1 - fx) * u[iy, ix] + fx * u[iy, ix + 1]
            hi = (1 - fx) * u[iy + 1 - NY, ix] + fx * u[iy + 1 - NY, ix + 1]  # periodic
            v = (1 - fy) * lo + fy * hi
        z[k] += DT * v


# uniform inflow, tilted by 4e-4 rad to break the up-down symmetry and trigger shedding
f = np.tile(feq(1.0, U_IN + 3e-5j, np.arange(9)), (NY, NX, 1))
g, u = f.copy(), np.zeros_like(R, complex)
# streakline tracers released just outside the cylinder (side +-1) and from a rake (0)
theta = np.linspace(0, 2 * np.pi, 72, endpoint=False)
src = np.r_[C + (D + 3) / 2 * np.exp(1j * theta), 1 + 1j * np.r_[4.5:NY:10]]
side = np.tile(np.r_[np.where(theta < np.pi, 1, -1), [0] * 36], 7500)
z = np.tile(src, 7500)  # one release from every source per tracer step
for n in range(-5500, 7500):  # DT = 2 LBM steps per tracer step
    step(f, g, u, z[:0])
    step(g, f, u, z[: src.size * max(n + 1, 0)])

vort = gaussian_filter(np.gradient(u.imag, axis=1) - np.gradient(u.real, axis=0), 0.7)
vort = np.tanh(1.5 * vort / np.percentile(abs(vort[R > D]), 99.5))
stops = [0, 0.2, 0.4, 0.5, 0.6, 0.8, 1]
colors = ["#8af4ff", "#1e88d0", "#14215a", "#05040c", "#4a0f3a", "#e0484f", "#ffd08a"]
cmap = LinearSegmentedColormap.from_list("vort", list(zip(stops, colors)))
# luminous streaklines: splat tracers, one cylinder half cool, the other warm, rake grey
bounds = [(-0.5, NY - 0.5), (-0.5, NX - 0.5), (-1.5, 1.5)]
dens = np.histogramdd((z.imag % NY, z.real, side), (NY * S, NX * S, 3), bounds)[0]
glow = 1 - np.exp(-gaussian_filter(dens, (1.3, 1.3, 0)) / [4.5, 9, 4.5])
img = 0.6 * cmap((zoom(vort, S, order=3) + 1) / 2)[..., :3]
img += 0.8 * glow @ [[0.55, 0.9, 1], [0.5, 0.5, 0.6], [1, 0.72, 0.42]]
r = zoom(R, S, order=1)[..., None]
img *= np.clip(r - D / 2 + 0.5, 0, 1)  # dark cylinder disk, then a soft rim light
img = np.uint8(255 * np.clip(img + 0.35 * np.exp(-(((r - D / 2) / 0.8) ** 2)), 0, 1))
Image.fromarray(img).save(Path(__file__).with_name("banner.webp"), quality=85, method=6)
