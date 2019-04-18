# we take 16.04 as a base operating system
FROM ubuntu:16.04
MAINTAINER Copernica BV <michael.vanderwerve@mailerq.com>

# fix apt-specific things on docker
RUN apt-get update && apt-get install --no-install-recommends -y ca-certificates gnupg libidn11 curl apt-transport-https lsb-release && rm -rf /var/lib/apt/lists/*

# add the copernica repository and install mailerq
ADD https://packages.copernica.com/copernica.key /tmp/copernica.key
COPY version /version
RUN apt-key add /tmp/copernica.key
RUN echo "deb https://packages.copernica.com/debian stable main" | tee /etc/apt/sources.list.d/copernica.list
RUN apt-get update && apt-get install --no-install-recommends -y mailerq-`cat /version` && rm -rf /var/lib/apt/lists/*

# install additional dependencies for databases and such
RUN curl http://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-6-amd64.deb --output couchbase.deb && dpkg -i couchbase.deb && rm couchbase.deb
RUN apt-get update && apt-get install --no-install-recommends -y libmysqlclient20 libmongoc-1.0 libmariadb2 libpq5 libcouchbase2-bin && rm -rf /var/lib/apt/lists/*

# expose the ports for mailerq. note that this doesn't really 'expose' them but is more
# of a general hint towards the ports that will likely be used, for documentation purposes.
EXPOSE 25 80 443 

# make the temp dir for all the downloads, these are ephemeral so may die with the container.
RUN mkdir -p /tmp/downloads

# we do not want the default config file to be present, because there is no local rabbitmq and we want this
# file to be bound as well as the logfiles.
VOLUME ["/etc/mailerq", "/var/log/mailerq", "/tmp/downloads"] 

# bootstrap our entry point and the command to run
CMD rm -f /tmp/mailerq.pid && mailerq --lock=/tmp/mailerq.pid
