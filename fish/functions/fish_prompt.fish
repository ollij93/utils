function fish_prompt
    set -l retc red
    test $status = 0; and set retc green

    function _prompt_wrapper
        set -l color $argv[1]
        set -l field_value $argv[2]

        set_color -o $color
        echo -n '('
        set_color normal
        echo -n $field_value
        set_color -o $color
        echo -n ')'
    end

    if functions -q fish_is_root_user; and fish_is_root_user
        set_color -o red
    else
        set_color -o FFAA33
    end
    echo -n $USER


    set_color -o white
    echo -n @
    set_color -o FFAA33
    if test -z "$SSH_CLIENT"
        echo -n "local"
    else
        echo -n (prompt_hostname)
    end
    set_color normal

    set_color white
    echo -n :(prompt_pwd)

    # git
    set -g __fish_git_prompt_show_informative_status 1
    set -g __fish_git_prompt_hide_untrackedfiles 1

    set -g __fish_git_prompt_color_branch cyan
    set -g __fish_git_prompt_showupstream "informative"
    set -g __fish_git_prompt_char_upstream_ahead "↑"
    set -g __fish_git_prompt_char_upstream_behind "↓"
    set -g __fish_git_prompt_char_upstream_prefix ""

    set -g __fish_git_prompt_char_stagedstate "●"
    set -g __fish_git_prompt_char_dirtystate "✚"
    set -g __fish_git_prompt_char_untrackedfiles "…"
    set -g __fish_git_prompt_char_conflictedstate "✖"
    set -g __fish_git_prompt_char_cleanstate "✔"

    set -g __fish_git_prompt_color_dirtystate blue
    set -g __fish_git_prompt_color_stagedstate yellow
    set -g __fish_git_prompt_color_invalidstate red
    set -g __fish_git_prompt_color_untrackedfiles normal
    set -g __fish_git_prompt_color_cleanstate green
    set -l prompt_git (fish_git_prompt '%s')
    test -n "$prompt_git"
    and _prompt_wrapper cyan $prompt_git

    # Virtual Environment
    set -q VIRTUAL_ENV_DISABLE_PROMPT
    or set -g VIRTUAL_ENV_DISABLE_PROMPT true
    set -q VIRTUAL_ENV
    and _prompt_wrapper green (basename "$VIRTUAL_ENV")

    # Battery status
    type -q acpi
    and test (acpi -a 2> /dev/null | string match -r off)
    and _prompt_wrapper yellow (acpi -b | cut -d' ' -f 4-)

    # New line
    echo

    # Vi-mode
    # The default mode prompt would be prefixed, which ruins our alignment.
    function fish_mode_prompt
    end

    if test "$fish_key_bindings" = fish_vi_key_bindings
        or test "$fish_key_bindings" = fish_hybrid_key_bindings
        set -l mode
        switch $fish_bind_mode
            case default
                set mode (set_color --bold red)N
            case insert
                set mode (set_color --bold green)I
            case replace_one
                set mode (set_color --bold green)R
                echo '[R]'
            case replace
                set mode (set_color --bold cyan)R
            case visual
                set mode (set_color --bold magenta)V
        end
        set mode $mode(set_color normal)
        _prompt_wrapper red $mode
    end


    set_color normal
    echo -n '>'
    set_color -o $retc
    echo -n '$ '
    set_color normal
end
