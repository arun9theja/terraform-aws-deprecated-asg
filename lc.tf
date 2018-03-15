resource "aws_launch_configuration" "app" {
  name_prefix          = "${var.service-name}-${var.cluster-role}-${var.environment}-"
  image_id             = "${var.instance-ami-id}"
  instance_type        = "${var.instance-type}"
  iam_instance_profile = "${var.instance-profile}"
  key_name             = "${var.instance-key-name}"
  security_groups      = ["${var.instance-sgs}"]
  user_data            = "${var.instance-user-data}"
  enable_monitoring    = "${var.instance-monitoring}"
  ebs_optimized        = "${var.instance-ebs-optimized}"

  lifecycle {
    create_before_destroy = true
  }
}
