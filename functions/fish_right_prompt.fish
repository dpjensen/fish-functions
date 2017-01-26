
function bc_gradient

    #Some batteries can report >100%
    if test $argv -gt 100
        set -g factor 100
    else
        set -g factor (echo $argv)
    end

    #set -l strip_factor (echo $argv | grep -o "[0-9]*")
    set -l factor (echo "scale=2; $factor / 100" | bc)

    set -l rred ( echo "scale=2; (255 * (1-$factor)) + (0 * $factor)" | bc )
    set -l rgreen ( echo "scale=2; (0 * (1-$factor)) + (255 * $factor)" | bc )

    set -l rred (printf "%02x" (echo "$rred/1" | bc))
    set -l rgreen (printf "%02x" (echo "$rgreen/1" | bc))
    set -l rblue (echo "00")
    echo "$rred$rgreen$rblue"
end

function battery_info
        set -u battery_string
        set -l normal (set_color normal)
    for battery in (find /sys/class/power_supply/ -maxdepth 1 -name 'BAT*' -print)
        set -l b_percentage (cat $battery/capacity)
        set -l b_name (cat $battery/type)
        set -l b_color (set_color (bc_gradient $b_percentage))

        set -g battery_string (echo "$battery_string $b_name:$b_color$b_percentage%$normal")
    end
    echo $battery_string
end

function fish_right_prompt
    set -l green (set_color green)
    set -l red (set_color red)
    set -l blue (set_color blue)
    set -l normal (set_color normal)
    set -l voltage (echo -n "☇")
    set -l funct "𝜵 "
    set -l ctemp (math (cat /sys/devices/platform/coretemp.0/hwmon/*/temp1_input)/1000)
    set -l battery_state (battery_info)
    echo "$ctemp°C $voltage$battery_state"
end
