#!/bin/sh
#
# Set login environment variables on macOS

: "${XDG_CONFIG_HOME:="$HOME/.config"}"
: "${ZDOTDIR:="$XDG_CONFIG_HOME/zsh"}"

# Reset the current PATH to a known state
if [ -x /usr/libexec/path_helper ]; then
    export PATH=''
    eval "$(/usr/libexec/path_helper -s)"
fi

for zshfile in "$HOME/.zshenv" "$ZDOTDIR/.zshenv.local" "$ZDOTDIR/.zprofile" "$ZDOTDIR/.zprofile.local"; do
    # Skip the file if it doesn't exist
    if [ ! -r "$zshfile" ]; then
        continue
    fi

    # Source file to expand necessary environment variables
    . "$zshfile"

    # Find all of the exported environment variables in the file
    grep '^export ' "$zshfile" | while IFS=' =' read -r ignoreexport envvar ignorevalue; do
        # Extract all of the variables in the current environment
        env -0 | while IFS='=' read -r -d '' key value; do
            # Set the current value of the environment variable only if it matches the file variable name
            if [ "$key" = "$envvar" ]; then
                launchctl setenv "$key" "$value"
            fi
        done
    done
done
