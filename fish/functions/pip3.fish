function pip3
    set -l cmd $argv[1]
    set -e argv[1]

    switch "$cmd"
        case install list
            command pip3 $cmd --user $argv
        case update upgrade
            command pip3 list --user $argv | tail -n +3 | cut -d ' ' -f 1 | xargs command pip3 install --user --upgrade $argv
        case '*'
            command pip3 $cmd $argv
    end
end
