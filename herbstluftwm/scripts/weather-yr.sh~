#!/bin/zsh
#
# Copyright (C) 2013-2015 Daniel Sandman <revoltism@gmail.com>
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


##  1 = Clear sky
##  2 = Fair
##  3 = Partly cloudy
##  4 = Cloudy
##  5 = Rain showers
##  6 = Rain showers and thunder
##  7 = Sleet showers
##  8 = Snow showers
##  9 = Rain
## 10 = Heavy rain
## 11 = Heavy rain and thunder
## 12 = Sleet
## 13 = Snow
## 15 = Fog
## 22 = Rain and thunder
## 24 = Light rain showers and thunder
## 25 = Heavy rain showers and thunder
## 30 = Light rain and thunder
## 40 = Light rain showers
## 41 = Heavy rain showers
## 42 = Light sleet showers
## 44 = Light snow showers
## 45 = Heavy snow showers
## 46 = Light rain
## 47 = Light sleet
## 48 = Heavy sleet
## 49 = Light snow
## 50 = Heavy snow

#declare -a fcasts
#declare -a wdates

wurl="http://www.yr.no/place/Sweden/Norrbotten/Ala_Lombolo/forecast.xml"
witr="3" # how many forcasts to show


## Do not change the below lines ##

wdata=$(curl -s $wurl)

winfo=$(echo $wdata | awk -F'="|"' '/(temperature|symbol)/{print $4}')
wdate=$(echo $wdata | awk -F'[T ]' '/Valid at/{print $13}')

#We want the new-line to remain
old_ifs=${IFS}
IFS=$'
'

for i in $(awk 'ORS=NR%2?",":"\n"' <<<"$winfo" | awk -F"," '{print $2"C",$1}');
do
	case "$(cut -d' ' -f2 <<<$i)" in
		1|2) fcast=$(awk 'sub(/C.*/, "°C \\u2600")' <<<$i) ;; # Sunny
		3|4) fcast=$(awk 'sub(/C.*/, "°C \\u2601")' <<<$i) ;; # Clody
		5|9|10|40|41|46) fcast=$(awk 'sub(/C.*/, "°C \\u2602")' <<<$i) ;; # Rainy
		6|11|22|24|25|30) fcast=$(awk 'sub(/C.*/, "°C \\u2602\\u26a1")' <<<$i) ;; # Thunder
		7|12|42|47|48) fcast=$(awk 'sub(/C.*/, "°C \\u2592")' <<<$i) ;; # sleet
		15) fcast=$(awk 'sub(/C.*/, "°C \\u2636")' <<<$i) ;; # fog
		8|13|44|45|49|50) fcast=$(awk 'sub(/C.*/, "°C \\u2744")' <<<$i) ;; # snow
		*) echo "n/a ($i)" ;;
	esac

	fcasts+=( $fcast )
done

while read
do
	wdates+=( "${REPLY[@]:0:5} /" )
done < <(echo $wdate)

IFS=${old_ifs}

# Make the forcasts and date output correct
echo $(paste -d' ' <(printf "%s\n" "${fcasts[@]:0:$witr}") <(printf "%s\n" "${wdates[@]:0:$witr}"))

