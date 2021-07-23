variable "image_ubuntu_2004lts" {
  default = {
    ap-northeast-1 = "ami-0827d8ed0295e3feb"
  }
}

variable "student_count" {
  default = 4
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_key_pair" "seccamp_sshkey1" {
  key_name   = "seccamp_sshkey1"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDYec7BanC3Jio/twmlnyHEvrUjf/pgw7T0Y0vg2rcNRLyRu+4xkeKbjFoD3P0pMI7fLQXRfuIl4y1imRwxCPp/8nf9Yw6C8d4dHALNG/SE4NpKAOWsptM+Pj0bT2pR/qNdgmwIVscDZou3+aQ/x2yQwoXqjJxl8X8Lm5Efi1m2TYuQs9w1ljhZeJiNQiTo1BD2LKVPNHWDhcqFTve9uzDLhNgSLA2sLkjBPE7Tzn2EttvViAla+TuyJNNZr1TUdXg7ImwLDF76bwX4hArBKkGsBzj7zNUeHTX4SPTaUpVmR4bP96Td+rf5xXmq+nq4MtZOOzPOiga5ombdKE1VLt4vKhhfP0KZeO13pXV2jyUlagYKRhMfeA4Xy/ISJkN5w3p7lofwhfnMV4vxRK1UTGGHUbkNt4AY0CSIxYv0k5LHGiI6XtzKsl6Poodkuh4JZlxWJ/Xp4F3j0J4bs3PIh+asyWpKpCH82ozbQHD26UhBJAqoLuVRMZVHm33W+lsBuks= h-shirokura@security-camp2021.jp"
}

resource "aws_vpc" "slankdev_vpc1" {
  cidr_block           = "10.255.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "false"

  tags = {
    Name = "slankdev_vpc1"
  }
}

resource "aws_internet_gateway" "slankdev_vpc1_igw" {
  vpc_id = "${aws_vpc.slankdev_vpc1.id}"

  tags = {
    Name = "slankdev_vpc1_igw"
  }
}

resource "aws_subnet" "slankdev_vpc1_subnet1" {
  vpc_id            = "${aws_vpc.slankdev_vpc1.id}"
  cidr_block        = "10.255.1.0/24"
  availability_zone = "ap-northeast-1a"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "slankdev_vpc1_subnet1"
  }
}

resource "aws_route_table" "route_table1" {
  vpc_id = "${aws_vpc.slankdev_vpc1.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.slankdev_vpc1_igw.id}"
  }
}

resource "aws_route_table_association" "route_association1" {
  subnet_id = "${aws_subnet.slankdev_vpc1_subnet1.id}"
  route_table_id = "${aws_route_table.route_table1.id}"
}

resource "aws_security_group" "slankdev_sg1" {
  vpc_id = "${aws_vpc.slankdev_vpc1.id}"
  name   = "slankdev_sg1"

  ingress {
    description = "SSH from Any"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP from Any"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Any to Any"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "slankdev_sg1"
  }
}

resource "aws_launch_template" "slankdev_instance_template1" {
  name          = "slankdev_instance_template1"
  image_id      = "${var.image_ubuntu_2004lts.ap-northeast-1}"
  instance_type = "t2.micro"
  key_name      = "seccamp_sshkey1"

  network_interfaces {
    associate_public_ip_address = "false"
    subnet_id = "${aws_subnet.slankdev_vpc1_subnet1.id}"
    security_groups = [
      "${aws_security_group.slankdev_sg1.id}"
    ]
  }
}

resource "aws_instance" "slankdev_instance_student" {
  count = "${var.student_count}"
  launch_template { id = "${aws_launch_template.slankdev_instance_template1.id}" }
  tags = { Name = "${format("student%02d", count.index + 1)}" }
}

resource "aws_eip" "slankdev_instance_student" {
  count = "${var.student_count}"
  instance = "${element(aws_instance.slankdev_instance_student.*.id, count.index)}"
  vpc      = true
}

output "student-servers" {
  value = "${aws_instance.slankdev_instance_student.*.public_ip}"
}
