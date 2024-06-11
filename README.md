# Rocky-Linux-MAAS-Image
The creation of a Rocky Linux image within a MAAS environment
Making a MAAS Local Environment and Creating a Custom "Rocky Linux" Image Within It

Creating the local environment: 
The first part of this project was creating a local environment to test creating the "Rocky Linux" image within MAAS. This was done through an ubuntu desktop and used an lxd host to creat VMs within MAAS. VMs were then composed, deployed, and tested. 

Installed ubuntu onto a desktop following the directions from the ubuntu website
	
 	https://ubuntu.com/tutorials/install-ubuntu-desktop#1-overview

Installed multipass on ubuntu desktop

	sudo snap install multipass 

Created a MAAS instance with the yaml file given at https://raw.githubusercontent.com/canonical/maas-multipass/main/maas.yml
	
 	wget -qO- https://raw.githubusercontent.com/canonical/maas-multipass/main/maas.yml \
 	| multipass launch --name maas -c4 -m8GB -d32GB --cloud-init -
Signed into MAAS UI with ip from the instance

login with user "admin" and password "admin"

Wait for the stock image to finish downloading onto maas

Compose a VM with the LXD host

Deploy that VM with ubuntu image to make sure that VM's are running correctly

Test by pinging and ssh into the ip of the newly created VM

Creating the custom image "Rocky Linux":
The next part of the project was creating the "Rocky Linux" image within MAAS, so that it could be deployed in machines. This was done with "make" and the "packer-maas" github repository. A slight problem that comes up when creating these machines is the sshd_config file does not have Password Authentication enabled. Therefore, you have to sign in as a cloud-user. 

Shelled into MAAS using multipass

	mulipass shell maas

Installed using apt

	sudo apt install qemu-utils
	sudo apt install libnbd-bin
	sudo apt install nbdkit
	sudo apt install fuse2fs
 	sudo apt install make

Installed Packer
	-follow instructions on the Packer website to install packer in the MAAS shell 

Cloned Rocky 9 Github repository into the maas shell

CD into the /packer-maas/Rocky9 directory

Used "make" to create the image that MAAS will be using later

While logged into root user, use "<Profile> maas boot-resources create" to create your image within the maas environment. Using the name "custom/rocky9", title "Rocky Linux", architecture "amd64/generic", base_image "rhel/9" filetype "tgz" and the content "rocky9.tar.gz"(the file made earlier using "make")

Login to MAAS UI and look in the images section, there should be a "Rocky Linux" choice available in the custom images section

Testing:

Once in MAAS UI, compose a machine with the host

Deploy the machine by choosing the "Custom Image" option and then choosing "Rocky Linux"

Using cloud-user, shell into the the newly deployed machine

	ssh cloud-user@<machine ip>
