#!/bin/bash
samInt1=1
file=text.txt

same2(){
    while [ ${samInt1} -lt 2 ]; 
    do 
        for i in $(cat ${file});
        do 
            if [ $i == "hh12" ];
            then 
                samInt1=4;
                happy=$i
                break;
            fi; 
        done; 
    done
}

same1(){
    same2
    samInt1=1
    echo $happy
    echo $samInt1
}


same1

for i in $(cat demandhost.txt);do aws ssm send-command --instance-ids ${i} --document-name "AWS-RunShellScript" --comment "subenum ${i}" --parameters commands="/root/go/bin/subfinder -dL /root/efs/slaves/${i}/domain.txt -o /root/efs/slaves/${i}/subout.txt;cat /root/efs/slaves/${i}/subout.txt >> /root/efs/Recon/test/passive",execuSession was closed --output text;done