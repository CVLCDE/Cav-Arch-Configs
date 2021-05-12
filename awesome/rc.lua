--       █████╗ ██╗    ██╗███████╗███████╗ ██████╗ ███╗   ███╗███████╗
--      ██╔══██╗██║    ██║██╔════╝██╔════╝██╔═══██╗████╗ ████║██╔════╝
--      ███████║██║ █╗ ██║█████╗  ███████╗██║   ██║██╔████╔██║█████╗
--      ██╔══██║██║███╗██║██╔══╝  ╚════██║██║   ██║██║╚██╔╝██║██╔══╝
--      ██║  ██║╚███╔███╔╝███████╗███████║╚██████╔╝██║ ╚═╝ ██║███████╗
--      ╚═╝  ╚═╝ ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝



-- ===================================================================
-- Standard awesome libraries
-- ===================================================================
pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")




-- ===================================================================
-- Error Handling
-- ===================================================================
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)


-- ===================================================================
-- Variable Definitions
-- ===================================================================
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"


-- ===================================================================
-- Themes
-- ===================================================================
local themes = {
	"default/theme.lua", -- 1
}

-- change this number to use the corresponding theme
local theme = themes[1]
local theme_config_dir = gears.filesystem.get_themes_dir() 
-- beautiful.init('/home/cav-arch/.config/awesome/themes/pro-dark/theme.lua')
beautiful.init('/home/cav-arch/.config/awesome/themes/default/theme.lua')


-- ===================================================================
-- Layouts
-- ===================================================================
local layouts_config_dir = 'initialization/layouts'
local layouts = require(layouts_config_dir)

-- ===================================================================
-- Wibar
-- ===================================================================
local wibar_config_dir = 'initialization/wibar'
local wibar = require(wibar_config_dir)


-- ===================================================================
-- Rules
-- ===================================================================
local rules_config_dir = 'initialization/rules'
local rules = require(rules_config_dir)


-- ===================================================================
-- Titlebars
-- ===================================================================
local titlebars_config_dir = 'initialization/titlebars'
local titlebars = require(titlebars_config_dir)


-- ===================================================================
-- Notifications
-- ===================================================================
local notifications_config_dir = 'initialization/notifications'
local notifications = require(notifications_config_dir)


-- ===================================================================
-- Tags
-- ===================================================================
local tags_config_dir = 'initialization/tags'
local tags = require(tags_config_dir)


-- ===================================================================
-- Key Bindings
-- ===================================================================
local keys_config_dir = 'initialization/keys'
local keys = require(keys_config_dir)


-- ===================================================================
-- Custom Changes
-- ===================================================================
-- Change the size of gaps between windows 
beautiful.useless_gap = 5
