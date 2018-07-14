set -gx AUTOJUMP_SOURCED 1

# enable tab completion
complete -x -c j -a '(autojump --complete (commandline -t))'

# set error file location
if test (uname) = "Darwin"
    set -gx AUTOJUMP_ERROR_PATH ~/Library/autojump/errors.log
else if test -d "$XDG_DATA_HOME"
    set -gx AUTOJUMP_ERROR_PATH $XDG_DATA_HOME/autojump/errors.log
else
    set -gx AUTOJUMP_ERROR_PATH ~/.local/share/autojump/errors.log
end

if test ! -d (dirname $AUTOJUMP_ERROR_PATH)
    mkdir -p (dirname $AUTOJUMP_ERROR_PATH)
end

function __aj_add --on-variable PWD -d "Change pwd hook"
    status --is-command-substitution; and return
    autojump --add (pwd) >/dev/null 2>>$AUTOJUMP_ERROR_PATH &
end

function __aj_err -d "Record error"
    echo -e $argv 1>&2; false
end

function j -d "Jump to a directory"
    switch "$argv"
        case '-*' '--*'
            autojump $argv
        case '*'
            set -l output (autojump $argv)
            # Check for . and attempt a regular cd
            if [ $output = "." ]
                cd $argv
            else
                if test -d "$output"
                    set_color red
                    echo $output
                    set_color normal
                    cd $output
                else
                    __aj_err "autojump: directory '"$argv"' not found"
                    __aj_err "\n$output\n"
                    __aj_err "Try `autojump --help` for more information."
                end
            end
    end
end

function jc -d "Jump to child directory (subdirectory of current path)"
    switch "$argv"
        case '-*'
            j $argv
        case '*'
            j (pwd) $argv
    end
end

function jo -d "Open autojump results in file browser"
    set -l output (autojump $argv)
    if test -d "$output"
        switch (uname)
            case Linux
                xdg-open (autojump $argv)
            case Darwin
                open (autojump $argv)
            case '*'
                __aj_err "Unknown operating system: \"$OSTYPE\""
        end
    else
        __aj_err "autojump: directory '"$argv"' not found"
        __aj_err "\n$output\n"
        __aj_err "Try `autojump --help` for more information."
    end
end

function jco -d "Open autojump results (child directory) in file browser"
    switch "$argv"
        case '-*'
            j $argv
        case '*'
            jo (pwd) $argv
    end
end
