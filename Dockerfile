# Pulling Ubuntu Image from Docker Hub
FROM alpine:latest

# Updating packages list and installing the prerequisite packages
RUN apk update && apk add \
net-tools \
vim \
jq \
wget \
curl \
nginx

WORKDIR /opt
EXPOSE 80
EXPOSE 443

ENTRYPOINT ["tail", "-f", "/dev/null"]
