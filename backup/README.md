# /sysadmin/backup
#### Scripts to backup data from servers
## Scripts
* `make-backup.sh` - Makes backups of files and databases
* `pull-backups.sh` - Retrieves backups from remote server
## Usage example
Server `A` is a server we want to backup
Server `B` is a server that we want to store backups on

The script `make-backup.sh` is put on server `A` and is being runned by a cron job

Script `pull-backups.sh` is put on sercer `B` and is being runned by a cron job

Server `A` makes backups of important data and stores them
Server `B` downloads these backups and stores them on itself
