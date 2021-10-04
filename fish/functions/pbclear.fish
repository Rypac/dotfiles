if command -q pbcopy
    function pbclear --description 'Clear the clipboard'
        printf '' | command pbcopy
    end
end
