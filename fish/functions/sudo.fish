function sudo
    if test "$argv" = !!
        set -l last_command $history[1]
        echo sudo $last_command
        eval command sudo $last_command
    else
        command sudo $argv
    end
end
