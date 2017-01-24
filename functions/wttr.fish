#console weather app
function wttr
    if test -z "$WTTR_ZIP"
        echo "Enter a zip code:"
        read LZIP
        set -gx WTTR_ZIP $LZIP
    end
    curl "wttr.in/$WTTR_ZIP?m"
end
