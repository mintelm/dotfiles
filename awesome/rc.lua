pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

local battery = require("awm-widgets.battery")

require("awful.autofocus")
require("awful.hotkeys_popup.keys")

awful.spawn.with_shell("~/.config/awesome/scripts/autorun.sh")

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}


-- {{{ Variable definitions
beautiful.init("/home/mario/.config/awesome/theme.lua")

terminal = "alacritty"
browser = "firefox"
explorer = "thunar"
calculator = "galculator"
editor = os.getenv("EDITOR") or "vi"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"

awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.fair,
}
-- }}}


-- {{{ Wibar
mytextclock = wibox.widget.textclock()
mytextclock.font = beautiful.clock_font

local taglist_buttons = gears.table.join(
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
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)

    awful.tag.add("", {
      icon              = awful.util.get_configuration_dir() .. "icons/tags/code-braces-colored.png",
      layout            = awful.layout.suit.tile,
      selected          = true,
      gap_single_client = true,
      screen            = s,
      expand            = "none",
    })
    awful.tag.add("", {
      icon              = awful.util.get_configuration_dir() .. "icons/tags/firefox-colored.png",
      layout            = awful.layout.suit.tile,
      gap_single_client = true,
      screen            = s,
      expand            = "none",
    })
    awful.tag.add("", {
      icon              = awful.util.get_configuration_dir() .. "icons/tags/text-file-colored.png",
      layout            = awful.layout.suit.tile,
      gap_single_client = true,
      screen            = s,
      expand            = "none",
    })
    awful.tag.add("", {
      icon              = awful.util.get_configuration_dir() .. "icons/tags/flask-colored.png",
      layout            = awful.layout.suit.tile,
      gap_single_client = true,
      screen            = s,
      expand            = "none",
    })

    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    s.mywibox = awful.wibar({ position = "top", screen = s, bg = beautiful.wibar_bg, height = beautiful.wibar_height})

    local vert_sep = wibox.widget {
        widget = wibox.widget.separator,
        orientation = "vertical",
        forced_width = 10,
        color = beautiful.fg_normal
    }

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            vert_sep,
        },
        -- Middle widgets
        s.mytasklist,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            vert_sep,
            wibox.widget.systray(),
            vert_sep,
            battery(),
            vert_sep,
            mytextclock,
            s.mylayoutbox,
        },
    }
end)
-- }}}


-- {{{ Key bindings
globalkeys = gears.table.join(
    -- General
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ "Mod1" }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
    awful.key({ modkey,           }, "m", function () awful.layout.inc( 1) end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "m", function () awful.layout.inc(-1) end,
              {description = "select previous", group = "layout"}),

    -- Standard programs
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open terminal", group = "launcher"}),
    awful.key({ modkey,           }, "w", function () awful.spawn(browser) end,
              {description = "open firefox", group = "launcher"}),
    awful.key({ modkey,           }, "e", function () awful.spawn(explorer) end,
              {description = "open fileexplorer", group = "launcher"}),
    awful.key({ modkey,           }, "c", function () awful.spawn(calculator) end,
              {description = "open calculator", group = "launcher"}),
    awful.key({ modkey },            "r",     function () awful.spawn("rofi -show run -theme gruvbox.rasi -lines 7") end,
              {description = "open prompt", group = "launcher"}),
    awful.key({ modkey,           }, "p", function () awful.spawn("scrot") end,
              {description = "take screenshot", group = "launcher"}),

    -- Sound
    awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer set Master 5%+") end,
              {description = "increase volume", group = "sound"}),
    awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer set Master 5%-") end,
              {description = "decrease volume", group = "sound"}),
    awful.key({ }, "XF86AudioMute", function () awful.util.spawn("amixer set Master toggle") end,
              {description = "(un)mute volume", group = "sound"}),

    -- Brightness
    awful.key({ }, "XF86MonBrightnessUp", function () awful.util.spawn("brightnessctl s 10%+") end,
              {description = "increase brightness", group = "screen"}),
    awful.key({ }, "XF86MonBrightnessDown", function () awful.util.spawn("brightnessctl s 10%-") end,
              {description = "decrease brightness", group = "screen"})
)

local function client_resize (key, c)
   if c == nil then
      c = client.focus
   end

   if c.floating then
      if     key == "Up"    then c:relative_move(0, 0, 0, -5)
      elseif key == "Down"  then c:relative_move(0, 0, 0, 5)
      elseif key == "Right" then c:relative_move(0, 0, 5, 0)
      elseif key == "Left"  then c:relative_move(0, 0, -5, 0)
      else
         return false
      end
   else
      if     key == "Up"    then awful.client.incwfact(-0.05)
      elseif key == "Down"  then awful.client.incwfact(0.05)
      elseif key == "Right" then awful.tag.incmwfact(0.05)
      elseif key == "Left"  then awful.tag.incmwfact(-0.05)
      else
         return false
      end
   end

   return true
end

-- client manipulation
clientkeys = gears.table.join(
    awful.key({ modkey }, "j", function () awful.client.focus.bydirection("down")
              if client.focus then client.focus:raise() end end,
              {description = "focus client underneath", group = "client"}),
    awful.key({ modkey }, "k", function () awful.client.focus.bydirection("up")
              if client.focus then client.focus:raise() end end,
              {description = "focus client above", group = "client"}),
    awful.key({ modkey }, "h", function () awful.client.focus.bydirection("left")
              if client.focus then client.focus:raise() end end,
              {description = "focus client to the left", group = "client"}),
    awful.key({ modkey }, "l", function () awful.client.focus.bydirection("right")
              if client.focus then client.focus:raise() end end,
              {description = "focus client to the right", group = "client"}),
    awful.key({ modkey, "Shift"   }, "h",     function () client_resize('Left') end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "j",     function () client_resize('Down') end,
              {description = "increase client height factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "k",     function () client_resize('Up')   end,
              {description = "decrease client height factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () client_resize('Right') end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "q",      function (c) c:kill() end,
              {description = "close", group = "client"}),
    awful.key({ modkey,           }, "space",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen() end,
              {description = "move to screen", group = "client"})
)

-- Bind all key numbers to tags.
for i = 1, 4 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"})
    )
end

-- Mouse Bindings
clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

root.keys(globalkeys)
-- }}}


-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    { rule_any = {
        class = {
          "Gpick",
          "Tor Browser",
        },
        role = {
          "pop-up",
        }
      }, properties = { floating = true }},
}
-- }}}


-- {{{ Signals
client.connect_signal("manage", function (c)
    c.maximized = false
    if not awesome.startup then
        awful.client.setslave(c)
    end
end)

-- Titlebar
client.connect_signal("request::titlebars", function(c)
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )
    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Titlebars only on floating windows
function dynamic_title(c)
    if ((c.floating or (c.first_tag ~= nil and c.first_tag.layout.name == "floating"))
    and not c.maximized)
    or (c.first_tag.layout.name == "floating" and c.maximized) then
        awful.titlebar.show(c)
    else
        awful.titlebar.hide(c)
    end
end

client.connect_signal("property::floating", function(c)
    if c.floating then
        awful.titlebar.show(c)
    else
        awful.titlebar.hide(c)
    end
end)

client.connect_signal("property::maximized", function(c)
    if c.first_tag ~= nil and c.first_tag.layout.name == "floating" then
        awful.titlebar.show(c)
    else
        awful.titlebar.hide(c)
    end
end)

tag.connect_signal("property::layout", function(t)
    local clients = t:clients()
    for k,c in pairs(clients) do
        dynamic_title(c)
    end
end)

client.connect_signal("tagged", dynamic_title)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

-- Draw border on focus
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- }}}
