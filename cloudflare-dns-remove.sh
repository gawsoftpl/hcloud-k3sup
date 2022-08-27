#!/bin/sh

if [ ${#STAGING_CF_DOMAIN_TOKEN} -eq 0 ];
then
    echo "NO SET $STAGING_CF_DOMAIN_TOKEN"
    exit 1
fi

curl -X GET "https://api.cloudflare.com/client/v4/zones/${1}/dns_records" \
    -H "Authorization: Bearer ${STAGING_CF_DOMAIN_TOKEN}" \
    -H "Content-Type: application/json" | jq ".result[]"  | jq -c "select( .type | contains(\"A\"))" | jq -c "select( .name | contains(\"$2\"))" \
    | jq -r '.id' > /tmp/del-id.txt

# Set variable with dns zone in cloudflare id
export dns_record_id=`cat /tmp/del-id.txt`
echo "Dns record id: $dns_record_id"

# Delete staging subdomain
response=`curl -X DELETE -w "%{http_code}" -s -o /dev/null "https://api.cloudflare.com/client/v4/zones/${1}/dns_records/${dns_record_id}" \
-H "Authorization: Bearer ${STAGING_CF_DOMAIN_TOKEN}" \
-H "Content-Type: application/json"`
if [ ! $response -eq "200" ];
then
echo "Response code: ${response}"
exit 1
fi
echo "Subdomain deleted"