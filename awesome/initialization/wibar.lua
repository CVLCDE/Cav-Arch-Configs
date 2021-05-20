local awful = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")
local wibox = require("wibox")
local ruled = require("ruled")
local lain  = require("lain")

-- ===================================================================
-- Widgets
-- ===================================================================

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Wired Connection Widget
local net_widgets = require("widgets/net_widgets")
net_wired = net_widgets.indicator({
    interfaces  = {"enp2s0", "enp5s0", "and_another_one"},
    timeout     = 5
})

-- CPU Widget
local cpu_widget = require("widgets/cpu-widget/cpu-widget")
cpu_widget = cpu_widget({
    width = 70,
    step_width = 2,
    step_spacing = 0,
    color = '#434c5e'
})

-- RAM Widget
local ram_widget = require("widgets/ram-widget/ram-widget")
ram_widget = ram_widget({
    color_used = "#FF495F",
    color_free = "#434c5e",
    color_buf = "#161b22"
})

-- Logout Widget 
local logout_popup = require("widgets/logout-popup-widget/logout-popup")

-- Pacman Widget 
local pacman = require("widgets/pacmanwidget/init")
pacman = pacman.create(90)

-- Sep 
local markup = lain.util.markup
local sep = wibox.widget.textbox(
    markup.font("Terminus 3", " ") .. 
    markup.fontfg("Terminus 10.5", "#777777", "|") .. 
    markup.font("Terminus 5", " "
))


screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
        buttons = {
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc(-1) end),
            awful.button({ }, 5, function () awful.layout.inc( 1) end),
        }
    }

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                                            if client.focus then
                                                client.focus:move_to_tag(t)
                                            end
                                        end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                                            if client.focus then
                                                client.focus:toggle_tag(t)
                                            end
                                        end),
            awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
        }
    }

    -- Create a tasklist widget
     s.mytasklist = awful.widget.tasklist {
         screen  = s,
         filter  = awful.widget.tasklist.filter.currenttags,
         buttons = {
             awful.button({ }, 1, function (c)
                 c:activate { context = "tasklist", action = "toggle_minimization" }
             end),
             awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
             awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
         }
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ 
        position = "top", 
        screen = s,      
        ontop = true,
        visible = true,
        height = 25,
        width = s.geometry.width,
        bg = "#303030",
        type = "dock"
    })

    -- Add widgets to the wibox
    s.mywibox.widget = {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            pacman,
            sep,
            cpu_widget,
            sep,
            ram_widget,
            sep,
            net_wired,
            sep,
            mykeyboardlayout,
            sep,
            wibox.widget.systray(),
            mytextclock,
            sep,
            logout_popup.widget{},
            s.mylayoutbox,
        },
    }
end)

