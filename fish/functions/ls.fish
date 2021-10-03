function ls --wraps=exa --description 'Use exa or fallback to ls'
    if command -q exa
        command exa $argv
    else
        command ls $argv
    end
end
