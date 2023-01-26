#!/bin/bash

instanceId=$1
outFolder=$2
inputFile=$3

httpxResolve(){
    /root/go/bin/httpx -l /root/efs/webprobe/$inputFile -o /root/efs/slaves/${instanceId}/httpxout.txt
}

saveOutput(){
    cat /root/efs/slaves/${instanceId}/httpxout.txt >> /root/efs/Recon/${outFolder}/webserver.txt

    rm /root/efs/slaves/${instanceId}/httpxout.txt
}

httpxResolve
saveOutput