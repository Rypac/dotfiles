if not status --is-interactive
    exit
end

# Neovim
alias vi nvim
alias vim nvim

# tmux
alias mux tmuxinator

# GPG
alias gpg gpg2
alias to-me 'gpg2 --encrypt --recipient me@rdavis.xyz --armour'
alias scramble 'gpg2 --output encrypted.gpg --encrypt --recipient me@rdavis.xyz'
alias unscramble 'gpg2 --decrypt --quiet'

# Stack
alias stack-update 'stack --resolver nightly setup --reinstall --install-ghc'
alias nstack 'stack --resolver nightly'

# resource usage
alias df 'df -khT'
alias du 'du -khsc'

switch (uname)
    case Linux
        # Python
        alias pip-upgrade "pip3 list --outdated --user --format=legacy | cut -d ' ' -f 1 | xargs -n 1 pip3 install --upgrade --user"

        # VSCode
        alias code "code --user-data-dir "$XDG_CONFIG_HOME/vscode" --extensions-dir "$XDG_CONFIG_HOME/vscode/extensions""
        alias vscode 'code'

        # Clipboard
        alias setclip 'xclip -selection clipboard -i'
        alias getclip 'xclip -selection clipboard -o'

        # pcmanfm
        function f --argument-names 'dir'
            test -n "$dir"; or set dir '.'
            pcmanfm "$dir" > /dev/null 2>&1 &
        end
    case Darwin
        # Python
        alias pip-upgrade "pip3 list --outdated --format=legacy | cut -d ' ' -f 1 | xargs -n 1 pip3 install --upgrade"

        # VSCode
        alias vscode 'code'

        # Vim (work around tmux issue on macOS sierra)
        alias nvim 'reattach-to-user-namespace -l nvim'

        # Finder
        function f --argument-names 'dir'
            test -n "$dir"; or set dir '.'
            open -a Finder "$dir"
        end
end
