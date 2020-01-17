#!/bin/bash


#if [[ $(docker run -d --name client.ftp -p 5800:5800 -v /docker/appdata/filezilla:/config:rw -v $HOME:/storage:rw --network proxy jlesage/filezilla) = 'docker:'* ]]; then
 # echo 'paluchilos'; else echo 'chexav' 
#fi 

#if ./docker run -d --name client.ftp -p 5800:5800 -v /docker/appdata/filezilla:/config:rw -v $HOME:/storage:rw --network proxy jlesage/filezilla | grep -q 'string'; then
 # echo "matched"
#fi


#if [[ "$(docker run -d --name client.ftp -p 5800:5800 -v /docker/appdata/filezilla:/config:rw -v $HOME:/storage:rw --network proxy jlesage/#filezilla)" =~ "docker" ]]; then echo "Output includes 'sub string'" ; fi

anasun='docker run -d --name client.ftp -p 5800:5800 -v /docker/appdata/filezilla:/config:rw -v $HOME:/storage:rw --network proxy jlesage/filezilla'
if [[ $anasun == *'Error'* ]]; then
  echo "It's there!"; else echo "dont work" ;
fi
