if command -q bat
    function cat --wraps=bat --description 'Concatenate and print files'
        bat $argv
    end
end
