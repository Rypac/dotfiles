function pbpaste --description 'Paste data from the clipboard'
    if command -sq pbcopy
        command pbpaste $argv
    else if command -sq xclip
        command xclip -selection clipboard -o $argv
    else if command -sq xsel
        command xsel --clipboard --output $argv
    else
        return 1
    end
end
