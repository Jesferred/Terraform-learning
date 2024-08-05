variable "region" {
  description = "region"
  default     = "eu-central-1"
}

variable "instance_type" {
  description = "instance_type"
  default     = "t2.micro"
}

variable "allow_ports" {
  description = "allow_ports"
  type        = list(any)
  default     = ["80", "443", "22"]
}
variable "common_tags" {
  description = "common tags tp allpy to all resources"
  type        = map(any)
  default = {
    Owner     = "Jefrrd"
    CreatedBy = "Terraform"
  }
}
