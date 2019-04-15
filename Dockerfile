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
lsb-release \
apt-transport-https \
--no-install-recommends

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E52529D4
RUN echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" > /etc/apt/sources.list.d/mongodb-org-4.0.list
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update && apt-get install -y build-essential mongodb-org nodejs npm graphicsmagick
RUN npm install -g inherits n && n 8.11.3

RUN curl -L https://releases.rocket.chat/latest/download -o /tmp/rocket.chat.tgz
RUN tar -xzf /tmp/rocket.chat.tgz -C /tmp
RUN cd /tmp/bundle/programs/server && npm install
RUN mv /tmp/bundle /opt/Rocket.Chat
RUN useradd -M rocketchat && usermod -L rocketchat
RUN chown -R rocketchat:rocketchat /opt/Rocket.Chat &
RUN echo -e "[Unit]\nDescription=The Rocket.Chat server\nAfter=network.target remote-fs.target nss-lookup.target nginx.target mongod.target\n[Service]\nExecStart=/usr/local/bin/node /opt/Rocket.Chat/main.js\nStandardOutput=syslog\nStandardError=syslog\nSyslogIdentifier=rocketchat\nUser=rocketchat\nEnvironment=MONGO_URL=mongodb://localhost:27017/rocketchat ROOT_URL=http://aci-sandbox.westeurope.azurecontainer.io:3000/ PORT=3000\n[Install]\nWantedBy=multi-user.target" | tee /lib/systemd/system/rocketchat.service

# MONGO_URL=mongodb://localhost:27017/rocketchat
# ROOT_URL=http://your-host-name.com-as-accessed-from-internet:3000
# PORT=3000

RUN systemctl enable mongod && systemctl start mongod
RUN systemctl enable rocketchat && systemctl start rocketchat

WORKDIR /opt
EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/sbin/init", "splash"]
