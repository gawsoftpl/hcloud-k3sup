#!/bin/sh

if [ ${#1} -eq 0 ];
then
    echo "Please set arg with project name to delete: hcloud-k3sup-delete test"
    exit 1
fi

servers=`hcloud server list -l name=${1} -o columns=name | tail -n +2`
for name in $servers;
do
    echo Delete $name
    hcloud server delete $name
done

