provider "aws" {
  region = "eu-west-2"
  alias  = "aws-uk"
}

variable "ami-uk" {
  description = "machine image uk"
  default     = "ami-0eb260c4d5475b901"
}

variable "type" {
  default = "t2.micro"
}

variable "zone" {
  description = "map of availability zones for eu-west-2"
  default = {
    1 = "eu-west-2a"
    2 = "eu-west-2b"
  }
}

resource "aws_instance" "EC2" {
  provider          = "aws.aws-uk"
  for_each          = var.zone
  availability_zone = each.value
  ami               = var.ami-uk
  instance_type     = var.type

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    create = "5m"
    delete = "2h"
  }
}