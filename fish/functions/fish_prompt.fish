function fish_prompt
    set -l last_status $status

    set -l red (set_color -o red)
    set -l blue (set_color -o blue)
    set -l green (set_color -o green)
    set -l normal (set_color normal)

    set -g __fish_git_prompt_color_branch brmagenta
    set -g __fish_git_prompt_color_cleanstate brgreen
    set -g __fish_git_prompt_color_invalidstate red
    set -g __fish_git_prompt_color_stagedstate yellow
    set -g __fish_git_prompt_show_informative_status 1 end
    set -g __fish_git_prompt_showupstream "informative"
    set -g __fish_git_prompt_showdirtystate "yes"

    set -l prompt_symbol
    switch "$USER"
        case root toor
            set prompt_symbol '#'
        case '*'
            set prompt_symbol '$'
    end

    set -l prompt_colour $green
    if [ $last_status -ne 0 ]
        set prompt_colour $red
    end

    set -l cwd $blue(basename (prompt_pwd))$normal
    set -l git (__fish_git_prompt)
    set -l prompt $prompt_colour$prompt_symbol$normal

    echo -n -s $cwd $git " $prompt "
end
