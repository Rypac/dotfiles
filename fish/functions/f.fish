function f --description 'Open the directory in a GUI file manager'
    set -l dir $argv
    if test -z $dir
        set dir .
    end

    switch (uname)
        case Linux
            pcmanfm $dir > /dev/null 2>&1 &
        case Darwin
            open -a Finder $dir
    end
end
