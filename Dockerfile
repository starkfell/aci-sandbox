# Pulling Image from https://hub.docker.com/r/matrixdotorg/synapse/

FROM ubuntu:xenial

# Updating packages list and installing Azure CLI prerequisite packages.
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

RUN wget -qO - https://matrix.org/packages/debian/repo-key.asc | apt-key add add-apt-repository https://matrix.org/packages/debian/

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
