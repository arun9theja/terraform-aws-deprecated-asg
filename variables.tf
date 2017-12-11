variable "service-name" {
  type    = "string"
  description = "the name of the service"
}

variable "product-domain" {
  type    = "string"
  description = "the owner of this pipeline (e.g. team). This is used mostly for adding tags to resources"
}

variable "traveloka-env" {
}

variable "environment" {
  type    = "string"
  description = "the created resources will belong to this infrastructure environment"
}

variable "asg-vpc-zone-identifier" {
    type = "list"
    description = "the created ASGs will spawn instances to these subnet IDs"
}

variable "asg-lb-target_group-arn" {
    type = "string"
    description = "the created ASGs will be attached to this target group"
}

variable "asg-min-capacity" {
    default = 1
    description = "the created ASGs will have this number of instances at minimum"
}

variable "asg-desired-capacity" {
    type = "string"
    description = "the created ASGs will be spawned initially with this capacity"
}

variable "asg-max-capacity" {
    default = 5
    description = "the created ASGs will have this number of instances at maximum"
}

variable "asg-wait-timeout" {
    type = "string"
    description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out"
}

variable "asg-health-check-type" {
    type = "string"
    default = "ELB"
    description = "the created ASGs will honor this healthcheck result"
}

variable "instance-sgs" {
    type = "list"
    description = "the created ASGs will spawn instances with these security groups"
}

variable "instance-profile" {
    type = "string"
    description = "the created ASGs will spawn instances with this instance profile"
}

variable "instance-type" {
    type = "string"
    description = "the created ASGs will spawn instances with this type"
}

variable "instance-ami-id" {
    type = "string"
    description = "the created ASGs will spawn instances with this AMI"
}

variable "instance-monitoring" {
    default = true
    description = "the created ASGs will spawn instances with enhanced monitoring if enabled"
}

variable "instance-ebs-optimized" {
    default = true
    description = "the created ASGs will spawn EBS-optimized instances if enabled"
}

variable "instance-additional-user-data" {
    default = ""
    description = "the created ASGs will spawn instances if enabled"
}
