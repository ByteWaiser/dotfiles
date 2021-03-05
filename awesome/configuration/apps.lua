local filesystem = require("gears.filesystem")

local with_dpi = require("beautiful").xresources.apply_dpi
local get_dpi = require("beautiful").xresources.get_dpi
local rofi_command = "env /usr/bin/rofi -dpi " .. get_dpi() .. " -with " .. with_dpi(400) .. " -show run -theme " .. filesystem.get_configuration_dir() .. "/configuration/rofi.rasi -run-command '/bin/bash -c -i \"shopt -s expand_aliases; {cmd}\"'"

return {
    default = {
        terminal = "alacritty",
        rofi = rofi_command,
        lock = "i3lock-fancy",
        quake = "alacritty",
        
        browser = "chromium",
        editor = "nvim",
        files = "thunar",
        music = rofi_command,
        
        screenshot = "maim -B $HOME/Pictures/screenshot/$(date '+%y-%m-%d_%H.%M.%S').png",
        region_screenshot = "maim -sB | tee $HOME/Pictures/screenshot/$(date '+%y-%m-%d_%H.%M.%S').png | xclip -selection clipboard -t image/png"
    },

    run_on_start_up = {
        "~/.config/awesome/configuration/screens.sh",
        "compton --config " .. filesystem.get_configuration_dir() .. "/configuration/compton.conf", 
        "nm-applet --indicator",
        "nitrogen --restore"
    }
}
