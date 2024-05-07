"""This script grid-searches OMP_NUM_THREADS, NCORE and number of MPI processes for
minimal VASP runtime on a simple Si2 relaxation.

It writes the results to CSV and copies
markdown table to clipboard. Requires Python 3.10. To keep a log, invoke with

python vasp-perf-grid-search.py 2>&1 | tee Si-relax.log

To install OpenMPI's mpiexec on macOS, use Homebrew:
brew install open-mpi
"""

import os
import warnings
from itertools import product
from time import perf_counter, sleep

import pandas as pd
from pandas.io.clipboard import clipboard_set
from pymatgen.core import Structure

from atomate2.vasp.jobs.core import RelaxMaker
from atomate2.vasp.powerups import update_user_incar_settings
from jobflow import run_locally

warnings.filterwarnings("ignore")  # hide pymatgen warnings clogging up the logs

VASP_BIN = "/Users/janosh/dev/vasp/compiled/vasp_std_6.3.0_m1"
results: list[tuple[int, int, int, float]] = []

# construct an FCC silicon structure
si_structure = Structure(
    lattice=[[0, 2.73, 2.73], [2.73, 0, 2.73], [2.73, 2.73, 0]],
    species=["Si", "Si"],
    coords=[[0, 0, 0], [0.25, 0.25, 0.25]],
)

# grid-search OMP_NUM_THREADS, NCORE and number of MPI processes
try:
    prod = list(product([1, 2, 4, 8], [1, 2], [2, 4]))
    for idx, (n_proc, n_threads, n_core) in enumerate(prod, start=1):
        os.environ["OMP_NUM_THREADS"] = str(n_threads)

        print(f"Run {idx} / {len(prod)}")

        # make a relax job to optimize the structure
        relax_job = RelaxMaker(
            run_vasp_kwargs={"vasp_cmd": f"mpiexec -np {n_proc} {VASP_BIN}"},
        ).make(si_structure)

        relax_job = update_user_incar_settings(relax_job, {"NCORE": n_core})

        start = perf_counter()
        # run the job
        run_locally(relax_job, create_folders=True, ensure_success=True)

        elapsed = perf_counter() - start
        print(
            f"run with {n_proc=}, {n_threads=}, {n_core=} took {elapsed:.1f} sec",
        )
        results += [(n_proc, n_threads, n_core, elapsed)]

        print("Waiting 10 secs to cooldown...\n\n", flush=True)
        sleep(10)  # so every run is a bit more like the first


except KeyboardInterrupt:  # exit gracefully on ctrl+c and write partial results
    print("Job was interrupted")


df_perf = pd.DataFrame(results, columns=["n_proc", "n_threads", "n_core", "elapsed"])
df_perf.round(2).to_csv("vasp-perf-results.csv")
clipboard_set(df_perf.to_markdown())
