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

sudo -s

mkdir /.ssh

#Copying the private key to the vagrant user
cp /vagrant/assignment-key.pem /.ssh/assignment-key.pem

#Setting up the private key to be used by the vagrant user
chmod 700 /.ssh/assignment-key.pem

cd /vagrant/tf-deploy
echo "making the ubuntu user own the /var/www folder"
ssh -i /.ssh/assignment-key.pem -o StrictHostKeyChecking=no ubuntu@$(terraform output -raw web_server_ip) "sudo mkdir /var/www"
ssh -i /.ssh/assignment-key.pem -o StrictHostKeyChecking=no ubuntu@$(terraform output -raw admin_server_ip) "sudo mkdir /var/www"

ssh -i /.ssh/assignment-key.pem -o StrictHostKeyChecking=no ubuntu@$(terraform output -raw web_server_ip) "sudo chown -R ubuntu:root /var/www"
ssh -i /.ssh/assignment-key.pem -o StrictHostKeyChecking=no ubuntu@$(terraform output -raw admin_server_ip) "sudo chown -R ubuntu:root /var/www"

#Copying the files to the web servers using secure copy.
#The terraform output grabs the output ip address of the webserver.
echo "copying the files to the web servers"
scp -i /.ssh/assignment-key.pem -o StrictHostKeyChecking=no -r /vagrant/store-web-files ubuntu@$(terraform output -raw web_server_ip):/var/www
scp -i /.ssh/assignment-key.pem -o StrictHostKeyChecking=no -r /vagrant/admin-web-files ubuntu@$(terraform output -raw admin_server_ip):/var/www

#changing the directory back

cd /vagrant

cat > /vagrant/web.conf << EOF
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/store-web-files
    <Directory "/var/www/store-web-files">
        Require all granted
    </Directory>
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

cat > /vagrant/admin.conf << EOF
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/admin-web-files
    <Directory "/var/www/admin-web-files">
        Require all granted
    </Directory>
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

cd /vagrant/tf-deploy

#Copying the config files to the web servers using secure copy.
ssh -i /.ssh/assignment-key.pem ubuntu@$(terraform output -raw web_server_ip) "sudo chown -R ubuntu:root /etc/apache2/sites-available"
ssh -i /.ssh/assignment-key.pem ubuntu@$(terraform output -raw admin_server_ip) "sudo chown -R ubuntu:root /etc/apache2/sites-available"
scp -i /.ssh/assignment-key.pem -r /vagrant/web.conf ubuntu@$(terraform output -raw web_server_ip):/etc/apache2/sites-available
scp -i /.ssh/assignment-key.pem -r /vagrant/admin.conf ubuntu@$(terraform output -raw admin_server_ip):/etc/apache2/sites-available

#Changing the ownership of the config files on the web servers back to root.
ssh -i /.ssh/assignment-key.pem ubuntu@$(terraform output -raw web_server_ip) "sudo chown -R root:ubuntu /etc/apache2/sites-available"
ssh -i /.ssh/assignment-key.pem ubuntu@$(terraform output -raw admin_server_ip) "sudo chown -R root:ubuntu /etc/apache2/sites-available"

#enabling the config files on the web servers
ssh -i /.ssh/assignment-key.pem ubuntu@$(terraform output -raw web_server_ip) "sudo a2ensite web.conf"
ssh -i /.ssh/assignment-key.pem ubuntu@$(terraform output -raw admin_server_ip) "sudo a2ensite admin.conf"

#disabling the default config files on the web servers
ssh -i /.ssh/assignment-key.pem ubuntu@$(terraform output -raw web_server_ip) "sudo a2dissite 000-default"
ssh -i /.ssh/assignment-key.pem ubuntu@$(terraform output -raw admin_server_ip) "sudo a2dissite 000-default"

echo "copying the website conf files"
#Copying the config files to the web servers using secure copy.
scp -i /.ssh/assignment-key.pem -r /vagrant/web.conf ubuntu@$(terraform output -raw web_server_ip):/var/www
scp -i /.ssh/assignment-key.pem -r /vagrant/admin.conf ubuntu@$(terraform output -raw admin_server_ip):/var/www


echo "making the config file"
#Grabbing the database details from terraform output and putting them into the config.php file.
cat > /vagrant/config.php << EOF
<?php
define('DB_HOST', '$(terraform output -raw db_host)');
define('DB_PORT', '$(terraform output -raw db_port)');
define('DB_NAME', '$(terraform output -raw db_name)');
define('DB_USER', '$(terraform output -raw db_user)');
define('DB_PASS', '$(terraform output -raw db_pass)');
define('STORE_URL', 'http://$(terraform output -raw web_server_ip)');
define('ADMIN_URL', 'http://$(terraform output -raw admin_server_ip)');
?>
EOF

echo "copying the config files"
#Copying the config.php file to the web servers using secure copy.
scp -i /.ssh/assignment-key.pem -r /vagrant/config.php ubuntu@$(terraform output -raw web_server_ip):/var/www/store-web-files
scp -i /.ssh/assignment-key.pem -r /vagrant/config.php ubuntu@$(terraform output -raw admin_server_ip):/var/www/admin-web-files

echo "restarting"
#restarting the apache2 service on the web servers
ssh -i /.ssh/assignment-key.pem ubuntu@$(terraform output -raw web_server_ip) "sudo systemctl restart apache2"
ssh -i /.ssh/assignment-key.pem ubuntu@$(terraform output -raw admin_server_ip) "sudo systemctl restart apache2"
