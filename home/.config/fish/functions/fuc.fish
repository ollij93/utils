function fuc
    set -g cmds (grep "^- cmd: " ~/.local/share/fish/fish_history | sed 's#^- cmd: ##' | sort | uniq -c | grep -v "^ *1 " | sort -rn)
    for cmd in $cmds
        echo $cmd
    end
end