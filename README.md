![MailerQ | The most powerful MTA](https://media.copernica.com/logos/mailerq-logo.svg "MailerQ | The most powerful MTA")

# Dockerfiles for MailerQ
This repository contains the Dockerfiles for MailerQ tools. Automatically built versions are available at at [Docker Hub](https://hub.docker.com/r/mailerq/). 

## Getting started
The easiest method to get started is to copy the license key from [here](https://www.mailerq.com/product/license/trial). If a LICENSE_KEY environmental variable is supplied, MailerQ will automatically fetch the appropriate license. 

Alternatively, the file itself can be downloaded, and bound using `-v` on container startup to `/etc/mailerq/license.txt`. See our [documentation](https://www.mailerq.com/documentation/5.13/configuration) for appropriate configuration file values. 
