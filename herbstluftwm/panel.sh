#!/usr/bin/env bash

#                                      ██
#  ██████                             ░██
# ░██░░░██  ██████   ███████   █████  ░██
# ░██  ░██ ░░░░░░██ ░░██░░░██ ██░░░██ ░██
# ░██████   ███████  ░██  ░██░███████ ░██
# ░██░░░   ██░░░░██  ░██  ░██░██░░░░  ░██
# ░██     ░░████████ ███  ░██░░██████ ███
# ░░       ░░░░░░░░ ░░░   ░░  ░░░░░░ ░░░ 
#


hc() { "${herbstclient_command[@]:-herbstclient}" "$@" ;}
monitor=${1:-0}
geometry=( $(herbstclient monitor_rect "$monitor") )
if [ -z "$geometry" ] ;then
    echo "Invalid monitor $monitor"
    exit 1
fi

# geometry has the format W H X Y
x=${geometry[0]}
y=${geometry[1]}
panel_width=${geometry[2]}
panel_height=16
#font="-*-fixed-medium-*-*-*-12-*-*-*-*-*-*-*"
#font="-*-tewi-medium-*-normal-*-17-120-*-*-*-*-*-1"
font2="-misc-fontawesome-medium-r-normal--0-0-0-8-p-0-iso10646-1"
#use xorg-xfontsel to pick a new font :3
#font="-*-terminesspowerline-medium-*-normal-*-10-*-*-*-*-*-*-*"
font="-Gohu-GohuFont-Medium-R-Normal--9-80-100-100-C-60-ISO10646-1"
#font2="-misc-stlarch-medium-r-normal--10-100-75-75-c-80-iso10646-1"
bgcolor=$(hc get frame_border_normal_color)
#selbg=$(hc get window_border_active_color)
selbg='#5f8787'

####
# Try to find textwidth binary.
# In e.g. Ubuntu, this is named dzen2-textwidth.
if which textwidth &> /dev/null ; then
    textwidth="textwidth";
elif which dzen2-textwidth &> /dev/null ; then
    textwidth="dzen2-textwidth";
else
    echo "This script requires the textwidth tool of the dzen2 project."
    exit 1
fi

####
# true if we are using the svn version of dzen2
# depending on version/distribution, this seems to have version strings like
# "dzen-" or "dzen-x.x.x-svn"
if dzen2 -v 2>&1 | head -n 1 | grep -q '^dzen-\([^,]*-svn\|\),'; then
    dzen2_svn="true"
else
    dzen2_svn=""
fi

if awk -Wv 2>/dev/null | head -1 | grep -q '^mawk'; then
    # mawk needs "-W interactive" to line-buffer stdout correctly
    # http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=593504
    uniq_linebuffered() {
      awk -W interactive '$0 != l { print ; l=$0 ; fflush(); }' "$@"
    }
else
    # other awk versions (e.g. gawk) issue a warning with "-W interactive", so
    # we don't want to use it there.
    uniq_linebuffered() {
      awk '$0 != l { print ; l=$0 ; fflush(); }' "$@"
    }
fi

####
# My Functions


hc pad $monitor $panel_height


{

	### Event generator ###
    # based on different input data (mpc, date, hlwm hooks, ...) this generates events, formed like this:
    #   <eventname>\t<data> [...]
    # e.g.
    #   date    ^fg(#efefef)18:33^fg(#909090), 2013-10-^fg(#efefef)29


    #mpc idleloop player &
    while true ; do
        # "date" output is checked once a second, but an event is only
        # generated if the output changed compared to the previous run.
        #date +$'date\t^fg(#efefef)%H:%M^fg(#909090), %Y-%m-^fg(#efefef)%d'
	date +$'date\t^fg(#efefef)%R, %d %b %Y'
	#date +$'date\t^fg(#efefef)%H:%M^fg(#909090), %a.^fg(#efefef)%d-^fg(#909090)%m-%Y'
	sleep 1 || break
    done > >(uniq_linebuffered) &
    childpid=$!
    hc --idle
    kill $childpid
} 2> /dev/null | {
    IFS=$'\t' read -ra tags <<< "$(hc tag_status $monitor)"
    visible=true
    date=""
    windowtitle=""
    while true ; do


	### Output ###
        # This part prints dzen data based on the _previous_ data handling run,
        # and then waits for the next event to happen.

        bordercolor="#26221C"
        separator="^bg()^fg($selbg)|"
        # draw tags
        for i in "${tags[@]}" ; do
            case ${i:0:1} in
                '#')
                    echo -n "^bg($selbg)^fg($selfg)"
                    ;;
                '+')
                    echo -n "^bg(#9CA668)^fg(#141414)"
                    ;;
                ':')
                    echo -n "^bg()^fg(#ffffff)"
                    ;;
                '!')
                    echo -n "^bg(#FF0675)^fg(#141414)"
                    ;;
                *)
                    echo -n "^bg()^fg(#ababab)"
                    ;;
            esac
            if [ ! -z "$dzen2_svn" ] ; then
                # clickable tags if using SVN dzen
                echo -n "^ca(1,\"${herbstclient_command[@]:-herbstclient}\" "
                echo -n "focus_monitor \"$monitor\" && "
                echo -n "\"${herbstclient_command[@]:-herbstclient}\" "
                echo -n "use \"${i:1}\") ${i:1} ^ca()"
 #               echo -n "use \"${i:1}\") ^fn(FontAwesome:size=8)${i:1}^fn() ^ca()"
            else
                # non-clickable tags if using older dzen
                echo -n " ${i:1} "
            fi
        done
        echo -n "$separator"
        echo -n "^bg()^fg() ${windowtitle//^/^^}"
        


	#battery
        bat=`cat /sys/class/power_supply/BAT0/capacity`
        batstat=`cat /sys/class/power_supply/BAT1/status`
        if (($batstat=='Charging'))
        then
        batico="^i(/usr/share/icons/stlarch_icons/ac10.xbm)"
        else
        batico="^i(/usr/share/icons/stlarch_icons/batt5full.xbm)"
        fi
	bat="^fg($xicon)$batico ^fg($xfg)$bat^fg($xext)%"



	# small adjustments
		cpu_temp=$(echo -n $(sensors | grep "Core" | cut -b 16-19))
		mpc_current=$(mpc current)
		right="^fg() ♫ ^fg() $mpc_current $separator^fg() $cpu_temp $separator^fg() $bat $separator^bg() $date $separator"
        right_text_only=$(echo -n "$right" | sed 's.\^[^(]*([^)]*)..g')

	
	# get width of right aligned text.. and add some space..
        width=$(txtw -f "$font" "$right_text_only  ")
        echo -n "^pa($(($panel_width - $width)))$right"
        echo


	### Data handling ###
        # This part handles the events generated in the event loop, and sets
        # internal variables based on them. The event and its arguments are
        # read into the array cmd, then action is taken depending on the event
        # name.http://vglive.no/#match=10013601
        # "Special" events (quit_panel/togglehidepanel/reload) are also handled
        # here.


	# wait for next event
        IFS=$'\t' read -ra cmd || break
        # find out event origin
        case "${cmd[0]}" in
            tag*)
                #echo "resetting tags" >&2
                IFS=$'\t' read -ra tags <<< "$(hc tag_status $monitor)"
                ;;
            date)
                #echo "resetting date" >&2
                date="${cmd[@]:1}"
                ;;
            quit_panel)
                exit
                ;;
            togglehidepanel)
                currentmonidx=$(hc list_monitors | sed -n '/\[FOCUS\]$/s/:.*//p')
                if [ "${cmd[1]}" -ne "$monitor" ] ; then
                    continue
                fi
                if [ "${cmd[1]}" = "current" ] && [ "$currentmonidx" -ne "$monitor" ] ; then
                    continue
                fi
                echo "^togglehide()"
                if $visible ; then
                    visible=false
                    hc pad $monitor 0
                else
                    visible=true
                    hc pad $monitor $panel_height
                fi
                ;;
            reload)
                exit
                ;;
            focus_changed|window_title_changed)
                windowtitle="${cmd[@]:2}"
                ;;
            #player)
            #    ;;
        esac
    done


    
    ### dzen2 ###
    # After the data is gathered and processed, the output of the previous block
    # gets piped to dzen2...or is it conky? If this ceases to work at any point
	# try changing 'conky' to '/dev/null'

} 2> conky | dzen2 -w $panel_width -x $x -y $y -fn "$font" -h $panel_height \
    -e 'button3=;button4=exec:herbstclient use_index -1;button5=exec:herbstclient use_index +1' \
    -ta l -bg "$bgcolor" -fg '#efefef'  &

sleep 1
stalonetray
 
