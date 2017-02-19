function base16-oceanicnext --description 'Modify 256 color space of terminal using base16 themes'
    set -l color00 "1B/2B/34" # Base 00 - Black
    set -l color01 "EC/5f/67" # Base 08 - Red
    set -l color02 "99/C7/94" # Base 0B - Green
    set -l color03 "FA/C8/63" # Base 0A - Yellow
    set -l color04 "66/99/CC" # Base 0D - Blue
    set -l color05 "C5/94/C5" # Base 0E - Magenta
    set -l color06 "5F/B3/B3" # Base 0C - Cyan
    set -l color07 "C0/C5/CE" # Base 05 - White
    set -l color08 "65/73/7E" # Base 03 - Bright Black
    set -l color09 $color01 # Base 08 - Bright Red
    set -l color10 $color02 # Base 0B - Bright Green
    set -l color11 $color03 # Base 0A - Bright Yellow
    set -l color12 $color04 # Base 0D - Bright Blue
    set -l color13 $color05 # Base 0E - Bright Magenta
    set -l color14 $color06 # Base 0C - Bright Cyan
    set -l color15 "D8/DE/E9" # Base 07 - Bright White
    set -l color16 "F9/91/57" # Base 09
    set -l color17 "AB/79/67" # Base 0F
    set -l color18 "34/3D/46" # Base 01
    set -l color19 "4F/5B/66" # Base 02
    set -l color20 "A7/AD/BA" # Base 04
    set -l color21 "CD/D3/DE" # Base 06
    set -l color_foreground "C0/C5/CE" # Base 05
    set -l color_background "1B/2B/34" # Base 00
    set -l color_cursor "C0/C5/CE" # Base 05

    set -l printf_template printf_template_var printf_template_custom

    if test -n "$TMUX"
        set printf_template "\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\"
        set printf_template_var "\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\"
        set printf_template_custom "\033Ptmux;\033\033]%s%s\033\033\\\033\\"
    else
        set printf_template "\033]4;%d;rgb:%s\033\\"
        set printf_template_var "\033]%d;rgb:%s\033\\"
        set printf_template_custom "\033]%s%s\033\\"
    end

    # 16 color space
    printf $printf_template 0 $color00
    printf $printf_template 1 $color01
    printf $printf_template 2 $color02
    printf $printf_template 3 $color03
    printf $printf_template 4 $color04
    printf $printf_template 5 $color05
    printf $printf_template 6 $color06
    printf $printf_template 7 $color07
    printf $printf_template 8 $color08
    printf $printf_template 9 $color09
    printf $printf_template 10 $color10
    printf $printf_template 11 $color11
    printf $printf_template 12 $color12
    printf $printf_template 13 $color13
    printf $printf_template 14 $color14
    printf $printf_template 15 $color15

    # 256 color space
    printf $printf_template 16 $color16
    printf $printf_template 17 $color17
    printf $printf_template 18 $color18
    printf $printf_template 19 $color19
    printf $printf_template 20 $color20
    printf $printf_template 21 $color21

    # foreground / background / cursor color
    if test -n "$ITERM_SESSION_ID"
        # iTerm2 proprietary escape codes
        printf $printf_template_custom Pg C0C5CE # forground
        printf $printf_template_custom Ph 1B2B34 # background
        printf $printf_template_custom Pi C0C5CE # bold color
        printf $printf_template_custom Pj 4F5B66 # selection color
        printf $printf_template_custom Pk C0C5CE # selected text color
        printf $printf_template_custom Pl C0C5CE # cursor
        printf $printf_template_custom Pm 1B2B34 # cursor text
    else
        printf $printf_template_var 10 $color_foreground
        printf $printf_template_var 11 $color_background
        printf $printf_template_custom 12 ";7" # cursor (reverse video)
    end
end
