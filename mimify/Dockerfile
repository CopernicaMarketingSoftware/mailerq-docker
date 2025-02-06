# use debian bookworm as a base
FROM debian:bookworm-slim
LABEL maintainer="Copernica BV <paloma.galvan@copernica.com>"

# everything is non-interactive
ENV DEBIAN_FRONTEND=noninteractive 

# install the dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gnupg \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# download and install the gpg key
RUN gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/mailerq-packages.gpg --keyserver keyserver.ubuntu.com --recv-keys 90DE523265E3563E

# add the MailerQ repository
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/mailerq-packages.gpg] https://packages.mailerq.com/debian bookworm main" > /etc/apt/sources.list.d/mailerq-packages.list

# install MailerQ mimify
RUN apt-get update && \
    apt-get install -y --no-install-recommends mailerq-mimify && \
    rm -rf /var/lib/apt/lists/*

# the command that starts everything
ENTRYPOINT ["mimify"]
