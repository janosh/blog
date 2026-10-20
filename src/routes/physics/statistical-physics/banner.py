"""Time-of-flight momentum distributions of a trapped Bose gas cooled through T_c: thermal cloud plus Thomas-Fermi condensate."""

from pathlib import Path

import numpy as np
from matplotlib import colormaps
from PIL import Image
from scipy.ndimage import gaussian_filter, map_coordinates

W, H = 2400, 720


def sample(field, depth):  # bilinear lookup of a floor field where the rays reach depth
    wy, wx = np.broadcast_arrays(depth - 24 + 14, u * depth + 46)  # from grid corner
    return map_coordinates(field, [wy / 0.04, wx / 0.04], order=1, mode="nearest")


# momentum distributions (N = 1, p in sqrt(m k_B T_c)) at t = T/T_c falling left to right:
# thermal cloud plus, below T_c, a Thomas-Fermi condensate (radius ~ N0^(1/5), aspect 1.6)
GY, GX = np.mgrid[-14:60:0.04, -46:46:0.04]  # floor grid in world units
k, xs = np.arange(1, 301)[:, None], np.linspace(0, 1, 4001)
g2, g3 = (xs**k / k**2).sum(0), (xs**k / k**3).sum(0)  # Bose functions g_s(z)
dens = np.zeros_like(GX)
for t, x0 in zip([1.5, 1.02, 0.85, 0.65, 0.35], range(-14, 15, 7)):
    z = np.interp(g3[-1] / t**3, g3, xs)  # fugacity from N ~ T^3 g_3(z), 1 below T_c
    n_th = np.interp(z * np.exp(-((GX - x0) ** 2 + GY**2) / (2 * t)), xs, g2)
    dens += t**2 * n_th / (2 * np.pi * g3[-1])
    if t < 1:  # condensate fraction 1 - t^3
        r0 = 0.85 * (1 - t**3) ** 0.2
        q = np.clip(1 - ((GX - x0) / r0 / 1.26) ** 2 - (GY * 1.26 / r0) ** 2, 0, None)
        dens += (1 - t**3) * q**1.5 / (2 * np.pi / 5 * r0**2)
# imaging blur smooths the TF edge kink; power 0.6 keeps thermal clouds visible
height = gaussian_filter(dens, 3) ** 0.6
height *= 4.8 / height.max()  # world units

hy, hx = np.gradient(height, 0.04)
normal = np.stack([-hx, -hy, np.ones_like(hx)]) / np.sqrt(1 + hx**2 + hy**2)
light_and_half = [[-0.55, -0.45, 0.7], [-0.29, -0.55, 0.78]]  # Blinn-Phong unit vectors
diffuse, spec = np.einsum("ijk,li->ljk", normal, light_and_half).clip(0, 1)
val = (height / 4.8) ** 0.75
shade = (0.55 + 0.45 * val) * (0.45 + 0.75 * diffuse)  # glowing: brighter where denser
albedo = colormaps["magma"](0.08 + 0.9 * val)[..., :3] * shade[..., None]
albedo += (0.35 * spec**40 * val)[..., None]
floor_grid = np.exp(-((np.mod([GX + 3.5, GY], 1.75) - 0.875) ** 2) / 0.0012).max(0)
albedo += (0.05 * floor_grid * (1 - val) ** 4)[..., None] * [0.55, 0.35, 0.95]

# voxel-space renderer at 2x supersampling: camera at x=0, y=-24, height 5.6, pitched down
focal = W / np.tan(np.radians(38))
u = (np.arange(2 * W) - W + 0.5) / focal  # ray slope per screen column
d = np.geomspace(3, 90, 3000)[:, None]  # distance along y from the camera
# screen row of the terrain top after occlusion by nearer terrain
v_min = np.minimum.accumulate(0.32 * H + (5.6 - sample(height, d)) * focal / d)
rows = np.arange(2 * H) + 0.5
# hit depth per pixel: v_min is non-increasing in depth, so interpolate its inverse
d_hit = np.stack([np.interp(rows, vc[::-1], d[::-1, 0]) for vc in v_min.T], 1)
color = np.stack([sample(a, d_hit) for a in albedo.transpose(2, 0, 1)], -1)
bg = np.array([0.045, 0.02, 0.075])
fog = np.exp(-(((d_hit - 12) / 45).clip(0) ** 1.6))[..., None]
sky = bg * (0.55 + 0.3 * rows / H)[:, None, None]  # dark violet gradient
img = np.where(rows[:, None, None] < v_min[-1, :, None], sky, bg + (color - bg) * fog)

img = img.reshape(H, 2, W, 2, 3).mean((1, 3))
lum = img.max(2, keepdims=True)  # soft bloom around the bright condensate peaks
glow = 1.2 * gaussian_filter(img * (lum - 0.3).clip(0), (14, 14, 0))
img += glow + gaussian_filter(img * (lum - 0.2).clip(0), (60, 60, 0))
img = Image.fromarray((img.clip(0, 1) * 255).astype(np.uint8))
img.save(Path(__file__).with_name("banner.webp"), quality=85, method=6)
