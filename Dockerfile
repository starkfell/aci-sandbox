# Pulling Image from https://hub.docker.com/r/matrixdotorg/synapse/

FROM matrixdotorg/synapse

# Updating packages list and installing Azure CLI prerequisite packages.
RUN apt-get update && apt-get install -y net-tools vim jq wget curl openssh-client apt-transport-https lsb-release software-properties-common dirmngr libunwind8 icu-devtools --no-install-recommends

