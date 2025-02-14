![MailerQ | The most powerful MTA](https://media.copernica.com/logos/mailerq-logo.svg "MailerQ | The most powerful MTA")

# Dockerfiles for MailerQ
This repository contains the Dockerfiles for MailerQ from version 5.0 and upward. Automatically built versions are available at at [Docker Hub](https://hub.docker.com/r/mailerq/mailerq/). 

Currently, it is a completely self-contained version of MailerQ, for testing purposes.

## Getting started
The easiest method to get started is to copy the license key from [here](https://www.mailerq.com/product/license/trial). If a LICENSE_KEY environmental variable is supplied, MailerQ will automatically fetch the appropriate license. 

Alternatively, the file itself can be downloaded, and bound using `-v` on container startup to `/etc/mailerq/license.txt`. See our [documentation](https://www.mailerq.com/documentation/5.13/configuration) for appropriate configuration file values. 

## Image for MailerQ
If you want to use the MailerQ images without using the docker-compose file, you need to make RabbitMQ and MySQL instances available for MailerQ.

### Setup
You need a minimal configuration file so MailerQ can connect to RabbitMQ and MySQL.
```yaml
# the database address
database-address: mysql://user:password@host:port/database

# the queue settings
rabbitmq-address: amqp://user:password@host:port/vhost

# print application log to stdout
application-log: stdout
```

If you want to run MailerQ with the management console, you also need to provide the following.
```yaml
# Minimal management console configuration
www-port: 80
www-dir: /usr/share/mailerq/www
www-auth: hardcoded://mailerq:mailerq
```

#### License Key
A requirement, next to the config file, is the MailerQ license key or file. You can either mount an existing license file or give the `LICENSE_KEY` environment variable to the Dockerfile so it can generate a license.

#### Example
```bash
docker build ./MailerQ-Server-Frontend/ -t mailerq-server-frontend
docker run -e LICENSE_KEY=<your_mailerq_license_key> -v /path/to/minimal-config.txt:/etc/mailerq/config.txt mailerq-server
```

## Self-contained image for MailerQ
This image is a self-contained version to run MailerQ locally or in the cloud. It contains RabbitMQ and uses an SQLite database for storage. Note that unless the these storage locations are bound to host folders, storage is ephemeral and a restart will be a completely new instance of MailerQ, with no retained settings and no retained on-queue messages.

### Setup
First pull the image using `docker pull mailerq/mailerq:latest`, then run 
```
docker run -e LICENSE_KEY=<license-key-here> -it mailerq/mailerq:latest
```

If you get `The license file does not contain IP addresses that are configured on this server`, add the `--net=host` flag, for example
```
docker run --net=host -e LICENSE_KEY=<license-key-here> -it mailerq/mailerq:latest
```

#### Database
To persist the database settings between runs, the database should be bound to a file on the host machine. This can be done by adding ```-v `pwd`/database.sqlite:/var/lib/mailerq/database.sqlite``` to the command.
