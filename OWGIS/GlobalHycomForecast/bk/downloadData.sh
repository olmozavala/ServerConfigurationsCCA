#!/bin/bash

#echo "Deleting old files..."
#`rm -f /ServerData/GlobalHycomData/*.nc`

echo "Downloading new forecast..."
`/usr/bin/python /ServerScripts/GlobalHycomForecast/hycomDownload.py`

`ls -1 | grep -v 'Crack' | xargs rm -f`
