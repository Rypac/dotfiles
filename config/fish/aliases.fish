# Neovim
alias vi nvim
alias vim nvim

# tmux
alias mux tmuxinator
function tm
    tmux attach -t "$1"; or tmux new -s "$1"
end

# GPG
alias gpg gpg2

# Stack
alias stack-update 'stack --resolver nightly setup --reinstall --install-ghc'
alias nstack 'stack --resolver nightly'

# NPM
alias npm-tasks "jq '.scripts' < package.json"

# Common tool aliases
alias qfind 'find . -name'
alias get 'curl --continue-at - --location --progress-bar --remote-name --remote-time'

# directory ops
alias cpr 'cp -r'
alias rmr 'rm -rf'
alias mkdir 'mkdir -p'
function mkcd
    [ -n "$1" ]; and mkdir -p "$1"; and cd "$1"
end

# resource usage
alias df 'df -khT'
alias du 'du -khsc'
function sizeof
    [ -n "$1" ]; and du "$1" | tail -1 | cut -f1
end

if [ (uname) = "Linux" ]
    # Python
    alias pip-upgrade "pip3 list --outdated --user | cut -d ' ' -f 1 | xargs -n 1 pip3 install --upgrade --user"

    # VSCode
    alias code "code --user-data-dir "$XDG_CONFIG_HOME/vscode" --extensions-dir "$XDG_CONFIG_HOME/vscode/extensions""
    alias vscode 'code'

    # Clipboard
    alias setclip 'xclip -selection clipboard -i'
    alias getclip 'xclip -selection clipboard -o'

    # Aliases
    # function f
    #     (pcmanfm "${1:-.}" > /dev/null 2>&1 &)
    # end

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

    # function appcleanall
    #     sudo dpkg -P (dpkg -l | awk '/^rc/ { print($2) }')
    # end
    # function applist
    #     dpkg-query -f '${binary:Package}\n' -W | less
    # end

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
    alias pip-upgrade "pip3 list --outdated | cut -d ' ' -f 1 | xargs -n 1 pip3 install --upgrade"

    # VSCode
    alias vscode 'code'

    # Vim (work around tmux issue on macOS sierra)
    alias nvim 'reattach-to-user-namespace -l nvim'

    # Cocos2d-x
    alias cocos "$HOME/Developer/projects/pulse/libs/cocos2d/tools/cocos2d-console/bin/cocos"
    alias fbx-conv "$HOME/Developer/projects/pulse/libs/cocos2d/tools/fbx-conv/mac/fbx-conv"

    # Aliases
    alias f 'open -a Finder ./'

    # Package manager
    alias appupdate 'brew update; and brew upgrade'
    alias appinstall 'brew install'
    alias appremove 'brew uninstall'
    alias appsearch 'brew search'
    alias appclean 'brew cleanup; and brew cask cleanup; and brew prune'
    alias appdoctor 'brew doctor; and brew cask doctor'

    # ls colours
    export LSCOLORS 'exfxcxdxbxGxDxabagacad'
    export LS_COLORS 'di 34:ln 35:so 32:pi 33:ex 31:bd 36;01:cd 33;01:su 31;40;07:sg 36;40;07:tw 32;40;07:ow 33;40;07:'
    alias ls 'ls -G'
end
