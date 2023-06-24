#!/usr/bin/env bash

mkdir -p ~/.local/bin

# Create the rickroller script in the ~/.local/bin directory
cat <<EOF >~/.local/bin/rick
#!/usr/bin/env bash

roll_count=0
path=\$(realpath "\$0")

# Reset lyrics index to 0 if roll_count is 0
if [ "\$1" = '-r' ]; then
    sed -i "s/^roll_count=[0-9]\+\$/roll_count=\$((\$roll_count + 1))/" "\$path"
    exit
fi

lyrics=("Never gonna give you up"
    "Never gonna let you down"
    "Never gonna run around and desert you"
    "Never gonna make you cry"
    "Never gonna say goodbye"
    "Never gonna tell a lie and hurt you"
    "Never gonna give you up"
    "Never gonna let you down"
    "Never gonna run around and desert you"
    "Never gonna make you cry"
    "Never gonna say goodbye"
    "Never gonna tell a lie and hurt you"
    "(Ooh, give you up)"
    "(Ooh, give you up)"
    "Never gonna give, never gonna give"
    "(Give you up)"
    "Never gonna give, never gonna give"
    "(Give you up)"
    "We've known each other for so long"
    "Your heart's been aching, but"
    "You're too shy to say it"
    "Inside, we both know what's been going on"
    "We know the game and we're gonna play it"
    "I just wanna tell you how I'm feeling"
    "Gotta make you understand"
    "Never gonna give you up"
    "Never gonna let you down"
    "Never gonna run around and desert you"
    "Never gonna make you cry"
    "Never gonna say goodbye"
    "Never gonna tell a lie and hurt you"
    "Never gonna give you up"
    "Never gonna let you down"
    "Never gonna run around and desert you"
    "Never gonna make you cry"
    "Never gonna say goodbye"
    "Never gonna tell a lie and hurt you"
    "Never gonna give you up"
    "Never gonna let you down"
    "Never gonna run around and desert you"
    "Never gonna make you cry"
    "Never gonna say goodbye"
    "Never gonna tell a lie and hurt you")

max="\${#lyrics[@]}"
[ -t 1 ] && echo "\${lyrics[\$roll_count]}" || echo -n "\${lyrics[\$roll_count]}"

if [[ -n "\${lyrics[\$((\$roll_count + 1))]}" ]]; then
    sed -i "s/^roll_count=[0-9]\+\$/roll_count=\$((\$roll_count + 1))/" "\$path"
else
    sed -i "s/^roll_count=[0-9]\+\$/roll_count=0/" "\$path"
fi
EOF

chmod +x ~/.local/bin/rick

# # Determin the shell type (bash, zsh, etc) and thus the right RC file
# shell_rc_file=~/.$(basename "$SHELL")rc

# Will be using bashrc for now
shell_rc_file=~/.bashrc

echo -e "\n\n# Inserted by rickroll-lyrics-PS1" >>$shell_rc_file
if [[ ! "$PATH" =~ "$HOME/.local/bin" ]]; then
    echo -e '\nexport PATH="$HOME/.local/bin:$PATH"' >>$shell_rc_file
fi

cat <<EOF >>"$shell_rc_file"
argmnt() {
    if [[ \$1 =~ ^-\$2 ]]; then
        return 0
    else
        return 1
    fi
}

roll() {
    argmnt "\$1" c && clear
    if argmnt "\$1" r; then
        [[ -f ~/.ps1.bk && -n \$(cat ~/.ps1.bk) ]] && export PS1=\$(cat ~/.ps1.bk)
        [[ -f ~/.pcmd.bk && -n \$(cat ~/.pcmd.bk) ]] && export PROMPT_COMMAND=\$(cat ~/.pcmd.bk) || unset PROMPT_COMMAND
        rm -f ~/.ps1.bk ~/.pcmd.bk
    else
        [ ! -f ~/.ps1.bk ] && echo "\$PS1" > ~/.ps1.bk
        [ -n "\$PROMPT_COMMAND" ] && echo "\$PROMPT_COMMAND" > ~/.pcmd.bk
        export PROMPT_COMMAND='PS1="\[\033[1;32m\]\$(~/.local/bin/rick)\[\033[0m\] \[\033[1;34m\]\w\[\033[0m\]$ "'
    fi
}
EOF

echo "# End of rickroll-lyrics-PS1" >>$shell_rc_file

# if [[ ! "$PATH" =~ "$HOME/.local/bin" ]]; then
#     export PATH="$HOME/.local/bin:$PATH"
# fi

echo -e "\e[32mYou can now open a new terminal session (or run 'source $shell_rc_file') then type 'roll'\e[0m"
