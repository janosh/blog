# %%
from glob import glob

import pymatgen.transformations.advanced_transformations as pat
from pymatgen.core import Structure

for cif in glob("*.cif"):
    struct = Structure.from_file(cif).add_oxidation_state_by_guess()
    # remove partial occupancies, matterviz does not support them (yet)
    ordered = pat.OrderDisorderedStructureTransformation().apply_transformation(struct)
    ordered.to(cif.replace(".cif", ".json"))
