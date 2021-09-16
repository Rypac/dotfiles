if status is-interactive; and type -q autojump
    set -gx AUTOJUMP_SOURCED 1
    complete -x -c j -a '(autojump --complete (commandline -t))'
end
