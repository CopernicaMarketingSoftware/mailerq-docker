#!/bin/bash
#   entry.sh
#
#   This file will bootstrap MailerQ. It will capture any
#   MQ_* variables and rewrite them to *: value config entries,
#   and will add a randomly generated username and password to
#   the entries.
#
#   @author Michael van der Werve <michael.vanderwerve@copernica.com>
#   @copyright 2018 Copernica BV
#

# start the rabbitmq server and add the 'mailerq' user for external connection
service rabbitmq-server start

cat /etc/mailerq/config.txt

# process the username and password in the storage
rabbitmqctl add_user mailerq `cat /external/rabbitmq-password.txt`
rabbitmqctl set_permissions -p / mailerq ".*" ".*" ".*"
rabbitmqctl set_user_tags mailerq administrator

# startup the mailerq (-dev for now, much easier testing)
mailerq-dev --license /external/license.txt --database sqlite:///external/database.sqlite
