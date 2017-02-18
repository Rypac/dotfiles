if not status --is-interactive
    exit
end

alias vi nvim
alias vim nvim

alias mux tmuxinator

alias gpg gpg2
alias to-me 'gpg --encrypt --recipient me@rdavis.xyz --armour'
alias scramble 'gpg --output encrypted.gpg --encrypt --recipient me@rdavis.xyz'
alias unscramble 'gpg --decrypt --quiet'

alias stack-update 'stack --resolver nightly setup --reinstall --install-ghc'
alias nstack 'stack --resolver nightly'

switch (uname)
    case Linux
        alias pip-upgrade "pip3 list --outdated --user --format=legacy | cut -d ' ' -f 1 | xargs -n 1 pip3 install --upgrade --user"

        alias code "code --user-data-dir "$XDG_CONFIG_HOME/vscode" --extensions-dir "$XDG_CONFIG_HOME/vscode/extensions""
        alias vscode 'code'

        alias setclip 'xclip -selection clipboard -i'
        alias getclip 'xclip -selection clipboard -o'
    case Darwin
        alias pip-upgrade "pip3 list --outdated --format=legacy | cut -d ' ' -f 1 | xargs -n 1 pip3 install --upgrade"

        alias vscode 'code'

        alias nvim 'reattach-to-user-namespace -l nvim'
end
