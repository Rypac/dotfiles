# Add Homebrew to path
if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Prepend directories to path
export PATH="$XDG_BIN_HOME${PATH:+:"${PATH}"}"
