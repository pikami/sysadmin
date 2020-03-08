#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Usage: $0 https://my.adobeconnect.com/video_id";
  exit 1
fi

valid='http[s:\/]+[a-zA-Z0-9.]+\/[a-zA-Z0-9]+$';
if [[ $1 =~ $valid ]]; then
  readarray -d / -t str_arr <<< "$1"
  id="$(echo -e "${str_arr[3]}" | tr -d '[:space:]')";
  dl_url="$1/output/$id.zip?download=zip";
  echo "Downloading $dl_url";
  wget -O "$id.zip" $dl_url;
else
  echo "URL is not the correct format";
  exit 1;
fi

