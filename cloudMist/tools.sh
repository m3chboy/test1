#!/bin/bash

#install subfinder
echo -e "\e[96m Installing Subfinder \e[0m\e[39m";
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
echo -e "-------------------------------"; echo "";

#install httpx 
echo -e "\e[96m Installing httpx  \e[0m\e[39m";
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
echo -e "-------------------------------"; echo "";

#install nuclei
echo -e "\e[96m Installing nuclei  \e[0m\e[39m";
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
cd;
git clone https://github.com/projectdiscovery/nuclei-templates
echo -e "-------------------------------"; echo "";

#create folder
mkdir /root/efs/Recon
mkdir /root/Tools
cd /root/Tools


#Nmap
echo -e "\e[96m Installing Nmap  \e[0m\e[39m";
apt-get install -y nmap
echo -e "-------------------------------"; echo "";

#masscan
echo -e "\e[96m Installing Masscan  \e[0m\e[39m";
cd /root/Tools
git clone https://github.com/robertdavidgraham/masscan && cd masscan && make && make install && mv bin/masscan /usr/bin/;
echo -e "-------------------------------"; echo "";
sleep 2

#Naabu
echo -e "\e[96m Installing naabu  \e[0m\e[39m";
apt install -y libpcap-dev;
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest;
echo -e "-------------------------------"; echo "";
sleep 2

#dnsutils
echo -e "\e[96m Installing dnsutils  \e[0m\e[39m";
apt-get install -y dnsutils
echo -e "-------------------------------"; echo "";
sleep 2

#Nmap
echo -e "\e[96m Installing massdns  \e[0m\e[39m";
cd /root/Tools
git clone https://github.com/blechschmidt/massdns.git
cd massdns
make
mv /root/Tools/massdns/bin/massdns /usr/bin/
cd ..
echo -e "-------------------------------"; echo "";
sleep 2

#ffuf
echo -e "\e[96m Installing ffuf  \e[0m\e[39m";
go install github.com/ffuf/ffuf@latest
echo -e "-------------------------------"; echo "";

#puredns
echo -e "\e[96m Installing puredns  \e[0m\e[39m";
go install github.com/d3mondev/puredns/v2@latest
echo -e "-------------------------------"; echo "";
sleep 2

#dnsgen
echo -e "\e[96m Installing dnsgen  \e[0m\e[39m";
pip3 install dnsgen
echo -e "-------------------------------"; echo "";
sleep 2

#Sqlmap
echo -e "\e[96m Installing Nmap  \e[0m\e[39m";
apt-get install -y sqlmap
echo -e "-------------------------------"; echo "";
sleep 2

#dalfox
echo -e "\e[96m Installing dalfox  \e[0m\e[39m";
go install github.com/hahwul/dalfox/v2@latest
echo -e "-------------------------------"; echo "";
sleep 2

#Nmap
echo -e "\e[96m Installing Nmap  \e[0m\e[39m";

echo -e "-------------------------------"; echo "";
sleep 2