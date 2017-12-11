variable "service-name" {
}

variable "product-domain" {
}

variable "traveloka-env" {
}

variable "environment" {
}

variable "asg-vpc-zone-identifier" {
    type = "list"
}

variable "asg-lb-target_group-arn" {
}

variable "asg-min-capacity" {
    default = 1
}

variable "asg-desired-capacity" {
}

variable "asg-max-capacity" {
    default = 5
}

variable "asg-wait-timeout" {
}

variable "asg-health-check-type" {
    default = "ELB"
}

variable "instance-sgs" {
    type = "list"
}

variable "instance-profile" {
}

variable "instance-type" {
}

variable "instance-ami-id" {
}

variable "instance-monitoring" {
    default = true
}

variable "instance-ebs-optimized" {
    default = true
}
