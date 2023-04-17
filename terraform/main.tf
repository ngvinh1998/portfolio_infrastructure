terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 4.50.0"
    }
  }
  cloud {
    organization = "ngqvinh1998"

    workspaces {
      name = "portfolio-tf"
    }
  }

  required_version = ">= 1.4.0"
}

provider "aws" {
  region = "ap-southeast-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "portfolio_host" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0b3cf699efe68ee0e"]
  tags = {
    Name = "PortfolioHost"
  }
}
