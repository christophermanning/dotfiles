#!/bin/bash
set -euo pipefail

# install virtualbox
sudo tee /etc/apt/sources.list.d/virtualbox.list <<EOF
deb http://download.virtualbox.org/virtualbox/debian xenial contrib
EOF

pushd /tmp && \
wget -N https://www.virtualbox.org/download/oracle_vbox_2016.asc && \
fingerprint=$(gpg --with-fingerprint oracle_vbox_2016.asc | grep Key |  awk -F'= ' '{print $2}') && \
[ "$fingerprint" = "B9F8 D658 297A F3EF C18D  5CDF A2F6 83C5 2980 AECF" ] && \
sudo apt-key add oracle_vbox_2016.asc && \
popd

sudo apt-get -y install virtualbox-5.1

# install vagrant
pushd /tmp
wget -N https://releases.hashicorp.com/vagrant/1.9.1/vagrant_1.9.1_x86_64.deb
sha=$(sha256sum vagrant_1.9.1_x86_64.deb | cut -f1 -d' ')
[ "$sha" = "d006d6227e049725b64d8ba3967f0c82460a403ff40230515c93134d58723150" ] && \
sudo dpkg -i vagrant_1.9.1_x86_64.deb
popd

# install docker
sudo apt-get -y install apt-transport-https ca-certificates linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-key adv \
           --keyserver hkp://ha.pool.sks-keyservers.net:80 \
           --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get -y install docker-engine
sudo service docker start
sudo groupadd docker
sudo usermod -aG docker $USER
