provider "aws" {
  region = "eu-central-1"
}

variable "users" {
  description = "list of aws users to use them in loop"
  default     = ["vasya", "petya", "kolya", "lexa", "andrew", "oleg", "masha", "JORA"]
}

resource "aws_iam_user" "aws_users" {
  count = length(var.users)
  name  = element(var.users, count.index)
}

resource "aws_instance" "servers" {
  count         = 0 # поменять на сколько надо
  ami           = "ami-0e872aee57663ae2d"
  instance_type = "t2.micro"
  tags = {
    Name = "Server Number ${count.index + 1}" # вывод будет Server Number 1, Server Number 2, Server Number 3
  }
}


output "created_aws_iam_users" {
  value = aws_iam_user.aws_users
}

output "created_aws_iam_users_ids" {
  value = aws_iam_user.aws_users[*].id
}

output "created_aws_iam_users_custom" {
  value = [
    for user in aws_iam_user.aws_users :
    "User: ${user.name} ARN: ${user.arn}"
  ]
}
