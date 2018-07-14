function jo --description 'Open autojump results in file browser'
    set -l output (autojump $argv)

    if test -d "$output"
        switch (uname)
            case Linux
                xdg-open (autojump $argv)
            case Darwin
                open (autojump $argv)
        end
    end
end
