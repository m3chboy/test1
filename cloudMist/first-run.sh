#!/bin/bash
#by: Muhe(mechboy)

#Checking for root access

if [ "${UID}" -eq 0 ]
then
    echo -e "\e[31m ----I'm going to install all BugBounty Tools---- \e[0m\e[39m";
else
    echo -e "\e[31m need ROOT access \e[0m\e[39m"
    exit;
fi

#update && upgrade && install git
apt-get -y update && apt-get -y upgrade && apt install -y git

#install python, ruby
echo -e "\e[96m Installing python, ruby \e[0m\e[39m";
apt-get install -y python python-pip python3 python3-pip python-dnspython python-dev python-setuptools virtualenv unzip make gcc libpcap-dev curl build-essential libcurl4-openssl-dev libldns-dev libssl-dev libffi-dev libxml2 jq libxml2-dev libxslt1-dev build-essential ruby-dev ruby-full libgmp-dev zlib1g-dev
apt install -y python3-pip
echo -e "-------------------------------"; echo "";

#install Golang
echo -e "\e[96m Installing Golang \e[0m\e[39m";
cd /tmp
rm go1.18.2.linux-amd64.tar.gz
wget https://go.dev/dl/go1.18.2.linux-amd64.tar.gz 
rm -rf /usr/local/go
tar -C /usr/local -xzf go1.18.2.linux-amd64.tar.gz
cd;
export GOROOT=/usr/local/go && export GOPATH=$HOME/go && export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
echo 'export GOROOT=/usr/local/go' >> ~/.bashrc
echo 'export GOPATH=$HOME/go'	>> ~/.bashrc
echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bashrc;
. /root/.bashrc

#check go was installed
if command -v go > /dev/null 2>&1
then
    echo -e "\e[33m Golang installed \e[0m\e[39m";
else
    echo "\e[32m Golang was not installed \e[0m\e[39m";
    exit;
fi