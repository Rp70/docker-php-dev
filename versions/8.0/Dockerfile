FROM rp70/php-fpm:8.0
LABEL maintainer="https://github.com/Rp70/docker-php-dev"

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive

COPY files/ /

# Installing Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs

# Installing Grunt
RUN set -ex && \
    npm install -g grunt-cli

# Installing OpenSSH server & related tools
RUN set -ex && \
    apt-install openssh-server sudo && \
    mkdir /run/sshd

# Installing other tools
RUN set -ex && \
    apt-install nano

# Installing Mariadb Client
RUN set -ex && \
    apt-install mariadb-client

RUN set -ex && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

COPY init.d/* /docker-entrypoint-init.d/
