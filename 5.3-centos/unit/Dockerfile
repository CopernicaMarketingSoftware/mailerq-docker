# use redhat based systems as a base
FROM centos:latest

# we need wget
RUN yum install -y wget epel-release

# install mailerq
RUN wget https://packages.copernica.com/rpm/copernica.repo -O /etc/yum.repos.d/copernica.repo
RUN yum -y update
RUN yum -y install mailerq-5.3

# expose the ports for mailerq. note that this doesn't really 'expose' them but is more
# of a general hint towards the ports that will likely be used, for documentation purposes.
EXPOSE 25 80 443 

# make the temp dir for all the downloads, these are ephemeral so may die with the container.
RUN mkdir -p /tmp/downloads

# we do not want the default config file to be present, because there is no local rabbitmq and we want this
# file to be bound as well as the logfiles.
VOLUME ["/etc/mailerq", "/var/log/mailerq"] 

# bootstrap our entry point and the command to run
CMD rm -f /tmp/mailerq.pid && mailerq --lock=/tmp/mailerq.pid