![MailerQ | The most powerful MTA](https://media.copernica.com/logos/mailerq-logo.svg "MailerQ | The most powerful MTA")

## Dockerfiles for MailerQ AmqpPickup

This repository contains the Dockerfile for MailerQ AmqpPickup. Automatically built versions are available at [Docker Hub](https://hub.docker.com/r/mailerq/amqppickup/).

## Setup

The MailerQ AmqpPickup is typically configured using environment variables. While you can provide a custom configuration file, using environment variables is the recommended and most common approach for Docker deployments.

The default configuration file is stored at `/etc/copernica/amqppickup.txt` inside the container. All settings from this file can be overridden using environment variables.

#### Configuration Options

The following options can be configured for the MailerQ AmqpPickup. These settings control how AmqpPickup connects to RabbitMQ, reads files from a pickup directory, and publishes them to an output queue for MailerQ to process. Environment variables are the preferred method for configuring these options.

*   **`AMQPPICKUP_RABBITMQ_ADDRESS`**: The RabbitMQ address in `amqp://user:password@hostname/vhost` format. This is a *required* setting.
*   **`AMQPPICKUP_RABBITMQ_OUTPUT`**: The name of the queue to which messages are published. This is a *required* setting.  The value can also be formatted as `"exchange:routingkey"`. If you use this format, all messages are published to the specified exchange with the specified routing key.
*   **`AMQPPICKUP_DIRECTORY`**: The directory from which AmqpPickup reads files to publish to RabbitMQ.
*   **`AMQPPICKUP_REMOVE`**: Whether files should be removed after consumption.
*   **`AMQPPICKUP_OPEN_FILES`**: The number of files that will be processed simultaneously.
*   **`AMQPPICKUP_SCAN_INTERVAL`**: The interval (in milliseconds) between scanning the pickup directory. This is only useful for filesystems that do not support inotify.

See all supported options in [documentation](https://www.mailerq.com/documentation/5.13/mailerq-amqppickup)

#### Overriding Configuration with Environment Variables

Any setting from the `/etc/copernica/amqppickup.txt` configuration file can be overridden using environment variables. To create the environment variable name:

1.  Convert the configuration setting name to uppercase.
2.  Replace dashes (`-`) with underscores (`_`).

For example, the `rabbitmq-address` setting becomes the `AMQPPICKUP_RABBITMQ_ADDRESS` environment variable.

#### Alternative Configuration Methods

Besides environment variables, you can also configure AmqpPickup using the following methods:

*   **Configuration File:** Mount a custom configuration file to `/etc/copernica/amqppickup.txt`.
*   **Command Line Arguments:** Pass settings directly as command-line arguments to the `docker run` command. For example: `docker run mailerq/amqppickup --rabbitmq-address amqp://...`

## Example

```bash
# Build the Docker image
docker build ./MailerQ-AmqpPickup/ -t mailerq/amqppickup

# Example using environment variables
docker run -d \
  -e AMQPPICKUP_RABBITMQ_ADDRESS="amqp://user:password@host:port/vhost" \
  -e AMQPPICKUP_RABBITMQ_OUTPUT="my_queue" \
  -e AMQPPICKUP_PICKUP_DIRECTORY="/data/pickup" \
  mailerq/amqppickup

# Example using a config file
docker run -v /path/to/minimal-config.txt:/etc/copernica/amqppickup.txt mailerq/amqppickup

# Example using command line arguments
docker run mailerq/amqppickup --rabbitmq-address amqp://user:password@host:port/vhost --rabbitmq-output my_queue
```
