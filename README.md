# rickroll-terminal

A tiny script that turns each Bash or Zsh prompt into the next line of a
rickroll.

![Terminal screenshot](https://raw.githubusercontent.com/Glitchii/rickroll-lyrics-PS1/main/terminal.png)

## Setup

From the cloned repo, copy and run this once:

```sh
mkdir -p ~/.local/bin
cp rickroll.sh ~/.local/bin/rickroll
chmod +x ~/.local/bin/rickroll

# Add an alias to the current shell and its rc file.
printf '\nalias rickroll=". ~/.local/bin/rickroll"\n' >> "$HOME/.${SHELL##*/}rc"
alias rickroll=". ~/.local/bin/rickroll"
```

Then you can type `rickroll` to activate in the current terminal or any new one.
Run `rickroll` again to turn it off. There are no flags.

This intentionally supports Bash and Zsh, the common default shells on Linux
and macOS.
