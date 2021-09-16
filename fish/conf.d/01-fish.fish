if status is-interactive
    set -gx SHELL (type -p fish)

    set -gx fish_color_autosuggestion brblack
    set -gx fish_color_command purple
    set -gx fish_color_comment yellow
    set -gx fish_color_end purple
    set -gx fish_color_error red
    set -gx fish_color_param blue
    set -gx fish_color_quote green
    set -gx fish_color_redirection cyan
end
