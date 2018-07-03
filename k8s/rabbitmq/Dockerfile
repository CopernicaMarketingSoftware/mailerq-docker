FROM rabbitmq:3.6.6-management-alpine
ENV RABBITMQ_USE_LONGNAME=true \
    AUTOCLUSTER_LOG_LEVEL=debug \
    AUTOCLUSTER_CLEANUP=true \
    CLEANUP_INTERVAL=60 \
    CLEANUP_WARN_ONLY=false \
    AUTOCLUSTER_TYPE=k8s \
    LANG=en_US.UTF-8

# we manually install both the (new) plugins, because they have k8s support
RUN apk update && apk add ca-certificates wget openssl && update-ca-certificates
RUN wget https://github.com/rabbitmq/rabbitmq-autocluster/releases/download/0.10.0/autocluster-0.10.0.ez 
RUN wget https://github.com/rabbitmq/rabbitmq-autocluster/releases/download/0.10.0/rabbitmq_aws-0.10.0.ez 
RUN cp autocluster-0.10.0.ez rabbitmq_aws-0.10.0.ez /opt/rabbitmq/plugins/

# enable the autocluster plugin, which depends on rabbitmq_aws
RUN rabbitmq-plugins enable --offline autocluster