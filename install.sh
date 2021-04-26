#!/bin/bash

if [ "$1" == "" ]; then
	echo "Usage: sudo ./install.sh <username>"
	echo "<username> is the user from which all the commands from now should be run with"
	exit 0
fi


apt-get update
apt-get install -y virtualbox
apt-get install -y vagrant
apt-get install -y python3-pip


pip3 install ansible fabric3 jsonpickle requests PyYAML
vagrant plugin install vagrant-vbguest

# Installing AWS-iam-Authenticator
curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator
mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
echo "ScriptReport: AWS_IAM_AUTHC8R INSTALLED"

# Installing kubectl
apt-get install -y apt-transport-https gnupg2 curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
echo "ScriptReport: KUBECTL INSTALLED"

#Installing helm
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
echo "ScriptReport: HELM INSTALLED"

#Installing terraform
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt install terraform
echo "ScriptReport: TERRAFORM INSTALLED"

python3 -m pip install awscli boto3
#aws configure


#installing docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo usermod -aG docker $1 


sudo curl -L "https://github.com/docker/compose/releases/download/1.28.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo apt-get install wget
sudo apt-get install qemu qemu-kvm libvirt-clients libvirt-daemon-system virtinst bridge-utils
wget "https://github.com/magma/magma/archive/refs/tags/v1.4.0.zip"


echo "Please restart the system"
echo "After reboot, run after-reboot.sh file created on the desktop with sudo previleges"

echo "sudo systemctl enable libvirtd" >> /home/$1/Desktop/after-reboot.sh
echo "sudo systemctl start libvirtd" >> /home/$1/Desktop/after-reboot.sh
chmod +x /home/$1/Desktop/after-reboot.sh 
