# Take the first n lines of stdin
# Usage: seq 10 | take 3  →  prints lines 1-3
function take --argument number --description "Take the first n lines of input"
    head -$number
end
