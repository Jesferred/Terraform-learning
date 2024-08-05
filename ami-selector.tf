provider "aws" {
  region = "eu-central-1"
}

# resource "aws_instance" "Test" {
#   ami = "ami-0e872aee57663ae2d"
#   instance_type = "t2.micro"
#   tags = {
#     Name = "Test"
#   }
# }

data "aws_ami" "latest_ubuntu" {
  owners = ["099720109477"]
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-server-*"]
  }
}

data "aws_ami" "latest_amazon_linux" {
  owners = ["amazon"]
  most_recent = true
  filter {
    name = "name"
    values = [ "amzn2-ami-kernel-5.10-hvm-*" ]
  }
}

data "aws_ami" "latest_windows_2022" {
  owners = [ "801119661308" ]
  most_recent = true
  filter {
    name = "name"
    values = [ "Windows_Server-2022-English-Full-Base-*" ]
  }
}

output "latest_amazon_linux_name" {
  value = data.aws_ami.latest_amazon_linux.name
}
output "latest_amazon_linux_id" {
  value = data.aws_ami.latest_amazon_linux.id
}
output "latest_ubuntu_ami_name" {
  value = data.aws_ami.latest_ubuntu.name
}
output "latest_ubuntu_ami_id" {
  value = data.aws_ami.latest_ubuntu.id
}
output "latest_windows_2022_name" {
  value = data.aws_ami.latest_windows_2022.name
}
output "latest_windows_2022_id" {
  value = data.aws_ami.latest_windows_2022.id
}