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

local battery_widget = wibox.widget {
    icon_widget,
    text_widget,
    layout = wibox.layout.fixed.horizontal,
}

local function bat_format(widget, args)
    local status = args[1]
    local batvalue = args[2]
    local icon = ""

    if (batvalue > 80) then
        icon = "battery-level-90"
    elseif (batvalue > 70) then
        icon = "battery-level-80"
    elseif (batvalue > 60) then
        icon = "battery-level-70"
    elseif (batvalue > 50) then
        icon = "battery-level-60"
    elseif (batvalue > 40) then
        icon = "battery-level-50"
    elseif (batvalue > 30) then
        icon = "battery-level-40"
    elseif (batvalue > 20) then
        icon = "battery-level-30"
    elseif (batvalue > 10) then
        icon = "battery-level-20"
    elseif (batvalue <= 10) then
        icon = "battery-level-10"
    end

    if (status == "+") then
        icon = icon .. "-charging"
    end

    icon = icon .. "-symbolic.svg"

    icon_widget.icon:set_image(PATH_TO_ICONS .. icon)

    return args[2] .. "%"
end

vicious.register(text_widget.text, vicious.widgets.bat, bat_format, 31, "BAT0")

return battery_widget
