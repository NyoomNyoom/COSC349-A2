provider "aws" {
  region = "us-east-1"
} 

resource "aws_security_group" "allow_sshAnywhere" {
  name        = "allow_sshAnywhere"
  description = "Allow inbound SSH traffic"

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
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
  key_name      = "cosc349-2023"

  vpc_security_group_ids = [aws_security_group.allow_sshAnywhere.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y apache2
              sudo systemctl start apache2
              sudo systemctl enable apache2
              EOF

  tags = {
    Name = "WebServer"
  }
}

resource "aws_instance" "Admin_server" {
    ami           = "ami-010e83f579f15bba0"
    instance_type = "t2.micro"
    key_name      = "cosc349-2023"
    
    vpc_security_group_ids = [aws_security_group.allow_sshAnywhere.id]
    
    user_data = <<-EOF
                #!/bin/bash
                sudo apt update
                sudo apt install -y apache2
                sudo systemctl start apache2
                sudo systemctl enable apache2
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
    publicly_accessible = true
    skip_final_snapshot = true
}

output "web_server_ip" {
  value = aws_instance.web_server.public_ip
}