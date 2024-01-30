function show_powerline_symbols
    # Just useful for customisation
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
    echo 
end

function fish_right_prompt
    set -l retc red
    test $status = 0; and set retc green

    set_color $retc
    echo ""
    set_color normal

    set_color -b $retc
    set_color white
    echo -n " "
    echo -n (humantime $CMD_DURATION)
    echo -n " "
    echo -n "[$status]"
    echo -n " "
    set_color normal
end

function fish_prompt
    set -l retc red
    test $status = 0; and set retc green

    # Setup some non-standard colors I like
    set -g orange FF8700
    set -g lime100 75FF20
    set -g lime80 9EFF62
    set -g lime60 BEFF96
    set -g grey 444444
    set -g dgrey 222222
    set -g dred 440000

    set -g _sep ""
    set -g _battery_color $dgrey
    set -g _userlocal_color_bg $orange
    set -g _userlocal_color_fg black
    set -g _cwd_color_bg cyan
    set -g _cwd_color_fg black
    set -g _git_color $grey
    set -g _venv_color green
    set -g _ws_state_color $dgrey

    if string match -q -- "*fire*" $PWD
        set -g _sep " "
        set -g _battery_color $dgrey
        set -g _userlocal_color_bg yellow
        set -g _userlocal_color_fg black
        set -g _cwd_color_bg $orange
        set -q _cwd_color_fg black
        set -g _git_color red
        set -g _venv_color $dred
    end

    # Prompt wrapper to draw the different sections
    set -e prevcolor
    function _prompt_wrapper
        set -l color $argv[1]
        set -l textcolor $argv[2]
        set -l fieldvalue $argv[3]

        if test $prevcolor
            set_color -b $color
            set_color $prevcolor
            echo -n $_sep
            set_color normal
        end

        set_color -b $color
        set_color $textcolor
        echo -n " "
        echo -n $fieldvalue
        echo -n " "
        set_color normal

        set -g prevcolor $color
    end

    # Battery status
    if type -q acpi
        test (acpi -a 2> /dev/null | string match -r off)
        and _prompt_wrapper $_battery_color yellow (acpi -b | cut -d' ' -f 4-)
    else if type -q pmset
        # TODO - change color based on percentage
        _prompt_wrapper $_battery_color green (pmset -g batt | awk 'NR==2 { gsub(";", "", $3) ; print $3 }')
    end

    # Draw the login details
    set -l userlocal_color_bg $_userlocal_color_bg
    set -l userlocal_color_fg $_userlocal_color_fg
    if functions -q fish_is_root_user; and fish_is_root_user
        set -l userlocal_color_bg red
        set -l userlocal_color_fg black
    end

    # Want uncolored prompt_login with custom value for the local case
    function _prompt_login
        if test -z "$SSH_CLIENT"
            echo -n "$USER@local"
        else
            echo -n "$USER@"
            echo -n (prompt_hostname)
        end
    end
    set -l login (_prompt_login)
    _prompt_wrapper $userlocal_color_bg $userlocal_color_fg "$login"

    # CWD
    set -l cwd (prompt_pwd)
    _prompt_wrapper $_cwd_color_bg $_cwd_color_fg "$cwd"

    ########################################################
    # git - set lots of config and avoid reseting the color
    # to normal by overriding the setting function
    set -g __fish_git_prompt_show_informative_status 1
    set -g __fish_git_prompt_hide_untrackedfiles 1

    set -g __fish_git_prompt_showupstream "informative"
    set -g __fish_git_prompt_char_upstream_ahead "↑"
    set -g __fish_git_prompt_char_upstream_behind "↓"
    set -g __fish_git_prompt_char_upstream_prefix ""
    set -g __fish_git_prompt_char_stagedstate "●"
    set -g __fish_git_prompt_char_dirtystate "✚"
    set -g __fish_git_prompt_char_untrackedfiles "…"
    set -g __fish_git_prompt_char_conflictedstate "✖"
    set -g __fish_git_prompt_char_cleanstate "✔"

    function _sgc
        set -l varname $argv[1]
        set -l color $argv[2]

        set -g $varname $color
        set -g {$varname}_done $color
    end

    function __fish_git_prompt_set_color
        set -l user_variable_name "$argv[1]"

        set -l default default_done
        switch (count $argv)
            case 1 # No defaults given, use prompt color
                set default $___fish_git_prompt_color
                set default_done $___fish_git_prompt_color_done
            case 2 # One default given, use normal for done
                set default "$argv[2]"
                set default_done (set_color normal)
            case 3 # Both defaults given
                set default "$argv[2]"
                set default_done "$argv[3]"
        end

        set -l variable _$user_variable_name
        set -l variable_done "$variable"_done

        if not set -q $variable
            if test -n "$$user_variable_name"
                set -g $variable (set_color $$user_variable_name)
                # set -g $variable_done (set_color normal)
            else
                set -g $variable $default
                set -g $variable_done $default_done
            end
        end
    end

    _sgc __fish_git_prompt_color white
    _sgc __fish_git_prompt_color_prefix white
    _sgc __fish_git_prompt_color_suffix white
    _sgc __fish_git_prompt_color_bare white
    _sgc __fish_git_prompt_color_merging white
    _sgc __fish_git_prompt_color_cleanstate green
    _sgc __fish_git_prompt_color_invalidstate red
    _sgc __fish_git_prompt_color_upstream white
    _sgc __fish_git_prompt_color_flags white
    _sgc __fish_git_prompt_color_branch white
    _sgc __fish_git_prompt_color_dirtystate blue
    _sgc __fish_git_prompt_color_stagedstate yellow
    _sgc __fish_git_prompt_color_stashstate white
    _sgc __fish_git_prompt_color_untrackedfiles white
    set -g __fish_git_prompt_shorten_branch_len 40
    set -g prompt_git (fish_git_prompt '%s')
    test -n "$prompt_git"
    and _prompt_wrapper $_git_color $_git_color "$prompt_git"
    #
    ########################################################

    # Virtual Environment
    set -q VIRTUAL_ENV_DISABLE_PROMPT
    or set -g VIRTUAL_ENV_DISABLE_PROMPT true
    set -q VIRTUAL_ENV
    and _prompt_wrapper $_venv_color black (basename "$VIRTUAL_ENV")

    # Workspace state
    if type -q ws_state
        set -l WS_STATE (ws_state)
        if test -n "$WS_STATE"
            _prompt_wrapper $_ws_state_color black (ws_state)
        end
    end

    # Put a cap on the prompt
    _prompt_wrapper normal normal ""

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
    echo -n ' '
    echo -n '$ '
    set_color normal
end
