![MailerQ | The most powerful MTA](https://media.copernica.com/logos/mailerq-logo.svg "MailerQ | The most powerful MTA")

# Dockerfiles for MailerQ AmqpDelayer

This repository contains the Dockerfile for MailerQ AmqpDelayer. Automatically built versions are available at [Docker Hub](https://hub.docker.com/r/mailerq/amqpdelayer/).

## Setup

The MailerQ AmqpDelayer is typically configured using environment variables. While you can provide a custom configuration file, using environment variables is the recommended and most common approach for Docker deployments.

The default configuration file is stored at `/etc/copernica/amqpdelayer.txt` inside the container. All settings from this file can be overridden using environment variables.

**Configuration Options**

The following options can be configured for the MailerQ AmqpDelayer.  These settings control how the AmqpDelayer reads messages from a RabbitMQ message queue, holds them for a while, and then publishes them back to RabbitMQ.  Environment variables are the preferred method for configuring these options.

*   **`AMQPDELAYER_RABBITMQ_ADDRESS`**:  The RabbitMQ address in `amqp://user:password@hostname/vhost` format. This is a *required* setting.
*   **`AMQPDELAYER_RABBITMQ_QUEUE`**: The name of the queue from which messages are read. This is a *required* setting.
*   **`AMQPDELAYER_RABBITMQ_EXCHANGE`**: The name of the exchange to which messages are published after their delay. This is a *required* setting.
*   **`AMQPDELAYER_RABBITMQ_ROUTINGKEY`**: The routing key used to publish messages. If you leave this empty, messages will be published with their original routing key.
*   **`AMQPDELAYER_RABBITMQ_USEREPLYTO`**: Whether to respect the "reply-to" message property. If set to `true`, messages with a routing-key set in their envelope will be sent back to this reply-to exchange, and the `AMQPDELAYER_RABBITMQ_EXCHANGE` setting will be ignored for those messages.

See all supported options in [documentation](https://www.mailerq.com/documentation/5.13/mailerq-amqpdelayer)

**Overriding Configuration with Environment Variables**

Any setting from the `/etc/copernica/amqpdelayer.txt` configuration file can be overridden using environment variables. To create the environment variable name:

1.  Convert the configuration setting name to uppercase.
2.  Replace dashes (`-`) with underscores (`_`).

For example, the `rabbitmq-address` setting becomes the `AMQPDELAYER_RABBITMQ_ADDRESS` environment variable.

**Alternative Configuration Methods**

Besides environment variables, you can also configure AmqpDelayer using the following methods:

*   **Configuration File:**  Mount a custom configuration file to `/etc/copernica/amqpdelayer.txt`.
*   **Command Line Arguments:** Pass settings directly as command-line arguments to the `docker run` command. For example: `docker run mailerq/amqpdelayer --rabbitmq-address amqp://...`

#### Example

```bash
# Build the Docker image
docker build ./MailerQ-AmqpDelayer/ -t mailerq/amqpdelayer

# Example using environment variables
docker run -d \
  -e AMQPDELAYER_RABBITMQ_ADDRESS="amqp://user:password@host:port/vhost" \
  -e AMQPDELAYER_RABBITMQ_QUEUE="my_queue" \
  -e AMQPDELAYER_RABBITMQ_EXCHANGE="my_exchange" \
  mailerq/amqpdelayer

# Example using a config file
docker run -v /path/to/minimal-config.txt:/etc/copernica/amqpdelayer.txt mailerq/amqpdelayer

# Example using command line arguments
docker run mailerq/amqpdelayer --rabbitmq-address amqp://user:password@host:port/vhost --rabbitmq-queue my_queue --rabbitmq-exchange my_exchange
```
