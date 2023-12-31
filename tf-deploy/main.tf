provider "aws" {
  region = "us-east-1"
} 

resource "aws_security_group" "allow_sshANDhttp" {
  name        = "allow_sshANDhttp"
  description = "Allow inbound SSH traffic"

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_mysql" {
  name        = "allow_mysql"
  description = "Allow inbound MySQL traffic"

  ingress {
    description = "MySQL from anywhere"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami           = "ami-010e83f579f15bba0"
  instance_type = "t2.micro"
  key_name      = "assignment-key"

  vpc_security_group_ids = [aws_security_group.allow_sshANDhttp.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y apache2
              sudo systemctl start apache2
              sudo systemctl enable apache2
              sudo apt install -y php
              sudo apt-get install -y php-mysql
              sudo apt install -y mysql-server
              EOF

  tags = {
    Name = "WebServer"
  }
}

resource "aws_instance" "Admin_server" {
    ami           = "ami-010e83f579f15bba0"
    instance_type = "t2.micro"
    key_name      = "assignment-key"
    
    vpc_security_group_ids = [aws_security_group.allow_sshANDhttp.id]
    
    user_data = <<-EOF
                #!/bin/bash
                sudo apt update
                sudo apt install -y apache2
                sudo systemctl start apache2
                sudo systemctl enable apache2
                sudo apt install -y php
                sudo apt-get install -y php-mysql
                sudo apt install -y mysql-server
                EOF
    
    tags = {
        Name = "AdminServer"
    }
}



resource "aws_db_instance" "LollystoreDB" {
    allocated_storage    = 20
    engine               = "mysql"
    engine_version       = "5.7"
    instance_class       = "db.t2.micro"
    username             = "admin"
    password             = "password"
    parameter_group_name = "default.mysql5.7"
    db_name              = "LollyStore"
    publicly_accessible = true
    skip_final_snapshot = true
}

resource "aws_s3_bucket" "web_backup_bucket" {
  bucket = "jnorth-web-backup"
  acl    = "private"
}

resource "aws_s3_bucket_object" "store_web_files" {
  bucket       = aws_s3_bucket.web_backup_bucket.id
  key          = "web-files/"
  source       = "/vagrant/store-web-files/submit.php"
}

resource "aws_s3_bucket_object" "admin_web_files" {
  bucket       = aws_s3_bucket.web_backup_bucket.id
  key          = "web-files/"
  source       = "/vagrant/admin-web-files/admin.php"
}

output "web_server_ip" {
  value = aws_instance.web_server.public_ip
}
output "admin_server_ip" {
  value = aws_instance.Admin_server.public_ip
}

output "db_host" {
  value = aws_db_instance.LollystoreDB.endpoint
}

output "db_port" {
  value = aws_db_instance.LollystoreDB.port
}

output "db_name" {
  value = aws_db_instance.LollystoreDB.db_name
}

output "db_user" {
  value = aws_db_instance.LollystoreDB.username
}

output "db_pass" {
  value = aws_db_instance.LollystoreDB.password
  sensitive = true
}
