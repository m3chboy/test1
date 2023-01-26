#!/bin/bash

domain=$1

#banner 
red='\e[31m'
green='\e[32m'
blue='\e[34m'
cyan='\e[96m'
ltcyan='\e[96m'
yellow='\e[33m'
black='\e[38;5;016m'
bluebg='\e[48;5;038m'${black}
end='\e[0m'


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

#passvie subdomain enum
function subdomain{
    printf "${logo}╭───────────────────────────────────────────────────────────────────────────────╮${end}\n" >&2
    #echo $domain | subfinder -silent -all -o subout
}

#active subdomain enum
#cat subout | dnsgen - >> act_$domain
#puredns resolve act_$domain -r ~/wordlists/resolvers.txt -w active
#cat active >> subout
#rm active
#cat subout | sort -u >> subdomain

#webserver
function webserver{
    #cat subout | httpx -silent -o webserver
    echo hello
}
#screenshot

#vuln scanner
function nuclei{
    #cat webserver | nuclei -t ~/nuclei-templates/ -tags moodle -silent -o vuln_out
}


banner
subdomain
webserver
nuclei