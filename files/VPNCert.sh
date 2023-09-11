#!/bin/bash

find ~/pki/ -name "*.pem" -delete \
&& find /etc/ipsec.d/ -name "*.pem" -delete \
&& ipsec pki --gen --type rsa --size 1024 --outform pem > ~/pki/private/ca-key.pem \
&& ipsec pki --self --ca --lifetime 3650 --in ~/pki/private/ca-key.pem --type rsa --dn "CN=VPN Freiheit tm2020" --outform pem > ~/pki/cacerts/ca-cert.pem \
&& ipsec pki --gen --type rsa --size 1024 --outform pem > ~/pki/private/server-key.pem \
&& ipsec pki --pub --in ~/pki/private/server-key.pem --type rsa \
         | ipsec pki --issue --lifetime 1825 --cacert ~/pki/cacerts/ca-cert.pem  --cakey ~/pki/private/ca-key.pem \
                     --dn "CN=amy.tmine.de" --san "amy.tmine.de" \
                     --flag serverAuth --flag ikeIntermediate --outform pem  >  ~/pki/certs/server-cert.pem \
&& cp -rfv ~/pki/* /etc/ipsec.d/ \
&& cat /etc/ipsec.d/cacerts/ca-cert.pem > /var/www/html/freiheit.pem \
&& systemctl restart strongswan
