![MailerQ | The most powerful MTA](https://media.copernica.com/logos/mailerq-logo.svg "MailerQ | The most powerful MTA")

## Dockerfile for MailerQ Unit
This image is an image which can be safely run in production. As opposed to the self-contained MailerQ image, in production setting the RabbitMQ server runs separately from the MailerQ server. This is mainly because MailerQ may be ephemeral, and multiple MailerQ instances may connect to a single RabbitMQ instance, all working on the same queue and communication with each other over RabbitMQ. 

### Getting started
The easiest method to get started is to copy the license key from [here](https://www.mailerq.com/product/license/trial). If a LICENSE_KEY environmental variable is supplied, MailerQ will automatically fetch the appropriate license. 

Alternatively, the file itself can be downloaded, and bound using `-v` on container startup to `/etc/mailerq/license.txt`. See our [documentation](https://www.mailerq.com/documentation/5.13/configuration) for appropriate configuration file values. 

### Setup 
Although this setup is slightly more involved than the simple standalone image for local testing, it is still relatively simple. To run the image, first create a folder with your configuration files. The folder will contain two files, `config.txt` and `license.txt`. For more information (and a minimal configuration) see the [MailerQ documentation](https://www.mailerq.com/documentation/5.13/configuration). Copy your config file to the folder, and run the following command.

```
docker run --net=host -v </path/to/config/folder>:/etc/mailerq/ -it mailerq/mailerq:lastest-unit mailerq --fetch-license <license-key-here>
```

This will show a prompt asking you to save your license. Type `y`, and your license will be saved. You are now done! To run MailerQ, simply run the last command but remove the `--fetch-license` part with your license key. 
