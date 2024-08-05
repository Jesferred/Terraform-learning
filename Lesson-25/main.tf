provider "aws" {
  region = "eu-central-1" # default


  #   access_key = "xxxxxxxxxxxxx"
  #   secret_key = "yyyyyyyyyyyyy"

  #    OR

  #   assume_role {
  #     role_arn = "arn:aws:iam::1234567890:role/Administrator" // тебе делают роль, которую ты можешь взять. так вот это взять и выполнено в этой строчке. офк выдумано
  #     session_name = "terraform-session" # может быть что угодно, это просто название сессии
  #   }
}

provider "aws" {
  region = "us-west-1"
  alias  = "usa"
}

provider "aws" {
  region = "ca-central-1"
  alias  = "canada"
}

data "aws_ami" "latest_ubuntu_eu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

data "aws_ami" "latest_ubuntu_usa" {
  provider    = aws.usa
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

data "aws_ami" "latest_ubuntu_canada" {
  provider    = aws.canada
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_instance" "webserver-eu" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.latest_ubuntu_eu.id
  tags = {
    Name = "default region"
  }
}

resource "aws_instance" "webserver-usa" {
  provider      = aws.usa
  instance_type = "t2.micro"
  ami           = data.aws_ami.latest_ubuntu_usa.id
  tags = {
    Name = "usa region"
  }
}

resource "aws_instance" "webserver-canada" {
  provider      = aws.canada
  instance_type = "t2.micro"
  ami           = data.aws_ami.latest_ubuntu_canada.id
  tags = {
    Name = "canada region"
  }
}
