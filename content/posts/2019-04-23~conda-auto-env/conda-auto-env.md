---
title: Conda Auto Env
slug: /conda-auto-env
date: 2019-04-23
cover:
  img: royal-python.jpg
  source: Kapa65
  url: https://pixabay.com/photos/snake-ball-python-garden-camouflage-365037
tags:
  - Tutorial
  - Python
---

If you're like me, you'll have gotten tired of manually having to activate your `conda` environment every time you switch between Python projects pretty quickly. Since you're reading this, you may even have started googling for a solution that could take care of this automatically. The following shell script has served me very well for this purpose for several months now. It's a spin-off of [Christine Doig](https://github.com/chdoig)'s [`conda-auto-env`](https://github.com/chdoig/conda-auto-env).

```sh:title=conda_auto_env
#!/bin/bash

# automatically activates conda environments when entering directories
# with a conda environment file which must be named one of
#   - env(ironment).y(a)ml
#   - requirements.y(a)ml
# if env doesn't exist yet, create it; deactivate env when exciting folder
# installation: copy chpwd() to .bashrc or save the whole script as
# file and source it in .bashrc, e.g. by placing it in /usr/local/bin
# or by symlinking conda_auto_env there

# chpwd is a zsh hook function that is executed whenever the current working
# directory is changed (http://zsh.sourceforge.net/Doc/Release/Functions.html).
chpwd() {
  FILE="$(find -E . -maxdepth 1 -regex '.*(env(ironment)?|requirements)\.ya?ml' -print -quit)"
  if [[ -e $FILE ]]; then
    ENV=$(sed -n 's/name: //p' $FILE)
    # check if env already active
    if [[ $CONDA_DEFAULT_ENV != $ENV ]]; then
      conda activate $ENV
      # if env activation unsuccessful, create new env from file
      if [ $? -ne 0 ]; then
        echo "Conda environment '$ENV' doesn't exist. Creating it now."
        conda env create -q
        conda activate $ENV
      fi
      CONDA_ENV_ROOT="$(pwd)"
    fi
  # deactivate env when exciting root dir
  elif [[ $PATH = */envs/* ]]\
    && [[ $(pwd) != $CONDA_ENV_ROOT ]]\
    && [[ $(pwd) != $CONDA_ENV_ROOT/* ]]
  then
    CONDA_ENV_ROOT=""
    conda deactivate
  fi
}

# execute chpwd on shell init
chpwd
```

To install it, either copy it to `.bashrc` or `.bashprofile` or -- perhaps a little cleaner -- source this script in either of those files. For instance, say you have a `~/scripts` directory where you keep custom scripts like this one, to add this script to your path, you would simply run

```sh
ln -s "~/scripts/conda_auto_env" /usr/local/bin
```

and then append the following line to your `.bashrc`.

```sh:title=.bashrc
source conda_auto_env
```

That's it. Now, every time you open a shell prompt in a directory that contains a `conda` environment file named one of `env(ironment).y(a)ml`, `requirements.y(a)ml`, `conda_auto_env` will automatically read the name of the corresponding environment from that file and activate it. Similarly, when you exit that directory, the environment will be deactivated again and if the environment doesn't exist yet when you first enter the directory, `conda_auto_env` will generate it and install all specified dependencies.
