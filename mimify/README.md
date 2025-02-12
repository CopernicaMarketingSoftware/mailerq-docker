![MailerQ | The most powerful MTA](https://media.copernica.com/logos/mailerq-logo.svg "MailerQ | The most powerful MTA")

# Dockerfiles for MailerQ Mimify
This repository contains the Dockerfile for MailerQ Mimify. Automatically built versions are available at [Docker Hub](https://hub.docker.com/r/mailerq/mimify/). 

## Setup
All options can be supplied in the system-wide config file, via environment variables, and as command line options. The config file is stored in /etc/copernica/mimify.txt. Each config file setting can also be passed as a command line argument, or supplied as an environment variable (where the variable name is converted to uppercase, and dashes to underscores). The following settings are thus equivalent:
 - the setting "rabbitmq-address" in the /etc/copernica/mimify.txt config file
 - the command line argument "--rabbitmq-address"
 - the environment variable "MIMIFY_RABBITMQ_ADDRESS"

The mimify tool reads all instructions from a RabbitMQ message queue, and writes the results back to RabbitMQ. The following options can be used to configure this:
 - **rabbitmq-address**: the address in amqp://user:password@hostname/vhost format.
 - **rabbitmq-input**: name of the queue from which messages are read.
 - **rabbitmq-output**: name of the exchange to which processed messages are published.
 - **rabbitmq-qos**: number of messages to keep in memory (equals max number of conversion operations in progress).

See all supported options in [documentation](https://www.mailerq.com/documentation/5.13/mailerq-mimify)

#### Example
```bash
docker build ./MailerQ-Mimify/ -t mimify
docker run -v /path/to/minimal-config.txt:/etc/copernica/mimify.txt mimify
```
