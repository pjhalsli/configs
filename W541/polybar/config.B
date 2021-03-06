#                           
#            #      #           
#   ### ###  #  # # ###  ## ### 
#   # # # #  #  ### # # # # #   
#   ### ###  ##   # ### ### #   
#   #           ###          
#

[color]

trans = #00000000
white = #dddddd
black = #000000

## Iceberg
#bg = #161821
#fg = #C6C8D1

## Cherry
#bg = #161821
#fg = #BBBBBB

## Dracula
bg = 282a36
fg = f8f8f2


acolor = #FFFFFF
curgent = #EF5350
coccupied = #42A5F5

shade1 = #212121
shade2 = #2e3440
shade3 = #616161
shade4 = #757575
shade5 = #9E9E9E
shade6 = #BDBDBD
shade7 = #D4D4D4
shade8 = #EEEEEE
ashade8 = #2C2C2C

## Material Colors

red = #e53935
pink = #d81b60
purple = #8e24aa
deep-purple = #5e35b1
indigo = #3949ab
blue = #1e88e5
light-blue = #039be5
cyan = #00acc1
teal = #00897b
green = #43a047
light-green = #7cb342
lime = #c0ca33
yellow = #fdd835
amber = #ffb300
orange = #fb8c00
deep-orange = #f4511e
brown = #6d4c41
grey = #757575
blue-gray = #546e7a

;==========================================================

[bar/def]
width = 100%
height = 32
offset-x = 0%
offset-y = 0%
bottom = false
fixed-center = true
line-size = 1

override-redirect = true
wm-restack = bspwm

background = ${color.bg}
foreground = ${color.fg}

border-size = 0
;border-top-size = 1
;border-color = #B34F63

;==========================================================

font-0 = " Crisp Regular:pixelsize=8;2"
font-1 = "Iosevka Nerd Font:pixelsize=8;2"
font-2 = "icomoon:pixelsize=8;2"

;==========================================================

cursor-click = pointer
cursor-scroll = ns-resize

scroll-up = i3wm-wsnext
scroll-down = i3wm-wsprev

;== Module Location ========================================================

modules-left = arch battery xwindow
modules-center = bspwm
modules-right = mpd volume xbacklight wlan date powermenu
 
; xtra mods =    battery mail updates weather bitcoin

;== Modules ========================================================

[module/arch]
type = custom/text
content = 
;alt icons = 
content-padding = 2
content-background = ${color.bg}
content-foreground = ${color.fg}
click-left = rmenu_1
click-right = rmenu_wi_1


[module/xwindow]
type = internal/xwindow
label =  %title:0:25:...%
label-padding = 2
label-background = ${color.bg}
label-foreground = ${color.fg}


[module/bspwm]
type = internal/bspwm
pin-workspaces = false
enable-click = true
enable-scroll = true
format-padding = 1

ws-icon-0 = I;
ws-icon-1 = II;
ws-icon-2 = III;
ws-icon-3 = IV;
ws-icon-4 = V;
ws-icon-5 = VI;
ws-icon-6 = VII;
ws-icon-7 = VIII;
ws-icon-8 = IX;
ws-icon-9 = X;

icon-default = 

format = <label-state>
;format-background = ${color.bg}
label-background =${color.shade1}
label-focused = ●
label-occupied = ●
label-urgent = ●
label-empty = ●

label-empty-padding = 1
label-focused-padding = 1
label-urgent-padding = 1
label-occupied-padding = 1

label-empty-foreground = #444444
label-focused-foreground = #8BE9FD
label-urgent-foreground = #FF5555
label-occupied-foreground = #BD93F9


;==========================================================

[module/mpd]
type = internal/mpd
format-online = <toggle> <label-song> 
;format-online =  <label-song> 
;alt icons =   
format-online-foreground = ${color.fg}
format-online-background = ${color.bg}
format-online-padding = 2

icon-play = 喇
icon-pause = 

label-song-maxlen = 35
label-song-ellipsis = true

;==========================================================

[module/pkg]
type = custom/script
exec = updates.sh
format-background = ${color.bg}
format-padding = 2
tail = true


[module/battery]
type = internal/battery
full-at = 99
time-format = %H:%M
battery = BAT1
adapter = AC
format-charging = <animation-charging> <label-charging>
format-charging-background = ${color.bg}
format-charging-padding = 2
label-charging = %percentage%%
label-charging-background = ${color.bg}
format-discharging = <ramp-capacity> <label-discharging>
format-discharging-background = ${color.bg}
format-discharging-padding = 2
label-discharging = %percentage%% 
format-full = <label-full>
format-full-background = ${color.bg}
label-padding = 2
label-charging-padding = 2
format-full-prefix = " "
ramp-capacity-0 = 
ramp-capacity-1 = 
ramp-capacity-2 = 
ramp-capacity-3 = 
ramp-capacity-4 = 
ramp-capacity-5 = 
ramp-capacity-6 = 
ramp-capacity-7 = 
ramp-capacity-8 = 
ramp-capacity-9 = 

ramp-capacity-0-foreground = ${color.red}
ramp-capacity-1-foreground = ${color.red}
ramp-capacity-foreground   = ${color.fg}
bar-capacity-width = 10

animation-charging-0 = 
animation-charging-1 = 
animation-charging-2 = 
animation-charging-3 = 
animation-charging-4 = 
animation-charging-5 = 
animation-charging-6 = 

animation-charging-framerate = 750

[module/volume]
type = internal/alsa
format-volume = <ramp-volume> <label-volume>
format-volume-padding = 2
format-volume-background = ${color.bg}
format-volume-foreground = ${color.fg}
label-volume = %percentage%%
label-muted = "婢"
label-muted-background = ${color.bg}
label-muted-padding = 2

ramp-volume-0 = 奄
ramp-volume-1 = 奄
ramp-volume-2 = 奔
ramp-volume-3 = 奔
ramp-volume-4 = 墳
ramp-volume-5 = 墳
ramp-volume-6 = 墳



[module/xbacklight]
type = internal/xbacklight
format = <label>
format-foreground = ${color.fg}
format-background = ${color.bg}
;format-padding = 2
label = " %percentage%"
label-background = ${color.bg} 
label-padding = 2


[module/wlan]
type = internal/network
interface = wlp3s0
interval = 3.0
format-connected-background = ${color.bg}
format-padding = 2
tail = true
label-background =${color.shade3}

format-connected = <ramp-signal> <label-connected>
label-connected = %essid%
label-connected-background = ${color.bg}
;format-disconnected =
ramp-signal-0 =
label-connected-padding = 2


[module/date]
type = internal/date
interval = 30
label =  %time%
label-padding = 2
label-background = ${color.bg}
time =  %H:%M
time-alt =  %d-%m-%Y

[module/powermenu]
type = custom/text
content = 襤
content-padding = 2
content-background = ${color.bg}
content-foreground = ${color.fg}
click-left = pmenu_1
click-right = pmenu_1

;== EOF ========================================================

# vim: ft=sh
