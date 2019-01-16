#!/bin/bash
DATE=$(date +"%d-%m-%Y")
PULL_DIR='backups'
SSH_KEY='/home/bakerupper/.ssh/bakerupper_key'

SERVERS=(
  'bakeruper;mail.pikami.org;/home/bakeruper/backups/*'
  'bakeruper;baguette.pikami.org;/home/bakeruper/backups/*'
)

# Pull backups
for i in "${SERVERS[@]}"
do
  conf=(${i//;/ })
  mkdir -p $PULL_DIR/$DATE/${conf[1]}
  scp -i $SSH_KEY ${conf[0]}@${conf[1]}:${conf[2]} $PULL_DIR/$DATE/${conf[1]}
done
