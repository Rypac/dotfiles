function pbclear --description 'Clear the clipboard'
    command -q pbcopy; and printf '' | pbcopy
end
