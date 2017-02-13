function fish_prompt
    set -l last_status $status

    set -l red (set_color -o red)
    set -l blue (set_color -o blue)
    set -l green (set_color -o green)
    set -l normal (set_color normal)

    set -l prompt_symbol '$'
    if [ $USER = 'root' ]
        set prompt_symbol '#'
    end

    set -l prompt_colour $green
    if [ $last_status -ne 0 ]
        set prompt_colour $red
    end

    set -l cwd $blue(basename (prompt_pwd))
    set -l prompt $prompt_colour$prompt_symbol

    echo -n $cwd $prompt $normal
end
