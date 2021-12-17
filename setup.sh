mkdir -p ~/.local/bin
tail -n 59 rick.txt >~/.local/bin/rick && chmod +x ~/.local/bin/rick
rc=~/.$(basename $SHELL)rc

echo -e "\n\n# Inserted by rickroll-terminal" >> $rc
if [[ ! "$PATH" =~ "$HOME/.local/bin" ]]; then
    echo -e '\nexport PATH="$HOME/.local/bin:$PATH"' >> $rc
fi

tail -n 20 roll.txt >>$rc
echo "# End of rickroll-terminal" >> $rc

# if [[ ! "$PATH" =~ "$HOME/.local/bin" ]]; then
#     export PATH="$HOME/.local/bin:$PATH"
# fi

echo -e "\e[32mDone, you can now open a new terminal and type 'roll'\e[0m"