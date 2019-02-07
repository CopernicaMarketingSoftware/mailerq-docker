#!/bin/bash
#   entry.sh
#
#   script will start up the rabbitmq server and add a user which can be
#   externally accessed.
#
#   @author Michael van der Werve <michael.vanderwerve@copernica.com>
#   @copyright 2018 - 2019 Copernica BV
#

# start the rabbitmq server and add the 'mailerq' user for external connection
/usr/sbin/rabbitmq-server & 

# rabbitmq needs to have started fully, should be really soon
sleep 5

# first we are going to try to fetch the licnse; if this fails, we're lost anyway
if [[ -n "${LICENSE_KEY}" ]]; then
    echo "y" | mailerq --fetch-license ${LICENSE_KEY}
elif [[ ! -f /etc/mailerq/license.txt ]]; then
    echo "License file does not exist. Either pass a LICENSE_KEY variable using -e or bind /etc/mailerq/license.txt using -v."
    exit 1
fi

# add mailerq user with permissions
rabbitmqctl add_user mailerq mailerq
rabbitmqctl set_permissions -p / mailerq ".*" ".*" ".*"
rabbitmqctl set_user_tags mailerq administrator

# we execute the command
exec "$@"