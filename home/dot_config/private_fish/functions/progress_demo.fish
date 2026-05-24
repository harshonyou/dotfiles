function progress_demo
    set -l g (printf "\e[0;32m")
    set -l r (printf "\e[0m")

    # MonoLisa progress bar glyphs (built at runtime via printf \uXXXX)
    set -l S (printf "") # empty start cap
    set -l E (printf "") # empty fill
    set -l R (printf "") # right end cap
    set -l L (printf "") # filled left cap
    set -l F (printf "") # filled fill
    set -l X (printf "") # full end cap (100%)

    printf "\n\n"
    for pct in (seq 0 100)
        set -l filled (math "round($pct * 38 / 100)")
        set -l empty (math "38 - $filled")
        set -l bar
        if test $pct -eq 0
            set bar (printf "%s%s%s" $S (string repeat -n 38 $E) $R)
        else if test $pct -eq 100
            set bar (printf "%s%s%s" $L (string repeat -n 38 $F) $X)
        else
            set bar (printf "%s%s%s%s" $L (string repeat -n $filled $F) (string repeat -n $empty $E) $R)
        end
        printf "\r     %s%s%s (%3d%%)" $g $bar $r $pct
        sleep 0.04
    end
    printf "\r%100s\n\n" ""

    # MonoLisa spinner glyphs: EE06-EE0B and EE10-EE15
    set -l spin1 \
        (printf "") (printf "") (printf "") \
        (printf "") (printf "") (printf "")
    set -l spin2 \
        (printf "") (printf "") (printf "") \
        (printf "") (printf "") (printf "")

    printf "\n\n"
    for i in (seq 1 3)
        for j in (seq 1 (count $spin1))
            printf "\r     %s%s     %s     %s" $g $spin1[$j] $spin2[$j] $r
            sleep 0.25
        end
    end
    printf "\r%100s\n\n" ""
end
