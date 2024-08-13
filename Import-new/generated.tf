# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "sg-0d4cae358bd46aefb"
resource "aws_security_group" "sql" {
  description = "My First SecurityGroup"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 80
  }]
  name                   = "WebServer SG Stag"
  name_prefix            = null
  revoke_rules_on_delete = null
  tags = {
    Name  = "Web Server SecurityGroup"
    Owner = "Jesferred"
  }
  tags_all = {
    Name  = "Web Server SecurityGroup"
    Owner = "Jesferred"
  }
  vpc_id = "vpc-01eaf84c800033ff3"
}

# __generated__ by Terraform from "sg-0f8499561c3ea8507"
resource "aws_security_group" "web" {
  description = "launch-wizard-1 created 2024-08-13T13:58:59.146Z"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 22
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 22
    }, {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 443
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 443
    }, {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 80
  }]
  name                   = "launch-wizard-1"
  name_prefix            = null
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = "vpc-01eaf84c800033ff3"
}
