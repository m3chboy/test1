#!/bin/bash

domainList=$1
outFolder=$2

samInt1=1
instanceId=x

echo "cloudMist webprobing started" | notify -silent

mkdir /root/efs/Recon/${outFolder}

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
        rm -rf /root/efs/webprobe/
        mkdir /root/efs/webprobe
        rm /root/efs/slaves/${folder}/command.txt
        mkdir slaveinput
        rm /root/efs/slaves/*/*
    done
}

setInputfile(){
    noOfslaves=$(cat demandhost.txt | wc -l)
    lines=$(cat $domainList | wc -l)

    splitIntpre=$((lines / noOfslaves))
    splitInt=$(($splitIntpre + 1))

    split -l $splitInt $domainList /root/efs/webprobe/httpxinput
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

sendHttpx(){
    #list of inputfiles
    sleep 4
    ls /root/efs/webprobe/ > slaveinput/fileForhttpx.txt

    for httpxfile in $(cat slaveinput/fileForhttpx.txt)
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
            echo -e "--------bash /root/cloudMist/slave/httpx.sh ${instanceId} ${outFolder} ${httpxfile}------"
            echo -e "bash /root/cloudMist/slave/httpx.sh ${instanceId} ${outFolder} ${httpxfile}" > /root/efs/slaves/${demandhost}/command.txt
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
        echo -e "\e[32m Subdomain resolving almost  completed \e[0m\e[39m"
        sleep 10
    done
    echo -e "\e[31m Subdomain resolving  completed \e[0m\e[39m"
}

dbInsert(){
    python3 my.py ${outFolder} webserver.txt webserver
}

slaves
makeFolders
setInputfile
sendHttpx
psCheck
dbInsert

cat /root/efs/Recon/${outFolder}/webserver.txt | notify -silent

sleep 10

echo "cloudMist webprobing completed" | notify -silent