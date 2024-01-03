#!/bin/bash

# Zone ID, Record ID, Bearer Token, Name

ip=$(curl -s "ifconfig.co")

#echo $ip

url="https://api.cloudflare.com/client/v4/zones/$1/dns_records/$2"
header="Authorization: Bearer $3"
data="{\"content\": \"$ip\", \"name\": \"$4\", \"proxied\": false, \"type\": \"A\", \"ttl\": 1}"

#echo $url
#echo $header
#echo $data

res=$(curl -s --request PUT --url "$url" --header "Content-Type: application/json" --header "$header" --data "$data")

resip=$(echo $res | grep -o -E "([0-9]{1,3}[\.]){3}([0-9]{1,3})")
resstatus=$(echo $res | grep -o -E "(\"success\":(true|false))")

echo "Public IP: $ip | Response IP: $resip | Response Status: $resstatus"
