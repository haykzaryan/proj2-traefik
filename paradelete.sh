#!/bin/bash


if [[ $(if ls -1qA ./tls/ | grep -q .;  then echo not empty; else echo empty; fi) = 'empty' ]]; then
  sh ./setup-cert.sh; else echo 'You alreade have the ceritifates created! Passing...' 
fi 


