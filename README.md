# Elastic Containerized Stack (ELKCS)
A complete ELK Stack environment containerized and able to be used in DEV or PROD

## Contains 
* Elasticsearch (cluster)
* Kibana
* Logstash
* Metricbeat for Metrics Monitoring
* Filebeat to collect logs

### Status
For now you can create a cluster of Elasticsearch to handle more data processing and with a little tricks and magic be able to run the cluster on swarm mode.

## How to use
Here we need some adaptations, as the stack is suposed to be used on DEV or PROD( still testing ) the x-autentication needs to be enabled. 
### Basic
To start the cluster
```
docker-compose up -d 
```
To stop the cluster
```
docker-compose down
```

## Setting up the cluster

### Creating Elastisearch Nodes
* Create the stack-cert on Master Node ( es01 )

```
$ docker exec es01 bin/elasticsearc-certutil ca && mv elastic-stack.p12 config/certs/

```
> *Obs*: no need to create a password, if you want you'll need extra steps to me the cluster works. You can find the information you need [here](https://www.elastic.co/guide/en/elastic-stack-get-started/7.7/get-started-docker.html#get-started-docker-tls) 

* On Each Node ( including Master )
```
$ docker exec esXX bin/elasticsearch-certutil cert --ca /config/certs/elastic-stack-ca.p12 && mv elastic-certificates.p12 /config/certs
```
After generating the certs you can uncomment the volume that binds the elasticsearch.yml from each node on docker-compose.yml
and run the following commands:
```
$ chown 1000:0 -R volumes/
```

#### Running a single node
To run a single elasticsearch node you don't need to set up the certs, so you can remove these lines from your elasticsearch.yml file:
``` 
xpack.security.transport.ssl.verification_mode: certificate
xpack.security.transport.ssl.keystore.path: elastic-certificates.p12
xpack.security.transport.ssl.truststore.path: elastic-certificates.p12
```
## Set passwords for default users
You have two options, set ut the passwords manually or automatic, if you choose automatic don't forget to save the passwords, otherwise you won't be able to use your cluster.
* Manually
```
$ docker exec es01 bin/elasticsearch-setup-passwords interactive -b
```
* Automatic
```
$ docker exec es01 bin/elasticsearch-setup-passwords auto
```
## Test cluster health
```
$ curl -u elastic:<your_awesome_password>  -XGET "172.100.22.4:9200/_cluster/health?pretty"
```

( in progress....)

### Contact
* Twitter - [@ViniciusMarc_](https://twitter.com/ViniciusMarc_)
* Linkedin - [Vinícius Vieira](https://www.linkedin.com/in/vinícius-vieira-0712251a3)

Another test
