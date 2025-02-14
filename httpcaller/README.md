![MailerQ | The most powerful MTA](https://media.copernica.com/logos/mailerq-logo.svg "MailerQ | The most powerful MTA")

## Dockerfiles for MailerQ HttpCaller

This repository contains the Dockerfile for MailerQ HttpCaller. Automatically built versions are available at [Docker Hub](https://hub.docker.com/r/mailerq/httpcaller/).

## Setup

The MailerQ HttpCaller is typically configured using environment variables. While you can provide a custom configuration file, using environment variables is the recommended and most common approach for Docker deployments.

The default configuration file is stored at `/etc/copernica/httpcaller.txt` inside the container. All settings from this file can be overridden using environment variables.

#### Configuration Options

The following options can be configured for the MailerQ HttpCaller. These settings control how the HttpCaller reads messages from a RabbitMQ message queue, makes HTTP requests, and then publishes the results back to RabbitMQ. Environment variables are the preferred method for configuring these options.

*   **`HTTPCALLER_RABBITMQ_ADDRESS`**: The RabbitMQ address in `amqp://user:password@hostname/vhost` format. This is a *required* setting.
*   **`HTTPCALLER_RABBITMQ_API`**: The REST API endpoint of the RabbitMQ server in `http://user:password@hostname:port` format.
*   **`HTTPCALLER_RABBITMQ_QUEUE`**: The name of the queue from which messages are read. This is a *required* setting.
*   **`HTTPCALLER_RABBITMQ_EXCHANGE`**: The exchange to which the results of the HTTP calls are published. This is a *required* setting.
*   **`HTTPCALLER_RABBITMQ_OVERFLOW_QUEUES`**: Whether to use overflow queues, can be `"true"` or `"false"`.
*   **`HTTPCALLER_RABBITMQ_QUEUE_TYPE`**: The type of queues to use for overflow queues (`"classic"` or `"quorum"`).
*   **`HTTPCALLER_RABBITMQ_ROUTINGKEY_DELAYED`**: The name of the routing key for delayed messages.
*   **`HTTPCALLER_RABBITMQ_ROUTINGKEY_FAILURE`**: The routing key for failures.
*   **`HTTPCALLER_RABBITMQ_ROUTINGKEY_SUCCESS`**: The routing key for successes.

See all supported options in [documentation](https://www.mailerq.com/documentation/5.13/mailerq-httpcaller)

#### Overriding Configuration with Environment Variables

Any setting from the `/etc/copernica/httpcaller.txt` configuration file can be overridden using environment variables. To create the environment variable name:

1.  Convert the configuration setting name to uppercase.
2.  Replace dashes (`-`) with underscores (`_`).

For example, the `rabbitmq-address` setting becomes the `HTTPCALLER_RABBITMQ_ADDRESS` environment variable.

#### Alternative Configuration Methods

Besides environment variables, you can also configure HttpCaller using the following methods:

*   **Configuration File:** Mount a custom configuration file to `/etc/copernica/httpcaller.txt`.
*   **Command Line Arguments:** Pass settings directly as command-line arguments to the `docker run` command. For example: `docker run mailerq/httpcaller --rabbitmq-address amqp://...`

## Example

```bash
# Build the Docker image
docker build ./MailerQ-HttpCaller/ -t mailerq/httpcaller

# Example using environment variables
docker run -d \
  -e HTTPCALLER_RABBITMQ_ADDRESS="amqp://user:password@host:port/vhost" \
  -e HTTPCALLER_RABBITMQ_QUEUE="my_queue" \
  -e HTTPCALLER_RABBITMQ_EXCHANGE="my_exchange" \
  mailerq/httpcaller

# Example using a config file
docker run -v /path/to/minimal-config.txt:/etc/copernica/httpcaller.txt mailerq/httpcaller

# Example using command line arguments
docker run mailerq/httpcaller --rabbitmq-address amqp://user:password@host:port/vhost --rabbitmq-queue my_queue --rabbitmq-exchange my_exchange
```
