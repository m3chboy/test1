#!/bin/bash

masterId=$(cat ../../config/masterID.txt)

availableEc2(){
    #no. of slaves
    aws ssm describe-instance-information  --output text --query "InstanceInformationList[*]" | cut -f 4 | grep -v $masterId > available-ec2.txt;
    
    #atleast 
    noOfslaves=$(cat available-ec2.txt | wc -l)
    if [ $noOfslaves -gt 0 ]
    then 
        echo -e "\e[34m $noOfslaves slaves are active \e[0m\e[39m"
    else 
        echo -e "\e[31m There is no slaves \e[0m\e[39m"
        exit;
    fi
}

sendCommand(){
    for instance in $(cat available-ec2.txt);
    do
        aws ssm send-command --instance-ids $instance --document-name "AWS-RunShellScript" --comment "IP config" --parameters commands="$command" --output text
    done
}

while [ -n "$1" ]
do
    case "$1" in
        -c) 
        command=$2
        script=True
        shift
        ;;
        -s) slave=True;;
    esac
shift
done

if [ $script ]
then
    availableEc2;
    sendCommand;
fi

if [ $slave ]
then
    availableEc2;
fi
