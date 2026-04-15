# Enables !! to expand to the previous command (bash-style)
# Bound in fish_user_key_bindings
function __history_previous_command
    switch (commandline -t)
    case "!"
        commandline -t $history[1]; commandline -f repaint
    case "*"
        commandline -i !
    end
end
