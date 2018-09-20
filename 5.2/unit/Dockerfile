# we take 16.04 as a base operating system
FROM ubuntu:16.04
MAINTAINER Copernica BV <michael.vanderwerve@copernica.com>

# fix apt-specific things on docker
RUN apt-get update && apt-get install -y strace curl apt-transport-https

# add the copernica repository and install mailerq
ADD https://packages.copernica.com/copernica.key /tmp/copernica.key
RUN apt-key add /tmp/copernica.key
RUN echo "deb https://packages.copernica.com/debian stable main" | tee /etc/apt/sources.list.d/copernica.list
RUN apt-get update && apt-get install -y mailerq-5.1

# install additional dependencies for databases and such
RUN apt-get update && apt-get install -y libmysqlclient20 libmongoc-1.0 libmariadb2 libpq5 

# install couchbase 
RUN apt-get update && apt-get install -y lsb-release
RUN curl http://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-4-amd64.deb --output couchbase.deb && dpkg -i couchbase.deb && rm couchbase.deb
RUN apt-get update && apt-get install -y libcouchbase2-bin

# expose the ports for mailerq. note that this doesn't really 'expose' them but is more
# of a general hint towards the ports that will likely be used, for documentation purposes.
EXPOSE 25 80 443 

# make the temp dir for all the downloads, these are ephemeral so may die with the container.
RUN mkdir -p /tmp/downloads

# we do not want the default config file to be present, because there is no local rabbitmq and we want this
# file to be bound as well as the logfiles.
VOLUME ["/etc/mailerq", "/var/log/mailerq"] 

# bootstrap our entry point and the command to run
CMD mailerq
