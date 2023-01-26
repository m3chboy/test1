# from crypt import methods
# from unittest import result
from flask import Flask, render_template, request, redirect, url_for
# import mysql.connector
import os, requests, json

app = Flask(__name__)

# conn=mysql.connector.connect(host="cloudb1.crsx053vqk56.us-east-1.rds.amazonaws.com",
# user="root",
# password="Imcloudb",
# database="cloudmist",
# auth_plugin='mysql_native_password')

# cursor=conn.cursor()


# def command(name, foldername):

#     hel = 'cd /root/cloudMist/master/module/;bash subenum.sh /root/efs/Recon/'+name+'/domain.txt '+name+';sleep 5; bash httprobe.sh /root/efs/Recon/'+name+'/passive.txt '+name+';sleep 5;bash nuvuln.sh /root/efs/Recon/'+name+'/webserver.txt '+name


#     os.system('screen -dm bash -c '+'"'+hel+'"')

# def createdb(folder):
#     cursor.execute('''CREATE TABLE '''+ folder +'''(domain VARCHAR(20), subdomain VARCHAR(30), webserver VARCHAR(30), vuln VARCHAR(250))''')
#     conn.commit()

#     inp = '"'+ folder +'"'
#     cursor.execute('''INSERT INTO scan (scan) VALUES('''+inp+''')''')
#     conn.commit()

# def insertdomain(foldername, folder):
#     with open(foldername+'/domain.txt', 'r') as z:
#         for inp in z.read().split('\n'):
#             inp = '"'+ inp +'"'
#             cursor.execute('''INSERT INTO '''+ folder +'''(domain) VALUES('''+inp+''')''')
#             conn.commit()
#     return 'hello'

def command(folder):
    cmd = 'cd /root/cloudMist/web-interface; bash script.sh '+folder

    os.system('screen -d -S cloudmist '++'"'+cmd+'"')

def get_data_from_file(file_path):
    with open(file_path, 'r') as file:
        data = file.read()
    return data

@app.route('/', methods=['POST', 'GET'])
# @app.route('/')
def home_page():
    #post req
    if request.method == 'POST':
        domains = request.form.get('domain')
        folder = request.form.get('folder')
        if domains and folder:
            foldername='/root/akm/recon/'+folder
            print(os.listdir('/root/akm/recon'))
            #folder not exist
            if not os.path.exists(foldername):
                #make folder
                os.mkdir(foldername)
                
    #             #create db
    #             createdb(folder)

                with open(foldername+'/domain.txt', 'w') as f:
                    f.write(str(domains.strip()))

    #             #insert domain in db
    #             insertdomain(foldername, folder)
                
                command(folder)
                return redirect(url_for('home_page'))
    #         #folder exist
    #         else:
    #             return 'folder name already exist'
    #     else:
    #         return render_template('home.html')
    # #get req
    # else:
    #     cursor.execute('''SELECT * FROM scan''')
    #     result = cursor.fetchall()

    #     cursor.execute('''SELECT * FROM subdomain''')
    #     subresult = cursor.fetchall()

    #     cursor.execute('''SELECT * FROM vulnerability''')
    #     vulresult = cursor.fetchall()

    #     #check scan is in progress
    #     os.system('screen -ls | wc -l > /root/cloudMist/web-interface/pscheck.txt')
    #     with open('/root/cloudMist/web-interface/pscheck.txt', 'r') as ps:
    #         pscheck = ps.read()

    # return render_template('home.html', data=result, pscheck=pscheck, subresult=subresult, vulresult=vulresult)
    return render_template('home.html')


# @app.route('/db')
# def db():
#     #cursor.execute('''CREATE TABLE test (id INTEGER, folder VARCHAR(20), domain VARCHAR(100), sub VARCHAR(20))''')
#     Muke = 'test'
#     cursor.execute('''INSERT INTO '''+ Muke +'''(Email) VALUES('hello.com')''')
#     conn.commit()
#     cursor.execute('''SELECT * FROM test''')
#     result = cursor.fetchall()
#     print(result)
#     return str(result)

@app.route('/scanlist')
def scanlist():
#     conn.commit()
#     cursor.execute('''SHOW TABLES''')
#     tables = cursor.fetchall()
    tables = os.listdir('/root/akm/recon')
    print(tables)
    return render_template('scanlist.html', tables=tables)

@app.route('/scan/<foldertable>')
def scan_details(foldertable):
#     conn.commit()
#     cursor.execute('''SELECT * FROM ''' + foldertable)
#     result = cursor.fetchall()
#     #return str(result)
    # return render_template('scaninfo.html', foldertable=foldertable, result=result)
    domains = ''
    if os.path.exists("/root/akm/recon/"+foldertable+"/domain.txt"):
        domains = get_data_from_file("/root/akm/recon/"+foldertable+"/domain.txt")

    #subdomain
    subdomain = ''
    if os.path.exists("/root/akm/recon/"+foldertable+"/subdomain.txt"):
        with open("/root/akm/recon/"+foldertable+"/subdomain.txt", 'r') as file:
            subdomain = file.read()
    
    webserver = ''
    if os.path.exists("/root/akm/recon/"+foldertable+"/webserver.txt"):
        with open("/root/akm/recon/"+foldertable+"/webserver.txt", 'r') as file:
            webserver = file.read()
    
    vuln = ''
    if os.path.exists("/root/akm/recon/"+foldertable+"/vuln.txt"):
        with open("/root/akm/recon/"+foldertable+"/vuln.txt", 'r') as file:
            vuln = file.read()

    return render_template('scaninfo.html', domains=domains, subdomain=subdomain, webserver=webserver, vuln=vuln)

@app.route('/vuln')
def vuln():
#     cursor.execute('''SELECT * FROM vulnerability''')
#     vulresult = cursor.fetchall()
    with open("/root/akm//recon/cmall/vuln.txt", 'r') as file:
        vulresult = file.read()

    return render_template('vuln.html', vulresult=vulresult)

@app.route('/subs')
def subs():
#     cursor.execute('''SELECT * FROM subdomain''')
#     subresult = cursor.fetchall()
    with open("/root/akm/recon/cmall/subdomain.txt", 'r') as file:
        subresult = file.read()

    return render_template('subs.html', subresult=subresult)

# # @app.route('/newscan', methods=['POST', 'GET'])
# # def new_scan():
# #     if request.method == 'POST':
# #         return "post method"
# #     else:
# #         return render_template('newscan.html')






# @app.route('/tele')
# def tele():
#     URL = "https://api.telegram.org/bot1653742854:AAHGjLHzPwKeXXn9skGBXwXteXambrGNzOk/getUpdates"
#     r = requests.get(url = URL)
#     data = r.json()
#     hello = data["result"]
#     hello1 = hello[-1]
#     hello2 = hello[-2]
#     hello11 = hello1["message"]
#     hello22 = hello2["message"]
#     #return str(hello11["text"])
#     return render_template('msg.html', hello11=hello11, hello22=hello22)

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=80)