#!/bin/bash

webhook=`cat webhook.txt`
template=`cat template.txt`
time_now=`date '+%Y-%m-%d %H:%M:%S'`

archive="/samba/WD_4TB/stuff/VID/yt/archive.txt"
reported="yt_reported.txt"

# Check if files are the same
cmp --silent $archive $reported && echo "[$time_now] Up to date!" && exit
echo "[$time_now] Not up to date, reporting news!"

# Set values
username="YT-Reporter"
main_message="Download report"
embed_title=""
embed_description="New downloads:"

# Get diff
for line in `comm -23 --nocheck-order $archive $reported`; do
  if [[ $line != *"youtube"* ]]; then
    embed_description="$embed_description\n* $line"
  fi
done

# Build payload
payload="${template/<main_message>/$main_message}"
payload="${payload/<username>/$username}"
payload="${payload/<embed_title>/$embed_title}"
payload="${payload/<embed_description>/$embed_description}"

# Send payload
echo "[$time_now] Sending:" $payload

curl --header "Content-Type: application/json" \
  --request POST \
  --data "$payload" \
  "$webhook"

# Update reported entries
cp $archive $reported
