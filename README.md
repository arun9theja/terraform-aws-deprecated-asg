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
 - The created pipeline name will be `${var.service-name}-bake-ami`
 - The pipeline source zip is an S3 object that should be located in `{var.service-s3-bucket}/${var.service-name}-bake-ami/${var.service-name}.zip`
 - The codepipeline IAM role name will be `CodePipelineBakeAmi-${var.service-name}`
 - The codepipeline IAM role inline policy name will be:
    - `CodePipelineBakeAmi-${var.service-name}-S3`
 - The created build project name will be ${var.service-name}-bake-ami
 - The codebuild IAM role name will be `CodeBuildBakeAmi-${var.service-name}`
 - The codebuild IAM role inline policy name will be:
    - `CodeBuildBakeAmi-${var.service-name}-S3`
    - `CodeBuildBakeAmi-${var.service-name}-cloudwatch`
    - `CodeBuildBakeAmi-${var.service-name}-packer`
 - The build project environment image is `aws/codebuild/java:openjdk-8`
 - The build project will be tagged:
    - "Service" = "${var.service-name}"
    - "ProductDomain" = "${var.product-domain}"
    - "Environment" = "management"
 - The build project will have permission to Run Instances:
    - having these tags on creation:
      - "Name" = "Packer Builder"
      - "Service" = "${var.service-name}"
      - "ServiceVersion" = any
      - "Cluster" = "${var.service-name}-app"
      - "ProductDomain" = "${var.product-domain}"
      - "Environment" = "management"
      - "Application" = any
      - "Description" = any
    - with a volume having these tags on creation:
      - "ProductDomain" = "${var.product-domain}"
      - "Environment" = "management"
    - creates images and snapshots having these tags:
      - "Service" = "${var.service-name}"
      - "ServiceVersion" = any
      - "ProductDomain" = "${var.product-domain}"
      - "Application" = any
      - "SourceAmi" = any



## Authors

 - [Salvian Reynaldi](https://github.com/salvianreynaldi)


## License

Apache 2. See LICENSE for full details.
