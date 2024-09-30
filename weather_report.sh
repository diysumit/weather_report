#!/bin/bash

# using GNU grep
brew install grep

# exclude next line, remove from comment to make it interactive
#echo -e "Enter location name: "

#read location

#using fixed value, comment it out when using interactive mode
location=casablanca

#using ?2 returns current and next day data
curl -s wttr.in/$location?2 > latest_weather_report

#getting todays current temp
today=$(cat "`pwd`/latest_weather_report" | head -n 7 | ggrep -Po '\+\d+' | tr -d +)

#getting tomorrows temp at noon
forcasted=$(cat "`pwd`/latest_weather_report" | tail | ggrep -Po "\+\d+" | tr -d + | tail -n 3 | head -n 1)

echo "`date +"%Y %m %d"` $today $forcasted"

if ! test -f ./weather_report; then
      echo "year month day obs_tmp fc_tmp" > weather_report
fi

echo "`date +"%Y %m %d"` $today $forcasted" >> weather_report


cat weather_report

#printing complete data for next two days
curl wttr.in/$location
#adding this to crontab
#crontab -r 
#crontab -e
#to make is run every day at noon
#0 12 * * * /location_to_script/weather_report.sh