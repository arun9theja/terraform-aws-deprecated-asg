resource "aws_autoscaling_group" "app" {
  name                      = "${aws_launch_configuration.app.name}"
  max_size                  = "${var.asg-max-capacity}"
  min_size                  = "${var.asg-min-capacity}"
  desired_capacity          = "${max(1,var.asg-desired-capacity)}"
  wait_for_elb_capacity     = "${max(1,var.asg-desired-capacity)}"
  wait_for_capacity_timeout = "${var.asg-wait-timeout}"
  health_check_type         = "${var.asg-health-check-type}"
  vpc_zone_identifier       = "${var.asg-vpc-zone-identifier}"
  launch_configuration      = "${aws_launch_configuration.app.name}"
  target_group_arns         = ["${var.asg-lb-target_group-arn}"]

  tag {
    key                 = "Application"
    value               = "${data.aws_ami.app.tags.Application}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Cluster"
    value               = "${data.aws_ami.app.tags.Service}-app"
    propagate_at_launch = true
  }
  
  tag {
    key                 = "Service"
    value               = "${data.aws_ami.app.tags.Service}"
    propagate_at_launch = true
  }

  tag {
    key                 = "ServiceVersion"
    value               = "${data.aws_ami.app.tags.ServiceVersion}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Description"
    value               = "This instance is running the ${data.aws_ami.app.tags.Service} service"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }

  tag {
    key                 = "ProductDomain"
    value               = "${data.aws_ami.app.tags.ProductDomain}"
    propagate_at_launch = true
  }

  tag {
    key                 = "BaseAmiId"
    value               = "${data.aws_ami.app.tags.BaseAmiId}"
    propagate_at_launch = true
  }

  tag {
    key                 = "AmiId"
    value               = "${data.aws_ami.app.id}"
    propagate_at_launch = false
  }

  tag {
    key                 = "AppBuildTime"
    value               = "${data.aws_ami.app.tags.AppBuildTime}"
    propagate_at_launch = true
  }

  tag {
    key                 = "AmiBakeTime"
    value               = "${data.aws_ami.app.tags.AmiBakeTime}"
    propagate_at_launch = true
  }


  lifecycle {
    create_before_destroy = true
  }
}
