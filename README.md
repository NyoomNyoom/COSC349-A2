# COSC349-A2
## Introduction
This is my repository holding all the code base for my assignment 2. Below will be instructions on how to clone the repository and start up the virtual machines, S3 backup bucket, and database. I am building off my assignment 1 idea of a lolly shop, with one VM being the store page, a second being the admin page (which will talk to the RDS and grab the orders). The S3 backup bucket will just hold the backup of files in the case of a corrupt machine thats hosting a website.

## Installation
1. Clone this repository onto your host machine using your desired method of git.
2. Log into your AWS learner lab and copy and paste your AWS API credentials into the repository file named ```credentials.txt```. This will then be copied into the right area and given permissions automatically.
3. If you haven’t already, create a new key called ```assignment-key.pem``` and add it into the cloned repository. You should see a blank file already there as a placeholder.
4. Navigate to where you cloned the repository in your command prompt and run the command ```vagrant up```. This will initialise a terraform VM which in turn will initialisethe two EC2 instances and the RDS database and create and place all the website files for the S3 bucket to hold the backup.
5. Next, navigate to the AWS learner lab and click on EC2 and then "Running instances". You should then see two running instances; one will be named "store webserver" and the other "admin webserver". Navigate to the admin website by clicking on the link beside the instance “public ipv4 DNS” and then adding ```http://``` in front of it. After this you should be greeted with a login page. Add “/setup.php” to the end of the URL and press enter. This sets up the database (DB) by adding the 3 tables and some example data into them.
6. Once you have done this the DB (database) has been set up and will contain some exemplary data within it. You will be able to navigate to any of the web servers’ webpages and be able to use them effectively. The log in details for the admin website are listed in the ```main.tf file``` but the defaults I used are ```USER: admin``` and
```PASS: password```. These can be changed in ```/Cloned repo/tf-deploy/main.tf```

**Warning** If you are trying to use the VM to run more code or change the configuration, after a couple of hours you will need to replace your AWS API credentials in the file ```~/.aws/credentials``` on the vm as it can time out and stop being valid. A way you could go about this would be replacing the credentials on your host system in the cloned repository into the file ```credentials.txt``` like you did at the start of step 2. Then run ```vagrant ssh``` in the shell where you ran ```vagrant up``` and run the following command ```cp /vagrant/credentials.txt ~/.aws/credentials```. This will update your credentials and mean you can continue to use terraform without issues :)

## My running versions
The EC2 machines that I will be running as examples are accessible from the links below:
[Admin web server](http://ec2-54-224-48-122.compute-1.amazonaws.com)
[Store web server](http://ec2-18-234-151-142.compute-1.amazonaws.com)
