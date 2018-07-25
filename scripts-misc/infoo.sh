f=3 b=4
for j in f b; do
  for i in {0..7}; do
    printf -v $j$i %b "\e[${!j}${i}m"
  done
done
d=$'\e[1m'
t=$'\e[0m'
v=$'\e[7m'

gtkrc="$HOME/.gtkrc-2.0"
GtkTheme=$( grep "gtk-theme-name" "$gtkrc" | cut -d\" -f2 )
GtkIcon=$( grep "gtk-icon-theme-name" "$gtkrc" | cut -d\" -f2 )
GtkFont=$( grep "gtk-font-name" "$gtkrc" | cut -d\" -f2 )

# Wallpaper set by feh
#Wallpaper=$(cat ~/.fehbg | cut -c 16-70)

# Time and date
time=$( date "+%H.%M")
date=$( date "+%a %d %b" )

# OS
OS=$(uname -r)
dist=$(cat /etc/*-release | grep -i name | cut -d'=' -d'"' -f2 | sed -n 1p)
bit=$(uname -m)

# WM version
wm=$(wmctrl -m | grep -i name | awk '{print $2}')

# Other
UPT=`uptime | awk -F'( |,)' '{print $2}' | awk -F ":" '{print $1}'`
uptime=$(uptime | sed 's/.*up \([^,]*\), .*/\1/')
uptime2=$(uptime | sed -nr 's/.*\s+([[:digit:]]{1,2}):[[:digit:]]{2},.*/\1/p')
size=$(df | grep '^/dev/[hs]d' | awk '{s+=$2} END {printf("%.0f\n", s/1048576)}')
use=$(df | grep '^/dev/[hs]d' | awk -M '{s+=$3} END {printf("%.0f\n", s/1048576)}')
gb=$(echo "G")
pac=$(pacman -Q|wc -l)
COUNT=$(cat /proc/cpuinfo | grep 'model name' | sed -e 's/.*: //' | wc -l)
cpu=$(lscpu | grep 'Model name' | awk -F ':' '{print $2}' | cut -c13-40)
#laptop=$(dmidecode | grep Product)
lap1=$(cat /sys/class/dmi/id/sys_vendor)
lap2=$(cat /sys/class/dmi/id/product_name)
vga=$(lspci | grep -i vga | cut -c62-75)
memkb=$(grep MemTotal /proc/meminfo | awk '{print $2}')
ram=$(expr $memkb / 1024)

cat << EOF

 ╔════╗	$f0 OS    » $f1$d$dist $bit
 ║██  ║	$f0 WM    » $f1$d$wm
 ║  ██║
 ║██  ║	$f0 Theme » $f1$d$GtkTheme
 ║  ██║	$f0 Icon  » $f1$d$GtkIcon
 ║██  ║	
 ║  ██║	$f0 RAM   » $f1$d$ram MB
 ║██  ║	$f0 VGA   » $f1$d$vga
 ║  ██║
 ║██  ║	$f0 Machine Description
 ║  ██║	$f0 $lap1 $lap2
 ║██  ║	$f0 with hardisk at $size GB
 ║  ██║
 ║██  ║	$f0 Additional Information
 ║  ██║	$f0 uptime » $f1$d$uptime
 ╚════╝	$f0 package » $f1$d$pac

EOF
