function active_git_branch
    git rev-parse --abbrev-ref HEAD 2> /dev/null
end

function gitsu
    set -l branch (active_git_branch)
    git branch --set-upstream-to=origin/$branch $branch
end