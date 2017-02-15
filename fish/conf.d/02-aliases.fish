if not status --is-interactive
    exit
end

# Neovim
alias vi nvim
alias vim nvim

# tmux
alias mux tmuxinator
function tm
    set -l name $argv[1] 'default'
    tmux new -s "$name" > /dev/null 2>&1
    or tmux attach -t "$name"
end

# GPG
alias gpg gpg2
alias to-me 'gpg2 --encrypt --recipient me@rdavis.xyz --armour'
alias scramble 'gpg2 --output encrypted.gpg --encrypt --recipient me@rdavis.xyz'
alias unscramble 'gpg2 --decrypt --quiet'

# Stack
alias stack-update 'stack --resolver nightly setup --reinstall --install-ghc'
alias nstack 'stack --resolver nightly'

# Docker
alias docker-stop 'docker stop (docker ps -aq)'
alias docker-clean 'docker rm -f (docker ps -aq)'
alias docker-purge 'docker rmi -f (docker images -aq)'
alias docker-connect 'docker start -ai (docker ps -ql)'

# NPM
alias npm-tasks 'jq .scripts < package.json'

# Common tool aliases
alias qfind 'find . -name'
alias get 'curl --continue-at - --location --progress-bar --remote-name --remote-time'

# directory ops
alias cpr 'cp -r'
alias rmr 'rm -rf'
alias mkdir 'mkdir -p'

# resource usage
alias df 'df -khT'
alias du 'du -khsc'

if [ (uname) = "Linux" ]
    # Python
    alias pip-upgrade "pip3 list --outdated --user --format=legacy | cut -d ' ' -f 1 | xargs -n 1 pip3 install --upgrade --user"

    # VSCode
    alias code "code --user-data-dir "$XDG_CONFIG_HOME/vscode" --extensions-dir "$XDG_CONFIG_HOME/vscode/extensions""
    alias vscode 'code'

    # Clipboard
    alias setclip 'xclip -selection clipboard -i'
    alias getclip 'xclip -selection clipboard -o'

    # pcmanfm
    function f
        set -l dir $argv[1] .
        pcmanfm $dir[1] > /dev/null 2>&1 &
    end

    # Modifying permissions
    alias chmod 'chmod --preserve-root -v'
    alias chown 'chown --preserve-root -v'

    # Package manager
    alias appupdate 'sudo apt update; and sudo apt upgrade'
    alias appinstall 'sudo apt install'
    alias appremove 'sudo apt remove'
    alias apppurge 'sudo apt purge --autoremove'
    alias appsearch 'sudo apt search'
    alias appclean 'sudo apt autoremove'
    alias appcleanall 'sudo dpkg -P (dpkg -l | awk \'/^rc/ { print($2) }\')'
    alias applist 'dpkg-query -f \'${binary:Package}\n\' -W | less'

    # Chrome apps
    alias fastmail 'chrome-app FastMail https://www.fastmail.com'
    alias inbox 'chrome-app Inbox https://inbox.google.com'
    alias messenger 'chrome-app Messenger https://messenger.com'
    alias whatsapp 'chrome-app WhatsApp https://web.whatsapp.com'

    # Checkinstall
    alias makeinstall 'sudo checkinstall --default --install yes --nodoc --deldoc yes --deldesc yes --delspec yes --backup no'

else if [ (uname) = "Darwin" ]
    # Ruby
    alias be 'bundle exec'
    alias ber 'bundle exec rake'

    # Python
    alias pip-upgrade "pip3 list --outdated --format=legacy | cut -d ' ' -f 1 | xargs -n 1 pip3 install --upgrade"

    # VSCode
    alias vscode 'code'

    # Vim (work around tmux issue on macOS sierra)
    alias nvim 'reattach-to-user-namespace -l nvim'

    # Finder
    alias f 'open -a Finder ./'

    # Package manager
    alias appupdate 'brew update; and brew upgrade'
    alias appinstall 'brew install'
    alias appremove 'brew uninstall'
    alias appsearch 'brew search'
    alias appclean 'brew cleanup; and brew cask cleanup; and brew prune'
    alias appdoctor 'brew doctor; and brew cask doctor'
end
