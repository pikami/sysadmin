# Get certs
acme.sh --issue -d pikami.org -d mail.pikami.org --webroot /var/www/html/ --force
# Install cert nginx
acme.sh --install-cert -d pikami.org \
  --key-file       /etc/ssl/private/domain.key \
  --fullchain-file /etc/ssl/certs/chained.pem
# Install cert postfix
cp /etc/ssl/certs/chained.pem /etc/postfix/chained.pem
cp /etc/ssl/private/domain.key /etc/postfix/domain.key
# Reload services
service nginx reload
service postfix reload
