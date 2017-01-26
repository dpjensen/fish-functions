#create git functions
function git_current_branch
    echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function git_is_dirty
    echo (git status -s --ignore-submodules=dirty ^/dev/null)
end

function fish_prompt

    set -g last_status (echo "$status")


    #shortcuts for 256 color ranges

    set -l orange0 (set_color FF6000)
    set -l orange1 (set_color FF8A42)
    set -l orange2 (set_color FFAA77)
    set -l orange3 (set_color A43E00)
    set -l orange4 (set_color 4D1E00)

    # shortcuts for colors
    set -l green (set_color green)
    set -l red (set_color red)
    set -l blue (set_color blue)
    set -l normal (set_color normal)
    set -l usr (whoami)
    set -l ppwd (prompt_pwd)
    set -l gear $normal"⏻"
    set -l funct "𝜵 "
    set -l arrow "→"
    set -l host (hostname)
    set -l ctime (timedatectl | grep "Local time" | awk '{print $5}' | grep -o "..:..")

    if test -n (git_current_branch)
        set git_info $orange3"[⎇"(git_current_branch)"]"

        if test -n (git_is_dirty)
            set -l dirty "$red 𝜵"
            set git_info "$git_info$dirty "
        else
            set git_info "$git_info "
        end
    end

    if  test (echo $last_status) != "0"
        set -g pstatus (echo "$red$last_status")
    else
        set -e pstatus
    end
    echo -n -s "$gear$orange2 "["$ppwd"]"$orange1@$orange0$host$normal$orange3::$ctime $git_info$pstatus $battery_state $normal$arrow "

end
