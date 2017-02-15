function prepend_to_path --description 'Prepend the value(s) to $PATH'
    for value in $argv
        if test -d $value; and not contains $value $PATH
            set PATH $value $PATH
        end
    end
end
