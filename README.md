# rickroll-terminal

A tiny script that turns each Bash or Zsh prompt into the next line of a
rickroll.

![Terminal screenshot](https://raw.githubusercontent.com/Glitchii/rickroll-lyrics-PS1/main/terminal.png)

## Setup

Paste this into your terminal just once to clone the repo and setup the script:

```sh
git clone https://github.com/Glitchii/rickroll-terminal
cd rickroll-terminal

rc_file="$HOME/.${SHELL##*/}rc"
mkdir -p ~/.local/bin
cp rickroll.sh ~/.local/bin/rickroll

printf '\nalias rickroll=". ~/.local/bin/rickroll"\n' >> "$rc_file"
alias rickroll=". ~/.local/bin/rickroll"
```

You can from now on run `rickroll` to activate or deactivate. The alias is also available in new terminals.  
To activate automatically in every new terminal, write `rickroll` in your shell rc file. Run `echo "$rc_file"` to see the rc file used
