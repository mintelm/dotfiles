local vicious = require("vicious")
local wibox = require("wibox")

local gfs = require("gears.filesystem")
local icon_path = gfs.get_configuration_dir() .. "/icons/widgets/"

vicious.cache(vicious.widgets.net)

local down_icon_widget = wibox.widget {
    {
        id = "icon",
        widget = wibox.widget.imagebox,
    },
    layout = wibox.container.margin(_, 6, 0, 4, 4),
}

local down_text_widget = wibox.widget {
    {
        id = "text",
        widget = wibox.widget.textbox,
    },
    layout = wibox.container.margin(_, 6, 6, 4, 4),
}

local down_widget = wibox.widget {
    down_icon_widget,
    down_text_widget,
    layout = wibox.layout.fixed.horizontal,
}

down_icon_widget.icon:set_image(icon_path .. "net-down.png")

vicious.register(down_text_widget.text, vicious.widgets.net, "${wlp0s20f3 down_mb} MB/s", 2, nil)

local up_icon_widget = wibox.widget {
    {
        id = "icon",
        widget = wibox.widget.imagebox,
    },
    layout = wibox.container.margin(_, 6, 0, 4, 4),
}

local up_text_widget = wibox.widget {
    {
        id = "text",
        widget = wibox.widget.textbox,
    },
    layout = wibox.container.margin(_, 6, 6, 4, 4),
}

local up_widget = wibox.widget {
    up_icon_widget,
    up_text_widget,
    layout = wibox.layout.fixed.horizontal,
}

up_icon_widget.icon:set_image(icon_path .. "net-up.png")

vicious.register(up_text_widget.text, vicious.widgets.net, "${wlp0s20f3 up_mb} MB/s", 2, nil)

return {
    down_widget = down_widget,
    up_widget = up_widget,
}
