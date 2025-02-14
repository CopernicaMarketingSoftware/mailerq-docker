![MailerQ | The most powerful MTA](https://media.copernica.com/logos/mailerq-logo.svg "MailerQ | The most powerful MTA")

## Dockerfiles for MailerQ AmqpHttp

This repository contains the Dockerfile for MailerQ AmqpHttp. Automatically built versions are available at [Docker Hub](https://hub.docker.com/r/mailerq/amqphttp/).

## Setup

The MailerQ AmqpHttp is typically configured using environment variables. While you can provide a custom configuration file, using environment variables is the recommended and most common approach for Docker deployments.

The default configuration file is stored at `/etc/copernica/amqphttp.txt` inside the container. All settings from this file can be overridden using environment variables.

#### Configuration Options

The following options can be configured for the MailerQ AmqpHttp. These settings control how the application reads out the MailerQ result queue from RabbitMQ, converts the messages, and publishes them back to a different queue, where they can be picked up by the HTTP caller.

*   **`AMQPHTTP_RABBITMQ_ADDRESS`**: The address in `amqp://user:password@hostname/vhost` format. This is a *required* setting.
*   **`AMQPHTTP_RABBITMQ_QUEUE`**: The name of the queue from which messages are read. This is a *required* setting.
*   **`AMQPHTTP_RABBITMQ_EXCHANGE`**: The exchange to which the converted messages are published. This is a *required* setting.
*   **`AMQPHTTP_RABBITMQ_ROUTINGKEY`**: The name of the routing key for the converted messages. If you specify a format of `exchange:routingkey`, all messages published to the specified exchange with the specified routing key will be consumed.
*   **`AMQPHTTP_RABBITMQ_QOS`**: Quality of service specification defining how many messages to consume.

See all supported options in [documentation](https://www.mailerq.com/documentation/5.13/mailerq-amqphttp).

#### Overriding Configuration with Environment Variables

Any setting from the `/etc/copernica/amqphttp.txt` configuration file can be overridden using environment variables. To create the environment variable name:

1.  Convert the configuration setting name to uppercase.
2.  Replace dashes (`-`) with underscores (`_`).

For example, the `rabbitmq-address` setting becomes the `AMQPHTTP_RABBITMQ_ADDRESS` environment variable.

#### Alternative Configuration Methods

Besides environment variables, you can also configure AmqpHttp using the following methods:

*   **Configuration File:** Mount a custom configuration file to `/etc/copernica/amqphttp.txt`.
*   **Command Line Arguments:** Pass settings directly as command-line arguments to the `docker run` command. For example: `docker run mailerq/amqphttp --rabbitmq-address amqp://...`.

## Example

```bash
# Build the Docker image
docker build ./MailerQ-AmqpHttp/ -t mailerq/amqphttp

# Example using a config file
docker run -v /path/to/minimal-config.txt:/etc/copernica/amqphttp.txt mailerq/amqphttp

# Example using environment variables
docker run -d \
  -e AMQPHTTP_RABBITMQ_ADDRESS="amqp://user:password@host:port/vhost" \
  -e AMQPHTTP_RABBITMQ_QUEUE="my_queue" \
  -e AMQPHTTP_RABBITMQ_EXCHANGE="my_exchange" \
  mailerq/amqphttp

# Example using command line arguments
docker run mailerq/amqphttp --rabbitmq-address amqp://user:password@host:port/vhost --rabbitmq-queue my_queue --rabbitmq-exchange my_exchange
```
