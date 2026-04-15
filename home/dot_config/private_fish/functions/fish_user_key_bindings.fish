# Custom key bindings loaded automatically by fish
# Uses vi mode as base, then adds !! and !$ bash-style history expansion
function fish_user_key_bindings
    fish_vi_key_bindings

    # !! expands to previous command
    bind -Minsert ! __history_previous_command
    # !$ expands to last argument of previous command
    bind -Minsert '$' __history_previous_command_arguments
end
