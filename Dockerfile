# Pulling Ubuntu Image from Docker Hub
# FROM ubuntu:xenial

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

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y build-essential mongodb-org nodejs npm graphicsmagick
RUN npm install -g inherits n && n 8.11.3

RUN curl -L https://releases.rocket.chat/latest/download -o /tmp/rocket.chat.tgz
RUN tar -xzf /tmp/rocket.chat.tgz -C /tmp
RUN cd /tmp/bundle/programs/server && npm install
RUN mv /tmp/bundle /opt/Rocket.Chat



WORKDIR /opt
EXPOSE 80
EXPOSE 443

ENTRYPOINT ["tail", "-f", "/dev/null"]
