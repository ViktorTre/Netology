FROM centos:7

RUN yum update -y && \
    yum install curl -y && \
    yum install perl-Digest-SHA -y

ENV ES_DIR="usr/share/elasticsearch"
ENV ES_USER="elasticsearch"

RUN curl -O https://mirror.g-soft.info/elasticsearch/elasticsearch-7.17.12-x86_64.rpm && \
    yum -y localinstall elasticsearch-7.17.12-x86_64.rpm && \
    rm -f elasticsearch-7.17.12-x86_64.prm

RUN mkdir -p /var/lib/elasticsearch

COPY elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

RUN id -u ${ES_USER} &>/dev/null || useradd -m -d ${ES_DIR} elasticsearch

RUN mkdir -p ${ES_DIR}/logs && \
    chown -R elasticsearch:elasticsearch ${ES_DIR} && \
    chmod -R 777 ${ES_DIR}/logs

USER ${ES_USER}

EXPOSE 9200 9300

CMD ["usr/share/elasticsearch/bin/elasticsearch"]