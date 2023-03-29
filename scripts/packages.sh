#!/usr/bin/env bash

set -euox pipefail

replicated_url="https://s3.amazonaws.com/replicated-airgap-work/replicated.tar.gz"

export APTARGS="-qq -o=Dpkg::Use-Pty=0"
export DEBIAN_FRONTEND=noninteractive

DEBIAN_FRONTEND=noninteractive apt-get --assume-yes clean ${APTARGS}
DEBIAN_FRONTEND=noninteractive rm -rf /var/lib/apt/lists/partial/
DEBIAN_FRONTEND=noninteractive apt-get --assume-yes update ${APTARGS}

DEBIAN_FRONTEND=noninteractive apt-get --assume-yes upgrade ${APTARGS}

DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes ${APTARGS} htop git vim curl wget tar software-properties-common htop unattended-upgrades gpg-agent apt-transport-https ca-certificates thin-provisioning-tools

unattended-upgrades -v

#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
#echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

DEBIAN_FRONTEND=noninteractive apt-get -y update ${APTARGS}

#DEBIAN_FRONTEND=noninteractive apt-get -y install net-tools docker-ce=5:20.10.9~3-0~ubuntu-focal docker-ce-cli=5:20.10.9~3-0~ubuntu-focal containerd.io awscli jq neovim unzip ${APTARGS}

#DEBIAN_FRONTEND=noninteractive apt-get -y install net-tools containerd.io awscli jq neovim unzip ${APTARGS}

DEBIAN_FRONTEND=noninteractive apt-get -y install net-tools containerd libseccomp2 awscli jq neovim unzip ${APTARGS}

curl -s https://packagecloud.io/install/repositories/netdata/netdata/script.deb.sh | DEBIAN_FRONTEND=noninteractive bash

DEBIAN_FRONTEND=noninteractive apt-get --assume-yes update ${APTARGS}
DEBIAN_FRONTEND=noninteractive apt-get --assume-yes upgrade ${APTARGS}
DEBIAN_FRONTEND=noninteractive apt-get --assume-yes install netdata ${APTARGS}

systemctl enable netdata.service

mkdir -p /etc/replicated

echo "$(date +"%T_%F") Downloading replicated"

curl --output /etc/replicated/replicated.tar.gz "$replicated_url"

echo "$(date +"%T_%F") Extracting replicated"

tar --directory /etc/replicated --extract --file /etc/replicated/replicated.tar.gz

echo "$(date +"%T_%F") containerd version"

containerd --version

echo "$(date +"%T_%F") runc version"

runc --version
