provider "aws" {
  region = "eu-central-1"
}

variable "env" {
  default = "prod"
}

variable "environment" {
  default = {
    "prod"    = "t3.medium"
    "dev"     = "t2.micro"
    "staging" = "t2.nano"
  }
}

resource "aws_instance" "webserver" {
  ami           = "ami-0e872aee57663ae2d"
  instance_type = "t2.micro"


  tags = {
    Name = var.env == "prod" ? "Prod" : "Development"
  }
}

resource "aws_instance" "my_webserver2" {
  ami           = "ami-0e872aee57663ae2d"
  instance_type = lookup(var.environment, var.env)
  tags = {
    Name = var.env
  }
}
