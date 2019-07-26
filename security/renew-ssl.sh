acme.sh --issue -d pikami.org -d mail.pikami.org --webroot /var/www/html/ --force
acme.sh --install-cert -d pikami.org \
  --key-file       /etc/ssl/private/domain.key \
  --fullchain-file /etc/ssl/certs/chained.pem
cp /etc/ssl/certs/chained.pem /etc/postfix/chained.pem
cp /etc/ssl/private/domain.key /etc/postfix/domain.key
