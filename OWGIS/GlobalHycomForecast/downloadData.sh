#!/bin/bash

#echo "Deleting old files..."
#`rm -f /ServerData/GlobalHycomData/*.nc`

echo "Downloading new forecast..."
#`/usr/bin/python /ServerScripts/GlobalHycomForecast/hycomDownload.py`

DATE=`date --date="1 day ago" +%Y%m%d`
COMMAND="ls -d -1 /ServerData/GlobalHycomData/* | grep -v '$DATE' | xargs rm -f"
echo "Removing files with: $COMMAND"
eval $COMMAND
