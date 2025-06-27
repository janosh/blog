---
title: Compile VASP on M1 Mac
date: 2022-03-28
cover:
  img: compiling-vasp-m1-mac.svg
tags:
  - Guide
  - Fortran
  - DFT
  - Materials Science
---

> This post started out [as a gist](https://gist.github.com/janosh/a484f3842b600b60cd575440e99455c0). There's some Q&A there that may be useful.

**Written by Alex Ganose [@utf](https://github.com/utf) and Janosh Riebesell [@janosh](https://github.com/janosh). Last updated on 2024-03-30.**

Follow these steps to compile VASP on an M1 Mac:

1. Install Xcode command line tools:

   ```sh
   xcode-select --install
   ```

2. Install dependencies using Homebrew:

   ```sh
   brew install gcc openmpi scalapack fftw qd openblas
   ```

   Optionally, add `hdf5` for [HDF5 support in VASP][vasp-hdf5].

3. Compile VASP:

   These instructions are for VASP 6.4.1 but should work with minor adjustments for other versions.

   ```sh
   cd /path/to/vasp-6.x.y
   cp arch/makefile.include.gnu_omp makefile.include
   ```

   Edit `makefile.include` in the VASP `src` directory:

   - Add to `CPP_OPTIONS`:

     ```make
     -D_OPENMP \
     -Dqd_emulate
     ```

   - Change all instances of `gcc` to `gcc-13` and `g++` to `g++-13`

   - Add after `LLIBS = -lstdc++` to emulate quad precision:

     ```make
     QD ?= /opt/homebrew/
     LLIBS += -L$(QD)/lib -lqdmod -lqd
     INCS += -I$(QD)/include/qd
     ```

   - Set `SCALAPACK_ROOT ?= /opt/homebrew`

   - Set `OPENBLAS_ROOT ?= /opt/homebrew/Cellar/openblas/0.3.20` (Double check this is the path on your system)

   - Set `FFTW_ROOT ?= /opt/homebrew`

   - (optional but [recommended by VASP][vasp-hdf5]) For HDF5 support, add

     ```make
     CPP_OPTIONS+= -DVASP_HDF5
     HDF5_ROOT  ?= /opt/homebrew/
     LLIBS      += -L$(HDF5_ROOT)/lib -lhdf5_fortran
     INCS       += -I$(HDF5_ROOT)/include
     ```

   - Append `getshmem.o` to `OBJECTS_LIB` in `makefile.include` ([VASP wiki](https://www.vasp.at/wiki/index.php/Shared_memory))

     ```diff
     - OBJECTS_LIB = linpack_double.o
     + OBJECTS_LIB = linpack_double.o getshmem.o
     ```

   - In `src/parser/makefile`, change (as noted by [@zhuligs](https://gist.github.com/janosh/a484f3842b600b60cd575440e99455c0?permalink_comment_id=4323518#gistcomment-4323518)):

     ```diff
     - ar vq libparser.a $(CPPOBJ_PARS) $(COBJ_PARS) locproj.tab.h
     + ar vq libparser.a $(CPPOBJ_PARS) $(COBJ_PARS)
     ```

     Do not replace the tab at the beginning of the line with spaces!

   - In `src/lib/getshmem.c`, add the line `#define SHM_NORESERVE 0` ([VASP forum](https://www.vasp.at/forum/viewtopic.php?t=15106)):

     ```c
     /*output: shmem id
     */
     #define SHM_NORESERVE 0 // this line was added

     void getshmem_C(size_t _size, int *_id)
     ```

   - In `makefile.include`, update the parser section ([VASP forum](https://www.vasp.at/forum/viewtopic.php?f=2&t=17477)):

     ```diff
     # For the parser library
     CXX_PARS = g++-13
     - LLIBS = -lstdc++
     + LIBS += parser
     + LLIBS = -Lparser -lparser -lstdc++
     QD ?= /opt/homebrew
     LLIBS += -L$(QD)/lib -lqdmod -lqd
     INCS += -I$(QD)/include/qd
     ```

4. Finally, run:

   ```sh
   make all
   ```

   If a previous compilation failed, remember to run `make veryclean` to start from a clean slate. Fixes `gfortran` errors like

   > Fatal Error: `string.mod` not found

If successful, the VASP binaries will be in `src/bin`. Test with `make test`.

## Last Tested on 2024-03-30

Confirmed working with VASP 6.4.1 on M1 Pro with Sonoma 14.2.1 and `gcc@13.2.0`.

## Resulting `makefile.include` with all modifications

See [`makefile.include`](https://gist.github.com/janosh/a484f3842b600b60cd575440e99455c0#file-makefile-include).

## Benchmarking

Initial performance testing suggests optimal parameters for the M1 Pro chip with 8 performance, 2 efficiency cores and 16" MBP cooling are

```sh
export OMP_NUM_THREADS=1 # important
mpiexec -np 8 vasp_std
NCORE = 4 # in INCAR
```

|    | n_proc | n_threads | n_core | elapsed (sec) |
| -: | -----: | --------: | -----: | ------------: |
|  0 |      1 |         1 |      2 |          93.3 |
|  1 |      1 |         1 |      4 |          92.8 |
|  2 |      1 |         2 |      2 |          82.8 |
|  3 |      1 |         2 |      4 |          82.7 |
|  4 |      2 |         1 |      2 |          42.8 |
|  5 |      2 |         1 |      4 |          42.9 |
|  6 |      2 |         2 |      2 |          52.9 |
|  7 |      2 |         2 |      4 |          52.7 |
|  8 |      4 |         1 |      2 |          32.9 |
|  9 |      4 |         1 |      4 |          32.9 |
| 10 |      4 |         2 |      2 |          52.9 |
| 11 |      4 |         2 |      4 |          53.0 |
| 12 |      8 |         1 |      2 |          32.8 |
| 13 |      8 |         1 |      4 |          22.8 |
| 14 |      8 |         2 |      2 |          62.8 |
| 15 |      8 |         2 |      4 |          62.9 |

Brings wall time for this Si2 relaxation down to 23 sec.

```py
from time import perf_counter

from atomate2.vasp.jobs.core import RelaxMaker
from atomate2.vasp.powerups import update_user_incar_settings
from jobflow import run_locally
from pymatgen.core import Structure


start = perf_counter()

# FCC silicon structure
si_structure = Structure(
    lattice=[[0, 2.73, 2.73], [2.73, 0, 2.73], [2.73, 2.73, 0]],
    species=["Si", "Si"],
    coords=[[0, 0, 0], [0.25, 0.25, 0.25]],
)

# relax job to optimize structure
relax_job = RelaxMaker().make(si_structure)

relax_job = update_user_incar_settings(relax_job, {"NCORE": 4})

# run job
run_locally(relax_job, create_folders=True, ensure_success=True)

print(f"Si relaxation took {perf_counter() - start:.3f} sec")
```

[vasp-hdf5]: https://vasp.at/wiki/index.php/Makefile.include#HDF5_support_.28strongly_recommended.29
