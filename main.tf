#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-1d4e7a66
#
# Your subnet ID is:
#
#     subnet-77f9d52d
#
# Your security group ID is:
#
#     sg-e72efe94
#
# Your Identity is:
#
#     terraform-salamander
#

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
  version    = "~> 0.1"
}

variable "web_count" {
  default = 2
}

resource "aws_instance" "web" {
  count         = "${var.web_count}"
  ami           = "ami-1d4e7a66"
  instance_type = "t2.micro"
  subnet_id     = "subnet-77f9d52d"

  vpc_security_group_ids = [
    "sg-e72efe94",
  ]

  tags = {
    Identity = "terraform-salamander"
    Stack    = "Production"
    Owner    = "root"
    Name     = "${format("web %d/%s", count.index + 1, var.web_count)}"
  }
}

output "public_dns" {
  value = "${aws_instance.web.*.public_dns}"
}
