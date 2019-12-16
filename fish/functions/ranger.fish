function ranger --description 'Prevent nested ranger sessions'
    if test -z "$RANGER_LEVEL"
        command ranger $argv
    else
        exit
    end
end
