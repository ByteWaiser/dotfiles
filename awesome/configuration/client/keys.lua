local awful = require('awful')
require('awful.autofocus')
local modkey = require('configuration.keys.mod').modKey
local altkey = require('configuration.keys.mod').altKey

local clientKeys =
  awful.util.table.join(
  awful.key(
    {modkey},
    'f',
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    {description = 'toggle fullscreen', group = 'client'}
  ),
  awful.key(
    {modkey, 'Shift'},
    'q',
    function(c)
      c:kill()
    end,
    {description = 'close', group = 'client'}
  ),
  awful.key(
    {modkey},
    's',
    function(c)
        if c.floating then
            c.floating = false
            c.ontop = false
        else
            c.floating = true
            c.ontop = true
            s = c.screen.geometry
            c.width = 1366/2
            c.height = 768/2
            c.x = (s.width - c.width)/2
            c.y = (s.height - c.height)/2
        end
    end,
    {description = 'close', group = 'client'}
  )
)

return clientKeys
