# Pulling Ubuntu Image from Docker Hub
FROM alpine:latest

# Updating packages list and installing the prerequisite packages
RUN apt-get update && apt-get install -y \
net-tools \
vim \
jq \
wget \
curl \
openssh-client \
nginx \
lsb-release \
apt-transport-https \
--no-install-recommends

WORKDIR /opt
EXPOSE 80
EXPOSE 443

ENTRYPOINT ["tail", "-f", "/dev/null"]
