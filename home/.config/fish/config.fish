if status is-interactive
    set --global fish_key_bindings fish_default_key_bindings

    fish_config theme choose "Dracula Official"

    # Disable the cheesy welcome message when opening the prompt
    set fish_greeting

    starship init fish | source

    if [ -e /nobackup/$USER ]
        set -gx RUSTUP_HOME /nobackup/olijohns/.rustup
        set -gx CARGO_HOME /nobackup/olijohns/.cargo
    end

    function refresh_vscode_ipc_hook
        set -l socket (command ls -1t '/run/user/*/vscode-ipc-*.sock' 2>/dev/null | head -n 1)

        if test -n "$socket"
            set -gx VSCODE_IPC_HOOK_CLI "$socket"
        end
    end

    refresh_vscode_ipc_hook

    function refresh_vscode_ipc_hook_preexec --on-event fish_preexec
        refresh_vscode_ipc_hook
    end
end
