provider "aws" {
  region = "eu-central-1"
}


terraform { # тфстейт теперь уезжает храниться туда
  backend "s3" {
    bucket = "terraform-tfstate-jesferred"
    key    = "dev/servers/terraform.tfstate"
    region = "eu-central-1"
  }
}

# берем отпуты, которые оставили сами себе в другой папке
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "terraform-tfstate-jesferred"
    key    = "dev/network/terraform.tfstate"
    region = "eu-central-1"
  }
}

resource "aws_security_group" "test-sg" {
  name        = "test-sg"
  description = "test-sg"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "TEST"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.test-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.test-sg.id
  cidr_ipv4         = data.terraform_remote_state.network.outputs.vpc_cidr
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.test-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


output "webserver_sg_id" {
  value = aws_security_group.test-sg.id
}
