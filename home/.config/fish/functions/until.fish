function until -d "Repeat command until it succeeds"
    if test (count $argv) -eq 0
        echo "Usage: until <command> [args...]"
        return 1
    end
    
    while not eval (string escape -- $argv)
        sleep 1
    end
end
