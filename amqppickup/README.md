![MailerQ | The most powerful MTA](https://media.copernica.com/logos/mailerq-logo.svg "MailerQ | The most powerful MTA")

# Dockerfiles for MailerQ AmqpPickup
This repository contains the Dockerfile for MailerQ AmqpPickup. Automatically built versions are available at [Docker Hub](https://hub.docker.com/r/mailerq/amqppickup/). 

## Setup
You need a minimal configuration file so AmqpPickup can connect to RabbitMQ.
```yaml
# the queue settings
rabbitmq-address: amqp://user:password@host:port/vhost
```

All options can be supplied in the system-wide config file, via environment variables, and as command line options. The config file is stored in /etc/copernica/amqppickup.txt. Each config file setting can also be passed as a command line argument, or supplied as an environment variable (where the variable name is converted to uppercase, and dashes to underscores). The following settings are thus equivalent:
 - the setting "rabbitmq-address" in the /etc/copernica/amqppickup.txt config file
 - the command line argument "--rabbitmq-address"
 - the environment variable "AMQPPICKUP_RABBITMQ_ADDRESS"

The application reads files from a specified pickup directory, and publishes them to the specified output queue, where they can be picked up by MailerQ.
 - **rabbitmq-address**: the address in amqp://user:password@hostname/vhost format.
 - **rabbitmq-output**: the name of the queue to which messages are published.

The value of rabbitmq-output can also be formatted as "exchange:routingkey". If you use this format, all messages published to the specified exchange with the specified routing key are consumed.

See all supported options in [documentation](https://www.mailerq.com/documentation/5.13/mailerq-amqppickup)

#### Example
```bash
docker build ./MailerQ-AmqpPickup/ -t amqppickup
docker run -v /path/to/minimal-config.txt:/etc/copernica/amqppickup.txt amqppickup
```
