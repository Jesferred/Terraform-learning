provider "aws" {
  region = "eu-central-1"
}

locals {
  full_project_name = "${var.environment}-${var.project}"
}

resource "aws_eip" "static_ip" {
  tags = {
    Name        = "Static ip"
    Owner       = var.owner
    Project     = local.full_project_name
    Environment = var.environment
  }
}
