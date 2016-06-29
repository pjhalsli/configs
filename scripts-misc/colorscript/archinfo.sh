USER=`whoami`
KERNEL=`uname -r`
OS=`hostnamectl status | awk 'NR==7{print $3,$4}'`
HOST=`hostnamectl status | awk 'NR==1{print $3}'`
ROOT_TOT=`df -h | awk 'NR==2{print $2}' | sed 's/G//g'`
ROOT_OCCUPIED=`df -h | awk 'NR==2{print $3}' | sed 's/G//g'`
PACKAGES=`pacman -Qq | wc -l`
CPU=`echo -e : $(cat /proc/cpuinfo | awk 'NR==5{$1=$2=$3="";print}')`
CONNECTION=`[[ -x /usr/bin/iwgetid ]] && echo -e $(iwgetid -r) || echo "missing iw package"`
RES="\033[0m"
ORANG="\033[0;33m"
echo -e "${ORANG}User${RES} : $USER"
echo -e "${ORANG}Host${RES} : $HOST"
echo -e "${ORANG}OS${RES} : $OS"
echo -e "${ORANG}Kernel${RES} : $KERNEL"
echo -e "${ORANG}Cpu${RES} $CPU"
echo -e "${ORANG}Root${RES} : $ROOT_OCCUPIED/$ROOT_TOT GB"
echo -e "${ORANG}Packages${RES} : $PACKAGES"
echo -e "${ORANG}Term${RES} : $(echo $TERM)"
echo -e "${ORANG}Shell${RES} : $(echo $SHELL)"
echo -e "${ORANG}Wifi${RES} : $CONNECTION"
echo -e "${ORANG}Editor${RES} : $(echo $EDITOR)"
