FROM ubuntu:16.04
MAINTAINER Copernica BV <michael.vanderwerve@copernica.com>

# fix apt-specific things on docker
RUN apt-get update && apt-get install -y strace curl apt-transport-https

# install the rabbitmq (standalone only )
RUN curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.deb.sh | bash 
RUN apt-get install rabbitmq-server=3.6.14-1 -y
RUN service rabbitmq-server start
RUN rabbitmq-plugins enable rabbitmq_management

# add the copernica repository and install mailerq
ADD https://packages.copernica.com/copernica.key /tmp/copernica.key
RUN apt-key add /tmp/copernica.key
RUN echo "deb https://packages.copernica.com/debian stable main" | tee /etc/apt/sources.list.d/copernica.list
RUN apt-get update && apt-get install -y mailerq-dev

# install additional dependencies
RUN apt-get update && apt-get install -y libmysqlclient20 libmongoc-1.0 libmariadb2 libpq5 

# install couchbase
RUN apt-get update && apt-get install -y lsb-release
RUN curl http://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-4-amd64.deb --output couchbase.deb && dpkg -i couchbase.deb && rm couchbase.deb
RUN apt-get update && apt-get install -y libcouchbase2-bin

# expose the ports for mailerq
EXPOSE 25 80 443 

# and rabbitmq
EXPOSE 5672 15672

# copy our entry script to the machine
COPY entry.sh /usr/bin/mq-entry.sh

# bootstrap our entry point and the command to run
ENTRYPOINT ["/usr/bin/mq-entry.sh"]
