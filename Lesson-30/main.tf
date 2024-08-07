# Global Vars

provider "aws" {
  region = "eu-central-1"
}

# This bucket not exist, just for example
terraform {
  backend "s3" {
    bucket = "value"
    key    = "value"
    region = "eu-central-1"
  }
}


# Make global vars
output "name" {
  value = "example"
}

output "owner" {
  value = "Jesfer"
}
#-----------------------------------------------------------
# Take global vars
data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    bucket = "value"
    key    = "value"
    region = "eu-central-1"
  }
}

locals {
  name  = data.terraform_remote_state.global.outputs.name
  owner = data.terraform_remote_state.global.outputs.owner
}
