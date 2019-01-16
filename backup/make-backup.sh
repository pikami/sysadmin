#!/bin/bash
DATE=$(date +"%d-%m-%Y")
BACKUP_DIR='/home/backuper/backups'
DIRS_TO_BACKUP=(
  # Mail
  '/etc/;postfix'  # postfix configs
  '/etc/;dovecot'  # dovecot configs
  '/var/;mail'     # emails
  # Web
  '/etc/;nginx'    # nginx configs
  '/var/;www'      # websites
)

# Setup
mkdir -p $BACKUP_DIR/mysql

# Backup directories
for i in "${DIRS_TO_BACKUP[@]}"
do
  conf=(${i//;/ })
  echo ${conf[0]}
  echo ${conf[1]}
  tar -zcvf $BACKUP_DIR/${conf[1]}-$DATE.tgz -C ${conf[0]} ${conf[1]}
done

# SQL
mysql -N -e 'show databases' | while read dbname;
do
  mysqldump --complete-insert --routines --triggers --single-transaction "$dbname" > $BACKUP_DIR/mysql/"$dbname".sql;
done
tar -zcvf $BACKUP_DIR/mysql-$DATE.tgz -C $BACKUP_DIR/ mysql
rm -rf $BACKUP_DIR/mysql
