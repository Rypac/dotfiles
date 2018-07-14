function jc --description 'Jump to child directory'
    switch "$argv"
        case '-*'
            j $argv
        case '*'
            j (pwd) $argv
    end
end
