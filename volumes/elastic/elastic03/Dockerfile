FROM docker.elastic.co/elasticsearch/elasticsearch:7.6.2

USER root

RUN yum install -y sudo wget vim

COPY filebeat/ /usr/share/elasticsearch/temp/
COPY entrypoint.sh /usr/share/elasticsearch/

# USER elasticsearch

ENTRYPOINT [ "./entrypoint.sh" ]