![MailerQ | The most powerful MTA](https://media.copernica.com/logos/mailerq-logo.svg "MailerQ | The most powerful MTA")

# Dockerfiles for MailerQ AmqpDelayer
This repository contains the Dockerfile for MailerQ AmqpDelayer. Automatically built versions are available at [Docker Hub](https://hub.docker.com/r/mailerq/amqpdelayer/). 

## Setup
You need a minimal configuration file so AmqpDelayer can connect to RabbitMQ.
```yaml
# the queue settings
rabbitmq-address: amqp://user:password@host:port/vhost
```

All options can be supplied in the system-wide config file, via environment variables, and as command line options. The config file is stored in /etc/copernica/amqpdelayer.txt. Each config file setting can also be passed as a command line argument, or supplied as an environment variable (where the variable name is converted to uppercase, and dashes to underscores). The following settings are thus equivalent:
 - the setting "rabbitmq-address" in the /etc/copernica/amqpdelayer.txt config file
 - the command line argument "--rabbitmq-address"
 - the environment variable "AMQPDELAYER_RABBITMQ_ADDRESS"

AmqpDelayer reads messages from a RabbitMQ message queue, holds them for a while, and then publishes them back to RabbitMQ. The following options can be used to configure this:
 - **rabbitmq-address**: the address in amqp://user:password@hostname/vhost format.
 - **rabbitmq-queue**: the name of the queue from which messages are read.
 - **rabbitmq-exchange**: the name of the exchange to which messages are published after their delay.
 - **rabbitmq-routingkey**: the routing key used to publish messages.
 - **rabbitmq-usereplyto**: whether to respect the "reply-to" message property.

If you leave the routing key empty, messages will be published with their original routing key. If the usereplyto is set to true, messages with a routing-key set in their envelope will be sent back to this reply-to exchange and the exchange from the config file is ignored.

See all supported options in [documentation](https://www.mailerq.com/documentation/5.13/mailerq-amqpdelayer)

#### Example
```bash
docker build ./MailerQ-AmqpDelayer/ -t amqpdelayer
docker run /path/to/minimal-config.txt:/etc/copernica/amqpdelayer.txt amqpdelayer
```
