#!/bin/bash

folderName = $1

#Subfinder
axiom-scan /root/akm/recon/${folderName}/domain.txt -m subfinder -o /root/akm/recon/${folderName}/subdomain.txt

#httpx
if [ -f /root/akm/recon/${folderName}/subdomain.txt ];
then
    # axiom-scan /root/akm/recon/${folderName}/subdomain.txt -m httpx -o /root/akm/recon/${folderName}/webserver.txt
    echo hello
fi

#vuln
if [ -f /root/akm/recon/${folderName}/webserver.txt ];
then
    # axiom-scan /root/akm/recon/${folderName}/webserver.txt -m nuclei -o /root/akm/recon/${folderName}/vuln.txt
    echo hello
fi