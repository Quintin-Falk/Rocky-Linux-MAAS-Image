#!/bin/bash

#install necessary packages

sudo apt-get install qemu-utils libnbd-bin nbdkit fuse2fs make curl -y

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" -y

sudo apt-get update && sudo apt-get install packer -y

#clone and cd packer-maas repository

git clone https://github.com/canonical/packer-maas.git

cd packer-maas/rocky9

#make image

sudo make
