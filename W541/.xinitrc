#!/bin/sh

# START THE BEST MF WM IN THE WORLD

[Cursor]
xsetroot -cursor_name left_ptr
xbanish &
#wal -R

exec bspwm
