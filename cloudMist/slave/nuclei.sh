#!/bin/bash

instanceId=$1
outFolder=$2
inputFile=$3

nucleiScan(){
    /root/go/bin/nuclei -l /root/efs/vulnu/$inputFile -t /root/nuclei-templates/ -es info -o /root/efs/slaves/${instanceId}/nucleiscan.txt
}

saveOutput(){
    cat /root/efs/slaves/${instanceId}/nucleiscan.txt >> /root/efs/Recon/${outFolder}/nucleivuln.txt

    rm /root/efs/slaves/${instanceId}/nucleiscan.txt
}

nucleiScan
saveOutput