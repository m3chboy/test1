#! /bin/bash

mysql --host=cloudb1.crsx053vqk56.us-east-1.rds.amazonaws.com --user=root --password=Imcloudb cloudmist << EOF
insert into ${2} (${3}) values('${1}');
EOF