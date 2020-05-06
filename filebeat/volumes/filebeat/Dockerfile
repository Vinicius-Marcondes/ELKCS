FROM docker.elastic.co/beats/filebeat:7.6.2
COPY filebeat.yml /usr/share/filebeat/filebeat.yml
USER root
RUN rm -fr /etc/localtime
RUN ln -s /usr/share/zoneinfo/CET /etc/localtime
USER filebeat
