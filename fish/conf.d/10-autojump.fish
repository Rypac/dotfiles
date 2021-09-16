if status is-interactive; and type -q autojump
    complete -x -c j -a '(autojump --complete (commandline -t))'
end
