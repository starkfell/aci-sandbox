# Pulling Image from https://hub.docker.com/r/matrixdotorg/synapse/

FROM matrixdotorg/synapse:latest

# Updating packages list and installing Azure CLI prerequisite packages.
RUN apt-get update && apt-get install -y \
net-tools \
vim \
jq \
get \
curl \
openssh-client \
apt-transport-https \
lsb-release \
--no-install-recommends

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
