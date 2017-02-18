function app --description 'Wrapper around various package managers'
    switch (uname)
        case Linux
            __app_apt $argv
        case Darwin
            __app_brew $argv
    end
end

function __app_apt
    set -l subcommand $argv[1]
    set -e argv[1]

    switch $subcommand
        case i in install
            sudo apt install $argv
        case u up update upgrade
            sudo apt update $argv
            sudo apt upgrade $argv
        case r rm remove
            sudo apt remove $argv
        case l list
            dpkg-query -f '${binary:Package}\n' -W | less
        case s search
            apt search $argv
        case c clean
            sudo apt autoremove $argv
            sudo dpkg -P (dpkg -l | awk '/^rc/ { print($2) }')
        case p purge
            sudo apt purge --autoremove $argv
    end
end

function __app_brew
    set -l subcommand $argv[1]
    set -e argv[1]

    switch $subcommand
        case i in install
            brew install $argv
        case u up update upgrade
            brew update $argv
            brew upgrade $argv
        case r rm remove
            brew uninstall $argv
        case l list
            brew list $argv
        case s search
            brew search $argv
        case c clean
            brew cleanup
            brew prune
    end
end
