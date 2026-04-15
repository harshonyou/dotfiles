# Skip the first n lines of stdin
# Usage: seq 10 | skip 5  →  prints lines 6-10
function skip --argument n --description "Skip the first n lines of input"
    tail +(math 1 + $n)
end
