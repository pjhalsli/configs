#!/bin/sh

# START THE BEST MF WM IN THE WORLD

[Cursor]
xsetroot -cursor_name left_ptr
xbanish &

#xset +fp ~/.local/share/fonts

exec bspwm
