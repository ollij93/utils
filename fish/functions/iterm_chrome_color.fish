function iterm_chrome_color
    set -l rgb
    set -l sequences

    switch "$argv[1]"
        case background
            set rgb 40 42 54       #282A36
        case current-line current_line
            set rgb 98 114 164     #6272A4
        case selection
            set rgb 68 71 90       #44475A
        case foreground
            set rgb 248 248 242    #F8F8F2
        case comment
            set rgb 98 114 164     #6272A4
        case red
            set rgb 255 85 85      #FF5555
        case orange
            set rgb 255 184 108    #FFB86C
        case yellow
            set rgb 241 250 140    #F1FA8C
        case green
            set rgb 80 250 123     #50FA7B
        case cyan
            set rgb 139 233 253    #8BE9FD
        case purple
            set rgb 189 147 249    #BD93F9
        case pink
            set rgb 255 121 198    #FF79C6
        case reset
            set sequences '6;1;bg;*;default'
        case '*'
            printf '%s\n' \
                'Usage: iterm_chrome_colour <colour>' \
                'Colours: background current-line selection foreground comment' \
                '         red orange yellow green cyan purple pink reset' >&2
            return 2
    end

    if test "$argv[1]" != reset
        set sequences \
            "6;1;bg;red;brightness;$rgb[1]" \
            "6;1;bg;green;brightness;$rgb[2]" \
            "6;1;bg;blue;brightness;$rgb[3]"
    end

    for sequence in $sequences
        if set -q TMUX
            printf '\033Ptmux;\033\033]%s\007\033\\' "$sequence"
        else
            printf '\033]%s\007' "$sequence"
        end
    end
end
