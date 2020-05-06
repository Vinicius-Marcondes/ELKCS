# Elastic Containerized Stack (ELKCS)
A complete ELK Stack environment containerized and able to be used in DEV or PROD

## Contains 
* Elasticsearch (cluster)
* Kibana
* Logstash
* Metricbeat for Metrics Monitoring
* Filebeat to collect logs

## Cluster
For now you can create a cluster of Elasticsearch to handle more data processing and with a little tricks and magic be able to run the cluster on swarm mode.

## How to use
Here we need some adaptations, as the stack is suposed to be used on DEV or PROD( still testing ) the x-autentication 
### Basic
To start the stack:

```
docker-compose up -d 
```
To stop the cluster:
```
docker-compose down
```
### Setting up 






#Creating Elastisearch Nodes
INSTRUCTIONS:
curl -X GET "localhost:9200/_cluster/health?pretty"

##On Each Node
Generate a stack certificate for your cluster 
$ ~/bin/elasticsearch-certutil ca
> *Obs*: no need to create a password, if you want you'll need extra steps to me the cluster works. You can find the information you nedd [here](h) 

bin/elasticsearch-certutil cert --ca elastic-stack-ca.p12


cp elastic-certificates.p12 /etc/elasticsearch/

cd /etc/elasticsearch/
ls -l
nano /etc/elasticsearch/elasticsearch.yml
- Copy and paste following 5 lines in elasticsearch.yml file
xpack.security.enabled: true
xpack.security.transport.ssl.enabled: true
xpack.security.transport.ssl.verification_mode: certificate
xpack.security.transport.ssl.keystore.path: elastic-certificates.p12
xpack.security.transport.ssl.truststore.path: elastic-certificates.p12

chown root:elasticsearch /etc/elasticsearch/elastic-certificates.p12
chmod 660 /etc/elasticsearch/elastic-certificates.p12

scp /usr/share/elasticsearch/elastic-certificates.p12 elk@192.168.56.102:/home/elk/
scp /usr/share/elasticsearch/elastic-certificates.p12 elk@192.168.56.103:/home/elk/

systemctl restart elasticsearch 

- Set passwords for default users
cd /usr/share/elasticsearch
bin/elasticsearch-setup-passwords interactive
demo passwords:
elastic:elastic
apm_system:apmsystem
kibana:kibana
logstash_system:logstashsytem
beats_system:beatssystem
remote_monitoring_user:remotemonitoringuser
- you can generate random passwords automatic using following command
bin/elasticsearch-setup-passwords auto
- be sure that you will remember them

Test cluster health:
curl -u elastic:elastic  -X GET "localhost:9200/_cluster/health?pretty"

Configure Kibana on Node 1

/bin/systemctl daemon-reload
/bin/systemctl enable kibana.service
nano /etc/kibana/kibana.yml 
Change followinglines:
server.port: 8801
server.host: "192.168.56.101"
elasticsearch.username: "kibana"
elasticsearch.password: "kibana"

sudo systemctl start kibana
create test user







### Contact
* Twitter - [@ViniciusMarc_](https://twitter.com/ViniciusMarc_)
* Linkedin - [Vinícius Vieira](https://www.linkedin.com/in/vinícius-vieira-0712251a3)
