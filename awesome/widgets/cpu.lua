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

local cpu_widget = wibox.widget {
    icon_widget,
    text_widget,
    layout = wibox.layout.fixed.horizontal,
}

icon_widget.icon:set_image(icon_path .. "cpu.png")

local function cpu_format(widget, args)
    return string.sub(args[2], 1, 3) .. " GHz"
end

vicious.register(text_widget.text, vicious.widgets.cpufreq, cpu_format, 3, "cpu0")

return cpu_widget
