#!/bin/bash

instanceId=$1

while [ 2 -gt 1 ]
do
    if [ $(ls /root/efs/slaves/${instanceId}/ | grep command.txt | sort -u) ]
    then
        #take command from command.txt
        command=$(cat /root/efs/slaves/${instanceId}/command.txt)
        $command

        #remove command file

        sleep 5

        rm /root/efs/slaves/${instanceId}/command.txt
        echo fileremoved

    else
        echo -e "\e[31m ${instanceId}: waiting \e[0m\e[39m"

        sleep 10
    fi
done