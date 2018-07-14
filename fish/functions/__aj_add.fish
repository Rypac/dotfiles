function __aj_add --on-variable PWD --description 'Add pwd hook'
    status --is-command-substitution; and return
    autojump --add (pwd) > /dev/null 2>&1 &
end
