# use redhat based systems as a base
FROM centos:latest

# we need wget
RUN yum install -y wget epel-release

# install latest erlang
RUN wget https://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm
RUN rpm -Uvh erlang-solutions-1.0-1.noarch.rpm
RUN yum install -y erlang socat logrotate

# install latest rabbit
RUN wget https://dl.bintray.com/rabbitmq/all/rabbitmq-server/3.7.10/rabbitmq-server-3.7.10-1.el7.noarch.rpm
RUN rpm --import https://www.rabbitmq.com/rabbitmq-signing-key-public.asc
RUN yum install -y rabbitmq-server-3.7.10-1.el7.noarch.rpm

# enable management console
RUN rabbitmq-plugins enable rabbitmq_management --offline

# install mailerq
RUN wget https://packages.copernica.com/rpm/copernica.repo -O /etc/yum.repos.d/copernica.repo
RUN yum -y update
RUN yum -y install mailerq

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
