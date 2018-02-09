# traveloka-terraform-aws-asg
A Terraform module which creates an AWS EC2 Launch Configuration, and EC2 Auto Scaling Groups.
This modules can be used to do blue/green auto scaling deployment


## Usage
```hcl
module "autoscaling-deployment" {
    source = "github.com/traveloka/traveloka-terraform-aws-asg?ref=master"
    service-name = "traveloka-flight"
    environment = "staging"
    traveloka-env = "my_staging"
    product-domain = "flight-team"
    asg-lb-target_group-arn = "arn:aws:elasticloadbalancing:ap-southeast-1:0123456789012:targetgroup/traveloka-flight-app-internal/afjwkllgjepwoej"
    # this variable should default to a number (e.g. 1) as a fallback. This can also be populated from the blue (currently live) ASG by using this module's `asg-desired-capacity` output as the input variable
    asg-desired-capacity = "${var.asg-desired-capacity}"
    asg-vpc-zone-identifier = ["subnet-12345678", "subnet-12345679"]
    asg-wait-timeout = "5m"
    instance-sgs = ["sg-12345678"]
    instance-profile = "profile-traveloka-flight-app"
    instance-type = "t2.small"
    # this variable value should be read from a file produced by ami baking pipeline / rollback pipeline
    instance-ami-id = "${var.instance-ami-id}"
}

```

## Conventions
The deployed AMIs should have these tags:
  - Application
  - ServiceVersion
  - BaseAmiId
The created ASGs will have these tags:
  - Service
  - ServiceVersion
  - Cluster
  - Environment
  - ProductDomain
  - Description
  - Application
  - BaseAmiId
  - AmiId

## Authors
  - [Salvian Reynaldi](https://github.com/salvianreynaldi)


## License

Apache 2. See LICENSE for full details.
