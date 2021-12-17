mkdir -p ~/.local/bin
tail -n 59 rick.txt >~/.local/bin/rick && chmod +x ~/.local/bin/rick
rc=~/.$(basename $SHELL)rc

echo "# Inserted by rickroll-terminal" >> $rc
if [[ ! "$PATH" =~ "$HOME/.local/bin" ]]; then
    echo -e '\nexport PATH="$HOME/.local/bin:$PATH"' >> $rc
fi

tail -n 22 roll.txt >>$rc
echo "# End of rickroll-terminal" >> $rc

# if [[ ! "$PATH" =~ "$HOME/.local/bin" ]]; then
#     export PATH="$HOME/.local/bin:$PATH"
# fi
