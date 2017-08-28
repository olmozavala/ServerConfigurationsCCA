#!/bin/bash

echo "Deleting old files..."
`rm -f /ServerData/GlobalHycomData/*.nc`

echo "Downloading new forecast..."
`python hycomDownload.py`
