local vicious = require("vicious")
local wibox = require("wibox")

local gfs = require("gears.filesystem")
local icon_path = gfs.get_configuration_dir() .. "/icons/widgets/"

local icon_widget = wibox.widget {
    {
        id = "icon",
        widget = wibox.widget.imagebox,
    },
    layout = wibox.container.margin(_, 6, 0, 4, 4),
}

local text_widget = wibox.widget {
    {
        id = "text",
        widget = wibox.widget.textbox,
    },
    layout = wibox.container.margin(_, 6, 6, 4, 4),
}

local pkg_widget = wibox.widget {
    icon_widget,
    text_widget,
    layout = wibox.layout.fixed.horizontal,
}

icon_widget.icon:set_image(icon_path.. "pkg.png")

vicious.register(text_widget.text, vicious.widgets.pkg, "$1", 2309, "Arch")

return pkg_widget
