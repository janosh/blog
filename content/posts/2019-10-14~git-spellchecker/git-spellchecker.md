---
title: Git Spellchecker
slug: /git-spellchecker
date: 2019-10-14
cover:
  img: git-spellchecker.svg
tags:
  - Tutorial
  - Technology
---

Do you sometimes find yourself typing commit messages in a hurry, immediately pushing to GitHub and only noticing too late that you've made a bunch of typos? It's happened to me often enough that I decided my commit messages need a spellchecker.

The good news is, `git` has your back here. A `commit-msg` hook makes this really easy. Hooks are simply shell scripts with a [name `git` recognizes](https://git-scm.com/docs/githooks) and placed in a directory where `git` is looking for hooks. According to the [`git` docs](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks):

> The `commit-msg` hook takes one parameter, the path to a temporary file that contains the commit message written by the developer. If this script exits non-zero, `git` aborts the commit process, so you can use it to validate your project state or commit message before allowing a commit to go through.

These hooks can be

- **local** to a project in which case the default location is `.git/hooks` (take a look in there for a bunch of helpful example hooks). This can be changed via `git config core.hooksPath path/to/hooks`. You'll probably want to use this if you want to commit the hooks themselves to version control.
- **global** in which case they trigger for commits in all repos on that machine.

There's not a whole lot of official documentation on `git` hooks, especially not on how to combine global and local hooks. All I could find is

- [a list of recognized hook names and their respective purpose](https://git-scm.com/docs/githooks)
- a [section in the `git` book](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks) that reiterates some of that information.

But after [a little bit of personal experimentation](https://github.com/pre-commit/pre-commit/issues/1198), it turns out that as soon as you specify a global hook path and leave the default local hook directory as is (i.e. `.git/hooks`), the global hook directory shadows the local one. Only the global hooks will called if you installed any or nothing happens if there are none. If, on the other hand, you also specify a local hooks directory (it can even be the default location, i.e. `git config --local core.hooksPath .git/hooks`) the story is reversed. In that case, local hooks will shadow global ones. It seems `git` left it to you to make sure the global/local hooks check for the existence of local/global hooks and [run those themselves](https://stackoverflow.com/a/53722351) if that's what you want...

Anyways with all that cleared up and knowing the caveats, I'll be assuming in this guide that you want to setup that `commit-msg` hook globally. In that case, first decide where your global `git` hooks should live. To specify that, run `git config --global core.hooksPath path/to/globalHooks`. The path could be something like `~/gitHooks` or `~/dotfiles/gitHooks`. You can also specify multiple directories for your global hooks. Just separate each path by a space.

Next, create a file named `commit-msg` in your global hook directory:

```sh
touch $(git config --global core.hooksPath)/commit-msg
```

and insert the following.

```sh
#!/bin/sh

# Adapted from https://reddit.com/r/bash/comments/49sflp/spellcheck_git_commit_hook.
if ! command -v aspell &>/dev/null; then
  printf "%s\n" "[commit-msg hook] Warning: 'aspell' not installed. Unable to spell check commit message."
else
  commit_msg_file="$1"
  wordList=( $(grep -v "^  " "$commit_msg_file" | aspell list) )
fi

if (( "${#wordList[@]}" > 0 )); then
  printf "%s\n" "[commit-msg hook] Possible spelling errors found in commit message:" "${wordList[@]}"
fi

# Check if running inside a terminal where the user can be prompted to handle
# possible spelling errors. See https://stackoverflow.com/a/911213.
if [ -t 1 ]; then
  # Adapted from https://stackoverflow.com/a/10015707.
  exec < /dev/tty

  while true; do
    read -p "[commit-msg hook] Proceed anyway? (y/n) " yn
    if [ "$yn" = "" ]; then
      yn='y'
    fi
    case $yn in
        [Yy] ) break;;
        [Nn] ) exit 1;;
        * ) echo "Please answer y for yes or n for no.";;
    esac
  done
fi
```

Finally, make sure you have [`aspell`](https://aspell.net) (or a similar command line spellchecker) installed and in your path. With Homebrew on macOS, it's as simple `brew install aspell`. Similarly, on Linux: `apt-get install aspell`.

That's it. Next time you type a commit message of questionable spelling, `git` will provide you with a list of all potential typos and ask if you want to abort to modify the message or proceed anyway.

Note, however, that with the above script, this will only work if you're committing from terminal. If instead you're using a UI for version control, there most likely won't a way for `git` to interact with the user directly. I asked [VS Code](https://github.com/microsoft/vscode/issues/82512) if they might provide a way around this in the future but they declined.
