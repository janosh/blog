---
title: Conda Auto Env
slug: /conda-auto-env
date: 2019-04-23
cover:
  img: conda-python-robot.svg
  source: Vecteezy
  url: https://vecteezy.com/vector-art/192230-robot-character-design
tags:
  - Tutorial
  - Python
---

If you're like me, you're tired of manually having to activate your `conda` environment every time you switch between Python projects. Since you're reading this, you may even have started googling for a solution that automates this process. The following `zsh` script aimed satisfies this objective and has served me well for the last few months now. It's a spin-off of Christine Doig's [`conda-auto-env`](https://github.com/chdoig/conda-auto-env).

```sh:title=conda_auto_env.sh
#!/bin/zsh

# Automatically activates conda environments when entering directories
# containing a conda environment file. The file must be named one of
#   - env(ironment).y(a)ml
#   - requirements.y(a)ml

# Deactivates env when exciting the directory. If the env doesn't exist yet,
# offer to create it from file.

# Installation: Copy chpwd() to .zshrc or save the whole script as a file and
# source it in .zshrc, e.g. by placing it in /usr/local/bin or by symlinking
# conda_auto_env there and then adding `source conda_auto_env`.

# chpwd is a zsh hook called whenever the working directory changes.
# (http://zsh.sourceforge.net/Doc/Release/Functions.html#Hook-Functions). When
# using bash, use the environment variable `PROMPT_COMMAND` instead. This might
# have performance implications since it runs on every prompt (even empty ones),
# not just directory changes. Plus PROMPT_COMMAND makes it impossible to change
# to a different conda env while you're in a directory with an env file since
# bash will always auto-change back to that file's env.
chpwd() {
  # On Linux replace `find -E` with `f -regextype posix-extended`.
  FILE="$(find -E . -maxdepth 1 -regex '.*(env(ironment)?|requirements)\.ya?ml' -print -quit)"
  if [[ -e $FILE ]]; then
    ENV=$(sed -n 's/name: //p' $FILE)
    # Check if env is already active.
    if [[ $CONDA_DEFAULT_ENV != $ENV ]]; then
      conda activate $ENV
      # If env activation is unsuccessful, prompt user whether to create conda env from file.
      if [ $? -ne 0 ]; then
        while true; do
          # Read user reply into variable YorN.
          read "YorN?[conda_auto_env] Environment '$ENV' doesn't exist. Would you like to create it now? (y/n)"$'\n'
          # $'\n' for newline. https://unix.stackexchange.com/a/126316/315020
          if [ "$YorN" = "" ]; then YorN='y'; fi # interpret enter as y
          case $YorN in
              [Yy] ) echo Proceeding...
                conda env create -f $FILE
                conda activate $ENV;;
              [Nn] ) echo Exiting...; break;;
              * ) echo "Enter y for yes or n for no.";;
          esac
        done
      fi
      CONDA_ENV_ROOT="$(pwd)"
    fi
  # Deactivate env when exciting the env file's directory.
  elif [[ $PATH = */envs/* ]]\
    && [[ $(pwd) != $CONDA_ENV_ROOT ]]\
    && [[ $(pwd) != $CONDA_ENV_ROOT/* ]]
  then
    CONDA_ENV_ROOT=""
    conda deactivate
  fi
}

# Execute chpwd on shell init in case the shell launches in a conda env directory.
chpwd
```

To install it, either copy it to `.zshrc` or `.zprofile` or -- a little cleaner -- source this script in either of those files. For instance, say you have a `~/scripts` directory where you keep custom scripts like this, simply run

```sh
ln -s "~/scripts/conda_auto_env" /usr/local/bin
```

to add this script to your path. Then append the following line to your `.zshrc`.

```sh:title=.zshrc
source conda_auto_env
```

That's it. Now, every time you open a shell prompt in a directory that contains a `conda` environment file named one of `[env(ironment).y(a)ml, requirements.y(a)ml]`, `conda_auto_env` will automatically read the name of the corresponding environment from that file and activate it. Similarly, when you exit that directory, the environment will be deactivated. Lastly, if the environment doesn't exist yet when you first enter the directory, `conda_auto_env` will offer to [create it from file](https://docs.conda.io/projects/conda/latest/commands/create.html).
