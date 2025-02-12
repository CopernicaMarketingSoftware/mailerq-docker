![MailerQ | The most powerful MTA](https://media.copernica.com/logos/mailerq-logo.svg "MailerQ | The most powerful MTA")

# Dockerfiles for MailerQ HttpCaller
This repository contains the Dockerfile for MailerQ HttpCaller. Automatically built versions are available at [Docker Hub](https://hub.docker.com/r/mailerq/httpcaller/). 

## Setup
All options can be supplied in the system-wide config file, via environment variables, and as command line options. The config file is stored in /etc/copernica/httpcaller.txt. Each config file setting can also be passed as a command line argument, or supplied as an environment variable (where the variable name is converted to uppercase, and dashes to underscores). The following settings are thus equivalent:
 - the setting "rabbitmq-address" in the /etc/copernica/httpcaller.txt config file
 - the command line argument "--rabbitmq-address"
 - the environment variable "HTTPCALLER_RABBITMQ_ADDRESS"

HttpCaller reads all instructions from a RabbitMQ message queue, and writes the results back to RabbitMQ. The following options can be used to configure this:
 - **rabbitmq-address**: the address in amqp://user:password@hostname/vhost format.
 - **rabbitmq-api**: the REST API endpoint of the RabbitMQ server in http://user:password@hostname:port format.
 - **rabbitmq-queue**: the name of the queue from which messages are read.
 - **rabbitmq-exchange**: the exchange to which the results of the HTTP calls are published.
 - **rabbitmq-overflow-queues**: whether to use overflow queues, can be "true" or "false".
 - **rabbitmq-queue-type**: the type of queues to use for overflow queues ("classic" or "quorum").
 - **rabbitmq-routingkey-delayed**: the name of the routing key for delayed messages.
 - **rabbitmq-routingkey-failure**: the routing key for failures.
 - **rabbitmq-routingkey-success**: the routing key for successes.

See all supported options in [documentation](https://www.mailerq.com/documentation/5.13/mailerq-httpcaller)

#### Example
```bash
docker build ./MailerQ-HttpCaller/ -t httpcaller
docker run -v /path/to/minimal-config.txt:/etc/copernica/httpcaller.txt httpcaller
```
