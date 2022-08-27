#!/bin/sh

if [ ${#STAGING_CF_DOMAIN_TOKEN} -eq 0 ];
then
    echo "NO SET $STAGING_CF_DOMAIN_TOKEN"
    exit 1
fi

echo "{\"type\":\"A\",\"name\":\"${2}\",\"content\":\"${3}\",\"ttl\":180,\"priority\":10,\"proxied\":false}" > cloudflare-data.txt
response2=`curl -X POST -w "%{http_code}" -s -o /dev/null "https://api.cloudflare.com/client/v4/zones/${1}/dns_records" \
-H "Authorization: Bearer ${STAGING_CF_DOMAIN_TOKEN}" \
-H "Content-Type: application/json" \
-d @cloudflare-data.txt`
if [ ! $response -eq "200" ];
then
echo "Response code: ${response}"
exit 1
fi

echo "Subdomain created"