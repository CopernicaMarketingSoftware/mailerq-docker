# use ubuntu 18.04 as a base
FROM ubuntu:18.04
MAINTAINER Copernica BV <michael.vanderwerve@mailerq.com>

# everything is non-interactive
ENV DEBIAN_FRONTEND=noninteractive 
ENV DEBCONF_NONINTERACTIVE_SEEN=true

# fix apt-specific things on docker
RUN apt-get update && apt-get install --no-install-recommends -y wget ca-certificates strace curl apt-transport-https libidn11 libmagic1 libxml2 gnupg && rm -rf /var/lib/apt/lists/*

# install the rabbitmq (standalone only)
# https://www.rabbitmq.com/install-debian.html#apt-quick-start-cloudsmith

## Team RabbitMQ's main signing key
RUN apt-key adv --keyserver "hkps://keys.openpgp.org" --recv-keys "0x0A9AF2115F4687BD29803A206B73A36E6026DFCA"

## Cloudsmith: modern Erlang repository
RUN curl -1sLf https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-erlang/gpg.E495BB49CC4BBE5B.key | sudo apt-key add -

## Cloudsmith: RabbitMQ repository
EUN curl -1sLf https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-server/gpg.9F4587F226208342.key | sudo apt-key add -

## Add apt repositories maintained by Team RabbitMQ
RUN echo "deb https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-erlang/deb/ubuntu bionic main" | tee /etc/apt/sources.list.d/rabbitmq-erlang.list
RUN echo "deb https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-server/deb/ubuntu bionic main" | tee /etc/apt/sources.list.d/rabbitmq-server.list

## Update package indices
RUN apt-get update -y

## Install Erlang packages
RUN apt-get install -y erlang-base \
                        erlang-asn1 erlang-crypto erlang-eldap erlang-ftp erlang-inets \
                        erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
                        erlang-runtime-tools erlang-snmp erlang-ssl \
                        erlang-syntax-tools erlang-tftp erlang-tools erlang-xmerl

## Install rabbitmq-server and its dependencies
RUN apt-get install rabbitmq-server -y --fix-missing

# add the copernica repository and install mailerq
ADD https://packages.copernica.com/copernica.key /tmp/copernica.key
COPY version /version
RUN apt-key add /tmp/copernica.key
RUN echo "deb https://packages.copernica.com/debian stable main" | tee /etc/apt/sources.list.d/copernica.list
RUN apt-get update && apt-get install --no-install-recommends -y mailerq-`cat /version` && rm -rf /var/lib/apt/lists/*

# expose the ports for mailerq
EXPOSE 25 80 443 

# and rabbitmq
EXPOSE 5672 15672

# copy our entry script to the machine
COPY entry.sh /usr/bin/mq-entry.sh

# make the temp dir for all the downloads
RUN mkdir -p /tmp/downloads

# create volumes by default
VOLUME ["/etc/mailerq", "/var/log/mailerq", "/tmp/downloads"] 

# bootstrap our entry point and the command to run
ENTRYPOINT ["/usr/bin/mq-entry.sh"]
CMD rm -f /tmp/mailerq.pid && mailerq --lock=/tmp/mailerq.pid
