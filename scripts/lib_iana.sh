#!/bin/bash
#
# iana provided data
#
# source: https://www.iana.org/
#   list of rdap related files: https://data.iana.org/rdap/
#   list of tld related files: https://data.iana.org/TLD/
#

get_tlds_rdap_count() {
	# result is a json
	curl -kfsSL https://data.iana.org/rdap/dns.json | jq ".services.[].[0].[]" | wc -l
}

get_tlds_registered_count() {	
	# first line is current date
	curl -kfsSL https://data.iana.org/TLD/tlds-alpha-by-domain.txt | grep -v '#' | wc -l
}
