#!/bin/bash
#
# Renew all SSL certificates and import to corresponding directories - Andywu

echo "\033[31m Tip: \033[0m"
read -p "   Please input domain:" domain
echo "[$domain] generate cert start"

# docker exec acme --issue --log --dns dns_dp -d $domain --keylength ec-384
docker exec acme --issue --log --dns dns_dp -d $domain

docker exec acme --install-cert -d $domain \
  --cert-file /etc/letsencrypt/$domain.chain.pem \
  --key-file /etc/letsencrypt/$domain.privkey.pem \
  --fullchain-file /etc/letsencrypt/$domain.fullchain.pem


echo "[$domain] generate cert end"
