FROM ubuntu:18.04
MAINTAINER Copernica BV <michael.vanderwerve@copernica.com>

# fix apt-specific things on docker
#ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y strace curl apt-transport-https

# install the rabbitmq (standalone only)
# https://www.rabbitmq.com/which-erlang.html
RUN curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.deb.sh | bash
RUN apt-get install rabbitmq-server=3.7.6-1 -y
RUN service rabbitmq-server start
RUN rabbitmq-plugins enable rabbitmq_management --offline

# add the copernica repository and install mailerq
ADD https://packages.copernica.com/copernica.key /tmp/copernica.key
RUN apt-key add /tmp/copernica.key
RUN echo "deb https://packages.copernica.com/debian stable main" | tee /etc/apt/sources.list.d/copernica.list
RUN apt-get update && apt-get install -y mailerq-5.1

# expose the ports for mailerq
EXPOSE 25 80 443 

# and rabbitmq
EXPOSE 5672 15672

# copy our entry script to the machine
COPY entry.sh /usr/bin/mq-entry.sh

# make the temp dir for all the downloads
RUN mkdir -p /tmp/downloads

# bootstrap our entry point and the command to run
ENTRYPOINT ["/usr/bin/mq-entry.sh"]
CMD rm -f /tmp/mailerq.pid && mailerq --lock=/tmp/mailerq.pid