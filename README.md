# COSC349-A2
## Introduction
This is my repository holding all the code base for my assignment 2. Below will be instructions on how to clone the repository and start up the virtual machines, S3 backup bucket, and database. I am building off my assignment 1 idea of a lolly shop, with one VM being the store page, a second being the admin page (which will talk to the RDS and grab the orders). The S3 backup bucket will just hold the backup of files in the case of a corrupt machine thats hosting a website.

## Installation
1. Firstly, clone this repository onto your host machine using what ever method of git that you feel like.\0
2. Log into your AWS learner lab and copy and paste your AWS API credentials into the repository file called ```credentials.txt``` (This will be copied into the right area and given permissions automatically). **Warning** If you are trying to use the VM for more codes, after about an hour you will need to replace your AWS API credentials in the file ```~/.aws/credentials``` on the vm as it can time out and stop being valid.
3. Navigate to where you cloned the repository in your command prompt and run the command ``` vagrant up ```. This will initialise a terraform VM that will initialise the two EC2 instances and the RDS database and create and place all the website files for the S3 bucket to hold the backup.
4. Then if you go into your AWS learner lab and click on EC2 and then "Running instances" you should see two running instances, one will be called "Customer website" and the other will be called "Admin website". If you navigate to the website you would like to open, and then....
5. 
