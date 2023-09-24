#!/bin/bash

find /etc/ipsec.d/ -name "*.pem" -delete 2>/dev/null \
&& pki --gen --type rsa --size 4096 --outform pem > ~/pki/private/ca-key.pem \
&& pki --self --ca --lifetime 3650 --in ~/pki/private/ca-key.pem  --type rsa --dn "CN=$1" --outform pem > ~/pki/cacerts/ca-cert.pem \
&& pki --gen --type rsa --size 4096 --outform pem > ~/pki/private/server-key.pem \
&& pki --pub --in ~/pki/private/server-key.pem --type rsa \
    | pki --issue --lifetime 1825 \
        --cacert ~/pki/cacerts/ca-cert.pem \
        --cakey ~/pki/private/ca-key.pem \
        --dn "CN=$1" --san $1 \
        --flag serverAuth --flag ikeIntermediate --outform pem \
    >  ~/pki/certs/server-cert.pem \
&& cp -rfv ~/pki/* /etc/ipsec.d/