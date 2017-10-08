#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar
killall -q compton
killall -q dunst

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch def
polybar def &
dunst &
compton &