local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('theme.icons')
local volume, update_volume = require('widget.volume.volume-percentage') () 
    
local icon = wibox.widget {
    {
        {image = icons.volume_dark, widget = wibox.widget.imagebox},
        margins = dpi(6),
        layout = wibox.container.margin
    },
    bg = beautiful.primary.hue_200,
    widget = wibox.container.background
}

local volume_percentage_widget = wibox.container.background(volume)

local VolumePanel = function(s, offset)
    local offsetx = dpi(236)
    if offset == true then offsety = dpi(12) end
    local panel = wibox({
        ontop = false,
        screen = s,
        height = dpi(32),
        width = dpi(64),
        x = s.geometry.x + offsetx,
        y = s.geometry.y + offsety,
        stretch = false,
        bg = beautiful.primary.hue_900,
        fg = beautiful.fg_normal
    })

    panel:setup{
        layout = wibox.layout.fixed.horizontal,
        icon,
        volume_percentage_widget
    }


    panel:buttons(awful.util.table.join(
        awful.button({}, 1, 
            function()
                awful.spawn.easy_async("amixer -D pulse sset Master toggle", function(_) update_volume() end)
            end
        ),
        awful.button({}, 4, 
            function()
                awful.spawn.easy_async("amixer -D pulse sset Master 5%+", function(_) update_volume() end)
            end
        ),
        awful.button({}, 5, 
            function()
                awful.spawn.easy_async("amixer -D pulse sset Master 5%-", function(_) update_volume() end)
            end
        )

    ))

    return panel
end

return VolumePanel
