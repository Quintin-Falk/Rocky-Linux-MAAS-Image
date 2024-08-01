# Rocky-Linux-MAAS-Image

<h2>Making the "Rocky Linux" image</h2>

**Creating the custom image "Rocky Linux":**
The next part of the project was creating the "Rocky Linux" image within MAAS, so that it could be deployed in machines. This was done with "make" and the "packer-maas" github repository. A slight problem that comes up when creating these machines is the sshd_config file does not have Password Authentication enabled. Therefore, you have to sign in as a cloud-user. 

<h3>Shelled into MAAS using multipass</h3>

	mulipass shell maas

<h3>Installed using apt</h3>

	sudo apt install qemu-utils
	sudo apt install libnbd-bin
	sudo apt install nbdkit
	sudo apt install fuse2fs
 	sudo apt install make

<h4>- Install packer by following instructions on the Packer website to install packer in the MAAS shell</h4>

	https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli

<h4>-Cloned Rocky 9 Github repository into the maas shell</h4>

<h4>-CD into the /packer-maas/Rocky9 directory</h4>

<h4>-Used "make" to create the image that MAAS will be using later</h4>

<h4>-While logged into root user, use "<Profile> maas boot-resources create" to create your image within the maas environment. Using the name "custom/rocky9", title "Rocky Linux", architecture "amd64/generic", base_image "rhel/9" filetype "tgz" and the content "rocky9.tar.gz"(the file made earlier using "make")</h4>

	sudo maas <Profile> boot-resources create \
    name='custom/rocky9' title='Rocky Linux' \
    architecture='amd64/generic' base_image='rhel/9' filetype='tgz' \
    content@=rocky9.tar.gz

<h4>-Login to MAAS UI and look in the images section, there should be a "Rocky Linux" choice available in the custom images section</h4>

**<h2>Testing:</h2>**

<h4>-Once in MAAS UI, compose a machine with the host</h4>

<h4>-Deploy the machine by choosing the "Custom Image" option and then choosing "Rocky Linux"</h4>

<h3>Using cloud-user, shell into the the newly deployed machine</h3>

	ssh cloud-user@<machine ip>
