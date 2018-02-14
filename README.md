# Dockerfiles for MailerQ
This repository contains the Dockerfiles for MailerQ from version 5.0 and upward. Automatically built 
versions are available at at [Docker Hub](https://hub.docker.com/r/mailerq/mailerq/). 

Currently, it is a completely self-contained version of MailerQ, for testing purposes.

## Self-contained image for MailerQ
This image is a self-contained version to run MailerQ locally or in the cloud. It contains RabbitMQ and uses 
an SQLite database for storage. Note that unless the these storage locations are bound to host folders, storage 
is ephemeral and a restart will be a completely new instance of MailerQ, with no retained settings and no retained on-queue messages.

### Getting started
The easiest method to get started is to copy the license key from [here](https://www.mailerq.com/product/license/trial). 
If a LICENSE_KEY environmental variable is supplied, MailerQ will automatically fetch the appropriate license. 

Alternatively, the file itself can be downloaded, and bound using `-v` on container startup to `/etc/mailerq/license.txt`.
See our [documentation](https://www.mailerq.com/documentation/5.0/configuration) for appropriate configuration file values. 

On startup, a random password is generated for the contained RabbitMQ instance. To make this password a fixed value, the 
`RABBITMQ_PASSWORD` environmental variable can be passed, which will then be used instead.

#### Example
First pull the image using `docker pull mailerq/mailerq:latest`, then run 
```docker run -e LICENSE_KEY=xxx -it mailerq/mailerq:latest```

If you get `The license file does not contain IP addresses that are configured on this server`, add the `--net=host` flag as such
```docker run --net=host -e LICENSE_KEY=xxx -it mailerq/mailerq:latest```

#### Database
To keep the database settings between runs, the database should be bound to a file on the host machine. This can
be done by adding ```-v `pwd`/database.sqlite:/var/lib/mailerq/database.sqlite``` to the command.

### Versions
- `latest` - Always points to the most recent stable version
- `5.0` - MailerQ 5.0
- `dev` - Nightly build
