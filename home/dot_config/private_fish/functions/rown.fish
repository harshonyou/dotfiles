# Print the nth line from stdin
# Usage: seq 5 | rown 3  →  3
function rown --argument index --description "Print the nth row of input"
    sed -n "$index p"
end
