#!/bin/bash

instanceId=$1
outFolder=$2
domain=$3

subdomain(){
    /root/go/bin/subfinder -d $domain -o /root/efs/slaves/${instanceId}/subout.txt

    sleep 20
}
saveOutput(){
    cat /root/efs/slaves/${instanceId}/subout.txt >> /root/efs/Recon/${outFolder}/passive.txt
    rm /root/efs/slaves/${instanceId}/subout.txt
}

subdomain
saveOutput