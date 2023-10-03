#!/bin/bash

#setting up terraform and getting it all working. Code from lab 09.
apt-get update
apt-get install -y python3-pip awscli gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor >/usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" >/etc/apt/sources.list.d/hashicorp.list
apt-get update
apt-get install terraform
runuser -l vagrant -c 'mkdir ~/.aws'
export LC_ALL="en_US.UTF-8"
pip3 install boto3
pip3 install --upgrade awscli



#Copying the AWS credentials to the vagrant user
mkdir ~/.aws
cp /vagrant/credentials.txt ~/.aws/credentials

#Running terraform using the main.tf file in the tf-deploy folder.
cd /vagrant/tf-deploy
terraform init
terraform apply -auto-approve

#Copying the private key to the vagrant user
cp /vagrant/assignment-key.pem ~/.ssh/assignment-key.pem

#Setting up the private key to be used by the vagrant user
chmod 700 ~/.ssh/assignment-key.pem