local vicious = require("vicious")
local wibox = require("wibox")

local PATH_TO_ICONS = "/usr/share/icons/Papirus-Dark/symbolic/status/"

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
    layout = wibox.container.margin(_, 4, 6, 4, 4),
}

local pkgwatch_widget = wibox.widget {
    icon_widget,
    text_widget,
    layout = wibox.layout.fixed.horizontal,
}

icon_widget.icon:set_image(PATH_TO_ICONS .. "software-update-available-symbolic.svg")

vicious.register(text_widget.text, vicious.widgets.pkg, "$1", 2309, "Arch")

return pkgwatch_widget 
