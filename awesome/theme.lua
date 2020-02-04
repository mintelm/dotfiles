local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local icon_path = gfs.get_configuration_dir() .. "/icons/"

local theme = {}

theme.font          = "noto sans display medium 8"
theme.clock_font    = "noto sans display bold 10"

theme.bg_normal     = "#3c3836"
theme.bg_focus      = "#282828"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_focus

theme.tasklist_bg_normal    = theme.bg_focus
theme.tasklist_bg_focus     = theme.bg_normal

theme.fg_normal     = "#ebdbb2"
theme.fg_focus      = "#fbf1c7"
theme.fg_urgent     = "#fbf1c7"
theme.fg_minimize   = "#fbf1c7"

theme.titlebar_bg       = "#282828"
theme.titlebar_bg_focus = "#3c3836"

theme.useless_gap   = dpi(7)
theme.border_width  = dpi(2)
theme.border_normal = theme.bg_focus
theme.border_focus  = "#fe8019"
theme.border_marked = "#91231c"
theme.fullscreen_hide_border = true
theme.maximized_hide_border  = true

theme.wibar_bg      = theme.bg_focus
theme.wibar_height  = 32

theme.bar_width = dpi(3)

theme.taglist_bg_focus = "#fe8019"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.taglist_bg_focus
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
theme.notification_font = "noto sans display medium 12"

theme.menu_height = dpi(15)

-- Define the image to load
theme.titlebar_close_button_normal = icon_path .. "close.png"
theme.titlebar_close_button_focus  = icon_path .. "close.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

theme.wallpaper = "/usr/share/backgrounds/psy_forest.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
