#!/bin/bash
red='\e[31m'
green='\e[32m'
blue='\e[34m'
cyan='\e[96m'
ltcyan='\e[96m'
yellow='\e[33m'
black='\e[38;5;016m'
bluebg='\e[48;5;038m'${black}
end='\e[0m'

domain=$1

function banner {
    printf "${red}           ████                          █████ ██████   ██████  ███           █████   
         ░░███                         ░░███ ░░██████ ██████  ░░░           ░░███    
  ██████  ░███   ██████  █████ ████  ███████  ░███░█████░███  ████   █████  ███████  
 ███░░███ ░███  ███░░███░░███ ░███  ███░░███  ░███░░███ ░███ ░░███  ███░░  ░░░███░   
░███ ░░░  ░███ ░███ ░███ ░███ ░███ ░███ ░███  ░███ ░░░  ░███  ░███ ░░█████   ░███    
░███  ███ ░███ ░███ ░███ ░███ ░███ ░███ ░███  ░███      ░███  ░███  ░░░░███  ░███ ███
░░██████  █████░░██████  ░░████████░░████████ █████     █████ █████ ██████   ░░█████ 
 ░░░░░░  ░░░░░  ░░░░░░    ░░░░░░░░  ░░░░░░░░ ░░░░░     ░░░░░ ░░░░░ ░░░░░░     ░░░░░  
                                                                                     
                                                                                     
                                                                                      ${cyan}"

    echo -e "${cyan}- @mechboy_"
}

function subdomain {
    printf "${blue}╭──────────────────────────────╮${end}\n"
    printf "${blue}│    SUBDOMAIN ENUMERATION     │${end}\n"
    printf "${blue}╰──────────────────────────────╯${end}\n"
    echo $domain | subfinder -silent -all -o subout
    totalpassive=$(cat subout | wc -l)
    curl -s -X POST "https://api.telegram.org/bot5192035546:AAHRq6ri2xfE-4H-gF0h0bdhN85TRGA_OK8/sendMessage" -d chat_id="1119981913" -d text="<b>SUBDOMAIN: </b><b> ${totalpassive} </b>" -d parse_mode="html" -d disable_web_page_preview=True &> /dev/null;
}

#webserver
function webserver {
    printf "${blue}╭────────────────────────────╮${end}\n"
    printf "${blue}│	   WEBSERVER         │${end}\n"
    printf "${blue}╰────────────────────────────╯${end}\n"
    cat subout | httpx -silent -o webserver
    totalweb=$(cat webserver | wc -l)
    curl -s -X POST "https://api.telegram.org/bot5192035546:AAHRq6ri2xfE-4H-gF0h0bdhN85TRGA_OK8/sendMessage" -d chat_id="1119981913" -d text="<b>WEBSERVER: </b><b> ${totalweb} </b>" -d parse_mode="html" -d disable_web_page_preview=True &> /dev/null;
}
#screenshot

#vuln scanner


banner
subdomain
webserver

printf "${blue}╭──────────────────────────────╮${end}\n"
printf "${blue}│	VULNERABILITY SCAN     │${end}\n"
printf "${blue}╰──────────────────────────────╯${end}\n"

cat webserver | nuclei -t ~/nuclei-templates/ -tags moodle -silent -o vuln_out
totalvuln=$(cat vuln_out)
curl -s -X POST "https://api.telegram.org/bot5192035546:AAHRq6ri2xfE-4H-gF0h0bdhN85TRGA_OK8/sendMessage" -d chat_id="1119981913" -d text="<b>VULNERABILITY: </b><b> ${totalvuln} </b>" -d parse_mode="html" -d disable_web_page_preview=True &> /dev/null;