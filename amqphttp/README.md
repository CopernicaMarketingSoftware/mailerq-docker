![MailerQ | The most powerful MTA](https://media.copernica.com/logos/mailerq-logo.svg "MailerQ | The most powerful MTA")

# Dockerfiles for MailerQ AmqpHttp
This repository contains the Dockerfile for MailerQ AmqpHttp. Automatically built versions are available at [Docker Hub](https://hub.docker.com/r/mailerq/amqphttp/). 

## Setup
All options can be supplied in the system wide config file, via environment variables and as command line options. The config file is stored in /etc/copernica/amqphttp.txt. Options from the config file can be overridden by passing them as command line arguments or environment variables. The "rabbitmq-address" setting, for example, can be provided in the following ways:
 - the setting "rabbitmq-address" in the /etc/copernica/httpcaller.txt config file
 - the command line argument "--rabbitmq-address"
 - the environment variable "AMQPHTTP_RABBITMQ_ADDRESS"

The application reads out the MailerQ result queue from RabbitMQ, converts the messages, and publishes them back to a different queue, where they can be picked up by the httpcaller.
 - **rabbitmq-address**: the address in amqp://user:password@hostname/vhost format.
 - **rabbitmq-queue**: the name of the queue from which messages are read.
 - **rabbitmq-exchange**: the exchange to which the converted messages are published.
 - **rabbitmq-routingkey**: the name of the routing key for the converted messages.
 - **rabbitmq-qos**: quality of service / how many messages to consume.

The queue name can also be formatted as "exchange:routingkey". If you use this format, all messages published to the specified exchange with the specified routing key are consumed.

See all supported options in [documentation](https://www.mailerq.com/documentation/5.13/mailerq-amqphttp)

#### Example
```bash
docker build ./MailerQ-AmqpHttp/ -t amqphttp
docker run /path/to/minimal-config.txt:/etc/copernica/amqphttp.txt amqphttp
```
