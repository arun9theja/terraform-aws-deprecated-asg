resource "aws_launch_configuration" "app" {
  name_prefix   = "${data.aws_ami.app.tags.Service}-app-${data.aws_ami.app.tags.ServiceVersion}-"
  image_id      = "${data.aws_ami.app.id}"
  instance_type = "${var.instance-type}"
  iam_instance_profile = "${var.instance-profile}"
  # we can't use data.aws_security_group.app.*.id here. (Another bug)?
  security_groups = "${var.instance-sgs}"
  user_data = "${var.instance-user-data}"
  enable_monitoring = "${var.instance-monitoring}"
  ebs_optimized = "${var.instance-ebs-optimized}"

  lifecycle {
    create_before_destroy = true
  }
}
