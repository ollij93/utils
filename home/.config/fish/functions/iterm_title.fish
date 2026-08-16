  function iterm_title
      set -l title (string join ' ' -- $argv)

      if set -q TMUX
          printf '\033Ptmux;\033\033]1;%s\007\033\\' "$title"
      else
          printf '\033]1;%s\007' "$title"
      end
  end
