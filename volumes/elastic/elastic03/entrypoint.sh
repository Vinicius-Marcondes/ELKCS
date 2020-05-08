#!/bin/bash
HOME="/usr/share/elasticsearch"

cd $HOME

yum install -y sudo wget
### Generating the certificates ###
if [ ! -s "/confing/certs/elastic-certificates.p12" ]; then 
    yes "" | bin/elasticsearch-certutil cert --ca config/certs/elastic-stack-ca.p12
    mv elastic-certificates.p12 config/certs/elastic-certificates.p12
    chown 1000:0 config/certs/elastic-certificates.p12
    chmod 600 config/certs/elastic-certificates.p12
fi

###################################

####### Installing FIlebeat #######

wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.6.2-linux-x86_64.tar.gz
tar xzf filebeat-7.6.2-linux-x86_64.tar.gz
mv filebeat-7.6.2-linux-x86_64 filebeat
rm -rf filebeat-7.6.2-linux-x86_64.tar.gz
cd filebeat
rm -rf filebeat.yml filebeat.reference.yml modules.d
mv $HOME/temp/* .
./filebeat setup 
./filebeat run &
cd ..

###################################

sudo su elasticsearch
elasticsearch
sleep infinity