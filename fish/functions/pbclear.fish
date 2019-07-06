function pbclear --description 'Clear the clipboard'
    if command -sq pbcopy
        echo '' | pbcopy
    else
        return 1
    end
end
