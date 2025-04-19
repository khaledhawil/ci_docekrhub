terraform {
     # Configure the AWS Provider
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" { // backend configuration
    key    = "aws/ec2-deploy/terraform.tfstate"
    
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "server" {
  ami           = "ami-0f9de6e2d2f067fca"
  instance_type = "t2.micro"
  key_name = aws_key_pair.deployer.key_name
  connection {
    type        = "ssh"
    host = self.public_ip
    user = "ubuntu"
    private_key = var.private_key
    timeout = "4m"    
  }
  tags = {
     Name = "server"
  }
}
resource "aws_security_group" "maingroup" {
     name  = "maingroup" 
}
resource "aws_key_pair" "deployer" {
     key_name = var.key_name
     public_key = var.public_key
  
}



output "public_info" {
  value = aws_instance.server.public_ip
  sensitive = true

}