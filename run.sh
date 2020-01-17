#!/bin/bash

echo
sleep 1
echo " *"
sleep 1
echo " *"
sleep 1
echo " *** Welcome to Projecte.ftpd script made by haykzaryan ***"
sleep 2
echo " *** Have a nice day! ***"
echo
echo

#Creates volume (deletes the old volume and containers in case if you have already executed the script 1 or more times)
docker stack rm traefik webapps
docker stop webgeneral server.ftp client.ftp web1 web2 web3
docker rm webgeneral server.ftp client.ftp web1 web2 web3
docker volume rm volume.ftp
docker volume create volume.ftp
sleep 1
docker network rm proxy
sleep 1

#Create network
docker network create -d overlay --attachable proxy

#Creates ftp client
docker run -d --name client.ftp -p 5800:5800 -v /docker/appdata/filezilla:/config:rw -v $HOME:/storage:rw --network proxy jlesage/filezilla

#Creates ftp server
docker run -d -p 21:21 -v volume.ftp:/home/vsftpd/admin --name server.ftp --network proxy fauria/vsftpd


docker stack deploy -c docker-compose.traefik.yml traefik 
docker stack deploy -c docker-compose.webapps.yml webapps



#Copy websites to our servers (web1.ftp and web2web3.ftp)

echo First website container\'s name: ; read web1_cont
echo Second website container\'s name: ; read web2_cont
echo Third website container\'s name: ; read web3_cont
echo General website container\'s name: ; read webgeneral_cont
echo First website directory: ; read web1_dir
echo Second website directory: ; read web2_dir
echo Third website directory: ; read web3_dir
echo General website directory: ; read webgeneral_dir
cd $web1_dir && docker cp . $web1_cont:/usr/share/nginx/html
cd $web2_dir && docker cp . $web2_cont:/usr/local/apache2/htdocs/
cd $web3_dir && docker cp . $web3_cont:/usr/local/apache2/htdocs/
cd $webgeneral_dir && docker cp . $webgeneral_cont:/usr/local/apache2/htdocs/



# INFO
echo
echo
echo
echo
echo
echo
echo " *****   IMPORTANT!   *****"
echo
sleep 1
echo " --> Files of your host's directory [/home/$(whoami)], it shows in "
echo " /storage (Host directory has been mounted in Client FTP's /storage directory.) "  
echo
sleep 1
echo "Your Server FTP's Info:"
echo 
docker exec server.ftp ./usr/sbin/run-vsftpd.sh
sleep 1
echo
echo " ***** You can already access to your Server FTP from Client FTP putting User's "
echo "       login and password. ***** "
echo
echo
echo

#docker cp ./projecte.ftpd/logerror.sh server.ftp:/usr/sbin/run-vsftpd.sh

#Create subfolders for each website (web2web3.ftp)
#docker exec web2web3.ftp bash -c "cd /usr/local/apache2/htdocs && mkdir web2 web3"

#docker exec web2 bash -c "cd /usr/local/apache2/htdocs && rm index.html"
