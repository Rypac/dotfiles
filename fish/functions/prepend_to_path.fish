function prepend_to_path --description 'Prepend the value(s) to $PATH'
    if test (count $argv) = 1
        set -l value $argv[1]
        if test -d $value; and not contains -- $value $PATH
            set PATH $value $PATH
        end
    else
        for value in $argv
            prepend_to_path $value
        end
    end
end
