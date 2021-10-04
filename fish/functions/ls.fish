if command -q exa
    function ls --wraps=exa --description 'List contents of directory'
        exa $argv
    end
end
