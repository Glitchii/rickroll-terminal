# File should be sourced so it can change the prompt in the current shell
if [ -n "${BASH_VERSION:-}" ] && [ "${BASH_SOURCE[0]}" = "$0" ]; then
    echo "Run this with: source $0"
    exit 1
fi

# Running rickroll again puts the old prompt back.
if [ "${rickrolling:-false}" = true ]; then
    PS1=$old_ps1

    if [ -n "${ZSH_VERSION:-}" ]; then
        precmd_functions=("${old_precmd_functions[@]}")
    else
        PROMPT_COMMAND=$old_prompt_command
    fi

    unset rickrolling roll_count lyrics old_ps1 old_prompt_command old_precmd_functions
    unset -f rick_prompt 2>/dev/null
    return 0
fi

lyrics=(
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
    "Never gonna tell a lie and hurt you"
)

roll_count=0
if [ -n "${ZSH_VERSION:-}" ]; then
    roll_count=1
fi

old_ps1=$PS1

rick_prompt() {
    local lyric=${lyrics[$roll_count]}

    if [ -n "${ZSH_VERSION:-}" ]; then
        PS1="%F{green}${lyric}%f %F{blue}%~%f%# "
        roll_count=$((roll_count + 1))
        [ "$roll_count" -gt "${#lyrics[@]}" ] && roll_count=1
    else
        PS1='\[\e[1;32m\]'"${lyric}"'\[\e[0m\] \[\e[1;34m\]\w\[\e[0m\]\$ '
        roll_count=$((roll_count + 1))
        [ "$roll_count" -ge "${#lyrics[@]}" ] && roll_count=0
    fi

    return 0
}

if [ -n "${ZSH_VERSION:-}" ]; then
    old_precmd_functions=("${precmd_functions[@]}")
    precmd_functions+=(rick_prompt)
else
    old_prompt_command=${PROMPT_COMMAND:-}
    PROMPT_COMMAND="${old_prompt_command}${old_prompt_command:+; }rick_prompt"
fi

rickrolling=true