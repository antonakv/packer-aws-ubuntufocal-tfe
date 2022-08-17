#!/usr/bin/env bash

export APTARGS="-qq -o=Dpkg::Use-Pty=0"
export DEBIAN_FRONTEND=noninteractive

sudo DEBIAN_FRONTEND=noninteractive apt-get clean ${APTARGS}
sudo DEBIAN_FRONTEND=noninteractive apt-get update ${APTARGS}

sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y ${APTARGS}

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y ${APTARGS} cloud-utils ctop htop git vim curl wget tar software-properties-common htop unattended-upgrades gpg-agent apt-transport-https ca-certificates thin-provisioning-tools net-tools 

sudo unattended-upgrades -v

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo DEBIAN_FRONTEND=noninteractive apt-get -y update ${APTARGS}

sudo DEBIAN_FRONTEND=noninteractive apt-get -y install docker-ce=5:20.10.7~3-0~ubuntu-focal docker-ce-cli=5:20.10.7~3-0~ubuntu-focal containerd.io awscli jq neovim unzip ${APTARGS}
