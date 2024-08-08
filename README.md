# Rocky-Linux-MAAS-Image

<h2>Making the "Rocky Linux" image</h2>

**Creating the custom image "Rocky Linux":**
The next part of the project was creating the "Rocky Linux" image within MAAS, so that it could be deployed in machines. This was done with "make" and the "packer-maas" github repository. A slight problem that comes up when creating these machines is the sshd_config file does not have Password Authentication enabled. Therefore, you have to sign in as a cloud-user. 

<h3>Install packages using apt, clone Rocky 9 github repository, and make the image</h3>

	wget https://raw.githubusercontent.com/Quintin-Falk/Rocky-Linux-MAAS-Image/main/rocky_linux.sh && chmod +x new_script.sh && ./rocky_linux.sh

<h4>-While logged into root user, use "<Profile> maas boot-resources create" to upload your image to the maas environment.</h4>

	sudo maas <Profile> boot-resources create \
    name='custom/rocky9' title='Rocky Linux' \
    architecture='amd64/generic' base_image='rhel/9' filetype='tgz' \
    content@=rocky9.tar.gz

<h4>-Login to MAAS UI and look in the images section, there should be a "Rocky Linux" choice available in the custom images section</h4>

**<h2>Testing:</h2>**

<h5>-Once in MAAS UI, compose a machine with the host</h5>

<h5>-Deploy the machine by choosing the "Custom Image" option and then choosing "Rocky Linux"</h5>

<h3>Using cloud-user, shell into the the newly deployed machine</h3>

	ssh cloud-user@<machine ip>
