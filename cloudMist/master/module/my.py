import mysql.connector, sys

conn=mysql.connector.connect(host="cloudb1.crsx053vqk56.us-east-1.rds.amazonaws.com",
user="root",
password="Imcloudb",
database="cloudmist",
auth_plugin='mysql_native_password')

cursor=conn.cursor()

foldername = '/root/efs/Recon/'+sys.argv[1]+'/'+sys.argv[2]
name = sys.argv[1]
id = sys.argv[3]

with open(foldername, 'r') as p:
    for inp in p.read().split('\n'):
        inp = '"'+ inp +'"'
        cursor.execute('''INSERT INTO '''+ name +'''('''+id+''') VALUES('''+inp+''')''')
        conn.commit()

        if id == 'subdomain':
            cursor.execute('''INSERT INTO subdomain (subdomain) VALUES('''+inp+''')''')
            conn.commit()

        if id == 'vuln':
            cursor.execute('''INSERT INTO vulnerability (vuln) VALUES('''+inp+''')''')
            conn.commit()