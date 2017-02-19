if not status --is-interactive
    exit
end

alias g git

alias vi nvim
alias vim nvim

alias mux tmuxinator

alias gpg gpg2
alias to-me 'gpg --encrypt --recipient me@rdavis.xyz --armour'
alias scramble 'gpg --output encrypted.gpg --encrypt --recipient me@rdavis.xyz'
alias unscramble 'gpg --decrypt --quiet'

alias stack-update 'stack --resolver nightly setup --reinstall --install-ghc'
alias nstack 'stack --resolver nightly'

alias vscode code

switch (uname)
    case Linux
        alias pip-upgrade "pip3 list --outdated --user --format=legacy | cut -d ' ' -f 1 | xargs -n 1 pip3 install --upgrade --user"

        alias code "code --user-data-dir "$XDG_CONFIG_HOME/vscode" --extensions-dir "$XDG_CONFIG_HOME/vscode/extensions""
    case Darwin
        alias pip-upgrade "pip3 list --outdated --format=legacy | cut -d ' ' -f 1 | xargs -n 1 pip3 install --upgrade"
end
