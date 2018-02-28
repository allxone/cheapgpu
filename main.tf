terraform {
  backend "s3" {
    bucket  = "s3-terraform-state.stedel.it"
    key     = "cheapgpu/aws.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
    region = "${var.region}"
}

data "aws_availability_zones" "available" {}

data "aws_ami" "cheapgpu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Deep Learning AMI (Amazon Linux)*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["898082745236"] # Amazon

  # aws ec2 describe-images --image-ids ami-fd797087
}

resource "aws_launch_configuration" "cheapgpu_conf" {
  name          = "cheapgpu_conf"
  image_id      = "${data.aws_ami.cheapgpu.id}"
  instance_type = "${var.instance_type}"

  spot_price    = "${var.spot_price}"

  key_name = "${var.key_name}"
  security_groups = ["${aws_security_group.cheapgpu.name}"]
}

resource "aws_security_group" "cheapgpu" {
  name = "cheapgpu-sg"

  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_autoscaling_group" "cheapgpu" {
  name                 = "cheapgpu-asg"
  availability_zones = ["${data.aws_availability_zones.available.names}"]
  launch_configuration = "${aws_launch_configuration.cheapgpu_conf.name}"
  min_size             = 1
  max_size             = 1

  tags {
    key   = "Role"
    value = "cheapgpu"
    propagate_at_launch = true
  }
}

# resource "aws_spot_datafeed_subscription" "default" {
#   bucket = "s3-terraform-state.stedel.it"
#   prefix = "spot_datafeed"
# }