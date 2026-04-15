function envrun --description "Load .env file and run a command"
    set -l env_file ".env"

    # Allow custom env file via -f flag
    if test "$argv[1]" = "-f"
        set env_file $argv[2]
        set argv $argv[3..]
    end

    if not test -f $env_file
        echo "envrun: $env_file not found"
        return 1
    end

    if test (count $argv) -eq 0
        echo "Usage: envrun [-f <file>] <command> [args...]"
        return 1
    end

    # Parse and export vars, then run command
    set -l env_vars
    while read -l line
        # Skip comments and empty lines
        string match -qr '^\s*#|^\s*$' -- $line; and continue
        # Strip leading export keyword if present
        set line (string replace -r '^export\s+' '' -- $line)
        # Only process KEY=VALUE lines
        if string match -qr '^[A-Za-z_][A-Za-z0-9_]*=' -- $line
            set -a env_vars $line
        end
    end < $env_file

    env $env_vars $argv
end
