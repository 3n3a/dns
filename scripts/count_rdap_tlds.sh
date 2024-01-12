#!/bin/bash

echo "This many tlds have ldap support: " 
curl -kfsSL https://data.iana.org/rdap/dns.json | jq ".services.[].[0].[]" | wc -l
