## Creating a VPC
resource "aws_vpc" "atom_wise_test" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  instance_tenancy = "default"
  tags {
    Name = "atom_wise_test"
  }
}
## Creating a subnet inside that VPC
resource "aws_subnet" "atom_wise_test" {
  vpc_id            = "${aws_vpc.atom_wise_test.id}"
  availability_zone = "us-east-1a"
  cidr_block = "10.0.0.0/24"
}

##creating a security Group and allowing access to port 80 from anywhere
resource "aws_security_group" "atom_wise_test" {
  name        = "atom_wise_test"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.atom_wise_test.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
