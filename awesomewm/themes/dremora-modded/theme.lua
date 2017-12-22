--[[

     Dremora Awesome WM theme 2.0
     github.com/lcpz

--]]

local gears   = require("gears")
local lain    = require("lain")
local naughty = require("naughty")
local awful   = require("awful")
local wibox   = require("wibox")
local vici    = require("vicious")
local os      = { getenv = os.getenv }

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/dremora-modded"
theme.wallpaper                                 = theme.dir .. "/wall.png"
theme.font                                      = "lucy tewii 10"
theme.taglist_font                              = "lucy tewii 10"
theme.fg_normal                                 = "#747474"
theme.fg_focus                                  = "#DDDCFF"
theme.bg_normal                                 = "#201e1e"
theme.bg_focus                                  = "#201e1e"
theme.fg_urgent                                 = "#CC9393"
theme.bg_urgent                                 = "#2A1F1E"
theme.border_width                              = "2"
theme.border_normal                             = "#201e1e"
theme.border_focus                              = "#292929"
theme.titlebar_bg_focus                         = "#292929"
theme.taglist_fg_focus                          = "#dddcff"
theme.taglist_bg_focus                          = "#121212"
theme.menu_height                               = 16
theme.menu_width                                = 130
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.awesome_icon                              = theme.dir .."/icons/awesome.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = 5
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

awful.util.tagnames   = { "1", "2", "3", "4", "5" }

local markup     = lain.util.markup
local separators = lain.util.separators
local white      = theme.fg_focus
local gray       = "#858585"

-- Textclock
local mytextclock = wibox.widget.textclock(
    markup(gray, "<span font='Wuncon Siji'></span> %a") .. 
    markup(white, " %d ") .. 
    markup(gray, "%b ") ..  
    markup(white, "%I:%M %p")
)
mytextclock.font = theme.font

-- Calendar
lain.widget.calendar({
    attach_to = { mytextclock },
    notification_preset = {
        font = "lucy tewii 9",
        fg   = white,
        bg   = theme.bg_normal
}})

--[[ Mail IMAP check
-- commented because it needs to be set before use
local mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    notification_preset = { fg = white }
    settings = function()
        mail  = ""
        count = ""

        if mailcount > 0 then
            mail = "Mail "
            count = mailcount .. " "
        end

        widget:set_markup(markup.font(theme.font, markup(gray, mail) .. markup(white, count)))
    end
})
--]]

-- MPD
theme.mpd = lain.widget.mpd({
    settings = function()
        mpd_notification_preset.fg = white
        artist = mpd_now.artist .. " "
        title  = mpd_now.title  .. " "

        if mpd_now.state == "pause" then
            artist = "mpd "
            title  = "paused "
        elseif mpd_now.state == "stop" then
            artist = ""
            title  = ""
        end

        widget:set_markup(markup.font(theme.font, markup(gray, artist) .. markup(white, title)))
    end
})

-- /home fs
theme.fs = lain.widget.fs({
    partition = "/home",
    options = "--exclude-type=tmpfs",
    notification_preset = { fg = white, bg = theme.bg_normal, font = "Misc Tamsyn 10.5" },
    settings  = function()
        fs_header = ""
        fs_p      = ""

        if tonumber(fs_now.used) >= 90 then
            fs_header = "Hdd "
            fs_p      = fs_now.used
        end

        widget:set_markup(markup.font(theme.font, 
            markup(gray, fs_header) .. 
            markup(white, fs_p)
        ))
    end
})

-- Battery
local bat = lain.widget.bat({
    timeout = 2,
    settings = function()
        bat_p      = tonumber(bat_now.perc)
        status     = bat_now.status -- "Discharging", "Charging", "Full"

        if status == "Discharging" then
            if bat_p <= 10 then
                bat_header = "" --e242
            elseif bat_p <= 20 then
                bat_header = ""
            elseif bat_p <= 30 then
                bat_header = ""
            elseif bat_p <= 40 then
                bat_header = ""
            elseif bat_p <= 50 then
                bat_header = ""
            elseif bat_p <= 60 then
                bat_header = ""
            elseif bat_p <= 70 then
                bat_header = ""
            elseif bat_p <= 80 then
                bat_header = ""
            elseif bat_p <= 90 then
                bat_header = ""
            elseif bat_p <= 100 then
                bat_header = ""
            end
        elseif status == "Charging" then
            bat_header = ""
        elseif status == "Full" then
            bat_header = ""
        end

        widget:set_markup(markup.font(theme.font, 
            markup(gray, "<span font='Wuncon Siji'>" .. bat_header .. "</span> ") .. 
            markup(white, bat_p .. " ") 
        ))
    end
})

-- ALSA volume
theme.volume = lain.widget.alsa({
    --togglechannel = "IEC958,3",
    settings = function()
        header = "Vol "
        vol    = tonumber(volume_now.level)

        if volume_now.status == "off" then
            vol = "M"
            header = ""
        else
            if vol == 0 then
                header = ""
            else
                header = ""
            end
        end


        widget:set_markup(markup.font(theme.font, 
            markup(gray, "<span font='Wuncon Siji'>" .. header .. "</span> ") .. 
            markup(white, vol .. " ")
        ))
    end
})

-- Weather
theme.weather = lain.widget.weather({
    city_id = 2643743, -- placeholder (London)
    notification_preset = { fg = white }
})

-- CPU
local cpu = lain.widget.cpu({
    settings = function()
        cpu_header = "<span font='Wuncon Siji'></span> "
        cpu_p = cpu_now.usage .. " "
        widget:set_markup(markup.font(theme.font, 
            markup(gray, cpu_header) .. 
            markup(white, cpu_p)
        ))
    end
})

-- Memory
local mem = lain.widget.mem({
    settings = function()
        mem_header = "<span font='Wuncon Siji'></span> "
        mem_p = mem_now.perc .. " "
        widget:set_markup(markup.font(theme.font, 
            markup(gray, mem_header) ..
            markup(white, mem_p)
        ))
    end
})

-- Menu
local menu = wibox.widget.textbox(
    "<span font='Wuncon Siji'></span> "
)

menu:connect_signal("mouse::enter", function(c)
    c.markup = "<span font='Wuncon Siji' color='white'></span> "
end)

menu:connect_signal("mouse::leave", function(c)
    c.markup = "<span font='Wuncon Siji'></span> "
end)

menu:connect_signal("button::release", function(c)
    awful.util.mymainmenu:toggle()
end)

-- nmcli
local nmcli_widget = awful.widget.watch(
    { awful.util.shell, "-c", "nmcli -g ACTIVE,IN-USE,DEVICE,SSID,SIGNAL dev wifi" }, 2, 
      function(widget, stdout) 
        local wifi_now = {}
    
        -- Wifi is connected using an nmcli profile if a
        -- row in the stdout list with "yes" in the ACTIVE column.
        -- Only one connection may be active at a time.
        if stdout:match("(yes): ?*?:") then
            wifi_now.status = "connected"
        else
            wifi_now.status = "disconnected"
        end

        -- If no nmcli connection is active, display the top connection
        -- from the list, which have the highest signal strength. Otherwise,
        -- show the information from the active connection.
        if wifi_now.status == "disconnected" then
            wifi_now.device = stdout:match("^.-:.-:(.-):") or "N/A"
            wifi_now.ssid   = stdout:match("^.-:.-:.-:(.-):") or "N/A"
            wifi_now.signal = stdout:match("^.-:.-:.-:.-:(%d+)") or "N/A"
        else
            wifi_now.device = stdout:match("yes:%*:(.-):") or "N/A"
            wifi_now.ssid   = stdout:match("yes:%*:.-:(.-):") or "N/A"
            wifi_now.signal = stdout:match("yes:%*:.-:.-:(%d+)") or "N/A"
        end

        -- Use icon to show the signal.
        local signal_label = ""
        local signal_num = tonumber(wifi_now.signal)
        if signal_num <= 20 then
            signal_label = ""
        elseif signal_num <= 40 then
            signal_label = ""
        elseif signal_num <= 60 then
            signal_label = ""
        elseif signal_num <= 80 then
            signal_label = ""
        else
            signal_label = ""
        end

        -- customize here
        widget:set_markup(markup.font(theme.font, 
            markup(white, "<span font='Wuncon Siji'>" .. signal_label .. "</span> ") ..
            markup(gray, wifi_now.ssid .. " ")
        ))
    end
)

-- Separators
local first     = wibox.widget.textbox('<span font="Misc Tamsyn 4"> </span>')
local arrl_pre  = separators.arrow_right("alpha", "#1A1A1A")
local arrl_post = separators.arrow_right("#1A1A1A", "alpha")
local pad       = wibox.widget.textbox(" ")

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ 
        position = "top", 
        screen = s, 
        height = 20, 
        bg = theme.bg_normal, 
        fg = theme.fg_normal 
    })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            pad,
            menu,
            layout = wibox.layout.fixed.horizontal,
            first,
            s.mytaglist,
            arrl_pre,
            s.mylayoutbox,
            arrl_post,
            s.mypromptbox,
            first,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            pad,
            first,
            nmcli_widget,
            cpu.widget,
            mem.widget,
            bat.widget,
            theme.volume.widget,
            mytextclock,
            pad,
        },
    }
end

return theme
