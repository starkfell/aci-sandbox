# Pulling Ubuntu Image from Docker Hub
FROM ubuntu:xenial

# Updating packages list and installing the prerequisite packages
RUN apt-get update && apt-get install -y \
net-tools \
vim \
jq \
wget \
curl \
openssh-client \
nginx \
apt-transport-https \
lsb-release \
build-essential \
python2.7-dev \
libffi-dev \
python-pip \
python-setuptools \
sqlite3 \
libssl-dev \
python-virtualenv \
libjpeg-dev \
libxslt1-dev \
--no-install-recommends

# Installing virtualenv
RUN /usr/bin/easy_install virtualenv
RUN virtualenv -p python2.7 ~/.synapse

 # Upgrading pip and installing Matrix Synapse Home Server
RUN bin/bash -c \
"source ~/.synapse/bin/activate && \
pip2.7 install --upgrade pip && \
pip2.7 install --upgrade setuptools && \
pip2.7 install https://github.com/matrix-org/synapse/tarball/master"

# Generating the Initial Configuration
RUN python -m synapse.app.homeserver \
--server-name aci-sandbox.westeurope.azurecontainer.io \
--config-path homeserver.yaml \
--generate-config \
--report-stats=no

# Starting the Home Server
RUN synctl start

WORKDIR /opt
EXPOSE 80
EXPOSE 443
EXPOSE 8448

# ENV SYNAPSE_SERVER_NAME=my.matrix.host
ENV POSTGRES_USER=synapse
ENV POSTGRES_PASSWORD=synapse
ENV SYNAPSE_REPORT_STATS=no
ENV SYNAPSE_ENABLE_REGISTRATION=yes
ENV SYNAPSE_LOG_LEVEL=INFO

ENTRYPOINT ["tail", "-f", "/dev/null"]
