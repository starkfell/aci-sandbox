# Pulling Ubuntu Image from Docker Hub
# FROM ubuntu:bionic
FROM snapcore/snapcraft:latest

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
--no-install-recommends


#RUN snap install rocketchat-server && \
#snap set rocketchat-server caddy-url=https://aci-sandbox.westeurope.azurecontainer.io && \
#snap set rocketchat-server caddy=enable && \
#snap set rocketchat-server https=enable && \
#rocketchat-server.initcaddy

WORKDIR /opt
EXPOSE 80
EXPOSE 443

ENTRYPOINT ["tail", "-f", "/dev/null"]
