# use ubuntu 18.04 as a base
FROM ubuntu:18.04
MAINTAINER Copernica BV <michael.vanderwerve@mailerq.com>

# everything is non-interactive
ENV DEBIAN_FRONTEND=noninteractive 
ENV DEBCONF_NONINTERACTIVE_SEEN=true

# fix apt-specific things on docker
RUN apt-get update && apt-get install --no-install-recommends -y wget ca-certificates strace curl apt-transport-https libidn11 libmagic1 libxml2 gnupg && rm -rf /var/lib/apt/lists/*

# install the rabbitmq (standalone only)
# https://www.rabbitmq.com/which-erlang.html
RUN wget -O - "https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc" | apt-key add -
RUN echo "deb https://dl.bintray.com/rabbitmq-erlang/debian bionic erlang" | tee -a /etc/apt/sources.list
RUN curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.deb.sh | bash \
    && apt-get update \
    && apt-get install rabbitmq-server -y \
    && rm -rf /var/lib/apt/lists/* \
    && rabbitmq-plugins enable rabbitmq_management --offline

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
