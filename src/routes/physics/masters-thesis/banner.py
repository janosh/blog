"""Phase portrait of the Bose-Einstein distribution n_B(z) = 1/(e^(z/T) - 1) continued into the complex frequency plane, with poles at the bosonic Matsubara frequencies z = 2 pi i n T."""

from pathlib import Path

import numpy as np
from matplotlib.colors import LinearSegmentedColormap
from PIL import Image

W, H, SS = 2400, 720, 2  # output size and supersampling factor
# z in units of T: Im(z) runs horizontally across 7.2 Matsubara spacings 2 pi, Re(z)
# vertically with the Boltzmann tail Re(z) > 0 on top, z = 0 at center
hw, hh = 7.2 * np.pi, 7.2 * np.pi * H / W
re_z, im_z = np.mgrid[hh : -hh : H * SS * 1j, -hw : hw : W * SS * 1j]
n_b = 1 / np.expm1(re_z + 1j * im_z)
# n_B on the Boltzmann side, 1 + n_B = -n_B(-z) below, cross-faded. Both ~1/z at poles
f = np.stack([n_b, 1 + n_b])
w = 1 / (1 + np.exp(-np.stack([re_z, -re_z]) / 1.1))
anchors = "#1b0c41 #4a0c6b #a52c60 #ed6925 #fbb61a #f6e3a1 #7fd3c8 #2a7fa8 #1e3a7a"
cmap = LinearSegmentedColormap.from_list("phase", [*anchors.split(), "#1b0c41"], 1024)
rgb = (w[..., None] * cmap(np.angle(f) / (2 * np.pi) % 1)[..., :3]).sum(0)
# glow: |n_B (1 + n_B)| = |dn_B/dz| T is large near poles, decays on both sides
glow = 1 / (1 + np.exp(-(np.log(np.abs(f.prod(0))) + 2.2) / 1.1))[..., None]
# conformal grid, 8 iso-modulus + iso-phase lines per turn, 1.5 px wide. Cauchy-Riemann:
# |grad log|f|| = |grad arg f| = |f'/f| = |f[::-1]| since n_B' = -n_B (1 + n_B)
d = np.abs((np.stack([np.log(np.abs(f)), np.angle(f)]) * 4 / np.pi + 0.5) % 1 - 0.5)
lines = (w * np.clip(1 - d * np.pi * W / (6 * hw * np.abs(f[::-1])), 0, 1)).max((0, 1))
lines = 0.4 * lines[..., None] * np.exp(-((re_z[..., None] / (0.55 * hh)) ** 2))
img = rgb * (0.1 + 0.95 * glow) + lines * (0.25 + 0.75 * rgb)
img = 1 - (1 - img) * (1 - 0.35 * np.clip(glow / 0.4 - 1.5, 0, 1) * (0.6 + 0.4 * rgb))
img *= 0.5 + 0.5 * np.exp(-((im_z[..., None] / (0.6 * hw)) ** 2))  # focus on z = 0
img = np.clip(img.reshape(H, SS, W, SS, 3).mean((1, 3)), 0, 1) ** 1.15
img = Image.fromarray((img * 255).astype(np.uint8))
img.save(Path(__file__).with_name("banner.webp"), quality=85, method=6)
