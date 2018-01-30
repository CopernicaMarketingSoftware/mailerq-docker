# Dockerfiles for MailerQ
This repository contains the Dockerfiles for MailerQ from version 5.0 and upward. Automatically built 
versions are available at at [Docker Hub](https://hub.docker.com/r/mailerq/mailerq/). 

Currently, it is a completely self-contained version of MailerQ, for testing purposes.

## Self-contained image for MailerQ
This image is a self-contained version to run MailerQ locally or in the cloud. It contains RabbitMQ and uses an SQLite database for storage. Note that unless the these storage locations are bound to host folders, storage is ephemeral and a restart will be a completely new instance of MailerQ, with no retained settings and no retained on-queue messages.

### Getting started
The easiest method to get started is to copy the license key from [here](https://www.mailerq.com/product/license/trial). If a LICENSE_KEY environmental variable is supplied, MailerQ will automatically fetch the appropriate license. 

Alternatively, the file itself can be downloaded, and bound using `-v` on container startup to `/etc/mailerq/license.txt`. See our [documentation](https://www.mailerq.com/documentation/5.0/configuration) for appropriate configuration file values. 

On startup, a random password is generated for the contained RabbitMQ instance. To fix this password, the `RABBITMQ_PASSWORD` environmental variable can be passed, which will then be used instead.

#### Example
First pull the image using `docker pull mailerq/mailerq:dev`, then run 
```docker run -e LICENSE_KEY=xxx -it mailerq/mailerq:dev```

### Versions
- `dev` - Nightly build
