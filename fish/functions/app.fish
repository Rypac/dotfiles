function app --description 'Wrapper around various package managers'
    switch (command uname)
        case Linux
            __app_apt $argv
        case Darwin
            __app_brew $argv
    end
end

function __app_apt
    set -l cmd $argv[1]
    set -e argv[1]

    switch "$cmd"
        case i install
            command sudo apt install $argv
        case u up update
            command sudo apt update $argv
            command sudo apt upgrade $argv
        case r rm remove
            command sudo apt purge --autoremove $argv
        case l ls list
            command dpkg-query -f '${binary:Package}\n' -W | less
        case s search
            command apt search $argv
        case c clean
            command sudo apt autoremove
            command sudo apt clean
            command sudo dpkg -P (dpkg -l | awk '/^rc/ { print($2) }')
        case h help -h --help
            __app_usage
        case '*'
            __app_usage
            return 1
    end
end

function __app_brew
    set -l cmd $argv[1]
    set -e argv[1]

    switch "$cmd"
        case i install
            command brew install $argv
        case u up update
            command brew update $argv
            command brew upgrade $argv
        case r rm remove
            command brew uninstall $argv
        case l ls list
            command brew list $argv
        case s search
            command brew search $argv
        case c clean
            command brew cleanup
            command brew prune
        case h help -h --help
            __app_usage
        case '*'
            __app_usage
            return 1
    end
end

function __app_usage
    set -l u (set_color -u)
    set -l nc (set_color normal)

    echo "Usage: app [COMMAND] [PACKAGES...]"
    echo
    echo "where COMMAND is one of:"
    echo "    "$u"i"$nc"nstall"
    echo "    "$u"up"$nc"date"
    echo "    "$u"r"$nc"e"$u"m"$nc"ove"
    echo "    "$u"l"$nc"i"$u"s"$nc"t"
    echo "    "$u"s"$nc"earch"
    echo "    "$u"c"$nc"lean"
    echo "    "$u"h"$nc"elp"
end
