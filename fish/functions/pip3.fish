function pip3
    set -l cmd $argv[1]
    set -e argv[1]

    switch "$cmd"
        case install list
            command pip3 $cmd --user $argv
        case update upgrade
            pip3 list --outdated --format=legacy $argv | cut -d ' ' -f 1 | xargs -n 1 pip3 install --upgrade $argv
        case '*'
            command pip3 $cmd $argv
    end
end
