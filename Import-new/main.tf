provider "aws" {
  region = "eu-central-1"
}


import {
  id = "sg-0f8499561c3ea8507"
  to = aws_security_group.web
}

import {
  id = "sg-0d4cae358bd46aefb"
  to = aws_security_group.sql
}

import {
  id = "i-0ee2b4358c4d1517a"
  to = aws_instance.web
}

import {
  id = "i-0d09052349417e408"
  to = aws_instance.db
}
