#!/bin/bash

domainFile=$1
outFolder=$2

samInt1=1
instanceId=x

echo "cloudMist scan started" | notify -silent

mkdir /root/efs/Recon/${outFolder}

echo "cloudMist subenum started" | notify -silent

masterId=$(cat ../../config/masterID.txt)

slaves(){
    #aws ssm describe-instance-information  --output text --query "InstanceInformationList[*]" | cut -f 5 | grep -v $masterId > demandhost.txt

    noOfslaves=$(cat demandhost.txt | wc -l)
    if [ $noOfslaves -gt 0 ]
    then 
        echo -e "\e[34m $noOfslaves slaves are active \e[0m\e[39m"
    else 
        echo -e "\e[31m There is no slaves \e[0m\e[39m"
        exit;
    fi
}

makeFolders(){
    for folder in $(cat demandhost.txt)
    do
        mkdir /root/efs/slaves/${folder}
        rm /root/efs/slaves/${folder}/command.txt
        rm /root/efs/slaves/*/*
    done
}

findFree(){
    while [ ${samInt1} -lt 2 ];
    do
        #check all ec2
        for demandhost in $(cat demandhost.txt);
        do
            if [ ! -f /root/efs/slaves/${demandhost}/command.txt ];
            then 
                #break while loop
                samInt1=4;

                #set instanceId
                instanceId=${demandhost}

                #set input in folder

                #break this for loop
                break;
            fi
        done
    done
}

sendSub(){
    for domain in $(cat $domainFile)
    do
        #find free ec2
        findFree


        #reset while loop int
        samInt1=1

        if [ ! -f /root/efs/slaves/${demandhost}/command.txt ];
        then
            echo $instanceId

            #set input in folder

            #send command to slave
            echo -e "---bash /root/cloudMist/slave/subfinder.sh ${instanceId} ${outFolder} ${domain}------"
            echo -e "bash /root/cloudMist/slave/subfinder.sh ${instanceId} ${outFolder} ${domain}" > /root/efs/slaves/${demandhost}/command.txt

            cat /root/efs/slaves/${demandhost}/command.txt
            echo ""
            echo ""

            #timeout
            sleep 3
        else
            echo error

            #timeout
            sleep 10
        fi

    done
        
}

psCheck(){ 
    while [ $(ls /root/efs/slaves/* | grep command.txt | sort -u) ];
    do
        echo -e "\e[31m Subdomain enum almost  completed \e[0m\e[39m"
        sleep 10
    done
    echo -e "\e[31m Subdomain enum  completed \e[0m\e[39m"
}

dbInsert(){
    python3 my.py ${outFolder} passive.txt subdomain
}

slaves
makeFolders
sendSub
psCheck
dbInsert

cat /root/efs/Recon/${outFolder}/passive.txt | notify -silent

echo "cloudMist subenum completed" | notify -silent