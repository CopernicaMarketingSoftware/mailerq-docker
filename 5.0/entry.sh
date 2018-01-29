#!/bin/bash
#   entry.sh
#
#   script will start up the rabbitmq server and add a user which can be
#   externally accessed.
#
#   @author Michael van der Werve <michael.vanderwerve@copernica.com>
#   @copyright 2018 Copernica BV
#

# start the rabbitmq server and add the 'mailerq' user for external connection
service rabbitmq-server start

# check if a password for the mailerq user has been provided
if [[ -z "${RABBITMQ_PASSWORD}" ]]; then
    # randomly generate a password for the mailerq user
    pass=`openssl rand -base64 32`
    echo 'Generated random password for RabbitMQ user `mailerq`:' $pass
    rabbitmqctl add_user mailerq $pass
else
    # pass was defined by docker
    rabbitmqctl add_user mailerq $RABBITMQ_PASSWORD
fi

# process the username and password in the storage
rabbitmqctl set_permissions -p / mailerq ".*" ".*" ".*"
rabbitmqctl set_user_tags mailerq administrator

# startup the mailerq (-dev for now, much easier testing)
mailerq-dev --license /external/license.txt --database sqlite:///external/database.sqlite
