function jco --description 'Open autojump child direcroty results in file browser'
    switch "$argv"
        case '-*'
            j $argv
        case '*'
            jo (pwd) $argv
    end
end
