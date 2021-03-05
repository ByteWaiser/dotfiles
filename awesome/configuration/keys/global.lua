local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup").widget

local modkey = require("configuration.keys.mod").modKey
local altkey = require("configuration.keys.mod").altKey
local apps = require("configuration.apps")

function poweroff_command()
    awful.spawn.with_shell("poweroff")
    awful.keygrabber.stop(_G.exit_screen_grabber)
end

local globalKeys = awful.util.table.join(
    awful.key({modkey}, 'z', hotkeys_popup.show_help,
    {description = "show help", group="awesome"}),
    awful.key({modkey}, 'Tab', awful.tag.history.restore, 
    {description = "go back", group="tag"}),
    awful.key({modkey}, 'Right', function() awful.client.focus.global_bydirection("right") end,
    {description = "focus right client", group="client"}),
    awful.key({modkey}, 'Left', function() awful.client.focus.global_bydirection("left") end,
    {description = "focus left client", group="client"}),
    awful.key({modkey}, 'Up', function() awful.client.focus.global_bydirection("up") end,
    {description = "focus up client", group="client"}),
    awful.key({modkey}, 'Down', function() awful.client.focus.global_bydirection("down") end,
    {description = "focus down client", group="client"}),
    awful.key({modkey}, 'l', function() awful.client.focus.global_bydirection("right") end,
    {description = "focus right client", group="client"}),
    awful.key({modkey}, 'h', function() awful.client.focus.global_bydirection("left") end,
    {description = "focus left client", group="client"}),
    awful.key({modkey}, 'k', function() awful.client.focus.global_bydirection("up") end,
    {description = "focus up client", group="client"}),
    awful.key({modkey}, 'j', function() awful.client.focus.global_bydirection("down") end,
    {description = "focus down client", group="client"}),
    awful.key({modkey}, 'r', function() _G.awesome.spawn(apps.default.rofi) end, 
    {description = "show rofi menu", group="awesome"}),
    awful.key({modkey, "Control"}, 'p', function() _G.awesome.spawn(apps.default.lock) end, 
    {description = "Lock the screen", group="awesome"}),

    -- Programs
    awful.key({modkey}, 'Print', function() awful.util.spawn_with_shell(apps.default.region_screenshot) end,
    {description = "Area screenshot", group="screen"}),
    awful.key({modkey, "Shift"}, 'Print', function() awful.util.spawn_with_shell(apps.default.screenshot) end,
    {description = "All screenshot", group="screen"}),
    awful.key({modkey}, 'F1', function() awful.util.spawn(apps.default.browser) end,
    {description = "Open browser", group="launcher"}),
    awful.key({modkey}, 'F2', function() awful.util.spawn(apps.default.files) end,
    {description = "Open file manager", group="launcher"}),
    awful.key({modkey}, 'F3', function() awful.util.spawn("obsidian") end,
    {description = "Obsidian", group="launcher"}),
    awful.key({modkey}, 'F4', function() awful.util.spawn("notion-app") end,
    {description = "Notion", group="launcher"}),

    -- Standard Programs
    awful.key({modkey}, 'Return', function() awful.util.spawn(apps.default.terminal) end,
    {description = "Open a terminal", group="launcher"}),
    awful.key({modkey, "Control"}, 'r', _G.awesome.restart,
    {description = "reload awesome", group="awesome"}),
    awful.key({modkey, "Control"}, 'Escape', _G.awesome.quit,
    {description = "quit awesome", group="awesome"}),
    
    -- X keys
    awful.key({}, 'XF86MonBrightnessUp', function() awful.spawn('xbacklight -inc 10') end,
    {description = '+10% brighness', group = 'hotkeys'}),
    awful.key({}, 'XF86MonBrightnessDown', function() awful.spawn('xbacklight -dec 10') end,
    {description = '-10% brighness', group = 'hotkeys'}),
    awful.key({}, 'XF86AudioRaiseVolume', function() awful.spawn.easy_async('amixer -D pulse sset Master 5%+', function() _G.update_volume() end) end, 
    {description = 'volume up', group = 'hotkeys'}),
    awful.key({}, 'XF86AudioLowerVolume', function() awful.spawn.easy_async('amixer -D pulse sset Master 5%-', function() _G.update_volume() end) end,
    {description = 'volume down', group = 'hotkeys'}),
    awful.key({}, 'XF86AudioMute', function() awful.spawn('amixer -D pulse sset Master toggle', function() _G.update_volume() end) end,
    {description = 'toggle mute', group = 'hotkeys'}),
    awful.key({}, 'XF86AudioPlay', function() awful.spawn('playerctl play-pause') end,
    {description = 'play/pause song', group = 'hotkeys'}),
    awful.key({}, 'XF86AudioStop', function() awful.spawn('playerctl stop') end,
    {description = 'stop song', group = 'hotkeys'}),
    awful.key({}, 'XF86AudioNext', function() awful.spawn('playerctl next') end,
    {description = 'next song', group = 'hotkeys'}),
    awful.key({}, 'XF86AudioPrev', function() awful.spawn('playerctl prev') end,
    {description = 'previous song', group = 'hotkeys'})
)


-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 10 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = 'view tag #', group = 'tag'}
        descr_toggle = {description = 'toggle tag #', group = 'tag'}
        descr_move = {
            description = 'move focused client to tag #',
            group = 'tag'
        }
        descr_toggle_focus = {
            description = 'toggle focused client on tag #',
            group = 'tag'
        }
    end
    globalKeys = awful.util.table.join(globalKeys, -- View tag only.
    awful.key({modkey}, '#' .. i + 9, function()
        --local screen = awful.screen.focused()
        local tag = root.tags()[i]
        local screen = tag.screen
        awful.screen.focus(screen)
        if tag then tag:view_only() end
    end, descr_view), -- Toggle tag display.
    awful.key({modkey, 'Control'}, '#' .. i + 9, function()
        --local screen = awful.screen.focused()
        local tag = root.tags()[i]
        if tag then awful.tag.viewtoggle(tag) end
    end, descr_toggle), -- Move client to tag.
    awful.key({modkey, 'Shift'}, '#' .. i + 9, function()
        local tag = root.tags()[i]
        if _G.client.focus then
            if tag then _G.client.focus:move_to_tag(tag) end
        end
    end, descr_move), -- Toggle tag on focused client.
    awful.key({modkey, 'Control', 'Shift'}, '#' .. i + 9, function()
        local tag = root.tags()[i]
        if _G.client.focus then
            if tag then _G.client.focus:toggle_tag(tag) end
        end
    end, descr_toggle_focus))
end

return globalKeys
