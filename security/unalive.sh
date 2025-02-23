#!/bin/bash
set -e

echo "[*] Stopping services..."
swapoff -a
systemctl disable mysql 
systemctl stop mysql
systemctl disable nginx
systemctl stop nginx

echo "[*] Wiping MySQL data..."
find /var/lib/mysql -type f -exec scrub {} \;

echo "[*] Wiping websites..."
find /var/www -type f -exec scrub {} \;
find /etc/nginx -type f -exec scrub {} \;

echo "[*] Wiping mail server data..."
find /var/spool -type f -exec scrub {} \;
find /var/mail -type f -exec scrub {} \;

echo "[*] Wiping logs..."
find /var/log -type f -exec scrub {} \;

echo "[*] Wiping user-installed software..."
find /usr/local -type f -exec scrub {} \;

echo "[*] Wiping home..."
find /root -type f -exec scrub {} \;
find /home -type f -exec scrub {} \;

echo "[*] Wiping configs..."
find /etc -type f -exec scrub {} \;

echo "[*] Wiping free space..."
scrub -X /

echo "[*] Done! System is wiped."
