"""Message passing on a Bi2Zr2O7 pyrochlore crystal graph, as in an ML interatomic potential (needs pymatgen)."""

from pathlib import Path

import numpy as np
from matplotlib import colormaps
from PIL import Image
from pymatgen.core import Structure
from scipy.ndimage import gaussian_filter
from scipy.signal import oaconvolve
from scipy.sparse import coo_array
from scipy.sparse.csgraph import shortest_path
from scipy.spatial import cKDTree
from scipy.spatial.transform import Rotation

W, H, f_px, z_focus, max_hop = 2400, 720, 1714.0, 40.0, 5  # f_px: ~70 deg FOV
rng = np.random.default_rng(7)
radii = {"Bi": 0.62, "Zr": 0.5, "O": 0.3}  # sphere radii in A


def hop_colour(h):  # white centre, first hops warm, blue outside the receptive field
    rgb = colormaps["plasma"](0.97 - 0.8 * np.clip(h / max_hop, 0, 1) ** 1.5)[..., :3]
    rgb = np.where(h[..., None] > max_hop, [0.25, 0.36, 0.75], rgb)
    return np.where(h[..., None] == 0, [1.0, 0.97, 0.9], rgb)


def splat(p, rgb, gain, radius, power=2):  # energy ~ core^2 for discs, ^1 for tubes
    z = p[:, 2]
    x, y = W / 2 + f_px * p[:, 0] / z, H / 2 - f_px * p[:, 1] / z
    core = radius * f_px / z
    fog = np.exp(-np.maximum(z - z_focus, 0) / 18) * np.clip((z - 16) / 14, 0, 1)
    total = np.hypot(core, 45 * (z_focus / z - 1)) + 0.35  # + thin-lens blur circle
    keep = (np.abs(x - W / 2) < W / 2 + total) & (np.abs(y - H / 2) < H / 2 + total)
    return x, y, rgb * (gain * fog * keep * core**power)[:, None], total, core / total


# pyrochlore A2B2O7 (Fd-3m, origin choice 1): Bi on the 8-fold A site, Zr in ZrO6
# octahedra, O 48f + O' 8a. Bond lengths come out Zr-O 2.04 A, Bi-O 2.29/2.64 A.
coords = [[1 / 8] * 3, [5 / 8] * 3, [0.3, 0, 0], [0] * 3]
cell = Structure.from_spacegroup(227, 10.6 * np.eye(3), ["Bi", "Zr", "O", "O"], coords)
# camera looks down +z at a channel-revealing view, Zr at (5/8, 7/8, 7/8) in focus on axis
shifts = 10.6 * (np.mgrid[-7:8, -7:8, -7:8].reshape(3, -1).T - [5 / 8, 7 / 8, 7 / 8])
pos = (shifts[:, None] + cell.cart_coords).reshape(-1, 3)
pos = Rotation.from_euler("YX", [38, -24], degrees=True).apply(pos) + [0, 0, z_focus]
radius = np.tile([radii[el.symbol] for el in cell.species], len(shifts))
uv = f_px * pos[:, :2] / pos[:, 2:]  # screen coords relative to the centre
in_view = (pos[:, 2] > 2) & (pos[:, 2] < 80) & (np.abs(uv) < [1290, 450]).all(1)
pos, radius, uv = pos[in_view], radius[in_view], uv[in_view]

# crystal graph of cation-oxygen bonds; hops from the central atom = message-passing steps
pairs = cKDTree(pos).query_pairs(2.75, output_type="ndarray")
pairs = pairs[np.diff(radius[pairs] == radii["O"])[:, 0]]  # exactly one end is O
graph = coo_array((np.ones(len(pairs)), pairs.T), shape=(len(pos),) * 2)
centre = np.linalg.norm(pos - [0, 0, z_focus], axis=1).argmin()
hops = shortest_path(graph, directed=False, unweighted=True, indices=centre)
a, b = np.take_along_axis(pairs, hops[pairs].argsort(1), 1).T  # a: end nearer centre
gain = np.pi * np.where(hops <= max_hop, 0.8, 0.07) * np.where(hops == 0, 3, 1)
atoms = splat(pos, hop_colour(hops), gain, radius)
# bonds sampled every <= 0.7 px; a bond carries a message if it links consecutive hops
seg = np.linalg.norm(uv[b] - uv[a], axis=1)  # on-screen bond length
n = np.ceil(seg / 0.7).astype(int) + 1
edge = np.repeat(np.arange(len(a)), n)
t = (np.arange(n.sum()) - np.repeat(np.cumsum(n) - n, n) + 0.5) / n[edge]
live = (hops[a] + 1 == hops[b]) & (hops[b] <= max_hop)
rgb = hop_colour(np.where(live[edge], hops[a][edge] + t, np.inf))
gain = (np.where(live, 1.4, 0.06) * seg / n)[edge]  # 2 * step * (0.7 or 0.03)
bonds = splat(pos[a][edge] + t[:, None] * (pos[b] - pos[a])[edge], rgb, gain, 0.07, 1)
tm = rng.uniform(0.25, 0.75, live.sum())  # messages in flight: pulses on live bonds
pm = pos[a[live]] + tm[:, None] * (pos[b[live]] - pos[a[live]])
msgs = splat(pm, hop_colour(hops[a[live]] + tm), 2.2 * np.pi, 0.13)
# bin splats by disc radius and convolve each bin with a disc whose profile (1 - rho^2)^p
# goes from a lit sphere (p = 0.5, in focus) to flat bokeh (p ~ 0, defocused)
x, y, energy, total, focus = map(np.concatenate, zip(atoms, bonds, msgs))
which = np.round(6 * np.log(total))
ix, iy = x.round().clip(0, W - 1).astype(int), y.round().clip(0, H - 1).astype(int)
img = np.zeros((H, W, 3))
for k in np.unique(which):
    sel = which == k
    layer = np.zeros((H, W, 3))
    np.add.at(layer, (iy[sel], ix[sel]), energy[sel])
    r, half = np.exp(k / 6), int(np.exp(k / 6)) + 2
    s = (np.arange(-4 * half, 4 * half) + 0.5) / 4 / r  # 4x supersampled
    p_exp = 0.05 + 0.45 * np.median(focus[sel]) ** 2
    kern = (1 - s**2 - s[:, None] ** 2).clip(0) ** p_exp
    kern = kern.reshape(2 * half, 4, 2 * half, 4).sum((1, 3))
    img += oaconvolve(layer, kern[..., None] / kern.sum(), mode="same", axes=(0, 1))
# bloom, background, tone mapping and dither against banding in the dark gradient
img += 0.25 * gaussian_filter(img, (8, 8, 0)) + 0.18 * gaussian_filter(img, (40, 40, 0))
yy, xx = np.linspace(0, 1, H)[:, None, None], np.linspace(-1, 1, W)[:, None]
bg = (0.012 + 0.018 * (1 - yy)) * np.array([0.55, 0.45, 1.0]) * (1 - 0.3 * xx**2)
img = (1 - np.exp(-img) + bg) ** (1 / 1.15) + rng.normal(0, 0.004, img.shape)
img = Image.fromarray((img.clip(0, 1) * 255).astype(np.uint8))
img.save(Path(__file__).with_name("banner.webp"), quality=85, method=6)
