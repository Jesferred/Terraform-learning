# -----------------------------
# Highly available web server in any region default VPC:
# Security group for web server
# auto ami lookup
# auto scaling group using 2 AZ
# classic load balancer in 2 AZ
# dynamic tagging
# -----------------------------

provider "aws" {
  region = "eu-central-1"
}

data "aws_availability_zones" "available" {}
data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_security_group" "SG-for-webserver" {
  name = "SG-for-webserver"
  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  #   ingress = {
  #     from_port = 22
  #     to_port = 22
  #     protocol = "tcp"
  #     cidr_blocks = ["0.0.0.0/0"]
  #   }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "Dynamic SecurityGroup"
    Owner = "Jfrrd"
  }
}

resource "aws_launch_configuration" "web" {
  name_prefix                 = "WebServer-Highly-Available-LC-" # делать другие версии а это будет префикс
  image_id                    = data.aws_ami.latest_ubuntu.id
  instance_type               = "t2.micro"
  security_groups             = [aws_security_group.SG-for-webserver.id]
  user_data                   = file("HA_user_data.sh")
  associate_public_ip_address = true
}

resource "aws_autoscaling_group" "web" {
  name                 = "ASG-${aws_launch_configuration.web.name}"
  launch_configuration = aws_launch_configuration.web.name
  min_size             = 2
  max_size             = 2
  min_elb_capacity     = 2
  health_check_type    = "ELB" # пинг страницы ELB и есть хелзчеком
  load_balancers       = [aws_elb.web.name]
  vpc_zone_identifier  = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
  lifecycle {
    create_before_destroy = true
  }


  # таггирование с помощью динамических тагов
  dynamic "tag" {
    for_each = {
      Name   = "WebServer in ASG"
      Owner  = "Jfrrd"
      TAGKEY = "TAGVALUE"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_elb" "web" {
  name               = "WebServer-HA-ELB"
  availability_zones = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  security_groups    = [aws_security_group.SG-for-webserver.id]
  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = 80
    instance_protocol = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 10
  }
  tags = {
    Name = "WebServer-HA-ELB"
  }
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = data.aws_availability_zones.available.names[1]
}

#-------------------------------
output "web_loadbalancer_url" {
  value = aws_elb.web.dns_name
}
