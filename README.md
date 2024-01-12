# dns

## Switch DNS Zones (.ch, .li)

See this website:
https://portal.switch.ch/pub/open-data/#tab-fccd70a3-b98e-11ed-9a74-5254009dc73c-3

## TLD Zones

See here for CZDS Rest API:
[https://github.com/icann/czds-api-client-java/blob/master/docs/ICANN_CZDS_api.pdf](https://github.com/icann/czds-api-client-java/blob/master/docs/ICANN_CZDS_api.pdf)

### CZDS Client (Python)

> Modified / corrected version of original by ICANN

1. Fill out config.json
2. Install Deps `pip3 install -r requirements.txt`
3. Run the script `python3 download.py -h`
3.1. Add the flag '-n' to preview and NOT download

## RDAP

Whois Lookup Protocol via JSON Api.

List of RDAP Servers for TLDs:
https://data.iana.org/rdap/dns.json
