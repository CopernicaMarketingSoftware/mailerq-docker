![MailerQ | The most powerful MTA](https://media.copernica.com/logos/mailerq-logo.svg "MailerQ | The most powerful MTA")

## Dockerfiles for MailerQ Mimify

This repository contains the Dockerfile for MailerQ Mimify. Automatically built versions are available at [Docker Hub](https://hub.docker.com/r/mailerq/mimify/).

## Setup

The MailerQ Mimify tool is typically configured using environment variables. While you can provide a custom configuration file, using environment variables is the recommended and most common approach for Docker deployments.

The default configuration file is stored at `/etc/copernica/mimify.txt` inside the container. All settings from this file can be overridden using environment variables.

#### Configuration Options

The following options can be configured for the MailerQ Mimify tool. These settings control how the Mimify tool reads messages from a RabbitMQ message queue, processes them, and then publishes the results back to RabbitMQ. Environment variables are the preferred method for configuring these options.

*   **`MIMIFY_RABBITMQ_ADDRESS`**: The RabbitMQ address in `amqp://user:password@hostname/vhost` format. This is a *required* setting.
*   **`MIMIFY_RABBITMQ_INPUT`**: The name of the queue from which messages are read. This is a *required* setting.
*   **`MIMIFY_RABBITMQ_OUTPUT`**: The name of the exchange to which processed messages are published. This is a *required* setting.
*   **`MIMIFY_RABBITMQ_QOS`**: The number of messages to keep in memory (equals the maximum number of conversion operations in progress).

See all supported options in [documentation](https://www.mailerq.com/documentation/5.13/mailerq-mimify)

#### Overriding Configuration with Environment Variables

Any setting from the `/etc/copernica/mimify.txt` configuration file can be overridden using environment variables. To create the environment variable name:

1.  Convert the configuration setting name to uppercase.
2.  Replace dashes (`-`) with underscores (`_`).

For example, the `rabbitmq-address` setting becomes the `MIMIFY_RABBITMQ_ADDRESS` environment variable.

#### Alternative Configuration Methods

Besides environment variables, you can also configure Mimify using the following methods:

*   **Configuration File:** Mount a custom configuration file to `/etc/copernica/mimify.txt`.
*   **Command Line Arguments:** Pass settings directly as command-line arguments to the `docker run` command. For example: `docker run mailerq/mimify --rabbitmq-address amqp://...`

## Example

```bash
# Build the Docker image
docker build ./MailerQ-Mimify/ -t mailerq/mimify

# Example using environment variables
docker run -d \
  -e MIMIFY_RABBITMQ_ADDRESS="amqp://user:password@host:port/vhost" \
  -e MIMIFY_RABBITMQ_INPUT="my_input_queue" \
  -e MIMIFY_RABBITMQ_OUTPUT="my_output_exchange" \
  mailerq/mimify

# Example using a config file
docker run -v /path/to/minimal-config.txt:/etc/copernica/mimify.txt mailerq/mimify

# Example using command line arguments
docker run mailerq/mimify --rabbitmq-address amqp://user:password@host:port/vhost --rabbitmq-input my_input_queue --rabbitmq-output my_output_exchange
```
