# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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

  tags = [
    "${var.asg-tags}",
  ]

  lifecycle {
    create_before_destroy = true
  }
}
