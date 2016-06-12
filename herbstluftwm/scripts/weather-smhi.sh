#!/bin/zsh
#
# Copyright (C) 2013-2014 Daniel Sandman <revoltism@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#

## The temperature is fetched from the free Norwegian forcast service Yr.no. Change the wurl variable so it
## correspond with your location. Your ip can be blocked if you try to fetch the forecast too frequent. Use
## an interval longer than 10 minutes.


##  0 = no
##  1 = Snow
##  2 = Snow and rain
##  3 = Rain
##  4 = Drizzle
##  5 = Freezing rain
##  6 = Freezing drizzle

declare -a fcasts

wurl="http://opendata-download-metfcst.smhi.se/api/category/pmp2g/version/1/geopoint/lat/67.84/lon/20.25/data.json"

#winfo=$(curl -s $wurl | awk -F'":' '/(validTime|"t"|pcat)/{print $2}')
winfo=$(curl -s $wurl | awk -F'":' '/("t"|pcat)/{print $2}')

#We want the new-line to remain
old_ifs=${IFS}
IFS=$'
'

for i in $(awk 'ORS=NR%2?" ":"\n"' <<<"$winfo" | awk '{print $1"C",$2}' | sed 's/,//g');
do

	case "$(cut -d' ' -f2 <<<$i)" in
		0) fcast=$(awk 'sub(/C.*/, "°C \\u2600")' <<<$i) ;; # Sunny
		1|2) fcast=$(awk 'sub(/C.*/, "°C \\u2744")' <<<$i) ;; # snow
		#0) fcast=$(awk 'sub(/C.*/, "°C \\u2601")' <<<$i) ;; # Clody
		3|4|5|6) fcast=$(awk 'sub(/C.*/, "°C \\u2602")' <<<$i) ;; # Rainy
		#6|11|22|24|25|30) fcast=$(awk 'sub(/C.*/, "°C \\u2602\\u26a1")' <<<$i) ;; # Thunder
		#7|12|42|47|48) fcast=$(awk 'sub(/C.*/, "°C \\u2592")' <<<$i) ;; # sleet
		#15) fcast=$(awk 'sub(/C.*/, "°C \\u2636")' <<<$i) ;; # fog
		*) echo "n/a ($i)" ;;
	esac

	fcasts+=( $fcast )

done

IFS=${old_ifs}

echo ${fcasts[@]:0:3} # how many forcasts we want to show
#echo ${fcasts[@]:0:37} # how many forcasts we want to show
