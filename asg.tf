resource "aws_autoscaling_group" "app" {
  name                      = "${aws_launch_configuration.app.name}"
  max_size                  = "${var.asg-max-capacity}"
  min_size                  = "${var.asg-min-capacity}"
  desired_capacity          = "${max(1,var.asg-desired-capacity)}"
  wait_for_elb_capacity     = "${max(1,var.asg-desired-capacity)}"
  wait_for_capacity_timeout = "${var.asg-wait-timeout}"
  health_check_type         = "${var.asg-health-check-type}"
  health_check_grace_period = "${var.asg-health-check-grace-period}"
  vpc_zone_identifier       = "${var.asg-vpc-zone-identifier}"
  launch_configuration      = "${aws_launch_configuration.app.name}"
  target_group_arns         = ["${var.asg-lb-target_group-arn}"]

  tags = ["${var.tags}"]

  lifecycle {
    create_before_destroy = true
  }
}
