FROM centos:7

LABEL "developer"="keqpup232" "product"="cetos_7 + elasticsearch_8.1.0"

RUN /bin/bash -c 'yum upgrade -y; \
                  yum install wget -y; \
                  yum install perl-Digest-SHA -y; \
                  wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.1.0-linux-x86_64.tar.gz; \
                  wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.1.0-linux-x86_64.tar.gz.sha512; \
                  shasum -a 512 -c elasticsearch-8.1.0-linux-x86_64.tar.gz.sha512; \
                  tar -xzf elasticsearch-8.1.0-linux-x86_64.tar.gz'

RUN /bin/bash -c 'rm -rf elasticsearch-8.1.0-linux-x86_64.tar.gz; \
                  rm -rf elasticsearch-8.1.0-linux-x86_64.tar.gz.sha512'

RUN /bin/bash -c 'groupadd elasticsearch; \
                  useradd elasticsearch -g elasticsearch -p elasticsearch'

COPY elasticsearch.yml /elasticsearch-8.1.0/config/

RUN /bin/bash -c 'chown -R elasticsearch:elasticsearch /elasticsearch-8.1.0/; \
                  mkdir /var/lib/logs; \
                  mkdir /var/lib/data; \
                  chown elasticsearch:elasticsearch /var/lib/logs; \
                  chown elasticsearch:elasticsearch /var/lib/data; \
                  chown -R elasticsearch:elasticsearch /elasticsearch-8.1.0/'

USER elasticsearch

ENV ES_PATH_CONF=/elasticsearch-8.1.0/config/

CMD /elasticsearch-8.1.0/bin/elasticsearch