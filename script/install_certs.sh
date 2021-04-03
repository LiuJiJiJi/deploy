#!/bin/bash
#
# Renew all SSL certificates and import to corresponding directories - Andywu

#echo "\033[31m Tip: \033[0m"
#read -p "   Please input domain:" DOMAIN
echo "[$DOMAIN] generate cert start"

# docker exec acme --issue --log --dns dns_dp -d $DOMAIN --keylength ec-384
sudo docker exec acme --issue --log --dns dns_dp -d $DOMAIN

sudo docker exec acme --install-cert -d $DOMAIN \
  --cert-file /etc/letsencrypt/$DOMAIN.chain.pem \
  --key-file /etc/letsencrypt/$DOMAIN.privkey.pem \
  --fullchain-file /etc/letsencrypt/$DOMAIN.fullchain.pem


echo "[$DOMAIN] generate cert end"
