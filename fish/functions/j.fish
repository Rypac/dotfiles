function j --description 'Jump to a directory'
    switch "$argv"
        case '-*' '--*'
            autojump $argv
        case '*'
            set -l output (autojump $argv)

            if [ $output = "." ]
                cd $argv
            else if test -d "$output"
                set_color red
                echo $output
                set_color normal
                cd $output
            end
    end
end
