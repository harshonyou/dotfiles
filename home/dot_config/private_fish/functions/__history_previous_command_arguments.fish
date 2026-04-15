# Enables !$ to expand to the last argument of the previous command (bash-style)
# Bound in fish_user_key_bindings
function __history_previous_command_arguments
    switch (commandline -t)
    case "!"
        commandline -t ""
        commandline -f history-token-search-backward
    case "*"
        commandline -i '$'
    end
end
