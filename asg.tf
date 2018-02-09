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
    value               = "${var.service-name}-app"
    propagate_at_launch = true
  }
  
  tag {
    key                 = "Service"
    value               = "${var.service-name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "ServiceVersion"
    value               = "${data.aws_ami.app.tags.ServiceVersion}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Description"
    value               = "This instance is running the ${var.service-name} service"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }

  tag {
    key                 = "ProductDomain"
    value               = "${var.product-domain}"
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

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      "launch_configuration"
    ]
  }
}
