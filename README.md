# Rocky-Linux-MAAS-Image
<h2>The creation of a MAAS environment</h2>

**Creating the local environment:** 
The first part of this project was creating a local environment to test creating the "Rocky Linux" image within MAAS. This was done through an ubuntu desktop and used an lxd host to creat VMs within MAAS. VMs were then composed, deployed, and tested. 

<h3>Installed ubuntu onto a desktop following the directions from the ubuntu website</h3>
	
 	https://ubuntu.com/tutorials/install-ubuntu-desktop#1-overview

<h3>Installed multipass on ubuntu desktop</h3>
	
 	sudo snap install multipass 

<h3>Created a MAAS instance with the yaml file given at https://raw.githubusercontent.com/canonical/maas-multipass/main/maas.yml</h3>	
 	
	wget -qO- https://raw.githubusercontent.com/canonical/maas-multipass/main/maas.yml \
 	| multipass launch --name maas -c4 -m8GB -d32GB --cloud-init -

<h4>-Signed into MAAS UI with ip from the instance</h4>

<h4>-Login with user "admin" and password "admin"</h4>

<h4>-Wait for the stock image to finish downloading onto maas</h4>

<h4>-Compose a VM with the LXD host</h4>

<h4>-Deploy that VM with ubuntu image to make sure that VM's are running correctly</h4>

**<h2>Testing:</h2>**
<h4>-Pinging and ssh into the ip of the newly created VM</h4>

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

<h4>Deploy the machine by choosing the "Custom Image" option and then choosing "Rocky Linux"</h4>

</h4>Using cloud-user, shell into the the newly deployed machine</h4>

	ssh cloud-user@<machine ip>
