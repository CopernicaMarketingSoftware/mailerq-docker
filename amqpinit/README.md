![MailerQ | The most powerful MTA](https://media.copernica.com/logos/mailerq-logo.svg "MailerQ | The most powerful MTA")

## Dockerfiles for MailerQ AmqpInit
This repository contains the Dockerfile for MailerQ AmqpInit. Automatically built versions are available at [Docker Hub](https://hub.docker.com/r/mailerq/amqpinit/). 

## Setup
You typically run this script with one command line argument, and you pipe the JSON input into the program.

See JSON input file format in [documentation](https://www.mailerq.com/documentation/5.13/mailerq-amqpinit).

## Example
```bash
# Build the Docker image
docker build ./MailerQ-AmqpInit/ -t mailerq/amqpinit

# Example using command line arguments
docker run mailerq/amqpinit amqp://user:password@hostname/vhost < input.json
```
