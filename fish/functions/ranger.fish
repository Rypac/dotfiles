function ranger
    if test -z "$RANGER_LEVEL"
        command ranger $argv
    else
        exit
    end
end
