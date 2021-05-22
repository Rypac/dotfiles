function tm --description 'Attach to (or create) a tmux session'
    set -l name $argv
    if test -z $name
        set name default
    end

    tmux attach -t $name >/dev/null 2>&1
    or tmux new -s $name
end
