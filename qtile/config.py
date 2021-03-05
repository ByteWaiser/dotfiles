from typing import List  # noqa: F401

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Screen
from libqtile.lazy import lazy
from libqtile.core.manager import Qtile

mod = "mod4"
terminal = "alacritty"

keys = [
    # Essentials
    Key(
        [mod], "Return", 
        lazy.spawn(terminal), 
        desc = "Launch terminal"
        ),

    Key(
        [mod, "shift"], "q", 
        lazy.window.kill(), 
        desc = "Kill focused window"
        ),

    Key(
        [mod, "control"], "r", 
        lazy.restart(), 
        desc = "Restart qtile"
        ),
    
    Key(
        [mod, "control"], "Escape", 
        lazy.shutdown(), 
        desc = "Shutdown qtile"
        ),
    
    Key(
        [mod], "d", 
        lazy.spawn("dmenu_run"),
        desc = "Spawn a command using rofi dmenu"
        ),

    # Audio Essentials
    Key(
        [], "XF86AudioRaiseVolume", 
        lazy.spawn("pactl set-sink-volume 0 +5%"),
        ),
    
    Key(
        [], "XF86AudioLowerVolume", 
        lazy.spawn("pactl set-sink-volume 0 -5%"),
        ),

    Key(
        [], "XF86AudioMute", 
        lazy.spawn("pactl set-sink-mute 0 toggle"),
        ),

    Key(
        [], "XF86AudioPlay", 
        lazy.spawn("mpc toggle")
        ),

    Key(
        [], "XF86AudioStop", 
        lazy.spawn("mpc stop")
        ),

    Key(
        [], "XF86AudioPrev", 
        lazy.spawn("mpc prev")
        ),

    Key(
        [], "XF86AudioNext", 
        lazy.spawn("mpc next")
        ),

    Key(
        [], "XF86MonBrightnessUp", 
        lazy.spawn("xbacklight +10%")
        ),

    Key(
        [], "XF86MonBrightnessDown", 
        lazy.spawn("xbacklight -10%")
        ),

    # Bsp Layout
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),

    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right()),

    Key([mod, "control"], "Up", lazy.layout.grow_up()),
    Key([mod, "control"], "Down", lazy.layout.grow_down()),
    Key([mod, "control"], "Left", lazy.layout.grow_left()),
    Key([mod, "control"], "Right", lazy.layout.grow_right()),
    
    Key([mod, "shift"], "n", lazy.layout.normalize()),
    Key([mod], "x", lazy.layout.toggle_split()),

    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "s", lazy.window.toggle_floating()),

    Key([mod], "Tab", lazy.screen.toggle_group()),
    

    # Apps
    Key([mod], "F1", lazy.spawn("brave")),
    Key([mod], "F2", lazy.spawn("code")),
    Key([mod], "F3", lazy.spawn("pcmanfm")),
    Key([mod], "F4", lazy.spawn(terminal + " -e ranger")),
    Key([mod], "F5", lazy.spawn(terminal + " -e ncmpcpp")),
    Key([mod], "F6", lazy.spawn("notion")),
]

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

groups = [Group(i) for i in "1234"]

for i, n in enumerate(groups):
    i += 1
    if i == 10:
        i = 0
    keys.extend([
        Key([mod], str(i), lazy.group[n.name].toscreen(),
            desc="Switch to group {}".format(n.name)),

        Key([mod, "shift"], str(i), lazy.window.togroup(n.name),
            desc="Switch to & move focused window to group {}".format(n.name)),
    ])

layouts = [
    layout.Bsp(fair=False, ratio=1),

    # layout.MonadTall(),
    # layout.TreeTab(),
]

widget_defaults = dict(
    font='RobotoMono Nerd Font Mono',
    fontsize=14,
    padding=2,
)
extension_defaults = widget_defaults.copy()

bar_size = 28
sep_size = 24
sep_pad = 0

left_square_sep = ""
right_square_sep = ""

black = "#000000"
purple = "#220022"
red = "#440000"
green = "#002222"

def squareBottomBar(left, right):
    return bar.Bar(
            [
                widget.GroupBox(hide_unused=True, disable_drag=True, highlight_method="line", fontsize=16, highlight_color=[green, green], this_current_screen_border=green, padding=8),

                widget.Spacer(),

                widget.TextBox(left, background=purple, foreground=black, fontsize=sep_size, padding=sep_pad),
                widget.TextBox(right, background=purple, foreground=black, fontsize=sep_size, padding=sep_pad),

                widget.TextBox(left, background=green, foreground=black, fontsize=sep_size, padding=sep_pad),
                widget.Memory(background=green),
                widget.TextBox(right, background=green, foreground=black, fontsize=sep_size, padding=sep_pad),

                widget.TextBox(left, background=red, foreground=black, fontsize=sep_size, padding=sep_pad),
                widget.Volume(background=red),
                widget.TextBox(right, background=red, foreground=black, fontsize=sep_size, padding=sep_pad),

                widget.TextBox(left, background=green, foreground=black, fontsize=sep_size, padding=sep_pad),
                widget.Battery(background=green, format="{char} {percent:2.0%}", charge_char="", discharge_char="", full_char="", unknown_char=""),
                widget.TextBox(right, background=green, foreground=black, fontsize=sep_size, padding=sep_pad),

                widget.TextBox(left, background=red, foreground=black, fontsize=sep_size, padding=sep_pad),
                widget.Clock(background=red, format='%d/%m/%Y'),
                widget.TextBox(right, background=red, foreground=black, fontsize=sep_size, padding=sep_pad),

                widget.TextBox(left, background=green, foreground=black, fontsize=sep_size, padding=sep_pad),
                widget.Clock(background=green, format='%a %H:%M'),
                widget.TextBox(right, background=green, foreground=black, fontsize=sep_size, padding=sep_pad),

                widget.Systray(background=purple),
            ],
            bar_size
        )

def squareTopBar(left, right):
    return bar.Bar(
            [
                widget.TextBox(left, background=purple, foreground=black, fontsize=sep_size, padding=sep_pad),
                widget.WindowName(bar.CALCULATED, background=purple),
                widget.TextBox(right, background=purple, foreground=black, fontsize=sep_size, padding=sep_pad),

                widget.TextBox(left, background=purple, foreground=black, fontsize=sep_size, padding=sep_pad),
                widget.TextBox(right, background=purple, foreground=black, fontsize=sep_size, padding=sep_pad),

                widget.Spacer(),

                widget.TextBox(left, background=purple, foreground=black, fontsize=sep_size, padding=sep_pad),
                widget.TextBox(right, background=purple, foreground=black, fontsize=sep_size, padding=sep_pad),

                widget.TextBox(left, background=green, foreground=black, fontsize=sep_size, padding=sep_pad),
                widget.Pacman(background=green, update_interval=3600*2, execute=terminal + " -e sudo pacman -Syu"),
                widget.TextBox(right, background=green, foreground=black, fontsize=sep_size, padding=sep_pad),

                widget.TextBox(left, background=red, foreground=black, fontsize=sep_size, padding=sep_pad),
                widget.Net(format="{down} ↓↑ {up}", background=red),
                widget.TextBox(right, background=red, foreground=black, fontsize=sep_size, padding=sep_pad),

                widget.TextBox(left, background=green, foreground=black, fontsize=sep_size, padding=sep_pad),
                widget.Mpd2(status_format="{title}", background=green),
                widget.TextBox(right, background=green, foreground=black, fontsize=sep_size, padding=sep_pad),
            ],
            bar_size,
        )


screens = [
    Screen(
        bottom = squareBottomBar(left_square_sep, right_square_sep),
        top = squareTopBar(left_square_sep, right_square_sep)
    ),
]

# Drag floating layouts.

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"