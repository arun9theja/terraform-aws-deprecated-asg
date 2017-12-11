data "aws_caller_identity" "current" {}

data "aws_ami" "app" {

  filter {
    name   = "image-id"
    values = ["${var.instance-ami-id}"]
  }

  filter {
    name   = "name"
    values = ["tvlk/ubuntu/${var.product-domain}/${var.service-name}-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["self"]
}
