FROM docker.elastic.co/beats/metricbeat:7.6.2
#RUN yum install sudo -y
ADD --chown=root:root metricbeat.yml /usr/share/metricbeat/
USER root
#RUN chown root:root /usr/share/metricbeat/metricbeat.yml
RUN chmod go-w /usr/share/metricbeat/metricbeat.yml
USER root