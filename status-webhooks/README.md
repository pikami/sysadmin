# /sysadmin/status-webhooks
#### Scripts to report information using webhooks
## Scripts
* `yt-report.sh` - Reports about newly downloaded youtube videos

## yt-report.sh
Reports newly downloaded youtube videos
### Files in directory:
* webhook.txt - contains webhook URL
* template.txt - contains template of the POST request body
* yt_reported.txt - contains already reported video list
### Parameters:
* archive - path to list of downloaded videos
* webhook - webhook URL
* template - template of the POST request body
* reported - path to list of reported videos
