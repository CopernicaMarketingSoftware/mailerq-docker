# Dockerfiles for MailerQ
This repository contains the Dockerfiles for MailerQ from version 5.0 and upward. Automatically built versions are available at at [Docker Hub](https://hub.docker.com/r/mailerq/mailerq/). 

Currently, it is a completely self-contained version of MailerQ, for testing purposes.

## Self-contained image for MailerQ
This image is a self-contained version to run MailerQ locally or in the cloud. It contains RabbitMQ and uses an SQLite database for storage. Note that unless the these storage locations are bound to host folders, storage is ephemeral and a restart will be a completely new instance of MailerQ, with no retained settings and no retained on-queue messages.

### Getting started
The easiest method to get started is to copy the license key from [here](https://www.mailerq.com/product/license/trial). If a LICENSE_KEY environmental variable is supplied, MailerQ will automatically fetch the appropriate license. 

Alternatively, the file itself can be downloaded, and bound using `-v` on container startup to `/etc/mailerq/license.txt`. See our [documentation](https://www.mailerq.com/documentation/5.1/configuration) for appropriate configuration file values. 

On startup, a random password is generated for the contained RabbitMQ instance. To make this password a fixed value, the `RABBITMQ_PASSWORD` environmental variable can be passed, which will then be used instead.

#### Example
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

### Versions
- `latest` - Always points to the most recent stable version, currently `5.1`.
- `5.1` - MailerQ 5.1
- `5.0` - MailerQ 5.0
- `dev` - Nightly build

## Unit image for MailerQ
This image is an image which can be safely run in production. As opposed to the self-contained image above, in production setting the RabbitMQ server runs separately from the MailerQ server. This is mainly because MailerQ may be ephemeral, and multiple MailerQ instances may connect to a single RabbitMQ instance, all working on the same queue and communication with each other over RabbitMQ. 

### Setup 
Although this setup is slightly more involved than the simple standalone image for local testing, it is still relatively simple. To run the image, first create a folder with your configuration files. The folder will contain two files, `config.txt` and `license.txt`. For more information (and a minimal configuration) see the [MailerQ documentation](https://www.mailerq.com/documentation/5.1/configuration). Copy your config file to the folder, and run the following command.

```
docker run --net=host -v </path/to/config/folder>:/etc/mailerq/ -it mailerq/mailerq:lastest-unit mailerq --fetch-license <license-key-here>
```

This will show a prompt asking you to save your license. Type `y`, and your license will be saved. You are now done! To run MailerQ, simply run the last command but remove the `--fetch-license` part with your license key. 

### Versions
- `latest-unit` - Always points to the most recent stable version, currently `5.1`.
- `5.1-unit` - MailerQ 5.1
- `5.0-unit` - MailerQ 5.0
