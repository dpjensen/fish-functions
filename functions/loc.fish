#prints lines of code for a directory
function loc
    find . -type f -not -path "./.git/*" -not -name ".pylintrc" | xargs wc -l | grep total
end
