function cat --wraps=bat --description 'Use bat or fallback to cat'
    if command -q bat
        command bat $argv
    else
        command cat $argv
    end
end
