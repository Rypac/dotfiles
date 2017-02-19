function pbcopy --description 'Copy data to the clipboard'
    if command -sq pbcopy
        command pbcopy $argv
    else if command -sq xclip
        command xclip -selection clipboard -i $argv
    else if command -sq xsel
        command xsel --clipboard --input $argv
    else
        return 1
    end
end
