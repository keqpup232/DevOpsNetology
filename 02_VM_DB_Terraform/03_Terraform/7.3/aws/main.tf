provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "tf-example"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "tf-example"
  }
}

resource "aws_network_interface" "foo" {
  subnet_id   = aws_subnet.my_subnet.id
  private_ips = ["172.16.10.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "foo" {
  ami = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  instance_type = local.web_instance_type_map[terraform.workspace]
  count = local.web_instance_count_map[terraform.workspace]
  availability_zone = "us-west-2"
  cpu_core_count = "4"

  network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  root_block_device {
    delete_on_termination = true
    iops = 150
    volume_size = 50
    volume_type = "gp3"
  }

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_instance" "for_each"{
  for_each = local.web_instance_each_map[terraform.workspace]

  instance_type = each.value
  ami = data.aws_ami.ubuntu.id

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}