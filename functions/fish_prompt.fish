#create git functions
function git_current_branch
    echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function git_is_dirty
    echo (git status -s --ignore-submodules=dirty ^/dev/null)
end

function fish_prompt

    set -g last_status (echo "$status")


    # shortcuts for colors
    set -l cyan (set_color -o cyan)
    set -l yellow (set_color -o yellow)
    set -l magenta (set_color -o magenta)
    set -l red (set_color -o red)
    set -l blue (set_color -o blue)
    set -l normal (set_color normal)
    set -l usr (whoami)
    set -l ppwd (prompt_pwd)
    set -l gear $normal"⚙️"
    set -l host (hostname)
    set -l ctime (timedatectl | grep "Local time" | awk '{print $5}' | grep -o "..:..")

    if test -n (git_current_branch)
        set git_info $blue"("(git_current_branch)")"

        if test -n (git_is_dirty)
            set -l dirty "$red ✗"
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
    echo -n -s "$gear$cyan "["$ppwd"]"$normal@$yellow$host$normal::$ctime $git_info$pstatus$magenta>> "

end
