# terraform import - for import resources, created not by terraform

provider "aws" {
  region = "eu-central-1"
}
# 1 делаем пустой ресурс
resource "aws_instance" "node01" {
  instance_type = "t2.micro"
  ami           = "ami-00060fac2f8c42d30"
  tags = {
    "Name" = "qwerh"
  }
}

# 2
# terraform import aws_instance.node01 [instance_id]

# 3
# terraform show и вручную добавлять необходимые аргументы
