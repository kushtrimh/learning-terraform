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

resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "Simple Example VPC"
  }
}

resource "aws_subnet" "example_subnet" {
  vpc_id            = aws_vpc.example_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    "Name" = "Simple Example Subnet 1A"
  }
}

resource "aws_instance" "example_instance" {
  ami           = "ami-07df274a488ca9195"
  instance_type = "t2.nano"
  subnet_id     = aws_subnet.example_subnet.id

  tags = {
    "Name" = "Simple Example EC2"
  }
}
