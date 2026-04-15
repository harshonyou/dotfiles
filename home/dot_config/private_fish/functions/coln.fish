# Print the nth whitespace-delimited column from stdin
# Usage: echo "a b c" | coln 2  →  b
function coln --description "Print the nth column of input"
    while read -l input
        echo $input | awk '{print $'$argv[1]'}'
    end
end
