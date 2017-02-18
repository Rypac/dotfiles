function append_to_path --description 'Append the value(s) to $PATH'
    for value in $argv
        if test -d $value; and not contains -- $value $PATH
            set PATH $PATH $value
        end
    end
end
