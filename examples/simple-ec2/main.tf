terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.60.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "simple-ec2-instance" {
  ami           = "ami-07df274a488ca9195"
  instance_type = "t2.nano"

  tags = {
    "Name" = "Simple EC2 Instance"
  }
}
